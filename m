Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8485EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 08:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F56A2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 08:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYXIJxcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F56A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieauT-0007fG-Gb
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 03:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ieato-00078c-7W
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ieatm-0006Fs-U3
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:29:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48137
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ieatm-0006Fj-Pm
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575966578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcMyK4IOa6/41nvg81B4lCm1hECzWTQ/P/XjN715egk=;
 b=bYXIJxcYHAZzmLfmaWmmchAdICNVY4htrr/R6SDQRqKFpOjjU2nUp84nmfPvD/DBTu6+gK
 D6SGa03V7mE4K1OadTaYIB4JkatKmGleOoR4QbYLmRyZl3EEj/M83xyKlloisK0WoWkfG0
 ro2Sj2+KiBIQFDR2yJTAwD3Y80Jdlr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-JAdTh2XYPdOpiMG0q2BfTw-1; Tue, 10 Dec 2019 03:29:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F319800EC0;
 Tue, 10 Dec 2019 08:29:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1888D6E504;
 Tue, 10 Dec 2019 08:29:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4EBD616E19; Tue, 10 Dec 2019 09:29:32 +0100 (CET)
Date: Tue, 10 Dec 2019 09:29:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 04/10] arm: allwinner-h3: add USB host controller
Message-ID: <20191210082932.teizmu3nco3ndjel@sirius.home.kraxel.org>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-5-nieklinnenbank@gmail.com>
 <4a900e8d-d803-5c58-5a4b-879cce5970b4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4a900e8d-d803-5c58-5a4b-879cce5970b4@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: JAdTh2XYPdOpiMG0q2BfTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 08:56:02AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> > The Allwinner H3 System on Chip contains multiple USB 2.0 bus
> > connections which provide software access using the Enhanced
> > Host Controller Interface (EHCI) and Open Host Controller
> > Interface (OHCI) interfaces. This commit adds support for
> > both interfaces in the Allwinner H3 System on Chip.
> >=20
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   hw/arm/allwinner-h3.c    | 20 ++++++++++++++++++++
> >   hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++
> >   hw/usb/hcd-ehci.h        |  1 +
>=20
> Cc'ing Gerd, the maintainer of these files.

Looks all reasonable.
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

(assuming this will be merged through arm tree not usb).

>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> >   3 files changed, 38 insertions(+)
> >=20
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index 5566e979ec..afeb49c0ac 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -26,6 +26,7 @@
> >   #include "hw/sysbus.h"
> >   #include "hw/arm/allwinner-h3.h"
> >   #include "hw/misc/unimp.h"
> > +#include "hw/usb/hcd-ehci.h"
> >   #include "sysemu/sysemu.h"
> >   static void aw_h3_init(Object *obj)
> > @@ -183,6 +184,25 @@ static void aw_h3_realize(DeviceState *dev, Error =
**errp)
> >       }
> >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, AW_H3_CCU_BASE);
> > +    /* Universal Serial Bus */
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
> > +                         s->irq[AW_H3_GIC_SPI_EHCI0]);
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI1_BASE,
> > +                         s->irq[AW_H3_GIC_SPI_EHCI1]);
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI2_BASE,
> > +                         s->irq[AW_H3_GIC_SPI_EHCI2]);
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI3_BASE,
> > +                         s->irq[AW_H3_GIC_SPI_EHCI3]);
> > +
> > +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI0_BASE,
> > +                         s->irq[AW_H3_GIC_SPI_OHCI0]);
> > +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI1_BASE,
> > +                         s->irq[AW_H3_GIC_SPI_OHCI1]);
> > +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI2_BASE,
> > +                         s->irq[AW_H3_GIC_SPI_OHCI2]);
> > +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI3_BASE,
> > +                         s->irq[AW_H3_GIC_SPI_OHCI3]);
> > +
> >       /* UART */
> >       if (serial_hd(0)) {
> >           serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
> > diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> > index 020211fd10..174c3446ef 100644
> > --- a/hw/usb/hcd-ehci-sysbus.c
> > +++ b/hw/usb/hcd-ehci-sysbus.c
> > @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info =
=3D {
> >       .class_init    =3D ehci_exynos4210_class_init,
> >   };
> > +static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
> > +{
> > +    SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +
> > +    sec->capsbase =3D 0x0;
> > +    sec->opregbase =3D 0x10;
> > +    set_bit(DEVICE_CATEGORY_USB, dc->categories);
> > +}
> > +
> > +static const TypeInfo ehci_aw_h3_type_info =3D {
> > +    .name          =3D TYPE_AW_H3_EHCI,
> > +    .parent        =3D TYPE_SYS_BUS_EHCI,
> > +    .class_init    =3D ehci_aw_h3_class_init,
> > +};
> > +
> >   static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
> >   {
> >       SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
> > @@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)
> >       type_register_static(&ehci_platform_type_info);
> >       type_register_static(&ehci_xlnx_type_info);
> >       type_register_static(&ehci_exynos4210_type_info);
> > +    type_register_static(&ehci_aw_h3_type_info);
> >       type_register_static(&ehci_tegra2_type_info);
> >       type_register_static(&ehci_ppc4xx_type_info);
> >       type_register_static(&ehci_fusbh200_type_info);
> > diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> > index 0298238f0b..edb59311c4 100644
> > --- a/hw/usb/hcd-ehci.h
> > +++ b/hw/usb/hcd-ehci.h
> > @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
> >   #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
> >   #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
> >   #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
> > +#define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
> >   #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
> >   #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
> >   #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
> >=20
>=20


