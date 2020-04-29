Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051ADC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B4D2184D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qPSQWEgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B4D2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmWl-0002HJ-Rd
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmV7-0007wi-U4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmUz-000856-Nm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:45 -0400
Received: from mail-eopbgr80118.outbound.protection.outlook.com
 ([40.107.8.118]:18917 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTmSl-0007bZ-5z; Wed, 29 Apr 2020 09:09:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg/RfQQGADZFpnrUdCQ76VDlmjxpmS54qYgTky5fCLVTdQlstlVCPui15227zRqMuaxgsa7Yya+bkQb5isjefPMqhDt68U/l6/ThBUDTsSMkz7J1Yqwer3o7VrTxVA0DZ809PqdgVrCS1BtaoshHZ7Yfs7jbuRmWsLhwKn53xuM9W07K9NByFIkYKSSJOjmhBAaxiUCeYnUq6ayS3dCuMxL9w1n28DQ+YOTVolVoZTa/gwXlPf9PZOV9Yv040i41gS0cgiMddRzDqT3/oU8kK58DjuuuBlvduqvZzSGpG8S41JhxeDAI7/2rP1f6PFz9cNDEMyKQWl1GkLzMLl5xGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln4J+gXgYopBJjdwMRlDdnwd0zyUvPHCA7EC1VSZv4A=;
 b=AZ1bW8khu5js54fwEw1Pmj7kq4rezTmvtvDCh9//tKmNBqvOGsotATb2Fm9oXQMqlLykQBSNfSaNwJ/xzD/auWf/iWr0v8AFSaM7xBG7448Mptnw5qUIe+inHE2VqRENN7yc/bw0eC+qJhIuDXyC/A+RPEOWcnZ4+4ZPYdXYK1l/2l70QxzFIUvBBM9j0tz0kM4tjjIxkQ4dCLzSSYMC5WS4ZyAzzROLyGhz3+zyTH9t67hT1UsJcORwTnNSP0wcpxSfaZlv9FZ9l15FLfIMy0rrP4/lxVWYlFs1K6iRD0uEF7eM7jFndyS2nV2RQXf4eq5wR9sYHK2bfggGGNM6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln4J+gXgYopBJjdwMRlDdnwd0zyUvPHCA7EC1VSZv4A=;
 b=qPSQWEgKxrUByXvo1DgJM41BUw0YYPTFtQ49a5Kxg5B9oAKbzts1Y+f4WdvLaQmIlnngTmkjpjuEpL14HnNon5Qsz3iqJy/z49KJFjFs3U3w9DA0Y+07dcWhysbHOALLWxleSmJabl/e7UKhGVNKyfk0UyT6IQk+Hcp7denKmyo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5446.eurprd08.prod.outlook.com (2603:10a6:20b:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 13:09:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 13:09:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 1/5] block/block-copy: rename in-flight requests to tasks
Date: Wed, 29 Apr 2020 16:08:43 +0300
Message-Id: <20200429130847.28124-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200429130847.28124-1-vsementsov@virtuozzo.com>
References: <20200429130847.28124-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:208:122::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.184) by
 AM0PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:208:122::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Wed, 29 Apr 2020 13:09:14 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a86e1e9-bda0-47cb-f04b-08d7ec3e8434
