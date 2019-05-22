Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F50C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C040320881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V056N645"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C040320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTRp-0003o8-Vw
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:46:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTTPs-0002QR-DE
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTTPn-0007kK-Ib
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:44:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hTTPj-0006N6-F7; Wed, 22 May 2019 11:44:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id q15so2737010wmj.0;
	Wed, 22 May 2019 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=UKdVLPaQlHDefBXUkYxJiqnMFEMZflVufG83ttROQyI=;
	b=V056N645w1NJEQutbDDZweV8EEb3HdL4HCiT7j9s0UEIiJ/2160zR07KsP3WqM1AVC
	SrEC1RooRtnb+1Ayu7q0LJhGFVrUb9CmEfn6tks6eVoFZazvjnThlePuo1KHj5jx35/t
	NT1BFP6A9lZMEbkTvgKkds5pif1KJJM5k5Xv6+xNuRufJKs0h7ubJwRN8+NBJ4d5h5oA
	RUZMsOExt5sYFDGebFEnX1ljIk3brTmxGGFI+B4x2QSB2NzUQWiMDZuTcajkeRYhi0E0
	XRo4u2+Kym4Hi7ARWwK6zNp4dIRPKsNI+/h4g7wOrSNkYrhIbBGo0edogTCfRVgeoCOc
	bK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=UKdVLPaQlHDefBXUkYxJiqnMFEMZflVufG83ttROQyI=;
	b=sHg3cWQFOptu4KbssYs+GvHN8Bd78GWR0vvSyPi3iFvxnZkMw9OPInNrfe5NAwFGxz
	kvPSdlNG8iLgr0JVoEuxVh0r7ciXLy3N5so3OVCQGgpUgZB9I4IIXKwTu7WRVsgcqOtQ
	qSHuwzwG96uipyQ+nsZzfcP1g5Lkc0+j92Stz40MbCjJYzE7vPWe4/OkLL8vKjtqHJwa
	N0t7U2hsKPKcAQjJPKTtxrNQW8A2/TAF8jsTOmi78ib/U+igDVjTTZdQERk0EXsNBdsg
	H6B187SbCB2X5ORh+PEtwHVZXJzDX2Hdecpvm2bCFATC0gd1J9go4MHPyhTu8W7juC/j
	VoVg==
X-Gm-Message-State: APjAAAVyqLK/JXdXQrrXKoJz16a37R6RkH/J9Fo1OvZ7hrQ9TmIiGnUd
	8j7ev0vTrcllbX8NCRMNF9A=
X-Google-Smtp-Source: APXvYqy5K3wK0ynoMqhuz0vAQjWe7ZlmtFA+LGFdBKcaPhXTBxEtfuPvGYlJAgF46VlIL6W+ZzPI9w==
X-Received: by 2002:a1c:7dd6:: with SMTP id y205mr7800475wmc.90.1558539840759; 
	Wed, 22 May 2019 08:44:00 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	f65sm3347290wmg.45.2019.05.22.08.43.59
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 08:43:59 -0700 (PDT)
Date: Wed, 22 May 2019 16:43:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190522154359.GM27900@stefanha-x1.localdomain>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
	<20190521235215.31341-7-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ICrdrp3pM9DyZLTK"
