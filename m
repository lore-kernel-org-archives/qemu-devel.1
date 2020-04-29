Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B3AC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1782082E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R44ChJfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1782082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfxU-0007nT-6x
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfwB-0005hR-DX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfwA-0002De-NB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:15 -0400
Received: from mail-vi1eur05on2121.outbound.protection.outlook.com
 ([40.107.21.121]:61758 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTfw8-000240-Gr; Wed, 29 Apr 2020 02:11:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZgjAy+SdvgfVknH9zvnF7nLY7FeyDyaz3j03SxS4KEtCGuuAkaZ6W2KVPtxzDFhwyBImw5SPRdsLRZ1dzzjautJHltj3FsGi4Oi2qijsl7axFu7tOvVyGWMF2zKTJTJfL6inN/Qmzsbujua18QW4xy4wMtMwQ75DpSb/n8lCisRxjzxef2ElNv5FU6e6gj6uGWY/5Xtnao1LRvKObA3GkEry5oFY685E/AEdVi3eXGJdbUSI88gMIrfL2YGJudyewxpszCat236NzrRwN+QvN3oMFp7Z4tUmS3p4PO5PBamMr23dgXNaOjBkBVRUjGoSTVFhx+a43WP9csveKgGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5D696Yi8Wv5VGGI7YednpN3hUbTU8uj/t9xqrnlOeo=;
 b=X/o+HOGg6zgWRlaBfJkVZ8++xt4QL/FXMW36pbYNb7IeLoR3jCx5cjqB9c6dfsIhzXCldCCSAj9tZDBumi3pznPYO9e0jvIyROjHoHxYSyESWVFfs0qvyNllL6GFm90OY89sVpBfSP7Snw2m95Fw3/ktcnsl1lsxBpiIc1au7QtU+bxDhhSW85WLpybxmdS3tSQSyymvmp0yict8wlT4qPhU04gWIYIMg0R/hiJqfJs12vE+JAZLWGryQg4yM5bmOrQkX8EwQpCrKdhFzGcWQcv5dPwlZFWVWm/g+u88bqnjjSvXkJ7caZBpHLzovTJtawgz0YpMmXSJSAKrc1ShcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5D696Yi8Wv5VGGI7YednpN3hUbTU8uj/t9xqrnlOeo=;
 b=R44ChJfu0yd/wWOrAORwIkoV9Cg/YfvAX+KHQI+/2b+TARH7aOlRc+7GH49uybDNqO04RA9uwJfwvoLgdcKEQCrP1abyX3nBSgKDKqch+96b2gsBsCROx1OqBRDbkNclq6Xp8HuUbWu7qHgzWdU25uXK/9A+V7eKtdGtWTRSkc8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5301.eurprd08.prod.outlook.com (2603:10a6:20b:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 06:11:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 06:11:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 5/5] block/block-copy: use aio-task-pool API
Date: Wed, 29 Apr 2020 09:10:39 +0300
Message-Id: <20200429061039.12687-6-vsementsov@virtuozzo.com>
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
 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 06:11:08 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34a1f54e-833a-4a14-c62e-08d7ec041bb0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5301535EE48E4A41DDCADCD3C1AD0@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlqacPEPxclUycu6RZDW4xP1ZMvrtbzj6vC2lT3dk3Z11UvXg/K/yqgZVbt7fhyKYd0SKuYaaSRHrJoXzJSB4Asbwp7IK/PoTV/dUrnyHpmQb4buO0NTCTwWAvOQUESuwGs7VP6L8sDs/9LcpaebPG0arMEeDreklhDo0/fV5J7cbay7dLx/MTul7jn5ffxhmLg9K28LPU/g1twR/8mCZfDX9gAL2uXi7MWhwa0wWXrtxBNP4NJjg8t2VqHkrZNpnli2VvU9Kux+tEJ2MiJqUzRDs6dsnHgiv/on+DJOCI/F7AEiTbVa53f3PW25RueVrIO5dfmKZQHN4naiwF2C+LA0RH8VW11SEV2bkjAGUWQNI3usfh/Xr2U4SMSDItvJsJlLej+b0cuc8nrQnadcUJLKVENgmtUPKRU7CZkjdUJ29noAvY1QahMUQgU8c79EnURl7ppkXtoobjuYdbAn20DMGKDK9PbKsnPj5ZtsJtyNJ4rlOOu8RrJKbGhWb5nW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39830400003)(136003)(376002)(396003)(366004)(2906002)(1076003)(86362001)(36756003)(186003)(16526019)(26005)(956004)(4326008)(52116002)(5660300002)(6506007)(69590400007)(107886003)(6512007)(6486002)(2616005)(6666004)(478600001)(316002)(6916009)(8676002)(66556008)(66476007)(8936002)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4ZkntWOoBAoKoEMyInZsnTmWOZzcHK0dnZUSLXTOFq1Ho+H6wTKnrMIx6lsTonWTJMxzNy5tGJwfd7EAUCYtG2ra52t0SkEHOgCnofC8z74zHhoSf4Z28QWtRJRz5hHNAojVrM5fS0SG1Oy/d95XBePZrZoPJZywjz4clWv2HmxPxcL2gyMLKAHi0FKHNe+PhkMZNvwi7tSszfNalrzZIg6duhTA8qRsF1T5Ru07zBN3J4DqdBl9aQHpVGtC6CeXGH7YcQvHsUKWtcJZy41HA99hXTS1jefWLCoV3RUJddYR1YFdqF3zEtHrR50guvKw6bs1XL4klxf6e89AHi5lwmqFUIQFUI/jogrMWa8hokf2V2OcyFmKGEHOHFCGykAqvBnr1NczMN/qlcscNcib4Kb2iPtNKU5DaWxW2wwG5LX6OuGLWkM5UtQc7v/wkAY3JsaL83dvhMmiU3F8Lpf16DvjniSjLt1xNaZ6YLuqsMoE+khJqOVNZGx4uc7HHvN3QNNWB6qrKT6LQXfjX1o9W5PxzbdNcVonOt9q/XKIql1XnrBb0UA0UzC4TuwYbXIm0+jxUgYSsPzmTBhQkqDzM5jm/9c5sZizxcIcwSM3Z8VswfLyTGdbafsc0+ZeMZudp/j8j/bwyJvT3Qb921IiZUq2sH1W5I2z1Lz3AGRD6QaMh5mtBJZ8yqrbXv9bIvKwDaG3Pusa6sueQ0p6dggpyPCQtg+0Em3Ywmzmwelb1BvGgfXAOkUD6rAJqHsA63oFtQlnLZq25TU9SmCuToUl4MtjrfuNd+PXavcvhdFKAhs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a1f54e-833a-4a14-c62e-08d7ec041bb0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 06:11:08.6262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4ILRAQ+LhatvXEfDJrBBkScPMEZg1fsW/z7vb92yb4K28sO7ZDlLEnt88BaO7sFX1FZaF8/cKPUwxE9LjznTXhZ7tsAaBYUo2PxdQHYi1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
