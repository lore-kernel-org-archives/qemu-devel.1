Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D44C83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650652083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QvEIbzak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650652083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfxU-0007oH-FG
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfw8-0005at-6M
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfw7-00026k-H8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:11 -0400
Received: from mail-db8eur05on2137.outbound.protection.outlook.com
 ([40.107.20.137]:43808 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTfw5-00023u-2Q; Wed, 29 Apr 2020 02:11:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK31tIKvNWkZyhZRqP3lwVkYPvxypodMKNPGmyXuXoTsu7P3GpXplhxHt2Mefwi+sPOFIDEp1t60A/bzQk8zAegRy97NPs8haJLeKSQU4hHwvHe1By8wp3XAaWCNkIQQ22xdEptdGJsiohetrceqRw/jn0MsdMtvIFvJOy4NWMPoFqFraMfm9PhR6j9HupDwSTjsZQbyxkd81lEEwHsFshvm5tt6E5PFeR2FTkyqguQR/hy0Y9HBpXCm5ex5P1wawGNQ7V08wxSoljh75tgjBz4OmJ8PNkaFX2RIONPz6u6oKVmKdGBV726IucXoE+IHgMLsdpCzVfuCQeYaOonaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qezvwwFTEgotZqdewgCAh9NUdboi37YOb9djMus6cSs=;
 b=m9pdRK2HJMSb9FM3nBJU19VSReGD7Fu4+RchfrZiuBYU7Bk4bjm9ilSbxDhKplLeyckvviJlZ7v1RVUSEuQLOVAOPV9dZaGHpj1zr02iMghTkIOiY3+3laUEe/0P6Ap5gJ0tyspeYmaADfQtwTwYiGbfMxIcYdE9z0NK+waKwQtpAKHbtCYSw+PyHnfE0eL4IGXGhsjb5nLHro2gNrB+FYkhTAjunbWXNgIioVIUmug4yGfw3VNP7vvUrJh96x2p0m/dPsGjQUNjPkMixaNgMBMEbthh81ohd2vMyQHCwyZI0vnbN4pXr9nsvZhtVeIcus6F8j2EHV7lgLFVYZsoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qezvwwFTEgotZqdewgCAh9NUdboi37YOb9djMus6cSs=;
 b=QvEIbzak83Lnltzj306aGemITqqlaZ/4oYfBDy7pUwzr6ijC7aEuA8Ne6ucBhifiNRRkIjubA0pGStzCWscx4UHIe0IMZzxm5/I4D9UMj3NcX4aE1ZwJ/aaGEQPr8qWbMsXOZbLd+Jz4yE0qnIfcXx9oVVN8Lj9xqSBuRxH+mXc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 06:11:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 06:11:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 1/5] block/block-copy: rename in-flight requests to tasks
Date: Wed, 29 Apr 2020 09:10:35 +0300
Message-Id: <20200429061039.12687-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200429061039.12687-1-vsementsov@virtuozzo.com>
References: <20200429061039.12687-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.184) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 06:11:05 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c15a9b4-7c7c-4b9e-df36-08d7ec0419d5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53823DD0704E467BB171344BC1AD0@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39830400003)(396003)(26005)(5660300002)(16526019)(36756003)(316002)(86362001)(6486002)(956004)(6666004)(107886003)(8676002)(1076003)(2616005)(8936002)(186003)(4326008)(6506007)(69590400007)(52116002)(2906002)(478600001)(66946007)(66476007)(6512007)(66556008)(6916009)(334744003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3p48O/l3NldSve6vtPgi9ymOooPb9PTX1XouCl7FW8zWsE+xBO/qcZ6535T2d4PThrgCMkNUGgqZd+Me2SmXshpfN7b4Ta6Rf0NUFHXZ9oZW4UwQ3q+Oe6TCtpj6Va600lSkRvnTIN0qFg3dXmEpwCX91s4QdlJn2c0+F5zAM6CMi8zgG8BqkCo2kwKG+DyVK+tW0OX4EbypDd9uR18ViGr1d2aB+irMTb9T2DzlHmVTisSwj4dAnB44H0wKuSsdJNssTJmVsel9ARjJNM562W5SJSdPz8gm4O0u0ZFyCbVqmYAybcIRnVFLrc6fE8CCALcty4p3UQKfYBFMv4H+kXKHCAe1nClOv9ZKxIlNDKvimshuVNTiunDgLh/MibevRFk5ZdIoX7j+H2h4Ln1Ju7jxl1q9tLlNHzYFzaS3X3xZ9HZRjGPI0UryI/bZKrZ/tnkn4R6vjkR0L8caiyH+6EQy2QgzIuKFB5U4TMsnzuHKD0tH6egVtMtEyOusBQ1EkpeBoK7ETou2A+lg/lOgQ==
X-MS-Exchange-AntiSpam-MessageData: yccjeH4vc+/1rvX65Uyo5SqNTArj0fSVYkuApQgtIj9j6CGgfIl+vIntBYe6VjuFNJw7sDyyvHqovgPX6gyQtnPeM2h5KWLibolszJcpvvKI6njRQPLalOyAX7yVSVk7izcCU9MBpenjpVCaoCgIGrrSlr6ntGvDUlAm/wjiDCoEkesBkEAN+dovk1oJOi+FuPUE4S/uYaM+HfIrG4vKl+0LiU43rj5WvcbXfjG6PequT504/rEASpC+xZWSpwOZeaSSzAzC0BLooKwUKKaHxG/HNQO4GVnJnoDCll+ofy/aXh2qwo0vgiD+6kYj280dmsu2Oj8hsvfZ4ggNgdhN1QvbDGhbSG8zng8Bt6A7ZpBrSxz3A+PDrztkw7nuzFOjfP2If2V6+7ezduJyDkzl0jqcXb0zHJmJfWCu6aRFSUYj+DHJgt7lGz1y74+rllB2UPuaDXYXy7Hm5yuICB2PtDpd4yHdAiT0xOYkMciM1pIg+mcXLDgruBzoIztduF+a9KRXBs10D3N0wvV7aBOWRL3Ywu3DqxdoBiUwRCE1CWEztFiYhBJvPpmIS1oKNobjsbXNeoBIh6AmtIFIJdl9KGSGqn0vw8DOIB1sPMY6zv+WeRrAcWlQsBiO5rNSI2dEEo6Q5Jfrky10WT6zkK2Uk7vKONZ8yaLuQpV3e53+SaNa+HJNVUnF/fw+7VpqGqoMSQjAZtlpc+jcXqSu7d+shOdN1zRz64JeswGkMBOqF6p/D4BWM1CVNfl/3TQ/LhVzbPAnGnl5bfON+B41mNfM03htqQ/X0ij5RDHcRJEMJNA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c15a9b4-7c7c-4b9e-df36-08d7ec0419d5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 06:11:05.5427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6VaR8Zp2vwzk5gV4qk/cMh3H/ej3AmLO3w8JuLPdqLnS8lcZ/wvBhOthrl/BLi3NgpBCwYLJivSiXvyAVB4PgPXaPf/JoOyrovE7qJCmM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.20.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:11:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.137
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


