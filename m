Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55573C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116E12075E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnARXkqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116E12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55145 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAq5-0004Vf-Pv
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:06:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAo6-0003K3-8M
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAo4-0002f2-Lv
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:26 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hUAo4-0002eW-E1; Fri, 24 May 2019 10:04:24 -0400
Received: by mail-pg1-x544.google.com with SMTP id d30so5127519pgm.7;
	Fri, 24 May 2019 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=HHUEovWF7EXR7rQLHGWiE3cCOALQt2MWSiGE0Lugumc=;
	b=hnARXkqDXehZrh41tvfk/VvinNqGoFHEaHO7S9P9BWbveGmrHUX8YlP2d6xwwvxPp8
	TqhdbzMQA8ZdDXlR9pwWvR8xlC/74TG2OOnYlJ0QV2Z8ZEoazCTm36XvdWFE6zt9chXy
	7nhAbjyCDlQkdz4grnkMS62+3HqqrT8MO8ADoCVKHdBmXppJH/bXTXVP9I8mE52K8gHO
	6wWSL724oNpzSZN7FYgZUd/37FF+IdLO+xRiLU0qdZiTZH1S3hcKsx/tgUu2Oe7tfIGr
	mKRyOXvZSMO3Y5RbzgDIs/sz50LBzsXh/riZE+1zu3xJtOjwrcDBZvRBvLuY+XLcrrES
	HPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=HHUEovWF7EXR7rQLHGWiE3cCOALQt2MWSiGE0Lugumc=;
	b=lxhMIbXy/wnywi2JR1wuEC+jEQYb0pGJyXLn0PlDKDiYytUKJ/m93n7ULRiVJ9B3jR
	8eMStQdYm91aRI4FbNslqIvdOoXh3CRcAPkXv4gsYG7+B1AHTdPphpF3Tc3KLr8SbL8F
	9q9av74ruy36xywRhypLziTjJhe/zFQqtBjdcwl7KCz4SisPfkPwwtp99sURMJHQH9/R
	Tg0/NRLD+rnk3ovaPA+xjdpTW81qQNFNDO2tHPeKF8jDxjV8LYveTvHxKVn36ynvjjKK
	bs9nOt1/ThAQZLOk7fv619coJiBDRLcuCjEb3Q8byebn+A3WrCVt5XtIFdOXwQi/Xp9e
	ttyg==
X-Gm-Message-State: APjAAAWV/sRTt0RdiDxggmb59ZV3fec208FSYNiZNI4/EAlt6z5J9NpW
	gdl8Yr48F/WF6UKu7yM3yrjTbXABNGVArA==
X-Google-Smtp-Source: APXvYqyXiM6EZJrCb2ZykyUnksHiYEAKLkNKPtqbjWanj+f4XdxTvmsXzsCwtgV6Haj/PCx6GjixEw==
X-Received: by 2002:a63:e018:: with SMTP id e24mr22720005pgh.361.1558706662971;
	Fri, 24 May 2019 07:04:22 -0700 (PDT)
Received: from localhost.localdomain ([120.57.120.132])
	by smtp.gmail.com with ESMTPSA id
	u11sm2556766pfh.130.2019.05.24.07.04.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 07:04:22 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:33:34 +0530
Message-Id: <20190524140337.13415-7-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524140337.13415-1-mehta.aaru20@gmail.com>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [RFC PATCH v2 6/9] block/io_uring: implements
 interfaces for io_uring
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
	saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 MAINTAINERS         |   1 +
 block/Makefile.objs |   2 +
 block/io_uring.c    | 306 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 309 insertions(+)
 create mode 100644 block/io_uring.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b8fc1e3fe3..770d562c6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2510,6 +2510,7 @@ R: Stefan Hajnoczi <stefan@redhat.com>
 L: qemu-block@nongnu.org
 S: Maintained
 F: stubs/io_uring.c
+F: block/io_uring.c


 L: qemu-block@nongnu.original
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 7a81892a52..262d413c6d 100644
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
@@ -61,5 +62,6 @@ block-obj-$(if $(CONFIG_LZFSE),m,n) += dmg-lzfse.o
 dmg-lzfse.o-libs   := $(LZFSE_LIBS)
 qcow.o-libs        := -lz
 linux-aio.o-libs   := -laio
+io_uring.o-libs    := -luring
 parallels.o-cflags := $(LIBXML2_CFLAGS)
 parallels.o-libs   := $(LIBXML2_LIBS)
