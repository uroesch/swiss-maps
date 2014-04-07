TOPOJSON = node_modules/.bin/topojson
MERGE = node_modules/.bin/topojson-merge
GROUP = node_modules/.bin/topojson-group
GEOJSON = node_modules/.bin/topojson-geojson
CANTONS = \
	zh be lu ur sz ow nw gl zg \
	fr so bs bl sh ar ai sg gr \
	ag tg ti vd vs ne ge ju

WIDTH = 960
HEIGHT = 500
MARGIN = 10

YEAR = 2014

PROPERTIES = name=NAME,abbr=ABBR,name=SEENAME

CONTOUR_INTERVAL = 500

all: topo geo

topo: node_modules \
	topo/ch-country.json \
	topo/ch-cantons.json \
	topo/ch-districts.json \
	topo/ch-municipalities.json \
	topo/ch-lakes.json \
	topo/ch-country-lakes.json \
	topo/ch-cantons-lakes.json \
	topo/ch-municipalities-lakes.json \
	$(addprefix topo/,$(addsuffix -municipalities.json,$(CANTONS))) \
	topo/ch.json

geo: node_modules \
	geo/ch-country.json \
	geo/ch-cantons.json \
	geo/ch-districts.json \
	geo/ch-municipalities.json \
	geo/ch-lakes.json \
	$(addprefix geo/,$(addsuffix -municipalities.json,$(CANTONS)))

node_modules: package.json
	npm install
	touch $@

clean: clean-generated clean-downloads

clean-generated:
	rm -rf shp geo topo tif

clean-downloads:
	rm -rf downloads

.PHONY: clean clean-generated clean-downloads topo geo

.SECONDARY:

##################################################
# Shapefiles
##################################################

shp/ch/country.shp: src/swissBOUNDARIES3D/2014/swissBOUNDARIES3D_1_1_TLM_LANDESGEBIET.shp
	mkdir -p $(dir $@)
	ogr2ogr $(if $(REPROJECT),-t_srs EPSG:4326) -where "ICC = 'CH'" $@ $<

shp/ch/cantons.shp: src/swissBOUNDARIES3D/2014/swissBOUNDARIES3D_1_1_TLM_KANTONSGEBIET.shp
	mkdir -p $(dir $@)
	ogr2ogr $(if $(REPROJECT),-t_srs EPSG:4326) -where "ICC = 'CH'" $@ $<

shp/ch/districts.shp: src/swissBOUNDARIES3D/2014/swissBOUNDARIES3D_1_1_TLM_BEZIRKSGEBIET.shp
	mkdir -p $(dir $@)
	ogr2ogr $(if $(REPROJECT),-t_srs EPSG:4326) -where "ICC = 'CH'" $@ $<

shp/ch/municipalities.shp: src/swissBOUNDARIES3D/$(YEAR)/swissBOUNDARIES3D_1_1_TLM_HOHEITSGEBIET.shp
	mkdir -p $(dir $@)
	ogr2ogr $(if $(REPROJECT),-t_srs EPSG:4326) -where "ICC = 'CH'" $@ $<

shp/zh/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 1" $@ $<

shp/be/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 2" $@ $<

shp/lu/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 3" $@ $<

shp/ur/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 4" $@ $<

shp/sz/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 5" $@ $<

shp/ow/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 6" $@ $<

shp/nw/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 7" $@ $<

shp/gl/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 8" $@ $<

shp/zg/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 9" $@ $<

shp/fr/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 10" $@ $<

shp/so/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 11" $@ $<

shp/bs/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 12" $@ $<

shp/bl/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 13" $@ $<

shp/sh/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 14" $@ $<

shp/ar/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 15" $@ $<

shp/ai/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 16" $@ $<

shp/sg/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 17" $@ $<

shp/gr/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 18" $@ $<

shp/ag/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 19" $@ $<

shp/tg/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 20" $@ $<

shp/ti/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 21" $@ $<

shp/vd/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 22" $@ $<

shp/vs/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 23" $@ $<

shp/ne/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 24" $@ $<

shp/ge/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 25" $@ $<

shp/ju/municipalities.shp: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	ogr2ogr -where "KANTONSNUM = 26" $@ $<

