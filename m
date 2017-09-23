Received: from eggs.gnu.org ([2001:4830:134:3::10]:36263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0M-0007Nj-M2
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0L-0002DX-0l
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:30 -0400
Date: Sat, 23 Sep 2017 15:14:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170923051439.GE4998@umbus.fritz.box>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-10-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eQ8QKBgzzGzhafWG"
Content-Disposition: inline
In-Reply-To: <20170922160111.31885-10-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 32/34] hw/net/ne2000: use TYPE_PCI_NE2000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org


--eQ8QKBgzzGzhafWG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 01:01:09PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc portions

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/net/pci.h  | 1 +
>  hw/net/ne2000.c       | 3 ++-
>  hw/ppc/mac_newworld.c | 3 ++-
>  hw/ppc/mac_oldworld.c | 3 ++-
>  hw/ppc/prep.c         | 2 +-
>  hw/sparc64/sun4u.c    | 3 ++-
>  6 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/net/pci.h b/include/hw/net/pci.h
> index 43ed3b0145..da733dd1d9 100644
> --- a/include/hw/net/pci.h
> +++ b/include/hw/net/pci.h
> @@ -15,6 +15,7 @@
> =20
>  #define TYPE_PCI_E1000      "e1000"
>  #define TYPE_PCI_E1000E     "e1000e"
> +#define TYPE_PCI_NE2000     "ne2k_pci"
>  #define TYPE_PCI_PCNET      "pcnet"
>  #define TYPE_PCI_RTL8139    "rtl8139"
> =20
> diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
> index 29bd4adb3f..b0a664d302 100644
> --- a/hw/net/ne2000.c
> +++ b/hw/net/ne2000.c
> @@ -23,6 +23,7 @@
>   */
>  #include "qemu/osdep.h"
>  #include "hw/pci/pci.h"
> +#include "hw/net/pci.h"
>  #include "ne2000.h"
>  #include "hw/loader.h"
>  #include "sysemu/sysemu.h"
> @@ -779,7 +780,7 @@ static void ne2000_class_init(ObjectClass *klass, voi=
d *data)
>  }
> =20
>  static const TypeInfo ne2000_info =3D {
> -    .name          =3D "ne2k_pci",
> +    .name          =3D TYPE_PCI_NE2000,
>      .parent        =3D TYPE_PCI_DEVICE,
>      .instance_size =3D sizeof(PCINE2000State),
>      .class_init    =3D ne2000_class_init,
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 33b46cb50b..2afc35c27f 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -55,6 +55,7 @@
>  #include "hw/ppc/mac_dbdma.h"
>  #include "hw/timer/m48t59.h"
>  #include "hw/pci/pci.h"
> +#include "hw/net/pci.h"
>  #include "net/net.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/boards.h"
> @@ -435,7 +436,7 @@ static void ppc_core99_init(MachineState *machine)
>      }
> =20
>      for (i =3D 0; i < nb_nics; i++) {
> -        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
> +        pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_NE2000, NULL=
);
>      }
> =20
>      /* The NewWorld NVRAM is not located in the MacIO device */
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 193b9047d9..8096e5a126 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -34,6 +34,7 @@
>  #include "net/net.h"
>  #include "hw/isa/isa.h"
>  #include "hw/pci/pci.h"
> +#include "hw/net/pci.h"
>  #include "hw/boards.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/char/escc.h"
> @@ -278,7 +279,7 @@ static void ppc_heathrow_init(MachineState *machine)
>                               escc_mem, 0, memory_region_size(escc_mem));
> =20
>      for(i =3D 0; i < nb_nics; i++)
> -        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
> +        pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_NE2000, NULL=
);
> =20
> =20
>      ide_drive_get(hd, ARRAY_SIZE(hd));
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index b2c7a62ebc..103beafef3 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -636,7 +636,7 @@ static void ppc_prep_init(MachineState *machine)
>              isa_ne2000_init(isa_bus, ne2000_io[i], ne2000_irq[i],
>                              &nd_table[i]);
>          } else {
> -            pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
> +            pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_NE2000, =
NULL);
>          }
>      }
> =20
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index fd10741607..67879c5135 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -32,6 +32,7 @@
>  #include "hw/char/serial.h"
>  #include "hw/timer/m48t59.h"
>  #include "hw/input/i8042.h"
> +#include "hw/net/pci.h"
>  #include "hw/block/fdc.h"
>  #include "net/net.h"
>  #include "qemu/timer.h"
> @@ -476,7 +477,7 @@ static void sun4uv_init(MemoryRegion *address_space_m=
em,
> =20
>              onboard_nic_idx =3D i;
>          } else {
> -            pci_nic_init_nofail(nd, pci_bus, "ne2k_pci", NULL);
> +            pci_nic_init_nofail(nd, pci_bus, TYPE_PCI_NE2000, NULL);
>          }
>      }
>      onboard_nic_idx =3D MAX(onboard_nic_idx, 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eQ8QKBgzzGzhafWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnF7b8ACgkQbDjKyiDZ
s5LW5w/9G8+GXm5Doj+lxWuroVUfLx8CFKwO8J+KeHHK4s+zSrdTEqLDvnnw19qN
Hqj65mA+Z/eYhyI12ylP3QyWJrcjvNTZwPccpjoXWzdxhY+L0MbY0RO+vbE3Amgr
hqCoJQu5/A6ssU9yMf8yYv6ol1yNPwoHqyiCNGn0CiKzkdeO49pih00ALB0xkk1J
3wtgQ8JMqSbNy8G7gWM4pwDs5BSw9xJz3M7PHx+KBaeIqFmkgrdzmzojMZ/wa4DB
JGvyA4f4e4P7Ot3JDWl6teblQwjrQaVf/gtlLeM1aKEqxiCUfJabgzeKI1n7SKZB
3SwBvBBP0aBhSO7Klsk9T7IYG9/hvrvP3cquMwyfY714TwV2TkjESEtWE1GESoZ6
jBttZpgkGhcsM4Xs0z1V1PggF3IzUkwUWkw8W/lYSVXmAEgabhMSOAoqw7Kby+ig
Y2BBNFevpDM19ldINPMFtBXcZLfUNsUDNXJZh4CcKKCkfkj9NMZ9EdZXgvaS8A18
I6/s1w45AGK3qmzIf4PNfqVhXW9pQsxZ4vQDIhILGCyXkAxZNp3pIvM4P6Vi7zM/
PG/1fvnfC8d6vNzbhay7zZ3weMfDLS0fCLS8CKo2cTpPCiA3EIk+aV/hpCrjl9XI
gNfTNwYwHivn0KF5BoI/fBsgH73xFRXNw44TIKWvrH6KuYUQACE=
=Zd0Q
-----END PGP SIGNATURE-----

--eQ8QKBgzzGzhafWG--
