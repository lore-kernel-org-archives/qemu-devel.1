Received: from eggs.gnu.org ([2001:4830:134:3::10]:51465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqgUR-0000ZF-FP
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqgUN-000334-CA
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:16:39 -0400
Received: from ec2-34-202-238-73.compute-1.amazonaws.com
	([34.202.238.73]:47314 helo=vps.thesusis.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <psusi@ubuntu.com>) id 1fqgUN-00032W-6A
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:16:35 -0400
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180817150513.GT11124@redhat.com>
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <6bf952d9-0269-c5df-6cac-70104ec88f81@ubuntu.com>
Date: Fri, 17 Aug 2018 11:16:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180817150513.GT11124@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kyGXzowCsyDcHJx17ZrmomxwrJWo1DB2h"
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
--kyGXzowCsyDcHJx17ZrmomxwrJWo1DB2h
From: Phillip Susi <psusi@ubuntu.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <6bf952d9-0269-c5df-6cac-70104ec88f81@ubuntu.com>
Subject: Re: Pipe key broken on US keyboards
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
 <20180817150513.GT11124@redhat.com>
In-Reply-To: <20180817150513.GT11124@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/17/2018 11:05 AM, Daniel P. Berrang=C3=A9 wrote:
> Reading again, this is a bit odd. On most keyboards, holding down shift=

> key generally would NOT change the scan code that is reported (there ar=
e a

Right; a real keyboard won't change the scan code, but it seems that
European keyboards have this extra key that can also produce a |, so
when qemu gets the key code for |, it has to pick one scan code or the
other to translate the | into, and it picks the wrong one.

Looking at the code it looks like qemu has its own qcode set and
translates between that and all of these other sets.  I'm guessing
either input-keymap-linux-to-qcode.c or input-keymap-x11-to-qcode.c is
where the error is, but these do not exist so I guess they must be auto
generated somehow by the build process?

Actually, which one of those code sets is vnc using?


--kyGXzowCsyDcHJx17ZrmomxwrJWo1DB2h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbdubRAAoJENsuw7lhAP6Ev+MH/00IOg1UsayCdOvKemVC0XtP
0LknXi6O2JDCCcRGEI9enF8Zo7rXs6ccGoEJ5fhxLsulyJ2IRwdRNc8fJPb33iHp
DxzvuAE6AbS+5PHVgVTbM3SaTdOv1NAw68j6bD3p5dNQlcUC8N3Q77xVaMz+BBrz
0nUsnsHFIZFEsLOw121++RhWgzisGLScfnqiQg4HoyNYWI8tRiVNXGVMZQUPqnOX
pmodT2aTkGO21iPEdww8MmnRilFdVgIi+LPKIpZnhuH7Ij7oeW++4DoPADQ2uOws
hzPMbG+5kShiPS3IsoMR+OFNSzdwy5NI18xWcHcNBhkXr5mG2GdwX6kGny5JQy0=
=Yjpx
-----END PGP SIGNATURE-----

--kyGXzowCsyDcHJx17ZrmomxwrJWo1DB2h--
