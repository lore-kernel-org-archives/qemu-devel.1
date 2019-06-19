Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6F2C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12C7206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12C7206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXd4-000093-Oz
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52659)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hdXcO-0007v9-Ue
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hdXcL-0001Vk-4X
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:15:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hdXc8-0001D8-8F; Wed, 19 Jun 2019 06:14:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68BC03087929;
 Wed, 19 Jun 2019 10:14:30 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4432E1001E81;
 Wed, 19 Jun 2019 10:14:23 +0000 (UTC)
Date: Wed, 19 Jun 2019 11:14:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190619101414.GA13569@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-5-mehta.aaru20@gmail.com>
 <81e4ab9b07d5678a3a28e1314c07ee0224e4d9ed.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <81e4ab9b07d5678a3a28e1314c07ee0224e4d9ed.camel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 19 Jun 2019 10:14:33 +0000 (UTC)
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
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 03:26:50PM +0300, Maxim Levitsky wrote:
> On Mon, 2019-06-10 at 19:18 +0530, Aarushi Mehta wrote:
> > +        if (!cqes) {
> > +            break;
> > +        }
> > +        LuringAIOCB *luringcb =3D io_uring_cqe_get_data(cqes);
> > +        ret =3D cqes->res;
> > +
> > +        if (ret =3D=3D luringcb->qiov->size) {
> > +            ret =3D 0;
> > +        } else if (ret >=3D 0) {
>=20
>=20
> You should very carefully check the allowed return values here.
>=20
> It looks like you can get '-EINTR' here, which would ask you to rerun the=
 read operation, and otherwise
> you will get the number of bytes read, which might be less that what was =
asked for, which implies that you
> need to retry the read operation with the remainder of the buffer rather =
that zero the end of the buffer IMHO=20
>=20
> (0 is returned on EOF according to 'read' semantics, which I think are us=
ed here, thus a short read might not be an EOF)
>=20
>=20
> Looking at linux-aio.c though I do see that it just passes through the re=
turned value with no special treatments.=20
> including lack of check for -EINTR.
>=20
> I assume that since aio is linux specific, and it only supports direct IO=
, it happens
> to have assumption of no short reads/-EINTR (but since libaio has very sp=
arse documentation I can't verify this)
>=20
> On the other hand the aio=3Dthreads implementation actually does everythi=
ng as specified on the 'write' manpage,
> retrying the reads on -EINTR, and doing additional reads if less that req=
uired number of bytes were read.
>=20
> Looking at io_uring implementation in the kernel I see that it does suppo=
rt synchronous (non O_DIRECT mode),=20
> and in this case, it goes through the same ->read_iter which is pretty mu=
ch the same path that=20
> regular read() takes and so it might return short reads and or -EINTR.

Interesting point.  Investigating EINTR should at least be a TODO
comment and needs to be resolved before io_uring lands in a QEMU
release.

> > +static int ioq_submit(LuringState *s)
> > +{
> > +    int ret =3D 0;
> > +    LuringAIOCB *luringcb, *luringcb_next;
> > +
> > +    while (s->io_q.in_queue > 0) {
> > +        QSIMPLEQ_FOREACH_SAFE(luringcb, &s->io_q.sq_overflow, next,
> > +                              luringcb_next) {
>=20
> I am torn about the 'sq_overflow' name. it seems to me that its not immed=
iately clear that these
> are the requests that are waiting because the io uring got full, but I ca=
n't now think of a better name.
>=20
> Maybe add a comment here to explain what is going on here?

Hmm...I suggested this name because I thought it was clear.  But the
fact that it puzzled you proves it wasn't clear :-).

Can anyone think of a better name?  It's the queue we keep in QEMU to
hold requests while the io_uring sq ring is full.

> Also maybe we could somehow utilize the plug/unplug facility to avoid rea=
ching that state in first place?
> Maybe the block layer has some kind of 'max outstanding requests' limit t=
hat could be used?
>=20
> In my nvme-mdev I opted to not process the input queues when such a condi=
tion is detected, but here you can't as the block layer
> pretty much calls you to process the requests.

Block layer callers are allowed to submit as many I/O requests as they
like and there is no feedback mechanism.  It's up to linux-aio.c and
io_uring.c to handle the case where host kernel I/O submission resources
are exhausted.

Plug/unplug is a batching performance optimization to reduce the number
of io_uring_enter() calls but it does not stop the callers from
submitting more I/O requests.  So plug/unplug isn't directly applicable
here.

> > +static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState=
 *s,
> > +                            uint64_t offset, int type)
> > +{
> > +    struct io_uring_sqe *sqes =3D io_uring_get_sqe(&s->ring);
> > +    if (!sqes) {
> > +        sqes =3D &luringcb->sqeq;
> > +        QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);
> > +    }
> > +
> > +    switch (type) {
> > +    case QEMU_AIO_WRITE:
> > +        io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
> > +                             luringcb->qiov->niov, offset);
> > +        break;
> > +    case QEMU_AIO_READ:
> > +        io_uring_prep_readv(sqes, fd, luringcb->qiov->iov,
> > +                            luringcb->qiov->niov, offset);
> > +        break;
> > +    case QEMU_AIO_FLUSH:
> > +        io_uring_prep_fsync(sqes, fd, 0);
> > +        break;
> > +    default:
> > +        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\=
n",
> > +                        __func__, type);
>=20
> Nitpick: Don't we use some king of error printing functions like 'error_s=
etg' rather that fprintf?

Here we're not in a context where an Error object can be returned (e.g.
printed by the QMP monitor).  We only have an errno return value that
the emulated storage controller may squash down further to a single
EIO-type error code.

'type' is a QEMU-internal value so the default case is basically
assert(false); /* we should never get here */

For these reasons the fprintf() seems okay here.

> I plan on this or next week to do some benchmarks of the code and I will =
share the results as soon
> as I do them.

Excellent, Aarushi has been benchmarking too.  Perhaps you can share the
QEMU command-line and fio configuration so that the results can be
compared.

Stefan

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0KCvYACgkQnKSrs4Gr
c8gdrggAvtksFXDYkb9KIbSgcMi7SYNTBy5rqoH2jkp8yC5abL1LyURRGl/6rzWL
Q/OOS5Jy9o+g931pb3wmC99qnHc2XcqGlR4NUSThpG8pkKVUo9dvxJjKuT4MKdqx
KEDavuSDZiRwaTHcoKafmAeUA6jpP0knTrmC2AQoD7AsDMWoVbLj3bgkZinnCVim
dmSM7UCyhKsNiJZzXuHrFqiooC/GZuDgGqW812EpxC/yKrDqmF54RiQ5uRwBk/Cp
rCmWKAG4RoomMp7MJU2gjS9LHzR5EK3mYuoRdafqitkSLkymmsRs9W4QKlfDG+HJ
z+J5JLotlDaD48H6mbYqNuND9vkEdg==
=cGpn
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

