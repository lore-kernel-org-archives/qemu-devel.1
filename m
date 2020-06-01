Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D24C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4580207BB
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EMfKiinn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4580207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfovm-0006vL-NZ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouV-0004uP-9M; Mon, 01 Jun 2020 14:11:43 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:10211 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouU-00027N-1d; Mon, 01 Jun 2020 14:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Drcg7dPdbGt8HSQ8v3Dt3JtW3pTv1XnWMMH4eu0lBx2wjcWwtj4klf3SnwSbAU5HIGQmMF/DxASafxsQyJjLUyz5eFE3/jmHVDjEZBoBuI1nWd7EjKt3f9yLM//WvK0fWKht+4+6Ql10nM42q5Bb+6XfS8LgZu0sUa2g00SNPsPawc8G41FekUzvzJQhEFRug0TrzLPH3hpEbBUwEnIx1/50WJGQfX6x5cBe/8h4A63WI7hhs+fcIqa7J5OYJdJUWsUoW+G32bcfW7p3spt5NPk0Z1disvU3VaKqc/4Lh+VndR5VIcjjRUKR/j3aT7S3aoLqI1QbzLQQw5AGonXLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtFOXYMWik8OBbtSOj0UkU8OwmPksuL15XJfxD/Vcts=;
 b=d4jBWmBvuvk2Kbxsz+SmWkq5rIGasn7v1HfKmc/K6Y9lv7/flpnrQ7yHQ+z7uFTZQKS639FvpGebotnu66fdv+5KrNlOjzxTaZO1CrNSkmNigvsVh2GfAdo+xq0ZjsEMn8ekU7dYJATPHL+S+0dD9v4jYuy0+OAGVwW6+h7/WF1/go8Zlzx7zUTzt7lt+piPrKcbD1dyOE6ogekI22nLqpQvyNjizgtGvcZHnVqmqfcLNEPNsfX0SKFGF6rwblV/eLOesJtkt/FROwTqoTgs7YAger1jI39h8CWkMXVlT3w7VNaxDI2uRGl+3CBuJr8iDz9PeLPa4buxmGaHm/xpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtFOXYMWik8OBbtSOj0UkU8OwmPksuL15XJfxD/Vcts=;
 b=EMfKiinn4OzHfGUqaEAW77Rp3OD9UngZQb11x/JP2ZiCHPE9mmJPvPgeasZFF84PbX8k+syZDaHrIEkhCxfzN0rVyFKXkenEgOJjDzLvsu5ZsFzkkWI37m3B/nbdDMszgemuw4aqZcd7NoN6+pnwAENviK/GohvuhF/FyrkHAck=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 03/20] qapi: backup: add x-use-copy-range parameter
Date: Mon,  1 Jun 2020 21:11:01 +0300
Message-Id: <20200601181118.579-4-vsementsov@virtuozzo.com>
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
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37067665-4681-47b5-326a-08d806573799
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53172FF13CA970F1A41649AFC18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/dEFUJJ6emTw15eEE7+StUSUyQJo5DLm6fLFclsUALs9KsPuIr4yxyOFIHJcf55K5fCHtPqqGt057VdSlZduKJDfAM+SuE+eZdpfUrt+616VHh5GddhzAG24fYNGs2Uvx57Vukkq4nF5v2rDqc2aXsHzOmLzMSi9KENZab7K4t3YIg+tLmT5nSuC76qUUj1raVOdQeblBoQO2F3g11qELR3HCe2BoNMhKIGguQleHjJZx5yVFrQYKvS4/OhTdtLR82jcebCKl4cJKPGGRryXnneDprlzGikF6g8xdA5Noa1CEYCt6jv46nDx9zId/jGvaFDxBsO3pNHJZ6Rwapw/x3Oxm80bpVi1awxfBTHTxiTfNnHbJR3LV66LwL9ZJoM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ctm9wUwBWwfl8lmrWDMKYnraOjPO9Ou3rhJikNNa5VhpJATn3vG4dqRpKeNUr73Osbj1YxE93aFmTYjwgLY2qTH0Tct8+4dIbtokH6f2MSk9pPA+MoA9eA6LKpti7A/Iy9hDp6dI+kgTbvpqbgDxgxXRT3MI5/r7H2F4h3LvEbo4AJtuuhGGCtMjepOJDu/SwEf78+htcAyaR92D9CAjn2esLrood3RU2QymIgZjJ6QZ0/s3cTut/WYf2Wshu0FjWGd/uzhgLu8RO/lhI3eWyry4W/b7TPOJri2hSXYMZf7+QNjAVbWWP0kvTxT1MYnvWGKu6uvcQjeKoDN0hjC0L6V2G2qzzXWjDnRsRgPdHs8drdZUattF1DWcThtn01+TFT/10KGyUl7qoWW9EFdSYz41Q9QLflbmtxePhskh2uAMdbPbpRYpg3qpCAbA/NiOW4CJrEgz7k6k8mQ2dsszZvLLmEUdHsgIpmRjh0xSKTA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37067665-4681-47b5-326a-08d806573799
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:33.8803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRWmHMeweFNCuGDje/VvCsF2OWkKvwKD0GduRvOjEWRvQBEy1Rsevtur3R93NBdTk9qhiSRuBnYDEWqW2GzhHfwLuZHeR/jSl9RnmMpOHoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:40
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

