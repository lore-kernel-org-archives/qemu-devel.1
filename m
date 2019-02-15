Received: from eggs.gnu.org ([209.51.188.92]:60184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1guix6-0003DA-F1
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1guix5-0000nb-Ov
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:15:12 -0500
References: <20190123103323.4516-1-stefanha@redhat.com>
	<20190123103323.4516-3-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7b9da22a-0756-054e-daad-9dba582a7487@redhat.com>
Date: Fri, 15 Feb 2019 20:14:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190123103323.4516-3-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RNlivSOyUw9XkBSIOq0ENEU9hbXu0tezL"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: add LUKS payload overhead
 to 178 qemu-img measure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RNlivSOyUw9XkBSIOq0ENEU9hbXu0tezL
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <7b9da22a-0756-054e-daad-9dba582a7487@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: add LUKS payload overhead to 178 qemu-img
 measure test
References: <20190123103323.4516-1-stefanha@redhat.com>
 <20190123103323.4516-3-stefanha@redhat.com>
In-Reply-To: <20190123103323.4516-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.19 11:33, Stefan Hajnoczi wrote:
> The previous patch includes the LUKS payload overhead into the qemu-img=

> measure calculation for qcow2.  Update qemu-iotests 178 to exercise thi=
s
> new code path.
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/178           |  8 ++++++++
>  tests/qemu-iotests/178.out.qcow2 | 24 ++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
> index 3f4b4a4564..23eb017ea1 100755
> --- a/tests/qemu-iotests/178
> +++ b/tests/qemu-iotests/178
> @@ -142,6 +142,14 @@ for ofmt in human json; do
>              # The backing file doesn't need to exist :)
>              $QEMU_IMG measure --output=3D$ofmt -o backing_file=3Dx \
>                                -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
> +
> +            echo
> +            echo "=3D=3D $fmt input image and LUKS encryption =3D=3D"
> +            echo
> +            $QEMU_IMG measure --output=3D$ofmt \
> +                              --object secret,id=3Dsec0,data=3Dbase \
> +                              -o encrypt.format=3Dluks,encrypt.key-sec=
ret=3Dsec0 \
> +                              -f "$fmt" -O "$IMGFMT" "$TEST_IMG"

With the change in patch 1, it would be possible to set
encrypt.iter-time=3D10, for example (default for the LUKS tests).  For me=
,
that decreases the test's runtime from 24 to 15 seconds.

Pretty please? :-)

Max

>          fi
> =20
>          echo


--RNlivSOyUw9XkBSIOq0ENEU9hbXu0tezL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxnD7MACgkQ9AfbAGHV
z0AwXwf+JTtmVbC2lBwLHkBEY08Tol/b3aqSTq4qSYxLwoZDUq5oezmG8x8n2yXw
vgbLRe6i8uKm9T4k9xrZ1YZbTD4LZAirLVxVtHSirCJ9pY5gQV4GKl5uXhwAOl3/
XaOHhP9LhFNocS675lQEWouSiaSBtP9yVnS3YfqczgOcEqyIklw1mdh4u/fs7TPz
T6COXjRLjE/VIf9y+h0DObX51JeaoJIj0JrvIggwo5Bt4MT5zjt6U7efI3vKFPHa
mUFg8F6G2kZZZ9nK+bTMbQvUYSDxgJVmP901waz0v7vMcL2K6d/4eEMRVoBOB7Pi
ZPfFARRy+8Ymao1Kw+SUolf/UG+m2g==
=fxL7
-----END PGP SIGNATURE-----

--RNlivSOyUw9XkBSIOq0ENEU9hbXu0tezL--
