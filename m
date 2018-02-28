Received: from eggs.gnu.org ([2001:4830:134:3::10]:58290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1er3yL-0002w8-Qh
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1er3yI-00009r-OJ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:48:49 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1er3yI-00008M-Gp
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:48:46 -0500
Received: by mail-wr0-x243.google.com with SMTP id p104so2900806wrc.12
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 07:48:45 -0800 (PST)
Date: Wed, 28 Feb 2018 15:48:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180228154843.GA1248@stefanha-x1.localdomain>
References: <20180216165015.30715-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20180216165015.30715-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] block: fix blk_aio_*() segfault
 when blk->root == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 04:50:10PM +0000, Stefan Hajnoczi wrote:
> v3:
>  * Add Patch 1 to rename aio_context_in_iothread() to
>    in_aio_context_home_thread() [Eric]
> v2:
>  * Introduce AIO_WAIT_WHILE() since aio_poll(ctx, true) is not allowed [P=
aolo]
>=20
> Using bdrv_inc_in_flight(blk_bs(blk)) doesn't work since BlockBackend->ro=
ot may
> be NULL.
>=20
> This patch series solves the issue by adding an BlockBackend->in_flight c=
ounter
> so requests can be tracked even when there is no BlockDriverState.
>=20
> This should fix the IDE and virtio-blk segfaults that have been encounter=
ed
> when there is no BlockDriverState.
>=20
> The patch is based on work by Kevin Wolf.
>=20
> Kevin Wolf (1):
>   block: test blk_aio_flush() with blk->root =3D=3D NULL
>=20
> Stefan Hajnoczi (4):
>   aio: rename aio_context_in_iothread() to in_aio_context_home_thread()
>   block: extract AIO_WAIT_WHILE() from BlockDriverState
>   block: add BlockBackend->in_flight counter
>   Revert "IDE: Do not flush empty CDROM drives"
>=20
>  tests/Makefile.include     |   2 +
>  util/Makefile.objs         |   2 +-
>  include/block/aio-wait.h   | 116 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/block/aio.h        |   7 ++-
>  include/block/block.h      |  40 +++-------------
>  include/block/block_int.h  |   7 ++-
>  block.c                    |   7 ++-
>  block/block-backend.c      |  60 ++++++++++++++++++++---
>  block/io.c                 |  10 +---
>  hw/ide/core.c              |  10 +---
>  tests/test-block-backend.c |  82 ++++++++++++++++++++++++++++++++
>  util/aio-wait.c            |  40 ++++++++++++++++
>  12 files changed, 318 insertions(+), 65 deletions(-)
>  create mode 100644 include/block/aio-wait.h
>  create mode 100644 tests/test-block-backend.c
>  create mode 100644 util/aio-wait.c

Any more comments?

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJals9aAAoJEJykq7OBq3PIX98IAJWsqu1dOlolzlru/6F1vT5q
MkEkraIOdkhOtNdlkgZLINGe2SMDYw10voP3CKsSbfQ5SRkBgbprd9PYLIQ66Nic
ykWUJLOBFUqdWhlo2gBb7iStrb4EGuJ+V/68qAw860j6Ry3ROIFG3pxgzuOh1CgM
IaRO6j2ikm3gjHd5c0w0dqGxNRM3I/6qIbQiEJ/F+e2J8Q9Ukpmqq659IOrNzWUU
p91rE2MFDoHPpxlTGZVRULTBFjLaOk+v2qInF2YQHbB6u1vjnDZoYtA6He/EbrLJ
xlEyd+NDF270OHyVuPNF2VGvcmxr4NSPOAfE07aqTSOqRvPK1O/K1162dj8VQpc=
=gDFW
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