shp/ch/lakes.shp: src/V200/VEC200_Commune.shp
	mkdir -p $(dir $@)
	ogr2ogr $(if $(REPROJECT),-t_srs EPSG:4326) -where "SEENR < 9999 AND SEENR > 0" $@ $<

shp/ch/contours.shp: shp/ch/contours-projected.shp shp/ch/country.shp
	mkdir -p $(dir $@)
	ogr2ogr -clipsrc shp/ch/country.shp $@ $<

shp/ch/contours-projected.shp: shp/ch/contours-unclipped.shp
	mkdir -p $(dir $@)
	ogr2ogr $(if $(REPROJECT),-t_srs EPSG:4326,-t_srs EPSG:21781) $@ $<

shp/ch/contours-unclipped.shp: shp/ch/contours_$(CONTOUR_INTERVAL).shp
	mkdir -p $(dir $@)
	ogr2ogr -nlt POLYGON $@ $(dir $<)contours_0.shp
	for i in `seq $(CONTOUR_INTERVAL) $(CONTOUR_INTERVAL) 4445`; do \
		ogr2ogr -update -append -nln contours-unclipped -nlt POLYGON $@ $(dir $<)contours_$$i.shp; \
	done

tif/contours/contours_$(CONTOUR_INTERVAL).tif: tif/srtm/srtm.tif
	mkdir -p $(dir $@)
	for i in `seq 0 $(CONTOUR_INTERVAL) 4445`; do \
		if [ $$i = 0 ]; then \
			gdal_calc.py -A $< --outfile=$(dir $@)contours_$$i.tif --calc="0"  --NoDataValue=-1; \
		else \
			gdal_calc.py -A $< --outfile=$(dir $@)contours_$$i.tif --calc="$$i*(A>$$i)" --NoDataValue=0; \
		fi; \
	done

shp/ch/contours_$(CONTOUR_INTERVAL).shp: tif/contours/contours_$(CONTOUR_INTERVAL).tif
	mkdir -p $(dir $@)
	for i in `seq 0 $(CONTOUR_INTERVAL) 4445`; do \
		gdal_polygonize.py -f "ESRI Shapefile" tif/contours/contours_$$i.tif $(dir $@)contours_$$i.shp contours_$$i elev; \
	done

##################################################
# PLZ (ZIP code) data
##################################################

shp/ch/plz/PLZO_PLZ.shp: downloads/plz.zip
	mkdir -p $(dir $@)
	unzip -o -j -d $(dir $@) $<
	touch $@

shp/ch/plz.shp: shp/ch/plz/PLZO_PLZ.shp
	mkdir -p $(dir $@)
	ogr2ogr $(if $(REPROJECT),-t_srs EPSG:4326) $@ $<

downloads/plz.zip:
	mkdir -p $(dir $@)
	curl http://data.geo.admin.ch.s3.amazonaws.com/ch.swisstopo-vd.ortschaftenverzeichnis_plz/PLZO_SHP_LV03.zip -L -o $@.download
	mv $@.download $@

##################################################
# SRTM elevation data
##################################################

tif/srtm/srtm.tif: tif/srtm/srtm_38_03.tif tif/srtm/srtm_39_03.tif
	mkdir -p $(dir $@)
	# gdal_merge.py -ul_lr 5.95662 47.8099 10.4935 45.8192 -o $@ $^
	gdal_merge.py -ul_lr 5.8 47.9 10.6 45.7 -o $@ $^

tif/srtm/%.tif: downloads/srtm/%.zip
	mkdir -p $(dir $@)
	unzip -o -d $(dir $@) $<
	touch $@

downloads/srtm/%.zip:
	mkdir -p $(dir $@)
	curl http://gis-lab.info/data/srtm-tif/$(notdir $@) -L -o $@.download
	mv $@.download $@

##################################################
# TopoJSON
##################################################

# Unscaled topologies

topo/unscaled/ch-country.json: shp/ch/country.shp
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	--id-property ICC \
	$(if $(PROPERTIES),-p $(PROPERTIES),) \
	-- country=$< | $(GROUP) -p > $@

