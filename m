Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18227C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48C120663
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qa3fvqyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48C120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6Q5-0007Hd-Ui
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NL-0002MB-Of
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NJ-0005ZW-W8
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:19 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com
 ([40.107.7.94]:37990 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH6NG-0005TM-5Y; Wed, 25 Mar 2020 09:47:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I40VxSN+pGS66KlaRdRBd0fpeWg0Zucvashhn56h59H3aaLD5VIFHJzqhWUP4LkOLxlqss9qOLHAxAXY6yykbfFkmhwnqAeXZXtQAyh+0mtuqTX37RukdLI3HWQZQMDITgf6x0LUX5sKt9PK2OmaVL6INVxCSOlwph/Zuubsb7tss30hOnWDLjqVjx+s46oOMv2r8y4aUTkSqobqVkGAQ7pMe2C9pahqEo+5D8t0hECldJvY0abGLLqp/qoajGUx+O80VfojQ2QkSyol/5XAs6igij+5nUhQH/fQGQNqFeaeHmnFlQVnJQjSpnlf9sbyyqTWwAtaqiDRnxYxPOEhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce3j9fN/QlzRmBxIfPz52+AON1QSZAfKuFbaQRS1lAI=;
 b=SROAkn4iL57w+stoZK/sWYZT2bFTQ00mWDlg3RMMHE0Q7gKY+M0WG+GgJyaJ0qIqNExesGVhWiq4rQL3lOwe17UaAuLwmfj/9AsUZPEH0JDwMxI00IEakXiI5/3akSWFm+NRWvMXZ31GBbtjQXvyd4MUY2LPE+uvmFoMASNkNKRsEZ7sp20rKPB3XEA1puAk/RkikW0mVrZbE2J8ETdy3qyxozhmouWPzX4Q/tEEX25uHQG1WykHlcx94D4aeJqz3Q51gz3TpY9LM9SZ7njEZtzamHoIXf2/iEN7X8Hpo4DeNaL/eRpIPF0BzHaPgBiNC6H20D2cgEicEC14ZDLtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce3j9fN/QlzRmBxIfPz52+AON1QSZAfKuFbaQRS1lAI=;
 b=qa3fvqyR+Hd31ogKLl1qhzuYUXemReZRzy4LvwsxL9QE9daploN3VN1TPA3cfjLrV6WOgf2NupqXTc5gX2uujtlTlW+J/2CTwmZLt1TeuPggjTSIt9QYymfa2+/Z6xzyddwWUjN7wwcOz6Wt/qOdEP/tUckCZ/xB4fCKa2ba1ZI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5480.eurprd08.prod.outlook.com (10.141.175.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.23; Wed, 25 Mar 2020 13:47:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 13:47:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/6] block/block-copy: rename in-flight requests to tasks
Date: Wed, 25 Mar 2020 16:46:34 +0300
Message-ID: <20200325134639.16337-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325134639.16337-1-vsementsov@virtuozzo.com>
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0085.eurprd02.prod.outlook.com
 (2603:10a6:208:154::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.35) by
 AM0PR02CA0085.eurprd02.prod.outlook.com (2603:10a6:208:154::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Wed, 25 Mar 2020 13:47:09 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 450e42df-d59c-473c-2995-08d7d0c3040c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5480847845904284334BB11DC1CE0@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(396003)(346002)(366004)(136003)(376002)(6512007)(478600001)(1076003)(69590400007)(6666004)(36756003)(2906002)(4326008)(6486002)(16526019)(81166006)(66556008)(6916009)(107886003)(66476007)(66946007)(26005)(86362001)(316002)(52116002)(186003)(956004)(2616005)(6506007)(8936002)(8676002)(81156014)(5660300002)(334744003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5480;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gncADpIz/1R/we3MSSpPZ8bR746MFv2S8FcFGI+8HnmAV/hSEKdbQNQddzckiOxvHJw5vKtRZYrlScQnNJDPJJOkHqgsE92EDLILnEqZ8b2wgDkCj64VY2P6lYtMZ+1NZAeohC0Q1WQusWcFxqYK0YLodoLlAzmhj2UudfDhPVOCQI/svHn+F2fRM9eF7ifnvQ8JnEMbpPZ5jWH0OntsaF4E1pfoBHwM52WWoTdx0Ts11zUkUkilrsThmxv9Q/W1IfhuEAg0k/KHo4hBrF+jUcxwypyY7DWBdyl0g+g+rjRkmTdhNg3LF8l8oBt0vPv29raaQkDitK32ZGkdJvn/1hLb5GegriPUimq36lIIOC2X1cwW3QPp4idhQHuudvpOu092B23ueNbrR74QjbU7M/9dOVcM9mqZnRO31gCnn6lNEsitnVIdYb5XD7nu01siNzgSF0z5EVl8VY9lH9WSoe7cb0GxSVFchip1GS4drOxQKzxZ5cJwDjqNWSEAmWYPKikRjr09cNdZ5wYAc2F8iw==
X-MS-Exchange-AntiSpam-MessageData: cymT5D9k4yvEmMQ2O5dToir1W/UO6uvO0xq8G+AjxWdFNNDb2TSSqrd83RCfQGoVJc8v30xehsRKQ8cNagSG8HymWJ9D/2cvLv4B86ivEAad8u8c7YuUKTnte/GfiukERKHdQhTzEgrZHhBohsf7vQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450e42df-d59c-473c-2995-08d7d0c3040c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:47:10.2405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dv4upIP6Q2BT0DPPTdoSpvKXCfecGeNmTl4fbiWv7ISMVllubb95hv+D5gc8D59ICsLdQuc04PxAi7fbifEjvYB0npwDguIPgcsaBMtTePE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.94
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to use aio-task-pool API and extend in-flight request
structure to be a successor of AioTask, so rename things appropriately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 99 +++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 50 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 05227e18bf..61d1d26991 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -24,12 +24,12 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
=20
-typedef struct BlockCopyInFlightReq {
+typedef struct BlockCopyTask {
     int64_t offset;
     int64_t bytes;
-    QLIST_ENTRY(BlockCopyInFlightReq) list;
-    CoQueue wait_queue; /* coroutines blocked on this request */
-} BlockCopyInFlightReq;
+    QLIST_ENTRY(BlockCopyTask) list;
+    CoQueue wait_queue; /* coroutines blocked on this task */
+} BlockCopyTask;
=20
 typedef struct BlockCopyState {
     /*
@@ -45,7 +45,7 @@ typedef struct BlockCopyState {
     bool use_copy_range;
     int64_t copy_size;
     uint64_t len;
-    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
+    QLIST_HEAD(, BlockCopyTask) tasks;
=20
     BdrvRequestFlags write_flags;
=20
@@ -73,15 +73,14 @@ typedef struct BlockCopyState {
     SharedResource *mem;
 } BlockCopyState;
=20
-static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState =
*s,
-                                                           int64_t offset,
-                                                           int64_t bytes)
+static BlockCopyTask *find_conflicting_task(BlockCopyState *s,
+                                            int64_t offset, int64_t bytes)
 {
-    BlockCopyInFlightReq *req;
+    BlockCopyTask *t;
=20
-    QLIST_FOREACH(req, &s->inflight_reqs, list) {
-        if (offset + bytes > req->offset && offset < req->offset + req->by=
tes) {
-            return req;
+    QLIST_FOREACH(t, &s->tasks, list) {
+        if (offset + bytes > t->offset && offset < t->offset + t->bytes) {
+            return t;
         }
     }
=20
@@ -89,73 +88,73 @@ static BlockCopyInFlightReq *find_conflicting_inflight_=
req(BlockCopyState *s,
 }
=20
 /*
- * If there are no intersecting requests return false. Otherwise, wait for=
 the
- * first found intersecting request to finish and return true.
+ * If there are no intersecting tasks return false. Otherwise, wait for th=
e
+ * first found intersecting tasks to finish and return true.
  */
 static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t of=
fset,
                                              int64_t bytes)
 {
-    BlockCopyInFlightReq *req =3D find_conflicting_inflight_req(s, offset,=
 bytes);
+    BlockCopyTask *task =3D find_conflicting_task(s, offset, bytes);
=20
-    if (!req) {
+    if (!task) {
         return false;
     }
=20
-    qemu_co_queue_wait(&req->wait_queue, NULL);
+    qemu_co_queue_wait(&task->wait_queue, NULL);
=20
     return true;
 }
=20
 /* Called only on full-dirty region */
-static void block_copy_inflight_req_begin(BlockCopyState *s,
-                                          BlockCopyInFlightReq *req,
-                                          int64_t offset, int64_t bytes)
+static void block_copy_task_begin(BlockCopyState *s, BlockCopyTask *task,
+                                  int64_t offset, int64_t bytes)
 {
-    assert(!find_conflicting_inflight_req(s, offset, bytes));
+    assert(!find_conflicting_task(s, offset, bytes));
=20
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
     s->in_flight_bytes +=3D bytes;
=20
-    req->offset =3D offset;
-    req->bytes =3D bytes;
-    qemu_co_queue_init(&req->wait_queue);
-    QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
+    task->offset =3D offset;
+    task->bytes =3D bytes;
+    qemu_co_queue_init(&task->wait_queue);
+    QLIST_INSERT_HEAD(&s->tasks, task, list);
 }
=20
 /*
- * block_copy_inflight_req_shrink
+ * block_copy_task_shrink
  *
- * Drop the tail of the request to be handled later. Set dirty bits back a=
nd
- * wake up all requests waiting for us (may be some of them are not inters=
ecting
- * with shrunk request)
+ * Drop the tail of the task to be handled later. Set dirty bits back and
+ * wake up all tasks waiting for us (may be some of them are not intersect=
ing
+ * with shrunk task)
  */
-static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *s,
-        BlockCopyInFlightReq *req, int64_t new_bytes)
+static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
+                                                BlockCopyTask *task,
+                                                int64_t new_bytes)
 {
-    if (new_bytes =3D=3D req->bytes) {
+    if (new_bytes =3D=3D task->bytes) {
         return;
     }
=20
-    assert(new_bytes > 0 && new_bytes < req->bytes);
+    assert(new_bytes > 0 && new_bytes < task->bytes);
=20
-    s->in_flight_bytes -=3D req->bytes - new_bytes;
+    s->in_flight_bytes -=3D task->bytes - new_bytes;
     bdrv_set_dirty_bitmap(s->copy_bitmap,
-                          req->offset + new_bytes, req->bytes - new_bytes)=
;
+                          task->offset + new_bytes, task->bytes - new_byte=
s);
+    s->in_flight_bytes -=3D task->bytes - new_bytes;
=20
-    req->bytes =3D new_bytes;
-    qemu_co_queue_restart_all(&req->wait_queue);
+    task->bytes =3D new_bytes;
+    qemu_co_queue_restart_all(&task->wait_queue);
 }
=20
-static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
-                                                     BlockCopyInFlightReq =
*req,
-                                                     int ret)
+static void coroutine_fn block_copy_task_end(BlockCopyState *s,
+                                             BlockCopyTask *task, int ret)
 {
-    s->in_flight_bytes -=3D req->bytes;
+    s->in_flight_bytes -=3D task->bytes;
     if (ret < 0) {
-        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
+        bdrv_set_dirty_bitmap(s->copy_bitmap, task->offset, task->bytes);
     }
-    QLIST_REMOVE(req, list);
-    qemu_co_queue_restart_all(&req->wait_queue);
+    QLIST_REMOVE(task, list);
+    qemu_co_queue_restart_all(&task->wait_queue);
 }
=20
 void block_copy_state_free(BlockCopyState *s)
@@ -223,7 +222,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source,=
 BdrvChild *target,
         s->copy_size =3D MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
     }
=20
-    QLIST_INIT(&s->inflight_reqs);
+    QLIST_INIT(&s->tasks);
=20
     return s;
 }
@@ -474,7 +473,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
=20
     while (bytes) {
-        BlockCopyInFlightReq req;
+        BlockCopyTask task;
         int64_t next_zero, cur_bytes, status_bytes;
=20
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -495,14 +494,14 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
             assert(next_zero < offset + cur_bytes); /* no need to do MIN()=
 */
             cur_bytes =3D next_zero - offset;
         }
-        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
+        block_copy_task_begin(s, &task, offset, cur_bytes);
=20
         ret =3D block_copy_block_status(s, offset, cur_bytes, &status_byte=
s);
         assert(ret >=3D 0); /* never fail */
         cur_bytes =3D MIN(cur_bytes, status_bytes);
-        block_copy_inflight_req_shrink(s, &req, cur_bytes);
+        block_copy_task_shrink(s, &task, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_inflight_req_end(s, &req, 0);
+            block_copy_task_end(s, &task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -518,7 +517,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
         ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_=
ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_inflight_req_end(s, &req, ret);
+        block_copy_task_end(s, &task, ret);
         if (ret < 0) {
             return ret;
         }
--=20
2.21.0


