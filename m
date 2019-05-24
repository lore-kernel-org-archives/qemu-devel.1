Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CDEC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E1F20851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E1F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUD1d-00006y-3w
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:26:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUCt0-00019y-DE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUCsy-0007lp-1Z
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:17:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hUCst-0007gx-8v; Fri, 24 May 2019 12:17:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 854E63002DAE;
	Fri, 24 May 2019 16:17:25 +0000 (UTC)
Received: from localhost (ovpn-117-142.ams2.redhat.com [10.36.117.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D14E419748;
	Fri, 24 May 2019 16:17:23 +0000 (UTC)
Date: Fri, 24 May 2019 17:17:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190524161722.GF31070@stefanha-x1.localdomain>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
	<20190524140337.13415-7-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <20190524140337.13415-7-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 24 May 2019 16:17:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 6/9] block/io_uring: implements
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 07:33:34PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  MAINTAINERS         |   1 +
>  block/Makefile.objs |   2 +
>  block/io_uring.c    | 306 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 309 insertions(+)
>  create mode 100644 block/io_uring.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8fc1e3fe3..770d562c6c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2510,6 +2510,7 @@ R: Stefan Hajnoczi <stefan@redhat.com>
>  L: qemu-block@nongnu.org
>  S: Maintained
>  F: stubs/io_uring.c
> +F: block/io_uring.c
>=20
>=20
>  L: qemu-block@nongnu.original
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
> index 0000000000..817ec055db
> --- /dev/null
> +++ b/block/io_uring.c
> @@ -0,0 +1,306 @@
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
> +#include <liburing.h>

Please move this include below osdep.h as per ./HACKING "1.2. Include
directives".

> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "block/aio.h"
> +#include "qemu/queue.h"
> +#include "block/block.h"
> +#include "block/raw-aio.h"
> +#include "qemu/event_notifier.h"

Unused, please drop.

> +#include "qemu/coroutine.h"
> +#include "qapi/error.h"
> +
> +#define MAX_EVENTS 128
> +
> +typedef struct LuringAIOCB {
> +    BlockAIOCB common;
> +    Coroutine *co;
> +    struct io_uring_sqe sqeq;
> +    int ret;
> +    QSIMPLEQ_ENTRY(LuringAIOCB) next;
> +} LuringAIOCB;
> +
> +typedef struct LuringQueue {
> +    int plugged;
> +    unsigned int in_queue;
> +    unsigned int in_flight;
> +    bool blocked;
> +    QSIMPLEQ_HEAD(, LuringAIOCB) pending;
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
> +    int event_idx;
> +    int event_max;
> +} LuringState;
> +
> +static void ioq_submit(LuringState *s);
> +
> +static inline int io_cqe_ret(struct io_uring_cqe *cqe)
> +{
> +    return cqe->res;
> +}
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
> +
> +    qemu_bh_schedule(s->completion_bh);

Please add a comment explaining why this is necessary:

  /*
   * Request completion callbacks can run the nested event loop.
   * Schedule ourselves so the nested event loop will "see" remaining
   * completed requests and process them.  Without this, completion
   * callbacks that wait for other requests using a nested event loop
   * would hang forever.
   */

> +
> +    while ((s->event_max =3D s->io_q.in_flight) &&
> +           !io_uring_peek_cqe(&s->ring, &cqes)) {
> +        for (s->event_idx =3D 0; s->event_idx < s->event_max;) {
> +            io_uring_cqe_seen(&s->ring, cqes);

What is the purpose of event_max/event_idx given that we can consume
cqes via io_uring_peek_cqe() + io_uring_cqe_seen()?

I think just this will do:

  while (!io_uring_peek_cqe(&s->ring, &cqes)) {
      int ret =3D io_cqe_ret(cqes);

      /* We're done accessing cqes, replenish the cq ring */
      io_uring_cqe_seen(&s->ring, cqes);

> +
> +            LuringAIOCB *luringcb;
> +            luringcb =3D g_malloc0(sizeof(luringcb));

We need to fetch the original LuringAIOCB associated with this request
instead of allocating a new one.  The original LuringAIOCB contains the
coroutine and async completion callback function pointer that we need.

io_uring allows us to pass user data along with the sqe and it gets
returned in the cqe.

During request submission:

  io_uring_sqe_set_data(sqes, luringcb);

During request completion:

  LuringAIOCB *luringcb =3D io_uring_cqe_get_data(cqes);

> +            luringcb->ret =3D io_cqe_ret(cqes);
> +            /* Change counters one-by-one because we can be nested. */
> +            s->io_q.in_flight--;
> +            s->event_idx++;

We must invoke completion and possibly unref luringcb here:

  if (luringcb->co) {
      /* If the coroutine is already entered it must be in ioq_submit() and
       * will notice laio->ret has been filled in when it eventually runs
       * later.  Coroutines cannot be entered recursively so avoid doing
       * that!
       */
      if (!qemu_coroutine_entered(luringcb->co)) {
          aio_wake(luringcb->co);
      }
  } else {
      luringcb->common.cb(luringcb->common.opaque, luringcb->ret);
      qemu_aio_unref(luringcb);
  }

Without this code the request is never completed.  How are you testing
this code (you mentioned the guest boots)?  Is it possible that the
Linux AIO or thread-pool code path is being taken accidentally and we're
actually not running io_uring yet?

> +        }
> +    }
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

Please use in_queue instead of checking io_q.pending since there might
be requests in the sq ring that also need to be submitted.

> +        ioq_submit(s);
> +    }
> +    aio_context_release(s->aio_context);
> +}
> +
> +static void qemu_luring_completion_bh(void *opaque)
> +{
> +    LuringState *s =3D opaque;
> +    qemu_luring_process_completions_and_submit(s);
> +}
> +
> +static void qemu_luring_completion_cb(void *opaque)
> +{
> +    LuringState *s =3D opaque;
> +    qemu_luring_process_completions_and_submit(s);
> +}
> +
> +static const AIOCBInfo luring_aiocb_info =3D {
> +    .aiocb_size         =3D sizeof(LuringAIOCB),
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
> +    LuringAIOCB *luringcb;
> +    QSIMPLEQ_HEAD(, LuringAIOCB) completed;
> +
> +    while (s->io_q.in_flight >=3D MAX_EVENTS && s->io_q.in_queue) {

Try to submit requests as long as MAX_EVENTS has not been reached:

s/>=3D/</

By the way, is a loop necessary?  I don't see a scenario where we need
multiple iterations.  In fact, this is an infinite loop if the kernel
refuses to consume further requests for some reason.

> +        len =3D 0;
> +        QSIMPLEQ_FOREACH(luringcb, &s->io_q.pending, next) {
> +            if (s->io_q.in_flight + len++ >=3D MAX_EVENTS) {
> +                break;
> +            }

Can we rely on io_uring_get_sqe() failing when the sq ring is exhausted?
That way there's no need for this if statement.

> +            struct io_uring_sqe *sqes =3D io_uring_get_sqe(&s->ring);
> +            if (sqes)  { /* Prep sqe for subission */
> +                memset(sqes, 0, sizeof(*sqes));

memset is unnecessary since the next statement overwrites all of sqes.

> +                *sqes =3D luringcb->sqeq;
> +                QSIMPLEQ_REMOVE_HEAD(&s->io_q.pending, next);

Careful, a special API is needed when you want to modify the queue
during iteration.  Please see QSIMPLEQ_FOREACH_SAFE().

> +            } else {
> +                break;
> +            }

The simpler form of this if statement is:

  if (!sqes) {
      break;
  }

  ...the success case without nesting...

This is just a style suggestion.  I find code easier to read without
nesting.  Feel free to leave it if you prefer your way.

> +        }
> +
> +        ret =3D  io_uring_submit(&s->ring);
> +        if (ret =3D=3D -EAGAIN) {
> +            break;
> +        }

Actually in all error cases since we don't want to increment
in_flight/in_queue with -errno:

  if (ret < 0) {
      break;
  }

Please add a TODO comment for error handling, the error is currently
ignored and this could be a problem.  In the EAGAIN case the kernel is
unable to process more requests temporarily and we should try again
later.  But we don't try again later, so this could result in hung I/O.

> +
> +        s->io_q.in_flight +=3D ret;
> +        s->io_q.in_queue  -=3D ret;
> +        QSIMPLEQ_SPLIT_AFTER(&s->io_q.pending, luringcb, next, &complete=
d);

Hmm...what is this doing?  QSIMPLEQ_REMOVE_HEAD() was already called
earlier on, so why modify the list again?

> +    }
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

Remember to take into account requests in the sq ring, they also need to
be submitted:

s/!QSIMPLEQ_EMPTY(&s->io_q.pending)/s->io_q.in_queue > 0/

> +        ioq_submit(s);
> +    }
> +}
> +
> +static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *=
s,
> +                            uint64_t offset, QEMUIOVector *qiov, int typ=
e)
> +{
> +    struct io_uring_sqe *sqes =3D io_uring_get_sqe(&s->ring);
> +    if (!sqes) {
> +        sqes =3D &luringcb->sqeq;
> +        QSIMPLEQ_INSERT_TAIL(&s->io_q.pending, luringcb, next);
> +    }
> +
> +    switch (type) {
> +    case QEMU_AIO_WRITE:
> +        io_uring_prep_writev(sqes, fd, qiov->iov, qiov->niov, offset);
> +        break;
> +    case QEMU_AIO_READ:
> +        io_uring_prep_readv(sqes, fd, qiov->iov, qiov->niov, offset);
> +        break;
> +    case QEMU_AIO_FLUSH:
> +        io_uring_prep_fsync(sqes, fd, IORING_FSYNC_DATASYNC);
> +        break;
> +    default:
> +        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\n",
> +                        __func__, type);
> +        abort();
> +    }
> +
> +    s->io_q.in_queue++;