Content-Disposition: inline
In-Reply-To: <20190521235215.31341-7-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [RFC PATCH 6/9] block/io_uring: implements
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
Cc: saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ICrdrp3pM9DyZLTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 05:22:12AM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  block/Makefile.objs |   2 +
>  block/io_uring.c    | 385 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 387 insertions(+)
>  create mode 100644 block/io_uring.c
>=20
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 7a81892a52..262d413c6d 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -18,6 +18,7 @@ block-obj-y +=3D block-backend.o snapshot.o qapi.o
>  block-obj-$(CONFIG_WIN32) +=3D file-win32.o win32-aio.o
>  block-obj-$(CONFIG_POSIX) +=3D file-posix.o
>  block-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
> +block-obj-$(CONFIG_LINUX_IO_URING) +=3D io_uring.o
>  block-obj-y +=3D null.o mirror.o commit.o io.o create.o
>  block-obj-y +=3D throttle-groups.o
>  block-obj-$(CONFIG_LINUX) +=3D nvme.o
> @@ -61,5 +62,6 @@ block-obj-$(if $(CONFIG_LZFSE),m,n) +=3D dmg-lzfse.o
>  dmg-lzfse.o-libs   :=3D $(LZFSE_LIBS)
>  qcow.o-libs        :=3D -lz
>  linux-aio.o-libs   :=3D -laio
> +io_uring.o-libs    :=3D -luring
>  parallels.o-cflags :=3D $(LIBXML2_CFLAGS)
>  parallels.o-libs   :=3D $(LIBXML2_LIBS)
> diff --git a/block/io_uring.c b/block/io_uring.c
> new file mode 100644
> index 0000000000..f8b0df90d4
> --- /dev/null
> +++ b/block/io_uring.c
> @@ -0,0 +1,385 @@
> +/*
> + * Linux io_uring support.
> + *
> + * Copyright (C) 2009 IBM, Corp.
> + * Copyright (C) 2009 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "block/aio.h"
> +#include "qemu/queue.h"
> +#include "block/block.h"
> +#include "block/raw-aio.h"
> +#include "qemu/event_notifier.h"
> +#include "qemu/coroutine.h"
> +#include "qapi/error.h"
> +
> +#include <liburing.h>

Please include system headers (<>) after "qemu/osdep.h" and before other
QEMU headers.  See the ./HACKING file "1.2. Include directives" for more
info.

> +
> +/*
> + * Queue size (per-device).
> + *
> + * XXX: eventually we need to communicate this to the guest and/or make =
it
> + *      tunable by the guest.  If we get more outstanding requests at a =
time
> + *      than this we will get EAGAIN from io_submit which is communicate=
d to
> + *      the guest as an I/O error.
> + */

This comment mentions Linux AIO io_submit() and needs to be updated.
The issue mentioned shouldn't apply since io_q.pending holds requests
that cannot be issued to the kernel while the submission queue is
exhausted.

> +#define MAX_EVENTS 128
> +
> +struct qemu_luringcb {

Please follow QEMU coding style (using typedef and naming structs
LikeThis):

  typedef struct LuringAIOCB {
      ...
  } LuringAIOCB;

> +    BlockAIOCB common;
> +    Coroutine *co;
> +    LuringState *ctx;

Please remove this field and pass it as an argument to
luring_do_submit() instead.  ctx isn't used after request submission.

> +    struct io_uring_sqe sqeq;
> +    int ret;

This field is not written in the completion callback.  This means the
luring_co_submit() is currently broken!

> +    size_t nbytes;

This field is written but never read.  Please remove it.

> +    QEMUIOVector *qiov;

Please remove this field and pass it as an argument to
luring_do_submit() instead.  qiov isn't used after request submission.

> +    bool is_read;

This field is written but never read.  Please remove it.

> +    QSIMPLEQ_ENTRY(qemu_luringcb) next;
> +};
> +
> +typedef struct {
> +    int plugged;
> +    unsigned int in_queue;
> +    unsigned int in_flight;
> +    bool blocked;
> +    QSIMPLEQ_HEAD(, qemu_luringcb) pending;
> +} LuringQueue;
> +
> +struct LuringState {
> +    AioContext *aio_context;
> +
> +    struct io_uring ring;
> +    EventNotifier e;

Where is this EventNotifier used?  I thought ring->ring_fd is the file
descriptor that we monitor.

> +
> +    /* io queue for submit at batch.  Protected by AioContext lock. */
> +    LuringQueue io_q;
> +
> +    /* I/O completion processing.  Only runs in I/O thread.  */
> +    QEMUBH *completion_bh;
> +    int event_idx;
> +    int event_max;
> +};
> +
> +static void ioq_submit(LuringState *s);
> +
> +static inline int32_t io_cqe_ret(struct io_uring_cqe *cqe)
> +{
> +    return cqe->res;
> +}
> +
> +/**
> + * io_getevents_peek:
> + * @ring: io_uring instance
> + * @cqes: Completion event array
> +
> + * Returns the number of completed events and sets a pointer
> + * on events queue.  This function does not update the head and tail.
> + */
> +static inline unsigned int io_getevents_peek(struct io_uring *ring,
> +                                             struct io_uring_cqe **cqes)
> +{
> +    unsigned int nr;
> +    read_barrier();
> +    struct io_uring_cq *cq_ring =3D &ring->cq;
> +    unsigned int head =3D *cq_ring->khead & *cq_ring->kring_mask;
> +    unsigned int tail =3D *cq_ring->ktail & *cq_ring->kring_mask;
> +    nr =3D tail - head;
> +    *cqes =3D ring->cq.cqes;
> +    return nr;
> +}

Is it possible to use liburing's io_uring_peek_cqe() instead?  I don't
see a need to know the number of available completed requests.  We can
just collect completed requests one-by-one.

