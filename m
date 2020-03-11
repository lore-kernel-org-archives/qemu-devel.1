Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CB2C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D451D20726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhiayRrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D451D20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC22P-0001qL-VL
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1nR-0005Df-Ll
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1nO-00039v-IP
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1nO-00038x-D8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PGjGHpfl+KFcZdJMlNe4JLWmpwp7pOcceXG/KTx/zA=;
 b=LhiayRrhDfXcXiT26eDDL2GoqE08//Kg6dT2Jzq+4AUHR4+WrHxIcLm6FvSK8toMOoTmol
 nba+fVfpOH9rs+uScaCo1nwh55yQANwU9dKt/faLrhJi6WBnW6q539GpcHM3QJ76q5sztA
 fqGxjDPpDH8PIhATQ/hmETEmwE/DdBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-hyHSJ4oeMrCdzRje_bUEUA-1; Wed, 11 Mar 2020 09:53:09 -0400
X-MC-Unique: hyHSJ4oeMrCdzRje_bUEUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83BAB140D;
 Wed, 11 Mar 2020 13:53:08 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4A8460E3E;
 Wed, 11 Mar 2020 13:53:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 17/19] block/block-copy: rename start to offset in interfaces
Date: Wed, 11 Mar 2020 14:52:11 +0100
Message-Id: <20200311135213.1242028-18-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

offset/bytes pair is more usual naming in block layer, let's use it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200311103004.7649-8-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c         | 82 +++++++++++++++++++-------------------
 include/block/block-copy.h |  4 +-
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 4c947e548b..8b91fa0b06 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -25,13 +25,13 @@
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
=20
 static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState =
*s,
-                                                           int64_t start,
+                                                           int64_t offset,
                                                            int64_t bytes)
 {
     BlockCopyInFlightReq *req;
=20
     QLIST_FOREACH(req, &s->inflight_reqs, list) {
-        if (start + bytes > req->start && start < req->start + req->bytes)=
 {
+        if (offset + bytes > req->offset && offset < req->offset + req->by=
tes) {
             return req;
         }
     }
@@ -40,21 +40,21 @@ static BlockCopyInFlightReq *find_conflicting_inflight_=
req(BlockCopyState *s,
 }
=20
 static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
-                                                       int64_t start,
+                                                       int64_t offset,
                                                        int64_t bytes)
 {
     BlockCopyInFlightReq *req;
=20
-    while ((req =3D find_conflicting_inflight_req(s, start, bytes))) {
+    while ((req =3D find_conflicting_inflight_req(s, offset, bytes))) {
         qemu_co_queue_wait(&req->wait_queue, NULL);
     }
 }
=20
 static void block_copy_inflight_req_begin(BlockCopyState *s,
                                           BlockCopyInFlightReq *req,
-                                          int64_t start, int64_t bytes)
+                                          int64_t offset, int64_t bytes)
 {
-    req->start =3D start;
+    req->offset =3D offset;
     req->bytes =3D bytes;
     qemu_co_queue_init(&req->wait_queue);
     QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
@@ -161,26 +161,26 @@ void block_copy_set_progress_meter(BlockCopyState *s,=
 ProgressMeter *pm)
  * Returns 0 on success.
  */
 static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
-                                           int64_t start, int64_t bytes,
+                                           int64_t offset, int64_t bytes,
                                            bool zeroes, bool *error_is_rea=
d)
 {
     int ret;
-    int64_t nbytes =3D MIN(start + bytes, s->len) - start;
+    int64_t nbytes =3D MIN(offset + bytes, s->len) - offset;
     void *bounce_buffer =3D NULL;
=20
-    assert(start >=3D 0 && bytes > 0 && INT64_MAX - start >=3D bytes);
-    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    assert(offset >=3D 0 && bytes > 0 && INT64_MAX - offset >=3D bytes);
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
-    assert(start < s->len);
-    assert(start + bytes <=3D s->len ||
-           start + bytes =3D=3D QEMU_ALIGN_UP(s->len, s->cluster_size));
+    assert(offset < s->len);
+    assert(offset + bytes <=3D s->len ||
+           offset + bytes =3D=3D QEMU_ALIGN_UP(s->len, s->cluster_size));
     assert(nbytes < INT_MAX);
=20
     if (zeroes) {
-        ret =3D bdrv_co_pwrite_zeroes(s->target, start, nbytes, s->write_f=
lags &
+        ret =3D bdrv_co_pwrite_zeroes(s->target, offset, nbytes, s->write_=
flags &
                                     ~BDRV_REQ_WRITE_COMPRESSED);
         if (ret < 0) {
-            trace_block_copy_write_zeroes_fail(s, start, ret);
+            trace_block_copy_write_zeroes_fail(s, offset, ret);
             if (error_is_read) {
                 *error_is_read =3D false;
             }
@@ -189,10 +189,10 @@ static int coroutine_fn block_copy_do_copy(BlockCopyS=
tate *s,
     }
=20
     if (s->use_copy_range) {
-        ret =3D bdrv_co_copy_range(s->source, start, s->target, start, nby=
tes,
+        ret =3D bdrv_co_copy_range(s->source, offset, s->target, offset, n=
bytes,
                                  0, s->write_flags);
         if (ret < 0) {
-            trace_block_copy_copy_range_fail(s, start, ret);
+            trace_block_copy_copy_range_fail(s, offset, ret);
             s->use_copy_range =3D false;
             s->copy_size =3D MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
             /* Fallback to read+write with allocated buffer */
@@ -228,19 +228,19 @@ static int coroutine_fn block_copy_do_copy(BlockCopyS=
tate *s,
=20
     bounce_buffer =3D qemu_blockalign(s->source->bs, nbytes);
=20
-    ret =3D bdrv_co_pread(s->source, start, nbytes, bounce_buffer, 0);
+    ret =3D bdrv_co_pread(s->source, offset, nbytes, bounce_buffer, 0);
     if (ret < 0) {
-        trace_block_copy_read_fail(s, start, ret);
+        trace_block_copy_read_fail(s, offset, ret);
         if (error_is_read) {
             *error_is_read =3D true;
         }
         goto out;
     }
=20
-    ret =3D bdrv_co_pwrite(s->target, start, nbytes, bounce_buffer,
+    ret =3D bdrv_co_pwrite(s->target, offset, nbytes, bounce_buffer,
                          s->write_flags);
     if (ret < 0) {
-        trace_block_copy_write_fail(s, start, ret);
+        trace_block_copy_write_fail(s, offset, ret);
         if (error_is_read) {
             *error_is_read =3D false;
         }
@@ -358,7 +358,7 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
 }
=20
 int coroutine_fn block_copy(BlockCopyState *s,
-                            int64_t start, int64_t bytes,
+                            int64_t offset, int64_t bytes,
                             bool *error_is_read)
 {
     int ret =3D 0;
@@ -371,64 +371,64 @@ int coroutine_fn block_copy(BlockCopyState *s,
     assert(bdrv_get_aio_context(s->source->bs) =3D=3D
            bdrv_get_aio_context(s->target->bs));
=20
-    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
=20
-    block_copy_wait_inflight_reqs(s, start, bytes);
-    block_copy_inflight_req_begin(s, &req, start, bytes);
+    block_copy_wait_inflight_reqs(s, offset, bytes);
+    block_copy_inflight_req_begin(s, &req, offset, bytes);
=20
     while (bytes) {
         int64_t next_zero, cur_bytes, status_bytes;
=20
-        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
-            trace_block_copy_skip(s, start);
-            start +=3D s->cluster_size;
+        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
+            trace_block_copy_skip(s, offset);
+            offset +=3D s->cluster_size;
             bytes -=3D s->cluster_size;
             continue; /* already copied */
         }
=20
         cur_bytes =3D MIN(bytes, s->copy_size);
=20
-        next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
+        next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
                                                 cur_bytes);
         if (next_zero >=3D 0) {
-            assert(next_zero > start); /* start is dirty */
-            assert(next_zero < start + cur_bytes); /* no need to do MIN() =
*/
-            cur_bytes =3D next_zero - start;
+            assert(next_zero > offset); /* offset is dirty */
+            assert(next_zero < offset + cur_bytes); /* no need to do MIN()=
 */
+            cur_bytes =3D next_zero - offset;
         }
=20
-        ret =3D block_copy_block_status(s, start, cur_bytes, &status_bytes=
);
+        ret =3D block_copy_block_status(s, offset, cur_bytes, &status_byte=
s);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            bdrv_reset_dirty_bitmap(s->copy_bitmap, start, status_bytes);
+            bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, status_bytes);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
-            trace_block_copy_skip_range(s, start, status_bytes);
-            start +=3D status_bytes;
+            trace_block_copy_skip_range(s, offset, status_bytes);
+            offset +=3D status_bytes;
             bytes -=3D status_bytes;
             continue;
         }
=20
         cur_bytes =3D MIN(cur_bytes, status_bytes);
=20
-        trace_block_copy_process(s, start);
+        trace_block_copy_process(s, offset);
=20
-        bdrv_reset_dirty_bitmap(s->copy_bitmap, start, cur_bytes);
+        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
         s->in_flight_bytes +=3D cur_bytes;
=20
         co_get_from_shres(s->mem, cur_bytes);
-        ret =3D block_copy_do_copy(s, start, cur_bytes, ret & BDRV_BLOCK_Z=
ERO,
+        ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_=
ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
         s->in_flight_bytes -=3D cur_bytes;
         if (ret < 0) {
-            bdrv_set_dirty_bitmap(s->copy_bitmap, start, cur_bytes);
+            bdrv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
             break;
         }
=20
         progress_work_done(s->progress, cur_bytes);
         s->progress_bytes_callback(cur_bytes, s->progress_opaque);
-        start +=3D cur_bytes;
+        offset +=3D cur_bytes;
         bytes -=3D cur_bytes;
     }
=20
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 7fd36e528b..b76efb736f 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -19,7 +19,7 @@
 #include "qemu/co-shared-resource.h"
=20
 typedef struct BlockCopyInFlightReq {
-    int64_t start;
+    int64_t offset;
     int64_t bytes;
     QLIST_ENTRY(BlockCopyInFlightReq) list;
     CoQueue wait_queue; /* coroutines blocked on this request */
@@ -85,7 +85,7 @@ void block_copy_state_free(BlockCopyState *s);
 int64_t block_copy_reset_unallocated(BlockCopyState *s,
                                      int64_t offset, int64_t *count);
=20
-int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t byte=
s,
+int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t byt=
es,
                             bool *error_is_read);
=20
 #endif /* BLOCK_COPY_H */
--=20
2.24.1


