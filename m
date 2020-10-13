Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E57C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAC22487A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAC22487A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLVN-0001I6-BG
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSLRR-0005MM-VN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:38:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSLRL-0002r5-Cz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:38:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F1FCBB198;
 Tue, 13 Oct 2020 14:38:09 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 3/3] replay: do not build if TCG is not available
Date: Tue, 13 Oct 2020 16:38:06 +0200
Message-Id: <20201013143806.14321-4-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013143806.14321-1-cfontana@suse.de>
References: <20201013143806.14321-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this fixes non-TCG builds broken recently by replay reverse debugging.

stub the needed functions in stub/, including errors for hmp and qmp.

change hooks for the case when replay code is disabled (!CONFIG_TCG),
as we need to avoid sinking all the events in replay in this case.

Surprisingly, only _one_ qtest was affected by this, ide-test.c, which
resulted in a buzz as the bh events were never delivered, and the bh
never executed.

Many other subsystems _should_ have been affected.

This fixes the immediate issue, however a better way to group replay
functionality to TCG-only code could be developed in the long term.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 block/block-backend.c      |  9 ++--
 block/io.c                 | 52 ++++++++++++++-------
 block/iscsi.c              |  5 +-
 block/meson.build          |  3 +-
 block/nfs.c                |  6 +--
 block/null.c               |  4 +-
 block/nvme.c               |  6 +--
 block/rbd.c                |  5 +-
 hw/ide/core.c              |  8 ++--
 hw/ide/ioport.c            |  1 -
 include/block/block.h      | 29 ++++++++++++
 migration/savevm.c         | 11 +++--
 net/meson.build            |  3 +-
 replay/meson.build         |  2 +-
 replay/replay-events.c     | 20 ++++----
 replay/replay-input.c      |  4 +-
 stubs/meson.build          |  1 -
 stubs/replay-user.c        |  9 ----
 stubs/replay.c             | 96 ++++++++++++++++++++++++++++++++++++++
 tests/ptimer-test-stubs.c  |  5 --
 tests/qtest/qmp-cmd-test.c |  3 ++
 ui/input.c                 | 12 ++++-
 22 files changed, 212 insertions(+), 82 deletions(-)
 delete mode 100644 stubs/replay-user.c

diff --git a/block/block-backend.c b/block/block-backend.c
index ce78d30794..57ec5224dc 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -19,7 +19,6 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/replay.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
 #include "qemu/id.h"
@@ -1381,9 +1380,7 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
     acb = blk_aio_get(&block_backend_aiocb_info, blk, cb, opaque);
     acb->blk = blk;
     acb->ret = ret;
-
-    replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
-                                     error_callback_bh, acb);
+    bdrv_bh_schedule_oneshot(blk_get_aio_context(blk), error_callback_bh, acb);
     return &acb->common;
 }
 
@@ -1447,8 +1444,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
-                                         blk_aio_complete_bh, acb);
+        bdrv_bh_schedule_oneshot(blk_get_aio_context(blk),
+                                 blk_aio_complete_bh, acb);
     }
 
     return &acb->common;
diff --git a/block/io.c b/block/io.c
index 54f0968aee..0347ff6b10 100644
--- a/block/io.c
+++ b/block/io.c
@@ -368,8 +368,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     if (bs) {
         bdrv_inc_in_flight(bs);
     }
-    replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
-                                     bdrv_co_drain_bh_cb, &data);
+    bdrv_bh_schedule_oneshot(bdrv_get_aio_context(bs),
+                             bdrv_co_drain_bh_cb, &data);
 
     qemu_coroutine_yield();
     /* If we are resumed from some other event (such as an aio completion or a
@@ -600,12 +600,12 @@ void bdrv_drain_all_begin(void)
         return;
     }
 
-    /*
-     * bdrv queue is managed by record/replay,
-     * waiting for finishing the I/O requests may
-     * be infinite
-     */
     if (replay_events_enabled()) {
+        /*
+         * bdrv queue is managed by record/replay,
+         * waiting for finishing the I/O requests may
+         * be infinite
+         */
         return;
     }
 
@@ -638,12 +638,12 @@ void bdrv_drain_all_end(void)
     BlockDriverState *bs = NULL;
     int drained_end_counter = 0;
 
