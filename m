Received: from eggs.gnu.org ([2001:4830:134:3::10]:53097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqeWx-00028s-Po
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqeWq-0000xx-9g
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:11:05 -0400
Received: from ec2-34-202-238-73.compute-1.amazonaws.com
	([34.202.238.73]:47166 helo=vps.thesusis.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <psusi@ubuntu.com>) id 1fqeWq-0000xQ-3P
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:11:00 -0400
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180816172722.GK23515@redhat.com>
	<83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
	<20180817085656.GA11124@redhat.com>
	<a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
	<20180817125808.GO11124@redhat.com>
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
Date: Fri, 17 Aug 2018 09:10:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180817125808.GO11124@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="evGgxlfFoePgrgv3BSpeAZyIcU8mxNgUw"
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
--evGgxlfFoePgrgv3BSpeAZyIcU8mxNgUw
From: Phillip Susi <psusi@ubuntu.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
Subject: Re: Pipe key broken on US keyboards
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
 <20180816172722.GK23515@redhat.com>
 <83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
 <20180817085656.GA11124@redhat.com>
 <a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
 <20180817125808.GO11124@redhat.com>
In-Reply-To: <20180817125808.GO11124@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/17/2018 8:58 AM, Daniel P. Berrang=C3=A9 wrote:
> Actually for QEMU there is no default localized keymap. This is desirab=
le
> because it allows VNC to activate its raw scancode extension which is m=
ore
> reliable than passing translated X11 key symbols.
>=20
> I guess there's a chance that Xen might secretly pass a '-k' arg anyway=
,
> but hopefully it doesn't...

It also happens when I just run qemu.  How can I check to see if it is
using raw scancodes or keycodes?




--evGgxlfFoePgrgv3BSpeAZyIcU8mxNgUw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbdslhAAoJENsuw7lhAP6E/LMH/ipmpABChrRpCR5lXNmvTMzt
QPjLF+5nuH+DB2R9KukF2J586NT61AqN5qcIggWjsMa7ZHbBrgHPDJcNxRqZjhza
gcb/c1i5rfFtvEu9J68/0r9/3A6y+ex7skBjBIR6Iv5zsmoL3Lp7G6YVK6ubcDPH
Xzw0DVGMqIuGrqRC9eYCCbJzQOCg6hBbTWmSKCDofvQcvX4RpUWi6xvxR7LKCatJ
eLUtUA+r+Oy0hokhq9HRpkH/HJX4GWgaOLCpNllSNJZx3uXHQ6r1G5YwmPeXYIEN
QszKb5PkyB3/28pBRZ1ZPlyOmSCEm6pYWVnPi6hWf0qQmikJY3xmkW03LbdT3jg=
=yU+J
-----END PGP SIGNATURE-----

--evGgxlfFoePgrgv3BSpeAZyIcU8mxNgUw--
