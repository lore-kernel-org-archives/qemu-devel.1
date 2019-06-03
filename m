Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D64C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E4D27F8D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbQqmj0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E4D27F8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34702 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmQb-0003C1-Az
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:51:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmKs-0007F5-13
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmF2-0007aD-9D
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:39:10 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hXmF2-0007Y3-1I; Mon, 03 Jun 2019 08:39:08 -0400
Received: by mail-pg1-x542.google.com with SMTP id 20so8228022pgr.4;
	Mon, 03 Jun 2019 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=G3ZSglryhsNUt/h90DmGkj8h+92M8tgHTqIsTGOKnJ4=;
	b=bbQqmj0M7cOWbQWWIPWYPxGWnOGdmAY3VcDaM2ex39NkPAZEMXi5LUPRV6VdCZIA59
	j8Mv+hn/T/T6cZOtrDOSnus2XUNSzWYJTTpBAwdrjzFV4dk61s4j9egPO0v7zKmuinYR
	X7hK0r6HtNp2qctI1xldnIPp2PYILG/xfA/RLq5g+N6XHSYLEMp6HkIF2c1GbEdjOG+2
	/wBdJlN7ZlSAEKljgf6MEtbOEnn3BR58mlCzBDGSfeUAa/d5Ev7jjGAeVkdqnfALLrdC
	kLD6OFk7XKoht4UNS9/qgOQ/QK8QG9VsLIJLyp+rfv3Yn/zDKHjR6CTzQB2LmPKMkX5N
	3ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=G3ZSglryhsNUt/h90DmGkj8h+92M8tgHTqIsTGOKnJ4=;
	b=cel83nhjVwLCo34cxh1lhjLj1mGga/zvQUYBzLwvE8+IB02jf1Ig02FsiH2Yqhmw9m
	oxA+ClAz+VfQUNIE2xkPuFPjJGgBOdQLzRKRNdfeLlql+r8Z3oq8LCqlYUNoYb/if//I
	tY6fKzf3nnvNNVZNZgvFzmaIpPJdykTDpF9gUT5FC8/XYb1qpXdFi+4yPxIjKqBlnDtM
	baLR0ZA+QyE0VJ0YFFdM/mrWHDW2zmZUUaRgjSFGJdK3JYxtaazEcBXw0IWIRkBsbbKz
	egRzEWU6oM2ykJVoBC80CR6Ak6I5Nt2JVQ1SmFY3zEoPDsA9JAHNnkbnugip2mSCa6m4
	aR/Q==
X-Gm-Message-State: APjAAAXSry8/eVIB/HKi2XtMdlggG0kn17/hIN7d9r7ShlYS4nZXuhkF
	AK32NypGt7/1tCy/1ZKhEfzhtaychO/Q1Q==
X-Google-Smtp-Source: APXvYqwPmxjEzBQBnHbLmH4nUxGRfPhlFVJkEFZkGI7DolvYFYe7Af9idnkMv1chUbPP/m3eUNa07w==
X-Received: by 2002:a65:6551:: with SMTP id a17mr25787591pgw.1.1559565546585; 
	Mon, 03 Jun 2019 05:39:06 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
	by smtp.gmail.com with ESMTPSA id
	k14sm34860257pga.5.2019.06.03.05.39.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 05:39:05 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 18:08:18 +0530
Message-Id: <20190603123823.32661-5-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603123823.32661-1-mehta.aaru20@gmail.com>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v4 4/9] block/io_uring: implements interfaces
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aborts when sqes cannot be set as sqes cannot be returned to ring.
Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 MAINTAINERS             |   7 +
 block/Makefile.objs     |   3 +
 block/io_uring.c        | 315 ++++++++++++++++++++++++++++++++++++++++
 include/block/aio.h     |  16 +-
 include/block/raw-aio.h |  12 ++
 5 files changed, 352 insertions(+), 1 deletion(-)
 create mode 100644 block/io_uring.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a96829ea83..dcaddec21f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2515,6 +2515,13 @@ F: block/file-posix.c
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
index ae11605c9f..8fde7a23a5 100644
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
index 0000000000..536a9fbe87
--- /dev/null
+++ b/block/io_uring.c
@@ -0,0 +1,315 @@
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
+ * qemu_luring_process_completions:
+ * @s: AIO state
+ *
+ * Fetches completed I/O requests, consumes cqes and invokes their callbacks.
+ *
+ */
+static void qemu_luring_process_completions(LuringState *s)
+{
+    struct io_uring_cqe *cqes;
+    int ret;
+
+    /*
+     * Request completion callbacks can run the nested event loop.
+     * Schedule ourselves so the nested event loop will "see" remaining
+     * completed requests and process them.  Without this, completion
+     * callbacks that wait for other requests using a nested event loop
+     * would hang forever.
+     */
+    qemu_bh_schedule(s->completion_bh);
+
+    while (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
+        if (!cqes) {
+            break;
+        }
+        LuringAIOCB *luringcb = io_uring_cqe_get_data(cqes);
+        read_barrier();
+        ret = cqes->res;
+
+        if (ret == luringcb->qiov->size) {
+            ret = 0;
+        } else if (ret >= 0) {
+            /* Short Read/Write */
+            if (luringcb->is_read) {
+                /* Read, pad with zeroes */
+                qemu_iovec_memset(luringcb->qiov, ret, 0,
+                luringcb->qiov->size - ret);
+            } else {
+                ret = -ENOSPC;;
+            }
+        }
+        luringcb->ret = ret;
+
+        io_uring_cqe_seen(&s->ring, cqes);
+        cqes = NULL;
+        /* Change counters one-by-one because we can be nested. */
+        s->io_q.in_flight--;
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
+static void ioq_init(LuringQueue *io_q)
+{
+    QSIMPLEQ_INIT(&io_q->sq_overflow);
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
+        QSIMPLEQ_FOREACH_SAFE(luringcb, &s->io_q.sq_overflow, next,
+                              luringcb_next) {
+            struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
+            if (!sqes) {
+                break;
+            }
+            /* Prep sqe for submission */
+            *sqes = luringcb->sqeq;
+            QSIMPLEQ_REMOVE_HEAD(&s->io_q.sq_overflow, next);
+        }
+        ret =  io_uring_submit(&s->ring);
+        /* Prevent infinite loop if submission is repeatedly refused */
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
+        qemu_luring_process_completions(s);
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
+    struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
+    if (!sqes) {
+        sqes = &luringcb->sqeq;
+        QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);
+    }
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
+        return ioq_submit(s);
+    }
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
+    s = g_malloc0(sizeof(*s));
+    struct io_uring *ring = &s->ring;
+    rc =  io_uring_queue_init(MAX_EVENTS, ring, 0);
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
index ba223dd1f1..1885b086e6 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -58,6 +58,18 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
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
2.17.1


