Received: from eggs.gnu.org ([209.51.188.92]:38191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqqm0-0002K0-Om
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 21:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqqlr-000170-6f
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 21:47:38 -0500
Date: Tue, 5 Feb 2019 13:25:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190205022503.GC22661@umbus.fritz.box>
References: <20190204210433.26088-1-philmd@redhat.com>
	<20190204210433.26088-4-philmd@redhat.com>
	<38f72fdf-2260-e886-7d60-0fd169545255@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <38f72fdf-2260-e886-7d60-0fd169545255@reactos.org>
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/ppc/prep: Drop useless inclusion of
 "hw/i386/pc.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 10:11:07PM +0100, Herv=E9 Poussineau wrote:
> Le 04/02/2019 =E0 22:04, Philippe Mathieu-Daud=E9 a =E9crit=A0:
> > In 47973a2dbf we split the last generic chipset out of the PC
> > board, but forgot to remove the include of "hw/i386/pc.h".
> > Since it is now unused, remove it.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>

Applied to ppc-for-4.0, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxY8/8ACgkQbDjKyiDZ
s5INQg/+PO68aQxEssUaMrKsMY1Z+/zARYZPp4EgjoUBjmZAp35ZPPtf9Q8fpcsR
Squlz3s8Zw2KSrC/Hk5WnqXu1REfUWRZx42fQCf3ECO412SdL2YmrilH2mUz06pp
dleW8P9yV/Z1y6F4tKm+Ydoan5V3Uxot9ZmB/ZJjqYKCqGv0wV5evc40z4TSeWPw
Sebq2VyRtDzk63T72QjDSuvnNsqsi1to0hd1M+c2/O/WnIH35nadq4x8+1/XVXOz
tjTsJF+O6nIhGVaRjyiDmlk9FQ6psR1BPxiRwOQ5obpWwrXGj/1z2e8UAkCdltHj
TNGAo78iabmrQSnvXDmlqas7ktiDiX2xjrOzCqgfoxS1Pm3sUjZreY1C/PG7352s
tgnYk2rmvwAJXD1sQLGJNwceAE0aJG8IP2Cs0lByKbL2gBQVj4550SMquvJcZMkz
PaTA6r2FVG9CyWsnSb5M+SJntEzKHY1HTNGDteYFM/k+2VpBppNyHc646qnECXkA
jk1FbK9EpOIsk6XHC1xMKC2YT/W0qwcgbtrcZrZJOo9O5uAk2aLXIrPmKI87Ce2W
Cyd8s0+6A0na5ZnVlVBYfwNjutfG8Snv0tCOS5/i0zavEcpib8uBHsw1XBC99P2M
34Fp7l3GE87s4SmTvIvUUP5GVBEzGVM+nofbdNkwr66AtnCK5/g=
=dePH
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
