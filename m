Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52917C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A58A21721
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSvb09pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A58A21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAfy-0002BA-8a
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:08:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAc7-0007js-Hi
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAc5-0001p2-K9
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:11 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hVAc5-0001mt-DL; Mon, 27 May 2019 04:04:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id z26so9128180pfg.6;
	Mon, 27 May 2019 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=q5UalSCQoMEla8Jfhq2XT1FqtWrDT6iYKSbikZw7dPY=;
	b=vSvb09pqYeX3EuL6ac2INKq9oBI1s2JkMaYfxn8EePc0wm1YCPqJJsTLoQZAg8pbUl
	5OsZkivd2+jJ3vI3bBBYuUnUjhdeEc2MARrNEUBdyGqScZcKyMshUT+OO+9nuznaqIpK
	gVDc5UitXU8Ak1KWOutIfzbHtWxA3u6OQpyF7GxLB4LQOQSWMT59r0Gqmr6Kl1vIR5zA
	IbBnXhFhNXvxXULLNnDJSdup9rwYx3zEI3FY+iBGnTjzKio6C/BRNgl9+Qj/IDzjQV5U
	2PfNfYqnjhJZ+AHfV3E7VP47xJq9jXZ+ioI0YM/I+e9bwB4iUb6vRhS/JTAdf6rlVKnk
	5SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=q5UalSCQoMEla8Jfhq2XT1FqtWrDT6iYKSbikZw7dPY=;
	b=sHWLONDB/bTfdJfxi6layk29GmTcrhuHbriZjw5UBSv7CfZj28DHWxJfBCiNC3c3jv
	Gep1M8HiBItKBIloUaABKV3BaXTljMmqajMJmJ+8mZHVyYy4+CwUidM2J0Fh85UnRTPk
	NXlK2MefWn8zP+G95CVmLCiF027OBEL2mLW4ia4QTbojsUECHSPnnmskfbFrFxIArQrJ
	n8dofUu8IdxXGIDC97vXgVpFHO9OJbeOXEztguFi1mOgvaF5JKgXS1sPpmGLCfEKxSbh
	xsrDG2X3xwznE9x64J7qUnipV1x+7CeP0TE8ueQkLMinhV7D6Pv3XRBmJ+rZiT+bmjbT
	U3tQ==
X-Gm-Message-State: APjAAAVQ7JYHyYt+crE1Hn15iW/AlFMMghCSbcrRJGUik3QsuiupN7I4
	9WStHzC1VDSEW9K3YiaKvdSjV5JwmEpcZA==
X-Google-Smtp-Source: APXvYqz2UhopOBIpKSz8bp3yRLzizpf5IejXx43rH9kRKgBdoSD59dJJ5bHU81S4ANqx1P5ASWHC2Q==
X-Received: by 2002:a62:87c6:: with SMTP id
	i189mr135495897pfe.65.1558944247899; 
	Mon, 27 May 2019 01:04:07 -0700 (PDT)
Received: from localhost.localdomain ([120.57.119.140])
	by smtp.gmail.com with ESMTPSA id
	j5sm10030853pfa.15.2019.05.27.01.04.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 01:04:07 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 May 2019 13:33:23 +0530
Message-Id: <20190527080327.10780-5-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527080327.10780-1-mehta.aaru20@gmail.com>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 4/8] block/io_uring: implements interfaces
 for io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
We need nested loops in ioq_submit because overflowed requests may be
permitted to submit if existing ones are cleared. Hence, failure to 
fulfill an overflow request must break separately from normal submission.

For now, to prevent any infinite loops, if the kernel fails to submit
for any reason, we break (ie when number of submissions is zero). 

Now this is tested with a  kali img with trace events to ensure it is 
actually running. The initramfs boots switched to threads.
 
 MAINTAINERS             |   7 +
 block/Makefile.objs     |   3 +
 block/io_uring.c        | 301 ++++++++++++++++++++++++++++++++++++++++
 include/block/aio.h     |  16 ++-
 include/block/raw-aio.h |  15 ++
 5 files changed, 341 insertions(+), 1 deletion(-)
 create mode 100644 block/io_uring.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cacd751bf..462c00a021 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2504,6 +2504,13 @@ F: block/file-posix.c
 F: block/file-win32.c
 F: block/win32-aio.c
 
