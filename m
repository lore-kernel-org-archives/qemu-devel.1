Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A144C072B5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 23:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88B8216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 23:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRvUvTEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88B8216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32827 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEfe-0008Dz-2L
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 19:59:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEcT-0005iQ-6l
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEYw-0001lv-LI
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:52:56 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hTEYw-0001lW-Dy; Tue, 21 May 2019 19:52:54 -0400
Received: by mail-pf1-x443.google.com with SMTP id q17so271697pfq.8;
	Tue, 21 May 2019 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rZoSYzQBqztWJbTLj3mPksJxb8vygw+5t40niBgkeQo=;
	b=CRvUvTEZEC11SbSl6KIwrB9oY7h2SyAZJSHkrnml2UNlijjmOzEG0FXd15TUwl6Efl
	CiC+db0hspoXJlQLqmSD2fwrOTr+paT6HhL0gxrM200EHAqXvqfaZky6swnN91kH5/qO
	0EnL2k6hpQVgzY50TWI83PsEJgggkxmjjJwSuJ5YMyeWYVBGq8s05SZvIEMhxPCdEXgw
	RQCOh5RLv8PnyD+XAJ5JxYx3JghoBqK7VNfBOPfvwPigte9eVv9i3uknRiyCIO1ZYmUO
	bqC1i5/DF3tfYcwkvWBdWvuL25oLNcJt0ufD+KlwE4eEPASrA51qqCbaFoevWiunmVEy
	kCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=rZoSYzQBqztWJbTLj3mPksJxb8vygw+5t40niBgkeQo=;
	b=AHxv1GlRdnkX/Ja5YKYUzyi+1DacW/V+2J5k/7DAV7KlBwXN0Rq4wbcuff35eJaahd
	d4RXIT6tp27Fp5TYSvPCvlW4h1fw/a/4xYFGHVOFxltn38dgw97NNi5U7eWw1rBoLbL2
	3FQpPfBkZwvcF54ss/sQQkCclGb3EMNsoNFWN/J812zjsBEH2fZIVaG7OCSZjs5PGDH7
	3fBw2UNasvPABz/Drw2sQjQySMtoGY5MAN7WkO4VOwz1aF6f1/mSf06CZgKzbAVJeHIL
	Rj6vyi9Ui1IF++ChjRPFOBa+qazKrFo0yUwKvgj326HJXfN4srSGcdx6Xm0xqqbwXdRX
	uXAQ==
X-Gm-Message-State: APjAAAVjNcvVKLsyodznzkR8uVHR5kN8Mks537RZhBpeS44KiotdD0i2
	etCv9rrS268LHGj8akc1/apEVsf1ZqC9uA==
X-Google-Smtp-Source: APXvYqwmdIQgI1bW41DrLEY0Y54nKWTpDNK3D/wj5bORvizEmPG2DWVSGEwZ0D8luJ8Zm97zFLwYxQ==
X-Received: by 2002:a63:c046:: with SMTP id z6mr86021366pgi.387.1558482772885; 
	Tue, 21 May 2019 16:52:52 -0700 (PDT)
Received: from localhost.localdomain ([120.57.118.207])
	by smtp.gmail.com with ESMTPSA id
	e5sm51571752pgh.35.2019.05.21.16.52.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 16:52:52 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 05:22:12 +0530
