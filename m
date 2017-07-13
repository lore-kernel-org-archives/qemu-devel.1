Received: from eggs.gnu.org ([2001:4830:134:3::10]:55650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVkbB-00056d-8t
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVkbA-00041p-7n
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:20:33 -0400
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-10-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <afed39a8-703e-96de-d06d-f652fbbb967e@redhat.com>
Date: Thu, 13 Jul 2017 15:20:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-10-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eoGH53AQIS4SDgCKvRR9QC4rlmnQl5Xs1"
Subject: Re: [Qemu-devel] [PATCH v2 09/29] vpc: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, "open list:vpc" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eoGH53AQIS4SDgCKvRR9QC4rlmnQl5Xs1
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 "open list:vpc" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <afed39a8-703e-96de-d06d-f652fbbb967e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/29] vpc: use DIV_ROUND_UP
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
 <20170713163219.9024-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 11:31 AM, Marc-Andr=C3=A9 Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/vpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/vpc.c b/block/vpc.c
> index 9a6f8173a5..c88dc72491 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -760,7 +760,7 @@ static int calculate_geometry(int64_t total_sectors=
, uint16_t* cyls,
>      } else {
>          *secs_per_cyl =3D 17;
>          cyls_times_heads =3D total_sectors / *secs_per_cyl;
> -        *heads =3D (cyls_times_heads + 1023) / 1024;
> +        *heads =3D DIV_ROUND_UP(cyls_times_heads, 1024);
> =20
>          if (*heads < 4) {
>              *heads =3D 4;
> @@ -813,7 +813,7 @@ static int create_dynamic_disk(BlockBackend *blk, u=
int8_t *buf,
>      offset =3D 3 * 512;
> =20
>      memset(buf, 0xFF, 512);
> -    for (i =3D 0; i < (num_bat_entries * 4 + 511) / 512; i++) {
> +    for (i =3D 0; i < DIV_ROUND_UP(num_bat_entries * 4, 512); i++) {
>          ret =3D blk_pwrite(blk, offset, buf, 512, 0);
>          if (ret < 0) {
>              goto fail;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eoGH53AQIS4SDgCKvRR9QC4rlmnQl5Xs1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ9YFAAoJEKeha0olJ0NqlngH/RZ+rurzZcfjMv9slQ0Te3P5
s3rvXtXQoAE7AcvNFOB6TThfeeCbtgi4xDToR17zrX/JrYDzpU3zwXx9vyA1Qcvu
mnJGq9gYFFwHvV3WYpzTpljHgCWt6tN+3IMYi2x+VHKTYeFRGFuGfkAD3/tJkSCn
4HJS2vh4tpOALXbdhiy1X/PKb9ffbB2U4EKkj5aOWtbGCL2CegzCvhRwqf8TDECv
YdujPEy7ROKJg3Od9abVgYORIyGBUxeAdQIJnJKH763OMEcNXwGN0VX62AqfhPQ/
mHVKtzKrnxvO6sFqCh2lmf9+bAQ5b8BGz0anQqr/FpeWUyIhDh1OrqtlbZF1j1g=
=O++8
-----END PGP SIGNATURE-----

--eoGH53AQIS4SDgCKvRR9QC4rlmnQl5Xs1--
