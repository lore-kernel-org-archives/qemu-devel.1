Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B64C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFCA20795
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BO5jSYfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFCA20795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTDjC-0001uR-GO
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 20:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDde-0004mO-Fq; Thu, 15 Oct 2020 20:30:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51689 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDda-0000E8-EV; Thu, 15 Oct 2020 20:30:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CC6Vx38msz9sTs; Fri, 16 Oct 2020 11:30:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602808217;
 bh=0KpTyPni7dthY43ZMLgfsGbxZf4T37Nhhu8J+0/hi5o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BO5jSYfQYYVxmWw4vWPuPD6zkPun7UHolJOqjJp9Af0TOktUVws3XwkF4+vvUdKDv
 rGXUct6DoVE+NAR8A+uHUkecOUk8aPTTWZIFaVnbwLQD9tR6/yP+0o7xdX+qJqCnx6
 bspyAOJF6NfnReVgCrAIvkJVci8fk4lY3z2lnCp0=
Date: Fri, 16 Oct 2020 11:30:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 3/3] uninorth: use qdev gpios for PCI IRQs
Message-ID: <20201016003010.GE7078@yekko.fritz.box>
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-4-mark.cave-ayland@ilande.co.uk>
 <f8df313a-24ae-5544-e1a8-32cb7729f680@eik.bme.hu>
 <f5ca9c69-c946-7f2e-0fc6-92a3136e63d1@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <f5ca9c69-c946-7f2e-0fc6-92a3136e63d1@ilande.co.uk>
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 05:58:52PM +0100, Mark Cave-Ayland wrote:
> On 13/10/2020 14:38, BALATON Zoltan via wrote:
>=20
> > On Tue, 13 Oct 2020, Mark Cave-Ayland wrote:
> > > Currently an object link property is used to pass a reference to the =
OpenPIC
> > > into the PCI host bridge so that pci_unin_init_irqs() can connect the=
 PCI