> +
> +/**
> + * qemu_luring_process_completions:
> + * @s: AIO state
> + *
> + * Fetches completed I/O requests, consumes cqes and invokes their callb=
acks.
> + *
> + */
> +static void qemu_luring_process_completions(LuringState *s)
> +{
> +    struct io_uring_cqe *cqes;
> +    qemu_bh_schedule(s->completion_bh);
> +
> +    while ((s->event_max =3D io_getevents_peek(&s->ring, &cqes))) {
> +        for (s->event_idx =3D 0; s->event_idx < s->event_max; ) {
> +                io_uring_cqe_seen(&s->ring, cqes);
> +
> +            /* Change counters one-by-one because we can be nested. */
> +            s->io_q.in_flight--;
> +            s->event_idx++;
> +        }
> +    }

Wait, where does this function invoke the aiocb callback?  Something is
missing here.  I guess later patches do it but this patch is incomplete
without it...

> +
> +    qemu_bh_cancel(s->completion_bh);
> +
> +    /*
> +     *If we are nested we have to notify the level above that we are done
> +     * by setting event_max to zero, upper level will then jump out of i=
t's
> +     * own `for` loop.  If we are the last all counters dropped to zero.
> +     */
> +    s->event_max =3D 0;
> +    s->event_idx =3D 0;
> +}
> +
> +static void qemu_luring_process_completions_and_submit(LuringState *s)
> +{
> +    aio_context_acquire(s->aio_context);
> +    qemu_luring_process_completions(s);
> +
> +    if (!s->io_q.plugged && !QSIMPLEQ_EMPTY(&s->io_q.pending)) {

It's safer to use io_q.in_queue > 0 instead of
QSIMPLEQ_EMPTY(&s->io_q.pending).  If io_uring_submit() consumed fewer
sqes than available, then io_q.pending may be empty but we still need to
call io_uring_submit() again to get those remaining sqes submitted.

> +        ioq_submit(s);
> +    }
> +    aio_context_release(s->aio_context);
> +}
> +
> +static void qemu_luring_completion_bh(void *opaque)
> +{
> +    LuringState *s =3D opaque;
> +
> +    qemu_luring_process_completions_and_submit(s);
> +}
> +
> +static void qemu_luring_completion_cb(EventNotifier *e)
> +{
> +    LuringState *s =3D container_of(e, LuringState, e);
> +
> +    if (event_notifier_test_and_clear(&s->e)) {

The EventNotifier isn't used so this call can be removed.  We need to
call qemu_luring_process_completions_and_submit() directly.

> +        qemu_luring_process_completions_and_submit(s);
> +    }
> +}
> +
> +static bool qemu_luring_poll_cb(void *opaque)
> +{
> +    EventNotifier *e =3D opaque;
> +    LuringState *s =3D container_of(e, LuringState, e);
> +    struct io_uring_cqe *cqes;
> +
> +    if (!io_getevents_peek(&s->ring, &cqes)) {
> +        return false;
> +    }
> +
> +    qemu_luring_process_completions_and_submit(s);
> +    return true;
> +}

This is unused and can be removed for now.  Only the unused
EventNotifier references this.