+Linux io_uring
+M: Aarushi Mehta <mehta.aaru20@gmail.com>
+R: Stefan Hajnoczi <stefan@redhat.com>
+L: qemu-block@nongnu.org
+S: Maintained
+F: block/io_uring.c
+
 qcow2
 M: Kevin Wolf <kwolf@redhat.com>
 M: Max Reitz <mreitz@redhat.com>
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 7a81892a52..348a003af5 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -18,6 +18,7 @@ block-obj-y += block-backend.o snapshot.o qapi.o
 block-obj-$(CONFIG_WIN32) += file-win32.o win32-aio.o
 block-obj-$(CONFIG_POSIX) += file-posix.o
 block-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
+block-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
 block-obj-y += null.o mirror.o commit.o io.o create.o
 block-obj-y += throttle-groups.o
 block-obj-$(CONFIG_LINUX) += nvme.o
@@ -61,5 +62,7 @@ block-obj-$(if $(CONFIG_LZFSE),m,n) += dmg-lzfse.o
 dmg-lzfse.o-libs   := $(LZFSE_LIBS)
 qcow.o-libs        := -lz
 linux-aio.o-libs   := -laio
+io_uring.o-cflags  := $(LINUX_IO_URING_CFLAGS)
+io_uring.o-libs    := $(LINUX_IO_URING_LIBS)
 parallels.o-cflags := $(LIBXML2_CFLAGS)
 parallels.o-libs   := $(LIBXML2_LIBS)
