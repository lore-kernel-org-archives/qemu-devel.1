Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971C6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503B1207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mYvxsz6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503B1207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6Wr-0003kb-IS
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb6UK-0007yg-Jr; Tue, 19 May 2020 13:57:12 -0400
Received: from mail-eopbgr70125.outbound.protection.outlook.com
 ([40.107.7.125]:55350 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb6UG-0003Xn-Na; Tue, 19 May 2020 13:57:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw2hEVbYhze6NMNu3KH8bjPFtyyUbP7SglK/BOBFHVplFPkDqcH4xG4b/eKc41GuNLP/8nmuPwUxknilzaQa0CT3U/ZvL4MKhhy3xCp660iT2OkSIukS9tVKlAX9lLc80y9st2d2HCP73egIJc75z9hWxeXarjODpbaEkN/xUjTkkki46vBVkbkL6ubJ28ZsvaF1e5u6ioJQuN1BhPpcA1cED7eKe+hOdpnFFKvVLHUZiJRpZFtmSMZi+x7Pv82Ilxbq2nMYVbgW9HpGhlNw0IV+YFK/X82t0F6V8jLEzOPVSZXW383Oj0U3IfD9yPP+Mg1F2pFSXQo0F54S9vIr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybhzGZmCtgC5mZNxaoeyyYhIvcxtr18D1fr1n3vEiEc=;
 b=lGmb2GDP9w/e1vPF8VL+ao5XyjnX5h2bxK4d2/yO/+zdlBu+bk8RUaH2IOoOGzvpZS89TtWHjMTPI1dkVBVfI2IzfZXQqdqvL45vltORsoITB7iy8UeDKsoSZFVnGNMQwSvH8nEP2+OxPK1GZg7wq1FD/f/9RAxolyEz4Un89l/sHW9U0fnDfuE/jE8uZlIAHBpUfI9qU0x7wK02jgMJfjmUcbRc8J+1VcFCTv6nPHzGYGCWximj2rSVunZsJJ3D++xRPOH5wAAePUhs7azBABzGHilGLS4zg2zI1aYTfQDUI7Hg7XRQpD2f2rp+YVZmn7gkCffD9KyqnuIpytw41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybhzGZmCtgC5mZNxaoeyyYhIvcxtr18D1fr1n3vEiEc=;
 b=mYvxsz6IiuhFizoCrXxIt6riN+nbpzKtNysb4DKLyT62C8dciP6WRzMYniyHIbYO6D2JRt3Y/cDgSPBJUObAG2t2zitMbZ6hEm+IGeWqf+WfzRqptjgMICUaj2Z2ZP9Zns+gcr2JTs1cyjxcVz2Tw50q4rJO3iOad/gCt6CZV5I=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 17:57:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 17:57:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2] block: Factor out bdrv_run_co()