-    /*
-     * bdrv queue is managed by record/replay,
-     * waiting for finishing the I/O requests may
-     * be endless
-     */
     if (replay_events_enabled()) {
+        /*
+         * bdrv queue is managed by record/replay,
+         * waiting for finishing the I/O requests may
+         * be endless
+         */
         return;
     }
 
@@ -2122,12 +2122,12 @@ int bdrv_flush_all(void)
     BlockDriverState *bs = NULL;
     int result = 0;
 
-    /*
-     * bdrv queue is managed by record/replay,
-     * creating new flush request for stopping
-     * the VM may break the determinism
-     */
     if (replay_events_enabled()) {
+        /*
+         * bdrv queue is managed by record/replay,
+         * creating new flush request for stopping
+         * the VM may break the determinism
+         */
         return result;
     }
 
@@ -3215,3 +3215,21 @@ out:
 
     return ret;
 }
+
+void bdrv_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
+{
+    if (replay_events_enabled()) {
+        replay_bh_schedule_oneshot_event(ctx, cb, opaque);
+    } else {
+        aio_bh_schedule_oneshot(ctx, cb, opaque);
+    }
+}
+
+void bdrv_bh_schedule(QEMUBH *bh)
+{
+    if (replay_events_enabled()) {
+        replay_bh_schedule_event(bh);
+    } else {
+        qemu_bh_schedule(bh);
+    }
+}
diff --git a/block/iscsi.c b/block/iscsi.c
index e30a7e3606..fec8cb9255 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -40,7 +40,6 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/uuid.h"
-#include "sysemu/replay.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qdict.h"
@@ -283,8 +282,8 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
     }
 
     if (iTask->co) {
-        replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
-                                         iscsi_co_generic_bh_cb, iTask);
+        bdrv_bh_schedule_oneshot(iTask->iscsilun->aio_context,
+                                 iscsi_co_generic_bh_cb, iTask);
     } else {
         iTask->complete = 1;
     }
diff --git a/block/meson.build b/block/meson.build
index 78e8b25232..01fe6f84d2 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -7,7 +7,6 @@ block_ss.add(files(
   'backup-top.c',
   'blkdebug.c',
   'blklogwrites.c',
-  'blkreplay.c',
   'blkverify.c',
   'block-backend.c',
   'block-copy.c',
@@ -42,6 +41,8 @@ block_ss.add(files(
   'write-threshold.c',
 ), zstd, zlib)
 
+block_ss.add(when: 'CONFIG_TCG', if_true: files('blkreplay.c'))
+
 block_ss.add(when: 'CONFIG_QCOW1', if_true: files('qcow.c'))
 block_ss.add(when: 'CONFIG_VDI', if_true: files('vdi.c'))
 block_ss.add(when: 'CONFIG_CLOOP', if_true: files('cloop.c'))
diff --git a/block/nfs.c b/block/nfs.c
index f86e660374..90a737fe64 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -38,7 +38,6 @@
 #include "qemu/uri.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/replay.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
@@ -259,8 +258,9 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    replay_bh_schedule_oneshot_event(task->client->aio_context,
-                                     nfs_co_generic_bh_cb, task);
+
+    bdrv_bh_schedule_oneshot(task->client->aio_context,
+                             nfs_co_generic_bh_cb, task);
 }
 
 static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
diff --git a/block/null.c b/block/null.c
index cc9b1d4ea7..1fa713c42d 100644
--- a/block/null.c
+++ b/block/null.c
@@ -17,7 +17,6 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/block_int.h"
-#include "sysemu/replay.h"
 
 #define NULL_OPT_LATENCY "latency-ns"
 #define NULL_OPT_ZEROES  "read-zeroes"
@@ -180,8 +179,7 @@ static inline BlockAIOCB *null_aio_common(BlockDriverState *bs,
         timer_mod_ns(&acb->timer,
                      qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + s->latency_ns);
     } else {
-        replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
-                                         null_bh_cb, acb);
+        bdrv_bh_schedule_oneshot(bdrv_get_aio_context(bs), null_bh_cb, acb);
     }
     return &acb->common;
 }
diff --git a/block/nvme.c b/block/nvme.c
index b48f6f2588..c13ad92b7d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -23,7 +23,6 @@
 #include "qemu/option.h"
 #include "qemu/vfio-helpers.h"
 #include "block/block_int.h"