diff --git a/block/io_uring.c b/block/io_uring.c
new file mode 100644
index 0000000000..2a8c48a7dc
--- /dev/null
+++ b/block/io_uring.c
@@ -0,0 +1,301 @@
+/*
+ * Linux io_uring support.
+ *
+ * Copyright (C) 2009 IBM, Corp.
+ * Copyright (C) 2009 Red Hat, Inc.
+ * Copyright (C) 2019 Aarushi Mehta
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include <liburing.h>
+#include "qemu-common.h"
+#include "block/aio.h"
+#include "qemu/queue.h"
+#include "block/block.h"
+#include "block/raw-aio.h"
+#include "qemu/coroutine.h"
+#include "qapi/error.h"
+
+#define MAX_EVENTS 128
+
+typedef struct LuringAIOCB {
+    BlockAIOCB common;
+    Coroutine *co;
+    struct io_uring_sqe sqeq;
+    int ret;
+    QSIMPLEQ_ENTRY(LuringAIOCB) next;
+} LuringAIOCB;
+
+typedef struct LuringQueue {
+    int plugged;
+    unsigned int in_queue;
+    unsigned int in_flight;
+    bool blocked;
+    QSIMPLEQ_HEAD(, LuringAIOCB) sq_overflow;
+} LuringQueue;
+
+typedef struct LuringState {
+    AioContext *aio_context;
+
+    struct io_uring ring;
+
+    /* io queue for submit at batch.  Protected by AioContext lock. */
+    LuringQueue io_q;
+
+    /* I/O completion processing.  Only runs in I/O thread.  */
+    QEMUBH *completion_bh;
+} LuringState;
+
+static void ioq_submit(LuringState *s);
+
+static inline int io_cqe_ret(struct io_uring_cqe *cqe)
+{
+    return cqe->res;
+}
+
+/**
+ * qemu_luring_process_completions:
+ * @s: AIO state
+ *
+ * Fetches completed I/O requests, consumes cqes and invokes their callbacks.
+ *
+ */
+static void qemu_luring_process_completions(LuringState *s)
+{
+    struct io_uring_cqe *cqes;
+    /*
+     * Request completion callbacks can run the nested event loop.
+     * Schedule ourselves so the nested event loop will "see" remaining
+     * completed requests and process them.  Without this, completion
+     * callbacks that wait for other requests using a nested event loop
+     * would hang forever.
+     */
+    qemu_bh_schedule(s->completion_bh);
+
+    while (!io_uring_peek_cqe(&s->ring, &cqes)) {
+        io_uring_cqe_seen(&s->ring, cqes);
+
+        LuringAIOCB *luringcb = io_uring_cqe_get_data(cqes);
+        luringcb->ret = io_cqe_ret(cqes);
+        if (luringcb->co) {
+            /*
+             * If the coroutine is already entered it must be in ioq_submit()
+             * and will notice luringcb->ret has been filled in when it
+             * eventually runs later. Coroutines cannot be entered recursively
+             * so avoid doing that!
+             */
+            if (!qemu_coroutine_entered(luringcb->co)) {
+                aio_co_wake(luringcb->co);
+            }
+        } else {
+            luringcb->common.cb(luringcb->common.opaque, luringcb->ret);
+            qemu_aio_unref(luringcb);
+        }
+        /* Change counters one-by-one because we can be nested. */
+        s->io_q.in_flight--;
+    }
+    qemu_bh_cancel(s->completion_bh);
+}
+
+static void qemu_luring_process_completions_and_submit(LuringState *s)
+{
+    aio_context_acquire(s->aio_context);
+    qemu_luring_process_completions(s);
+
+    if (!s->io_q.plugged && !s->io_q.in_queue) {
+        ioq_submit(s);
+    }
+    aio_context_release(s->aio_context);
+}
+
+static void qemu_luring_completion_bh(void *opaque)
+{
+    LuringState *s = opaque;
+    qemu_luring_process_completions_and_submit(s);
+}
+
+static void qemu_luring_completion_cb(void *opaque)
+{
+    LuringState *s = opaque;
+    qemu_luring_process_completions_and_submit(s);
+}
+
+static const AIOCBInfo luring_aiocb_info = {
+    .aiocb_size         = sizeof(LuringAIOCB),
+};
+
+static void ioq_init(LuringQueue *io_q)
+{
+    QSIMPLEQ_INIT(&io_q->sq_overflow);
+    io_q->plugged = 0;
+    io_q->in_queue = 0;
+    io_q->in_flight = 0;
+    io_q->blocked = false;
+}
+
+static void ioq_submit(LuringState *s)
+{
+    int ret;
+    LuringAIOCB *luringcb, *luringcb_next;
+
+    while(!s->io_q.in_queue) {
+        QSIMPLEQ_FOREACH_SAFE(luringcb, &s->io_q.sq_overflow, next,
+                              luringcb_next) {
+            struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
+            if (!sqes) {
+                break;
+            }
+            /* Prep sqe for submission */
+            *sqes = luringcb->sqeq;
+            io_uring_sqe_set_data(sqes, luringcb);
+            QSIMPLEQ_REMOVE_HEAD(&s->io_q.sq_overflow, next);
+        }
+        ret =  io_uring_submit(&s->ring);
+        if (ret <= 0) { 
+            /* TODO error handling */
+            break;
+        }
+        s->io_q.in_flight += ret;
+        s->io_q.in_queue  -= ret;
+    }
+    s->io_q.blocked = (s->io_q.in_queue > 0);
+
+    if (s->io_q.in_flight) {
+        /*
+         * We can try to complete something just right away if there are
+         * still requests in-flight.
+         */
+        qemu_luring_process_completions(s);
+    }
+}
+
+void luring_io_plug(BlockDriverState *bs, LuringState *s)
+{
+    s->io_q.plugged++;
+}
+
+void luring_io_unplug(BlockDriverState *bs, LuringState *s)
+{
+    assert(s->io_q.plugged);
+    if (--s->io_q.plugged == 0 &&
+        !s->io_q.blocked && s->io_q.in_queue > 0) {
+        ioq_submit(s);
+    }
+}
+
+static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
+                            uint64_t offset, QEMUIOVector *qiov, int type)
+{
+    struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
+    if (!sqes) {
+        sqes = &luringcb->sqeq;
+        QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);
+    }
+
+    switch (type) {
+    case QEMU_AIO_WRITE:
+        io_uring_prep_writev(sqes, fd, qiov->iov, qiov->niov, offset);
+        break;
+    case QEMU_AIO_READ:
+        io_uring_prep_readv(sqes, fd, qiov->iov, qiov->niov, offset);
+        break;
+    case QEMU_AIO_FLUSH:
+        io_uring_prep_fsync(sqes, fd, 0);
+        break;
+    default:
+        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\n",
+                        __func__, type);
+        abort();
+    }
+    io_uring_sqe_set_data(sqes, luringcb);
+    s->io_q.in_queue++;
+
+    if (!s->io_q.blocked &&
+        (!s->io_q.plugged ||
+         s->io_q.in_flight + s->io_q.in_queue >= MAX_EVENTS)) {
+        ioq_submit(s);
+    }
+
+    return 0;
+}
+
+int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
+                                uint64_t offset, QEMUIOVector *qiov, int type)
+{
+    int ret;
+    LuringAIOCB luringcb = {
+        .co         = qemu_coroutine_self(),
+        .ret        = -EINPROGRESS,
+    };
+
+    ret = luring_do_submit(fd, &luringcb, s, offset, qiov, type);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (luringcb.ret == -EINPROGRESS) {
+        qemu_coroutine_yield();
+    }
+    return luringcb.ret;
+}
+
+BlockAIOCB *luring_submit(BlockDriverState *bs, LuringState *s, int fd,
+        int64_t sector_num, QEMUIOVector *qiov, BlockCompletionFunc *cb,
+        void *opaque, int type)
+{
+    LuringAIOCB *luringcb;
+    off_t offset = sector_num * BDRV_SECTOR_SIZE;
+    int ret;
+
+    luringcb = qemu_aio_get(&luring_aiocb_info, bs, cb, opaque);
+    luringcb->ret = -EINPROGRESS;
+    ret = luring_do_submit(fd, luringcb, s, offset, qiov, type);
+    if (ret < 0) {
+        qemu_aio_unref(luringcb);
+        return NULL;
+    }
+
+    return &luringcb->common;
+}
+
+void luring_detach_aio_context(LuringState *s, AioContext *old_context)
+{
+    aio_set_fd_handler(old_context, s->ring.ring_fd, false, NULL, NULL, NULL,
+                       &s);
+    qemu_bh_delete(s->completion_bh);
+    s->aio_context = NULL;
+}
+
+void luring_attach_aio_context(LuringState *s, AioContext *new_context)
+{
+    s->aio_context = new_context;
+    s->completion_bh = aio_bh_new(new_context, qemu_luring_completion_bh, s);
+    aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
+                       qemu_luring_completion_cb, NULL, NULL, &s);
+}
+
+LuringState *luring_init(Error **errp)
+{
+    int rc;
+    LuringState *s;
+    s = g_malloc0(sizeof(*s));
+    struct io_uring *ring = &s->ring;
+    rc =  io_uring_queue_init(MAX_EVENTS, ring, 0);
+    if (rc == -1) {
+        error_setg_errno(errp, -rc, "failed to init linux io_uring ring");
+        g_free(s);
+        return NULL;
+    }
+
+    ioq_init(&s->io_q);
+    return s;
+
+}
+
+void luring_cleanup(LuringState *s)
+{
+    io_uring_queue_exit(&s->ring);
+    g_free(s);
+}
diff --git a/include/block/aio.h b/include/block/aio.h
index 0ca25dfec6..9da3fd9793 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -50,6 +50,7 @@ typedef void IOHandler(void *opaque);
 struct Coroutine;
 struct ThreadPool;
 struct LinuxAioState;