Received-SPF: pass client-ip=40.107.21.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:11:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.121
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

Run block_copy iterations in parallel in aio tasks.

Changes:
  - BlockCopyTask becomes aio task structure. Add zeroes field to pass
    it to block_copy_do_copy
  - add call state - it's a state of one call of block_copy(), shared
    between parallel tasks. For now used only to keep information about
    first error: is it read or not.
  - convert block_copy_dirty_clusters to aio-task loop.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 104 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 5cf032c4d8..f5ef91f292 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -19,15 +19,29 @@
 #include "block/block-copy.h"
 #include "sysemu/block-backend.h"
 #include "qemu/units.h"
+#include "qemu/coroutine.h"
+#include "block/aio_task.h"
 
 #define BLOCK_COPY_MAX_COPY_RANGE (16 * MiB)
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
+#define BLOCK_COPY_MAX_WORKERS 64
+
+static coroutine_fn int block_copy_task_entry(AioTask *task);
+
+typedef struct BlockCopyCallState {
+    bool failed;
+    bool error_is_read;
+} BlockCopyCallState;
 
 typedef struct BlockCopyTask {
+    AioTask task;
+
     BlockCopyState *s;
+    BlockCopyCallState *call_state;
     int64_t offset;
     int64_t bytes;
+    bool zeroes;
     QLIST_ENTRY(BlockCopyTask) list;
     CoQueue wait_queue; /* coroutines blocked on this task */
 } BlockCopyTask;
@@ -116,6 +130,7 @@ static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t offset,
  * the beginning of it.
  */
 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