-#include "sysemu/replay.h"
 #include "trace.h"
 
 #include "block/nvme.h"
@@ -313,8 +312,7 @@ static void nvme_put_free_req_locked(NVMeQueuePair *q, NVMeRequest *req)
 static void nvme_wake_free_req_locked(NVMeQueuePair *q)
 {
     if (!qemu_co_queue_empty(&q->free_req_queue)) {
-        replay_bh_schedule_oneshot_event(q->s->aio_context,
-                nvme_free_req_queue_cb, q);
+        bdrv_bh_schedule_oneshot(q->s->aio_context, nvme_free_req_queue_cb, q);
     }
 }
 
@@ -1068,7 +1066,7 @@ static void nvme_rw_cb(void *opaque, int ret)
         /* The rw coroutine hasn't yielded, don't try to enter. */
         return;
     }
-    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
+    bdrv_bh_schedule_oneshot(data->ctx, nvme_rw_cb_bh, data);
 }
 
 static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
diff --git a/block/rbd.c b/block/rbd.c
index 9bd2bce716..11d082b7cc 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -22,7 +22,6 @@
 #include "block/qdict.h"
 #include "crypto/secret.h"
 #include "qemu/cutils.h"
-#include "sysemu/replay.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
@@ -862,8 +861,8 @@ static void rbd_finish_aiocb(rbd_completion_t c, RADOSCB *rcb)
     rcb->ret = rbd_aio_get_return_value(c);
     rbd_aio_release(c);
 
-    replay_bh_schedule_oneshot_event(bdrv_get_aio_context(acb->common.bs),
-                                     rbd_finish_bh, rcb);
+    bdrv_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
+                             rbd_finish_bh, rcb);
 }
 
 static int rbd_aio_discard_wrapper(rbd_image_t image,
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 693b352d5e..4c21e74aac 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -36,7 +36,6 @@
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-#include "sysemu/replay.h"
 #include "sysemu/runstate.h"
 #include "hw/ide/internal.h"
 #include "trace.h"
@@ -493,7 +492,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
 done:
     iocb->aiocb = NULL;
     if (iocb->bh) {
-        replay_bh_schedule_event(iocb->bh);
+        bdrv_bh_schedule(iocb->bh);
     }
 }
 
@@ -2289,8 +2288,9 @@ void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val)
             s = &bus->ifs[i];
             s->status |= BUSY_STAT;
         }
-        replay_bh_schedule_oneshot_event(qemu_get_aio_context(),
-                                         ide_bus_perform_srst, bus);
+
+        bdrv_bh_schedule_oneshot(qemu_get_aio_context(),
+                                 ide_bus_perform_srst, bus);
     }
 
     bus->cmd = val;
diff --git a/hw/ide/ioport.c b/hw/ide/ioport.c
index b613ff3bba..b1cfd1fd85 100644
--- a/hw/ide/ioport.c
+++ b/hw/ide/ioport.c
@@ -33,7 +33,6 @@
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-#include "sysemu/replay.h"
 
 #include "hw/ide/internal.h"
 #include "trace.h"
diff --git a/include/block/block.h b/include/block/block.h
index d16c401cb4..802f2283fa 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -834,4 +834,33 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
                                     BdrvChild *dst, uint64_t dst_offset,
                                     uint64_t bytes, BdrvRequestFlags read_flags,
                                     BdrvRequestFlags write_flags);
+
+/**
+ *
+ * bdrv_bh_schedule_oneshot:
+ *
+ * This is a wrapper for aio_bh_schedule_oneshot:
+ * allocate and schedule a oneshot aio bottom half, to be executed as soon as
+ * possible.
+ *
+ * If event-capturing frameworks are present and active,
+ * the event will instead be consumed by their internal queues.
+ *
+ * Arguments are as per aio_bh_schedule_oneshot.
+ **/
+void bdrv_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque);
+
+/**
+ *
+ * bdrv_bh_schedule:
+ *
+ * This is a wrapper for qemu_bh_schedule.
+ *
+ * If event-capturing frameworks are present and active,
+ * the event will instead be consumed by their internal queues.
+ *
+ * Arguments are as per qemu_bh_schedule.
+ **/
+void bdrv_bh_schedule(QEMUBH *bh);
+
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index d2e141f7b1..d9181ca520 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -63,6 +63,7 @@
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
+#include "sysemu/tcg.h"
 
 const unsigned int postcopy_ram_discard_version = 0;
 
