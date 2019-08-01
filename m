Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386F6C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF29206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX/oHgKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF29206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKki-0002Kx-4P
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60253)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKhO-0005pW-B9
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKhM-0002hl-6x
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:30 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKhL-0002h5-Tp; Thu, 01 Aug 2019 19:41:28 -0400
Received: by mail-pf1-x443.google.com with SMTP id c3so11816212pfa.13;
 Thu, 01 Aug 2019 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hXmBoKcclHo43SA4lszos7jbnCcUTSqSDPN0ATn5TOc=;
 b=lX/oHgKW0t9IV4kPa46NgHQryu6oAI4A9M0xWcXf5QaDSRsiZlQHpjmOoC6dZACs/m
 a3dmNpZGJmSPce+AoN3Gi3IELi/PR3VnzaZkDufjdPLfDLmKVphbwlmKKxdaA46+T4Fz
 YqoBS/C6Mj1v1SUdAbj6XDRbxHuPQkJa96kW/iqCrTKbav78U9GwKVoeIjsVMY+2j3pR
 30XxWmSJ2V26ikLo5IsokeWrsXH0M8dGOWUWgxROzFTJGNk1v/I9fmNoD+Bf7I2XuBcZ
 oOzsDxv2EOrABnbrCTOolq8dDxQbX4wDLre+3jHeL8ACxKRIDppIZYvxF+Y+PRBgWwwY
 Ml2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hXmBoKcclHo43SA4lszos7jbnCcUTSqSDPN0ATn5TOc=;
 b=s46Rfh/Sd9H613o2hTjq7F86yCsbwF2WmUtWDlJMGYYAIJRsIy8rdavhKgFwjiBWhR
 hsue9thxwN+DmC5DdtJUTny7wpuCQ+WmRDL35y8lpo6GLwnJOGKNlGGQKl178Ept9k2d
 aRFQPOhuvh4vD9sDTkDb5qsUW3LonmLENONVWWVflE5/B54z1bvJfjhguF/pV7TZJRkw
 gImFVWfRiMIckLrEi5SquKugf9dFBhJw9rdGUoZtZ0IDbcMT1nwre0Co8+3CiM+GKgE3
 WSbSW45uY8LLr8ok+mll7R9F2BjHZdkq15pm1vIo6LOA/1ZGu3VcAmk7eA/f+gRBu9fO
 dOXQ==
X-Gm-Message-State: APjAAAUSlbyNGu93p3oBA9YZb67N6cDJ4ooxAUKr1tLOfdsAalckKPCX
 LRNp618H7VtPqRaTSXdj4RFQaLnw+2+BXA==
X-Google-Smtp-Source: APXvYqwP+VHD717TRCE8zJWBMsTGruK0XZoMdt2IQ8mTM0wV14rbuFyaGcoDBua90m7ys8cLGBOSAg==
X-Received: by 2002:a17:90a:a410:: with SMTP id
 y16mr1351682pjp.62.1564702886415; 
 Thu, 01 Aug 2019 16:41:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.41.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:41:25 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:18 +0530
Message-Id: <20190801234031.29561-5-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v9 04/17] block/io_uring: implements interfaces
 for io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aborts when sqe fails to be set as sqes cannot be returned to the
