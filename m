Received: from eggs.gnu.org ([2001:4830:134:3::10]:45869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1frl5p-0005rP-9r
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1frl5m-0008EZ-2d
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:23:41 -0400
Received: from ec2-34-202-238-73.compute-1.amazonaws.com
	([34.202.238.73]:50200 helo=vps.thesusis.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <psusi@ubuntu.com>) id 1frl5l-0008E3-Ub
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:23:38 -0400
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180817150513.GT11124@redhat.com>
	<6bf952d9-0269-c5df-6cac-70104ec88f81@ubuntu.com>
	<20180820084329.3uhnobuy5g52zqio@sirius.home.kraxel.org>
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <b91de5ea-7719-0301-7c7a-fb06785da0dc@ubuntu.com>
Date: Mon, 20 Aug 2018 10:23:32 -0400
MIME-Version: 1.0
In-Reply-To: <20180820084329.3uhnobuy5g52zqio@sirius.home.kraxel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lJ3qIoH6UTUKHY8WhJuzKSiftyhvsjLU3"
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lJ3qIoH6UTUKHY8WhJuzKSiftyhvsjLU3
From: Phillip Susi <psusi@ubuntu.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <b91de5ea-7719-0301-7c7a-fb06785da0dc@ubuntu.com>
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
 <20180817150513.GT11124@redhat.com>
 <6bf952d9-0269-c5df-6cac-70104ec88f81@ubuntu.com>
 <20180820084329.3uhnobuy5g52zqio@sirius.home.kraxel.org>
In-Reply-To: <20180820084329.3uhnobuy5g52zqio@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/20/2018 4:43 AM, Gerd Hoffmann wrote:
> There have been fixes for that one, specifically recent qemu will look
> at modifier state in addition to the keysym when looking up the keycode=
,
> because some keymaps can generate the same keysym with different key
> combinations, and most of the time they have different modifier state.

Yea, I saw that code, so the new version probably works if I could
figure out how to get the package to build.  I'm not sure why Ubuntu is
on such an old version.  I just cloned the debain git repo to start
poking around and assumed that was what was in Ubuntu.



--lJ3qIoH6UTUKHY8WhJuzKSiftyhvsjLU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbes7nAAoJENsuw7lhAP6EUcsH+wTtAZF7HoqalBb6VrfL3Kzh
2+gcb3dO6YwuNdlGsY8jag0WOvcQVJlFFX1u/lu7vTnqhmXMV3veEaYWp4oit1EF
uSpubeD8f03w8oR1u9ZGMAdhBg8zuiH5M7VZav4gsGBIf/N9MBHik61sOO9kHw0N
YZvhj5IMhuZV5j3q1yBCemKc5T6e/vBgqzfeY4qIPKfhbyGuFoZda1VAFX1LSwnu
5A3WE74hQlLpyEMp4frzqHyWIMhtWZiCDnrdcc0QrYP5knNontiSF383Kg6iJddD
Db2bdFqk4qXY9niLiu+oYzPQitkL2MOoR+5Y8y5V9f/dAZwkLOljOEamy4+N3gE=
=MJlw
-----END PGP SIGNATURE-----

--lJ3qIoH6UTUKHY8WhJuzKSiftyhvsjLU3--
