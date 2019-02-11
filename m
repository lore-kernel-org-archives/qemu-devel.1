Received: from eggs.gnu.org ([209.51.188.92]:39520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtOCt-0001VE-7Z
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 21:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtOCr-0002sx-Nk
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 21:53:59 -0500
Date: Mon, 11 Feb 2019 14:03:29 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190211060329.GJ18083@stefanha-x1.localdomain>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqSa+Xr3J/G6Hhls"
Content-Disposition: inline
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/17] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com


--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 01:24:28PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> Here is a new simple helper for a very often patter
> around qemu_iovec_init_external, when we need simple qiov with only
> one iov, initialized from external buffer.
>=20
> v3:
>   01-02: tiny improvements, described in patch-emails
>   03-17: new patches
>=20
>   Note: only hw/scsi/scsi-disk.c not updated, as it has too tricky
>         logic around @iov fields of structures. So, it is simpler to
>         keep it as is.
>=20
> Previous series version was "[PATCH v2 0/2] block: local qiov helper: par=
t I"
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01610.html
>=20
> Vladimir Sementsov-Ogievskiy (17):
>   block: enhance QEMUIOVector structure
>   block/io: use qemu_iovec_init_buf
>   block/block-backend: use QEMU_IOVEC_INIT_BUF
>   block/backup: use qemu_iovec_init_buf
>   block/commit: use QEMU_IOVEC_INIT_BUF
>   block/stream: use QEMU_IOVEC_INIT_BUF
>   block/parallels: use QEMU_IOVEC_INIT_BUF
>   block/qcow: use qemu_iovec_init_buf
>   block/qcow2: use qemu_iovec_init_buf
>   block/qed: use qemu_iovec_init_buf
>   block/vmdk: use qemu_iovec_init_buf
>   qemu-img: use qemu_iovec_init_buf
>   migration/block: use qemu_iovec_init_buf
>   tests/test-bdrv-drain: use QEMU_IOVEC_INIT_BUF
>   hw/ide: drop iov field from IDEState
>   hw/ide: drop iov field from IDEBufferedRequest
>   hw/ide: drop iov field from IDEDMA
>=20
>  include/hw/ide/internal.h |  3 --
>  include/qemu/iov.h        | 64 +++++++++++++++++++++++++++-
>  block/backup.c            |  5 +--
>  block/block-backend.c     | 13 +-----
>  block/commit.c            |  7 +--
>  block/io.c                | 89 +++++++++------------------------------
>  block/parallels.c         | 13 +++---
>  block/qcow.c              | 21 ++-------
>  block/qcow2.c             | 12 +-----
>  block/qed-table.c         | 16 ++-----
>  block/qed.c               | 31 ++++----------
>  block/stream.c            |  7 +--
>  block/vmdk.c              |  7 +--
>  hw/ide/atapi.c            | 14 +++---
>  hw/ide/core.c             | 19 ++++-----
>  migration/block.c         | 10 ++---
>  qemu-img.c                | 10 +----
>  tests/test-bdrv-drain.c   | 29 ++-----------
>  18 files changed, 134 insertions(+), 236 deletions(-)
>=20
> --=20
> 2.18.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NqSa+Xr3J/G6Hhls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYRAwAAoJEJykq7OBq3PIYa8H/2crO5zhfsytDEryJYwLviUz
4vTZ0gr/07j77zBYigJiVb4Ta4dvYd2//eK2ZW/aATPY7eKxGwXE+vhFDLAYEFz9
ddSx4Vx6mq7Vv8BlvP1GQ9hxzwBeCU8jTgrNF1dnnqfihsf6cQ8tYVFPUb+SVQNq
sxkoOxRolQsicToVaoZTychmNsYOkzEcH7+1TNbBAwsz4jjxkfT+TlueeoZyAKXo
6wilbKPg6K4yd8czImWF9yn18WrWOVAoCgP2e1Qq0uCUJCRdUMpKonv+XhMA7iM+
RJUeHLaxoDnUC9uKH52T2j0okjp5cDcNpkktzbcmVkCcM0d6uwz6gEXvqMGcrzg=
=J8s5
-----END PGP SIGNATURE-----

--NqSa+Xr3J/G6Hhls--