ring. Adds slow path for short reads for older kernels

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS             |   7 +
 block/Makefile.objs     |   3 +
 block/io_uring.c        | 409 ++++++++++++++++++++++++++++++++++++++++
 include/block/aio.h     |  16 +-
 include/block/raw-aio.h |  12 ++
 5 files changed, 446 insertions(+), 1 deletion(-)
 create mode 100644 block/io_uring.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d6de200453..be688fcd5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2530,6 +2530,13 @@ F: block/file-posix.c
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
index 35f3bca4d9..6a548af8ed 100644
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
index 0000000000..902b106954
--- /dev/null
+++ b/block/io_uring.c
@@ -0,0 +1,409 @@
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
+    Coroutine *co;
+    struct io_uring_sqe sqeq;
+    ssize_t ret;
+    QEMUIOVector *qiov;
+    bool is_read;
+    QSIMPLEQ_ENTRY(LuringAIOCB) next;
+
+    /*
+     * Buffered reads may require resubmission, see
+     * luring_resubmit_short_read().
+     */
+    int total_read;
+    QEMUIOVector resubmit_qiov;
+} LuringAIOCB;
+
+typedef struct LuringQueue {
+    int plugged;
+    unsigned int in_queue;
+    unsigned int in_flight;
+    bool blocked;
+    QSIMPLEQ_HEAD(, LuringAIOCB) submit_queue;
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
+/**
+ * ioq_submit:
+ * @s: AIO state
+ *
+ * Queues pending sqes and submits them
+ *
+ */
+static int ioq_submit(LuringState *s);
+
+/**
+ * luring_resubmit:
+ *
+ * Resubmit a request by appending it to submit_queue.  The caller must ensure
+ * that ioq_submit() is called later so that submit_queue requests are started.
+ */
+static void luring_resubmit(LuringState *s, LuringAIOCB *luringcb)
+{
+    QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
+    s->io_q.in_queue++;
+}
+
+/**
+ * luring_resubmit_short_read:
+ *
+ * Before Linux commit 9d93a3f5a0c ("io_uring: punt short reads to async
+ * context") a buffered I/O request with the start of the file range in the
+ * page cache could result in a short read.  Applications need to resubmit the
+ * remaining read request.
+ *
+ * This is a slow path but recent kernels never take it.
+ */
+static void luring_resubmit_short_read(LuringState *s, LuringAIOCB *luringcb,
+                                       int nread)
+{
+    QEMUIOVector *resubmit_qiov;
+    size_t remaining;
+
+    /* Update read position */
+    luringcb->total_read = nread;
+    remaining = luringcb->qiov->size - luringcb->total_read;
+
+    /* Shorten qiov */
+    resubmit_qiov = &luringcb->resubmit_qiov;
+    if (resubmit_qiov->iov == NULL) {
+        qemu_iovec_init(resubmit_qiov, luringcb->qiov->niov);
+    } else {
+        qemu_iovec_reset(resubmit_qiov);
+    }
+    qemu_iovec_concat(resubmit_qiov, luringcb->qiov, luringcb->total_read,
+                      remaining);
+
+    /* Update sqe */
+    luringcb->sqeq.off = nread;
+    luringcb->sqeq.addr = (__u64)(uintptr_t)luringcb->resubmit_qiov.iov;
+    luringcb->sqeq.len = luringcb->resubmit_qiov.niov;
+
+    luring_resubmit(s, luringcb);
+}
+
+/**
+ * luring_process_completions:
+ * @s: AIO state
+ *
+ * Fetches completed I/O requests, consumes cqes and invokes their callbacks
+ * The function is somewhat tricky because it supports nested event loops, for
+ * example when a request callback invokes aio_poll().
+ *
+ * Function schedules BH completion so it  can be called again in a nested
+ * event loop.  When there are no events left  to complete the BH is being
+ * canceled.
+ *
+ */
+static void luring_process_completions(LuringState *s)
+{
+    struct io_uring_cqe *cqes;
+    int total_bytes;
+    /*
+     * Request completion callbacks can run the nested event loop.
+     * Schedule ourselves so the nested event loop will "see" remaining
+     * completed requests and process them.  Without this, completion
+     * callbacks that wait for other requests using a nested event loop
+     * would hang forever.
+     *
+     * This workaround is needed because io_uring uses poll_wait, which
+     * is woken up when new events are added to the uring, thus polling on
+     * the same uring fd will block unless more events are received.
+     *
+     * Other leaf block drivers (drivers that access the data themselves)
+     * are networking based, so they poll sockets for data and run the
+     * correct coroutine.
+     */
+    qemu_bh_schedule(s->completion_bh);
+
+    while (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
+        LuringAIOCB *luringcb;
+        int ret;
+
+        if (!cqes) {
+            break;
+        }
+
+        luringcb = io_uring_cqe_get_data(cqes);
+        ret = cqes->res;
+        io_uring_cqe_seen(&s->ring, cqes);
+        cqes = NULL;
+
+        /* Change counters one-by-one because we can be nested. */
+        s->io_q.in_flight--;
+
+        /* total_read is non-zero only for resubmitted read requests */
+        total_bytes = ret + luringcb->total_read;
+
+        if (ret < 0) {
+            if (ret == -EINTR) {
+                luring_resubmit(s, luringcb);
+                continue;
+            }
+        } else if (!luringcb->qiov) {
+            goto end;
+        } else if (total_bytes == luringcb->qiov->size) {
+            ret = 0;
+        /* Only read/write */
+        } else {
+            /* Short Read/Write */
+            if (luringcb->is_read) {
+                if (ret > 0) {
+                    luring_resubmit_short_read(s, luringcb, ret);
+                    continue;
+                } else {
+                    /* Pad with zeroes */
+                    qemu_iovec_memset(luringcb->qiov, total_bytes, 0,
+                                      luringcb->qiov->size - total_bytes);
+                    ret = 0;
+                }
+            } else {
+                ret = -ENOSPC;;
+            }
+        }
+end:
+        luringcb->ret = ret;
+        qemu_iovec_destroy(&luringcb->resubmit_qiov);
+
+        /*
+         * If the coroutine is already entered it must be in ioq_submit()
+         * and will notice luringcb->ret has been filled in when it
+         * eventually runs later. Coroutines cannot be entered recursively
+         * so avoid doing that!
+         */
+        if (!qemu_coroutine_entered(luringcb->co)) {
+            aio_co_wake(luringcb->co);
+        }
+    }
+    qemu_bh_cancel(s->completion_bh);
+}
+
+static void luring_process_completions_and_submit(LuringState *s)
+{
+    aio_context_acquire(s->aio_context);
+    luring_process_completions(s);
+
+    if (!s->io_q.plugged && s->io_q.in_queue > 0) {
+        ioq_submit(s);
+    }
+    aio_context_release(s->aio_context);
+}
+
+static void qemu_luring_completion_bh(void *opaque)
+{
+    LuringState *s = opaque;
+    luring_process_completions_and_submit(s);
+}
+
+static void qemu_luring_completion_cb(void *opaque)
+{
+    LuringState *s = opaque;
+    luring_process_completions_and_submit(s);
+}
+
+static void ioq_init(LuringQueue *io_q)
+{
+    QSIMPLEQ_INIT(&io_q->submit_queue);
+    io_q->plugged = 0;
+    io_q->in_queue = 0;
+    io_q->in_flight = 0;
+    io_q->blocked = false;
+}
+
+static int ioq_submit(LuringState *s)
+{
+    int ret = 0;
+    LuringAIOCB *luringcb, *luringcb_next;
+
+    while (s->io_q.in_queue > 0) {
+        /*
+         * Try to fetch sqes from the ring for requests waiting in
+         * the overflow queue
+         */
+        QSIMPLEQ_FOREACH_SAFE(luringcb, &s->io_q.submit_queue, next,
+                              luringcb_next) {
+            struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
+            if (!sqes) {
+                break;
+            }
+            /* Prep sqe for submission */
+            *sqes = luringcb->sqeq;
+            QSIMPLEQ_REMOVE_HEAD(&s->io_q.submit_queue, next);
+        }
+        ret = io_uring_submit(&s->ring);
+        /* Prevent infinite loop if submission is refused */
+        if (ret <= 0) {
+            if (ret == -EAGAIN) {
+                continue;
+            }
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
+        luring_process_completions(s);
+    }
+    return ret;
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
+/**
+ * luring_do_submit:
+ * @fd: file descriptor for I/O
+ * @luringcb: AIO control block
+ * @s: AIO state
+ * @offset: offset for request
+ * @type: type of request
+ *
+ * Fetches sqes from ring, adds to pending queue and preps them
+ *
+ */
+static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
+                            uint64_t offset, int type)
+{
+    struct io_uring_sqe *sqes = &luringcb->sqeq;
+
+    switch (type) {
+    case QEMU_AIO_WRITE:
+        io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
+                             luringcb->qiov->niov, offset);
+        break;
+    case QEMU_AIO_READ:
+        io_uring_prep_readv(sqes, fd, luringcb->qiov->iov,
+                            luringcb->qiov->niov, offset);
+        break;
+    case QEMU_AIO_FLUSH:
+        io_uring_prep_fsync(sqes, fd, IORING_FSYNC_DATASYNC);
+        break;
+    default:
+        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\n",
+                        __func__, type);
+        abort();
+    }
+    io_uring_sqe_set_data(sqes, luringcb);
+
+    QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
+    s->io_q.in_queue++;
+
+    if (!s->io_q.blocked &&
+        (!s->io_q.plugged ||
+         s->io_q.in_flight + s->io_q.in_queue >= MAX_EVENTS)) {
+        return ioq_submit(s);
+    }
+    return 0;
+}
+
+int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
+                                  uint64_t offset, QEMUIOVector *qiov, int type)
+{
+    int ret;
+    LuringAIOCB luringcb = {
+        .co         = qemu_coroutine_self(),
+        .ret        = -EINPROGRESS,
+        .qiov       = qiov,
+        .is_read    = (type == QEMU_AIO_READ),
+    };
+
+    ret = luring_do_submit(fd, &luringcb, s, offset, type);
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
+void luring_detach_aio_context(LuringState *s, AioContext *old_context)
+{
+    aio_set_fd_handler(old_context, s->ring.ring_fd, false, NULL, NULL, NULL,
+                       s);
+    qemu_bh_delete(s->completion_bh);
+    s->aio_context = NULL;
+}
+
+void luring_attach_aio_context(LuringState *s, AioContext *new_context)
+{
+    s->aio_context = new_context;
+    s->completion_bh = aio_bh_new(new_context, qemu_luring_completion_bh, s);
+    aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
+                       qemu_luring_completion_cb, NULL, NULL, s);
+}
+
+LuringState *luring_init(Error **errp)
+{
+    int rc;
+    LuringState *s;
+    s = g_new0(LuringState, 1);
+    struct io_uring *ring = &s->ring;
+    rc = io_uring_queue_init(MAX_EVENTS, ring, 0);
+    if (rc < 0) {
+        error_setg_errno(errp, errno, "failed to init linux io_uring ring");
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
index 6b0d52f732..7ba9bd7874 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -49,6 +49,7 @@ typedef void IOHandler(void *opaque);
 struct Coroutine;
 struct ThreadPool;
 struct LinuxAioState;
+struct LuringState;
 
 struct AioContext {
     GSource source;
@@ -117,11 +118,19 @@ struct AioContext {
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
@@ -386,6 +395,11 @@ struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
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
index 0cb7cc74a2..71d7d1395f 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -55,6 +55,18 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
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
+void luring_detach_aio_context(LuringState *s, AioContext *old_context);
+void luring_attach_aio_context(LuringState *s, AioContext *new_context);
+void luring_io_plug(BlockDriverState *bs, LuringState *s);
+void luring_io_unplug(BlockDriverState *bs, LuringState *s);
+#endif
 
 #ifdef _WIN32
 typedef struct QEMUWin32AIOState QEMUWin32AIOState;
-- 
2.21.0