X-MS-TrafficTypeDiagnostic: AM7PR08MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5446B015C4D1F22D6CBFCFB0C1AD0@AM7PR08MB5446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(8936002)(16526019)(2616005)(107886003)(6512007)(66946007)(66556008)(66476007)(316002)(36756003)(6486002)(52116002)(5660300002)(186003)(6506007)(26005)(4326008)(956004)(1076003)(69590400007)(478600001)(6666004)(86362001)(2906002)(6916009)(8676002)(334744003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJv9zj73vA8sBV0w2lTuOJFaozCoTrSiKiEOVOvoe3aDkOYFoEo/2ZtPlrgvSDA2PiD1pM+hHyMT+AAIUMew8+1K9FxuQ/V3aIJ+kPcwwxyMSxR+dfw6Q4u56gPYPrgGHgJWeiibSuvSE+avWP+TYuVemF+/eyEKWmm1Pvn/sJXmdH/VUuFnVX5lbvdMcNK1QGF0C+xwqCc8pEE6pNjVg9WROL2xiIzgvpOoFl0PKNchk3ppBZCC+cewPPosjNIKStkBLFnJe4j150dtBSfftQ0sTRmDPodghylzw5OAZW13YP7jjPMfYky+e7EhSugiKQ7e8DI/XnX7UEO4ez1qlCSj5nHvo+OO1myv1dwgGo9PPgCnZDaRIbVBLWBn09pPJb/YAP1f1VpVbofkBu/dwPehgXchmVMvDINS0YiIAYe1spUKUUu1Jzoq5f3qmAgNtKrA3DcncKF2be2SzA73/JE1PxhKD9pxx654GqYu8T0GLC6SiU5QWt80aeJwnl9YhCq1JO6IkhRZT4jKRib8IA==
X-MS-Exchange-AntiSpam-MessageData: +OgWoYx522ExxDaJCvLVldO0xBA8urvKJ+2smOWA5XoPyN/Lt7cw3EcQk63H8X6S63+Zqp85LYnNIPHtui/3gqUMHV6Y+vC0jEp5arS9E36iSTtyVTHrJI3UrthCkAw+eHBNZ8OhG1C/t22cQPX5at7lt7NmCQS9Ile1EIbD3VrTWlqOTowEFn1zURbThtGYbTHLwmnXLJpTenEBycuLTIuN3m27IOAFf8Kl3dv1IxMimhJFKvYCKMfoSfHNUE4ow5Uxxl+MQOhWaAIfzBEG5x703FNO7rkezjYEzkbjWh5pmmuL1FwbrqSR3lCG5OW/yWLKzSzAF3jLjmUe1eBuGQUZJOf+ErMSDtyjF6UH/U9VPqSv1z4wZ+GlJxkVIB/vlvph74SE3rcJ3DNWpiwYKLSuCh8WOvGPoUUC+AAjPRD6KI8PFNth4sjkBIZpH9tgox+2MZRcBzB0MOr4fgjXC23U5NobW9H6bTysMcJpLH5SxKnGtjfFcYfElsEcOvS/yz54wVipiK2x7NwAsKjmIrVBAAK042jF94UUdXv3sJ7KonLbFNQhjKZZX5QWQZXim1u7AVHqPrp7JU7UE+OW3ecPPal5Ho1Jx9l7ng8FT2yuISIU7wv+note5To7s8gyp/pPrza/fYQpWhTz5wW1H8eiGP9KREpvHqltS1N38Ct+Y8JzmLic+gUFNmorxKeZVTVqMYEKAOLT95nBKJVn8K9g3gYN+XE+Q0xskD6aO0i/XDukpp67Id74GUdc9YXgnz952O5G93b4VAPN0EwGrscS80k+aWBxktBbl5MHpDk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a86e1e9-bda0-47cb-f04b-08d7ec3e8434
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 13:09:14.8235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UXx2O8bKsTrCKiPznLailH0HERgI0+rQlDExTXyez9fX7oIilJR7xHWFW6upOm5J+3k/k8FRxqO/QPy5i7PFTJP9KE/co/RL3c8v/Joc7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5446
Received-SPF: pass client-ip=40.107.8.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 09:09:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.118
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 98 +++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 05227e18bf..bbb29366dc 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -24,12 +24,12 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 
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
 
 typedef struct BlockCopyState {
     /*
@@ -45,7 +45,7 @@ typedef struct BlockCopyState {
     bool use_copy_range;
     int64_t copy_size;
     uint64_t len;
-    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
+    QLIST_HEAD(, BlockCopyTask) tasks;
 
     BdrvRequestFlags write_flags;
 
@@ -73,15 +73,14 @@ typedef struct BlockCopyState {
     SharedResource *mem;
 } BlockCopyState;
 
-static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState *s,
-                                                           int64_t offset,
-                                                           int64_t bytes)
+static BlockCopyTask *find_conflicting_task(BlockCopyState *s,
+                                            int64_t offset, int64_t bytes)
 {
-    BlockCopyInFlightReq *req;
+    BlockCopyTask *t;
 
-    QLIST_FOREACH(req, &s->inflight_reqs, list) {
-        if (offset + bytes > req->offset && offset < req->offset + req->bytes) {
-            return req;
+    QLIST_FOREACH(t, &s->tasks, list) {
+        if (offset + bytes > t->offset && offset < t->offset + t->bytes) {
+            return t;
         }
     }
 
@@ -89,73 +88,72 @@ static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState *s,
 }
 
 /*
- * If there are no intersecting requests return false. Otherwise, wait for the
- * first found intersecting request to finish and return true.
+ * If there are no intersecting tasks return false. Otherwise, wait for the
+ * first found intersecting tasks to finish and return true.
  */
 static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t offset,
                                              int64_t bytes)
 {
-    BlockCopyInFlightReq *req = find_conflicting_inflight_req(s, offset, bytes);
+    BlockCopyTask *task = find_conflicting_task(s, offset, bytes);
 
-    if (!req) {
+    if (!task) {
         return false;
     }
 
-    qemu_co_queue_wait(&req->wait_queue, NULL);
+    qemu_co_queue_wait(&task->wait_queue, NULL);
 
     return true;
 }
 
 /* Called only on full-dirty region */
-static void block_copy_inflight_req_begin(BlockCopyState *s,
-                                          BlockCopyInFlightReq *req,
-                                          int64_t offset, int64_t bytes)
+static void block_copy_task_begin(BlockCopyState *s, BlockCopyTask *task,
+                                  int64_t offset, int64_t bytes)
 {
-    assert(!find_conflicting_inflight_req(s, offset, bytes));
+    assert(!find_conflicting_task(s, offset, bytes));
 
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
     s->in_flight_bytes += bytes;
 
-    req->offset = offset;
-    req->bytes = bytes;
-    qemu_co_queue_init(&req->wait_queue);
-    QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
+    task->offset = offset;
+    task->bytes = bytes;
+    qemu_co_queue_init(&task->wait_queue);
+    QLIST_INSERT_HEAD(&s->tasks, task, list);
 }
 
 /*
- * block_copy_inflight_req_shrink
+ * block_copy_task_shrink
  *
- * Drop the tail of the request to be handled later. Set dirty bits back and
- * wake up all requests waiting for us (may be some of them are not intersecting
- * with shrunk request)
+ * Drop the tail of the task to be handled later. Set dirty bits back and
+ * wake up all tasks waiting for us (may be some of them are not intersecting
+ * with shrunk task)
  */
-static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *s,
-        BlockCopyInFlightReq *req, int64_t new_bytes)
+static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
+                                                BlockCopyTask *task,
+                                                int64_t new_bytes)
 {
-    if (new_bytes == req->bytes) {
+    if (new_bytes == task->bytes) {
         return;
     }
 
-    assert(new_bytes > 0 && new_bytes < req->bytes);
+    assert(new_bytes > 0 && new_bytes < task->bytes);
 
-    s->in_flight_bytes -= req->bytes - new_bytes;
+    s->in_flight_bytes -= task->bytes - new_bytes;
     bdrv_set_dirty_bitmap(s->copy_bitmap,
-                          req->offset + new_bytes, req->bytes - new_bytes);
+                          task->offset + new_bytes, task->bytes - new_bytes);
 
-    req->bytes = new_bytes;
-    qemu_co_queue_restart_all(&req->wait_queue);
+    task->bytes = new_bytes;
+    qemu_co_queue_restart_all(&task->wait_queue);
 }
 
