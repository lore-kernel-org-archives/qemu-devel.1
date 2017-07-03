Received: from eggs.gnu.org ([2001:4830:134:3::10]:44249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS3qf-0002ur-PN
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS3qe-0005uf-Pn
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:05:17 -0400
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-3-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e2327ac-0acb-4485-8036-db3483fcb82e@redhat.com>
Date: Mon, 3 Jul 2017 11:05:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170629184320.7151-3-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gr0N1r9F6jUceCxQtLgNVLJqDPgm1vKfp"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block: use defaults of bdrv_*
 callbacks in raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gr0N1r9F6jUceCxQtLgNVLJqDPgm1vKfp
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <1e2327ac-0acb-4485-8036-db3483fcb82e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block: use defaults of bdrv_*
 callbacks in raw
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
 <20170629184320.7151-3-el13635@mail.ntua.gr>
In-Reply-To: <20170629184320.7151-3-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 01:43 PM, Manos Pitsidianakis wrote:
> Now that passing the call to bs->file is the default for some bdrv_*
> callbacks, remove the duplicate implementations in block/raw-format.c
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/raw-format.c | 32 +-------------------------------
>  1 file changed, 1 insertion(+), 31 deletions(-)
>=20

> @@ -479,16 +454,11 @@ BlockDriver bdrv_raw =3D {
>      .bdrv_truncate        =3D &raw_truncate,
>      .bdrv_getlength       =3D &raw_getlength,
>      .has_variable_length  =3D true,
> -    .bdrv_get_info        =3D &raw_get_info,
>      .bdrv_refresh_limits  =3D &raw_refresh_limits,
>      .bdrv_probe_blocksizes =3D &raw_probe_blocksizes,
>      .bdrv_probe_geometry  =3D &raw_probe_geometry,
> -    .bdrv_media_changed   =3D &raw_media_changed,
> -    .bdrv_eject           =3D &raw_eject,
> -    .bdrv_lock_medium     =3D &raw_lock_medium,
>      .bdrv_co_ioctl        =3D &raw_co_ioctl,
> -    .create_opts          =3D &raw_create_opts,
> -    .bdrv_has_zero_init   =3D &raw_has_zero_init
> +    .create_opts          =3D &raw_create_opts

Please use a trailing comma here. It causes less churn in future patches
if you don't have to have a -/+ line pair just re-adding the comma.
(Yes, we didn't have a trailing comma, but we should have had one; your
patch is now the chance to make it so).

With that fixed, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Gr0N1r9F6jUceCxQtLgNVLJqDPgm1vKfp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWmswAAoJEKeha0olJ0NqcKYH/29DmxMU2sPw+llErvdmhOvC
SQr/jid6slkOBMrmHiXEJ7kiLKoxP1QmN8ZCDNPeKGHA5VFFHDe5LP+T6Qpf7tRN
s0q55zD6qPO+KMAHvJnyA2PyhitAkBXqjlWGKZ0TyVFEXOfyiFu8Q0yBJQ2wzNjm
Gt6YZBIg2bP26GuWU9LzIX2X4M0hJGlYyM+YiIOu111eoYiEOSUeAFY/Xlc9aaZ5
XiKLxHD0X6MoYxh2lYIcfNT8opZ3l+6XiWcyVBeh2BtIcLgAfYb0IHq+8kNpBDCP
x8txUDHbFTg9ebMkDxMePgohEeQjjSxL0bwu4s4I4yvjRwXzkqUU/JGWbWOJYNQ=
=/3Sx
-----END PGP SIGNATURE-----

--Gr0N1r9F6jUceCxQtLgNVLJqDPgm1vKfp--
