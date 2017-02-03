Received: from eggs.gnu.org ([2001:4830:134:3::10]:59281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ct@flyingcircus.io>) id 1cZZ8W-0005fa-GZ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ct@flyingcircus.io>) id 1cZZ8T-0004Ec-C3
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:22:28 -0500
From: Christian Theune <ct@flyingcircus.io>
Message-Id: <2BB6EFE6-C476-4A48-AFC9-52B9B9F8433F@flyingcircus.io>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_A7C72EFD-BE92-478A-A329-763C6955F7B6";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Fri, 3 Feb 2017 09:22:22 +0100
In-Reply-To: <03b2194a-ea37-c025-53c2-53b030b593f6@kamp.de>
References: <1485876994-14555-1-git-send-email-pl@kamp.de>
	<ea032a8a-1429-bd95-5b68-4634a0fb0a57@redhat.com>
	<03b2194a-ea37-c025-53c2-53b030b593f6@kamp.de>
Subject: Re: [Qemu-devel] [PATCH] qga: ignore EBUSY when freezing a
 filesystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, mdroth@linux.vnet.ibm.com


--Apple-Mail=_A7C72EFD-BE92-478A-A329-763C6955F7B6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

> On 3 Feb 2017, at 09:20, Peter Lieven <pl@kamp.de> wrote:
>=20
> If you try to THAW an unfrozen FS you get EINVAL.
>=20
> The current code thaws until an error is returned.
>=20
>=20
> So it should work as is.
>=20
>=20
> If you feel uncomfortable with the EBUSY approach. The other idea =
would
>=20
> be to track all devices which have been successfully frozen and skip =
consecutive
>=20
> tries to freeze them.

Which will be subject to race conditions as other processes may call =
freeze/thaw on any device. Those are completely out of our control.

Christian

--
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 http://flyingcircus.io
Forsterstra=C3=9Fe 29 =C2=B7 06112 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian. =
Theune, Christian. Zagrodnick


--Apple-Mail=_A7C72EFD-BE92-478A-A329-763C6955F7B6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJYlD2+AAoJEKuh8lKpfGLOP9kIANxNT+d6acKCC2/HYah+W8E3
h8LKy4uZKcip1EZejfE72hZFdl6/p0fn+I4fTSCDiOoHlQ+Lv2sDp6T25kIZn1ZA
gEYh+4YDfBaBOnRT8a99YPGvkS6p8H+U5RYSqw+c64xFBg5YeW1Dq1w3cmqV111x
s0w/qnCqDLBXRD1+jqhvUCDG3Y91QtHTLIFSk5pPxqKluCZe4aaFVr7fYuNlGyiP
PxNN0uYPoPRCgOzRThXnRLz5pIHnwlBymaV8Lu1knGSCfpBWkfhQd1A2FqsI749z
tMuhy1QWSxu95BcacApXNQfxU0/J17JGJgd8tyEHfgDkMKli8ocw0Wkz+1kEy1c=
=E4Ks
-----END PGP SIGNATURE-----

--Apple-Mail=_A7C72EFD-BE92-478A-A329-763C6955F7B6--
