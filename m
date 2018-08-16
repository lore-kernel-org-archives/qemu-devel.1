Received: from eggs.gnu.org ([2001:4830:134:3::10]:49293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqOCh-0002n7-Fu
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqOCc-0002pH-3s
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:45:07 -0400
Received: from ec2-34-202-238-73.compute-1.amazonaws.com
	([34.202.238.73]:46742 helo=vps.thesusis.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <psusi@ubuntu.com>) id 1fqOCb-0002od-Uj
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:45:02 -0400
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180816172722.GK23515@redhat.com>
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
Date: Thu, 16 Aug 2018 15:44:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180816172722.GK23515@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RusTNGyHcagxKENa1Z5Ewq5wWByIIybGV"
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
--RusTNGyHcagxKENa1Z5Ewq5wWByIIybGV
From: Phillip Susi <psusi@ubuntu.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
Subject: Re: Pipe key broken on US keyboards
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
 <20180816172722.GK23515@redhat.com>
In-Reply-To: <20180816172722.GK23515@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/16/2018 1:27 PM, Daniel P. Berrang=C3=A9 wrote:
> Did you actually 'git bisect' to that commit, or is that just a guess ?=


No, I haven't actually tried to build it from sources myself yet so I
just found the source file that handles the keyboard, saw a bunch of
scancode translation stuff in it, did a git log on that file and that
first commit sticks out like a sore thumb; it changes the way scancodes
are translated in a big way and the timing of it seems about right.  The
other commits talk about fixing specific key codes that are unrelated to
pipe, and it looks like this commit threw out the code those commits
touched anyhow and refactored the whole thing.

> If not, could you 'git bisect' to confirm the actual commit, as there
> have been lots of changes in this area.

I'll try.



--RusTNGyHcagxKENa1Z5Ewq5wWByIIybGV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbddQ7AAoJENsuw7lhAP6E76AIAK3OtZXdcp5gtjlPC0OkmKkh
+1kNmcbaxcOqezlDfPIwKLJgERG6BIZagT9DiEDtA+WoQUJKBRIZMfLNWJnKPoVb
5dADrkw8u1WTJBuTQ3zgMEvAn2WjJ2hyagL6eO3fHe08FWEIl+h/u/Oc/Qv4I3y/
T2cNpPvFP5So3EwZ58OS/Z9YFk7E+gm18RLjB40j4qaExeXs3uagJzqNJS07KyUn
dPeQ6RStobojuOUmi3DXs9Mng9UahGfQ+R+tvjDq/tHIZk8t4N1fyIHyj98gBrly
S+dlL/jYJbxzEpZxpP27qNOPyAG76w8uDjRM/h4bw1jFhxjc9ybzxcoNmeshm5o=
=ktYZ
-----END PGP SIGNATURE-----

--RusTNGyHcagxKENa1Z5Ewq5wWByIIybGV--