Date: Tue, 19 May 2020 20:56:50 +0300
Message-Id: <20200519175650.31506-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0033.eurprd03.prod.outlook.com
 (2603:10a6:208:14::46) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 AM0PR03CA0033.eurprd03.prod.outlook.com (2603:10a6:208:14::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Tue, 19 May 2020 17:57:03 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb12d581-56d7-4a5f-c0a4-08d7fc1e0a02
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478722E3AE08533A278FF5DC1B90@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLJvoINyI2QlvkiudQ7HRAl+3sa+mKeyYuoqBXYD2hs11gGgoc9eLy9IsHGqGno57812E1eSuzArc8JpD6+S4wMUn0kdYU4Wcf6JlJMkgSXDA+Pg3VeeObTqMDH3bzmxG3YS7dchYgTXfcaL6uyd9Gz/8uBHI7YNvAoEwr3eB6MN7PzDcVjC+1tnrKgvUDlsQwiGuU7O01VgO+Fat1F25EJ5BCQQqMQLBI/vAHYKGViBig4GIfbpGf212sAGBnFvLhalB3XoELkF72mEy7BqxWlXXFfNFwgwu/4+6ZJCXmG49kBjZkOmlXPaIh+to8bxnYtDie+i42khA5HsTTFsBtkGbivPVPDDzTKAXIuhuDAyboQZC+DWQsHFn+Brn45VAOj82ZuCfSxuVczo4A6PSjeMOMG8uCnyI906Ti7oLz5+oWKI5YgOQTww5sl/imBzxTAbXX4aD7JoANBXX37LHzTl/Ql+NWfz561F0BLMjrWQ2dKHquLCaJqcTY86hiX7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39830400003)(52116002)(26005)(6666004)(6512007)(6486002)(186003)(5660300002)(6506007)(16526019)(69590400007)(2616005)(956004)(1076003)(86362001)(478600001)(2906002)(316002)(66556008)(6916009)(66946007)(107886003)(36756003)(66476007)(8676002)(8936002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bgLLSaq88VaQI1uKxvvh/X6AakPc5T+cVs0K64NBOuOHhPfTeY32rDeAF8qlhmQK6lBIAmTPDU3CLJRMDd1z0lT8Goi/pIydTp6Vqo80ppdhk4Eqw7J3fM7aNWdRQtFNgKrVk7N5CDbOWV9S3iytD8iQgm4OJ+BJa5maSPOyyDuwLP0emkpIq/5Rkye8qckNGyyqq2ZEynuW2GS6jRxOdzt9myjQQkO17//7xQoDKwPSjI4XerDJsVXfM99NPuRKOovTocuerBC9vc3Dm2Fw/FMk/zn5EZrICJl5TL3mkP1jyNPUzDiKuApCufArtExBKbq1+faTc6gxrEXxCQgAdvnNUgH3gp0GlgwiimRifLoNaYyvG2bkzR1UOi5qTbFQOmQDM0JWe1uUc2IO5YsmoRvYIdkmR9TqACeZWSuRLxeCuruksSeCeokqXE4mo5xneuZdNZMUqftzvV5zi4fC4pN6fbsXKcXOTv9Cdda9S2OFRTBuqrpTPPy1SfYoxcKa
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb12d581-56d7-4a5f-c0a4-08d7fc1e0a02
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 17:57:04.6262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA8sW3ioJplBCaoivfjtNB8yzfWlcvBdtmB5tYDdkakcRzzOW/CTwyLYglMD/W0p3pfgQ6HANiIbxNV678WM95RHUaChnOfCAc04MHsDTaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.7.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 13:57:05
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a few bdrv_*() functions that can either spawn a new coroutine
and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
alreeady running in a coroutine. All of them duplicate basically the
same code.

Factor the common code into a new function bdrv_run_co().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
   [Factor out bdrv_run_co_entry too]
---

Hi!

I'm a bit lost on rebasing "block/io: safer inc/dec in_flight sections"
(is it needed or not?), so, I decided to send just this one patch:

I suggest to go a bit further, and refactor that bdrv_run_co don't need
additional *ret argument neither NOT_DONE logic.

 block/io.c | 191 ++++++++++++++++++++---------------------------------
 1 file changed, 70 insertions(+), 121 deletions(-)

diff --git a/block/io.c b/block/io.c
index 121ce17a49..794eebbd0c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -35,8 +35,6 @@
 #include "qemu/main-loop.h"
 #include "sysemu/replay.h"
 
-#define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
-
 /* Maximum bounce buffer for copy-on-read and write zeroes, in bytes */
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
 
@@ -891,29 +889,61 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
+typedef int coroutine_fn BdrvRequestEntry(void *opaque);
+typedef struct BdrvRunCo {
+    BdrvRequestEntry *entry;
+    void *opaque;
+    int ret;
+    bool done;
+} BdrvRunCo;
+
+static void coroutine_fn bdrv_run_co_entry(void *opaque)
+{
+    BdrvRunCo *arg = opaque;
+
+    arg->ret = arg->entry(arg->opaque);
+    arg->done = true;
+    aio_wait_kick();
+}
+
+static int bdrv_run_co(BlockDriverState *bs, BdrvRequestEntry *entry,
+                       void *opaque)
+{
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        return entry(opaque);
+    } else {
+        BdrvRunCo s = { .entry = entry, .opaque = opaque };
+
+        bdrv_coroutine_enter(bs, qemu_coroutine_create(bdrv_run_co_entry, &s));
+
+        BDRV_POLL_WHILE(bs, !s.done);
+
+        return s.ret;
+    }
+}
+
 typedef struct RwCo {
     BdrvChild *child;
     int64_t offset;
     QEMUIOVector *qiov;
     bool is_write;
-    int ret;
     BdrvRequestFlags flags;
 } RwCo;
 