+struct LuringState;
 
 struct AioContext {
     GSource source;
@@ -118,11 +119,19 @@ struct AioContext {
     struct ThreadPool *thread_pool;
 
 #ifdef CONFIG_LINUX_AIO
-    /* State for native Linux AIO.  Uses aio_context_acquire/release for
+    /*
+     * State for native Linux AIO.  Uses aio_context_acquire/release for
      * locking.
      */
     struct LinuxAioState *linux_aio;
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    /*
+     * State for Linux io_uring.  Uses aio_context_acquire/release for
+     * locking.
+     */
+    struct LuringState *linux_io_uring;
+#endif
 
     /* TimerLists for calling timers - one per clock type.  Has its own
      * locking.
@@ -387,6 +396,11 @@ struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
 /* Return the LinuxAioState bound to this AioContext */
 struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
 
+/* Setup the LuringState bound to this AioContext */
+struct LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp);
+
+/* Return the LuringState bound to this AioContext */
+struct LuringState *aio_get_linux_io_uring(AioContext *ctx);
 /**
  * aio_timer_new_with_attrs:
  * @ctx: the aio context
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index ba223dd1f1..28a836151e 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -58,6 +58,21 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
 void laio_io_plug(BlockDriverState *bs, LinuxAioState *s);
 void laio_io_unplug(BlockDriverState *bs, LinuxAioState *s);
 #endif
+/* io_uring.c - Linux io_uring implementation */
+#ifdef CONFIG_LINUX_IO_URING
+typedef struct LuringState LuringState;
+LuringState *luring_init(Error **errp);
+void luring_cleanup(LuringState *s);
+int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
+                                uint64_t offset, QEMUIOVector *qiov, int type);
+BlockAIOCB *luring_submit(BlockDriverState *bs, LuringState *s, int fd,
+        int64_t sector_num, QEMUIOVector *qiov, BlockCompletionFunc *cb,
+        void *opaque, int type);
+void luring_detach_aio_context(LuringState *s, AioContext *old_context);
+void luring_attach_aio_context(LuringState *s, AioContext *new_context);
+void luring_io_plug(BlockDriverState *bs, LuringState *s);
+void luring_io_unplug(BlockDriverState *bs, LuringState *s);
+#endif
 
 #ifdef _WIN32
 typedef struct QEMUWin32AIOState QEMUWin32AIOState;
-- 
2.17.1


