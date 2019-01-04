Received: from eggs.gnu.org ([208.118.235.92]:49999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gfHwb-0002m6-Jd
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gfHwa-000304-Oa
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:22:53 -0500
Date: Fri, 4 Jan 2019 16:17:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190104051729.GD2801@umbus.fritz.box>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<16d6e1b4987d30c11ace0211e9d6a57303784467.1546394798.git.balaton@eik.bme.hu>
	<20190102041507.GN27457@umbus.fritz.box>
	<alpine.BSF.2.21.9999.1901031501030.39019@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1901031501030.39019@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 4/8] ppc4xx: Use ram_addr_t in
 ppc4xx_sdram_adjust()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 03:03:20PM +0100, BALATON Zoltan wrote:
> On Wed, 2 Jan 2019, David Gibson wrote:
> > On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
> > > To avoid overflow if larger values are added later use ram_addr_t for
> > > the sdram_bank_sizes parameter to match ram_size to which it is
> > > compared.
> >=20
> > So, technically I think these should be 'hwaddr' (which represents a
> > guest physical address) rather tham ram_addr_t which
> > represents... something subtley different I've never properly
> > understood.
>=20
> I don't understand the difference either but ram_size in MachineState whe=
re
> this value comes from is ram_addr_t now so I've left is for now. If someo=
ne
> knows which type should this be can change it in another patch
> later.

Ok, fair enough.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwu7GkACgkQbDjKyiDZ
s5KhnBAAt7uqP3ue/dBM5AIBG99Sxq6dejYYZHzLamdKGfnQ5xbTPpULDsI5oHLT
k6u8lDAJN6p3zu9QrmAvDr3RWqIDXFYEMadkxrS+umD7h7UzfqJSxtxanpEsRLxw
cDCGiK3rGt15MJEYZ1on5LPKKlYGWN7tB3WxxCMUW5rcdDzd+ep9YOE8SOxug5+y
Y0kurKy4z3a0oWfd+jvJQ3GJMMqyTliNGzWpqTqv/y0RxSHFmwrUPnsispl5COB5
1VGDPGg5BRoDb7N8kPimTnprsDbbwrcFuewwxFnyBoSmgkYRSpV3FmgSBdyX7C4F
BZEl0Tn8zu8BFTwCRcABQ6Xt4AKD9D9vpQR5VdAUhNKLtnaRdtOilmw8RuBpw12i
jXURrKjny70Ys4G9vmhM6c/E+lTVowjlTDPXQdYbDkdlNOGBbALvhGgQ3lRoTnbS
NDgVdUiu6+DCNeDl0oYf/R712WujPgh96410RaF8JKFHJvK2KOMubP6gdBKua6E+
UGsPurl8w/OhJOJF4esuQaBU4ONaNSCfubk7HmCRzTsyBYtJvMI64MC/x+uZDiJz
3sqbGqNFfSlEmKX8LokhK+LZAT7AFWHOpUlVlkWPk8QYc9+Fny7szmranCGCMocw
MJJ5+piBfs58Wmzne7NpjRXJuBjpdFTZmH/tOdbg37bOtF6q9is=
=QVVl
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
