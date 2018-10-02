Received: from eggs.gnu.org ([2001:4830:134:3::10]:51587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7BU3-00042W-2D
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 23:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7BU1-0005VD-M4
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 23:36:26 -0400
Date: Tue, 2 Oct 2018 11:19:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181002011940.GA1886@umbus.fritz.box>
References: <20181001114421.1377-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20181001114421.1377-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] ppc: convert SysBus init method to a
 realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 01:44:19PM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here are a couple of patches converting the SysBus init method to a
> realize method. make check tested only.

Applied to ppc-for-3.1, thanks.

>=20
> Thanks,
>=20
> C.
>=20
>=20
> C=E9dric Le Goater (2):
>   ppc440_pcix: convert SysBus init method to a realize method
>   ppc4xx_pci: convert SysBus init method to a realize method
>=20
>  hw/ppc/ppc440_pcix.c | 14 ++++++--------
>  hw/ppc/ppc4xx_pci.c  | 14 ++++++--------
>  2 files changed, 12 insertions(+), 16 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluyx6oACgkQbDjKyiDZ
s5L+kw/9HR1QjkMYU95NJS4BCpYaTGIDO0LBYtsTo8yoWj+IW1rJyKe34nh40Nd6
LqTbI3FYYDPTxVmpb64CnBtsXJ3WCr+Nup+ldNim+pvGAcZwgvuvrvDFjpbUdtAo
QtqOP9EBGczdgtygRWJfimL+XsaLwqHo8JUasuEwqxDoud4wQjp8o4rTVvasW9XJ
0mv2dqQXsK7TJgq5kIHe+C6XrVTiYInyhMeup4IeZojhCB7BLLXaY6/v2P0rcgSs
77L3fcTr1KVLnxfRQ0NF+go7Sn0g4s8OszRC9sP8/Q/XD6oy67Zd46DFNu/Mb51c
oHAoxH4/0lDp5+j0sfkz+VpbwBESBRCKmzeWLgRU3HMM0O65T6pffFCZbGM9MmIQ
AT8CIjckIk+s65gvcuEK2oTHlEBqQtT5W7O3ZNjYM14BiU6kKTS/KPw0WK+wwUO8
ZF2cUJlz5RuG0ytaTbeRaFZIwbqAkR4AR++b1DTAw9wi43WJd0CiBKBT4ptuP+lA
hzJpclpibzxE2hQGJgNdZV9PzAI3oR974tb+IgUgVgn/l7FTX7Hhxatioq+/wrSD
V27M+ooEdlgPP8XyRuS8s5jEQxD59gTRmDva4DsQdwokW1jLe/HtYaMJWneeiols
+b82VW5jV2KpRp9VAl3bv7dgiFjGt6HLmHWBKPFfTxy0z5kHrrQ=
=Tbeo
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
