Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED141C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3652089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="MapfuRNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3652089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haf35-00084e-Vg
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fam@euphon.net>) id 1haeni-0003WK-O3
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fam@euphon.net>) id 1haenW-0002zS-Ev
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:18:44 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17976
 helo=sender1.zoho.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fam@euphon.net>)
 id 1haenP-0002rY-7j; Tue, 11 Jun 2019 07:18:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560251839; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=M7DyTI0wnhBnr4/F5e56m3YLtuqaBMzmjGBTwx2d7fAVw1NE12Jo3s36ESJW4OnvwBgjQh11lI8lQSUs2hNu/JMASDj12SqYn2udbK/C8mYrABOecgzg51VDWvABi4pRH5lLX6DJKH/vXsYdrFuH+1ODJ2Jm3V0QEsy4bLjwWkU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1560251839;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results;
 bh=fvFziQv307w1cPzZ1ySZopJYIELMOoQzuGSpGbjC4rw=; 
 b=VQRtALNLiOxrIQpW4KUDZ8IhaD3SyZ+lsdsrz6cS/A0qQgE3TP9HONQLek0xCjfs6nkutpnVvTYQrznSucPJqEhr9iNNolfSYZgCZhxweZue98XskqNfhM6Vduz+NSzZbfH33ZitlopipIg9IQ1ZJYe4pcvpLN3KaYI7dHhU9pI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1560251839; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 l=13433; bh=fvFziQv307w1cPzZ1ySZopJYIELMOoQzuGSpGbjC4rw=;
 b=MapfuRNSFO1V9S2h96bFKC24GFUYZ/5POp0BYZ8Kz2PAwJbNdDB3rLGglI7QVWLB
 GVvgH9+BDPzcx1GISAoSRht1YToVYTLiRgaDKrTh8ZZ5XzJWcw/NsbmiNB0W47zuD1s
 ifQS5N1y7Z+7XpTxBQmn5CiaOVtMNUUzv+o5m5qo=
Received: from localhost (120.52.147.48 [120.52.147.48]) by mx.zoho.com.cn
 with SMTPS id 15602518367371005.4267481207212;
 Tue, 11 Jun 2019 19:17:16 +0800 (CST)
Date: Tue, 11 Jun 2019 19:17:14 +0800
From: Fam Zheng <fam@euphon.net>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190611111714.wshlk6fddh34atfp@debian>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-5-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610134905.22294-5-mehta.aaru20@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ZohoCNMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 163.53.93.243
Subject: Re: [Qemu-devel] [PATCH v5 04/12] block/io_uring: implements
 interfaces for io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 06/10 19:18, Aarushi Mehta wrote:
