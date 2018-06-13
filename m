Received: from eggs.gnu.org ([2001:4830:134:3::10]:36965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT29P-0007Fa-Ht
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT29O-0006tb-GO
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:33:11 -0400
Date: Wed, 13 Jun 2018 19:21:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613092111.GC30690@umbus.fritz.box>
References: <20180613083015.15749-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KtWcatouGV9Nk9BU"
Content-Disposition: inline
In-Reply-To: <20180613083015.15749-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/3] mos6522: allow IRQs from external port
 pins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com


--KtWcatouGV9Nk9BU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 09:30:12AM +0100, Mark Cave-Ayland wrote:
> Whilst testing a conversion of Laurent's q800 patchset over to use mos6522
> I discovered some issues which prevented IRQs being generated from inputs=
 to
> external port pins.
>=20
> This is a requirement for the q800 patchset which uses external clocks to
> generate periodic interrupts.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

>=20
>=20
> Mark Cave-Ayland (3):
>   mos6522: only clear the shift register interrupt upon write
>   mos6522: remove additional interrupt flag filter from
>     mos6522_update_irq()
>   mos6522: expose mos6522_update_irq() through MOS6522DeviceClass
>=20
>  hw/misc/mos6522.c         | 5 +++--
>  include/hw/misc/mos6522.h | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KtWcatouGV9Nk9BU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg4gcACgkQbDjKyiDZ
s5JAYBAAqTA937cET8yTaI3fad/oPmS5hiBnuKEeDSsu0gxRcLnF6yZ9e4uFWE4D
ADz8oItSlWn+WOMqNxarnpefKzTKqdOdnYsjyAUQ7dv8X4CnMKmMiy+akfwQWHDY
bqS8snwsOPzwtfrqgWem7t5iDU2+0v+L2zmHxUfx88F6BF3OfF769C5G9hWYyLJr
n0ZLX1otl1P+7qUHVnXTRfORDQUcsaWNK4sFa1tYD6cWNkFDOi4gm3eKt7jcY3CH
6SETaNnldVBacPjdCvP4yCdvCw1weqN3diBvH5Kcmj24lotd/s2QLn4WJThJfQqB
ybCEL7cBur/oPlCMsg+FyrAUkQsCzdGnGoR36dfK+8wEWW79MCIbrHzhuqov02Kz
AN2SFSDuvdmuv/es+ahj9sTRmY206k3mz+KJNFCuDp4vNxZ9fRiLki93CAIZdUkq
sxiFOV0yPncpHauh+NGmTmqbWijGg97ba0LUe3CapNN8PhYQJl5bv7qUyloEAYbL
5cZxvfRdsPkBmnmMWycbtbJ+fHz0g5BBbNd2yHFA3/qz7ajLhQVC07mnT7m+efCJ
utaeNroQjsGSHxVF1/0d750A396Ptv+q1OUUUivCLKOlmMlqNKUsnJ8g8dwrREin
nlsSMFGiTrcs6YCoLmmONX70aj+VI8mTwv3YPoiu53frLZTOwYQ=
=zulO
-----END PGP SIGNATURE-----

--KtWcatouGV9Nk9BU--
