Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C60FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4622073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jkRzF8Jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4622073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp5E-0002HP-UE
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoub-0005CA-Lu; Mon, 01 Jun 2020 14:11:49 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoua-00026c-Au; Mon, 01 Jun 2020 14:11:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUtHHHgWe7wbYQckufP9irvLDMWUOIkYxj+qqdHaedF9NzYBueauLda22AjK39xX4OVFEahnTvittTO7P0nSwje8NBAjeN4MnnYbriNAzm2HOgddL/BL1TNJwrRyH1X6O5milcReO/Eyy5GxTggdoJfFfpNLbyoj/5fVu5iiz63RdicfSP0jbRsU1SJ4bfAV2r//vO6rVMKgV5Q3zew7vGqProSPqleBJ2yypHQuXP9+/qPLou8pldH9AXbl67vvGRfz6WR/hZx00uWsDiVqD49hPl+uTd7cjHHM8A6teD4u2fTyER7yQH6nID17TGgQD3lbSCiFmZ4EhkAWaYocJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYkryG17z2qbi66UH5knwakQqhGFwVBWkY8Ljnt3fOQ=;
 b=haJHi3hFjl+b1wTnrEWzGFYAKCZfYJbZNHJBnNttYlNALvnoTWcv+kMOKlcdF3vX4L+75NGUEkcoP0QXOeYBEy4AHEnSsZfhRPehNaRlDZZ0UK8y2SvVeuRfr2kqYDl0m8Y1FxVvHGlT0laHy5+TalpeyX3EaWdTW73UjRLgsRNHtAm3RAWqXPb+ifRRfUCFLaHq/cMkVI4ipx98YYJUEJhURUYmfKOejEN/yXVdTPEseccUXJ5P9Z5UlC79I11RaL9KErfOWreVaqfow0yPW4bJg1RI/JTuWsW03XLLPnhmwrru/ULJUFLAbdORsjJBUr+YnQXJL89lxLIpeG5tUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYkryG17z2qbi66UH5knwakQqhGFwVBWkY8Ljnt3fOQ=;
 b=jkRzF8JrRmmMEgKwmgItseY4a9tvLdKO5XIxGEhJm0XZuBlWbnoMiBHBxILE909BbMJ4XrLXV+QUpCvbH82y5+BJfgXRyHb9sJvQ/0deCQHFBRMo17g4Tk7K/6khkqelThYBdA63vYC5ye08kd8xbZnvy8VfcgVIqoh2QRpc1fI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 11/20] qapi: backup: add x-max-chunk and x-max-workers
 parameters
Date: Mon,  1 Jun 2020 21:11:09 +0300
Message-Id: <20200601181118.579-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:40 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a41eab4-ddbb-4391-858d-08d806573bc4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53171089E6F4C6A1E8F0D6DAC18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h36Xtz5eXxd7VQ57+trMrTmiCxacQrrvN/nvrxoUtSjcoLtEqLcRFd5+a9IfIWdhPU+6MsiJ5cGLr1k0/z1uZ0Vo/fyOdevVI/hkdqaeS3BuQ/HUD1V36oCZerDh2t75zwFVW15CwEuKhrDMmU2ViyLcCsVHfF7n51q/RXSpflekTLXUYTzBGijNvuFgRYbmsH9P2sfC7q6T0IpuZC3lYVvby0NRxk3K+fVmjl/CDTzSOBJNDdZoskxISLlikoKPdY08IAOe+ex50I8EbKPm2SPBcRP6KVYG5jx+FcHCwudADW/cftqRqVeWThU8UkDDEanw283GegoCp0l9XZKLpSiXW4FOT8sBys7CEkIyUPgrIv2BoskQHzz0p+HMSEkQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8VOcVqeP9XlcCFqoVqJ6H44U04B1VlYlox+l05yL2nEeZBHUt/T8meQy9RpwN6D5c7Ldt43tE53Aa+tF2P587NVZAXotgKaBlt4M57IcCHUv6zDIEZfexeYMAuMAvUQ5LSgHryFbsH5PaRIIGWAqugnp3LBelsTG4eVkGAXRhuZFFFy+4l5NmMJbhcEhr90qDJFLsRPolIOpn5Dk7KVpSs7UZaW2HpWhJOqz9huLLJWYCmvfuZI5jnDbnfdnNsp/bzgOiazXUTpC9ljFSA0+KhthrURAOerrUbp506n4nMBoS33nuSsHf2rfzMm1GcvXMY1jrYpmKoPEaLPanJhOvI5enNaaNyOuWBMq2WXl5Ry7e+vHw31TGERoC4EOm2PQZNdbyWR6AEAjNI1F+bh+EVKaw3zPvrQG6Any0neTYRr9dSrHJPZSPYCH+kt67JQc5nr7DkDGalzgC+93OpOiG3Fq7r6tZ001mKj78XYdyYI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a41eab4-ddbb-4391-858d-08d806573bc4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:40.9065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3s6M3gYW+sAh5ngMya3903RwwALQ95A3qeZ90+IliZ9D/CjpW7fGF1cXv08e5F0gsaojzgZMc0LeRMoI7eqF4fOInGJtE6JX6moENTobLBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new parameters to configure future backup features. The patch
doesn't introduce aio backup requests (so we actually have only one
worker) neither requests larger than one cluster. Still, formally we
satisfy these maximums anyway, so add the parameters now, to facilitate
further patch which will really change backup job behavior.

