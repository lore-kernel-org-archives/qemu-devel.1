Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6790C04E87
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A5020578
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A5020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQsuH-0003th-RE
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:21:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hQspz-0000IZ-J0
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hQspx-0002jD-QL
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hQspx-0002hD-Ih
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFDD4307D914
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-37.ams2.redhat.com
	[10.36.116.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 08A595C1A3;
	Wed, 15 May 2019 12:16:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 14:15:41 +0200
Message-Id: <20190515121544.4597-6-quintela@redhat.com>
In-Reply-To: <20190515121544.4597-1-quintela@redhat.com>
References: <20190515121544.4597-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 15 May 2019 12:16:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 5/8] migration: Add multifd-compress
 parameter
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>

---
Rename it to NONE
Fix typos (dave)
---
 hmp.c                        | 17 +++++++++++++++++
 hw/core/qdev-properties.c    | 13 +++++++++++++
 include/hw/qdev-properties.h |  1 +
 migration/migration.c        | 16 ++++++++++++++++
 qapi/migration.json          | 30 +++++++++++++++++++++++++++---
 tests/migration-test.c       | 13 ++++++++++---
 6 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/hmp.c b/hmp.c
index 56a3ed7375..5732c34249 100644
--- a/hmp.c
+++ b/hmp.c
@@ -38,6 +38,7 @@
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-commands-tpm.h"
 #include "qapi/qapi-commands-ui.h"
+#include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
@@ -435,6 +436,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS)=
,
             params->multifd_channels);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESS)=
,
+            MultifdCompress_str(params->multifd_compress));
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE=
),
             params->xbzrle_cache_size);
@@ -1736,6 +1740,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
     MigrateSetParameters *p =3D g_new0(MigrateSetParameters, 1);
     uint64_t valuebw =3D 0;
     uint64_t cache_size;
+    MultifdCompress compress_type;
     Error *err =3D NULL;
     int val, ret;
=20
@@ -1821,6 +1826,18 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
         p->has_multifd_channels =3D true;
         visit_type_int(v, param, &p->multifd_channels, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
+        p->has_multifd_compress =3D true;
+        visit_type_MultifdCompress(v, param, &compress_type, &err);
+        if (err) {
+            break;
+        }
+        if (compress_type < 0 || compress_type >=3D MULTIFD_COMPRESS__MA=
X) {
+            error_setg(&err, "Invalid multifd_compress option %s", value=
str);
+            break;
+        }
+        p->multifd_compress =3D compress_type;
+        break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size =3D true;
         visit_type_size(v, param, &cache_size, &err);
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5da1439a8b..ebeeb5c88d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -5,6 +5,7 @@
 #include "hw/pci/pci.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-types-migration.h"
 #include "hw/block/block.h"
 #include "net/hub.h"
 #include "qapi/visitor.h"
@@ -645,6 +646,18 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
     .set_default_value =3D set_default_value_enum,
 };
=20
+/* --- MultifdCompress --- */
+
+const PropertyInfo qdev_prop_multifd_compress =3D {
+    .name =3D "MultifdCompress",
+    .description =3D "multifd_compress values, "
+                   "none",
+    .enum_table =3D &MultifdCompress_lookup,
+    .get =3D get_enum,
+    .set =3D set_enum,
+    .set_default_value =3D set_default_value_enum,
+};
+
 /* --- pci address --- */
=20
 /*
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index b6758c852e..ac452d8f2c 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -23,6 +23,7 @@ extern const PropertyInfo qdev_prop_tpm;
 extern const PropertyInfo qdev_prop_ptr;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_on_off_auto;
+extern const PropertyInfo qdev_prop_multifd_compress;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
diff --git a/migration/migration.c b/migration/migration.c
index 609e0df5d0..d6f8ef342a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -82,6 +82,7 @@
 /* The delay time (in ms) between two COLO checkpoints */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