It's easy to think that "in_queue" is just the length of io_q.pending,
but that's incorrect.  "pending" and "in_queue" have different semantics
and it's a bit subtle:

 * The "pending" queue is only used when the sq ring is full.

 * The "in_queue" counter indicates the total number of requests on the
   io_q.pending list and in the sq_ring but not yet consumed by the
   kernel.

Changing the names would help.  Here is my suggestion, maybe you have a
better idea:

 * Call the list io_q.sq_overflow so it's clear these are requests that
   didn't fit into the sq ring.

 * Call the counter num_unsubmitted.  I don't know about this one, it's
   hard to find a good name :).  Maybe it can be left as in_queue.

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
> +    LuringAIOCB luringcb =3D {
> +        .co         =3D qemu_coroutine_self(),
> +        .ret        =3D -EINPROGRESS,
> +    };
> +
> +    ret =3D luring_do_submit(fd, &luringcb, s, offset, qiov, type);
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
> +        int64_t sector_num, QEMUIOVector *qiov, BlockCompletionFunc *cb,
> +        void *opaque, int type)
> +{
> +    LuringAIOCB *luringcb;
> +    off_t offset =3D sector_num * BDRV_SECTOR_SIZE;
> +    int ret;
> +
> +    luringcb =3D qemu_aio_get(&luring_aiocb_info, bs, cb, opaque);
> +    luringcb->ret =3D -EINPROGRESS;
> +    ret =3D luring_do_submit(fd, luringcb, s, offset, qiov, type);
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
> +    aio_set_fd_handler(old_context, s->ring.ring_fd, false, NULL, NULL, =
NULL,
> +                       &s);
> +    qemu_bh_delete(s->completion_bh);
> +    s->aio_context =3D NULL;
> +}
> +
> +void luring_attach_aio_context(LuringState *s, AioContext *new_context)
> +{
> +    s->aio_context =3D new_context;
> +    s->completion_bh =3D aio_bh_new(new_context, qemu_luring_completion_=
bh, s);
> +    aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
> +                       (IOHandler *)qemu_luring_completion_cb, NULL, NUL=
L, &s);