@@ -2674,10 +2675,12 @@ int save_snapshot(const char *name, Error **errp)
         return ret;
     }
 
-    if (!replay_can_snapshot()) {
-        error_setg(errp, "Record/replay does not allow making snapshot "
-                   "right now. Try once more later.");
-        return ret;
+    if (tcg_enabled()) {
+        if (!replay_can_snapshot()) {
+            error_setg(errp, "Record/replay does not allow making snapshot "
+                       "right now. Try once more later.");
+            return ret;
+        }
     }
 
     if (!bdrv_all_can_snapshot(&bs)) {
diff --git a/net/meson.build b/net/meson.build
index 1c7e3a3cb9..1076b0a7ab 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -7,7 +7,6 @@ softmmu_ss.add(files(
   'eth.c',
   'filter-buffer.c',
   'filter-mirror.c',
-  'filter-replay.c',
   'filter-rewriter.c',
   'filter.c',
   'hub.c',
@@ -17,6 +16,8 @@ softmmu_ss.add(files(
   'util.c',
 ))
 
+softmmu_ss.add(when: 'CONFIG_TCG', if_true: files('filter-replay.c'))
+
 softmmu_ss.add(when: 'CONFIG_L2TPV3', if_true: files('l2tpv3.c'))
 softmmu_ss.add(when: slirp, if_true: files('slirp.c'))
 softmmu_ss.add(when: ['CONFIG_VDE', vde], if_true: files('vde.c'))
diff --git a/replay/meson.build b/replay/meson.build
index f91163fb1e..cb3207740a 100644
--- a/replay/meson.build
+++ b/replay/meson.build
@@ -1,4 +1,4 @@
-softmmu_ss.add(files(
+softmmu_ss.add(when: 'CONFIG_TCG', if_true: files(
   'replay.c',
   'replay-internal.c',
   'replay-events.c',
diff --git a/replay/replay-events.c b/replay/replay-events.c
index a1c6bb934e..e0a4523e18 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -130,23 +130,19 @@ void replay_add_event(ReplayAsyncEventKind event_kind,
 
 void replay_bh_schedule_event(QEMUBH *bh)
 {
-    if (events_enabled) {
-        uint64_t id = replay_get_current_icount();
-        replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
-    } else {
-        qemu_bh_schedule(bh);
-    }
+    uint64_t id = replay_get_current_icount();
+
+    g_assert(events_enabled);
+    replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
 }
 
 void replay_bh_schedule_oneshot_event(AioContext *ctx,
     QEMUBHFunc *cb, void *opaque)
 {
-    if (events_enabled) {
-        uint64_t id = replay_get_current_icount();
-        replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
-    } else {
-        aio_bh_schedule_oneshot(ctx, cb, opaque);
-    }
+    uint64_t id = replay_get_current_icount();
+
+    g_assert(events_enabled);
+    replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
 }
 
 void replay_add_input_event(struct InputEvent *event)
diff --git a/replay/replay-input.c b/replay/replay-input.c
index 1147e3d34e..5d1fd92e79 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -124,7 +124,7 @@ void replay_input_event(QemuConsole *src, InputEvent *evt)
     } else if (replay_mode == REPLAY_MODE_RECORD) {
         replay_add_input_event(QAPI_CLONE(InputEvent, evt));
     } else {
-        qemu_input_event_send_impl(src, evt);
+        g_assert_not_reached();
     }
 }
 
@@ -135,6 +135,6 @@ void replay_input_sync_event(void)
     } else if (replay_mode == REPLAY_MODE_RECORD) {
         replay_add_input_sync_event();
     } else {
-        qemu_input_event_sync_impl();
+        g_assert_not_reached();
     }
 }
diff --git a/stubs/meson.build b/stubs/meson.build
index 67f2a8c069..bbd2230d69 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -32,7 +32,6 @@ stub_ss.add(files('qtest.c'))
 stub_ss.add(files('ram-block.c'))
 stub_ss.add(files('ramfb.c'))
 stub_ss.add(files('replay.c'))
-stub_ss.add(files('replay-user.c'))
 stub_ss.add(files('runstate-check.c'))
 stub_ss.add(files('set-fd-handler.c'))
 stub_ss.add(files('sysbus.c'))
diff --git a/stubs/replay-user.c b/stubs/replay-user.c
deleted file mode 100644
index 2ad9e27203..0000000000
--- a/stubs/replay-user.c
+++ /dev/null
@@ -1,9 +0,0 @@
-#include "qemu/osdep.h"
-#include "sysemu/replay.h"
-#include "sysemu/sysemu.h"
-
-void replay_bh_schedule_oneshot_event(AioContext *ctx,
-    QEMUBHFunc *cb, void *opaque)
-{
-    aio_bh_schedule_oneshot(ctx, cb, opaque);
-}
diff --git a/stubs/replay.c b/stubs/replay.c
index 45ebe77fb9..86e8be704b 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -103,3 +103,99 @@ bool replay_reverse_continue(void)
 {
     return false;
 }
+
+void replay_input_event(QemuConsole *src, InputEvent *evt)
+{
+}
+void replay_input_sync_event(void)
+{
+}
+void replay_bh_schedule_event(QEMUBH *bh)
+{
+}
+void replay_bh_schedule_oneshot_event(AioContext *ctx,
+                                      QEMUBHFunc *cb, void *opaque)
+{
+}
+void replay_add_blocker(Error *reason)
+{
+}
+void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size)
+{
+}
+void replay_audio_out(size_t *played)
+{
+}
+void replay_breakpoint(void)
+{
+}
+bool replay_can_snapshot(void)
+{
+    return false;
+}
+void replay_configure(struct QemuOpts *opts)
+{
+}
+void replay_flush_events(void)
+{
+}
+void replay_gdb_attached(void)
+{
+}
+bool replay_running_debug(void)
+{
+    return false;
+}
+void replay_shutdown_request(ShutdownCause cause)
+{
+}
+void replay_start(void)
+{
+}
+void replay_vmstate_init(void)
+{
+}
+
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
+#include "qapi/qapi-commands-replay.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+
+void hmp_info_replay(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available");
+}
+void hmp_replay_break(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available");
+}
+void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available");
+}
+void hmp_replay_seek(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available");
+}
+ReplayInfo *qmp_query_replay(Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+              "replay support not available");
+    return NULL;
+}
+void qmp_replay_break(int64_t icount, Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+              "replay support not available");
+}
+void qmp_replay_delete_break(Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+              "replay support not available");
+}
+void qmp_replay_seek(int64_t icount, Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+              "replay support not available");
+}
diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
index e935a1395e..7f801a4d09 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -122,8 +122,3 @@ void qemu_bh_delete(QEMUBH *bh)
 {
     g_free(bh);
 }
