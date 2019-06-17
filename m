Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F04C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E8A20679
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E8A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqy7-0005AI-W5
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40507)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hcqjG-00033u-LT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hcqjD-0005L4-Kz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:27:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hcqj7-00059s-14; Mon, 17 Jun 2019 08:27:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3620530872C4;
 Mon, 17 Jun 2019 12:27:00 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4EF31001DFF;
 Mon, 17 Jun 2019 12:26:51 +0000 (UTC)
Message-ID: <81e4ab9b07d5678a3a28e1314c07ee0224e4d9ed.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:26:50 +0300
In-Reply-To: <20190610134905.22294-5-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-5-mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 17 Jun 2019 12:27:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-06-10 at 19:18 +0530, Aarushi Mehta wrote:
> Aborts when sqe fails to be set as sqes cannot be returned to the ring.
>=20
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  MAINTAINERS             |   7 +
>  block/Makefile.objs     |   3 +
>  block/io_uring.c        | 314 ++++++++++++++++++++++++++++++++++++++++
>  include/block/aio.h     |  16 +-
>  include/block/raw-aio.h |  12 ++
>  5 files changed, 351 insertions(+), 1 deletion(-)
>  create mode 100644 block/io_uring.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7be1225415..49f896796e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2516,6 +2516,13 @@ F: block/file-posix.c
>  F: block/file-win32.c
>  F: block/win32-aio.c
> =20
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
> @@ -18,6 +18,7 @@ block-obj-y +=3D block-backend.o snapshot.o qapi.o
>  block-obj-$(CONFIG_WIN32) +=3D file-win32.o win32-aio.o
>  block-obj-$(CONFIG_POSIX) +=3D file-posix.o
>  block-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
> +block-obj-$(CONFIG_LINUX_IO_URING) +=3D io_uring.o
>  block-obj-y +=3D null.o mirror.o commit.o io.o create.o
>  block-obj-y +=3D throttle-groups.o
>  block-obj-$(CONFIG_LINUX) +=3D nvme.o
> @@ -61,5 +62,7 @@ block-obj-$(if $(CONFIG_LZFSE),m,n) +=3D dmg-lzfse.o
>  dmg-lzfse.o-libs   :=3D $(LZFSE_LIBS)
>  qcow.o-libs        :=3D -lz
>  linux-aio.o-libs   :=3D -laio
> +io_uring.o-cflags  :=3D $(LINUX_IO_URING_CFLAGS)
> +io_uring.o-libs    :=3D $(LINUX_IO_URING_LIBS)
>  parallels.o-cflags :=3D $(LIBXML2_CFLAGS)
>  parallels.o-libs   :=3D $(LIBXML2_LIBS)
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
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
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
> + * Fetches completed I/O requests, consumes cqes and invokes their cal=
lbacks.
> + *
> + */
> +static void qemu_luring_process_completions(LuringState *s)
> +{
> +    struct io_uring_cqe *cqes;
> +    int ret;
> +
> +    /*
> +     * Request completion callbacks can run the nested event loop.
> +     * Schedule ourselves so the nested event loop will "see" remainin=
g
> +     * completed requests and process them.  Without this, completion
> +     * callbacks that wait for other requests using a nested event loo=
p
> +     * would hang forever.
> +     */

About that qemu_bh_schedule
The code is copied from linux-aio.c where it was added with the below com=
mit.

Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Mon Aug 4 16:56:33 2014 +0100

    linux-aio: avoid deadlock in nested aio_poll() calls
   =20
    If two Linux AIO request completions are fetched in the same
    io_getevents() call, QEMU will deadlock if request A's callback waits
    for request B to complete using an aio_poll() loop.  This was reporte=
d
    to happen with the mirror blockjob.
   =20
    This patch moves completion processing into a BH and makes it resumab=
le.
    Nested event loops can resume completion processing so that request B
    will complete and the deadlock will not occur.
   =20
    Cc: Kevin Wolf <kwolf@redhat.com>
    Cc: Paolo Bonzini <pbonzini@redhat.com>
    Cc: Ming Lei <ming.lei@canonical.com>
    Cc: Marcin Gibu=C5=82a <m.gibula@beyond.pl>
    Reported-by: Marcin Gibu=C5=82a <m.gibula@beyond.pl>
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
    Tested-by: Marcin Gibu=C5=82a <m.gibula@beyond.pl>


I kind of opened a Pandora box by researching that area suspecting that t=
he same treatment is needed in other block drivers,
but after all, this is correct behaviour, and this is why:

The reason that the bottom half workaround is needed in linux-aio is beca=
use aio uses an eventfd which just notifies it
of the completions once, thus if the co-routine which handles the respons=
e does aio_poll, the same fd won't be returned again,
at least unless more events are received which is not guaranteed.


Here in io_uring, I think the same would happen. Looking at the kernel so=
urce I see that poll implementation uses 'poll_wait' which is basically
a wait queue which is woken up when new completion events are added to th=
e uring, thus attempting to poll again on the same uring fd will indeed b=
lock,
even if there are events not yet processed.

For all other leaf block drivers (drivers that access the data, rather th=
at forward the requests to another block driver), they are all networking=
 based,=20
thus they poll the communication socket.
When the same situation occurs the nested aio_poll will notice that the s=
ocket still has data and thus run the corresponding co-routine, thus prev=
enting the deadlock.

I think that the two above comments should be added to the source in some=
 way to document this so that next guy after me won't need to spend time =
understanding this.


BTW, nvme userspace driver also solves this issue by not entering the co-=
routine directly from aio fd handler,  but doing that from a bottom half =
which the handler schedules.=20
This works because the nested aio_poll will
run the bottom halves again, but I suspect that this adds overhead that c=
ould be avoided. I'll look at that later.


> +    qemu_bh_schedule(s->completion_bh);
> +
> +    while (io_uring_peek_cqe(&s->ring, &cqes) =3D=3D 0) {


Maybe consider using io_uring_for_each_cqe and then io_uring_cq_advance
to avoid acking one ring entry at the time ?=20
However this probably will break the nesting.

> +        if (!cqes) {
> +            break;
> +        }
> +        LuringAIOCB *luringcb =3D io_uring_cqe_get_data(cqes);
> +        ret =3D cqes->res;
> +
> +        if (ret =3D=3D luringcb->qiov->size) {
> +            ret =3D 0;
> +        } else if (ret >=3D 0) {


You should very carefully check the allowed return values here.

It looks like you can get '-EINTR' here, which would ask you to rerun the=
 read operation, and otherwise
you will get the number of bytes read, which might be less that what was =
asked for, which implies that you
need to retry the read operation with the remainder of the buffer rather =
that zero the end of the buffer IMHO=20

(0 is returned on EOF according to 'read' semantics, which I think are us=
ed here, thus a short read might not be an EOF)


Looking at linux-aio.c though I do see that it just passes through the re=
turned value with no special treatments.=20
including lack of check for -EINTR.

I assume that since aio is linux specific, and it only supports direct IO=
, it happens
to have assumption of no short reads/-EINTR (but since libaio has very sp=
arse documentation I can't verify this)

On the other hand the aio=3Dthreads implementation actually does everythi=
ng as specified on the 'write' manpage,
retrying the reads on -EINTR, and doing additional reads if less that req=
uired number of bytes were read.

Looking at io_uring implementation in the kernel I see that it does suppo=
rt synchronous (non O_DIRECT mode),=20
and in this case, it goes through the same ->read_iter which is pretty mu=
ch the same path that=20
regular read() takes and so it might return short reads and or -EINTR.


> +            /* Short Read/Write */
> +            if (luringcb->is_read) {
> +                /* Read, pad with zeroes */
> +                qemu_iovec_memset(luringcb->qiov, ret, 0,
> +                luringcb->qiov->size - ret);
> +            } else {
> +                ret =3D -ENOSPC;;
> +            }
> +        }
> +        luringcb->ret =3D ret;
> +
> +        io_uring_cqe_seen(&s->ring, cqes);
> +        cqes =3D NULL;
> +        /* Change counters one-by-one because we can be nested. */
> +        s->io_q.in_flight--;
> +
> +        /*
> +         * If the coroutine is already entered it must be in ioq_submi=
t()
> +         * and will notice luringcb->ret has been filled in when it
> +         * eventually runs later. Coroutines cannot be entered recursi=
vely
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
> +static void ioq_init(LuringQueue *io_q)
> +{
> +    QSIMPLEQ_INIT(&io_q->sq_overflow);
> +    io_q->plugged =3D 0;
> +    io_q->in_queue =3D 0;
> +    io_q->in_flight =3D 0;
> +    io_q->blocked =3D false;
> +}
> +
> +static int ioq_submit(LuringState *s)
> +{
> +    int ret =3D 0;
> +    LuringAIOCB *luringcb, *luringcb_next;
> +
> +    while (s->io_q.in_queue > 0) {
> +        QSIMPLEQ_FOREACH_SAFE(luringcb, &s->io_q.sq_overflow, next,
> +                              luringcb_next) {

I am torn about the 'sq_overflow' name. it seems to me that its not immed=
iately clear that these
are the requests that are waiting because the io uring got full, but I ca=
n't now think of a better name.

Maybe add a comment here to explain what is going on here?

Also maybe we could somehow utilize the plug/unplug facility to avoid rea=
ching that state in first place?
Maybe the block layer has some kind of 'max outstanding requests' limit t=
hat could be used?

In my nvme-mdev I opted to not process the input queues when such a condi=
tion is detected, but here you can't as the block layer
pretty much calls you to process the requests.


> +            struct io_uring_sqe *sqes =3D io_uring_get_sqe(&s->ring);
> +            if (!sqes) {
> +                break;
> +            }
> +            /* Prep sqe for submission */
> +            *sqes =3D luringcb->sqeq;
> +            QSIMPLEQ_REMOVE_HEAD(&s->io_q.sq_overflow, next);
> +        }
> +        ret =3D  io_uring_submit(&s->ring);
> +        /* Prevent infinite loop if submission is refused */
> +        if (ret <=3D 0) {
> +            if (ret =3D=3D -EAGAIN) {
> +                continue;
> +            }
> +            break;
> +        }
> +        s->io_q.in_flight +=3D ret;
> +        s->io_q.in_queue  -=3D ret;
> +    }
> +    s->io_q.blocked =3D (s->io_q.in_queue > 0);
> +
> +    if (s->io_q.in_flight) {
> +        /*
> +         * We can try to complete something just right away if there a=
re
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
> +    if (--s->io_q.plugged =3D=3D 0 &&
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
> +static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState=
 *s,
> +                            uint64_t offset, int type)
> +{
> +    struct io_uring_sqe *sqes =3D io_uring_get_sqe(&s->ring);
> +    if (!sqes) {
> +        sqes =3D &luringcb->sqeq;
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
> +        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\=
n",
> +                        __func__, type);

Nitpick: Don't we use some king of error printing functions like 'error_s=
etg' rather that fprintf?


> +        abort();
> +    }
> +    io_uring_sqe_set_data(sqes, luringcb);
> +    s->io_q.in_queue++;
> +
> +    if (!s->io_q.blocked &&
> +        (!s->io_q.plugged ||
> +         s->io_q.in_flight + s->io_q.in_queue >=3D MAX_EVENTS)) {
> +        return ioq_submit(s);
> +    }
> +    return 0;
> +}
> +
> +int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s=
, int fd,
> +                                uint64_t offset, QEMUIOVector *qiov, i=
nt type)
> +{
> +    int ret;
> +    LuringAIOCB luringcb =3D {
> +        .co         =3D qemu_coroutine_self(),
> +        .ret        =3D -EINPROGRESS,
> +        .qiov       =3D qiov,
> +        .is_read    =3D (type =3D=3D QEMU_AIO_READ),
> +    };
> +
> +    ret =3D luring_do_submit(fd, &luringcb, s, offset, type);
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
> +void luring_detach_aio_context(LuringState *s, AioContext *old_context=
)
> +{
> +    aio_set_fd_handler(old_context, s->ring.ring_fd, false, NULL, NULL=
, NULL,
> +                       s);
> +    qemu_bh_delete(s->completion_bh);
> +    s->aio_context =3D NULL;
> +}
> +
> +void luring_attach_aio_context(LuringState *s, AioContext *new_context=
)
> +{
> +    s->aio_context =3D new_context;
> +    s->completion_bh =3D aio_bh_new(new_context, qemu_luring_completio=
n_bh, s);
> +    aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
> +                       qemu_luring_completion_cb, NULL, NULL, s);
> +}
> +
> +LuringState *luring_init(Error **errp)
> +{
> +    int rc;
> +    LuringState *s;
> +    s =3D g_malloc0(sizeof(*s));
> +    struct io_uring *ring =3D &s->ring;
> +    rc =3D  io_uring_queue_init(MAX_EVENTS, ring, 0);
> +    if (rc < 0) {
> +        error_setg_errno(errp, errno, "failed to init linux io_uring r=
ing");
> +        g_free(s);
> +        return NULL;
> +    }
> +



> +    ioq_init(&s->io_q);

Another nitpick, maybe inline that function as it is used just here?
(that will save the static declaration upfront as well)
Feel free to leave this as is, if you think this way it is clearer.

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
> =20
>  struct AioContext {
>      GSource source;
> @@ -118,11 +119,19 @@ struct AioContext {
>      struct ThreadPool *thread_pool;
> =20
>  #ifdef CONFIG_LINUX_AIO
> -    /* State for native Linux AIO.  Uses aio_context_acquire/release f=
or
> +    /*
> +     * State for native Linux AIO.  Uses aio_context_acquire/release f=
or
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
> =20
>      /* TimerLists for calling timers - one per clock type.  Has its ow=
n
>       * locking.
> @@ -387,6 +396,11 @@ struct LinuxAioState *aio_setup_linux_aio(AioConte=
xt *ctx, Error **errp);
>  /* Return the LinuxAioState bound to this AioContext */
>  struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
> =20
> +/* Setup the LuringState bound to this AioContext */
> +struct LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **=
errp);
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
> @@ -55,6 +55,18 @@ void laio_attach_aio_context(LinuxAioState *s, AioCo=
ntext *new_context);
>  void laio_io_plug(BlockDriverState *bs, LinuxAioState *s);
>  void laio_io_unplug(BlockDriverState *bs, LinuxAioState *s);
>  #endif
> +/* io_uring.c - Linux io_uring implementation */
> +#ifdef CONFIG_LINUX_IO_URING
> +typedef struct LuringState LuringState;
> +LuringState *luring_init(Error **errp);
> +void luring_cleanup(LuringState *s);
> +int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s=
, int fd,
> +                                uint64_t offset, QEMUIOVector *qiov, i=
nt type);
> +void luring_detach_aio_context(LuringState *s, AioContext *old_context=
);
> +void luring_attach_aio_context(LuringState *s, AioContext *new_context=
);
> +void luring_io_plug(BlockDriverState *bs, LuringState *s);
> +void luring_io_unplug(BlockDriverState *bs, LuringState *s);
> +#endif
> =20
>  #ifdef _WIN32
>  typedef struct QEMUWin32AIOState QEMUWin32AIOState;


I plan on this or next week to do some benchmarks of the code and I will =
share the results as soon
as I do them.

Please pardon me if I made some mistakes in the review because most of th=
e qemu is new for me,
so I don't yet know well most of the stuff here.

Best regards,
	Maxim Levitsky




