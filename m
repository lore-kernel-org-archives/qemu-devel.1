Received: from eggs.gnu.org ([2001:4830:134:3::10]:36142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0I-0007Jh-68
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0G-0002Au-O4
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:26 -0400
Date: Sat, 23 Sep 2017 15:14:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170923051403.GD4998@umbus.fritz.box>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-8-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FJ766Kk/2p6HVARF"
Content-Disposition: inline
In-Reply-To: <20170922160111.31885-8-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 30/34] hw/net/pcnet: use TYPE_PCI_PCNET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org


--FJ766Kk/2p6HVARF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 01:01:07PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc portion

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/net/pci.h | 1 +
>  hw/mips/mips_malta.c | 2 +-
>  hw/net/pcnet-pci.c   | 3 +--
>  hw/ppc/prep.c        | 3 ++-
>  4 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/net/pci.h b/include/hw/net/pci.h
> index 92111f86f3..5ad5487a91 100644
> --- a/include/hw/net/pci.h
> +++ b/include/hw/net/pci.h
> @@ -15,6 +15,7 @@
> =20
>  #define TYPE_PCI_E1000      "e1000"
>  #define TYPE_PCI_E1000E     "e1000e"
> +#define TYPE_PCI_PCNET      "pcnet"
> =20
>  PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>                                 const char *default_model,
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index fb6a2f9363..921678fdb0 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -597,7 +597,7 @@ static void network_init(PCIBus *pci_bus)
>              /* The malta board has a PCNet card using PCI SLOT 11 */
>              default_devaddr =3D "0b";
> =20
> -        pci_nic_init_nofail(nd, pci_bus, "pcnet", default_devaddr);
> +        pci_nic_init_nofail(nd, pci_bus, TYPE_PCI_PCNET, default_devaddr=
);
>      }
>  }
> =20
> diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
> index 0acf8a4879..878e2c89c1 100644
> --- a/hw/net/pcnet-pci.c
> +++ b/hw/net/pcnet-pci.c
> @@ -29,6 +29,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/pci/pci.h"
> +#include "hw/net/pci.h"
>  #include "net/net.h"
>  #include "hw/loader.h"
>  #include "qemu/timer.h"
> @@ -46,8 +47,6 @@
>  //#define PCNET_DEBUG_TMD
>  //#define PCNET_DEBUG_MATCH
> =20
> -#define TYPE_PCI_PCNET "pcnet"
> -
>  #define PCI_PCNET(obj) \
>       OBJECT_CHECK(PCIPCNetState, (obj), TYPE_PCI_PCNET)
> =20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index fb330a1769..b2c7a62ebc 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -44,6 +44,7 @@
>  #include "hw/input/i8042.h"
>  #include "hw/isa/pc87312.h"
>  #include "hw/net/ne2000-isa.h"
> +#include "hw/net/pci.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/kvm.h"
> @@ -800,7 +801,7 @@ static void ibm_40p_init(MachineState *machine)
>          pci_vga_init(pci_bus);
> =20
>          for (i =3D 0; i < nb_nics; i++) {
> -            pci_nic_init_nofail(&nd_table[i], pci_bus, "pcnet",
> +            pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_PCNET,
>                                  i =3D=3D 0 ? "3" : NULL);
>          }
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FJ766Kk/2p6HVARF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnF7ZsACgkQbDjKyiDZ
s5KjEg/+PDQr+QccK4hE+upZjmuJzkuQILaiTRxsukyodpODDlkBzPu+/he7kPU1
6InBbk7UJKI8MXOvp48j9JHwCLN0mhVYuNU+A+vb6EQvZgEAs1noQt80JPEjjeuI
xpZq5lqGQ5aXsRxhY6L/cW7xpGJmJQ+VyMAE58tjmUTcznASUgdD9YB1Xdg81daA
AwOkAvzWYal3ct4MDQ2vB6M/fS9wZtl6QXt8uovBH6xleVrGW0AtyWZo68mEE1+u
eGpfS76ZyR7I39H/5cBViz7jBwAtKPx06VzMayiz9/O8nmGcDWI/fN3dy0l8GEfU
MhK3fzwhgO8W6hTSr5F57ECpAUq2O/0M6zGbX+9IvK/6g9b1GsV8BcaD1AZsWV+x
HIHhv1GhIHszn4INizTML/Y2E6Q+qquYVceMHPUgXbgN9bGMxLuP9aEUJ7Wq1msU
uAPb1pQwQIPXnhh1U645JcH4NpnB5ADoJkq2kJeRSLzUetnSqG40HWjgwBVM4wm2
SvgCw+l0p8XRA9MnM1Fq3Bvu4AZeZKv2aCf+jSh9ko2PUStb8t2kzlctDLVEr7ak
bntLKlVqQaRpA6Lq+id0BIOR7ZLmBHhuVPhgS4fN7UOKksEoG+zDQQXG2HWffBsk
sn0tjeOCkZ+/o8tU3ZuG/TJa8wo6lkPgcMrWgrG+6juTRneOgF0=
=4mXj
-----END PGP SIGNATURE-----

--FJ766Kk/2p6HVARF--
