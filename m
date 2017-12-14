Received: from eggs.gnu.org ([2001:4830:134:3::10]:58130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePJ8k-0005GN-E8
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePJ8f-0006ei-P4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:20:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePJ8f-0006eP-G7
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:20:45 -0500
References: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
	<20171212143421.GD26971@redhat.com>
	<11216FAC-3F62-43AF-ACD8-00F28B7AD886@gmail.com>
	<20171213091458.GA28379@redhat.com>
	<7D487247-C5DA-4902-A21E-B16861F763C8@gmail.com>
	<alpine.BSF.2.21.1712131914560.26243@zero.eik.bme.hu>
	<99BD2069-929C-402A-B38A-778DAB427449@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9dae1cb6-0ed1-ca51-42c7-e8d0bddf10d3@redhat.com>
Date: Wed, 13 Dec 2017 20:20:43 -0600
MIME-Version: 1.0
In-Reply-To: <99BD2069-929C-402A-B38A-778DAB427449@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B4Jlr5O4usd8807O1wEoB7qBMMDRGRRxW"
Subject: Re: [Qemu-devel] Adding more function keys support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B4Jlr5O4usd8807O1wEoB7qBMMDRGRRxW
From: Eric Blake <eblake@redhat.com>
To: Programmingkid <programmingkidx@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <9dae1cb6-0ed1-ca51-42c7-e8d0bddf10d3@redhat.com>
Subject: Re: [Qemu-devel] Adding more function keys support
References: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
 <20171212143421.GD26971@redhat.com>
 <11216FAC-3F62-43AF-ACD8-00F28B7AD886@gmail.com>
 <20171213091458.GA28379@redhat.com>
 <7D487247-C5DA-4902-A21E-B16861F763C8@gmail.com>
 <alpine.BSF.2.21.1712131914560.26243@zero.eik.bme.hu>
 <99BD2069-929C-402A-B38A-778DAB427449@gmail.com>
In-Reply-To: <99BD2069-929C-402A-B38A-778DAB427449@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/13/2017 01:18 PM, Programmingkid wrote:

> Thank you BALATON for the file. One thing that caught my eye in this fi=
le is this:
>=20

> 	if (usage->code =3D=3D KEY_FN) {
> 		asc->fn_on =3D !!value;
>=20
> Why would they need the double !?=20

Double '!!' is an idiomatic way to force a value to be converted to bool
(squashing all non-zero values into 1).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--B4Jlr5O4usd8807O1wEoB7qBMMDRGRRxW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlox3/sACgkQp6FrSiUn
Q2rakAf+OvZTZ31TqHTi9MZoLFBtxoKpWT2Us+tqDy1JFF8X8PYvWJoZwrzOxbGi
azZqDxVUpvur/Wh0oMFW8HhDLxom+u6FSga8QgBjRL3cxBsJJwgBsMquEH30Xh72
2oouk1cp36XdYnZJ1VnSou97CScfJseubX2e4VjLM2ysZIvXudsXdg/Ksa/nP+RO
7hWQOIL/qn9BUcZOIe43DY0kvzXkSe0Ox85C+5x6aJRYFSsUMbzwJYzpLcwSnZeY
9IjdRYjbRUjZ0yAYd2qxv9aUx4Dcc+9sJ3El8TzxIWCFCty/gYpvITAdX2FBPCrA
QCbJG+z0IG29iYbLVeEqB+HqHs5DCw==
=u/8+
-----END PGP SIGNATURE-----

--B4Jlr5O4usd8807O1wEoB7qBMMDRGRRxW--
