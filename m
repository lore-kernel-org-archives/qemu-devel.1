Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F223C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA92921974
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fsB8QxoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA92921974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmY8-0004xQ-Uy
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmV9-000813-SF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmV1-00085a-DL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:47 -0400
Received: from mail-eopbgr80118.outbound.protection.outlook.com
 ([40.107.8.118]:18917 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTmSo-0007bZ-6u; Wed, 29 Apr 2020 09:09:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX5etUp9JqAE/BTofr7QWltG9fbDasmUw59bwPGt7S2Usvkl3kMVyXgNJlrvPXdjgBOEmxY+YPiT2PY6+16PqryEezBAbLxSZ+kPfyz0+f+gkekk/HEN8NNZWmQbp/hVBLhAETWlCRf4dAMOij6VfJ95q0iNKyjoPJeE3xRiH2wVn3n/RoCr7WKoKzCn0D3PH0giRcL1Zs0cRAhSF0+3zpJmvLYw7sbuRilDgsUK2mMBayBo91SnPAZfbgJv7c9OyeE2SHJfo3U08JF1HU3+JZhXUheI3ClLKBGBDs4fzBCTWC12AJRW+6ZOP7R0a7uVc+tVd05ZvOGVi+5Fi4Vaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw89ul5DChI1jdaCSD5v/qnlhmxpIx9EKk3XxHDGSvo=;
 b=a1MsAe0gJI4KWID0jgdBT5CXrMcb69AAoNFZihsxaww0BkU2MiQBca+eeSfK5XpPuGdlRLCxaE7WbaWQL3knMNI+RgQr0Vr2gTQuZDcoihPj0CvO/msI3zHmei4ZiErAXPLNLjxS7Thre21X2MpKwdfLFEXGI3aX8eUSkYON20K0Z8Eqb3CG51knkEzR5fZJOPkc8sph+z7GPnPaqhwR8a1cVc9l2655mG+Jmqsj/AGCTQB9FnCX3/cOpT3XjcavUcGJvd/1x5tPiflAmlu27YBh0JDtI3aQlZaHbzXYQQnDYtUkSVWUIUITKfUu+8pjB4FG5aOzOOvWOV6ptdUeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw89ul5DChI1jdaCSD5v/qnlhmxpIx9EKk3XxHDGSvo=;
 b=fsB8QxoNwVoFTVAH4hmYRJcFdHiZZgbpInrFQ63yHrQ9VqBAZ2OiBJ5QwR7owXwr/zypHzB67BEcwZwK6wqoo2qJJZIbfmpfRHLvSFpsJ5RxOczHAUBpSR7hbifgdabJ7tAabHHX2zNbDkMMx9omaDs7+cPT74Uef5mkx7qbYvI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5446.eurprd08.prod.outlook.com (2603:10a6:20b:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 13:09:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 13:09:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 4/5] block/block-copy: refactor task creation
Date: Wed, 29 Apr 2020 16:08:46 +0300
Message-Id: <20200429130847.28124-5-vsementsov@virtuozzo.com>
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
 Transport; Wed, 29 Apr 2020 13:09:16 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9df23ff8-1f26-48cc-56a4-08d7ec3e8575
X-MS-TrafficTypeDiagnostic: AM7PR08MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5446C735659D689670CD1FF8C1AD0@AM7PR08MB5446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(8936002)(16526019)(2616005)(107886003)(6512007)(66946007)(66556008)(66476007)(316002)(36756003)(6486002)(52116002)(5660300002)(186003)(6506007)(26005)(4326008)(956004)(1076003)(69590400007)(478600001)(6666004)(86362001)(2906002)(6916009)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuiCMbxPxcwUxlJnwqKx33F2j44QFHHcwStUeyJ8IDs262fNIf99v31k+c4eEcPV8U00ILjX6CsIZcAHP3zv8U8ZK7NJDK44RYkIP3I8BKP8R9fETEc9xgRCobBluzeR2SPayuR87jFQ4eS2beJdgJhjt1CldcjvAG9XpOEWe/1Lqrb7LElIXTJFGw1kMDDrPKVKNQxQlST0rCILJ2YVdQZt7W5hTR6Xs5eS57bcWS4F30Xtgi2tisZMysc4NhtCnsQZXvH6Scu1ZERKeXmb4w6aYZgbfbBFgVE4VBL+/cK1+b+VpUd0RHIkiho91tkeMmxcN2gYnR7fHRVPnND8fJB69ecKCHxH8PABd/eWPoV2cYA2wSFxL00ca0l6xlJf/qwLceqK69sbSD4wnmJMQv+OeUSKtC3v2dOli46ezSEw4gAqwG3Z5Vj5Qh1ulbM08Hfx73Ya0+CEvdb7JXOxl2PUunLRQNFlhH7+lsRfB2VfEmBp36ss9Sbrh4YRb/zj
X-MS-Exchange-AntiSpam-MessageData: B+EWsO+HlYLmwayR8SS/1GqS7FUsrNWqwywbKUEBMDMcldZiwtm92wsptttc7TUsKjASGbt8UD7YL7b97DKlAVSW3isEl0jVQdX1U+ZHkK0iZNqQTOS5JZl0HaKkM+ZJWTKa8znTJZHUWhr0a2wl7iz1qW3qFYf0nDihl7wIzvc9Sm4HaDJSWQBFD+9ZkDMwfrQsZkF5Y/CcQgntPJ3qvIIwv8NfU4wblz+hrb9JwJkfNDoXj5Tb92IJQa7hsaBQVoIrbLLLAV4TkCZfVP4vYJKfobqHVD27K6vXvDT+zLT+4qP8zd5vdswsdR2kV0haEYn32ntvJMMtvNBy4O6zSDX/m0l/WB2sb73laRLtoL0aOrzxgYpcgE0sjB1Z6QGh+T7wHEW7ZGGZPm114OGagxMRrr4iZTqkwJjlPuXKwEjSRIkgzbITsOPdtZfyzp9MqhLvXn3CaQwBQqCfLmFaXb9VGf3/qB867UzvQ3vDyErGIvdVB7GuXIM0UxxpGUq9dE2bHzg/xhvFtc3Twb1LSnLrZYFG+JiT23LwSp8zAb+S4ysUoaejDGRwYoJINR0/QYOzAYdoP1llxOWbuoJb6XIIuhzyXeLKAicYJdwHlQAE4t6tlIxrjz/1wHAUvmnjbpThLaPvhIogmI6y36EQ6T8bwHMT5fqDUYsg0AG+tGh+gTJHk0cNZ+jnXsfjEexdf4onjF/M5nAS78v3x5FmqnmoEgR2qzGAh8PHa+SMOSLi2e/4OBR+jlW7QQWGC9jqHz1gGHmKA7fNl9v25z0WCKNtcmslRHJBHn06dWKkEf0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df23ff8-1f26-48cc-56a4-08d7ec3e8575
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 13:09:16.9412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhvHZvL7zkQRsZYxDg8B4+aeVexg+Bn+G3H6WhyHbQ4LWsRgYz2J1BoMIhoErTMCpMBpX8uldfLt8egFYxD1YGByqtDGcyOmk8SuNlgHrVE=
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

Instead of just relying on the comment "Called only on full-dirty
region" in block_copy_task_create() let's move initial dirty area
search directly to block_copy_task_create(). Let's also use effective
bdrv_dirty_bitmap_next_dirty_area instead of looping through all
non-dirty clusters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 80 ++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 35ff9cc3ef..f560338647 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -32,6 +32,11 @@ typedef struct BlockCopyTask {
     CoQueue wait_queue; /* coroutines blocked on this task */
 } BlockCopyTask;
 
+static int64_t task_end(BlockCopyTask *task)
+{
+    return task->offset + task->bytes;
+}
+
 typedef struct BlockCopyState {
     /*
      * BdrvChild objects are not owned or managed by block-copy. They are
@@ -106,17 +111,29 @@ static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t offset,
     return true;
 }
 
-/* Called only on full-dirty region */
+/*
+ * Search for the first dirty area in offset/bytes range and create task at
+ * the beginning of it.
+ */
 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
                                              int64_t offset, int64_t bytes)
 {
-    BlockCopyTask *task = g_new(BlockCopyTask, 1);
+    BlockCopyTask *task;
 
+    if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
+                                           offset, offset + bytes,
+                                           s->copy_size, &offset, &bytes))
+    {
+        return NULL;
+    }
+
+    /* region is dirty, so no existent tasks possible in it */
     assert(!find_conflicting_task(s, offset, bytes));
 
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
     s->in_flight_bytes += bytes;
 
