Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D968CC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0571220C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EE+/CDo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0571220C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5LR-0000U1-3a
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5K4-0006s6-Tv; Wed, 09 Sep 2020 15:00:00 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com
 ([40.107.7.97]:14387 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5K2-0001M1-TO; Wed, 09 Sep 2020 15:00:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Brh4dGHiCvMEKI5214Og8nrwZ5JR6EEDq+cbbMq7pQeBIMjjNhOGK5nF9SYPSFnAEFYAhSODHPf6gr+TzBr9fDJgZ2TbJc4NiSbzng4jgPtmKDSbN/c7l2m+GwQqHLE/+XbMKUWFm2l9x9cUVyjiCXi3MEeT2aLzXpq0yjzc2GAksFsyDsoFUPgjf8qdqbHGHYDuaEsUrIMwdd8njYmpPlKKF0MwButXixjfwOM/0A5VopekfqAAionsmiIf0DmV9HHn5dN+zQYTKDoZmhfWJueNDxUQcejYA75AZzbuGve+hh4btqhDVtEli4tBZPPeghrtLw/dm8irUGpQhXYWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjcLS9sPZNB4bNg0LWN4zI1x2sjmbDN/x4eoWkmAwd8=;
 b=gVSRwtA8w2hej7fp57feWpFy5YGTiaqSbMtjXN3+/yGArhlCun7x7aFLcfTjXohCI0UyNYAVisDvAuMV7hZ1hON4VT6d3zuuMNZlnlwOIh8vHOey68wStvl5voDatbpya3oAKWKCTGJFlbYTl4+n6FBp89izXm1J68lrvjj1XwMF7Vio0Hpc9956HRmNO6EMATB1rorXtmKef98n7eBdoQ1tvI08cQeS1o8lqd5F/JAZpS8xe/zFSSZ/pKZ9A1GolxLvT/DSUloMGwx9EItiHcd8S0Bwnrt0xGBScpzs8/HvkTwHuT8bhsnk/MNK+Stel7vsMdKYzPD4ggoactx+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjcLS9sPZNB4bNg0LWN4zI1x2sjmbDN/x4eoWkmAwd8=;
 b=EE+/CDo81jcdOiaITcbllYWst+gtL+x+3ZXnjuz7IdCZV1Ftyavu4clIDR2AgAbOplVzr4am1PSD+gjowXoHOwwCbDP6vwoO0bLXjb9m9ID9jQ2HZMz6zAuPOkIZLphcPV349OWx8WOmY0xefwiH29RGKlazaSLN1kMJhILpmP0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3445.eurprd08.prod.outlook.com (2603:10a6:20b:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:59:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 18:59:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 02/14] block: use return status of bdrv_append()
Date: Wed,  9 Sep 2020 21:59:18 +0300
Message-Id: <20200909185930.26524-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909185930.26524-1-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.136) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 18:59:51 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c3b513-a351-4676-8567-08d854f288d1
X-MS-TrafficTypeDiagnostic: AM6PR08MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34454538A65333529C83D4C7C1260@AM6PR08MB3445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRoohtyX7WI5QJYln0rCn7bZmk3CF/g/bsambDhd7Vv4mwmeFiI1C8rcLVv6MFC4ysiUzT40ogvjUUfn3Zd9dt7RpxnGiB37B+lvxMdb/JRm383GfcUS5Ox34NnhlKNRjS9AB3fSkRNgy2dv0R880aotngPpAQY6IN+r8i+Wv6MuGXXufobv5rLmt3L9ODlTdvBom48MWXcOJy18n17GiCUjqIiZaBrHJ29U+TvNjb2XPNeTyTxWWAu9P+RuJ3VKKtzgE8z53d+NstLTGpT6KpwB6ru6fk7i0w1IFuSdjbdDvK1pbBNzU+fDrMkVC7PZ4FDVTL8gcVblU55tH4jr1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39840400004)(376002)(346002)(66946007)(52116002)(83380400001)(2616005)(956004)(2906002)(6666004)(8676002)(6512007)(1076003)(86362001)(5660300002)(26005)(36756003)(6916009)(478600001)(6506007)(8936002)(316002)(16526019)(66556008)(186003)(66476007)(7416002)(6486002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: X/5IChnHLAaVrke+XtdNsGxu14euvtXaGhJqwsKcMVxeJXpc3LjYf8PWu5MBlp/URvSbKyrO8UJAZUCqnFukBjNaXtec8piYvyJbwZjWmTcL55F8TNAsEwKcC75i3TMj1IsyNKEj7CqzU+DUuGU1RioVXJXozuYPS498H1L3CiR+1mvSLNgbYjpaYXR72JaZ/rgNbsszG+CiF0ctT7cxYtdGlBF34A4uSsczrZWqCvx0A0V51/AOSX2mJbBHCnpg3Eq7qUVhhCDzQkuQRomoC8J8InD0NbmwAGP4bdnsE70/jmqw6PEeLu8Rpu63k8EIgLi13Xhlemll2R0InSyV+kqWBQQhK/3vCsvk+PMfZD49vwV+yGwP1Z80bp6mmBMODvJfvkih8Lrb6IsYtWnII+SWpWzqGPh4cu+CWphcTJpnbn7jgpC/PynbXou0lBosssrJg3hEu2yqs/9NBromWVMa/rBa30dUWM12zssvkB7iGHB/XgbcJgdJyEqyPl6Ar32AZvuRtx8vUbz3k2EJQxc6sOuHET0HRTaaIVbD4XnHrCDLFXr96Z2VZdyZBFDw+hZ+R5qPt4vWnojZq8jHztnmI6NB6TM1chNvwctnCHaPbsKnkVqWaTJQLct+vU1poZ8t3PES/0M4ehsidGYEEg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c3b513-a351-4676-8567-08d854f288d1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:59:52.9287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGwrGF03Nr51gN7afxEgET8oSVCpTfaLyCQH1qQwHMdIPj2PUD7wMyTyY0N5Aj0Ul/l+WSvis+9Vn75a7pQiep3coVxw6nnFJDeDGfZjnJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Received-SPF: pass client-ip=40.107.7.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:59:51
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
---
 block.c                     |  5 +----
 block/backup-top.c          | 20 ++++++++------------
 block/commit.c              |  5 +----
 block/mirror.c              |  6 ++----
 blockdev.c                  |  4 +---
 tests/test-bdrv-graph-mod.c |  6 +++---
 6 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/block.c b/block.c
index 6d35449027..9b624b2535 100644
--- a/block.c
+++ b/block.c
@@ -3156,7 +3156,6 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     int64_t total_size;
     QemuOpts *opts = NULL;
     BlockDriverState *bs_snapshot = NULL;
-    Error *local_err = NULL;
     int ret;
 
     /* if snapshot, we create a temporary backing file and open it
@@ -3203,9 +3202,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
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
index af2f20f346..de9d5e1634 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -192,7 +192,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
                                          BlockCopyState **bcs,
                                          Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_GUARD();
     BDRVBackupTopState *state;
     BlockDriverState *top;
     bool appended = false;
@@ -225,9 +225,8 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
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
@@ -237,18 +236,16 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
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
@@ -266,7 +263,6 @@ fail:
     }
 
     bdrv_drained_end(source);
-    error_propagate(errp, local_err);
 
     return NULL;
 }
diff --git a/block/commit.c b/block/commit.c
index 7732d02dfe..7720d4729b 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -253,7 +253,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     CommitBlockJob *s;
     BlockDriverState *iter;
     BlockDriverState *commit_top_bs = NULL;
-    Error *local_err = NULL;
     int ret;
 
     assert(top != bs);
@@ -292,10 +291,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 
     commit_top_bs->total_sectors = top->total_sectors;
 
-    bdrv_append(commit_top_bs, top, &local_err);
-    if (local_err) {
+    if (bdrv_append(commit_top_bs, top, errp) < 0) {
         commit_top_bs = NULL;
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/mirror.c b/block/mirror.c
index e8e8844afc..ca250f765d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1557,7 +1557,6 @@ static BlockJob *mirror_start_job(
     BlockDriverState *mirror_top_bs;
     bool target_graph_mod;
     bool target_is_backing;
-    Error *local_err = NULL;
     int ret;
 
     if (granularity == 0) {
@@ -1606,12 +1605,11 @@ static BlockJob *mirror_start_job(
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
index 3848a9c8ab..36bef6b188 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1576,9 +1576,7 @@ static void external_snapshot_prepare(BlkActionState *common,
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