-static void coroutine_fn bdrv_rw_co_entry(void *opaque)
+static int coroutine_fn bdrv_rw_co_entry(void *opaque)
 {
     RwCo *rwco = opaque;
 
     if (!rwco->is_write) {
-        rwco->ret = bdrv_co_preadv(rwco->child, rwco->offset,
-                                   rwco->qiov->size, rwco->qiov,
-                                   rwco->flags);
+        return bdrv_co_preadv(rwco->child, rwco->offset,
+                              rwco->qiov->size, rwco->qiov,
+                              rwco->flags);
     } else {
-        rwco->ret = bdrv_co_pwritev(rwco->child, rwco->offset,
-                                    rwco->qiov->size, rwco->qiov,
-                                    rwco->flags);
+        return bdrv_co_pwritev(rwco->child, rwco->offset,
+                               rwco->qiov->size, rwco->qiov,
+                               rwco->flags);
     }
-    aio_wait_kick();
 }
 
 /*
@@ -923,25 +953,15 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
                         QEMUIOVector *qiov, bool is_write,
                         BdrvRequestFlags flags)
 {
-    Coroutine *co;
     RwCo rwco = {
         .child = child,
         .offset = offset,
         .qiov = qiov,
         .is_write = is_write,
-        .ret = NOT_DONE,
         .flags = flags,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_rw_co_entry(&rwco);
-    } else {
-        co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
-    }
-    return rwco.ret;
+    return bdrv_run_co(child->bs, bdrv_rw_co_entry, &rwco);
 }
 
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
@@ -2229,8 +2249,6 @@ typedef struct BdrvCoBlockStatusData {
     int64_t *pnum;
     int64_t *map;
     BlockDriverState **file;
-    int ret;
-    bool done;
 } BdrvCoBlockStatusData;
 
 int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
@@ -2484,16 +2502,14 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
 }
 
 /* Coroutine wrapper for bdrv_block_status_above() */
-static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
+static int coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
     BdrvCoBlockStatusData *data = opaque;
 
-    data->ret = bdrv_co_block_status_above(data->bs, data->base,
-                                           data->want_zero,
-                                           data->offset, data->bytes,
-                                           data->pnum, data->map, data->file);
-    data->done = true;
-    aio_wait_kick();
+    return bdrv_co_block_status_above(data->bs, data->base,
+                                      data->want_zero,
+                                      data->offset, data->bytes,
+                                      data->pnum, data->map, data->file);
 }
 
 /*
@@ -2508,7 +2524,6 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
                                           int64_t *map,
                                           BlockDriverState **file)
 {
-    Coroutine *co;
     BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
@@ -2518,18 +2533,9 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
         .pnum = pnum,
         .map = map,
         .file = file,
-        .done = false,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_block_status_above_co_entry(&data);
-    } else {
-        co = qemu_coroutine_create(bdrv_block_status_above_co_entry, &data);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, !data.done);
-    }
-    return data.ret;
+    return bdrv_run_co(bs, bdrv_block_status_above_co_entry, &data);
 }
 
 int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
@@ -2630,7 +2636,6 @@ typedef struct BdrvVmstateCo {
     QEMUIOVector        *qiov;
     int64_t             pos;
     bool                is_read;
-    int                 ret;
 } BdrvVmstateCo;
 
 static int coroutine_fn
@@ -2658,33 +2663,25 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
     return ret;
 }
 
-static void coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
+static int coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
 {
     BdrvVmstateCo *co = opaque;
-    co->ret = bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
-    aio_wait_kick();
+
+    return bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
 }
 
 static inline int
 bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                 bool is_read)
 {
-    if (qemu_in_coroutine()) {
-        return bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
-    } else {
-        BdrvVmstateCo data = {
-            .bs         = bs,
-            .qiov       = qiov,
-            .pos        = pos,
-            .is_read    = is_read,
-            .ret        = -EINPROGRESS,
-        };
-        Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
+    BdrvVmstateCo data = {
+        .bs         = bs,
+        .qiov       = qiov,
+        .pos        = pos,
+        .is_read    = is_read,
+    };
 
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
-        return data.ret;
-    }
+    return bdrv_run_co(bs, bdrv_co_rw_vmstate_entry, &data);
 }
 
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
@@ -2762,18 +2759,9 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb)
 /**************************************************************/
 /* Coroutine block device emulation */
 
