Received: from eggs.gnu.org ([2001:4830:134:3::10]:39134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e7cKZ-00059p-U0
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e7cKW-0005S2-OQ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:11:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1e7cKW-0005RE-FM
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:11:52 -0400
References: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
	<20171025133115.GA23458@lemon>
	<BC29A004BA570342A4CC0044A3845572CFCE5962@H3CMLB12-EX.srv.huawei-3com.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f10f73b8-6b6b-a30e-a147-b7fcaa28b182@redhat.com>
Date: Thu, 26 Oct 2017 09:11:46 +0200
MIME-Version: 1.0
In-Reply-To: <BC29A004BA570342A4CC0044A3845572CFCE5962@H3CMLB12-EX.srv.huawei-3com.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xcxxtJarGcoTRq9EuvUmoVOa5BvDeiAPq"
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'locking' when disable image locking with option locking=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changlimin <changlimin@h3c.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xcxxtJarGcoTRq9EuvUmoVOa5BvDeiAPq
From: Max Reitz <mreitz@redhat.com>
To: Changlimin <changlimin@h3c.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <f10f73b8-6b6b-a30e-a147-b7fcaa28b182@redhat.com>
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'locking' when disable image locking with option locking=off
References: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
 <20171025133115.GA23458@lemon>
 <BC29A004BA570342A4CC0044A3845572CFCE5962@H3CMLB12-EX.srv.huawei-3com.com>
In-Reply-To: <BC29A004BA570342A4CC0044A3845572CFCE5962@H3CMLB12-EX.srv.huawei-3com.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-26 03:06, Changlimin wrote:
> share-rw=3Don is good for raw format file, but bad for qcow2 format fil=
e:
>=20
> Failed to get "write" lock
> Is another process using the image?
>=20
> Is this intented?

Yes, because you can never share qcow2 image files between VMs.  The
qcow2 format itself does not support this, as it may lead to metadata
corruption.

Max


--xcxxtJarGcoTRq9EuvUmoVOa5BvDeiAPq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnxirISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABA0H/07M1/RRe4us+Y1tKI3KiIYBuejK/kVf
xm5vWNT5oO/a74mN03Svop++9TDAGk+R3ZXO6n6+Hfy6CFewc2a5kX3BzCsDr+8U
Xe9F0ROK6d8iY/ZTxQEifSO0WI7fOZB5lCgAxUMbIJGrp6BbGs01dLXxFIhWsB4s
Ydv6Ec0diC+7ebK5A4AoBZryz2ZLrHSKFWlFX93yd2ulWv1Tkurvn/msqKFmKTFZ
FGqsglzOqa7VkQmDIDjWCvNR/lAJwnSl79cKyz7ao6TLoY830cx3pHjqQ2Wpb0xg
U6jwymDsAAP+5q+iNH4CaCfu0NhSIy3/cSGMjl4PYalzLcrfjGrt+fA=
=HScl
-----END PGP SIGNATURE-----

--xcxxtJarGcoTRq9EuvUmoVOa5BvDeiAPq--