+    task = g_new(BlockCopyTask, 1);
     *task = (BlockCopyTask) {
         .s = s,
         .offset = offset,
@@ -466,6 +483,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
 {
     int ret = 0;
     bool found_dirty = false;
+    int64_t end = offset + bytes;
 
     /*
      * block_copy() user is responsible for keeping source and target in same
@@ -479,58 +497,52 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
 
     while (bytes) {
         g_autofree BlockCopyTask *task = NULL;
-        int64_t next_zero, cur_bytes, status_bytes;
+        int64_t status_bytes;
 
-        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
-            trace_block_copy_skip(s, offset);
-            offset += s->cluster_size;
-            bytes -= s->cluster_size;
-            continue; /* already copied */
+        task = block_copy_task_create(s, offset, bytes);
+        if (!task) {
+            /* No more dirty bits in the bitmap */
+            trace_block_copy_skip_range(s, offset, bytes);
+            break;
+        }
+        if (task->offset > offset) {
+            trace_block_copy_skip_range(s, offset, task->offset - offset);
         }
 
         found_dirty = true;
 
-        cur_bytes = MIN(bytes, s->copy_size);
-
-        next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
-                                                cur_bytes);
-        if (next_zero >= 0) {
-            assert(next_zero > offset); /* offset is dirty */
-            assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
-            cur_bytes = next_zero - offset;
-        }
-        task = block_copy_task_create(s, offset, cur_bytes);
-
-        ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
+        ret = block_copy_block_status(s, task->offset, task->bytes,
+                                      &status_bytes);
         assert(ret >= 0); /* never fail */
-        cur_bytes = MIN(cur_bytes, status_bytes);
-        block_copy_task_shrink(task, cur_bytes);
+        if (status_bytes < task->bytes) {
+            block_copy_task_shrink(task, status_bytes);
+        }
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
-            trace_block_copy_skip_range(s, offset, status_bytes);
-            offset += status_bytes;
-            bytes -= status_bytes;
+            trace_block_copy_skip_range(s, task->offset, task->bytes);
+            offset = task_end(task);
+            bytes = end - offset;
             continue;
         }
 
-        trace_block_copy_process(s, offset);
+        trace_block_copy_process(s, task->offset);
 
-        co_get_from_shres(s->mem, cur_bytes);
-        ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
-                                 error_is_read);
-        co_put_to_shres(s->mem, cur_bytes);
+        co_get_from_shres(s->mem, task->bytes);
+        ret = block_copy_do_copy(s, task->offset, task->bytes,
+                                 ret & BDRV_BLOCK_ZERO, error_is_read);
+        co_put_to_shres(s->mem, task->bytes);
         block_copy_task_end(task, ret);
         if (ret < 0) {
             return ret;
         }
 
-        progress_work_done(s->progress, cur_bytes);
-        s->progress_bytes_callback(cur_bytes, s->progress_opaque);
-        offset += cur_bytes;
-        bytes -= cur_bytes;
+        progress_work_done(s->progress, task->bytes);
+        s->progress_bytes_callback(task->bytes, s->progress_opaque);
+        offset = task_end(task);
+        bytes = end - offset;
     }
 
     return found_dirty;
-- 
2.21.0


