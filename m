Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636AC2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128D7206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YMxypANG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128D7206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ02s-0004to-VG
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 15:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00O-0002fp-DI; Thu, 17 Sep 2020 15:55:44 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com
 ([40.107.20.124]:28615 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00M-0005s0-8X; Thu, 17 Sep 2020 15:55:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkisIifJanTVhe59QtxqpDZECWTTB48lKNyn2pHNLu95vCvoQaiYNaUIsYReDj4Twy2EUnVZtglvixFsfk4ZnG09x6F8D6CASjBNCOhrwqEGqPh8KIZm0MxnjlkDIesVkXGvndag1dhwdSxA9Zqup16uv8H7YevWyb10sj0xmq7ajEUQ7AhnXwl/jXwi0BQDcpu6a89ElNzyKxWE+mIa+0erMxfUvu6Iu0lxUchiNRHTSaj8BJzP/xCRiHNGiJeTgKpsJZG6jteyPfwBYINd5R8Q9QeEuEGR9BvPWSkhe4TWp/9vdRPADV4j4ZV9hmv0ml+B7HxgRiF8k/eNravP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWT1D2Ys1RHUdDXu05q1rK/upQhpC5OQdqPlKEfuyH8=;
 b=gmSL6Lq5ZVuy0fUSd5rMYe4289mWBrp5z+TYrT9eSHRYxQkNj+qMVgMphxFP5EQiEI3LKfjHNS5HHPfc3LDlX5mXuqQnxWsISNtX+XMTjzJ0zGsRR6Z5nXD5uw7przRe62LEcgBpiPV6jPa0pmaeXopyJbCz92+2+BvIRfV1mG2YrV/o1oPjOFWa2UASnXWvcOnRiU7VaabAbaQBEsIuyeK3FiCT3p8uBk0vM9GxR6xbBsTsa4bHPq9YPJIVQwS/iKBog3X+KXEM/vnnSInpK3eANJZwVHMcWnM4lMVKXv+J/sDbEEZgRZ5G67pmuzzaVHbOOI1fxPXlJxb8nvwdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWT1D2Ys1RHUdDXu05q1rK/upQhpC5OQdqPlKEfuyH8=;
 b=YMxypANGJKuRu7G86KH8qSmEdeks9X/vA1nfW+p7mp2PBZQKsIKZhYET78GPLYs/KlMx+4yFiQHxoDWQJQJMtKARtsEzG6xYBm9UnjHgU/TQ9TGhlxsc2CQlH4Wo6tgKy87vI/H+TJllm5QhTZMpUP/AhVJsYRd+/HBjzp30pow=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 19:55:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 02/13] block: use return status of bdrv_append()
