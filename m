Received: from eggs.gnu.org ([209.51.188.92]:60033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghg5I-00056t-PZ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghg5H-0005C4-2d
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:33:44 -0500
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<8736q3ebs2.fsf@dusky.pond.sub.org>
	<d0736347-867d-49f5-5615-dfe5f9b82412@janustech.com>
	<1551373d-91fa-1345-1757-7299b073d157@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d3ebe4db-cb42-91ce-f624-240c9a1416d3@redhat.com>
Date: Thu, 10 Jan 2019 13:33:35 -0600
MIME-Version: 1.0
In-Reply-To: <1551373d-91fa-1345-1757-7299b073d157@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YazUYI3xIH6htFtOTt32trDXCb8vUMY5J"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YazUYI3xIH6htFtOTt32trDXCb8vUMY5J
From: Eric Blake <eblake@redhat.com>
To: Leonid Bloch <lbloch@janustech.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <d3ebe4db-cb42-91ce-f624-240c9a1416d3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
References: <20190103213320.2653-1-lbloch@janustech.com>
 <20190103213320.2653-2-lbloch@janustech.com>
 <8736q3ebs2.fsf@dusky.pond.sub.org>
 <d0736347-867d-49f5-5615-dfe5f9b82412@janustech.com>
 <1551373d-91fa-1345-1757-7299b073d157@redhat.com>
In-Reply-To: <1551373d-91fa-1345-1757-7299b073d157@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 7:33 AM, Eric Blake wrote:

>> Eric - thanks for the comment about 'local' - I will get rid of it if =
we=20
>> decide to include this patch.
>=20
> I'm still not convinced we need it.  I would much rather see a patch
> that makes QemuOpt accept default integer values as integers rather tha=
n
> as strings, so we don't have to worry about stringifying special macros=
=2E

So I took a quick look at QemuOpts, and it turned out to be easier than
I feared; hence:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02041.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YazUYI3xIH6htFtOTt32trDXCb8vUMY5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw3ng8ACgkQp6FrSiUn
Q2qK4gf8D24M4nFPISEuJ9plWKhLh9PmIwcYG7H5fp9VGDYnjDdzJ82l8/XYuBma
yzX1jL8U4/j3FrObfV9Frxy2c1xCKpMFotYUx08LSIeIsHfoi3IZYwCXfstQqBBl
d8lF2D4/A1U4hj4GE25xodjwWcCkKxWhWKMX3CdW2Z0KxdDLxpqL8JnKO1lhCdd/
BhVCrizUYcZy2pdm/VFLMWYdUpzp7SG3Nt8x/3AWlaCZykXVdM4LWOGHQNfDKbIr
pD4NEO8a+ZyLdoxC+8HmrtIw/9zh2OQGlAZLm7LrquaV5F9XE5AoPQn6Y/t+fjLw
p+y6l20/qBbaR4obEof4N4j5PICL1w==
=kzzO
-----END PGP SIGNATURE-----

--YazUYI3xIH6htFtOTt32trDXCb8vUMY5J--
