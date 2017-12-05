Received: from eggs.gnu.org ([2001:4830:134:3::10]:58569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1eM9Al-0000P5-So
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 04:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1eM9Ag-0004Gm-V8
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 04:05:51 -0500
References: <20171205010820.27732-1-jsnow@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <fed2fb73-d490-dc88-a65c-0df7dd0bcddb@redhat.com>
Date: Tue, 5 Dec 2017 10:05:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171205010820.27732-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Mnf6p4euWpcFcvB7b42m3dMH5iDkbLcCP"
Subject: Re: [Qemu-devel] [PATCH v2] iotests: fix 197 for vpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mnf6p4euWpcFcvB7b42m3dMH5iDkbLcCP
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <fed2fb73-d490-dc88-a65c-0df7dd0bcddb@redhat.com>
Subject: Re: [PATCH v2] iotests: fix 197 for vpc
References: <20171205010820.27732-1-jsnow@redhat.com>
In-Reply-To: <20171205010820.27732-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 5.12.2017 v 02:08 John Snow napsal(a):
> VPC has some difficulty creating geometries of particular size.
> However, we can indeed force it to use a literal one, so let's
> do that for the sake of test 197, which is testing some specific
> offsets.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/197           | 4 ++++
>  tests/qemu-iotests/common.filter | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
> index 887eb4f496..5e869fe2b7 100755
> --- a/tests/qemu-iotests/197
> +++ b/tests/qemu-iotests/197
> @@ -60,6 +60,10 @@ echo '=3D=3D=3D Copy-on-read =3D=3D=3D'
>  echo
> =20
>  # Prep the images
> +# VPC rounds image sizes to a specific geometry, force a specific size=
=2E
> +if [ "$IMGFMT" =3D "vpc" ]; then
> +    IMGOPTS=3D$(_optstr_add "$IMGOPTS" "force_size")
> +fi

Yep, the comment is helpful and it works well. (well "-nbd -vpc" fails, b=
ut that is another story)

Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=20


>  _make_test_img 4G
>  $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
>  IMGPROTO=3Dfile IMGFMT=3Dqcow2 IMGOPTS=3D TEST_IMG_FILE=3D"$TEST_WRAP"=
 \
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/comm=
on.filter
> index d9237799e9..f08248bfd9 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -134,7 +134,8 @@ _filter_img_create()
>          -e "s# log_size=3D[0-9]\\+##g" \
>          -e "s# refcount_bits=3D[0-9]\\+##g" \
>          -e "s# key-secret=3D[a-zA-Z0-9]\\+##g" \
> -        -e "s# iter-time=3D[0-9]\\+##g"
> +        -e "s# iter-time=3D[0-9]\\+##g" \
> +        -e "s# force_size=3D\\(on\\|off\\)##g"
>  }
> =20
>  _filter_img_info()
>=20



--Mnf6p4euWpcFcvB7b42m3dMH5iDkbLcCP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJaJmFYExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFa
qggAwjbGJI3AYUI7SVRgs8vx4TdFf93z3PRwbi0U1iUoCV/tPo8bK7EpEI4i1gIy
EfR/EKFbF+qfsV8Br7Y3Xml9Nk/XOxkwlf+RkC+oVPo74SCJXm5XFXMBdjr5ri3l
X8Bj39nm9KsN9U3BDAXMWDOS/ziYpg+/f7Kt8QE50rp+YPKjSgghVNNL7xGGds6f
59PQ7mhWKIu1wlRVZiaUQGJAlQG/7gIoce4mfktAkMSCL4fd/u0+w2VlmNZjhioj
PRAicg6n1/UNzSGarSwF0FUgR05uGL2Zv5JsB7/CItlvJg4zNx2zjrO6vhJIIrGZ
H7nO2vA/rMDLnxJ2vq4d2jx12A==
=KuHM
-----END PGP SIGNATURE-----

--Mnf6p4euWpcFcvB7b42m3dMH5iDkbLcCP--
