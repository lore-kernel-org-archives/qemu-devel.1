Received: from eggs.gnu.org ([2001:4830:134:3::10]:36627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db4sy-0006aY-5M
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db4sx-0001R1-7K
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:00:56 -0400
References: <20170728123127.27921-1-olaf@aepfle.de>
	<d8aca223-4007-6524-9876-fe32fd81e893@redhat.com>
	<20170728124832.GP8603@aepfle.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4264ad8d-d988-463d-728f-20ac77db39e9@redhat.com>
Date: Fri, 28 Jul 2017 08:00:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170728124832.GP8603@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xn9OfCA4IJhfCIfeIwwuG1lWmaOAihgQ4"
Subject: Re: [Qemu-devel] [PATCH] xen-disk: use g_malloc0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xn9OfCA4IJhfCIfeIwwuG1lWmaOAihgQ4
From: Eric Blake <eblake@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "open list:X86"
 <xen-devel@lists.xenproject.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Message-ID: <4264ad8d-d988-463d-728f-20ac77db39e9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] xen-disk: use g_malloc0 to fix build
References: <20170728123127.27921-1-olaf@aepfle.de>
 <d8aca223-4007-6524-9876-fe32fd81e893@redhat.com>
 <20170728124832.GP8603@aepfle.de>
In-Reply-To: <20170728124832.GP8603@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 07:48 AM, Olaf Hering wrote:
> On Fri, Jul 28, Eric Blake wrote:
>=20
>> This version is prone to multiplication overflow (well, maybe not, but=

>> you have to audit for that).  Wouldn't it be better to use:
>=20
> What could go wrong?
> qemu will die either way, I think.

Dying immediately due to provable multiplication overflow is MUCH better
than successfully allocating too-little and then having who-knows-what
go wrong down the road because you didn't check for overflow.  The
latter can sometimes be exploited into CVEs.  And maybe you can't
overflow, but having to do a non-local audit to prove that is more time
spent than just using the right interface from the get-go.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xn9OfCA4IJhfCIfeIwwuG1lWmaOAihgQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7NXwACgkQp6FrSiUn
Q2pHfAf/Y8uL8EhzLZHNqrT1SzBI6n+PPGACDZWHbgQbWE8uL7aFAe6UJKhaRyFO
nLWd86K+sHrgOQlLlrbplGYzSZRZYlUMKbTiZhaAojiM4rUnctGcmh54by3wMAAA
0sktP9DhaTQAwSyQ3WpzMNaW8d6ka0IiadJ6ibv+ez99IVWTmAGE3qRo+bPQja73
9ZUB4/DdVKMYlyMbbU2e5AG5siolM3Ejs4XVYTIIGbc5mwV2uLRtM6cv1zj6LoBY
D8h/gFGtufcYxXz+8SIMJa9jnv+Hii1dHHnHI5sKtgxr304Rypiwg4B5Qp8OrXCH
pqPN4eISdyl9O+C7Mg43Dkh48FdOhw==
=8BNK
-----END PGP SIGNATURE-----

--xn9OfCA4IJhfCIfeIwwuG1lWmaOAihgQ4--