-typedef struct FlushCo {
-    BlockDriverState *bs;
-    int ret;
-} FlushCo;
-
-
-static void coroutine_fn bdrv_flush_co_entry(void *opaque)
+static int coroutine_fn bdrv_flush_co_entry(void *opaque)
 {
-    FlushCo *rwco = opaque;
-
-    rwco->ret = bdrv_co_flush(rwco->bs);
-    aio_wait_kick();
+    return bdrv_co_flush(opaque);
 }
 
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
@@ -2890,36 +2878,20 @@ early_exit:
 
 int bdrv_flush(BlockDriverState *bs)
 {
-    Coroutine *co;
-    FlushCo flush_co = {
-        .bs = bs,
-        .ret = NOT_DONE,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_flush_co_entry(&flush_co);
-    } else {
-        co = qemu_coroutine_create(bdrv_flush_co_entry, &flush_co);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE);
-    }
-
-    return flush_co.ret;
+    return bdrv_run_co(bs, bdrv_flush_co_entry, bs);
 }
 
 typedef struct DiscardCo {
     BdrvChild *child;
     int64_t offset;
     int64_t bytes;
-    int ret;
 } DiscardCo;
-static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
+
+static int coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
 {
     DiscardCo *rwco = opaque;
 
-    rwco->ret = bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
-    aio_wait_kick();
+    return bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
 }
 
 int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
@@ -3038,24 +3010,13 @@ out:
 
 int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
 {
-    Coroutine *co;
     DiscardCo rwco = {
         .child = child,
         .offset = offset,
         .bytes = bytes,
-        .ret = NOT_DONE,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_pdiscard_co_entry(&rwco);
-    } else {
-        co = qemu_coroutine_create(bdrv_pdiscard_co_entry, &rwco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
-    }
-
-    return rwco.ret;
+    return bdrv_run_co(child->bs, bdrv_pdiscard_co_entry, &rwco);
 }
 
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
@@ -3463,21 +3424,19 @@ typedef struct TruncateCo {
     PreallocMode prealloc;
     BdrvRequestFlags flags;
     Error **errp;
-    int ret;
 } TruncateCo;
 
-static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
+static int coroutine_fn bdrv_truncate_co_entry(void *opaque)
 {
     TruncateCo *tco = opaque;
-    tco->ret = bdrv_co_truncate(tco->child, tco->offset, tco->exact,
-                                tco->prealloc, tco->flags, tco->errp);
-    aio_wait_kick();
+
+    return bdrv_co_truncate(tco->child, tco->offset, tco->exact,
+                            tco->prealloc, tco->flags, tco->errp);
 }
 
 int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
                   PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
 {
-    Coroutine *co;
     TruncateCo tco = {
         .child      = child,
         .offset     = offset,
@@ -3485,17 +3444,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
         .prealloc   = prealloc,
         .flags      = flags,
         .errp       = errp,
-        .ret        = NOT_DONE,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_truncate_co_entry(&tco);
-    } else {
-        co = qemu_coroutine_create(bdrv_truncate_co_entry, &tco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, tco.ret == NOT_DONE);
-    }
-
-    return tco.ret;
+    return bdrv_run_co(child->bs, bdrv_truncate_co_entry, &tco);
 }
-- 
2.21.0