+#define DEFAULT_MIGRATE_MULTIFD_COMPRESS MULTIFD_COMPRESS_NONE
=20
 /* Background transfer rate for postcopy, 0 means unlimited, note
  * that page requests can still exceed this limit.
@@ -769,6 +770,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
     params->block_incremental =3D s->parameters.block_incremental;
     params->has_multifd_channels =3D true;
     params->multifd_channels =3D s->parameters.multifd_channels;
+    params->has_multifd_compress =3D true;
+    params->multifd_compress =3D s->parameters.multifd_compress;
     params->has_xbzrle_cache_size =3D true;
     params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
     params->has_max_postcopy_bandwidth =3D true;
@@ -1268,6 +1271,9 @@ static void migrate_params_test_apply(MigrateSetPar=
ameters *params,
     if (params->has_multifd_channels) {
         dest->multifd_channels =3D params->multifd_channels;
     }
+    if (params->has_multifd_compress) {
+        dest->multifd_compress =3D params->multifd_compress;
+    }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size =3D params->xbzrle_cache_size;
     }
@@ -1364,6 +1370,9 @@ static void migrate_params_apply(MigrateSetParamete=
rs *params, Error **errp)
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels =3D params->multifd_channels;
     }
+    if (params->has_multifd_compress) {
+        s->parameters.multifd_compress =3D params->multifd_compress;
+    }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size =3D params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
@@ -3353,6 +3362,9 @@ void migration_global_dump(Monitor *mon)
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, enabled_capabilities[x], fals=
e)
=20
+#define DEFINE_PROP_MULTIFD_COMPRESS(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compress, Multi=
fdCompress)
+
 static Property migration_properties[] =3D {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
@@ -3392,6 +3404,9 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("multifd-channels", MigrationState,
                       parameters.multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
+    DEFINE_PROP_MULTIFD_COMPRESS("multifd-compress", MigrationState,
+                      parameters.multifd_compress,
+                      DEFAULT_MIGRATE_MULTIFD_COMPRESS),
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
@@ -3481,6 +3496,7 @@ static void migration_instance_init(Object *obj)
     params->has_x_checkpoint_delay =3D true;
     params->has_block_incremental =3D true;
     params->has_multifd_channels =3D true;
+    params->has_multifd_compress =3D true;
     params->has_xbzrle_cache_size =3D true;
     params->has_max_postcopy_bandwidth =3D true;
     params->has_max_cpu_throttle =3D true;
diff --git a/qapi/migration.json b/qapi/migration.json
index 9cfbaf8c6c..8ec1944b7a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -482,6 +482,19 @@
 ##
 { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapab=
ilityStatus']}
=20
+##
+# @MultifdCompress:
+#
+# An enumeration of multifd compression.
+#
+# @none: no compression.
+#
+# Since: 4.1
+#
+##
+{ 'enum': 'MultifdCompress',
+  'data': [ 'none' ] }
+
 ##
 # @MigrationParameter:
 #
@@ -580,6 +593,9 @@
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    Defaults to 99. (Since 3.1)
 #
+# @multifd-compress: Which compression method to use.
+#                    Defaults to none. (Since 4.1)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -592,7 +608,7 @@
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle' ] }
+           'max-cpu-throttle', 'multifd-compress' ] }
=20
 ##
 # @MigrateSetParameters:
@@ -682,6 +698,9 @@
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    The default value is 99. (Since 3.1)
 #
+# @multifd-compress: Which compression method to use.
+#                    Defaults to none. (Since 4.1)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -707,7 +726,8 @@
             '*multifd-channels': 'int',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
-	    '*max-cpu-throttle': 'int' } }
+	    '*max-cpu-throttle': 'int',
+            '*multifd-compress': 'MultifdCompress' } }
=20
 ##
 # @migrate-set-parameters:
@@ -817,6 +837,9 @@
 #                    Defaults to 99.
 #                     (Since 3.1)
 #
+# @multifd-compress: Which compression method to use.
+#                    Defaults to none. (Since 4.1)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -840,7 +863,8 @@
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
 	    '*max-postcopy-bandwidth': 'size',
-            '*max-cpu-throttle':'uint8'} }
+            '*max-cpu-throttle': 'uint8',
+            '*multifd-compress': 'MultifdCompress' } }
=20
 ##
 # @query-migrate-parameters:
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 65d5e256a7..8a1ccc2516 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -449,7 +449,6 @@ static void migrate_check_parameter_str(QTestState *w=
ho, const char *parameter,
     g_free(result);
 }
=20
-__attribute__((unused))
 static void migrate_set_parameter_str(QTestState *who, const char *param=
eter,
                                       const char *value)
 {
@@ -1065,7 +1064,7 @@ static void test_precopy_tcp(void)
     g_free(uri);
 }
=20
-static void test_multifd_tcp(void)
+static void test_multifd_tcp(const char *method)
 {
     char *uri;
     QTestState *from, *to;
@@ -1087,6 +1086,9 @@ static void test_multifd_tcp(void)
     migrate_set_parameter_int(from, "multifd-channels", 2);
     migrate_set_parameter_int(to, "multifd-channels", 2);
=20
+    migrate_set_parameter_str(from, "multifd-compress", method);
+    migrate_set_parameter_str(to, "multifd-compress", method);
+
     migrate_set_capability(from, "multifd", "true");
     migrate_set_capability(to, "multifd", "true");
     /* Wait for the first serial output from the source */
@@ -1112,6 +1114,11 @@ static void test_multifd_tcp(void)
     test_migrate_end(from, to, true);
 }
=20
+static void test_multifd_tcp_none(void)
+{
+    test_multifd_tcp("none");
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1166,7 +1173,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); *=
/
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
-    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
+    qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none)=
;
=20
     ret =3D g_test_run();
=20
--=20
2.21.0


