Received: from eggs.gnu.org ([2001:4830:134:3::10]:34097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eahyV-0007WL-Ez
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eahyQ-0003OH-EJ
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:05:23 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eahyQ-0003Nj-51
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:05:18 -0500
Received: by mail-qt0-x243.google.com with SMTP id f2so11254406qtj.4
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 05:05:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
	<20180114104751.21965-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2afc9a8c-ce2b-81f9-b255-53b1ec3a6451@amsat.org>
Date: Sun, 14 Jan 2018 10:05:00 -0300
MIME-Version: 1.0
In-Reply-To: <20180114104751.21965-2-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="hfBBUEy1fiAuQWB0hL5sBspD4vLhdCEhn"
Subject: Re: [Qemu-devel] [PATCH 01/11] apb: split simba PCI bridge into
 hw/pci-bridge/simba.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hfBBUEy1fiAuQWB0hL5sBspD4vLhdCEhn
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Message-ID: <2afc9a8c-ce2b-81f9-b255-53b1ec3a6451@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 01/11] apb: split simba PCI bridge into
 hw/pci-bridge/simba.c
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
 <20180114104751.21965-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180114104751.21965-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On 01/14/2018 07:47 AM, Mark Cave-Ayland wrote:
> Move the QOM type and macros into a new include/hw/pci-bridge/simba.h
> file, and add a new CONFIG_SIMBA Makefile.objs variable which is enable=
d
> for sparc64-softmmu builds only.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  default-configs/sparc64-softmmu.mak |   1 +
>  hw/pci-bridge/Makefile.objs         |   2 +
>  hw/pci-bridge/simba.c               | 101 ++++++++++++++++++++++++++++=
++++++++
>  hw/pci-host/apb.c                   |  62 +---------------------
>  include/hw/pci-bridge/simba.h       |  38 ++++++++++++++
>  include/hw/pci-host/apb.h           |   9 ----

I recommend you to use the scripts/git.orderfile, such code movement
result slightly easier to review.

