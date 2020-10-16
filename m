Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7651BC43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DE620874
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EFmUUrXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DE620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTND-0000NJ-Js
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGN-00037Y-5Y; Fri, 16 Oct 2020 13:11:31 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com
 ([40.107.0.100]:3705 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGJ-0007Mv-0A; Fri, 16 Oct 2020 13:11:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaQcZrcSWohzNVWOue4YFpruciwuJG45QH34fJQ2iTVGI4Z70BzKgpHI6bDYD0dKuue7jvo20LQU9M/VXMbTHef/m18hPibMf+h6+qHnxd7hL6BeZ24+NikJ1ZmtcLtyPF6gs1OfBsfu/UFUjUs5b3QskQ4xEwUUmpIIp4HghVTj3pribgIUexypi0KOtFHLtjFfx8J8jaTf4YYHJ4lD2HIHXhHrhDLgcT/i1cd973URSElKuzEz4scCwje11MzRGdTLoL4lzCPjnvirJGdByheZmHp/HToPYoMZ2gSZU4Pjc/4cF/wEMCbaR/I6qt73DWcUF9SmAiTvWdLz0T7Ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm+6+FzPqWXrAb/weFgm9UyRar/9V9d6JgPD3kd9T3c=;
 b=QTSvYzr38ldqWvvkeube3LeJIUSIhkd6PlAgr/SSZmRiAdmfxD30FraZSX9EAq75XLYSHoFZ02wuSFwUkroH8PR4uGi+2bh2908eYAGZbvO/41ykyJgBr+hszrn7KJs+39425FAkN+l9zp4aPya2LL3dkRgxicDkkNebRtzvA6RukNr6bBH6vEn6jssVlvzjfg9hNaVYqtq386PXN7TOSOkHGd+O4xexz2J8QPVeIeLse2TQP9c4a6KsNyUECuy8E+UG7zjAmRDAoQm7rQO/S7QP0cl3L6CzCVKhYczUydTPLNp+yalu9QdZnyLpO7KiWVMePWdn8p/+1sP4NJR0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm+6+FzPqWXrAb/weFgm9UyRar/9V9d6JgPD3kd9T3c=;
 b=EFmUUrXwyvLCHN7T4tuE5e7VtzBOTyf9dNbVoDfo3cYJdxj+DE1Mr6n63Tcx+pj7eSN0OVMTOtN/WFPuCsRnW68csdCktCTl9ZIcgd3RbLzAS9TM8PcHTu6Q4K9z7OiJnS/0kr5GajDMt9pMWtG98N/VOR4Xdar/c/8giQQRSAU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1972.eurprd08.prod.outlook.com (2603:10a6:203:4b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 17:11:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 03/13] block: check return value of bdrv_open_child and
 drop error propagation
Date: Fri, 16 Oct 2020 20:10:47 +0300
Message-Id: <20201016171057.6182-4-vsementsov@virtuozzo.com>
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
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c59e24db-fe0e-4651-72c5-08d871f67d0a
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB197206DA6DDEB38695576D94C1030@AM5PR0801MB1972.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wegNg9RjcQwFpjVCiuNXiWmlTo7k6NgcBz1g+1wqm0r/txypn+X/XMwEkBSDV16nQbKPBBQ7KL5QMHKb6fmdc8mz1aRJFWNzwMydpO6xhLerYiQQnoOOYHQ5pGvGBOguGe43z3aS/KDQ6qCs0hmsVGZhImvy9NMFiNOs/2ixFNsg/NHayqaFqMz7f5hrssgbRUSzrUscK1+cKC06qF8WdJ8ycCo2pxr7y899742IjDdBuiJ7vc7uKKJ0VHQckWxg3mkBRMj1hioTa7A9j7RFwun5+BmGpQCyjipACAWYAu4X8yqLhtiK3jaAqYuGh6nQ0fSAgRGfiRDHzG7voS5VBbinOwzHGstaFskHLXY01hArQiJ/YRd2CKJR63U7li6s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39830400003)(366004)(346002)(376002)(136003)(83380400001)(8676002)(8936002)(6666004)(316002)(6486002)(36756003)(956004)(1076003)(5660300002)(6512007)(86362001)(2616005)(52116002)(34490700002)(66946007)(2906002)(66556008)(66476007)(4326008)(186003)(478600001)(7416002)(26005)(6506007)(16526019)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1U85mcZPTs+i3lOdw4qRcaZX5Bv6BlqfH6hu0X7KGRM/rmEhP7wQDFr/LpsljtcbpvDWy8cW1CikwdOUoP2K72+p+ukjmvoafN9tCynGsE9w3ggL4gscMl/yq3suxALP/mbN42sxZr0qO8lwFM/VgqPDBpBq7GMjL/+GuwgT+znLrT9Ko1WRl7J+nG5tLohSf2lmD+8p5rj2I6V+B7gNQNaz/HN3cKGWXbNbwczLivwEN5oPDTxIKAjB5wZItYRUjOtA7Vde7vqLKFN7N0DeTyNFo8lz9MIGmR5ptigoInLcdmcwvIUAUhI14nZLUUvLW6nHy0iMyd+H/Nd6AJimgFKLpKTD2lPCYDEf9uBxS6ZOy5MNPUs8UoBvYeO0MHQmAj/4ZArsSmN2derdPySFiffMZ2h8Lta30tcPVw9uGd+ISd/u3dwhflBO4LXXhzQ3FL7lx+T7MFvE2IIDYWqFG0SszbpaXUjJ0tn+eBaoj5BtWlWubaU7K5ktL1QRFL6eZvvCGskhIyI8ElqdsSv1p4O4IwgJPBQwaQO/OKgP7p1IbuzGPBafFp2q2AyOdftxK+Iq9xja7Ltc05/By5Tu02kuZRcxM1jXH2QZwa/E31z69U/6VcSM1RPPn7pghGGVCKlFYMONO29RsvlI5QFX8Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59e24db-fe0e-4651-72c5-08d871f67d0a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:14.7979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOk7WugrU8VKBpmH6XhKsXLTQ4twG/cDW8rIgXufVkcgc4+V4/nxA6gmEHxDi9QTnPS0B7tAkCqrfqJr12g6Q/hqn80jkbE/D7scUcQZSic=
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

