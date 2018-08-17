Received: from eggs.gnu.org ([2001:4830:134:3::10]:41644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqgAJ-0000mE-4L
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqgAE-0001F7-0z
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:55:51 -0400
Received: from ec2-34-202-238-73.compute-1.amazonaws.com
	([34.202.238.73]:47276 helo=vps.thesusis.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <psusi@ubuntu.com>) id 1fqgAD-0001Cl-OQ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:55:45 -0400
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180816172722.GK23515@redhat.com>
	<83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
	<20180817085656.GA11124@redhat.com>
	<a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
	<20180817125808.GO11124@redhat.com>
	<b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
	<20180817131226.GP11124@redhat.com>
	<e88687b0-f116-e6eb-0432-12e38ecece2f@ubuntu.com>
	<20180817144421.GS11124@redhat.com>
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <389b2689-b86e-26be-6e4e-506559df7450@ubuntu.com>
Date: Fri, 17 Aug 2018 10:55:38 -0400
MIME-Version: 1.0
In-Reply-To: <20180817144421.GS11124@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="22dZaXyhvbr4yUmqJmvMc3ZIzcirLdOiX"
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--22dZaXyhvbr4yUmqJmvMc3ZIzcirLdOiX
From: Phillip Susi <psusi@ubuntu.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <389b2689-b86e-26be-6e4e-506559df7450@ubuntu.com>
Subject: Re: Pipe key broken on US keyboards
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
 <20180816172722.GK23515@redhat.com>
 <83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
 <20180817085656.GA11124@redhat.com>
 <a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
 <20180817125808.GO11124@redhat.com>
 <b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
 <20180817131226.GP11124@redhat.com>
 <e88687b0-f116-e6eb-0432-12e38ecece2f@ubuntu.com>
 <20180817144421.GS11124@redhat.com>
In-Reply-To: <20180817144421.GS11124@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/17/2018 10:44 AM, Daniel P. Berrang=C3=A9 wrote:
> 0x2b is 43 in hex.
>=20
> xev reports the Xorg scancode, which is the same as the XT/AT-set1
> scancodes, with an offset of 8 added
>=20
> IOW, 51 from xev does actually match 0x2b from XT scancode set

Oy vey!  Just for fun they decided to add 8 eh?  Which set does linux
configure the keyboard controller for?  I guess I need to find the code
that is translating the key code to the scan code in whatever set that
is, and it should be using a 0x56 that needs changed to 0x2b ( assuming
linux is using set 1? ).



--22dZaXyhvbr4yUmqJmvMc3ZIzcirLdOiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbduHuAAoJENsuw7lhAP6E7oMH/2QNjUvyRB1UhwxXfxQqVG7p
GsX5Y38977pFb1apdOqvQYb0CYEQeE/xPy9PHlZ0JGSRa25Hy9glM60PK1IvPxWS
1nOxOMyBfL5ryuQQrsUI9HPD4D5ab0S2DsaohexKwVaAeh2vu6le87HJMPUCDp8P
mKJnowLJa4NXcyWUzP/YRVsa0nM76TO/PpiWipavtgnYKSNivLGhxfQffXepWDXz
b+kX4nylgsuVsNDKGP1QmEZ4TBlp3f/0SAlV2UT14XFqZX40UgzGN0fIF2bSF3MF
qnm0y2mR20TX2DpyDhGnlosWaWvaDcVZ9bTF+x2M/3/xKMK+37pnjrS8u3ArJOY=
=ySwA
-----END PGP SIGNATURE-----

--22dZaXyhvbr4yUmqJmvMc3ZIzcirLdOiX--