>  6 files changed, 143 insertions(+), 70 deletions(-)
>  create mode 100644 hw/pci-bridge/simba.c
>  create mode 100644 include/hw/pci-bridge/simba.h
>=20
> diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/spar=
c64-softmmu.mak
> index 3e177bbd7b..9b742a7b41 100644
> --- a/default-configs/sparc64-softmmu.mak
> +++ b/default-configs/sparc64-softmmu.mak
> @@ -12,6 +12,7 @@ CONFIG_FDC=3Dy
>  CONFIG_IDE_ISA=3Dy
>  CONFIG_IDE_CMD646=3Dy
>  CONFIG_PCI_APB=3Dy
> +CONFIG_SIMBA=3Dy
>  CONFIG_SUNHME=3Dy
>  CONFIG_MC146818RTC=3Dy
>  CONFIG_ISA_TESTDEV=3Dy
> diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
> index 1b05023662..47065f87d9 100644
> --- a/hw/pci-bridge/Makefile.objs
> +++ b/hw/pci-bridge/Makefile.objs
> @@ -6,3 +6,5 @@ common-obj-$(CONFIG_IOH3420) +=3D ioh3420.o
>  common-obj-$(CONFIG_I82801B11) +=3D i82801b11.o
>  # NewWorld PowerMac
>  common-obj-$(CONFIG_DEC_PCI) +=3D dec.o
> +# Sun4u
> +common-obj-$(CONFIG_SIMBA) +=3D simba.o
> diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
> new file mode 100644
> index 0000000000..05ba6f0f34
> --- /dev/null
> +++ b/hw/pci-bridge/simba.c
> @@ -0,0 +1,101 @@
> +/*
> + * QEMU Simba PCI bridge
> + *
> + * Copyright (c) 2006 Fabrice Bellard
> + * Copyright (c) 2012,2013 Artyom Tarasenko
> + * Copyright (c) 2018 Mark Cave-Ayland
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_bridge.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci-bridge/simba.h"
> +
> +/*
> + * Chipset docs:
> + * APB: "Advanced PCI Bridge (APB) User's Manual",
> + * http://www.sun.com/processors/manuals/805-1251.pdf
> + */
> +
> +static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
> +{
> +    /*
> +     * command register:
> +     * According to PCI bridge spec, after reset
> +     *   bus master bit is off
> +     *   memory space enable bit is off
> +     * According to manual (805-1251.pdf).
> +     *   the reset value should be zero unless the boot pin is tied hi=
gh
> +     *   (which is true) and thus it should be PCI_COMMAND_MEMORY.
> +     */
> +    PBMPCIBridge *br =3D PBM_PCI_BRIDGE(dev);
> +
> +    pci_bridge_initfn(dev, TYPE_PCI_BUS);
> +
> +    pci_set_word(dev->config + PCI_COMMAND, PCI_COMMAND_MEMORY);
> +    pci_set_word(dev->config + PCI_STATUS,
> +                 PCI_STATUS_FAST_BACK | PCI_STATUS_66MHZ |
> +                 PCI_STATUS_DEVSEL_MEDIUM);
> +
> +    /* Allow 32-bit IO addresses */
> +    pci_set_word(dev->config + PCI_IO_BASE, PCI_IO_RANGE_TYPE_32);
> +    pci_set_word(dev->config + PCI_IO_LIMIT, PCI_IO_RANGE_TYPE_32);
> +    pci_set_word(dev->wmask + PCI_IO_BASE_UPPER16, 0xffff);
> +    pci_set_word(dev->wmask + PCI_IO_LIMIT_UPPER16, 0xffff);
> +
> +    pci_bridge_update_mappings(PCI_BRIDGE(br));
> +}
> +
> +static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> +
> +    k->realize =3D apb_pci_bridge_realize;
> +    k->exit =3D pci_bridge_exitfn;
> +    k->vendor_id =3D PCI_VENDOR_ID_SUN;
> +    k->device_id =3D PCI_DEVICE_ID_SUN_SIMBA;
> +    k->revision =3D 0x11;
> +    k->config_write =3D pci_bridge_write_config;
> +    k->is_bridge =3D 1;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->reset =3D pci_bridge_reset;
> +    dc->vmsd =3D &vmstate_pci_device;
> +}
> +
> +static const TypeInfo pbm_pci_bridge_info =3D {
> +    .name          =3D TYPE_PBM_PCI_BRIDGE,
> +    .parent        =3D TYPE_PCI_BRIDGE,
> +    .class_init    =3D pbm_pci_bridge_class_init,
> +    .instance_size =3D sizeof(PBMPCIBridge),
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
> +static void pbm_register_types(void)
> +{
> +    type_register_static(&pbm_pci_bridge_info);
> +}
> +
> +type_init(pbm_register_types)
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index ec676f94b6..3a5c046794 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -33,6 +33,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pci_bus.h"
> +#include "hw/pci-bridge/simba.h"
>  #include "hw/pci-host/apb.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
> @@ -53,9 +54,6 @@ do { printf("APB: " fmt , ## __VA_ARGS__); } while (0=
)
>   * Chipset docs:
>   * PBM: "UltraSPARC IIi User's Manual",
>   * http://www.sun.com/processors/manuals/805-0087.pdf
> - *
> - * APB: "Advanced PCI Bridge (APB) User's Manual",
> - * http://www.sun.com/processors/manuals/805-1251.pdf
>   */
> =20
>  #define PBM_PCI_IMR_MASK    0x7fffffff
> @@ -348,35 +346,6 @@ static void pci_apb_set_irq(void *opaque, int irq_=
num, int level)
>      }
>  }
> =20
> -static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
> -{
> -    /*
> -     * command register:
> -     * According to PCI bridge spec, after reset
> -     *   bus master bit is off
> -     *   memory space enable bit is off
> -     * According to manual (805-1251.pdf).
> -     *   the reset value should be zero unless the boot pin is tied hi=
gh
> -     *   (which is true) and thus it should be PCI_COMMAND_MEMORY.
> -     */
> -    PBMPCIBridge *br =3D PBM_PCI_BRIDGE(dev);
> -
> -    pci_bridge_initfn(dev, TYPE_PCI_BUS);
> -
> -    pci_set_word(dev->config + PCI_COMMAND, PCI_COMMAND_MEMORY);
> -    pci_set_word(dev->config + PCI_STATUS,
> -                 PCI_STATUS_FAST_BACK | PCI_STATUS_66MHZ |
> -                 PCI_STATUS_DEVSEL_MEDIUM);
> -
> -    /* Allow 32-bit IO addresses */
> -    pci_set_word(dev->config + PCI_IO_BASE, PCI_IO_RANGE_TYPE_32);
> -    pci_set_word(dev->config + PCI_IO_LIMIT, PCI_IO_RANGE_TYPE_32);
> -    pci_set_word(dev->wmask + PCI_IO_BASE_UPPER16, 0xffff);
> -    pci_set_word(dev->wmask + PCI_IO_LIMIT_UPPER16, 0xffff);
> -
> -    pci_bridge_update_mappings(PCI_BRIDGE(br));
> -}
> -
>  static void pci_pbm_reset(DeviceState *d)
>  {
>      APBState *s =3D APB_DEVICE(d);
> @@ -564,39 +533,10 @@ static const TypeInfo pbm_host_info =3D {
>      .class_init    =3D pbm_host_class_init,
>  };
> =20
> -static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> -
> -    k->realize =3D apb_pci_bridge_realize;
> -    k->exit =3D pci_bridge_exitfn;
> -    k->vendor_id =3D PCI_VENDOR_ID_SUN;
> -    k->device_id =3D PCI_DEVICE_ID_SUN_SIMBA;
> -    k->revision =3D 0x11;
> -    k->config_write =3D pci_bridge_write_config;
> -    k->is_bridge =3D 1;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    dc->reset =3D pci_bridge_reset;
> -    dc->vmsd =3D &vmstate_pci_device;
> -}
> -
> -static const TypeInfo pbm_pci_bridge_info =3D {
> -    .name          =3D TYPE_PBM_PCI_BRIDGE,
> -    .parent        =3D TYPE_PCI_BRIDGE,
> -    .class_init    =3D pbm_pci_bridge_class_init,
> -    .instance_size =3D sizeof(PBMPCIBridge),
> -    .interfaces =3D (InterfaceInfo[]) {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { },
> -    },
> -};
> -
>  static void pbm_register_types(void)
>  {
>      type_register_static(&pbm_host_info);
>      type_register_static(&pbm_pci_host_info);
> -    type_register_static(&pbm_pci_bridge_info);
>  }
> =20
>  type_init(pbm_register_types)
> diff --git a/include/hw/pci-bridge/simba.h b/include/hw/pci-bridge/simb=
a.h
> new file mode 100644
> index 0000000000..5ab1330236
> --- /dev/null
> +++ b/include/hw/pci-bridge/simba.h
> @@ -0,0 +1,38 @@
> +/*
> + * QEMU Simba PCI bridge
> + *
> + * Copyright (c) 2006 Fabrice Bellard
> + * Copyright (c) 2012,2013 Artyom Tarasenko
> + * Copyright (c) 2017 Mark Cave-Ayland
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci_bridge.h"
> +
> +
> +typedef struct PBMPCIBridge {
> +    /*< private >*/
> +    PCIBridge parent_obj;
> +} PBMPCIBridge;
> +
> +#define TYPE_PBM_PCI_BRIDGE "pbm-bridge"
> +#define PBM_PCI_BRIDGE(obj) \
> +    OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index 604d899b1e..5e28f3e1f3 100644
> --- a/include/hw/pci-host/apb.h
> +++ b/include/hw/pci-host/apb.h
> @@ -42,13 +42,4 @@ typedef struct APBState {
>      unsigned int nr_resets;
>  } APBState;
> =20
> -typedef struct PBMPCIBridge {
> -    /*< private >*/
> -    PCIBridge parent_obj;
> -} PBMPCIBridge;
> -
> -#define TYPE_PBM_PCI_BRIDGE "pbm-bridge"
> -#define PBM_PCI_BRIDGE(obj) \
> -    OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
> -
>  #endif
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


