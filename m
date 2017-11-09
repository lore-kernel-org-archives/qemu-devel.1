Received: from eggs.gnu.org ([2001:4830:134:3::10]:48072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCnSA-0006q8-8T
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCnS4-00032X-L1
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:05:10 -0500
References: <20171109013804.14488-1-mreitz@redhat.com>
	<20171109013804.14488-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4f27b1ba-33fb-f385-f609-36ebcd80b0e0@redhat.com>
Date: Thu, 9 Nov 2017 08:04:45 -0600
MIME-Version: 1.0
In-Reply-To: <20171109013804.14488-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rDJk3rQWuDlnIls16NDBUeMqAxi32QU4r"
Subject: Re: [Qemu-devel] [PATCH 2/5] iotests: Add missing 'blkdebug::' in
 040
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rDJk3rQWuDlnIls16NDBUeMqAxi32QU4r
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <4f27b1ba-33fb-f385-f609-36ebcd80b0e0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] iotests: Add missing 'blkdebug::' in 040
References: <20171109013804.14488-1-mreitz@redhat.com>
 <20171109013804.14488-3-mreitz@redhat.com>
In-Reply-To: <20171109013804.14488-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 07:38 PM, Max Reitz wrote:
> 040 tries to invoke pause_drive() on a drive that does not use blkdebug=
=2E
> Good idea, but let's use blkdebug to make it actually work.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/040 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index c284d08796..90b5b4f2ad 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -289,7 +289,7 @@ class TestSetSpeed(ImageCommitTestCase):
>          qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D=
%s' % mid_img, test_img)
>          qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 0 512', test=
_img)
>          qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 5242=
88', mid_img)
> -        self.vm =3D iotests.VM().add_drive(test_img)
> +        self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
>          self.vm.launch()
> =20
>      def tearDown(self):
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rDJk3rQWuDlnIls16NDBUeMqAxi32QU4r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEYH0ACgkQp6FrSiUn
Q2oKsQgAqxxSA+7+n2R4i4X8EyQXtUOXyMoYI8Xt/AyMqf4W2b9QBPRnp+QvKBZo
AbXnN7ch8leif30YQyPHK/0wPBP2jvYsjqFHK/tWnfDBxkHUqbU8lZeZoQtSo9uF
7pP+dwCqZozAXwHTMB0G92cCz2bX1Kp8bNupP6KXHv73I73CV//xFTuSvtVCYIWz
o2U/lGR5MKS/x/iiYFv7+0WlI26SZnfhXgDzF+jprGZaKmiWsSeXKaD9rsONuw+G
/oxIxYCiKQLCmnlnO1Ts1GIMD8+OWi1Pz+ESaBX1MTsUv59gj9CNTLyqtBy2jsl9
xgR1KRtIA04qXaWRQkEdiFShCtV5aA==
=quxJ
-----END PGP SIGNATURE-----

--rDJk3rQWuDlnIls16NDBUeMqAxi32QU4r--