-
-void replay_bh_schedule_event(QEMUBH *bh)
-{
-    bh->cb(bh->opaque);
-}
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 8a4c570e83..1c7186e53c 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -31,6 +31,9 @@ static int query_error_class(const char *cmd)
 #ifndef CONFIG_SPICE
         { "query-spice", ERROR_CLASS_COMMAND_NOT_FOUND },
 #endif
+#ifndef CONFIG_TCG
+        { "query-replay", ERROR_CLASS_COMMAND_NOT_FOUND },
+#endif
 #ifndef CONFIG_VNC
         { "query-vnc", ERROR_CLASS_GENERIC_ERROR },
         { "query-vnc-servers", ERROR_CLASS_GENERIC_ERROR },
diff --git a/ui/input.c b/ui/input.c
index 4791b089c7..8675e8ad09 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -375,7 +375,11 @@ void qemu_input_event_send(QemuConsole *src, InputEvent *evt)
         return;
     }
 
-    replay_input_event(src, evt);
+    if (replay_events_enabled()) {
+        replay_input_event(src, evt);
+    } else {
+        qemu_input_event_send_impl(src, evt);
+    }
 }
 
 void qemu_input_event_sync_impl(void)
@@ -401,7 +405,11 @@ void qemu_input_event_sync(void)
         return;
     }
 
-    replay_input_sync_event();
+    if (replay_events_enabled()) {
+        replay_input_sync_event();
+    } else {
+        qemu_input_event_sync_impl();
+    }
 }
 
 static InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
-- 
2.26.2


