Received: from eggs.gnu.org ([2001:4830:134:3::10]:55366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckzrh-0004Pm-4m
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckzrg-0008Ni-Cn
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:08:21 -0500
References: <20170306195255.15806-1-mreitz@redhat.com>
	<20170306195407.16415-2-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <da15caba-8c83-1ebd-4a2e-593e88c011b0@redhat.com>
Date: Mon, 6 Mar 2017 22:08:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170306195407.16415-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MhHFtQsn8Jjl2cPc02KqiPhUsWDfcgjwe"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/3] block: Add errp to
 BD.bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MhHFtQsn8Jjl2cPc02KqiPhUsWDfcgjwe
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <da15caba-8c83-1ebd-4a2e-593e88c011b0@redhat.com>
Subject: Re: [PATCH for-2.10 2/3] block: Add errp to BD.bdrv_truncate()
References: <20170306195255.15806-1-mreitz@redhat.com>
 <20170306195407.16415-2-mreitz@redhat.com>
In-Reply-To: <20170306195407.16415-2-mreitz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 06.03.2017 20:54, Max Reitz wrote:
> Add an Error parameter to the block drivers' bdrv_truncate() interface.=

> If a block driver does not set this in case of an error, the generic
> bdrv_truncate() implementation will do so.
>=20
> Where it is obvious, this patch also makes some block drivers set this
> value.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block_int.h |  2 +-
>  block.c                   |  4 ++--
>  block/archipelago.c       |  3 ++-
>  block/blkdebug.c          |  4 ++--
>  block/crypto.c            |  5 +++--
>  block/file-posix.c        |  2 +-
>  block/file-win32.c        |  6 +++---
>  block/gluster.c           |  3 ++-
>  block/iscsi.c             |  4 ++--
>  block/nfs.c               |  2 +-
>  block/qcow2.c             |  8 ++++----
>  block/qed.c               |  2 +-
>  block/raw-format.c        |  4 ++--
>  block/rbd.c               |  2 +-
>  block/sheepdog.c          | 14 ++++++--------
>  15 files changed, 33 insertions(+), 32 deletions(-)

[...]


> diff --git a/block/archipelago.c b/block/archipelago.c
> index 2449cfc702..0015178381 100644
> --- a/block/archipelago.c
> +++ b/block/archipelago.c
> @@ -976,7 +976,8 @@ static int64_t qemu_archipelago_getlength(BlockDriv=
erState *bs)
>      return archipelago_volume_info(s);
>  }
> =20
> -static int qemu_archipelago_truncate(BlockDriverState *bs, int64_t off=
set)
> +static int qemu_archipelago_truncate(BlockDriverState *bs, int64_t off=
set,
> +                                     Error *errp)

This should be **errp, of course. Will fix. :-/

Max

>  {
>      int ret, targetlen;
>      struct xseg_request *req;


--MhHFtQsn8Jjl2cPc02KqiPhUsWDfcgjwe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli9z7wSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Acq4IAJ9EBeoqhsPd5BgoGzknNE6+upL/DTog
QRoz+SkRbmX975kZpDreVld+I1FbPZqtqMb53FUBM2ucXe1TGqQnVQCOhAgWX+Tx
MVzULq+BFSQX5soK1yNYjBq/WA4u8sTL7Fc8Srsp6GpKpSeFlHLch38wyeLXUeju
iTPJ85W0AClH6sZxCAozIeBWR+aJ8Re1r1MvSx/qSHPgzxe/RYyNepq+5LUKiUo2
4Fcq4zv3WfHKWpCcBLnX+w6Yb6cdxpgYtF7JYYlo7ojrWTqs1mSFqh7f6Ppt0m1G
Pd/a4QSUMSqicRFEJAtwSqFI1xXTJRctcQzF9ySWsVTXU0eC32LAm3I=
=dU1z
-----END PGP SIGNATURE-----

--MhHFtQsn8Jjl2cPc02KqiPhUsWDfcgjwe--