> Aborts when sqe fails to be set as sqes cannot be returned to the ring.
> 
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  MAINTAINERS             |   7 +
>  block/Makefile.objs     |   3 +
>  block/io_uring.c        | 314 ++++++++++++++++++++++++++++++++++++++++
>  include/block/aio.h     |  16 +-
>  include/block/raw-aio.h |  12 ++
>  5 files changed, 351 insertions(+), 1 deletion(-)
>  create mode 100644 block/io_uring.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7be1225415..49f896796e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2516,6 +2516,13 @@ F: block/file-posix.c
>  F: block/file-win32.c
>  F: block/win32-aio.c
>  
> +Linux io_uring
> +M: Aarushi Mehta <mehta.aaru20@gmail.com>
> +R: Stefan Hajnoczi <stefan@redhat.com>
> +L: qemu-block@nongnu.org
> +S: Maintained
> +F: block/io_uring.c
> +
>  qcow2
>  M: Kevin Wolf <kwolf@redhat.com>
>  M: Max Reitz <mreitz@redhat.com>
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index ae11605c9f..8fde7a23a5 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -18,6 +18,7 @@ block-obj-y += block-backend.o snapshot.o qapi.o
>  block-obj-$(CONFIG_WIN32) += file-win32.o win32-aio.o
>  block-obj-$(CONFIG_POSIX) += file-posix.o
>  block-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
> +block-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
>  block-obj-y += null.o mirror.o commit.o io.o create.o
>  block-obj-y += throttle-groups.o
>  block-obj-$(CONFIG_LINUX) += nvme.o
> @@ -61,5 +62,7 @@ block-obj-$(if $(CONFIG_LZFSE),m,n) += dmg-lzfse.o
>  dmg-lzfse.o-libs   := $(LZFSE_LIBS)
>  qcow.o-libs        := -lz
>  linux-aio.o-libs   := -laio
> +io_uring.o-cflags  := $(LINUX_IO_URING_CFLAGS)
> +io_uring.o-libs    := $(LINUX_IO_URING_LIBS)
>  parallels.o-cflags := $(LIBXML2_CFLAGS)
>  parallels.o-libs   := $(LIBXML2_LIBS)
> diff --git a/block/io_uring.c b/block/io_uring.c
> new file mode 100644
> index 0000000000..f327c7ef96
> --- /dev/null
> +++ b/block/io_uring.c
> @@ -0,0 +1,314 @@
> +/*
> + * Linux io_uring support.
> + *
> + * Copyright (C) 2009 IBM, Corp.
> + * Copyright (C) 2009 Red Hat, Inc.
> + * Copyright (C) 2019 Aarushi Mehta
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include <liburing.h>
> +#include "qemu-common.h"
> +#include "block/aio.h"
> +#include "qemu/queue.h"
> +#include "block/block.h"
> +#include "block/raw-aio.h"
> +#include "qemu/coroutine.h"
> +#include "qapi/error.h"
> +
> +#define MAX_EVENTS 128
> +
> +typedef struct LuringAIOCB {

I have to say it is a good name.

> +    Coroutine *co;
> +    struct io_uring_sqe sqeq;
> +    ssize_t ret;
> +    QEMUIOVector *qiov;
> +    bool is_read;
> +    QSIMPLEQ_ENTRY(LuringAIOCB) next;
> +} LuringAIOCB;
> +
> +typedef struct LuringQueue {
> +    int plugged;
> +    unsigned int in_queue;
> +    unsigned int in_flight;
> +    bool blocked;
> +    QSIMPLEQ_HEAD(, LuringAIOCB) sq_overflow;
> +} LuringQueue;
> +
> +typedef struct LuringState {
> +    AioContext *aio_context;
> +
> +    struct io_uring ring;
> +
> +    /* io queue for submit at batch.  Protected by AioContext lock. */
> +    LuringQueue io_q;
> +
> +    /* I/O completion processing.  Only runs in I/O thread.  */
> +    QEMUBH *completion_bh;
> +} LuringState;
> +
> +/**
> + * ioq_submit:
> + * @s: AIO state
> + *
> + * Queues pending sqes and submits them
> + *
> + */
> +static int ioq_submit(LuringState *s);
> +
> +/**
> + * qemu_luring_process_completions:
> + * @s: AIO state
> + *
> + * Fetches completed I/O requests, consumes cqes and invokes their callbacks.
> + *
> + */
> +static void qemu_luring_process_completions(LuringState *s)
> +{
> +    struct io_uring_cqe *cqes;
> +    int ret;
> +
> +    /*
> +     * Request completion callbacks can run the nested event loop.
> +     * Schedule ourselves so the nested event loop will "see" remaining
> +     * completed requests and process them.  Without this, completion
> +     * callbacks that wait for other requests using a nested event loop
> +     * would hang forever.
> +     */
> +    qemu_bh_schedule(s->completion_bh);
> +
> +    while (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
> +        if (!cqes) {
> +            break;
> +        }
> +        LuringAIOCB *luringcb = io_uring_cqe_get_data(cqes);
> +        ret = cqes->res;

Declarations should be in the beginning of the code block.

> +
> +        if (ret == luringcb->qiov->size) {
> +            ret = 0;
> +        } else if (ret >= 0) {
> +            /* Short Read/Write */
> +            if (luringcb->is_read) {
> +                /* Read, pad with zeroes */
> +                qemu_iovec_memset(luringcb->qiov, ret, 0,
> +                luringcb->qiov->size - ret);

Should you check that (ret < luringcb->qiov->size) since ret is from external?

Either way, ret should be assigned 0, I think.

> +            } else {
> +                ret = -ENOSPC;;

s/;;/;/

> +            }
> +        }
> +        luringcb->ret = ret;
> +
> +        io_uring_cqe_seen(&s->ring, cqes);
> +        cqes = NULL;
> +        /* Change counters one-by-one because we can be nested. */
> +        s->io_q.in_flight--;
> +
> +        /*
> +         * If the coroutine is already entered it must be in ioq_submit()
> +         * and will notice luringcb->ret has been filled in when it
> +         * eventually runs later. Coroutines cannot be entered recursively
> +         * so avoid doing that!
> +         */
> +        if (!qemu_coroutine_entered(luringcb->co)) {
> +            aio_co_wake(luringcb->co);
> +        }
> +    }
> +    qemu_bh_cancel(s->completion_bh);
> +}
> +
> +static void qemu_luring_process_completions_and_submit(LuringState *s)
> +{
> +    aio_context_acquire(s->aio_context);
> +    qemu_luring_process_completions(s);
> +
> +    if (!s->io_q.plugged && s->io_q.in_queue > 0) {
> +        ioq_submit(s);
> +    }
> +    aio_context_release(s->aio_context);
> +}
> +
> +static void qemu_luring_completion_bh(void *opaque)
> +{
> +    LuringState *s = opaque;
> +    qemu_luring_process_completions_and_submit(s);
> +}
> +
> +static void qemu_luring_completion_cb(void *opaque)
> +{
> +    LuringState *s = opaque;
> +    qemu_luring_process_completions_and_submit(s);
> +}
> +
> +static void ioq_init(LuringQueue *io_q)
> +{
> +    QSIMPLEQ_INIT(&io_q->sq_overflow);
> +    io_q->plugged = 0;
> +    io_q->in_queue = 0;
> +    io_q->in_flight = 0;
> +    io_q->blocked = false;
> +}
> +
> +static int ioq_submit(LuringState *s)
> +{
> +    int ret = 0;
> +    LuringAIOCB *luringcb, *luringcb_next;
> +
> +    while (s->io_q.in_queue > 0) {
> +        QSIMPLEQ_FOREACH_SAFE(luringcb, &s->io_q.sq_overflow, next,
> +                              luringcb_next) {
> +            struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
> +            if (!sqes) {
> +                break;
> +            }
> +            /* Prep sqe for submission */
> +            *sqes = luringcb->sqeq;
> +            QSIMPLEQ_REMOVE_HEAD(&s->io_q.sq_overflow, next);
> +        }
> +        ret =  io_uring_submit(&s->ring);

s/  / /

> +        /* Prevent infinite loop if submission is refused */
> +        if (ret <= 0) {
> +            if (ret == -EAGAIN) {
> +                continue;
> +            }
> +            break;
> +        }
> +        s->io_q.in_flight += ret;
> +        s->io_q.in_queue  -= ret;
> +    }
> +    s->io_q.blocked = (s->io_q.in_queue > 0);

I'm confused about s->io_q.blocked. ioq_submit is where it gets updated, but
if it becomes true, calling ioq_submit will be fenced. So how does it get
cleared?

> +
> +    if (s->io_q.in_flight) {
> +        /*
> +         * We can try to complete something just right away if there are
> +         * still requests in-flight.
> +         */
> +        qemu_luring_process_completions(s);
> +    }
> +    return ret;
> +}
> +
> +void luring_io_plug(BlockDriverState *bs, LuringState *s)
> +{
> +    s->io_q.plugged++;
> +}
> +
> +void luring_io_unplug(BlockDriverState *bs, LuringState *s)
> +{
> +    assert(s->io_q.plugged);
> +    if (--s->io_q.plugged == 0 &&
> +        !s->io_q.blocked && s->io_q.in_queue > 0) {
> +        ioq_submit(s);
> +    }
> +}
> +
> +/**
> + * luring_do_submit:
> + * @fd: file descriptor for I/O
> + * @luringcb: AIO control block
> + * @s: AIO state
> + * @offset: offset for request
> + * @type: type of request
> + *
> + * Fetches sqes from ring, adds to pending queue and preps them
> + *
> + */
> +static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
> +                            uint64_t offset, int type)
> +{
> +    struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
> +    if (!sqes) {
> +        sqes = &luringcb->sqeq;
> +        QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);
> +    }
> +
> +    switch (type) {
> +    case QEMU_AIO_WRITE:
> +        io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
> +                             luringcb->qiov->niov, offset);
> +        break;
> +    case QEMU_AIO_READ:
> +        io_uring_prep_readv(sqes, fd, luringcb->qiov->iov,
> +                            luringcb->qiov->niov, offset);
> +        break;
> +    case QEMU_AIO_FLUSH:
> +        io_uring_prep_fsync(sqes, fd, 0);
> +        break;
> +    default:
> +        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\n",
> +                        __func__, type);
> +        abort();
> +    }
> +    io_uring_sqe_set_data(sqes, luringcb);
> +    s->io_q.in_queue++;
> +
> +    if (!s->io_q.blocked &&
> +        (!s->io_q.plugged ||
> +         s->io_q.in_flight + s->io_q.in_queue >= MAX_EVENTS)) {
> +        return ioq_submit(s);
> +    }
> +    return 0;
> +}
> +
> +int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
> +                                uint64_t offset, QEMUIOVector *qiov, int type)
> +{
> +    int ret;
> +    LuringAIOCB luringcb = {
> +        .co         = qemu_coroutine_self(),
> +        .ret        = -EINPROGRESS,
> +        .qiov       = qiov,
> +        .is_read    = (type == QEMU_AIO_READ),
> +    };
> +
> +    ret = luring_do_submit(fd, &luringcb, s, offset, type);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (luringcb.ret == -EINPROGRESS) {
> +        qemu_coroutine_yield();
> +    }
> +    return luringcb.ret;
> +}
> +
> +void luring_detach_aio_context(LuringState *s, AioContext *old_context)
> +{
> +    aio_set_fd_handler(old_context, s->ring.ring_fd, false, NULL, NULL, NULL,
> +                       s);
> +    qemu_bh_delete(s->completion_bh);
> +    s->aio_context = NULL;
> +}
> +
> +void luring_attach_aio_context(LuringState *s, AioContext *new_context)
> +{
> +    s->aio_context = new_context;
> +    s->completion_bh = aio_bh_new(new_context, qemu_luring_completion_bh, s);
> +    aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
> +                       qemu_luring_completion_cb, NULL, NULL, s);
> +}
> +
> +LuringState *luring_init(Error **errp)
> +{
> +    int rc;
> +    LuringState *s;
> +    s = g_malloc0(sizeof(*s));

You can use g_new0() to be more concise.

> +    struct io_uring *ring = &s->ring;
> +    rc =  io_uring_queue_init(MAX_EVENTS, ring, 0);

s/  / /

> +    if (rc < 0) {
> +        error_setg_errno(errp, errno, "failed to init linux io_uring ring");
> +        g_free(s);
> +        return NULL;
> +    }
> +
> +    ioq_init(&s->io_q);
> +    return s;
> +
> +}
> +
> +void luring_cleanup(LuringState *s)
> +{
> +    io_uring_queue_exit(&s->ring);
> +    g_free(s);
> +}
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 0ca25dfec6..9da3fd9793 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -50,6 +50,7 @@ typedef void IOHandler(void *opaque);
>  struct Coroutine;
>  struct ThreadPool;
>  struct LinuxAioState;
> +struct LuringState;
>  
>  struct AioContext {
>      GSource source;
> @@ -118,11 +119,19 @@ struct AioContext {
>      struct ThreadPool *thread_pool;
>  
>  #ifdef CONFIG_LINUX_AIO
> -    /* State for native Linux AIO.  Uses aio_context_acquire/release for
> +    /*
> +     * State for native Linux AIO.  Uses aio_context_acquire/release for
>       * locking.
>       */
>      struct LinuxAioState *linux_aio;
>  #endif
> +#ifdef CONFIG_LINUX_IO_URING
> +    /*
> +     * State for Linux io_uring.  Uses aio_context_acquire/release for
> +     * locking.
> +     */
> +    struct LuringState *linux_io_uring;
> +#endif
>  
>      /* TimerLists for calling timers - one per clock type.  Has its own
>       * locking.
> @@ -387,6 +396,11 @@ struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
>  /* Return the LinuxAioState bound to this AioContext */
>  struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
>  
> +/* Setup the LuringState bound to this AioContext */
> +struct LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp);
> +
> +/* Return the LuringState bound to this AioContext */
> +struct LuringState *aio_get_linux_io_uring(AioContext *ctx);
>  /**
>   * aio_timer_new_with_attrs:
>   * @ctx: the aio context
> diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
> index 0cb7cc74a2..71d7d1395f 100644
> --- a/include/block/raw-aio.h
> +++ b/include/block/raw-aio.h
> @@ -55,6 +55,18 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
>  void laio_io_plug(BlockDriverState *bs, LinuxAioState *s);
>  void laio_io_unplug(BlockDriverState *bs, LinuxAioState *s);
>  #endif
> +/* io_uring.c - Linux io_uring implementation */
> +#ifdef CONFIG_LINUX_IO_URING
> +typedef struct LuringState LuringState;
> +LuringState *luring_init(Error **errp);
> +void luring_cleanup(LuringState *s);
> +int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
> +                                uint64_t offset, QEMUIOVector *qiov, int type);
> +void luring_detach_aio_context(LuringState *s, AioContext *old_context);
> +void luring_attach_aio_context(LuringState *s, AioContext *new_context);
> +void luring_io_plug(BlockDriverState *bs, LuringState *s);
> +void luring_io_unplug(BlockDriverState *bs, LuringState *s);
> +#endif
>  
>  #ifdef _WIN32
>  typedef struct QEMUWin32AIOState QEMUWin32AIOState;
> -- 
> 2.17.1
> 