-static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
-                                                     BlockCopyInFlightReq *req,
-                                                     int ret)
+static void coroutine_fn block_copy_task_end(BlockCopyState *s,
+                                             BlockCopyTask *task, int ret)
 {
-    s->in_flight_bytes -= req->bytes;
+    s->in_flight_bytes -= task->bytes;
     if (ret < 0) {
-        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
+        bdrv_set_dirty_bitmap(s->copy_bitmap, task->offset, task->bytes);
     }
-    QLIST_REMOVE(req, list);
-    qemu_co_queue_restart_all(&req->wait_queue);
+    QLIST_REMOVE(task, list);
+    qemu_co_queue_restart_all(&task->wait_queue);
 }
 
 void block_copy_state_free(BlockCopyState *s)
@@ -223,7 +221,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
         s->copy_size = MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
     }
 
-    QLIST_INIT(&s->inflight_reqs);
+    QLIST_INIT(&s->tasks);
 
     return s;
 }
@@ -474,7 +472,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
     while (bytes) {
-        BlockCopyInFlightReq req;
+        BlockCopyTask task;
         int64_t next_zero, cur_bytes, status_bytes;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -495,14 +493,14 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
             assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
             cur_bytes = next_zero - offset;
         }
-        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
+        block_copy_task_begin(s, &task, offset, cur_bytes);
 
         ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
         assert(ret >= 0); /* never fail */
         cur_bytes = MIN(cur_bytes, status_bytes);
-        block_copy_inflight_req_shrink(s, &req, cur_bytes);
+        block_copy_task_shrink(s, &task, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_inflight_req_end(s, &req, 0);
+            block_copy_task_end(s, &task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -518,7 +516,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_inflight_req_end(s, &req, ret);
+        block_copy_task_end(s, &task, ret);
         if (ret < 0) {
             return ret;
         }
-- 
2.21.0