topo/unscaled/ch-cantons.json: shp/ch/cantons.shp
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	--e meta/cantons.csv \
	--id-property +KANTONSNUM \
	$(if $(PROPERTIES),-p $(PROPERTIES),) \
	-- cantons=$< | $(GROUP) -p > $@

topo/unscaled/ch-districts.json: shp/ch/districts.shp
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	--id-property +BEZIRKSNUM \
	$(if $(PROPERTIES),-p $(PROPERTIES),) \
	-- districts=$< | $(GROUP) -p > $@

topo/unscaled/ch-municipalities.json: shp/ch/municipalities.shp
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	--id-property +BFS_NUMMER \
	$(if $(PROPERTIES),-p $(PROPERTIES),) \
	-- municipalities=$< | $(GROUP) -p > $@

topo/unscaled/%-municipalities.json: shp/%/municipalities.shp
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	--id-property +BFS_NUMMER \
	$(if $(PROPERTIES),-p $(PROPERTIES),) \
	-- municipalities=$< | $(GROUP) -p > $@

topo/unscaled/ch-plz.json: shp/ch/plz.shp
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	--id-property +PLZ \
	$(if $(PROPERTIES),-p $(PROPERTIES),) \
	-- plz=$< > $@

topo/unscaled/ch-lakes.json: shp/ch/lakes.shp
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	--id-property +SEENR \
	$(if $(PROPERTIES),-p $(PROPERTIES),) \
	-- lakes=$< \
	| $(MERGE) \
	-p \
	--io lakes \
	--oo lakes \
	> $@

# Combined files

topo/ch.json: topo/unscaled/ch-country.json topo/unscaled/ch-cantons.json topo/unscaled/ch-municipalities.json topo/unscaled/ch-lakes.json
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	$(if $(REPROJECT),,--width $(WIDTH) --height $(HEIGHT) --margin $(MARGIN)) \
	--simplify $(if $(REPROJECT),2e-9,1) \
	-p \
	-- $^ > $@

topo/ch-country-lakes.json: topo/unscaled/ch-country.json topo/unscaled/ch-lakes.json
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	$(if $(REPROJECT),,--width $(WIDTH) --height $(HEIGHT) --margin $(MARGIN)) \
	--simplify $(if $(REPROJECT),2e-9,1) \
	-p \
	-- $^ > $@

topo/ch-cantons-lakes.json: topo/unscaled/ch-cantons.json topo/unscaled/ch-lakes.json
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	$(if $(REPROJECT),,--width $(WIDTH) --height $(HEIGHT) --margin $(MARGIN)) \
	--simplify $(if $(REPROJECT),2e-9,1) \
	-p \
	-- $^ > $@

topo/ch-municipalities-lakes.json: topo/unscaled/ch-municipalities.json topo/unscaled/ch-lakes.json
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	$(if $(REPROJECT),,--width $(WIDTH) --height $(HEIGHT) --margin $(MARGIN)) \
	--simplify $(if $(REPROJECT),2e-9,1) \
	-p \
	-- $^ > $@

# Contours

topo/ch-contours.json: shp/ch/contours.shp
	mkdir -p $(dir $@)
	$(TOPOJSON) \
	$(if $(REPROJECT),,--width $(WIDTH) --height $(HEIGHT) --margin $(MARGIN)) \
	--simplify $(if $(REPROJECT),2e-9,1) \
	--id-property +elev \
	-- contours=$< | $(GROUP) > $@

# Scale the rest

topo/%.json: topo/unscaled/%.json
	$(TOPOJSON) \
	$(if $(REPROJECT),,--width $(WIDTH) --height $(HEIGHT) --margin $(MARGIN)) \
	--simplify $(if $(REPROJECT),2e-9,1) \
	-p \
	-- $< > $@

##################################################
# GeoJSON
##################################################

geo/ch-%.json: topo/ch-%.json
	mkdir -p $(dir $@)
	$(GEOJSON) \
	--precision 3 \
	-o $(dir $@) \
	-- $<
	mv $(dir $@)$*.json $@

geo/%-municipalities.json: topo/%-municipalities.json
	mkdir -p $(dir $@)
	$(GEOJSON) \
	--precision 3 \
	-o $(dir $@) \
	-- $<
	mv $(dir $@)municipalities.json $@