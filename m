Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9A2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 22:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FB1205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 22:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FB1205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgcDI-0008UT-1A
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 18:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe.slater@windriver.com>)
 id 1jgcCd-00082j-6X; Wed, 03 Jun 2020 18:49:43 -0400
Received: from mail5.windriver.com ([192.103.53.11]:45868 helo=mail5.wrs.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe.slater@windriver.com>)
 id 1jgcCa-0003Ue-L2; Wed, 03 Jun 2020 18:49:41 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 053MnFpl018347
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Wed, 3 Jun 2020 15:49:25 -0700
Received: from ala-lpggp3.wrs.com (147.11.105.124) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 3 Jun 2020 15:49:04 -0700
From: Joe Slater <joe.slater@windriver.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/2] lockable:  use QLNULL for a null lockable
Date: Wed, 3 Jun 2020 15:49:02 -0700
Message-ID: <20200603224903.26268-2-joe.slater@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603224903.26268-1-joe.slater@windriver.com>
References: <20200603224903.26268-1-joe.slater@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=192.103.53.11;
 envelope-from=joe.slater@windriver.com; helo=mail5.wrs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 18:49:36
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allows us to build with -Og and optimizations that
do not clean up dead-code.

Signed-off-by: Joe Slater <joe.slater@windriver.com>

to be squished

Signed-off-by: Joe Slater <joe.slater@windriver.com>
---
 block/block-backend.c          | 4 ++--
 block/block-copy.c             | 2 +-
 block/mirror.c                 | 5 +++--
 fsdev/qemu-fsdev-throttle.c    | 6 +++---
 hw/9pfs/9p.c                   | 2 +-
 include/qemu/lockable.h        | 3 +++
 util/qemu-co-shared-resource.c | 2 +-
 7 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 6936b25..92128e8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1174,7 +1174,7 @@ static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
 
     if (blk->quiesce_counter && !blk->disable_request_queuing) {
         blk_dec_in_flight(blk);
-        qemu_co_queue_wait(&blk->queued_requests, NULL);
+        qemu_co_queue_wait(&blk->queued_requests, QLNULL);
         blk_inc_in_flight(blk);
     }
 }
@@ -2367,7 +2367,7 @@ static void blk_root_drained_end(BdrvChild *child, int *drained_end_counter)
         if (blk->dev_ops && blk->dev_ops->drained_end) {
             blk->dev_ops->drained_end(blk->dev_opaque);
         }
-        while (qemu_co_enter_next(&blk->queued_requests, NULL)) {
+        while (qemu_co_enter_next(&blk->queued_requests, QLNULL)) {
             /* Resume all queued requests */
         }
     }
diff --git a/block/block-copy.c b/block/block-copy.c
index bb8d056..8de0b54 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -120,7 +120,7 @@ static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t offset,
         return false;
     }
 
-    qemu_co_queue_wait(&task->wait_queue, NULL);
+    qemu_co_queue_wait(&task->wait_queue, QLNULL);
 
     return true;
 }
diff --git a/block/mirror.c b/block/mirror.c
index e8e8844..76c082d2 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -28,6 +28,7 @@
 #define MAX_IO_BYTES (1 << 20) /* 1 Mb */
 #define DEFAULT_MIRROR_BUF_SIZE (MAX_IN_FLIGHT * MAX_IO_BYTES)
 
+
 /* The mirroring buffer is a list of granularity-sized chunks.
  * Free chunks are organized in a list.
  */
@@ -157,7 +158,7 @@ static void coroutine_fn mirror_wait_on_conflicts(MirrorOp *self,
             if (ranges_overlap(self_start_chunk, self_nb_chunks,
                                op_start_chunk, op_nb_chunks))
             {
-                qemu_co_queue_wait(&op->waiting_requests, NULL);
+                qemu_co_queue_wait(&op->waiting_requests, QLNULL);
                 break;
             }
         }
@@ -297,7 +298,7 @@ mirror_wait_for_any_operation(MirrorBlockJob *s, bool active)
         if (!op->is_pseudo_op && op->is_in_flight &&
             op->is_active_write == active)
         {
-            qemu_co_queue_wait(&op->waiting_requests, NULL);
+            qemu_co_queue_wait(&op->waiting_requests, QLNULL);
             return;
         }
     }
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 5c83a1c..78d256d 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -22,13 +22,13 @@
 static void fsdev_throttle_read_timer_cb(void *opaque)
 {
     FsThrottle *fst = opaque;
-    qemu_co_enter_next(&fst->throttled_reqs[false], NULL);
+    qemu_co_enter_next(&fst->throttled_reqs[false], QLNULL);
 }
 
 static void fsdev_throttle_write_timer_cb(void *opaque)
 {
     FsThrottle *fst = opaque;
-    qemu_co_enter_next(&fst->throttled_reqs[true], NULL);
+    qemu_co_enter_next(&fst->throttled_reqs[true], QLNULL);
 }
 
 int fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
@@ -100,7 +100,7 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst, bool is_write,
     if (throttle_enabled(&fst->cfg)) {
         if (throttle_schedule_timer(&fst->ts, &fst->tt, is_write) ||
             !qemu_co_queue_empty(&fst->throttled_reqs[is_write])) {
-            qemu_co_queue_wait(&fst->throttled_reqs[is_write], NULL);
+            qemu_co_queue_wait(&fst->throttled_reqs[is_write], QLNULL);
         }
 
         throttle_account(&fst->ts, is_write, iov_size(iov, iovcnt));
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 45a788f..35976e2 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2888,7 +2888,7 @@ static void coroutine_fn v9fs_flush(void *opaque)
         /*
          * Wait for pdu to complete.
          */
-        qemu_co_queue_wait(&cancel_pdu->complete, NULL);
+        qemu_co_queue_wait(&cancel_pdu->complete, QLNULL);
         if (!qemu_co_queue_next(&cancel_pdu->complete)) {
             cancel_pdu->cancelled = 0;
             pdu_free(cancel_pdu);
diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index b620023..7f7aebb 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -24,6 +24,9 @@ struct QemuLockable {
     QemuLockUnlockFunc *unlock;
 };
 
+#define QLNULL ((QemuLockable *)0)
+
+
 /* This function gives an error if an invalid, non-NULL pointer type is passed
  * to QEMU_MAKE_LOCKABLE.  For optimized builds, we can rely on dead-code elimination
  * from the compiler, and give the errors already at link time.
diff --git a/util/qemu-co-shared-resource.c b/util/qemu-co-shared-resource.c
index 1c83cd9..7423ea4 100644
--- a/util/qemu-co-shared-resource.c
+++ b/util/qemu-co-shared-resource.c
@@ -64,7 +64,7 @@ void coroutine_fn co_get_from_shres(SharedResource *s, uint64_t n)
 {
     assert(n <= s->total);
     while (!co_try_get_from_shres(s, n)) {
-        qemu_co_queue_wait(&s->queue, NULL);
+        qemu_co_queue_wait(&s->queue, QLNULL);
     }
 }
 
-- 
2.7.4


