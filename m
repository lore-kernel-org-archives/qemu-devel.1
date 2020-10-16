Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E5C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BAA720797
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nIQL4JXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAA720797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTDgQ-00075z-JC
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 20:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDdc-0004mG-PY; Thu, 15 Oct 2020 20:30:30 -0400
Received: from ozlabs.org ([203.11.71.1]:59167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDdZ-0000EG-GD; Thu, 15 Oct 2020 20:30:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CC6Vx3nZ6z9sV0; Fri, 16 Oct 2020 11:30:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602808217;
 bh=8R2K2t4Rvo6/hV/FvZo++PwpO5WuDttAUQ4ZZHdsHwg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nIQL4JXhqsetC09xtBpHZ62VkK+5cZnAviU/FD75gJa7MUl88MtHqaAr9rsj9spcP
 i6GH2r8HVJMMJIW1JQZr0vrc/9EkrHlYClRF0suMmn9XMm4DcyrqZuAGZjoOzEmfcP
 PGh97koz7Klb8pLZky2nry2+3CAQaDhC/2F9x0/Q=
Date: Fri, 16 Oct 2020 11:21:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 3/3] uninorth: use qdev gpios for PCI IRQs
Message-ID: <20201016002136.GD7078@yekko.fritz.box>
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20201013114922.2946-4-mark.cave-ayland@ilande.co.uk>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:30:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 12:49:22PM +0100, Mark Cave-Ayland wrote:
> Currently an object link property is used to pass a reference to the Open=
PIC
> into the PCI host bridge so that pci_unin_init_irqs() can connect the PCI
> IRQs to the PIC itself.
>=20
> This can be simplified by defining the PCI IRQs as qdev gpios and then wi=
ring
> up the PCI IRQs to the PIC in the New World machine init function.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-5.2, thanks.

> ---
>  hw/pci-host/uninorth.c         | 45 +++++++---------------------------
>  hw/ppc/mac_newworld.c          | 24 ++++++++++++------
>  include/hw/pci-host/uninorth.h |  2 --
>  3 files changed, 25 insertions(+), 46 deletions(-)
>=20
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 1ed1072eeb..0c0a9ecee1 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -32,8 +32,6 @@
>  #include "hw/pci-host/uninorth.h"
>  #include "trace.h"
> =20
> -static const int unin_irq_line[] =3D { 0x1b, 0x1c, 0x1d, 0x1e };
> -
>  static int pci_unin_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
>      return (irq_num + (pci_dev->devfn >> 3)) & 3;
> @@ -43,7 +41,7 @@ static void pci_unin_set_irq(void *opaque, int irq_num,=
 int level)
