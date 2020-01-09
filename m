Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BA5C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A31420673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A31420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57623 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUaN-0003ua-VI
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvD-00010D-6q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvA-0001Jt-DL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2292 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPv9-000173-IR
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:48 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C26DDD10DADBFCC61460;
 Thu,  9 Jan 2020 12:59:40 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:32 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 03/12] migration: Create the multi-rdma-channels parameter
Date: Thu, 9 Jan 2020 12:59:13 +0800
Message-ID: <20200109045922.904-4-fengzhimin1@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20200109045922.904-1-fengzhimin1@huawei.com>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.198]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
X-Mailman-Approved-At: Thu, 09 Jan 2020 04:56:54 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jemmy858585@gmail.com, fengzhimin <fengzhimin1@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: fengzhimin <fengzhimin1@huawei.com>

Indicates the number of RDMA threads that we would create.
By default we create 2 threads for RDMA migration.

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/migration.c | 32 ++++++++++++++++++++++++++++++++
 migration/migration.h |  1 +
 monitor/hmp-cmds.c    |  7 +++++++
 qapi/migration.json   | 23 +++++++++++++++++++----
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d9d73a5eac..5756a4806e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -88,6 +88,9 @@
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
=20
+/* Define default MultiRDMA thread number */
+#define DEFAULT_MIGRATE_MULTIRDMA_CHANNELS 2
+
 /* Background transfer rate for postcopy, 0 means unlimited, note
  * that page requests can still exceed this limit.
  */
@@ -788,6 +791,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
     params->announce_rounds =3D s->parameters.announce_rounds;
     params->has_announce_step =3D true;
     params->announce_step =3D s->parameters.announce_step;
+    params->has_multi_rdma_channels =3D true;
+    params->multi_rdma_channels =3D s->parameters.multi_rdma_channels;
=20
     return params;
 }
@@ -1171,6 +1176,14 @@ static bool migrate_params_check(MigrationParamete=
rs *params, Error **errp)
         return false;
     }
=20
+    if (params->has_multi_rdma_channels
+        && (params->multi_rdma_channels < 1)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "multi_rdma_channels",
+                   "is invalid, it should be in the range of 1 to 5");
+        return false;
+    }
+
     if (params->has_xbzrle_cache_size &&
         (params->xbzrle_cache_size < qemu_target_page_size() ||
          !is_power_of_2(params->xbzrle_cache_size))) {
@@ -1302,6 +1315,9 @@ static void migrate_params_test_apply(MigrateSetPar=
ameters *params,
     if (params->has_announce_step) {
         dest->announce_step =3D params->announce_step;
     }
+    if (params->has_multi_rdma_channels) {
+        dest->multi_rdma_channels =3D params->multi_rdma_channels;
+    }
 }
=20
 static void migrate_params_apply(MigrateSetParameters *params, Error **e=
rrp)
@@ -1403,6 +1419,9 @@ static void migrate_params_apply(MigrateSetParamete=
rs *params, Error **errp)
     if (params->has_announce_step) {
         s->parameters.announce_step =3D params->announce_step;
     }
+    if (params->has_multi_rdma_channels) {
+        s->parameters.multi_rdma_channels =3D params->multi_rdma_channel=
s;
+    }
 }
=20
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **er=
rp)
@@ -2222,6 +2241,15 @@ int migrate_multifd_channels(void)
     return s->parameters.multifd_channels;
 }
=20
+int migrate_multiRDMA_channels(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->parameters.multi_rdma_channels;
+}
+
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
@@ -3513,6 +3541,9 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_SIZE("announce-step", MigrationState,
                       parameters.announce_step,
                       DEFAULT_MIGRATE_ANNOUNCE_STEP),
+    DEFINE_PROP_UINT8("multiRDMA-channels", MigrationState,
+                      parameters.multi_rdma_channels,
+                      DEFAULT_MIGRATE_MULTIRDMA_CHANNELS),
=20
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -3591,6 +3622,7 @@ static void migration_instance_init(Object *obj)
     params->has_announce_max =3D true;
     params->has_announce_rounds =3D true;
     params->has_announce_step =3D true;
+    params->has_multi_rdma_channels =3D true;
=20
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
diff --git a/migration/migration.h b/migration/migration.h
index 0a23375b2f..4192c22d8c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -271,6 +271,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, =
Error **errp);
 void migration_incoming_process(void);
=20
 bool  migration_has_all_channels(void);
+int migrate_multiRDMA_channels(void);
=20
 uint64_t migrate_max_downtime(void);
=20
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index d0e0af893a..80898c8942 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -456,6 +456,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
         monitor_printf(mon, " %s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->has_tls_authz ? params->tls_authz : "");
+        monitor_printf(mon, "%s: %u\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTI_RDMA_CHANNE=
LS),
+            params->multi_rdma_channels);
     }
=20
     qapi_free_MigrationParameters(params);
@@ -1855,6 +1858,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
         p->has_announce_step =3D true;
         visit_type_size(v, param, &p->announce_step, &err);
         break;
+    case MIGRATION_PARAMETER_MULTI_RDMA_CHANNELS:
+        p->has_multi_rdma_channels =3D true;
+        visit_type_int(v, param, &p->multi_rdma_channels, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/qapi/migration.json b/qapi/migration.json
index c995ffdc4c..ab79bf0600 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -588,6 +588,10 @@
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    Defaults to 99. (Since 3.1)
 #
+# @multi-rdma-channels: Number of channels used to migrate data in
+#                       parallel. This is the same number that the
+#                       number of multiRDMA used for migration.  The
+#                       default value is 2 (since 4.2)
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -600,7 +604,8 @@
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle' ] }
+           'max-cpu-throttle',
+           'multi-rdma-channels'] }
=20
 ##
 # @MigrateSetParameters:
@@ -690,6 +695,10 @@
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    The default value is 99. (Since 3.1)
 #
+# @multi-rdma-channels: Number of channels used to migrate data in
+#                       parallel. This is the same number that the
+#                       number of multiRDMA used for migration.  The
+#                       default value is 2 (since 4.2)
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -715,7 +724,8 @@
             '*multifd-channels': 'int',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
-	    '*max-cpu-throttle': 'int' } }
+     	    '*max-cpu-throttle': 'int',
+            '*multi-rdma-channels': 'int'} }
=20
 ##
 # @migrate-set-parameters:
@@ -825,6 +835,10 @@
 #                    Defaults to 99.
 #                     (Since 3.1)
 #
+# @multi-rdma-channels: Number of channels used to migrate data in
+#                       parallel. This is the same number that the
+#                       number of multiRDMA used for migration.  The
+#                       default value is 2 (since 4.2)
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -847,8 +861,9 @@
             '*block-incremental': 'bool' ,
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
-	    '*max-postcopy-bandwidth': 'size',
-            '*max-cpu-throttle':'uint8'} }
+     	    '*max-postcopy-bandwidth': 'size',
+            '*max-cpu-throttle':'uint8',
+            '*multi-rdma-channels':'uint8'} }
=20
 ##
 # @query-migrate-parameters:
--=20
2.19.1



