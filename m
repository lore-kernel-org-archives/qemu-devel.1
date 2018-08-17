Received: from eggs.gnu.org ([2001:4830:134:3::10]:34463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqfrc-0002MD-AE
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqfrW-0003Ye-Vr
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:36:31 -0400
Received: from ec2-34-202-238-73.compute-1.amazonaws.com
	([34.202.238.73]:47252 helo=vps.thesusis.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <psusi@ubuntu.com>) id 1fqfrO-0003WC-Ma
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:36:21 -0400
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180816172722.GK23515@redhat.com>
	<83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
	<20180817085656.GA11124@redhat.com>
	<a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
	<20180817125808.GO11124@redhat.com>
	<b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
	<20180817131226.GP11124@redhat.com>
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <e88687b0-f116-e6eb-0432-12e38ecece2f@ubuntu.com>
Date: Fri, 17 Aug 2018 10:36:14 -0400
MIME-Version: 1.0
In-Reply-To: <20180817131226.GP11124@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NMOW9duxfRTBlrjnFUHVzG1HY7R17G6S8"
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
--NMOW9duxfRTBlrjnFUHVzG1HY7R17G6S8
From: Phillip Susi <psusi@ubuntu.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <e88687b0-f116-e6eb-0432-12e38ecece2f@ubuntu.com>
Subject: Re: Pipe key broken on US keyboards
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
 <20180816172722.GK23515@redhat.com>
 <83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
 <20180817085656.GA11124@redhat.com>
 <a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
 <20180817125808.GO11124@redhat.com>
 <b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
 <20180817131226.GP11124@redhat.com>
In-Reply-To: <20180817131226.GP11124@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I've been reading up here:
http://www.win.tue.nl/~aeb/linux/kbd/scancodes-1.html

And man, what a mess keyboards are!  Worse than floppy controllers.
According to that site, the scan code for \ should be 0x2b, so why does
xev say the keycode is 51?  Is keycode something else entirely from scan
codes and keysyms?  If so how can I see the scan code?

On 8/17/2018 9:12 AM, Daniel P. Berrang=C3=A9 wrote:
> It depends on what the VNC client asks for too. With no '-k' arg, if th=
e
> VNC client asks for raw scancodes it'll get that, otherwise QEMU will
> fallback to en-US.    GTK-VNC based clients (remote-viewer, virt-viewer=
,
> vinagre, virt-manager, GNOME boxes) use the raw scancodes. Most other
> clients do not.
>=20
>=20
> Regards,
> Daniel
>=20


--NMOW9duxfRTBlrjnFUHVzG1HY7R17G6S8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbdt1fAAoJENsuw7lhAP6EhSMH/2Hs5Lg0OxC8m+pRZjOwI6Pl
uS7NuFObZCCecarF6QP0blEaT/Yu4OyeGlE2F7X6w/6Fda0BmUeDi0KJu+QQSY3Q
9KB0yLz4vJ2ZCrMERTfvviqRDrgi1G8k2F9v0UUbJTMWWEig9nTvhN1tdEbcYeRx
Y5yIT3f9Y54wOj5L1om+7xNk/OVy5Ajdq/W9A7EDlxciMWTQrYZODAp217kr+/Ne
WqTnYgR0D4rq+NGPQvPqcbrCQ1ltvvOd8mXxVC+xXkZEiIKu0EdG9B48fkrgQuXH
nQzU638b1DvdzwUpuaMHqKELflx0s/Op7D5gNAfB6R3h/nGG9sm2Lctewfy7w9s=
=Z/xp
-----END PGP SIGNATURE-----

--NMOW9duxfRTBlrjnFUHVzG1HY7R17G6S8--