Add parameter to enable/disable copy_range. Keep current default for
now (enabled).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json       | 4 +++-
 block/backup-top.h         | 1 +
 include/block/block-copy.h | 2 +-
 include/block/block_int.h  | 1 +
 block/backup-top.c         | 4 +++-
 block/backup.c             | 4 +++-
 block/block-copy.c         | 4 ++--
 block/replication.c        | 1 +
 blockdev.c                 | 5 +++++
 9 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6fbacddab2..0c7600e4ec 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1405,6 +1405,8 @@
 #                    above node specified by @drive. If this option is not given,
 #                    a node name is autogenerated. (Since: 4.2)
 #
+# @x-use-copy-range: use copy offloading if possible. Default true. (Since 5.1)
+#
 # Note: @on-source-error and @on-target-error only affect background
 #       I/O.  If an error occurs during a guest write request, the device's
 #       rerror/werror actions will be used.
@@ -1419,7 +1421,7 @@
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
-            '*filter-node-name': 'str' } }
+            '*filter-node-name': 'str', '*x-use-copy-range': 'bool'  } }
 
 ##
 # @DriveBackup:
diff --git a/block/backup-top.h b/block/backup-top.h
index e5cabfa197..2d74a976d8 100644
--- a/block/backup-top.h
+++ b/block/backup-top.h
@@ -33,6 +33,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
                                          BlockDriverState *target,
                                          const char *filter_node_name,
                                          uint64_t cluster_size,
+                                         bool use_copy_range,
                                          BdrvRequestFlags write_flags,
                                          BlockCopyState **bcs,
                                          Error **errp);
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index aac85e1488..6397505f30 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -22,7 +22,7 @@ typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
 typedef struct BlockCopyState BlockCopyState;
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
-                                     int64_t cluster_size,
+                                     int64_t cluster_size, bool use_copy_range,
                                      BdrvRequestFlags write_flags,
                                      Error **errp);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 791de6a59c..93b9b3bdc0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1225,6 +1225,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             BitmapSyncMode bitmap_mode,
                             bool compress,
                             const char *filter_node_name,
+                            bool use_copy_range,
                             BlockdevOnError on_source_error,
                             BlockdevOnError on_target_error,
                             int creation_flags,
diff --git a/block/backup-top.c b/block/backup-top.c
index af2f20f346..0a09544c76 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -188,6 +188,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
                                          BlockDriverState *target,
                                          const char *filter_node_name,
                                          uint64_t cluster_size,
+                                         bool use_copy_range,
                                          BdrvRequestFlags write_flags,
                                          BlockCopyState **bcs,
                                          Error **errp)
@@ -246,7 +247,8 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
 
     state->cluster_size = cluster_size;
     state->bcs = block_copy_state_new(top->backing, state->target,
-                                      cluster_size, write_flags, &local_err);
+                                      cluster_size, use_copy_range,
+                                      write_flags, &local_err);
     if (local_err) {
         error_prepend(&local_err, "Cannot create block-copy-state: ");
         goto fail;
diff --git a/block/backup.c b/block/backup.c
index 4f13bb20a5..76847b4daf 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -334,6 +334,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BitmapSyncMode bitmap_mode,
                   bool compress,
                   const char *filter_node_name,
+                  bool use_copy_range,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   int creation_flags,
@@ -440,7 +441,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   (compress ? BDRV_REQ_WRITE_COMPRESSED : 0),
 
     backup_top = bdrv_backup_top_append(bs, target, filter_node_name,
-                                        cluster_size, write_flags, &bcs, errp);
+                                        cluster_size, use_copy_range,
+                                        write_flags, &bcs, errp);
     if (!backup_top) {
         goto error;
     }
diff --git a/block/block-copy.c b/block/block-copy.c
index f7428a7c08..43a018d190 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -215,7 +215,7 @@ static uint32_t block_copy_max_transfer(BdrvChild *source, BdrvChild *target)
 }
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
-                                     int64_t cluster_size,
+                                     int64_t cluster_size, bool use_copy_range,
                                      BdrvRequestFlags write_flags, Error **errp)
 {
     BlockCopyState *s;
@@ -257,7 +257,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
          * We enable copy-range, but keep small copy_size, until first
          * successful copy_range (look at block_copy_do_copy).
          */
-        s->use_copy_range = true;
+        s->use_copy_range = use_copy_range;
         s->copy_size = MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
     }
 
diff --git a/block/replication.c b/block/replication.c
index ccf7b78160..25987eab0f 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -563,6 +563,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
                                 0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, NULL,
+                                true,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_err);
diff --git a/blockdev.c b/blockdev.c
index 72df193ca7..28145afe7d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2813,10 +2813,15 @@ static BlockJob *do_backup_common(BackupCommon *backup,
         job_flags |= JOB_MANUAL_DISMISS;
     }
 
+    if (!backup->has_x_use_copy_range) {
+        backup->x_use_copy_range = true;
+    }
+
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->bitmap_mode,
                             backup->compress,
                             backup->filter_node_name,
+                            backup->x_use_copy_range,
                             backup->on_source_error,
                             backup->on_target_error,
                             job_flags, NULL, NULL, txn, errp);
-- 
2.21.0