--hfBBUEy1fiAuQWB0hL5sBspD4vLhdCEhn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpbVXwACgkQ4+MsLN6t
wN4cYhAAlvieo+nwMTZ3RmR8c2dtZgRICndSwNYXZ9E/A61QwLpnkYqdyH3xtqoB
fLyhCA5g1JQZAqyvngsdLVeBPdO/aekU57bSgxwZ7OLFtvJSRyp+jat/Q/K3tSbF
Hzd/QyqeS19MJkmwTLue3LGrdonloFs/6Zjo6A5BFji4fqW2CtJpIEdtiWK63nY3
NgFKmhdqfa1mv57T05HWDucsHx4L+xmqaM4Z1rOHCZ/dTNFD3QLtO9sGAvnJ7hw0
G78ogFUbQQzxGGUYjE4BMnye0JXHBjQQnk6ImZprMtIqWrmFQJe6jEBE19J5UV8T
H7d2ESM1RTLc0D5aelwdnsljVhtVqwpb7eSfQHvgqJCgbA9RtY2jxZDn3U9+L0Vv
DmQBzDix0w6d3+sOfu0EsSVzs+P7zEHrYD9NL3i47AkRRWk4OgkzQ4hJT2oYKBN0
0WUuZnKrvV5IBRlujMlyQ+L6rtlTl7oBB2PJ9Bky2iOWQA75jrT8p1E/eQusa4NP
4IaVMyVIGCvb8/bVf7Rup/dATCss88mclL3fsTz3mULLgUmSyZgBFrBN4uT5Pj/Q
94qC0WoEyIm5XviS3bVVu7+36ROFEw/kgCXIdlCY67SSxDZi2gC4CzGkg27mz1fy
We3Is3xajH66JoRDV4wE24a3HDF2k4TirgTyjOegrEAVrFz3API=
=6asP
-----END PGP SIGNATURE-----

--hfBBUEy1fiAuQWB0hL5sBspD4vLhdCEhn--