This patch is generated by cocci script:

@@
symbol bdrv_open_child, errp, local_err;
expression file;
@@

  file = bdrv_open_child(...,
-                        &local_err
+                        errp
                        );
- if (local_err)
+ if (!file)
  {
      ...
-     error_propagate(errp, local_err);
      ...
  }

with command

spatch --sp-file x.cocci --macro-file scripts/cocci-macro-file.h \
--in-place --no-show-diff --max-width 80 --use-gitgrep block

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/blkdebug.c     |  6 ++----
 block/blklogwrites.c | 10 ++++------
 block/blkreplay.c    |  6 ++----
 block/blkverify.c    | 11 ++++-------
 block/qcow2.c        |  5 ++---
 block/quorum.c       |  6 ++----
 6 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 54da719dd1..d795077fee 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -465,7 +465,6 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVBlkdebugState *s = bs->opaque;
     QemuOpts *opts;
-    Error *local_err = NULL;
     int ret;
     uint64_t align;
 
@@ -495,10 +494,9 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     bs->file = bdrv_open_child(qemu_opt_get(opts, "x-image"), options, "image",
                                bs, &child_of_bds,
                                BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
-                               false, &local_err);
-    if (local_err) {
+                               false, errp);
+    if (!bs->file) {
         ret = -EINVAL;
-        error_propagate(errp, local_err);
         goto out;
     }
 
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 13ae63983b..b7579370a3 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -157,19 +157,17 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     /* Open the file */
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
                                BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY, false,
-                               &local_err);
-    if (local_err) {
+                               errp);
+    if (!bs->file) {
         ret = -EINVAL;
-        error_propagate(errp, local_err);
         goto fail;
     }
 
     /* Open the log file */
     s->log_file = bdrv_open_child(NULL, options, "log", bs, &child_of_bds,
-                                  BDRV_CHILD_METADATA, false, &local_err);
-    if (local_err) {
+                                  BDRV_CHILD_METADATA, false, errp);
+    if (!s->log_file) {
         ret = -EINVAL;
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 30a0f5d57a..4a247752fd 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -23,16 +23,14 @@ typedef struct Request {
 static int blkreplay_open(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp)
 {
-    Error *local_err = NULL;
     int ret;
 
     /* Open the image file */
     bs->file = bdrv_open_child(NULL, options, "image", bs, &child_of_bds,
                                BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
-                               false, &local_err);
-    if (local_err) {
+                               false, errp);
+    if (!bs->file) {
         ret = -EINVAL;
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/blkverify.c b/block/blkverify.c
index 4aed53ab59..95ae73e2aa 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -112,7 +112,6 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVBlkverifyState *s = bs->opaque;
     QemuOpts *opts;
-    Error *local_err = NULL;
     int ret;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
@@ -125,20 +124,18 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
     bs->file = bdrv_open_child(qemu_opt_get(opts, "x-raw"), options, "raw",
                                bs, &child_of_bds,
                                BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
-                               false, &local_err);
-    if (local_err) {
+                               false, errp);
+    if (!bs->file) {
         ret = -EINVAL;
-        error_propagate(errp, local_err);
         goto fail;
     }
 
     /* Open the test file */
     s->test_file = bdrv_open_child(qemu_opt_get(opts, "x-image"), options,
                                    "test", bs, &child_of_bds, BDRV_CHILD_DATA,
-                                   false, &local_err);
-    if (local_err) {
+                                   false, errp);
+    if (!s->test_file) {
         ret = -EINVAL;
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index b05512718c..41a29072e6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1612,9 +1612,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     /* Open external data file */
     s->data_file = bdrv_open_child(NULL, options, "data-file", bs,
                                    &child_of_bds, BDRV_CHILD_DATA,
-                                   true, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                                   true, errp);
+    if (!s->data_file) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/block/quorum.c b/block/quorum.c
index e846a7e892..2ebe0ba16d 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -900,7 +900,6 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
                        Error **errp)
 {
     BDRVQuorumState *s = bs->opaque;
-    Error *local_err = NULL;
     QemuOpts *opts = NULL;
     const char *pattern_str;
     bool *opened;
@@ -978,9 +977,8 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
 
         s->children[i] = bdrv_open_child(NULL, options, indexstr, bs,
                                          &child_of_bds, BDRV_CHILD_DATA, false,
-                                         &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+                                         errp);
+        if (!s->children[i]) {
             ret = -EINVAL;
             goto close_exit;
         }
-- 
2.21.3