>  {
>      UNINHostState *s =3D opaque;
> =20
> -    trace_unin_set_irq(unin_irq_line[irq_num], level);
> +    trace_unin_set_irq(irq_num, level);
>      qemu_set_irq(s->irqs[irq_num], level);
>  }
> =20
> @@ -112,15 +110,6 @@ static const MemoryRegionOps unin_data_ops =3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
> -static void pci_unin_init_irqs(UNINHostState *s)
> -{
> -    int i;
> -
> -    for (i =3D 0; i < ARRAY_SIZE(s->irqs); i++) {
> -        s->irqs[i] =3D qdev_get_gpio_in(DEVICE(s->pic), unin_irq_line[i]=
);
> -    }
> -}
> -
>  static char *pci_unin_main_ofw_unit_address(const SysBusDevice *dev)
>  {
>      UNINHostState *s =3D UNI_NORTH_PCI_HOST_BRIDGE(dev);
> @@ -141,7 +130,6 @@ static void pci_unin_main_realize(DeviceState *dev, E=
rror **errp)
>                                     PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> =20
>      pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
> -    pci_unin_init_irqs(s);
> =20
>      /* DEC 21154 bridge */
>  #if 0
> @@ -172,15 +160,12 @@ static void pci_unin_main_init(Object *obj)
>                               "unin-pci-hole", &s->pci_mmio,
>                               0x80000000ULL, 0x10000000ULL);
> =20
> -    object_property_add_link(obj, "pic", TYPE_OPENPIC,
> -                             (Object **) &s->pic,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             0);
> -
>      sysbus_init_mmio(sbd, &h->conf_mem);
>      sysbus_init_mmio(sbd, &h->data_mem);
>      sysbus_init_mmio(sbd, &s->pci_hole);
>      sysbus_init_mmio(sbd, &s->pci_io);
> +
> +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
>  }
> =20
>  static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
> @@ -196,7 +181,6 @@ static void pci_u3_agp_realize(DeviceState *dev, Erro=
r **errp)
>                                     PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> =20
>      pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
> -    pci_unin_init_irqs(s);
>  }
> =20
>  static void pci_u3_agp_init(Object *obj)
> @@ -220,15 +204,12 @@ static void pci_u3_agp_init(Object *obj)
>                               "unin-pci-hole", &s->pci_mmio,
>                               0x80000000ULL, 0x70000000ULL);
> =20
> -    object_property_add_link(obj, "pic", TYPE_OPENPIC,
> -                             (Object **) &s->pic,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             0);
> -
>      sysbus_init_mmio(sbd, &h->conf_mem);
>      sysbus_init_mmio(sbd, &h->data_mem);
>      sysbus_init_mmio(sbd, &s->pci_hole);
>      sysbus_init_mmio(sbd, &s->pci_io);
> +
> +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
>  }
> =20
>  static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
> @@ -244,7 +225,6 @@ static void pci_unin_agp_realize(DeviceState *dev, Er=
ror **errp)
>                                     PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> =20
>      pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
> -    pci_unin_init_irqs(s);
>  }
> =20
>  static void pci_unin_agp_init(Object *obj)
> @@ -259,13 +239,10 @@ static void pci_unin_agp_init(Object *obj)
>      memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
>                            obj, "unin-agp-conf-data", 0x1000);
> =20
> -    object_property_add_link(obj, "pic", TYPE_OPENPIC,
> -                             (Object **) &s->pic,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             0);
> -
>      sysbus_init_mmio(sbd, &h->conf_mem);
>      sysbus_init_mmio(sbd, &h->data_mem);
> +
> +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
>  }
> =20
>  static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
> @@ -281,7 +258,6 @@ static void pci_unin_internal_realize(DeviceState *de=
v, Error **errp)
>                                     PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
> =20
>      pci_create_simple(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci"=
);
> -    pci_unin_init_irqs(s);
>  }
> =20
>  static void pci_unin_internal_init(Object *obj)
> @@ -296,13 +272,10 @@ static void pci_unin_internal_init(Object *obj)
>      memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
>                            obj, "unin-pci-conf-data", 0x1000);
> =20
> -    object_property_add_link(obj, "pic", TYPE_OPENPIC,
> -                             (Object **) &s->pic,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             0);
> -
>      sysbus_init_mmio(sbd, &h->conf_mem);
>      sysbus_init_mmio(sbd, &h->data_mem);
> +
> +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
>  }
> =20
>  static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 6f5ef2e782..7a8dc09c8d 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -303,8 +303,6 @@ static void ppc_core99_init(MachineState *machine)
>          /* 970 gets a U3 bus */
>          /* Uninorth AGP bus */
>          dev =3D qdev_new(TYPE_U3_AGP_HOST_BRIDGE);
> -        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
> -                                 &error_abort);
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>          uninorth_pci =3D U3_AGP_HOST_BRIDGE(dev);
>          s =3D SYS_BUS_DEVICE(dev);
> @@ -317,32 +315,38 @@ static void ppc_core99_init(MachineState *machine)
>          sysbus_mmio_map(s, 0, 0xf0800000);
>          sysbus_mmio_map(s, 1, 0xf0c00000);
> =20
> +        for (i =3D 0; i < 4; i++) {
> +            qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x1b=
 + i));
> +        }
> +
>          machine_arch =3D ARCH_MAC99_U3;
>      } else {
>          /* Use values found on a real PowerMac */
>          /* Uninorth AGP bus */
>          dev =3D qdev_new(TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
> -        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
> -                                 &error_abort);
>          s =3D SYS_BUS_DEVICE(dev);
>          sysbus_realize_and_unref(s, &error_fatal);
>          sysbus_mmio_map(s, 0, 0xf0800000);
>          sysbus_mmio_map(s, 1, 0xf0c00000);
> =20
> +        for (i =3D 0; i < 4; i++) {
> +            qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x1b=
 + i));
