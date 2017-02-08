Received: from eggs.gnu.org ([2001:4830:134:3::10]:40539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbSgS-00078k-TB
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbSgP-0002QQ-NK
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:53:21 -0500
References: <20170208080900.4092-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3dccbc96-1ba2-5cd5-041c-4ed071fddfcb@redhat.com>
Date: Wed, 8 Feb 2017 07:53:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170208080900.4092-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m2k6SrU6K9TT8IDNnBVsDTeWTRruX23jr"
Subject: Re: [Qemu-devel] [PATCH] qcow2: remove useless NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m2k6SrU6K9TT8IDNnBVsDTeWTRruX23jr
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-trivial@nongnu.org
Message-ID: <3dccbc96-1ba2-5cd5-041c-4ed071fddfcb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: remove useless NULL check
References: <20170208080900.4092-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170208080900.4092-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/08/2017 02:09 AM, Marc-Andr=C3=A9 Lureau wrote:
> g_strdup() already handles the case where the argument is NULL.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/qcow2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 96fb8a8f16..9114218030 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2016,8 +2016,8 @@ static int qcow2_change_backing_file(BlockDriverS=
tate *bs,
>      g_free(s->image_backing_file);
>      g_free(s->image_backing_format);
> =20
> -    s->image_backing_file =3D backing_file ? g_strdup(bs->backing_file=
) : NULL;
> -    s->image_backing_format =3D backing_fmt ? g_strdup(bs->backing_for=
mat) : NULL;
> +    s->image_backing_file =3D g_strdup(bs->backing_file);
> +    s->image_backing_format =3D g_strdup(bs->backing_format);
> =20
>      return qcow2_update_header(bs);
>  }
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--m2k6SrU6K9TT8IDNnBVsDTeWTRruX23jr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmyLKAAoJEKeha0olJ0Nqt9YH/3G+n/+rDGknCLDDOHHwGtaV
TXsfLNqITpUpyhsKAcdwNaqiTNBDaE9fkJ+D/EnGVn8a+qP6foLqOAtJflH6C51L
O06I337v36e2hba9AO/lJVy3cK9aM76cK/+c2of+OEcjXArpu2DwIDRkyQwytai2
IM2Klz4s9bf3FxYeMAUNJmxz2btD4zageARb7kaf6J4qSutZzOMXeCEKKMx1F6YJ
yG+hqLoUS6XVpCEp/QwrSHtjMdwIMlcN/D0gGpzyMaO3vW2bGG5syHJfsO6F1T73
yM1yXXg/ssY9L4MJ+m7MWW+FUYt5OVRVoR6jo2RmP9UgtOiLuiatUmKAwq2Nj90=
=6gTy
-----END PGP SIGNATURE-----

--m2k6SrU6K9TT8IDNnBVsDTeWTRruX23jr--