+                                             BlockCopyCallState *call_state,
                                              int64_t offset, int64_t bytes)
 {
     if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
@@ -133,7 +148,9 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
 
     BlockCopyTask *task = g_new(BlockCopyTask, 1);
     *task = (BlockCopyTask) {
+        .task.func = block_copy_task_entry,
         .s = s,
+        .call_state = call_state,
         .offset = offset,
         .bytes = bytes,
     };
@@ -261,6 +278,30 @@ void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
     s->progress = pm;
 }
 
+/* Takes ownership on @task */
+static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
+                                            BlockCopyTask *task)
+{
+    if (!pool) {
+        int ret = task->task.func(&task->task);
+
+        g_free(task);
+        return ret;
+    }
+
+    aio_task_pool_wait_slot(pool);
+    if (aio_task_pool_status(pool) < 0) {
+        co_put_to_shres(task->s->mem, task->bytes);
+        block_copy_task_end(task, -EAGAIN);
+        g_free(task);
+        return aio_task_pool_status(pool);
+    }
+
+    aio_task_pool_start_task(pool, &task->task);
+
+    return 0;
+}
+
 /*
  * block_copy_do_copy
  *
@@ -364,6 +405,27 @@ out:
     return ret;
 }
 
+static coroutine_fn int block_copy_task_entry(AioTask *task)
+{
+    BlockCopyTask *t = container_of(task, BlockCopyTask, task);
+    bool error_is_read;
+    int ret;
+
+    ret = block_copy_do_copy(t->s, t->offset, t->bytes, t->zeroes,
+                             &error_is_read);
+    if (ret < 0 && !t->call_state->failed) {
+        t->call_state->failed = true;
+        t->call_state->error_is_read = error_is_read;
+    } else {
+        progress_work_done(t->s->progress, t->bytes);
+        t->s->progress_bytes_callback(t->bytes, t->s->progress_opaque);
+    }
+    co_put_to_shres(t->s->mem, t->bytes);
+    block_copy_task_end(t, ret);
+
+    return ret;
+}
+
 static int block_copy_block_status(BlockCopyState *s, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
@@ -482,6 +544,8 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
     int ret = 0;
     bool found_dirty = false;
     int64_t end = offset + bytes;
+    AioTaskPool *aio = NULL;
+    BlockCopyCallState call_state = {false, false};
 
     /*
      * block_copy() user is responsible for keeping source and target in same
@@ -493,11 +557,11 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
-    while (bytes) {
-        g_autofree BlockCopyTask *task = NULL;
+    while (bytes && aio_task_pool_status(aio) == 0) {
+        BlockCopyTask *task;
         int64_t status_bytes;
 
-        task = block_copy_task_create(s, offset, bytes);
+        task = block_copy_task_create(s, &call_state, offset, bytes);
         if (!task) {
             /* No more dirty bits in the bitmap */
             trace_block_copy_skip_range(s, offset, bytes);
@@ -517,6 +581,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         }
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
+            g_free(task);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -525,25 +590,38 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
             bytes = end - offset;
             continue;
         }
+        task->zeroes = ret & BDRV_BLOCK_ZERO;
 
         trace_block_copy_process(s, task->offset);
 
         co_get_from_shres(s->mem, task->bytes);
-        ret = block_copy_do_copy(s, task->offset, task->bytes,
-                                 ret & BDRV_BLOCK_ZERO, error_is_read);
-        co_put_to_shres(s->mem, task->bytes);
-        block_copy_task_end(task, ret);
-        if (ret < 0) {
-            return ret;
-        }
 
-        progress_work_done(s->progress, task->bytes);
-        s->progress_bytes_callback(task->bytes, s->progress_opaque);
         offset = task_end(task);
         bytes = end - offset;
+
+        if (!aio && bytes) {
+            aio = aio_task_pool_new(BLOCK_COPY_MAX_WORKERS);
+        }
+
+        ret = block_copy_task_run(aio, task);
+        if (ret < 0) {
+            goto out;
+        }
+    }
+
+out:
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+        if (ret == 0) {
+            ret = aio_task_pool_status(aio);
+        }
+        g_free(aio);
+    }
+    if (error_is_read && ret < 0) {
+        *error_is_read = call_state.error_is_read;
     }
 
-    return found_dirty;
+    return ret < 0 ? ret : found_dirty;
 }
 
 /*
-- 
2.21.0