> +        }
> +
>          /* Uninorth internal bus */
>          dev =3D qdev_new(TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
> -        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
> -                                 &error_abort);
>          s =3D SYS_BUS_DEVICE(dev);
>          sysbus_realize_and_unref(s, &error_fatal);
>          sysbus_mmio_map(s, 0, 0xf4800000);
>          sysbus_mmio_map(s, 1, 0xf4c00000);
> =20
> +        for (i =3D 0; i < 4; i++) {
> +            qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x1b=
 + i));
> +        }
> +
>          /* Uninorth main bus */
>          dev =3D qdev_new(TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
>          qdev_prop_set_uint32(dev, "ofw-addr", 0xf2000000);
> -        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
> -                                 &error_abort);
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>          uninorth_pci =3D UNI_NORTH_PCI_HOST_BRIDGE(dev);
>          s =3D SYS_BUS_DEVICE(dev);
> @@ -355,6 +359,10 @@ static void ppc_core99_init(MachineState *machine)
>          sysbus_mmio_map(s, 0, 0xf2800000);
>          sysbus_mmio_map(s, 1, 0xf2c00000);
> =20
> +        for (i =3D 0; i < 4; i++) {
> +            qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x1b=
 + i));
> +        }
> +
>          machine_arch =3D ARCH_MAC99;
>      }
> =20
> diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
> index a6ba5f21a8..62bd81e721 100644
> --- a/include/hw/pci-host/uninorth.h
> +++ b/include/hw/pci-host/uninorth.h
> @@ -26,7 +26,6 @@
>  #define UNINORTH_H
> =20
>  #include "hw/pci/pci_host.h"
> -#include "hw/ppc/openpic.h"
>  #include "qom/object.h"
> =20
>  /* UniNorth version */
> @@ -51,7 +50,6 @@ struct UNINHostState {
>      PCIHostState parent_obj;
> =20
>      uint32_t ofw_addr;
> -    OpenPICState *pic;
>      qemu_irq irqs[4];
>      MemoryRegion pci_mmio;
>      MemoryRegion pci_hole;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+I55AACgkQbDjKyiDZ
s5JcshAAxSoqd1RqgLrnfJ/aD3igs7mqsAHBqeptiXDUsrE6NLue0vnII1vWZJDd
wunfEWCEc9frmeIMntY9tysa0f67nM1ReEOUv+fE1DwLi5kyE5nGP1DfdvBratde
xbKM+gUlA6Lx9/NDQxY+Q0VwiKElO0U062zNZ1lb/qZv+ZGa3J3hW3cAYLM+S/Al
TegV9cGZ7eiavgjdmmkO3pStWPcCQ3UXTwzGyLIrvIHbvobdgr7PHY7bJuwyY4sB
vzivNpG9WDvx85dwJgYA7GpASXtrqz8FAbVipYoHILTgGiVTEiD+oKkUEYOV+38f
cBBr3x5IBHJ2fK3lSrhjItt6+k6Vzf6nvrLsfiSj2rm5BP3P/v/pMmyN/QvPRJpm
OBv+c1WBbgB9p4dX1cb2mKC4XxECORToJztd+lhUY1Gv6xYNkgtBBM+jUKTI4foJ
651rwbW5v0I9hn4tn4FfNEHBV3iMIgrAPqgXjxfBoWwpvXMAH+B8BBqhucyXtCPA
8RF5bi2E1vPR2sF+ZrgSDiCRTntxqnN8OoQWgejOHN+rkjEzpaYcvRu5upcn5IKh
LWOHYS7oPz1O07GFvl9pKPKd/A4AQoc8zmWjOQudfIOp9c2kdhS1A0uUOaqV2D/R
kz4UoCaTXeQzHpYNZqBU6hA3V6CP4GjYduo3yoR1RG9eubcIOxg=
=+gip
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--