> +
> +static const AIOCBInfo luring_aiocb_info =3D {
> +    .aiocb_size         =3D sizeof(struct qemu_luringcb),
> +};
> +
> +
> +static void ioq_init(LuringQueue *io_q)
> +{
> +    QSIMPLEQ_INIT(&io_q->pending);
> +    io_q->plugged =3D 0;
> +    io_q->in_queue =3D 0;
> +    io_q->in_flight =3D 0;
> +    io_q->blocked =3D false;
> +}
> +
> +static void ioq_submit(LuringState *s)
> +{
> +    int ret, len;
> +    struct qemu_luringcb *aiocb;
> +    QSIMPLEQ_HEAD(, qemu_luringcb) completed;
> +
> +    do {
> +        if (s->io_q.in_flight >=3D MAX_EVENTS) {
> +            break;
> +        }

This do { if (...) } while (...) loop can be written more concisely as:

  while (!QSIMPLEQ_EMPTY(&s->io_q.pending) &&
         s->io_q.in_flight >=3D MAX_EVENTS) {

> +        len =3D 0;
> +        QSIMPLEQ_FOREACH(aiocb, &s->io_q.pending, next) {
> +            if (s->io_q.in_flight + len++ >=3D MAX_EVENTS) {
> +                break;
> +            }
> +            struct io_uring_sqe *sqes =3D io_uring_get_sqe(&s->ring);
> +            if (sqes)  { /* Prep sqe for subission */

If the ring is exhausted we should stop trying to add more requests:

  if (!sqes) {
      break;
  }

> +                memset(sqes, 0, sizeof(*sqes));
> +                sqes->opcode =3D aiocb->sqeq.opcode;
> +                sqes->fd =3D aiocb->sqeq.fd;
> +                if (sqes->opcode =3D=3D IORING_OP_FSYNC) {
> +                    sqes->fsync_flags =3D aiocb->sqeq.fsync_flags;
> +                }
> +                else {
> +                    sqes->off =3D aiocb->sqeq.off;
> +                    sqes->addr =3D aiocb->sqeq.addr;
> +                    sqes->len =3D aiocb->sqeq.len;
> +                }

struct io_uring_sqe can safely be copied since it does not contain
pointers to itself.  The preceding lines of code can be simplified to:

  *sqes =3D aiocb->sqeq;

> +                QSIMPLEQ_REMOVE_HEAD(&s->io_q.pending, next);
> +            }
> +        }
> +
> +        ret =3D  io_uring_submit(&s->ring);
> +        if (ret =3D=3D -EAGAIN) {
> +            break;
> +        }
> +
> +        s->io_q.in_flight +=3D ret;
> +        s->io_q.in_queue  -=3D ret;
> +        QSIMPLEQ_SPLIT_AFTER(&s->io_q.pending, aiocb, next, &completed);
> +    } while (!QSIMPLEQ_EMPTY(&s->io_q.pending));
> +    s->io_q.blocked =3D (s->io_q.in_queue > 0);
> +
> +    if (s->io_q.in_flight) {
> +        /*
> +         * We can try to complete something just right away if there are
> +         * still requests in-flight.
> +         */
> +        qemu_luring_process_completions(s);
> +    }
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
> +    if (--s->io_q.plugged =3D=3D 0 &&
> +        !s->io_q.blocked && !QSIMPLEQ_EMPTY(&s->io_q.pending)) {
> +        ioq_submit(s);
> +    }
> +}
> +
> +static int luring_do_submit(int fd, struct qemu_luringcb *luringcb,
> +                            off_t offset, int type)
> +{
> +    LuringState *s =3D luringcb->ctx;
> +    struct io_uring_sqe *sqes =3D io_uring_get_sqe(&s->ring);
> +    if (!sqes) {
> +        sqes =3D &luringcb->sqeq;
> +        QSIMPLEQ_INSERT_TAIL(&s->io_q.pending, luringcb, next);
> +    }
> +    QEMUIOVector *qiov =3D luringcb->qiov;
> +
> +    switch (type) {
> +    case QEMU_AIO_WRITE:
> +        io_uring_prep_writev(sqes, fd, qiov->iov, qiov->niov, offset);
> +        break;
> +    case QEMU_AIO_READ:
> +        io_uring_prep_readv(sqes, fd, qiov->iov, qiov->niov, offset);
> +        break;
> +    case QEMU_AIO_FLUSH:
> +        io_uring_prep_fsync(sqes, fd, 0);
> +        break;
> +    default:
> +        fprintf(stderr, "%s: invalid AIO request type 0x%x.\n",
> +                        __func__, type);

sqes is leaked if io_uring_get_sqe() succeeded.  Looking at the io_uring
API, there doesn't seem to be a way to return an unused sqe to the ring
:(.

Perhaps just make return -EIO an abort() call instead.  This case should
never happen.  If it does happen, fail loudly.

> +        return -EIO;
> +    }
> +
> +    s->io_q.in_queue++;
> +    if (!s->io_q.blocked &&
> +        (!s->io_q.plugged ||
> +         s->io_q.in_flight + s->io_q.in_queue >=3D MAX_EVENTS)) {
> +        ioq_submit(s);
> +    }
> +
> +    return 0;
> +}
> +
> +int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, =
int fd,
> +                                uint64_t offset, QEMUIOVector *qiov, int=
 type)
> +{
> +    int ret;
> +    struct qemu_luringcb luringcb =3D {
> +        .co         =3D qemu_coroutine_self(),
> +        .nbytes     =3D qiov->size,
> +        .ctx        =3D s,
> +        .ret        =3D -EINPROGRESS,
> +        .is_read    =3D (type =3D=3D QEMU_AIO_READ),
> +        .qiov       =3D qiov,
> +    };
> +
> +    ret =3D luring_do_submit(fd, &luringcb, offset, type);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (luringcb.ret =3D=3D -EINPROGRESS) {
> +        qemu_coroutine_yield();
> +    }
> +    return luringcb.ret;
> +}
> +
> +BlockAIOCB *luring_submit(BlockDriverState *bs, LuringState *s, int fd,
> +        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
> +        BlockCompletionFunc *cb, void *opaque, int type)
> +{
> +    struct qemu_luringcb *luringcb;
> +    off_t offset =3D sector_num * BDRV_SECTOR_SIZE;
> +    int ret;
> +
> +    luringcb =3D qemu_aio_get(&luring_aiocb_info, bs, cb, opaque);
> +    luringcb->nbytes =3D nb_sectors * BDRV_SECTOR_SIZE;
> +    luringcb->ctx =3D s;
> +    luringcb->ret =3D -EINPROGRESS;
> +    luringcb->is_read =3D (type =3D=3D QEMU_AIO_READ);
> +    luringcb->qiov =3D qiov;
> +
> +    ret =3D luring_do_submit(fd, luringcb, offset, type);
> +    if (ret < 0) {
> +        qemu_aio_unref(luringcb);
> +        return NULL;
> +    }
> +
> +    return &luringcb->common;
> +}
> +
> +void luring_detach_aio_context(LuringState *s, AioContext *old_context)
> +{
> +    aio_set_event_notifier(old_context, &s->e, false, NULL, NULL);
> +    qemu_bh_delete(s->completion_bh);
> +    s->aio_context =3D NULL;
> +}
> +
> +void luring_attach_aio_context(LuringState *s, AioContext *new_context)
> +{
> +    s->aio_context =3D new_context;
> +    s->completion_bh =3D aio_bh_new(new_context, qemu_luring_completion_=
bh, s);
> +    aio_set_event_notifier(new_context, &s->e, false,
> +                           qemu_luring_completion_cb,
> +                           qemu_luring_poll_cb);
> +}
> +
> +LuringState *luring_init(Error **errp)
> +{
> +    int rc;
> +    LuringState *s;
> +    s =3D g_malloc0(sizeof(*s));
> +    rc =3D event_notifier_init(&s->e, false);
> +    if (rc < 0) {
> +        error_setg_errno(errp, -rc, "failed to to initialize event notif=
ier");
> +        goto out_free_state;
> +    }
> +
> +    struct io_uring *ring =3D &s->ring;
> +    rc =3D  io_uring_queue_init(MAX_EVENTS, ring, 0);
> +    if (rc < 0) {
> +        error_setg_errno(errp, -rc, "failed to create linux io_uring que=
ue");

liburing documents the error return as -1.  The error can be found in
errno:

s/-rc/errno/

> +        goto out_close_efd;
> +    }
> +
> +    ioq_init(&s->io_q);
> +    aio_set_fd_handler(s->aio_context, ring->ring_fd, false,
> +                       (IOHandler *)qemu_luring_completion_cb, NULL, NUL=
L, &s);

Please do this in attach/detach_aio_context().

> +    return s;
> +
> +out_close_efd:
> +    event_notifier_cleanup(&s->e);
> +out_free_state:
> +    g_free(s);
> +    return NULL;
> +}
> +
> +void luring_cleanup(LuringState *s)
> +{
> +    event_notifier_cleanup(&s->e);
> +    io_uring_queue_exit(&s->ring);
> +    g_free(s);
> +}
> --
> 2.17.1
>=20

--ICrdrp3pM9DyZLTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzlbj4ACgkQnKSrs4Gr
c8hlMAgAx5mQxSYZZGUmOlsTpO5P2dPewf8b3s/ZI9ZmybfHe/pX906cIQFIA4pV
hP/ry7UGoJjnZflgHfZI3YM+fhZ5+7p/e4r5UbiyMUctN9p2xb/PlWj2LU6ZaqhW
3yAyzWgvmXcfmzVfSMDn4obdq9+wFWG55FjY98+Wv3JuRpgLTPb8vOgcoSpMMDvN
ihhexCzLaKhGbZoS658W3gG1TRbCtQ/fxjB7hye9BaQR4rlb4s63Ev++V4KglLmk
RtERBKUxBOJl5ApznKENlyzGXMJBT9m77vqgAR4kOm0gTdNSHaNTHwdIeHIU0e3p
IPlypY7HcvEriB7BNLCOvgZG0Z1jtw==
=2v+E
-----END PGP SIGNATURE-----

--ICrdrp3pM9DyZLTK--

