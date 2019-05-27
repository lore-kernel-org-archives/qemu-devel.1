Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6363C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCD22173B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCD22173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVC0h-0004zv-Nz
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 05:33:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hVBzo-0004fB-Af
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hVBzn-0002ap-21
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:32:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hVBzc-0002L1-Kq; Mon, 27 May 2019 05:32:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD19CF74A7;
	Mon, 27 May 2019 09:32:25 +0000 (UTC)
Received: from localhost (unknown [10.36.118.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8ED8510027D2;
	Mon, 27 May 2019 09:32:22 +0000 (UTC)
Date: Mon, 27 May 2019 10:32:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190527093221.GB25631@stefanha-x1.localdomain>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
	<20190527080327.10780-5-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <20190527080327.10780-5-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 27 May 2019 09:32:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/8] block/io_uring: implements
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
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 27, 2019 at 01:33:23PM +0530, Aarushi Mehta wrote:
> +static void qemu_luring_process_completions(LuringState *s)
> +{
> +    struct io_uring_cqe *cqes;
> +    /*
> +     * Request completion callbacks can run the nested event loop.
> +     * Schedule ourselves so the nested event loop will "see" remaining
> +     * completed requests and process them.  Without this, completion
> +     * callbacks that wait for other requests using a nested event loop
> +     * would hang forever.
> +     */
> +    qemu_bh_schedule(s->completion_bh);
> +
> +    while (!io_uring_peek_cqe(&s->ring, &cqes)) {
> +        io_uring_cqe_seen(&s->ring, cqes);

The kernel may overwrite the cqe once we've marked it seen.  Therefore
the cqe must only be marked seen after the last access to it.  This is
analogous to a use-after-free bug: we're not allowed to access fields of
an object after it has been freed.

The place to do so is...

> +
> +        LuringAIOCB *luringcb = io_uring_cqe_get_data(cqes);
> +        luringcb->ret = io_cqe_ret(cqes);

...here:

  io_uring_cqe_seen(&s->ring, cqes);
  cqes = NULL; /* returned to ring, don't access it anymore */

> +        if (luringcb->co) {
> +            /*
> +             * If the coroutine is already entered it must be in ioq_submit()
> +             * and will notice luringcb->ret has been filled in when it
> +             * eventually runs later. Coroutines cannot be entered recursively
> +             * so avoid doing that!
> +             */
> +            if (!qemu_coroutine_entered(luringcb->co)) {
> +                aio_co_wake(luringcb->co);
> +            }
> +        } else {
> +            luringcb->common.cb(luringcb->common.opaque, luringcb->ret);
> +            qemu_aio_unref(luringcb);
> +        }
> +        /* Change counters one-by-one because we can be nested. */
> +        s->io_q.in_flight--;

This counter must be decremented before invoking luringcb's callback.
That way the nested event loop doesn't consider this completed request
in flight anymore.

> +static void ioq_submit(LuringState *s)
> +{
> +    int ret;
> +    LuringAIOCB *luringcb, *luringcb_next;
> +
> +    while(!s->io_q.in_queue) {

Should this be while (s->io_q.in_queue > 0)?

> +        QSIMPLEQ_FOREACH_SAFE(luringcb, &s->io_q.sq_overflow, next,
> +                              luringcb_next) {
> +            struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
> +            if (!sqes) {
> +                break;
> +            }
> +            /* Prep sqe for submission */
> +            *sqes = luringcb->sqeq;
> +            io_uring_sqe_set_data(sqes, luringcb);

This is unnecessary, the data field has already been set in
luring_do_submit() and copied to *sqes in the previous line.

> +BlockAIOCB *luring_submit(BlockDriverState *bs, LuringState *s, int fd,
> +        int64_t sector_num, QEMUIOVector *qiov, BlockCompletionFunc *cb,
> +        void *opaque, int type)
> +{
> +    LuringAIOCB *luringcb;
> +    off_t offset = sector_num * BDRV_SECTOR_SIZE;
> +    int ret;
> +
> +    luringcb = qemu_aio_get(&luring_aiocb_info, bs, cb, opaque);
> +    luringcb->ret = -EINPROGRESS;

luringcb isn't zeroed by qemu_aio_get().  luringcb->co must be
explicitly set to NULL to prevent undefined behavior in
qemu_luring_process_completions() (uninitialized memory access).

  luring->co = NULL;

By the way, this bug originates from linux-aio.c.  I have sent a patch
to fix it there!

> +    ret = luring_do_submit(fd, luringcb, s, offset, qiov, type);
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
> +    aio_set_fd_handler(old_context, s->ring.ring_fd, false, NULL, NULL, NULL,
> +                       &s);
> +    qemu_bh_delete(s->completion_bh);
> +    s->aio_context = NULL;
> +}
> +
> +void luring_attach_aio_context(LuringState *s, AioContext *new_context)
> +{
> +    s->aio_context = new_context;
> +    s->completion_bh = aio_bh_new(new_context, qemu_luring_completion_bh, s);
> +    aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
> +                       qemu_luring_completion_cb, NULL, NULL, &s);
> +}
> +
> +LuringState *luring_init(Error **errp)
> +{
> +    int rc;
> +    LuringState *s;
> +    s = g_malloc0(sizeof(*s));
> +    struct io_uring *ring = &s->ring;
> +    rc =  io_uring_queue_init(MAX_EVENTS, ring, 0);
> +    if (rc == -1) {
> +        error_setg_errno(errp, -rc, "failed to init linux io_uring ring");

Why was this changed from error_setg_errno(errp, errno, "failed to init
linux io_uring ring") to -rc in v3?

rc is -1 here, not an errno value, so the error message will be
incorrect.

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzrrqUACgkQnKSrs4Gr
c8g7LwgAoLglkVc9Y2vD+7t9blITtEaZHx8Ew/uSN8+RP71zR6wOhZ8Vr+xn+ELe
6hKH/pzHwm3B7I3ZvAH0q+Eszt9e1NmI02nIDv3uJ4/eoCj3G4Ip/JDdNyBKrufu
YXn+UCoRpUpcmcNr9P74nPjLC/YZt8BIBVWyn2DwOP90/t7uhGRZSSsnIgtETSyP
en7kvS+J6KwN63ulmEykJmR51igah/BPPbkDLhO8n8nY5AxjAScr8Tt+QoO8RAzN
oO7OkSrV5OI6HA9eGSEQ2r2CPBt6O6JU0tOOoMZInakiqcMQdMk0cTa+on0Y94p/
Ul7n81GzCPkEqfXv/7wbsOh/X4qcDA==
=GmOy
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--

