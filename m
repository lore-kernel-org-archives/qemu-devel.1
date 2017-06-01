Received: from eggs.gnu.org ([2001:4830:134:3::10]:49077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGW7b-0001Ye-2m
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGW7Y-00039t-1a
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGW7X-00039L-Lz
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:50:59 -0400
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496330073-51338-4-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc70b146-4a16-428f-e2f3-ea9ea09ecc06@redhat.com>
Date: Thu, 1 Jun 2017 14:50:56 -0500
MIME-Version: 1.0
In-Reply-To: <1496330073-51338-4-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="geI0SqHfkpDaOs3gkHxwESGeUc0NVmEq7"
Subject: Re: [Qemu-devel] [PATCH v2 03/15] blkdebug: support
 BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--geI0SqHfkpDaOs3gkHxwESGeUc0NVmEq7
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <dc70b146-4a16-428f-e2f3-ea9ea09ecc06@redhat.com>
Subject: Re: [PATCH v2 03/15] blkdebug: support BDRV_REQ_ALLOCATE
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1496330073-51338-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-4-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 10:14 AM, Anton Nefedov wrote:
> Support the flag if the underlying BDS supports it
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/blkdebug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Shouldn't other passthrough drivers (like raw-format.c) make this change
as well?

>=20
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index a5196e8..8b1401b 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -415,7 +415,8 @@ static int blkdebug_open(BlockDriverState *bs, QDic=
t *options, int flags,
> =20
>      bs->supported_write_flags =3D BDRV_REQ_FUA &
>          bs->file->bs->supported_write_flags;
> -    bs->supported_zero_flags =3D (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &=

> +    bs->supported_zero_flags =3D
> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
>          bs->file->bs->supported_zero_flags;
>      ret =3D -EINVAL;
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--geI0SqHfkpDaOs3gkHxwESGeUc0NVmEq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMHAgAAoJEKeha0olJ0NqVOsH/2fLle8JehzA7dR0y9FCp9xm
zzN6kAgZyHLSTBAkXdgGKiZHDbav0obLft/l0IrwXTJ0GsjdqLt+40LabNWI04Id
8hYO1RucLM+7MnBdLWNmOMSmUOe8j7JXBRdvlKj1kfXQ52i16+1K/p1bI0hAG9+6
CL4px78E2M6oemwjerzbgoSdIKPM+hJlQhdsNfzOIn2LDTahydjOStEGvHdJ6Y4x
oFQEigsbklpShu26OIkwggOpcO+aE8azgNaNbsq63xL8AM5+5Eu1C/bgA9xnNvOl
+MKRmQuCvi3wKAso4LiF3+rNGZiRxapqAARm5gjmALYm3vVtEwENU3AShnS5Zz8=
=DftL
-----END PGP SIGNATURE-----

--geI0SqHfkpDaOs3gkHxwESGeUc0NVmEq7--
