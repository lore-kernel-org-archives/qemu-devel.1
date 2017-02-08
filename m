Received: from eggs.gnu.org ([2001:4830:134:3::10]:54391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbFti-0005RQ-Sr
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:14:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbFth-0008La-Qq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:14:10 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-9-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a2eae5c1-7267-fb4b-747f-4c9bbd1d16d0@redhat.com>
Date: Wed, 8 Feb 2017 01:14:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-9-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="68fwfvAhnNVuNm0DaVpP3EW5gAGAqaoXD"
Subject: Re: [Qemu-devel] [PATCH v12 08/16] iotests: 087: Don't attach test
 image twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--68fwfvAhnNVuNm0DaVpP3EW5gAGAqaoXD
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <a2eae5c1-7267-fb4b-747f-4c9bbd1d16d0@redhat.com>
Subject: Re: [PATCH v12 08/16] iotests: 087: Don't attach test image twice
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-9-famz@redhat.com>
In-Reply-To: <20170123123056.30383-9-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> The test scenario doesn't require the same image, instead it focuses on=

> the duplicated node-name, so use null-co to avoid locking conflict.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/087 | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--68fwfvAhnNVuNm0DaVpP3EW5gAGAqaoXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliaYsgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyBQH/2+mvdIrIORuYSTTyRPloLvcw0/8qUIr
e8NRRWrLqDyJ2g9+HcKACfasZ8lI0Zw498YSaRTWcYDPVIRLLw9BAVxpUPJseBtm
/13mgVWR1HGy0rfupzcLon18e/T9KSerJTnYxepChc6k5W9EyieznBI0VNzZQeZf
b7xv9C5Lz4o3S4O3jTYaPvnGEdPgtVGomxZLSqnSFJH0JMC5gyt4bxJxfe9DuqTD
ZinCqjYeFOX03rUyAmOcu2lYogPuPfybqdR3xvIHCdU0LDaMWh9ZCRaLKLejW9Qq
L29vKGZR8ewDuBD/aTajbewZWZP0mDJBODL6+nZMr+mr12A4oAlFm6s=
=2yJr
-----END PGP SIGNATURE-----

--68fwfvAhnNVuNm0DaVpP3EW5gAGAqaoXD--