Options are added with x- prefixes, as the only use for them are some
very conservative iotests which will be updated soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json      |  9 ++++++++-
 include/block/block_int.h |  7 +++++++
 block/backup.c            | 21 +++++++++++++++++++++
 block/replication.c       |  2 +-
 blockdev.c                |  5 +++++
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0c7600e4ec..f4abcde34e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1407,6 +1407,12 @@
 #
 # @x-use-copy-range: use copy offloading if possible. Default true. (Since 5.1)
 #
+# @x-max-workers: maximum of parallel requests for static data backup. This
+#                 doesn't influence copy-before-write operations. (Since: 5.1)
+#
+# @x-max-chunk: maximum chunk length for static data backup. This doesn't
+#               influence copy-before-write operations. (Since: 5.1)
+#
 # Note: @on-source-error and @on-target-error only affect background
 #       I/O.  If an error occurs during a guest write request, the device's
 #       rerror/werror actions will be used.
@@ -1421,7 +1427,8 @@
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
-            '*filter-node-name': 'str', '*x-use-copy-range': 'bool'  } }
+            '*filter-node-name': 'str', '*x-use-copy-range': 'bool',
+            '*x-max-workers': 'int', '*x-max-chunk': 'int64' } }
 
 ##
 # @DriveBackup:
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 93b9b3bdc0..d93a170d37 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1207,6 +1207,11 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
  * @sync_mode: What parts of the disk image should be copied to the destination.
  * @sync_bitmap: The dirty bitmap if sync_mode is 'bitmap' or 'incremental'
  * @bitmap_mode: The bitmap synchronization policy to use.
+ * @max_workers: The limit for parallel requests for main backup loop.
+ *               Must be >= 1.
+ * @max_chunk: The limit for one IO operation length in main backup loop.
+ *             Must be not less than job cluster size or zero. Zero means no
+ *             specific limit.
  * @on_source_error: The action to take upon error reading from the source.
  * @on_target_error: The action to take upon error writing to the target.
  * @creation_flags: Flags that control the behavior of the Job lifetime.
@@ -1226,6 +1231,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             bool compress,
                             const char *filter_node_name,
                             bool use_copy_range,
+                            int max_workers,
+                            int64_t max_chunk,
                             BlockdevOnError on_source_error,
                             BlockdevOnError on_target_error,
                             int creation_flags,
diff --git a/block/backup.c b/block/backup.c
index 76847b4daf..ec2676abc2 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -46,6 +46,8 @@ typedef struct BackupBlockJob {
     uint64_t len;
     uint64_t bytes_read;
     int64_t cluster_size;
+    int max_workers;
+    int64_t max_chunk;
 
     BlockCopyState *bcs;
 } BackupBlockJob;
@@ -335,6 +337,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   bool compress,
                   const char *filter_node_name,
                   bool use_copy_range,
+                  int max_workers,
+                  int64_t max_chunk,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   int creation_flags,
@@ -355,6 +359,16 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     assert(sync_mode != MIRROR_SYNC_MODE_INCREMENTAL);
     assert(sync_bitmap || sync_mode != MIRROR_SYNC_MODE_BITMAP);
 
+    if (max_workers < 1) {
+        error_setg(errp, "At least one worker needed");
+        return NULL;
+    }
+
+    if (max_chunk < 0) {
+        error_setg(errp, "max-chunk is negative");
+        return NULL;
+    }
+
     if (bs == target) {
         error_setg(errp, "Source and target cannot be the same");
         return NULL;
@@ -422,6 +436,11 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     if (cluster_size < 0) {
         goto error;
     }
+    if (max_chunk && max_chunk < cluster_size) {
+        error_setg(errp, "Required max-chunk (%" PRIi64") is less than backup "
+                   "cluster size (%" PRIi64 ")", max_chunk, cluster_size);
+        return NULL;
+    }
 
     /*
      * If source is in backing chain of target assume that target is going to be
@@ -465,6 +484,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->bcs = bcs;
     job->cluster_size = cluster_size;
     job->len = len;
+    job->max_workers = max_workers;
+    job->max_chunk = max_chunk;
 
     block_copy_set_progress_callback(bcs, backup_progress_bytes_callback, job);
     block_copy_set_progress_meter(bcs, &job->common.job.progress);
diff --git a/block/replication.c b/block/replication.c
index 25987eab0f..a9ee82db80 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -563,7 +563,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
                                 0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, NULL,
-                                true,
+                                true, 0, 0,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_err);
diff --git a/blockdev.c b/blockdev.c
index 28145afe7d..cf068d20fa 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2743,6 +2743,9 @@ static BlockJob *do_backup_common(BackupCommon *backup,
     if (!backup->has_compress) {
         backup->compress = false;
     }
+    if (!backup->has_x_max_workers) {
+        backup->x_max_workers = 64;
+    }
 
     if ((backup->sync == MIRROR_SYNC_MODE_BITMAP) ||
         (backup->sync == MIRROR_SYNC_MODE_INCREMENTAL)) {
@@ -2822,6 +2825,8 @@ static BlockJob *do_backup_common(BackupCommon *backup,
                             backup->compress,
                             backup->filter_node_name,
                             backup->x_use_copy_range,
+                            backup->x_max_workers,
+                            backup->x_max_chunk,
                             backup->on_source_error,
                             backup->on_target_error,
                             job_flags, NULL, NULL, txn, errp);
-- 
2.21.0


