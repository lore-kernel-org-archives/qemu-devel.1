Received: from eggs.gnu.org ([2001:4830:134:3::10]:59086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct6Rv-0007vJ-1G
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct6Ru-0002A6-0h
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:47:15 -0400
Date: Wed, 29 Mar 2017 16:25:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329052551.GC21068@umbus.fritz.box>
References: <20170329050958.3652-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cX4WM3qIY/fHWHDu"
Content-Disposition: inline
In-Reply-To: <20170329050958.3652-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] spapr_pci: Removed unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--cX4WM3qIY/fHWHDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 04:09:58PM +1100, Alexey Kardashevskiy wrote:
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> This leftover is just confusing :)

Applied to ppc-for-2.10.

>=20
>=20
> ---
>  hw/ppc/spapr_pci.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 097ebdd51d..e7567e2e8f 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -50,8 +50,6 @@
>  #include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
> =20
> -#include "hw/vfio/vfio.h"
> -
>  /* Copied from the kernel arch/powerpc/platforms/pseries/msi.c */
>  #define RTAS_QUERY_FN           0
>  #define RTAS_CHANGE_FN          1

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cX4WM3qIY/fHWHDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY20VfAAoJEGw4ysog2bOSoGkP/iHDQDYnrad1xNCve9T9GJUk
iZj88KtdIC7SPgIajTgKYsTOOr2sqz0bfcdZZkHys7mAGDIQCF0e0vzbGYKC8lW+
jOPl/tAnrq+wnVue/XkoLFvpvg7UhfavXP+0JPVyxEV1CBNLVo2AXcetsL2V3sie
NzvuuwopKG72/KAKagfFxn4ItuDAajkad7b6FZXi9CWmN1Gr4l6+sGTZXwAFoTNZ
SFntxXoKvnIsfuRgyHKE+vJ8Tv3S9qSd4T8NipgKeH3DfpwKqj1V+cNKlYKmhlad
S7gstw5w/S0cYSkxM61enrI6nvJXrqe5T8UqpLJ/mHPRA74soTLbxobL5ZENCqJ/
3J9R3Yv2k8TazI9BS/7rjH8cf9uBr/PciG0Tz4sPstYqcXyNRT/XUfV4WeJ0iPEZ
jBBaK3SSZsieQ6YmvmhtTYrxN/AbnPuPQOYxlt2ch6Tn3/qonJlW2E+B0eVZfOri
Z98QPqLfrWlmNaTxlCBZbJl8nMPP98V1bLqK81ddneLCo4VCgtFyJldhfQ7LhP//
7ulwAta9qJ/Qiju7xgzdd+70yVmQBRiG0E3HfyH5hp3Rz8COlDKQWulGNh5egt+n
GGiHQg6AD/j+weaDCuERRwX0T5P55V8VJTduEiD0+4INf169x4KLa9ZqOpeLom9e
7Om7ZqXbIzusDfdonlQG
=G4gV
-----END PGP SIGNATURE-----

--cX4WM3qIY/fHWHDu--
