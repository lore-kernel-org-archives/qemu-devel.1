Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFC6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562F320795
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YygxiqCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562F320795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTDgP-00074j-3L
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 20:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDde-0004mQ-FL; Thu, 15 Oct 2020 20:30:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDdZ-0000E9-DQ; Thu, 15 Oct 2020 20:30:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CC6Vx2R58z9sTr; Fri, 16 Oct 2020 11:30:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602808217;
 bh=vacZmplMm7mxZEnI7ew1FVVcBgM4S5rOVjRMoDGKcNI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YygxiqCzIo/3P7tWt7wZkFvhoDsc4Jyz8mGK0KmjQRWPtbKUa4OQIPd9PUHFvSjUH
 LkxGYSwW1BEEQsu689No8wRe9iQ2w68qYDt0Ul2Am+NfSNONr8DxtbhPy+Prg52jff
 ALI7+SVzxIn4MoDhCOV5DWNKtUX1QXwLNpqQDe2Q=
Date: Fri, 16 Oct 2020 11:18:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 2/3] grackle: use qdev gpios for PCI IRQs
Message-ID: <20201016001803.GC7078@yekko.fritz.box>
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20201013114922.2946-3-mark.cave-ayland@ilande.co.uk>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 12:49:21PM +0100, Mark Cave-Ayland wrote:
> Currently an object link property is used to pass a reference to the Heat=
hrow
> PIC into the PCI host bridge so that grackle_init_irqs() can connect the =
PCI
> IRQs to the PIC itself.
>=20
> This can be simplified by defining the PCI IRQs as qdev gpios and then wi=
ring
> up the PCI IRQs to the PIC in the Old World machine init function.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-5.2.

> ---
>  hw/pci-host/grackle.c | 19 ++-----------------
>  hw/ppc/mac_oldworld.c |  7 +++++--
>  2 files changed, 7 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> index 57c29b20af..b05facf463 100644
> --- a/hw/pci-host/grackle.c
> +++ b/hw/pci-host/grackle.c
> @@ -28,7 +28,6 @@
>  #include "hw/ppc/mac.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/pci/pci.h"
> -#include "hw/intc/heathrow_pic.h"
>  #include "hw/irq.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
> @@ -41,7 +40,6 @@ struct GrackleState {
>      PCIHostState parent_obj;
> =20
>      uint32_t ofw_addr;
> -    HeathrowState *pic;
>      qemu_irq irqs[4];
>      MemoryRegion pci_mmio;
>      MemoryRegion pci_hole;
> @@ -62,15 +60,6 @@ static void pci_grackle_set_irq(void *opaque, int irq_=
num, int level)
>      qemu_set_irq(s->irqs[irq_num], level);
>  }
> =20
> -static void grackle_init_irqs(GrackleState *s)
> -{
> -    int i;
> -
> -    for (i =3D 0; i < ARRAY_SIZE(s->irqs); i++) {
> -        s->irqs[i] =3D qdev_get_gpio_in(DEVICE(s->pic), 0x15 + i);
> -    }
> -}
> -
>  static void grackle_realize(DeviceState *dev, Error **errp)
>  {
>      GrackleState *s =3D GRACKLE_PCI_HOST_BRIDGE(dev);
> @@ -85,7 +74,6 @@ static void grackle_realize(DeviceState *dev, Error **e=
rrp)
>                                       0, 4, TYPE_PCI_BUS);
> =20
>      pci_create_simple(phb->bus, 0, "grackle");
> -    grackle_init_irqs(s);
>  }
> =20
>  static void grackle_init(Object *obj)
> @@ -106,15 +94,12 @@ static void grackle_init(Object *obj)
>      memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops,
>                            DEVICE(obj), "pci-data-idx", 0x1000);
> =20
> -    object_property_add_link(obj, "pic", TYPE_HEATHROW,
> -                             (Object **) &s->pic,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             0);
> -
>      sysbus_init_mmio(sbd, &phb->conf_mem);
>      sysbus_init_mmio(sbd, &phb->data_mem);
>      sysbus_init_mmio(sbd, &s->pci_hole);
>      sysbus_init_mmio(sbd, &s->pci_io);
> +
> +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
>  }
> =20
>  static void grackle_pci_realize(PCIDevice *d, Error **errp)
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index d6a76d06dc..05e46ee6fe 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -253,10 +253,9 @@ static void ppc_heathrow_init(MachineState *machine)
>      /* Grackle PCI host bridge */
>      dev =3D qdev_new(TYPE_GRACKLE_PCI_HOST_BRIDGE);
>      qdev_prop_set_uint32(dev, "ofw-addr", 0x80000000);
> -    object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
> -                             &error_abort);
>      s =3D SYS_BUS_DEVICE(dev);
>      sysbus_realize_and_unref(s, &error_fatal);
> +
>      sysbus_mmio_map(s, 0, GRACKLE_BASE);
>      sysbus_mmio_map(s, 1, GRACKLE_BASE + 0x200000);
>      /* PCI hole */
> @@ -266,6 +265,10 @@ static void ppc_heathrow_init(MachineState *machine)
>      memory_region_add_subregion(get_system_memory(), 0xfe000000,
>                                  sysbus_mmio_get_region(s, 3));
> =20
> +    for (i =3D 0; i < 4; i++) {
> +        qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x15 + i=
));
> +    }
> +
>      pci_bus =3D PCI_HOST_BRIDGE(dev)->bus;
> =20
>      pci_vga_init(pci_bus);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+I5roACgkQbDjKyiDZ
s5JbkRAA4/7hKdwI2+BY6/JGgIqtFXC2eEQApvzFPuvj+fmorCywg2Drk6c2otC1
LK4ROYm37fL8vXfE5oMVje6OFjcaE2lMMn0bJ4dW5Y/UW6Nsp325/uLqu8vDBDMl
3f2bH7tm68rJXo1gCwMyp73BmOHP7CV9UQrE8ATo2KggYqPrKZUayX4zt9CZhJdN
ryVOBUg0H+r7ad/HV7OyAXahKGYrs9mAiwKQQmkTPeuIyRx9k9uReOeM4utSERYv
pcTdBgsztBeX0lIEKVlBAOU1jkmV+YuR6nkn19eDaurM4Xw0x+drt9UAg3kjl7Zz
OZkbEfECuSb5FZV6OcEYBNyo1AgZFW9iH7xidQzl3J4jXClaU5hFF1PhSa7NS1fc
Flh9rYaEsFw3whI6PoJ+RcDWFbaM5TlU0gQcjJZDbYwRll3uY7q/v+DO0RaOrtUx
VU1baKTz4MBy7Sm6Xr9mTOzX8KNonAYgwLZ96nHbFIptxgoLT80DNxmUsmLP9rTE
fyrUYOy9LaI6yFVW3KC2l5umh2lb97GUsSYKWJPUiurCKSYcnjYrmiWvUU4pzX04
7Lisszs7Vv+7Hfpshc/9bvapwh35WTRT49CFgYUGbVN8PQTQNGd75wuiW2lI/BFm
k9INpAxEmRtu5gN8Am73EeFdP2uOe/P+wzu86TIlZa212NsBEMk=
=qxLx
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