Casting function pointers is suspicious because it often indicates
unportable code (it relies on assumptions about the calling convention
that the compiler is using).

Luckily this type cast seems unnecessary and can be dropped:

  static void qemu_luring_completion_cb(void *opaque)
  =3D=3D
  typedef void IOHandler(void *opaque);

> +}
> +
> +LuringState *luring_init(Error **errp)
> +{
> +    int rc;
> +    LuringState *s;
> +    s =3D g_malloc0(sizeof(*s));
> +    struct io_uring *ring =3D &s->ring;
> +    rc =3D  io_uring_queue_init(MAX_EVENTS, ring, 0);
> +    if (rc =3D=3D -1) {
> +        error_setg_errno(errp, errno, "failed to init linux io_uring rin=
g");
> +        goto out_close_efd;
> +    }
> +
> +    ioq_init(&s->io_q);
> +    return s;
> +
> +out_close_efd:

There is no eventfd so "efd" is outdated.  Given that there are no other
gotos, you could just inline this return code and avoid the goto
altogether.

> +    g_free(s);
> +    return NULL;
> +}
> +
> +void luring_cleanup(LuringState *s)
> +{
> +    io_uring_queue_exit(&s->ring);
> +    g_free(s);
> +}
> --
> 2.17.1

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzoGRIACgkQnKSrs4Gr
c8gXIwf9EBqyQCLl+gMh+kioeg840aAYbAxomKjG67HvHlE6l1v4J4r75cUrmwQh
9D1vlJMUdfriP/lvKlE8Kvc5m1Sa4JmTdKvu39WWwB8OuNyk6rfIzihbVE+aOlQv
/N5hxeNl7rBBW3FFkWOxRj3L7x9UQ7MPIzA45xAY3WVVzUdv953Zkyuui7yM9MZU
xaZw62plL1mi/2ed2Vjg9IKyC7IRRl7qLAhi/hdyjgKFg1hicD+Zww0y+UJ16INI
pdJdAAzLP+3TZFaCzqDDvOG2LLjXE3UQ51ymtdPVxJOxV4BxdqWhjMZcAVf5eyFo
OhSxTim2pedrj6Ah0QcPwuPlJUhMoA==
=d5IH
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--

