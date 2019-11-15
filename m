Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604B1C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362022073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362022073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcYa-00009n-UZ
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNj-0005B5-Le
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNe-0002Cr-WB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:27 -0500
Received: from relay.sw.ru ([185.231.240.75]:47472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNb-0001t5-18; Fri, 15 Nov 2019 09:15:19 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcN4-0006WW-EH; Fri, 15 Nov 2019 17:14:46 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 05/24] block/block-copy: rename start to offset in interfaces
Date: Fri, 15 Nov 2019 17:14:25 +0300
Message-Id: <20191115141444.24155-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115141444.24155-1-vsementsov@virtuozzo.com>
References: <20191115141444.24155-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, ehabkost@redhat.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org, jsnow@redhat.com, crosa@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

offset/bytes pair is more usual naming in block layer, let's use it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  2 +-
 block/block-copy.c         | 80 +++++++++++++++++++-------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 7321b3d305..d96b097267 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -19,7 +19,7 @@
 #include "qemu/co-shared-resource.h"
 
 typedef struct BlockCopyInFlightReq {
-    int64_t start;
+    int64_t offset;
     int64_t bytes;
     QLIST_ENTRY(BlockCopyInFlightReq) list;
     CoQueue wait_queue; /* coroutines blocked on this request */
diff --git a/block/block-copy.c b/block/block-copy.c
index cc273b6cb8..20068cd699 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -25,13 +25,13 @@
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 
 static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
-                                                          int64_t start,
+                                                          int64_t offset,
                                                           int64_t bytes)
 {
     BlockCopyInFlightReq *req;
 
     QLIST_FOREACH(req, &s->inflight_reqs, list) {
-        if (start + bytes > req->start && start < req->start + req->bytes) {
+        if (offset + bytes > req->offset && offset < req->offset + req->bytes) {
             return req;
         }
     }
@@ -40,21 +40,21 @@ static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
 }
 
 static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
-                                                       int64_t start,
+                                                       int64_t offset,
                                                        int64_t bytes)
 {
     BlockCopyInFlightReq *req;
 
-    while ((req = block_copy_find_inflight_req(s, start, bytes))) {
+    while ((req = block_copy_find_inflight_req(s, offset, bytes))) {
         qemu_co_queue_wait(&req->wait_queue, NULL);
     }
 }
 
 static void block_copy_inflight_req_begin(BlockCopyState *s,
                                           BlockCopyInFlightReq *req,
-                                          int64_t start, int64_t bytes)
+                                          int64_t offset, int64_t bytes)
 {
-    req->start = start;
+    req->offset = offset;
     req->bytes = bytes;
     qemu_co_queue_init(&req->wait_queue);
     QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
@@ -158,24 +158,24 @@ void block_copy_set_callbacks(
  * Returns 0 on success.
  */
 static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
-                                           int64_t start, int64_t bytes,
+                                           int64_t offset, int64_t bytes,
                                            bool zeroes, bool *error_is_read)
 {
     int ret;
-    int nbytes = MIN(start + bytes, s->len) - start;
+    int nbytes = MIN(offset + bytes, s->len) - offset;
     void *bounce_buffer = NULL;
 
-    assert(start >= 0 && bytes > 0 && INT64_MAX - start >= bytes);
-    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    assert(offset >= 0 && bytes > 0 && INT64_MAX - offset >= bytes);
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
-    assert(start + bytes <= s->len ||
-           start + bytes == QEMU_ALIGN_UP(s->len, s->cluster_size));
+    assert(offset + bytes <= s->len ||
+           offset + bytes == QEMU_ALIGN_UP(s->len, s->cluster_size));
 
     if (zeroes) {
-        ret = bdrv_co_pwrite_zeroes(s->target, start, nbytes, s->write_flags &
+        ret = bdrv_co_pwrite_zeroes(s->target, offset, nbytes, s->write_flags &
                                     ~BDRV_REQ_WRITE_COMPRESSED);
         if (ret < 0) {
-            trace_block_copy_write_zeroes_fail(s, start, ret);
+            trace_block_copy_write_zeroes_fail(s, offset, ret);
             if (error_is_read) {
                 *error_is_read = false;
             }
@@ -184,10 +184,10 @@ static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
     }
 
     if (s->use_copy_range) {
-        ret = bdrv_co_copy_range(s->source, start, s->target, start, nbytes,
+        ret = bdrv_co_copy_range(s->source, offset, s->target, offset, nbytes,
                                  0, s->write_flags);
         if (ret < 0) {
-            trace_block_copy_copy_range_fail(s, start, ret);
+            trace_block_copy_copy_range_fail(s, offset, ret);
             s->use_copy_range = false;
             s->copy_size = MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
             /* Fallback to read+write with allocated buffer */
@@ -221,19 +221,19 @@ static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
 
     bounce_buffer = qemu_blockalign(s->source->bs, nbytes);
 
-    ret = bdrv_co_pread(s->source, start, nbytes, bounce_buffer, 0);
+    ret = bdrv_co_pread(s->source, offset, nbytes, bounce_buffer, 0);
     if (ret < 0) {
-        trace_block_copy_read_fail(s, start, ret);
+        trace_block_copy_read_fail(s, offset, ret);
         if (error_is_read) {
             *error_is_read = true;
         }
         goto out;
     }
 
-    ret = bdrv_co_pwrite(s->target, start, nbytes, bounce_buffer,
+    ret = bdrv_co_pwrite(s->target, offset, nbytes, bounce_buffer,
                          s->write_flags);
     if (ret < 0) {
-        trace_block_copy_write_fail(s, start, ret);
+        trace_block_copy_write_fail(s, offset, ret);
         if (error_is_read) {
             *error_is_read = false;
         }
@@ -345,7 +345,7 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
 }
 
 int coroutine_fn block_copy(BlockCopyState *s,
-                            int64_t start, uint64_t bytes,
+                            int64_t offset, uint64_t bytes,
                             bool *error_is_read)
 {
     int ret = 0;
@@ -358,59 +358,59 @@ int coroutine_fn block_copy(BlockCopyState *s,
     assert(bdrv_get_aio_context(s->source->bs) ==
            bdrv_get_aio_context(s->target->bs));
 
-    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
-    block_copy_wait_inflight_reqs(s, start, bytes);
-    block_copy_inflight_req_begin(s, &req, start, bytes);
+    block_copy_wait_inflight_reqs(s, offset, bytes);
+    block_copy_inflight_req_begin(s, &req, offset, bytes);
 
     while (bytes) {
         int64_t next_zero, cur_bytes, status_bytes;
 
-        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
-            trace_block_copy_skip(s, start);
-            start += s->cluster_size;
+        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
+            trace_block_copy_skip(s, offset);
+            offset += s->cluster_size;
             bytes -= s->cluster_size;
             continue; /* already copied */
         }
 
         cur_bytes = MIN(bytes, s->copy_size);
 
-        next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
+        next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
                                                 cur_bytes);
         if (next_zero >= 0) {
-            assert(next_zero > start); /* start is dirty */
-            assert(next_zero < start + cur_bytes); /* no need to do MIN() */
-            cur_bytes = next_zero - start;
+            assert(next_zero > offset); /* offset is dirty */
+            assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
+            cur_bytes = next_zero - offset;
         }
 
-        ret = block_copy_block_status(s, start, cur_bytes, &status_bytes);
+        ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            bdrv_reset_dirty_bitmap(s->copy_bitmap, start, status_bytes);
+            bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, status_bytes);
             s->progress_reset_callback(s->progress_opaque);
-            trace_block_copy_skip_range(s, start, status_bytes);
-            start += status_bytes;
+            trace_block_copy_skip_range(s, offset, status_bytes);
+            offset += status_bytes;
             bytes -= status_bytes;
             continue;
         }
 
         cur_bytes = MIN(cur_bytes, status_bytes);
 
-        trace_block_copy_process(s, start);
+        trace_block_copy_process(s, offset);
 
-        bdrv_reset_dirty_bitmap(s->copy_bitmap, start, cur_bytes);
+        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
 
         co_get_from_shres(s->mem, cur_bytes);
-        ret = block_copy_do_copy(s, start, cur_bytes, ret & BDRV_BLOCK_ZERO,
+        ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
         if (ret < 0) {
-            bdrv_set_dirty_bitmap(s->copy_bitmap, start, cur_bytes);
+            bdrv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
             break;
         }
 
         s->progress_bytes_callback(cur_bytes, s->progress_opaque);
-        start += cur_bytes;
+        offset += cur_bytes;
         bytes -= cur_bytes;
     }
 
-- 
2.21.0


