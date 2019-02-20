Received: from eggs.gnu.org ([209.51.188.92]:59762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUxZ-0000dg-Kv
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUxV-0004ps-4s
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:43:00 -0500
Date: Wed, 20 Feb 2019 16:42:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190220164241.GI30403@stefanha-x1.localdomain>
References: <20190218140926.333779-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Content-Disposition: inline
In-Reply-To: <20190218140926.333779-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/17] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com


--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 05:09:09PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> Here is a new simple helper for a very often patter
> around qemu_iovec_init_external, when we need simple qiov with only
> one iov, initialized from external buffer.
>=20
> v4:
>  01: tiny improvements by Eric
>      + fix bug: s/niov/nalloc in assertion
>      + rename s/qemu_iovec_get_buf/qemu_iovec_buf,
>        to don't look like getter, which in turn should not return
>        pointer to something internal to be freed separately.
>      So, no r-b's in 01=20
>  07,10,16
>     - rebase on new function name qemu_iovec_buf=20
>     - save r-b's by Eric and Stefan
>  others unchanged, add r-b's by Eric and Stefan
>=20
> v3:
>   01-02: tiny improvements, described in patch-emails
>   03-17: new patches
>=20
>   Note: only hw/scsi/scsi-disk.c not updated, as it has too tricky
>         logic around @iov fields of structures. So, it is simpler to
>         keep it as is.
>=20
> v2 was "[PATCH v2 0/2] block: local qiov helper: part I"
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
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcbYOBAAoJEJykq7OBq3PI/VUH/3ZgCbBdxUjgN+T6BmkyC044
iw9EZXbOKxvfdHjX/IZB/XRfg6LsGXUuOLzd0OYbflvIA0/pbehRML+NxMzTa7I2
VU7teU2iN3s1LJ7BsT5FGCt6BN6uOMdNOlY3FcIZZbrbcSRde5joOrpdq8vA2TIN
djnQjRNLPwX0eRV+PzfZpVPIS2T+Tvm6p0dfEUvrXGrCEGW5sjp/Uq5ttCBEOAPB
yKsG9BxVmthbIePsou7h3oe4ol24qUgYYLNqWVcVkXvPHcFCtVQuivtq9oUKqr3i
SW42DDOlaruG/uhoKOAL5iPZMhWFayjgGT4XqA6b+ymqxGcsFfspdC+H3B5cr4U=
=DgVu
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--
