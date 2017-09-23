Received: from eggs.gnu.org ([2001:4830:134:3::10]:36133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0H-0007Jd-UB
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0G-0002Az-O8
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:25 -0400
Date: Sat, 23 Sep 2017 15:13:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170923051336.GC4998@umbus.fritz.box>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Efge0/SQAHHP+Pr2"
Content-Disposition: inline
In-Reply-To: <20170922160111.31885-6-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 28/34] hw/net/e1000: use TYPE_PCI_E1000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Balaton Zoltan <balaton@eik.bme.hu>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org


--Efge0/SQAHHP+Pr2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 01:01:05PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc portion

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/net/pci.h   | 2 ++
>  hw/alpha/dp264.c       | 3 ++-
>  hw/i386/pc.c           | 3 ++-
>  hw/ppc/ppc440_bamboo.c | 3 ++-
>  4 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/net/pci.h b/include/hw/net/pci.h
> index 529591b7f3..b24b5257a5 100644
> --- a/include/hw/net/pci.h
> +++ b/include/hw/net/pci.h
> @@ -13,6 +13,8 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
> =20
> +#define TYPE_PCI_E1000      "e1000"
> +
>  PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>                                 const char *default_model,
>                                 const char *default_devaddr);
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index df6dadf13f..65947fe1bf 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -21,6 +21,7 @@
>  #include "hw/timer/i8254.h"
>  #include "hw/input/i8042.h"
>  #include "hw/char/serial.h"
> +#include "hw/net/pci.h"
>  #include "qemu/cutils.h"
> =20
>  #define MAX_IDE_BUS 2
> @@ -93,7 +94,7 @@ static void clipper_init(MachineState *machine)
> =20
>      /* Network setup.  e1000 is good enough, failing Tulip support.  */
>      for (i =3D 0; i < nb_nics; i++) {
> -        pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
> +        pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_E1000, NULL);
>      }
> =20
>      /* IDE disk setup.  */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 085577e066..3cdeb148aa 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -72,6 +72,7 @@
>  #include "hw/nmi.h"
>  #include "hw/i386/intel_iommu.h"
>  #include "hw/net/ne2000-isa.h"
> +#include "hw/net/pci.h"
> =20
>  /* debug PC/ISA interrupts */
>  //#define DEBUG_IRQ
> @@ -1606,7 +1607,7 @@ void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus)
>          if (!pci_bus || (nd->model && strcmp(nd->model, "ne2k_isa") =3D=
=3D 0)) {
>              pc_init_ne2k_isa(isa_bus, nd);
>          } else {
> -            pci_nic_init_nofail(nd, pci_bus, "e1000", NULL);
> +            pci_nic_init_nofail(nd, pci_bus, TYPE_PCI_E1000, NULL);
>          }
>      }
>      rom_reset_order_override();
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index f92d47f28d..6387dbda9f 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -24,6 +24,7 @@
>  #include "elf.h"
>  #include "exec/address-spaces.h"
>  #include "hw/char/serial.h"
> +#include "hw/net/pci.h"
>  #include "hw/ppc/ppc.h"
>  #include "ppc405.h"
>  #include "sysemu/sysemu.h"
> @@ -248,7 +249,7 @@ static void bamboo_init(MachineState *machine)
>          for (i =3D 0; i < nb_nics; i++) {
>              /* There are no PCI NICs on the Bamboo board, but there are
>               * PCI slots, so we can pick whatever default model we want.=
 */
> -            pci_nic_init_nofail(&nd_table[i], pcibus, "e1000", NULL);
> +            pci_nic_init_nofail(&nd_table[i], pcibus, TYPE_PCI_E1000, NU=
LL);
>          }
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Efge0/SQAHHP+Pr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnF7YAACgkQbDjKyiDZ
s5IswxAApbvz6DAIapNCOmaJOc+n6ZJhZAoI5t6PPw4m0cQuSiHDcwvnr4yNUsNT
hRPgH2N1xsEIrtI9wIfmeO8F4pin//RudWy7/qcOFkPN1cKJ7ydNTYLUztWEUdh3
Ym9JoftZ7UKoesFHr9OirfvCQZt2DDkY5DISgq19/7O6NRf8wFK7WRkdluYg1KBK
PQ7tx+NfabkwuAsjvXX4VFE4QexEyB7B2jkS1TepkRY4zheTSQXkQDKChGq42zF9
5ctPbfOvhXVF79GYkSEOsqpnDWjYE1bn7OInExdoC054Zlcge333ecXFUwoFShsY
rOHi288zfza95tmvG/wyOuSr+OiGkcF5U7OqYFfOKC5uJxI6/SkQjlFwiFKJoaoR
PNXVDS7LMbTc0sDgONnO+o8GvSSSVxYvMzZeHgMzaPbr5wsgZ9H9S5TwpJlc0gwS
t8B4KzmiKrlZ2lOOkGzwUTP7AHsDYQCw2ok7k9jRj6PeZxD0Rk9UOlD1/gB5U9y9
X3xusg8oml15mG+58VR0YK694VnHC1mqE0zgaOBusYKQWeu4VIqu4eMvPnGi4IlY
4x7uxKwVSsMs7hLuKjy9Tj3heVefoXdXYPX11g/wiAY1Dfk5R5l/JJf43sYRzZv3
cl4qORoqedWDLiO38geTDTl/wSH1FDCa/Dh4IOkQqOlVGf3MZEQ=
=4vs3
-----END PGP SIGNATURE-----

--Efge0/SQAHHP+Pr2--
