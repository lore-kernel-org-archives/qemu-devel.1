Received: from eggs.gnu.org ([2001:4830:134:3::10]:58448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Nm5-0005re-Qu
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Nm1-0006V6-Os
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:18:33 -0400
References: <20170426141407.10161-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4d1a9fa-a155-3760-bb4e-69200764476e@redhat.com>
Date: Wed, 26 Apr 2017 09:18:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170426141407.10161-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ibihrm3V9mBpip1GLNS18Aceq23fPK5u5"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: Launch qemu-nbd with
 -e 42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ibihrm3V9mBpip1GLNS18Aceq23fPK5u5
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c4d1a9fa-a155-3760-bb4e-69200764476e@redhat.com>
Subject: Re: [Qemu-block] [PATCH] iotests: Launch qemu-nbd with -e 42
References: <20170426141407.10161-1-mreitz@redhat.com>
In-Reply-To: <20170426141407.10161-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 09:14 AM, Max Reitz wrote:
> There is no reason for the qemu-nbd server used for tests not to accept=

> an arbitrary number of clients. In fact, test 181 will require it to
> accept two clients at the same time (and thus it fails before this
> patch).
>=20
> This patch updates common.rc to launch qemu-nbd with -e 42 which should=

> be enough for all of our current and future tests.

Perfect place for you to inject some jibe about "life, the universe, and
everything" ;)

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


>=20
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.r=
c
> index 7d4781d4ad..31b888d4e9 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -168,7 +168,9 @@ _make_test_img()
> =20
>      # Start an NBD server on the image file, which is what we'll be ta=
lking to
>      if [ $IMGPROTO =3D "nbd" ]; then
> -        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_=
IMG_FILE >/dev/null &"
> +        # Pass a sufficiently high number to -e that should be enough =
for all
> +        # tests
> +        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT -e 42  =
$TEST_IMG_FILE >/dev/null &"

Worth dropping the double-space before $TEST_IMG_FILE while touching this=
?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ibihrm3V9mBpip1GLNS18Aceq23fPK5u5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAKwnAAoJEKeha0olJ0Nq1eEH/2IIb2oYJaV+16SQPn9e4fj/
ik2rrULX9/xBGTIAC0C0gQAG6xP66L6Cc0U5oU7LYyt1jJzkaWrHofeA4CyYuOIz
O8pl3ujlHpoOxICeN6n03QO+NLcZiKCxiqYdwrGPcHcHx1jsN1QfrhbMxJSk15nG
TthTY/Wb8fxxos72sOp4oEYjaYN2LDpQU0ilBSLfJ2Fr0BDzl8QmbILsVYXlufJl
GcLtC/xCYAu2CEkwgr4coQE+kZUgYncyeVxHOubgU1NXNpvkTywbufK8fYGeg7+j
iBmHvcg/mkrhke1WxFFs0VZG/2pqsYdfPFopinBRfJMl/HgbXIZnX7Ov3gRd0ZQ=
=7X2O
-----END PGP SIGNATURE-----

--ibihrm3V9mBpip1GLNS18Aceq23fPK5u5--
