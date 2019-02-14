Received: from eggs.gnu.org ([209.51.188.92]:48129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu6tS-0003sC-S6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu6tE-0002BN-MC
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:36:45 -0500
References: <20181203175211.8230-1-mreitz@redhat.com>
	<20181203175211.8230-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1bd3814-7eb9-1548-a084-d248fa3a1df3@redhat.com>
Date: Wed, 13 Feb 2019 20:36:27 -0600
MIME-Version: 1.0
In-Reply-To: <20181203175211.8230-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l7Eox42uVMXJXgWOIwpLI7Ie9lERPOQtb"
Subject: Re: [Qemu-devel] [PATCH for-next 4/6] blkdebug: Add "none" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l7Eox42uVMXJXgWOIwpLI7Ie9lERPOQtb
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <c1bd3814-7eb9-1548-a084-d248fa3a1df3@redhat.com>
Subject: Re: [PATCH for-next 4/6] blkdebug: Add "none" event
References: <20181203175211.8230-1-mreitz@redhat.com>
 <20181203175211.8230-5-mreitz@redhat.com>
In-Reply-To: <20181203175211.8230-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/3/18 11:52 AM, Max Reitz wrote:
> Together with @iotypes and @sector, this can be used to trap e.g. the
> first read or write access to a certain sector without having to know
> what happens internally in the block layer, i.e. which "real" events
> happen right before such an access.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 4 +++-
>  block/blkdebug.c     | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--l7Eox42uVMXJXgWOIwpLI7Ie9lERPOQtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxk1CsACgkQp6FrSiUn
Q2owMQf+PHmJTkRneMcEdZcKaEUc3ENdUA35JDH4lBboC+yZmnKzy8gm8AWUEcQs
bZHV3kwsj3hXN6UaXex09BSpMLETwcUTP1WHzJpc7SEahz4VPO2MXzZ1dfGrL0fW
C68F4kefNQWq94gdBXFKDVuyTtoGcg0ODjcRq8onL8z+0oofpry9rLbu9JnjyOSZ
3Sj9mPC4v3oIlEXm+0vy3K9N9q+im3Oko/UdAtuCxoliKJUwtumygx4WX4iTfoOU
4ykZDgDYEC/TILofI+40wYOFEl8g6vBMxmc7t0YMAEhFOmd0rCAI/VMKwffarCvD
k433McJFPiuZQk6aKstxO29eTvgiKw==
=1Jkt
-----END PGP SIGNATURE-----

--l7Eox42uVMXJXgWOIwpLI7Ie9lERPOQtb--
