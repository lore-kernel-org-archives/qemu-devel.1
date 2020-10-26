Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D47EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3BE2225C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HMJM9B7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3BE2225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6a7-0007wJ-O5
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX690-0007hc-84; Mon, 26 Oct 2020 13:18:54 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:39555 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68x-0008NC-0R; Mon, 26 Oct 2020 13:18:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnqHYOJwEHwC3Wb/yTyTcfwC6NgmhuRNZrGVsgUoFN2fEpfRbxBtEoiJ7kTbmKIfvSTjrSMogqN9Q5uzeHSvCC83Uwxa70VgaU3nN1VXcXOOdiXFYh5AyEgjz4NQmlmRCc16y7w2ZGZgmdOyKyjzq7XVgMEy1m5xJwFePaVqj5BLcsINjjxLON04FKmba22iEXoxcPTV7nwyEBO6wDkma/ZqtxG5dm6f4qEziG/YWvZhhAg7G+25L+NQaGEg7uRktVvWlfO9eQt4QalMBbw3KEgHmj6T6J4r2D+euBBHqtTIZ5gnkNUdQeBT3cGEAi2H7cblzL14wiYuNLHu53MOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XwRk0JKZhe9Z1MVt3seoLYsnKtcJabieAZWYrA/gPo=;
 b=YJYFQFV/rKBucayuqNqcrsRGOdNEcmgz9fBnUMvvhModCXnkLL9zItH4TRnbZwWpOjQCSza5MI+WedcKTx/x9JkRd6MgF/1bq8pV/A66OFYVjDmjQes5vqIYRmUExNEehsJJrnN816o9dlYrRQpeMCOrOU7sxPJ/APMTj3UL+MI2BIgmoUHZh3rkPhX1Aqr/PeAMe9GdCIiouXEl3DBwyIQlE2m7qOtCdy2d3rWOSVN5H+6bD85p2UYuuTJzqkrekKOcR4ICD43mV7vRL3Njx43OoapefknyePG3W1zyNZzTo//vGlXW6tXDokHHUYH9/+4T8n3gwZb7xWl3XCMtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XwRk0JKZhe9Z1MVt3seoLYsnKtcJabieAZWYrA/gPo=;
 b=HMJM9B7Kv/ORfH4o9Iyd5rOJgsVIDZk9P9laK3tdgFnnkNZhXUYRafpB/H9SI+X1aauSt2lwlPc9ELlwioR/P9zUxovXUm7xMULA62dzrcNw7SJQ6GsyywElCMpVyDxQi1z9zx/eeWb76h3QOQszS0IekA3Pi9heW2FGfs1T8h0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 11/25] qapi: backup: add max-chunk and max-workers to
 x-perf struct
Date: Mon, 26 Oct 2020 20:18:01 +0300
Message-Id: <20201026171815.13233-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d43fd28d-e31c-4fb9-e695-08d879d32e48
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032CDC10C071914E75866BDC1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Y5W5ssezg7b63zn5VfUoLwtfuKui5M1V0qEJOClyOhxI+q3/0Wjf5GQlaMtj3tSxDgrbXmLjLxLeXm0PV9tWZuF8cHlRd/QAwC/kOqzruGkUmwVsB02Qc30e+PEB567FYiL42//gqY6o7iCy0g+WeAx45LR2yhc/8/66FuR/ntO2sO76tnmunjdAdtTBWaD914WzRp1dX6FKtqf4qX8odqLNNhIJNnzlkSj2THkP7O6iLnfJ5LyzTQ5Hfd8lt+I1jHne6tr0B3ZGbMRyQo5SFYclhwwFiG5cT7hOT0hZQafNtMT1hHs/JSeSTHf4+EYEVXlw9NQTCQbKP27Ft4MqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ex/xl7Ky2yWTfzePG9/T3ktKrZjL/CYaaJRAq1Pzi1K7MayuEVohEwIpPa1bosW43ZpdM6o3O++pxwCW6FE5847lEPEp6sSp12gfNOsfp2cd2vr7oRvhdrQ9pjd3aXDNfSfN6pnbpo65SCy8kAxAP88qIkpNFetYlQmlg1x6qjqpjayH9tcfCSqO9o3qjpPfh3LmQI8EBU1CtzfR9OpVkzYsT+EXm4ruec6tP02bz8vakXlSEe7Y2hd/k59CZHrZw05qKO436piguve5Q+wm5NiZw+RWwCJWTO71WkvskMUOzCrdfswCgIFBU3AFkTYKbnLsUZGQ+AAMf6qtA6GRWSm71/6IYjcOF99UeJRXK288MzOPjI9goeSOhjV5dyV7iQKReM5nWVzwDQ3UzqMZiNTarYMeUI58G+IcWa4Wir7S+Q3QmuTxadg5U1jxHnFEj9EP+lQda++8YJAm2cTu0u4KCR6SeaQDllXhWh0ikcVlQC4r/AINapCFWGS+/yxp53bZ/4Dbk+Qhf0hyhhfFEq0gNCLfcD5OO1Ard6OQTbuUowigcbTp3iHnT8YY/d/G9xyfX7WAT2vkhbfjp63QmwYFmqujIqpXMoScLPQ0Nq3eSxmO99n3ttQmJPhCt5AnVsISX8gYdzlmOqX321805Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43fd28d-e31c-4fb9-e695-08d879d32e48
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:39.5779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+spdcLeur+c94QgfpqOiziwuw1kg0AS/QsH+p3+Uxdorw59PbTvaqarTIE8Zlban0ZNAEGqzEl7RklUtGgWory7exDhLvcHSdjhGzgK70E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.6.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new parameters to configure future backup features. The patch
doesn't introduce aio backup requests (so we actually have only one
worker) neither requests larger than one cluster. Still, formally we
satisfy these maximums anyway, so add the parameters now, to facilitate
further patch which will really change backup job behavior.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 11 ++++++++++-
 block/backup.c       | 28 +++++++++++++++++++++++-----
 block/replication.c  |  2 +-
 blockdev.c           |  8 +++++++-
 4 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 71e6faa15c..5a21c24c1d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1378,10 +1378,19 @@
 #
 # @use-copy-range: Use copy offloading. Default true.
 #