Date: Thu, 17 Sep 2020 22:55:08 +0300
Message-Id: <20200917195519.19589-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917195519.19589-1-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:35 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7654d6e-c2a3-4e3b-548a-08d85b43a530
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30325C9EE7343DF907F649B3C13E0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MnojJA3w7SAb1x+TRZ7RSwTx8dTduJwKI/NDeHZqfqIbtxsRb+XcqNhmYGpn8SoBnJBwHbgApyrMmnKevvIkoikjlTj7MAm3fci+iPWpxhSptv3cR6Tim20m3MbcvRm3IPyk1PGPesHuOR0Nh6vIWw3rvnN2m6bNLa8a28/S3eF6RowXCOiyHlb22Cy91nzMW1EBKzbo41o2X8VfJAKOJM63GbubhnG7LHjJIP+EwG78mJNo7OZX6FlV0vvSrsyUQDFaVJeUwycOr4ovO+NdOSLogwLy4QS12IDjRZbBVoiFMcO6mr3agECyMPUDCO4UUt2MTCFSnB8C5AB35zaWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(26005)(186003)(316002)(6486002)(4326008)(86362001)(478600001)(6666004)(16526019)(8936002)(956004)(6512007)(2616005)(6916009)(6506007)(2906002)(7416002)(36756003)(5660300002)(83380400001)(66476007)(66946007)(1076003)(8676002)(52116002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TkHi8p+ZdAv6+YsiCCe8FHyrwBBwVKx6Mh/7AVeJ5/2tDCn/cPgFLKGZJip+wNqC87DINzg7ucT53U2Olvoj0mVrdV63M4IRI84apdGZsBxPfDwEmZuGW9R0fYmPqTd02aHhAt7U0RZMrJc6Qg0cdArXYfjtP9IBOko7TQrb4x3dDY8Tc6TOpR4QVjZeNXXlRV7ZbeRCB9tAjjSD9rjtDKL4q4ty7t2LBypgYoGltMvlbfx2JFjLGC5m3gtQGvgbmMoVU5eo9iLbWFaSwZmWS3oRwsbHqxDdDlMGYrwMZ30OI1WvemFA+3MiTmLa/3vc4Giuidup24brqIiNAfik0CsIG3VxhCHoN+Wr5ljtam1rl7XOhfde4wcsf8HEUpcvEoBrMd9lRNKiIK+zeHKBCZYqn+Mzl9Oym0wcdPuNeaMMisx3RRHrp63pcGudJjUV9Z2/RXpUqL+thUZd0hWhMkudpwKZpGu3dc/mKHoEy/3VI0t49ducV6BbEHzNAbOiPGTMghy7cTfNAbMfLFnMvKu3K6mMl5qc5ktFSX8k+nUmxvIsG3zaSYaHb7bHNbhsH0DROZLgVWORqkSL63hBTJTj9miQiAFJRNkhXGbjGr+GRjSIriEv1i7TAoyIZauhPBSNIvySR5dl6pNGKmpMsg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7654d6e-c2a3-4e3b-548a-08d85b43a530
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:36.6593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEodqKUDD5KRFhixAhh+Odvb7E3p5tZim/EseQQ9iNDPk5+Y6urwvd/C0bbVSP4vpeAc7107d2Z+DTqjMQwxvl2itt5bmg5KmBWpkmzujbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.20.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now bdrv_append returns status and we can drop all the local_err things
around it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c                     |  5 +----
 block/backup-top.c          | 20 ++++++++------------
 block/commit.c              |  5 +----
 block/mirror.c              |  6 ++----
 blockdev.c                  |  4 +---
 tests/test-bdrv-graph-mod.c |  6 +++---
 6 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/block.c b/block.c
index f922c6d8f4..b4e36d6dd7 100644
--- a/block.c
+++ b/block.c
@@ -3160,7 +3160,6 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     int64_t total_size;
     QemuOpts *opts = NULL;
     BlockDriverState *bs_snapshot = NULL;
-    Error *local_err = NULL;
     int ret;
 
     /* if snapshot, we create a temporary backing file and open it
@@ -3207,9 +3206,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
      * order to be able to return one, we have to increase
      * bs_snapshot's refcount here */
     bdrv_ref(bs_snapshot);
-    bdrv_append(bs_snapshot, bs, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (bdrv_append(bs_snapshot, bs, errp) < 0) {
         bs_snapshot = NULL;
         goto out;
     }
diff --git a/block/backup-top.c b/block/backup-top.c
index fe6883cc97..eb6a34b726 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -190,7 +190,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
                                          BlockCopyState **bcs,
                                          Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_GUARD();
     BDRVBackupTopState *state;
     BlockDriverState *top;
     bool appended = false;
@@ -223,9 +223,8 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
     bdrv_drained_begin(source);
 
     bdrv_ref(top);
-    bdrv_append(top, source, &local_err);
-    if (local_err) {
-        error_prepend(&local_err, "Cannot append backup-top filter: ");
+    if (bdrv_append(top, source, errp) < 0) {
+        error_prepend(errp, "Cannot append backup-top filter: ");
         goto fail;
     }
     appended = true;
@@ -235,18 +234,16 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
      * we want.
      */
     state->active = true;
-    bdrv_child_refresh_perms(top, top->backing, &local_err);
-    if (local_err) {
-        error_prepend(&local_err,
-                      "Cannot set permissions for backup-top filter: ");
+    if (bdrv_child_refresh_perms(top, top->backing, errp) < 0) {
+        error_prepend(errp, "Cannot set permissions for backup-top filter: ");
         goto fail;
     }
 
     state->cluster_size = cluster_size;
     state->bcs = block_copy_state_new(top->backing, state->target,
-                                      cluster_size, write_flags, &local_err);
-    if (local_err) {
-        error_prepend(&local_err, "Cannot create block-copy-state: ");
+                                      cluster_size, write_flags, errp);
+    if (!state->bcs) {
+        error_prepend(errp, "Cannot create block-copy-state: ");
         goto fail;
     }
     *bcs = state->bcs;
@@ -264,7 +261,6 @@ fail:
     }
 
     bdrv_drained_end(source);
-    error_propagate(errp, local_err);
 
     return NULL;
 }
diff --git a/block/commit.c b/block/commit.c
index 1e85c306cc..6da0902f9d 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -254,7 +254,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     BlockDriverState *iter;
     BlockDriverState *commit_top_bs = NULL;
     BlockDriverState *filtered_base;
-    Error *local_err = NULL;
     int64_t base_size, top_size;
     uint64_t base_perms, iter_shared_perms;
     int ret;
@@ -312,10 +311,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 
     commit_top_bs->total_sectors = top->total_sectors;
 
-    bdrv_append(commit_top_bs, top, &local_err);
-    if (local_err) {
+    if (bdrv_append(commit_top_bs, top, errp) < 0) {
         commit_top_bs = NULL;
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/mirror.c b/block/mirror.c
index 26acf4af6f..b3778248b8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1560,7 +1560,6 @@ static BlockJob *mirror_start_job(
     BlockDriverState *mirror_top_bs;
     bool target_is_backing;
     uint64_t target_perms, target_shared_perms;
-    Error *local_err = NULL;
     int ret;
 
     if (granularity == 0) {
@@ -1609,12 +1608,11 @@ static BlockJob *mirror_start_job(
      * it alive until block_job_create() succeeds even if bs has no parent. */
     bdrv_ref(mirror_top_bs);
     bdrv_drained_begin(bs);
-    bdrv_append(mirror_top_bs, bs, &local_err);
+    ret = bdrv_append(mirror_top_bs, bs, errp);
     bdrv_drained_end(bs);
 
-    if (local_err) {
+    if (ret < 0) {
         bdrv_unref(mirror_top_bs);
-        error_propagate(errp, local_err);
         return NULL;
     }
 
diff --git a/blockdev.c b/blockdev.c
index 7f2561081e..b9803e553f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1581,9 +1581,7 @@ static void external_snapshot_prepare(BlkActionState *common,
      * can fail, so we need to do it in .prepare; undoing it for abort is
      * always possible. */
     bdrv_ref(state->new_bs);
-    bdrv_append(state->new_bs, state->old_bs, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (bdrv_append(state->new_bs, state->old_bs, errp) < 0) {
         goto out;
     }
     state->overlay_appended = true;
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index 8cff13830e..2b71601c24 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -101,7 +101,7 @@ static BlockDriverState *pass_through_node(const char *name)
  */
 static void test_update_perm_tree(void)
 {
-    Error *local_err = NULL;
+    int ret;
 
     BlockBackend *root = blk_new(qemu_get_aio_context(),
                                  BLK_PERM_WRITE | BLK_PERM_CONSISTENT_READ,
@@ -114,8 +114,8 @@ static void test_update_perm_tree(void)
     bdrv_attach_child(filter, bs, "child", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY, &error_abort);
 
-    bdrv_append(filter, bs, &local_err);
-    error_free_or_abort(&local_err);
+    ret = bdrv_append(filter, bs, NULL);
+    assert(ret < 0);
 
     blk_unref(root);
 }
-- 
2.21.3