diff --git a/block/io_uring.c b/block/io_uring.c
new file mode 100644
index 0000000000..817ec055db
--- /dev/null
+++ b/block/io_uring.c
@@ -0,0 +1,306 @@
+/*
+ * Linux io_uring support.
+ *
+ * Copyright (C) 2009 IBM, Corp.
+ * Copyright (C) 2009 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include <liburing.h>
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "block/aio.h"
+#include "qemu/queue.h"
+#include "block/block.h"
+#include "block/raw-aio.h"
+#include "qemu/event_notifier.h"
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
+    QSIMPLEQ_HEAD(, LuringAIOCB) pending;
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
+    int event_idx;
+    int event_max;
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
+
+    qemu_bh_schedule(s->completion_bh);
+
+    while ((s->event_max = s->io_q.in_flight) &&
+           !io_uring_peek_cqe(&s->ring, &cqes)) {
+        for (s->event_idx = 0; s->event_idx < s->event_max;) {
+            io_uring_cqe_seen(&s->ring, cqes);
+
+            LuringAIOCB *luringcb;
+            luringcb = g_malloc0(sizeof(luringcb));
+            luringcb->ret = io_cqe_ret(cqes);
+            /* Change counters one-by-one because we can be nested. */
+            s->io_q.in_flight--;
+            s->event_idx++;
+        }
+    }
+
+    qemu_bh_cancel(s->completion_bh);
+
+    /*
+     *If we are nested we have to notify the level above that we are done
+     * by setting event_max to zero, upper level will then jump out of it's
+     * own `for` loop.  If we are the last all counters dropped to zero.
+     */
+    s->event_max = 0;
+    s->event_idx = 0;
+}
+
+static void qemu_luring_process_completions_and_submit(LuringState *s)
+{
+    aio_context_acquire(s->aio_context);
+    qemu_luring_process_completions(s);
+
+    if (!s->io_q.plugged && !QSIMPLEQ_EMPTY(&s->io_q.pending)) {
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
+
+static void ioq_init(LuringQueue *io_q)
+{
+    QSIMPLEQ_INIT(&io_q->pending);
+    io_q->plugged = 0;
+    io_q->in_queue = 0;
+    io_q->in_flight = 0;
+    io_q->blocked = false;
+}
+
+static void ioq_submit(LuringState *s)
+{
+    int ret, len;
+    LuringAIOCB *luringcb;
+    QSIMPLEQ_HEAD(, LuringAIOCB) completed;
+
+    while (s->io_q.in_flight >= MAX_EVENTS && s->io_q.in_queue) {
+        len = 0;
+        QSIMPLEQ_FOREACH(luringcb, &s->io_q.pending, next) {
+            if (s->io_q.in_flight + len++ >= MAX_EVENTS) {
+                break;
+            }
+            struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
+            if (sqes)  { /* Prep sqe for subission */
+                memset(sqes, 0, sizeof(*sqes));
+                *sqes = luringcb->sqeq;
+                QSIMPLEQ_REMOVE_HEAD(&s->io_q.pending, next);
+            } else {
+                break;
+            }
+        }
+
+        ret =  io_uring_submit(&s->ring);
+        if (ret == -EAGAIN) {
+            break;
+        }
+
+        s->io_q.in_flight += ret;
+        s->io_q.in_queue  -= ret;
+        QSIMPLEQ_SPLIT_AFTER(&s->io_q.pending, luringcb, next, &completed);
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
+        !s->io_q.blocked && !QSIMPLEQ_EMPTY(&s->io_q.pending)) {
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
+        QSIMPLEQ_INSERT_TAIL(&s->io_q.pending, luringcb, next);
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
+        io_uring_prep_fsync(sqes, fd, IORING_FSYNC_DATASYNC);
+        break;
+    default:
+        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\n",
+                        __func__, type);
+        abort();
+    }
+
+    s->io_q.in_queue++;
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
+                       (IOHandler *)qemu_luring_completion_cb, NULL, NULL, &s);
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
+        error_setg_errno(errp, errno, "failed to init linux io_uring ring");
+        goto out_close_efd;
+    }
+
+    ioq_init(&s->io_q);
+    return s;
+
+out_close_efd:
+    g_free(s);
+    return NULL;
+}
+
+void luring_cleanup(LuringState *s)
+{
+    io_uring_queue_exit(&s->ring);
+    g_free(s);
+}
--
2.17.1