> > > IRQs to the PIC itself.
> > >=20
> > > This can be simplified by defining the PCI IRQs as qdev gpios and the=
n wiring
> > > up the PCI IRQs to the PIC in the New World machine init function.
> > >=20
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > ---
> > > hw/pci-host/uninorth.c=A0=A0=A0=A0=A0=A0=A0=A0 | 45 +++++++----------=
-----------------
> > > hw/ppc/mac_newworld.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 24 ++++++++++++---=
---
> > > include/hw/pci-host/uninorth.h |=A0 2 --
> > > 3 files changed, 25 insertions(+), 46 deletions(-)
> > >=20
> > > diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> > > index 1ed1072eeb..0c0a9ecee1 100644
> > > --- a/hw/pci-host/uninorth.c
> > > +++ b/hw/pci-host/uninorth.c
> > > @@ -32,8 +32,6 @@
> > > #include "hw/pci-host/uninorth.h"
> > > #include "trace.h"
> > >=20
> > > -static const int unin_irq_line[] =3D { 0x1b, 0x1c, 0x1d, 0x1e };
> > > -
> > > static int pci_unin_map_irq(PCIDevice *pci_dev, int irq_num)
> > > {
> > > =A0=A0=A0 return (irq_num + (pci_dev->devfn >> 3)) & 3;
> > > @@ -43,7 +41,7 @@ static void pci_unin_set_irq(void *opaque, int irq_=
num, int level)
> > > {
> > > =A0=A0=A0 UNINHostState *s =3D opaque;
> > >=20
> > > -=A0=A0=A0 trace_unin_set_irq(unin_irq_line[irq_num], level);
> > > +=A0=A0=A0 trace_unin_set_irq(irq_num, level);
> > > =A0=A0=A0 qemu_set_irq(s->irqs[irq_num], level);
> > > }
> > >=20
> > > @@ -112,15 +110,6 @@ static const MemoryRegionOps unin_data_ops =3D {
> > > =A0=A0=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
> > > };
> > >=20
> > > -static void pci_unin_init_irqs(UNINHostState *s)
> > > -{
> > > -=A0=A0=A0 int i;
> > > -
> > > -=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(s->irqs); i++) {
> > > -=A0=A0=A0=A0=A0=A0=A0 s->irqs[i] =3D qdev_get_gpio_in(DEVICE(s->pic)=
, unin_irq_line[i]);
> > > -=A0=A0=A0 }
> > > -}
> > > -
> > > static char *pci_unin_main_ofw_unit_address(const SysBusDevice *dev)
> > > {
> > > =A0=A0=A0 UNINHostState *s =3D UNI_NORTH_PCI_HOST_BRIDGE(dev);
> > > @@ -141,7 +130,6 @@ static void pci_unin_main_realize(DeviceState *de=
v, Error **errp)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> > >=20
> > > =A0=A0=A0 pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-pci"=
);
> > > -=A0=A0=A0 pci_unin_init_irqs(s);
> > >=20
> > > =A0=A0=A0 /* DEC 21154 bridge */
> > > #if 0
> > > @@ -172,15 +160,12 @@ static void pci_unin_main_init(Object *obj)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 "unin-pci-hole", &s->pci_mmio,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x80000000ULL, 0x10000000ULL);
> > >=20
> > > -=A0=A0=A0 object_property_add_link(obj, "pic", TYPE_OPENPIC,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (Object **) &s->pic,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 qdev_prop_allow_set_link_before_realize,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0);
> > > -
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &h->conf_mem);
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &h->data_mem);
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &s->pci_hole);
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &s->pci_io);
> > > +
> > > +=A0=A0=A0 qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irq=
s));
> > > }
> > >=20
> > > static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
> > > @@ -196,7 +181,6 @@ static void pci_u3_agp_realize(DeviceState *dev, =
Error **errp)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> > >=20
> > > =A0=A0=A0 pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
> > > -=A0=A0=A0 pci_unin_init_irqs(s);
> > > }
> > >=20
> > > static void pci_u3_agp_init(Object *obj)
> > > @@ -220,15 +204,12 @@ static void pci_u3_agp_init(Object *obj)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 "unin-pci-hole", &s->pci_mmio,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x80000000ULL, 0x70000000ULL);
> > >=20
> > > -=A0=A0=A0 object_property_add_link(obj, "pic", TYPE_OPENPIC,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (Object **) &s->pic,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 qdev_prop_allow_set_link_before_realize,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0);
> > > -
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &h->conf_mem);
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &h->data_mem);
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &s->pci_hole);
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &s->pci_io);
> > > +
> > > +=A0=A0=A0 qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irq=
s));
> > > }
> > >=20
> > > static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
> > > @@ -244,7 +225,6 @@ static void pci_unin_agp_realize(DeviceState *dev=
, Error **errp)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> > >=20
> > > =A0=A0=A0 pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp"=
);
> > > -=A0=A0=A0 pci_unin_init_irqs(s);
> > > }
> > >=20
> > > static void pci_unin_agp_init(Object *obj)
> > > @@ -259,13 +239,10 @@ static void pci_unin_agp_init(Object *obj)
> > > =A0=A0=A0 memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_da=
ta_le_ops,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 obj, "unin-agp-conf-data", 0x1000);
> > >=20
> > > -=A0=A0=A0 object_property_add_link(obj, "pic", TYPE_OPENPIC,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (Object **) &s->pic,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 qdev_prop_allow_set_link_before_realize,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0);
> > > -
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &h->conf_mem);
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &h->data_mem);
> > > +
> > > +=A0=A0=A0 qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irq=
s));
> > > }
> > >=20
> > > static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
> > > @@ -281,7 +258,6 @@ static void
> > > pci_unin_internal_realize(DeviceState *dev, Error **errp)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
> > >=20
> > > =A0=A0=A0 pci_create_simple(h->bus, PCI_DEVFN(14, 0), "uni-north-inte=
rnal-pci");
> > > -=A0=A0=A0 pci_unin_init_irqs(s);
> > > }
> > >=20
> > > static void pci_unin_internal_init(Object *obj)
> > > @@ -296,13 +272,10 @@ static void pci_unin_internal_init(Object *obj)
> > > =A0=A0=A0 memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_da=
ta_le_ops,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 obj, "unin-pci-conf-data", 0x1000);
> > >=20
> > > -=A0=A0=A0 object_property_add_link(obj, "pic", TYPE_OPENPIC,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (Object **) &s->pic,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 qdev_prop_allow_set_link_before_realize,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0);
> > > -
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &h->conf_mem);
> > > =A0=A0=A0 sysbus_init_mmio(sbd, &h->data_mem);
> > > +
> > > +=A0=A0=A0 qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irq=
s));
> > > }
> > >=20
> > > static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
> > > diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> > > index 6f5ef2e782..7a8dc09c8d 100644
> > > --- a/hw/ppc/mac_newworld.c
> > > +++ b/hw/ppc/mac_newworld.c
> > > @@ -303,8 +303,6 @@ static void ppc_core99_init(MachineState *machine)
> > > =A0=A0=A0=A0=A0=A0=A0 /* 970 gets a U3 bus */
> > > =A0=A0=A0=A0=A0=A0=A0 /* Uninorth AGP bus */
> > > =A0=A0=A0=A0=A0=A0=A0 dev =3D qdev_new(TYPE_U3_AGP_HOST_BRIDGE);
> > > -=A0=A0=A0=A0=A0=A0=A0 object_property_set_link(OBJECT(dev), "pic", O=
BJECT(pic_dev),
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &error_abort);
> > > =A0=A0=A0=A0=A0=A0=A0 sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &=
error_fatal);
> > > =A0=A0=A0=A0=A0=A0=A0 uninorth_pci =3D U3_AGP_HOST_BRIDGE(dev);
> > > =A0=A0=A0=A0=A0=A0=A0 s =3D SYS_BUS_DEVICE(dev);
> > > @@ -317,32 +315,38 @@ static void ppc_core99_init(MachineState *machi=
ne)
> > > =A0=A0=A0=A0=A0=A0=A0 sysbus_mmio_map(s, 0, 0xf0800000);
> > > =A0=A0=A0=A0=A0=A0=A0 sysbus_mmio_map(s, 1, 0xf0c00000);
> > >=20
> > > +=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < 4; i++) {
> >=20
> > Philippe had a series that replaced all these with PCI_NUM_IRQS or
> > similar constant. Should you use that instead in new additions?
>=20
> I'm not sure that's directly relevant here - my understanding was that
> PCI_NUM_IRQS represents the number of IRQs on the device, not the PCI host
> bridge. Certainly it could be argued that there is a 1:1 correspondence in
> this case, however I don't have any documentation to support this so it
> doesn't feel right to make these values directly equivalent.

I think it's the same thing.  On legacy PCI there are 4 interrupt
lines (INTA..INTD).  Each device can use any or all of those (though
they usually only use one per function in practice).  Bridges swizzle
which pins on the downstream bus are wired to which pins on the
upstream bus, but there's still just 4 of them all the way up to the
host bridge, which will then wire those 4 up to system PIC lines one
way or another.

On-board devices often have (had?) a sideband interrupt wired directly
to the PIC, rather than using one of the bus lines.

> > This is probably not modelled faithfuly (the whole mac99 machine is a
> > hack to get the most OSes run, not emulating an actual machine) but I
> > wonder if it's correct to connect all these irqs for all the different
> > busses to the same pic lines? Is that how it is on a real PowerMac3,1?
> > (This is just a question not something that should be fixed in this
> > patch which is a nice clean up anyway, this just made it more obvious to
> > me what's happening so maybe we can find out a difference in emulation
> > compared to real hardware that could be fixed in the future.)
>=20
> Yeah I spotted that too when I was writing the patch. In its current form=
 it
> keeps the existing behaviour as-is, but this is something that may be wor=
th
> investigating later. I'm not aware of any documentation explaining how the
> PCI/AGP bridges are wired up on a Mac, so it might end up being a case of
> trawling through driver source code to try and get some answers...

It's worth checking, but having them all wired together isn't that
implausible.  In that pre-MSI era some weird wirings and heavily
shared irq lines are pretty common.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+I6ZIACgkQbDjKyiDZ
s5KMKBAAsrc4wlsmMIFiumU6D+gyWRje/lyy4KBGiC3kl97tirklSs4eXP7A0TsH
a4uhoFRpGeWqrQEYPs++U6ZwS1gIUc0HgMzun+kf0FIdNWyJrrSaZPjqPEduGVCU
unG9vzGKlXATR2LsJ2HzHzMk7p4sNSgiWL8wEycXhI5pVZp4R+Pjo+bf46WazKLD
R72bVafpJMvZJ+ylenrncjF4C0mpnr4PDCnTa/fmd1iiwvMJaZplILOvsUSC2e1M
Y40LQfQImh87OnuOH7f4TMUPcSucxdWmVbNUKbZsDafRRhoPjj3RdI2x01rBb2sk
QGDC5QhCmnFRjgUGu4AdWrNWkkfsQVQpraLcpinMpaJXEMC1MgCyk+k7m21ELOCZ
bu96iEtIZE1X3AhsY4KShBJpmB3oZpMoyqs3ErczaoupynaQFxz8jtcxRUjdOUHd
4VMQW3hQKnaXaPBQRzNYGXzY/Y7VSWrljILGQSlOPV4oFDuSG+RYPuyceHNDIonL
UKMQymTPar/AbRLgLP+ObSRv7l24I6upJU2IPCxk8/MEdRXm7P/CuKIK/x0Wx1KS
mpSyDyKLk0MkP+bfsriwh1NhaH4HO07GNCyh0xJj8d+PInH5pzNRwvnolBeiGf8K
W0s1+hPWQDcviXpxMPfWdLcqYznYUxhxKTY+NrdRxciwzw4Sops=
=gH7h
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--

