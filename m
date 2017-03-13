Received: from eggs.gnu.org ([2001:4830:134:3::10]:49156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnY0i-0002dc-Im
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnY0h-0004hp-TJ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:00:12 -0400
References: <20170308025428.1037-1-eblake@redhat.com>
	<20170308025428.1037-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f4cbc108-a91f-6d52-b46e-3c1332199779@redhat.com>
Date: Mon, 13 Mar 2017 23:00:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170308025428.1037-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qPKNqhU0jtbA8mkoodA1xd16xOkleh22Q"
Subject: Re: [Qemu-devel] [PATCH v6 02/10] iotests: Improve image-clear
 tests on non-aligned image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qPKNqhU0jtbA8mkoodA1xd16xOkleh22Q
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <f4cbc108-a91f-6d52-b46e-3c1332199779@redhat.com>
Subject: Re: [PATCH v6 02/10] iotests: Improve image-clear tests on
 non-aligned image
References: <20170308025428.1037-1-eblake@redhat.com>
 <20170308025428.1037-3-eblake@redhat.com>
In-Reply-To: <20170308025428.1037-3-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 08.03.2017 03:54, Eric Blake wrote:
> Tweak 097 and 176 to operate on an image that is not cluster-aligned,
> to give further coverage of clearing out an entire image.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v6: new patch
> ---
>  tests/qemu-iotests/097     |  7 ++++---
>  tests/qemu-iotests/097.out | 24 ++++++++++++------------
>  tests/qemu-iotests/176     |  7 ++++---
>  tests/qemu-iotests/176.out | 24 ++++++++++++------------
>  4 files changed, 32 insertions(+), 30 deletions(-)

I don't have anything against this patch, but maybe it would be even
more useful if it wrote some data to the final partial cluster (just an
idea).

Reviewed-by: Max Reitz <mreitz@redhat.com>


--qPKNqhU0jtbA8mkoodA1xd16xOkleh22Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljHFmMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyF0H/1mHDvRmxmlNwcTX9Np+hkCJggYsiwUX
ZPpM3EEG0P5ABElLtMBnAz3LWGRed/nMXtZ3XnLRvxVZWdFwpli5FRMw8IY3bZjp
aDbegOTdwyL6RF/6M2VMWpu0Gm7D2J3Uru5vhZ1JgCfdl13Pltx3KKkm1TyDDmfX
woDQGFJuVNO3zsdCf9eks24uLZPAVNy8lg24aKcavlNZD7AAh9fgKljhfP1Kx/In
D4cB5438mG/qDNE8TJMMrMwOn/f7J2i18Z7sBD58vXosJxnRVqaegdIGX8y6GAag
h9zeWLP49T6ZVFlaSTmnKvKA41mK8Bd9HTFurVxrpfDKfkOV1p2AzME=
=Js3r
-----END PGP SIGNATURE-----

--qPKNqhU0jtbA8mkoodA1xd16xOkleh22Q--
