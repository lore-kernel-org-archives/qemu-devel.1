Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DB020874
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WK7tijmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DB020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTMq-0008SJ-1a
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGI-000301-7c; Fri, 16 Oct 2020 13:11:26 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com
 ([40.107.0.100]:3705 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGF-0007Mv-Lg; Fri, 16 Oct 2020 13:11:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BekCax2vhT4sCwugedNsto7eF5RCrINvmlhrvrfu2sWQJIqY/U5DPF8TkVwuSZgjjgrRafwQW08pfHwTr8ZeihzaefmIIDp6sO+H+Ou1i9wXD+jY3C2QVlJ+5CMbwifMQKvfX1rt0Bit4uQrc//fi/N+n+mIDNtTJcnm7EiVLm6qCJ7YRhzdf1zha1foM6ItlqTO4Lnr1vI8PDkyMakWwDuErtbM1mEhbp17y9KivOyO8Ij/A0HwP8rMvhjKYXnuOX27wevjE3eyp7sj4sqtCR2cxWEkrtfWQfrkJZXnGs3RfpYvUN2gwhHon34Exf/mrIEVAt9UAziN9+n5tBjf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA0n0CyzmUHd7YYcI4/mQ/XLFDCunSl6/6gTva1x6Vc=;
 b=Y7dexJf/Db860gqIRZjbazgXK7Z9/W8deayy/ZZ3e/engeZyIE6yWVyyEMMAheSWiZeUeUYlsGf0KqUwHmdNJhHa4AWwWuvZTtKV0cFiq3xe0svDz3Knjf7z9UWo+StFuvfWbXVO3yJFmC6PUNJyrc5KIGa888NW5aN6DD79WHOMv2qjGXKYXkIHzbY8PgKbY8L2YLdaDcFGwb50NV5bEmGX58NsaGunEg6BTvVOx3qsc8k3S2d9zoVpjrlEoYybQzHZMEyxcsN1uUYoqGPWibH+iFQOAN0Npj2ywWOan430G3+Zbd94knoD/WApAXO/SjZtDrWKJtuTO33O5sQYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA0n0CyzmUHd7YYcI4/mQ/XLFDCunSl6/6gTva1x6Vc=;
 b=WK7tijmOvSv7EcobXi787kHio1FTgx3wgHXSkDSok8GpVKgTUb3m4gg2defGBKRX0bzJfi7ctfIpLUjdBKE3L4ULH9xGHBzBvb2/lb2zJtOHeGaR/nWV90kE+BfLpWZRzXHzJIyFgkGzqI6hQQ3LB7IhNuiN75yrJruvdIk0p8I=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1972.eurprd08.prod.outlook.com (2603:10a6:203:4b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 17:11:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 02/13] block: use return status of bdrv_append()
Date: Fri, 16 Oct 2020 20:10:46 +0300
Message-Id: <20201016171057.6182-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016171057.6182-1-vsementsov@virtuozzo.com>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30bd14fb-70a1-4235-c999-08d871f67c57
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB197220DAB02258C160F9F199C1030@AM5PR0801MB1972.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3BwBdSIzQGFKygHPwh3MqF2ba+z2Wp4T3g/CHo3cSgLSLqCT5u5AXtUMP/SHvQkNsPHzaaKwFxWy1M+zPQK5pFvL5SALy0u2TPmN1f/ojy2qUccwQtcJXlJOeXsn0E6jDdy/uV0ssQodDAtFs4pp5ZUHoTOGMtkVignoGgHl98CahRtmQ7LWxE31B1vC4uN96N5b/hNOWZfJhmIg/p1ePFt7Rn+7YHCiFZKxpLq21m1cd+wDFA7qL6mv9zp7NDHLugkVP+YNyNZxK3+/MTtlezbAjOR6F4Mjq3Eh2kQ5NlPIABdbfzLpTmyqUaLVyb1vQGXe9ezk0dScN8OSEPI49Hi4meIxm+J78SLY9lU3vwTmVdVnA8G1q9WbVG2pAj3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39830400003)(366004)(346002)(376002)(136003)(83380400001)(8676002)(8936002)(6666004)(316002)(6486002)(36756003)(956004)(1076003)(5660300002)(6512007)(86362001)(2616005)(52116002)(34490700002)(66946007)(2906002)(66556008)(66476007)(4326008)(186003)(478600001)(7416002)(26005)(6506007)(16526019)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4wDUGkxQuwuYNVy1vvu1j6jHz+VL5p4lpn2FcJp0MT3wah2dStJz6H1n+NclkP/FUrjfT022SgsEVzU/JRGWgc2eMpAAHcpe/tPa0qc6GCCrB0EMNd8Bh2L/PSJdIn/BEL9xnQWWB6YmYoYIWksAZGHmmJpYm1GYePAIQWRycujs7XiXLh1XXNkB8PhrMqdgVssN83E18GOn/ybUBbbmk/LUlJoQQgrg24E/yy0k+zGm7OF53pyhmMNP82HDrvhF/7myfen1C9hqybdbVn4AaWZtDuDChlWMqRZBBeLzVV4gtzmmsgKE7iPDOtja5W632BYs/e+FJ+xwLWCR7wvuzVjVdZNrHPQB4QmeH08wT08FPGrd+0zD+Yh0vrrPiEA5fuOwXddpOM2iX4VbueqirLa5LrDL+WDs7WA2r9TJmEC3rT5h0D4rM7Xm8rGgNnlkMYrZr0deuPc0XhK0FwPrm6p7cwE6iPhhojFLvwPlw88f0DEEAt2vPP2b2aUApgN1OdtAfNFDdZHrAs5em0BckckLmbDXkCmV82ZJ1PtN0dF7PexPtO7GzAP0pmQyEfEBsc7otI3PySy+PnLKMqXgwqG4Nun6Zq+/IQxzmOZOu61bc8Xjoja9nZe6Wizkr/ENF0U93xBAAUE2x2bD95Fang==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bd14fb-70a1-4235-c999-08d871f67c57
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:13.6300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbjLzWqIq0MwsAy38MhyHScP22I/7VgFGLoAZB43ENFLmWETnGGORqLUiHlet3J/f/cIS8d8KGINCLdAaR8arlTvraAPC7wTZoPmYhIrRzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1972
Received-SPF: pass client-ip=40.107.0.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:12
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
index b05fbff42d..7b6818c681 100644
--- a/block.c
+++ b/block.c
@@ -3161,7 +3161,6 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     int64_t total_size;
     QemuOpts *opts = NULL;
     BlockDriverState *bs_snapshot = NULL;
-    Error *local_err = NULL;
     int ret;
 
     /* if snapshot, we create a temporary backing file and open it
@@ -3208,9 +3207,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
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
index fe6fb5dc1d..3a896181fd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1591,9 +1591,7 @@ static void external_snapshot_prepare(BlkActionState *common,
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