+# @max-workers: Maximum number of parallel requests for the sustained background
+#               copying process. Doesn't influence copy-before-write operations.
+#               Default 64.
+#
+# @max-chunk: Maximum request length for the sustained background copying
+#             process. Doesn't influence copy-before-write operations.
+#             0 means unlimited. Default 0.
+#
 # Since: 5.2
 ##
 { 'struct': 'BackupPerf',
-  'data': { '*use-copy-range': 'bool' }}
+  'data': { '*use-copy-range': 'bool',
+            '*max-workers': 'int', '*max-chunk': 'int64' } }
 
 ##
 # @BackupCommon:
diff --git a/block/backup.c b/block/backup.c
index 09ff5a92ef..8c67d77504 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -388,6 +388,29 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         return NULL;
     }
 
+    cluster_size = backup_calculate_cluster_size(target, errp);
+    if (cluster_size < 0) {
+        goto error;
+    }
+
+    if (perf->max_workers < 1) {
+        error_setg(errp, "max-worker must be greater than zero");
+        return NULL;
+    }
+
+    if (perf->max_chunk < 0) {
+        error_setg(errp, "max-chunk must be zero (which means no limit) or "
+                   "positive");
+        return NULL;
+    }
+
+    if (perf->max_chunk && perf->max_chunk < cluster_size) {
+        error_setg(errp, "Required max-chunk (%" PRIi64 ") is less than backup "
+                   "cluster size (%" PRIi64 ")", perf->max_chunk, cluster_size);
+        return NULL;
+    }
+
+
     if (sync_bitmap) {
         /* If we need to write to this bitmap, check that we can: */
         if (bitmap_mode != BITMAP_SYNC_MODE_NEVER &&
@@ -420,11 +443,6 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
-    cluster_size = backup_calculate_cluster_size(target, errp);
-    if (cluster_size < 0) {
-        goto error;
-    }
-
     /*
      * If source is in backing chain of target assume that target is going to be
      * used for "image fleecing", i.e. it should represent a kind of snapshot of
diff --git a/block/replication.c b/block/replication.c
index 22ffc811ee..97be7ef4de 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -454,7 +454,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
     int64_t active_length, hidden_length, disk_length;
     AioContext *aio_context;
     Error *local_err = NULL;
-    BackupPerf perf = { .use_copy_range = true };
+    BackupPerf perf = { .use_copy_range = true, .max_workers = 1 };
 
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
diff --git a/blockdev.c b/blockdev.c
index b71ed08a3b..0ed390abe0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2788,7 +2788,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
 {
     BlockJob *job = NULL;
     BdrvDirtyBitmap *bmap = NULL;
-    BackupPerf perf = { .use_copy_range = true };
+    BackupPerf perf = { .use_copy_range = true, .max_workers = 64 };
     int job_flags = JOB_DEFAULT;
 
     if (!backup->has_speed) {
@@ -2817,6 +2817,12 @@ static BlockJob *do_backup_common(BackupCommon *backup,
         if (backup->x_perf->has_use_copy_range) {
             perf.use_copy_range = backup->x_perf->use_copy_range;
         }
+        if (backup->x_perf->has_max_workers) {
+            perf.max_workers = backup->x_perf->max_workers;
+        }
+        if (backup->x_perf->has_max_chunk) {
+            perf.max_chunk = backup->x_perf->max_chunk;
+        }
     }
 
     if ((backup->sync == MIRROR_SYNC_MODE_BITMAP) ||
-- 
2.21.3


