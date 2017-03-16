Received: from eggs.gnu.org ([2001:4830:134:3::10]:60921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coKZZ-0000Qe-Lx
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coKZW-0000pZ-J3
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:51:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1coKZW-0000pV-9v
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:51:22 -0400
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-8-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ed926593-88de-90ec-4133-c02d9f1a3766@redhat.com>
Date: Thu, 16 Mar 2017 02:51:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170315092940.1367-8-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3n8pVO7Ug82UAHqv6RHJEc1ddLQFWbgxm"
Subject: Re: [Qemu-devel] [RFC v2 7/8] qemu-iotests: support per-format
 golden output files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3n8pVO7Ug82UAHqv6RHJEc1ddLQFWbgxm
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <ed926593-88de-90ec-4133-c02d9f1a3766@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 7/8] qemu-iotests: support per-format golden
 output files
References: <20170315092940.1367-1-stefanha@redhat.com>
 <20170315092940.1367-8-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-8-stefanha@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 15.03.2017 10:29, Stefan Hajnoczi wrote:
> Some tests produce format-dependent output.  Either the difference is
> filtered out and ignored, or the test case is format-specific so we
> don't need to worry about per-format output differences.
>=20
> There is a third case: the test script is the same for all image format=
s
> and the format-dependent output is relevant.  An ugly workaround is to
> copy-paste the test into multiple per-format test cases.  This
> duplicates code and is not maintainable.
>=20
> This patch allows test cases to add per-format golden output files so a=

> single test case can work correctly when format-dependent output must b=
e
> checked:
>=20
>   123.out.qcow2
>   123.out.raw
>   123.out.vmdk
>   ...
>=20
> This naming scheme is not composable with 123.out.nocache or 123.pc.out=
,
> two other scenarios where output files are split.  I don't think it
> matters since few test cases need these features.

Well, it would be pretty simple to implement by just always using
reference_x=3D"$reference.$NEW_EXTENSION" instead of rebuilding the path
from screatch, but the number of combinations would blow up so much it
may be better to leave that out anyway.

(No R-b because I like to save my precious R-bs for non-RFCs)

Max

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/check | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 4b1c674..29553cf 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -338,6 +338,11 @@ do
>                  reference=3D"$reference_machine"
>              fi
> =20
> +            reference_format=3D"$source_iotests/$seq.out.$IMGFMT"
> +            if [ -f "$reference_format" ]; then
> +                reference=3D"$reference_format"
> +            fi
> +
>              if [ "$CACHEMODE" =3D "none" ]; then
>                  [ -f "$source_iotests/$seq.out.nocache" ] && reference=
=3D"$source_iotests/$seq.out.nocache"
>              fi
>=20



--3n8pVO7Ug82UAHqv6RHJEc1ddLQFWbgxm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljJ75ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALGUIAKMJtBoESozb5r/aeG3Qy/XWxNhONXIf
YX04FfqGY8qHp4wmv8vyi/jaDyfbej7lsral0tvKHmfEb08hMEjKjY+aJmSdRHoI
ZGKK4vb0pTiICzYAWrkHhHPMWxx7k6wd5szTukd4zFOOccQ+kzFK+55g5TmTyKfv
123/dT3POQCu5pjjetIj9BX/a2nm1pnAMZl5fBAq/l4PED0OSuSfaKmxV34mejmn
hvXT9Qfxw/icqSbJ0F+ozD5W6U8aTlq/XxTr9oLWfKuJgifvMQKGltiSbj2rVZWH
fmFTZliwwvisLnKQxJWedO556VrSXNDLb1gxcr1cZo6glF2jrTfQDLI=
=V6M+
-----END PGP SIGNATURE-----

--3n8pVO7Ug82UAHqv6RHJEc1ddLQFWbgxm--