Message-Id: <20190521235215.31341-7-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521235215.31341-1-mehta.aaru20@gmail.com>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [RFC PATCH 6/9] block/io_uring: implements interfaces
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
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/Makefile.objs |   2 +
 block/io_uring.c    | 385 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 387 insertions(+)
 create mode 100644 block/io_uring.c

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
index 0000000000..f8b0df90d4
--- /dev/null
+++ b/block/io_uring.c
@@ -0,0 +1,385 @@
+/*
+ * Linux io_uring support.
+ *
+ * Copyright (C) 2009 IBM, Corp.
+ * Copyright (C) 2009 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
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
+#include <liburing.h>
+
+/*
+ * Queue size (per-device).
+ *
+ * XXX: eventually we need to communicate this to the guest and/or make it
+ *      tunable by the guest.  If we get more outstanding requests at a time
+ *      than this we will get EAGAIN from io_submit which is communicated to
+ *      the guest as an I/O error.
+ */
+#define MAX_EVENTS 128
+
+struct qemu_luringcb {
+    BlockAIOCB common;
+    Coroutine *co;
+    LuringState *ctx;
+    struct io_uring_sqe sqeq;
+    int ret;
+    size_t nbytes;
+    QEMUIOVector *qiov;
+    bool is_read;
+    QSIMPLEQ_ENTRY(qemu_luringcb) next;
+};
+
+typedef struct {
+    int plugged;
+    unsigned int in_queue;
+    unsigned int in_flight;
+    bool blocked;
+    QSIMPLEQ_HEAD(, qemu_luringcb) pending;
+} LuringQueue;
+
+struct LuringState {
+    AioContext *aio_context;
+
+    struct io_uring ring;
+    EventNotifier e;
+
+    /* io queue for submit at batch.  Protected by AioContext lock. */
+    LuringQueue io_q;
+
+    /* I/O completion processing.  Only runs in I/O thread.  */
+    QEMUBH *completion_bh;
+    int event_idx;
+    int event_max;
+};
+
+static void ioq_submit(LuringState *s);
+
+static inline int32_t io_cqe_ret(struct io_uring_cqe *cqe)
+{
+    return cqe->res;
+}
+
+/**
+ * io_getevents_peek:
+ * @ring: io_uring instance
+ * @cqes: Completion event array
+
+ * Returns the number of completed events and sets a pointer
+ * on events queue.  This function does not update the head and tail.
+ */
+static inline unsigned int io_getevents_peek(struct io_uring *ring,
+                                             struct io_uring_cqe **cqes)
+{
+    unsigned int nr;
+    read_barrier();
+    struct io_uring_cq *cq_ring = &ring->cq;
+    unsigned int head = *cq_ring->khead & *cq_ring->kring_mask;
+    unsigned int tail = *cq_ring->ktail & *cq_ring->kring_mask;
+    nr = tail - head;
+    *cqes = ring->cq.cqes;
+    return nr;
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
+    qemu_bh_schedule(s->completion_bh);
+
+    while ((s->event_max = io_getevents_peek(&s->ring, &cqes))) {
+        for (s->event_idx = 0; s->event_idx < s->event_max; ) {
+                io_uring_cqe_seen(&s->ring, cqes);
+
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
+
+    qemu_luring_process_completions_and_submit(s);
+}
+
+static void qemu_luring_completion_cb(EventNotifier *e)
+{
+    LuringState *s = container_of(e, LuringState, e);
+
+    if (event_notifier_test_and_clear(&s->e)) {
+        qemu_luring_process_completions_and_submit(s);
+    }
+}
+
+static bool qemu_luring_poll_cb(void *opaque)
+{
+    EventNotifier *e = opaque;
+    LuringState *s = container_of(e, LuringState, e);
+    struct io_uring_cqe *cqes;
+
+    if (!io_getevents_peek(&s->ring, &cqes)) {
+        return false;
+    }
+
+    qemu_luring_process_completions_and_submit(s);
+    return true;
+}
+
+static const AIOCBInfo luring_aiocb_info = {
+    .aiocb_size         = sizeof(struct qemu_luringcb),
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
+    struct qemu_luringcb *aiocb;
+    QSIMPLEQ_HEAD(, qemu_luringcb) completed;
+
+    do {
+        if (s->io_q.in_flight >= MAX_EVENTS) {
+            break;
+        }
+        len = 0;
+        QSIMPLEQ_FOREACH(aiocb, &s->io_q.pending, next) {
+            if (s->io_q.in_flight + len++ >= MAX_EVENTS) {
+                break;
+            }
+            struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
+            if (sqes)  { /* Prep sqe for subission */
+                memset(sqes, 0, sizeof(*sqes));
+                sqes->opcode = aiocb->sqeq.opcode;
+                sqes->fd = aiocb->sqeq.fd;
+                if (sqes->opcode == IORING_OP_FSYNC) {
+                    sqes->fsync_flags = aiocb->sqeq.fsync_flags;
+                }
+                else {
+                    sqes->off = aiocb->sqeq.off;
+                    sqes->addr = aiocb->sqeq.addr;
+                    sqes->len = aiocb->sqeq.len;
+                }
+                QSIMPLEQ_REMOVE_HEAD(&s->io_q.pending, next);
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
+        QSIMPLEQ_SPLIT_AFTER(&s->io_q.pending, aiocb, next, &completed);
+    } while (!QSIMPLEQ_EMPTY(&s->io_q.pending));
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
+static int luring_do_submit(int fd, struct qemu_luringcb *luringcb,
+                            off_t offset, int type)
+{
+    LuringState *s = luringcb->ctx;
+    struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
+    if (!sqes) {
+        sqes = &luringcb->sqeq;
+        QSIMPLEQ_INSERT_TAIL(&s->io_q.pending, luringcb, next);
+    }
+    QEMUIOVector *qiov = luringcb->qiov;
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
+        fprintf(stderr, "%s: invalid AIO request type 0x%x.\n",
+                        __func__, type);
+        return -EIO;
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
+    struct qemu_luringcb luringcb = {
+        .co         = qemu_coroutine_self(),
+        .nbytes     = qiov->size,
+        .ctx        = s,
+        .ret        = -EINPROGRESS,
+        .is_read    = (type == QEMU_AIO_READ),
+        .qiov       = qiov,
+    };
+
+    ret = luring_do_submit(fd, &luringcb, offset, type);
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
+        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
+        BlockCompletionFunc *cb, void *opaque, int type)
+{
+    struct qemu_luringcb *luringcb;
+    off_t offset = sector_num * BDRV_SECTOR_SIZE;
+    int ret;
+
+    luringcb = qemu_aio_get(&luring_aiocb_info, bs, cb, opaque);
+    luringcb->nbytes = nb_sectors * BDRV_SECTOR_SIZE;
+    luringcb->ctx = s;
+    luringcb->ret = -EINPROGRESS;
+    luringcb->is_read = (type == QEMU_AIO_READ);
+    luringcb->qiov = qiov;
+
+    ret = luring_do_submit(fd, luringcb, offset, type);
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
+    aio_set_event_notifier(old_context, &s->e, false, NULL, NULL);
+    qemu_bh_delete(s->completion_bh);
+    s->aio_context = NULL;
+}
+
+void luring_attach_aio_context(LuringState *s, AioContext *new_context)
+{
+    s->aio_context = new_context;
+    s->completion_bh = aio_bh_new(new_context, qemu_luring_completion_bh, s);
+    aio_set_event_notifier(new_context, &s->e, false,
+                           qemu_luring_completion_cb,
+                           qemu_luring_poll_cb);
+}
+
+LuringState *luring_init(Error **errp)
+{
+    int rc;
+    LuringState *s;
+    s = g_malloc0(sizeof(*s));
+    rc = event_notifier_init(&s->e, false);
+    if (rc < 0) {
+        error_setg_errno(errp, -rc, "failed to to initialize event notifier");
+        goto out_free_state;
+    }
+
+    struct io_uring *ring = &s->ring;
+    rc =  io_uring_queue_init(MAX_EVENTS, ring, 0);
+    if (rc < 0) {
+        error_setg_errno(errp, -rc, "failed to create linux io_uring queue");
+        goto out_close_efd;
+    }
+
+    ioq_init(&s->io_q);
+    aio_set_fd_handler(s->aio_context, ring->ring_fd, false,
+                       (IOHandler *)qemu_luring_completion_cb, NULL, NULL, &s);
+    return s;
+
+out_close_efd:
+    event_notifier_cleanup(&s->e);
+out_free_state:
+    g_free(s);
+    return NULL;
+}
+
+void luring_cleanup(LuringState *s)
+{
+    event_notifier_cleanup(&s->e);
+    io_uring_queue_exit(&s->ring);
+    g_free(s);
+}
--
2.17.1

