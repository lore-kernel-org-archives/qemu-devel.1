Received: from eggs.gnu.org ([2001:4830:134:3::10]:39111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgW1T-0001sI-HS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgW1S-0006qq-T3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:27:55 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-2-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <edb36e3a-42bb-a2f6-7c7f-6de45f8d5000@redhat.com>
Date: Wed, 22 Feb 2017 13:27:44 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-2-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lOXmbHItCXG854MVo4uJIQTedijlCRQMI"
Subject: Re: [Qemu-devel] [PATCH 01/54] blockdev: Use BlockBackend to resize
 in qmp_block_resize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lOXmbHItCXG854MVo4uJIQTedijlCRQMI
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <edb36e3a-42bb-a2f6-7c7f-6de45f8d5000@redhat.com>
Subject: Re: [PATCH 01/54] blockdev: Use BlockBackend to resize in
 qmp_block_resize()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:57, Kevin Wolf wrote:
> In order to be able to do permission checking and to keep working with
> the BdrvChild based bdrv_truncate() that this involves, we need to
> create a temporary BlockBackend to resize the image.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockdev.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--lOXmbHItCXG854MVo4uJIQTedijlCRQMI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitg8ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMQUH/iOd2Y593c8yUCmZOkMMun2i9g8vv+V4
MKZgrlmZ5xZCHIIMh6/B/r0tJ4oi/PYRslaSMS/oOBl28Jz2RiSPrLuGcG+GemGx
4ptBNIn+0b5wxJBci6m9mPQI2mF/5yMWKHaTuKfAGayNbN1281QSZK4RSsxWVory
wwps3Mk2QQQS584j1+BtyxEwwKfudjqBpqBV9zzEZo+LObrMBvpFoBXWjmD9wLGd
brojnuNAU01UPi9LhPcY996Cxc5XNQE/v/22C/lgwkJb/hO6A+WvwVuWG/WPiCdx
2j0HOu1Ls1iqqwtxu267qaGtMuMNKPoA8hFJyUjUpjEFklp8gSfaHk8=
=dTzD
-----END PGP SIGNATURE-----

--lOXmbHItCXG854MVo4uJIQTedijlCRQMI--
