Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0722EC35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 19:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57792067C
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 19:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t61juFSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57792067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyKgV-0006XH-Uy
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 14:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyKfs-00060B-GI
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 14:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyKfq-0008Bv-Cs
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 14:12:52 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:33867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iyKfq-00084h-5b; Sun, 02 Feb 2020 14:12:50 -0500
Received: by mail-io1-xd41.google.com with SMTP id z193so14272346iof.1;
 Sun, 02 Feb 2020 11:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WE281d5ljjNya0jElG6lulRNZasLBxUVQgJBPJ/8SZE=;
 b=t61juFSG3DSqk7wCzDZPQ0dgR0V6Ef3wiILcV+/XV+ubSYXDRI9AWCIHuNvy1j3RBT
 LxYzd9A9bD0ExtnfNKi/pBLjatZwPvy5e1Zn/u7PZF8xDHSILTjKolHvrhb8f3YBUN/L
 6mDrRDNbYNx0Sb/WX+V6fTfV1K2KmBPMzN1E/e1xfpQtlYK+TX0qJ0EiND/4ZKjf3S50
 wJaHfuYqQSVj0gKnriWWaNV+XFZEUzzoTOCZBlHR19UfwOTvK/a1KBremIH87ZFdcdQJ
 6ZY4gJuqZXLhZ+ct7JohVH/6MhdYUxYyO5SaPCp7JasLUPHHnTpLLj3ysSgX8Ti15Vzj
 lk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WE281d5ljjNya0jElG6lulRNZasLBxUVQgJBPJ/8SZE=;
 b=XZTRpu2iXNJ7WYBQxn66Qy22YPe3pEfct/q6EV5GrHcOvA/PKUsQOJ1BsIUuC9mnvT
 jMXl5zTM9OAEOOc1BQ6jKi3DstuqUvF4wXTPO27t8HYgMwVeBQQ5csU7yqPKlWDrCW2w
 eu+0vW8AwzzqoN7OhBVZWh65hpo0AbKLJ+nRanXwbfi/7K6DyM9fceRyQWrtrKHebSX1
 x2hSfGTrI9G9RgFm2OiMDEzhkEmwRyj2eMuTwcZ5DoTIT7l/zwuMVFLGME58INkwq7mo
 zsbk0AILPp/Y99wtj4BpH0CYRB+Zq8p2oZihJnwO/WaFoEQYSwrzV3I+Tx4On+3EouGW
 wo5Q==
X-Gm-Message-State: APjAAAWyLFDaq8VDzC/LT1JvlHmyaGfQp3RfpnqS51+wrCvfwWDUiPQJ
 OZ/pKKLS6vlOT1eW1/MiIltXHKPLeuNKAZSYEE4=
X-Google-Smtp-Source: APXvYqxDwZvSBSn3zwnc2WI1/rTgWu0rMrTgLcz69qQr1p/ZETyN2daO/lilxgWhYyTvuyIc3OPUYJhyfGjLj0TlHIg=
X-Received: by 2002:a02:856a:: with SMTP id g97mr16426021jai.97.1580670768193; 
 Sun, 02 Feb 2020 11:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-5-nieklinnenbank@gmail.com>
 <39b5cc92-df42-50a4-72ba-10850aa00b04@redhat.com>
In-Reply-To: <39b5cc92-df42-50a4-72ba-10850aa00b04@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 2 Feb 2020 20:12:36 +0100
Message-ID: <CAPan3WoTQpm5-+Xp=6oKXtAYiVMV_+=0y+4-rg2-EH0A3i2Ytw@mail.gmail.com>
Subject: Re: [PATCH v4 04/20] hw/arm/allwinner-h3: add USB host controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a52783059d9c977c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jasowang@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 imammedo@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a52783059d9c977c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2020 at 7:37 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> > The Allwinner H3 System on Chip contains multiple USB 2.0 bus
> > connections which provide software access using the Enhanced
> > Host Controller Interface (EHCI) and Open Host Controller
> > Interface (OHCI) interfaces. This commit adds support for
> > both interfaces in the Allwinner H3 System on Chip.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   hw/usb/hcd-ehci.h             |  1 +
> >   include/hw/arm/allwinner-h3.h |  8 ++++++
> >   hw/arm/allwinner-h3.c         | 52 ++++++++++++++++++++++++++++++++--=
-
> >   hw/usb/hcd-ehci-sysbus.c      | 17 ++++++++++++
> >   4 files changed, 74 insertions(+), 4 deletions(-)
> >
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
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index abdc20871a..4f4dcbcd17 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -56,6 +56,14 @@ enum {
> >       AW_H3_SRAM_A1,
> >       AW_H3_SRAM_A2,
> >       AW_H3_SRAM_C,
> > +    AW_H3_EHCI0,
> > +    AW_H3_OHCI0,
> > +    AW_H3_EHCI1,
> > +    AW_H3_OHCI1,
> > +    AW_H3_EHCI2,
> > +    AW_H3_OHCI2,
> > +    AW_H3_EHCI3,
> > +    AW_H3_OHCI3,
> >       AW_H3_CCU,
> >       AW_H3_PIT,
> >       AW_H3_UART0,
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index 8df8e3e05e..f360625ee9 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -28,6 +28,7 @@
> >   #include "hw/sysbus.h"
> >   #include "hw/char/serial.h"
> >   #include "hw/misc/unimp.h"
> > +#include "hw/usb/hcd-ehci.h"
> >   #include "sysemu/sysemu.h"
> >   #include "hw/arm/allwinner-h3.h"
> >
> > @@ -36,6 +37,14 @@ const hwaddr allwinner_h3_memmap[] =3D {
> >       [AW_H3_SRAM_A1]    =3D 0x00000000,
> >       [AW_H3_SRAM_A2]    =3D 0x00044000,
> >       [AW_H3_SRAM_C]     =3D 0x00010000,
> > +    [AW_H3_EHCI0]      =3D 0x01c1a000,
> > +    [AW_H3_OHCI0]      =3D 0x01c1a400,
> > +    [AW_H3_EHCI1]      =3D 0x01c1b000,
> > +    [AW_H3_OHCI1]      =3D 0x01c1b400,
> > +    [AW_H3_EHCI2]      =3D 0x01c1c000,
> > +    [AW_H3_OHCI2]      =3D 0x01c1c400,
> > +    [AW_H3_EHCI3]      =3D 0x01c1d000,
> > +    [AW_H3_OHCI3]      =3D 0x01c1d400,
> >       [AW_H3_CCU]        =3D 0x01c20000,
> >       [AW_H3_PIT]        =3D 0x01c20c00,
> >       [AW_H3_UART0]      =3D 0x01c28000,
> > @@ -73,10 +82,10 @@ struct AwH3Unimplemented {
> >       { "msgbox",    0x01c17000, 4 * KiB },
> >       { "spinlock",  0x01c18000, 4 * KiB },
> >       { "usb0-otg",  0x01c19000, 4 * KiB },
> > -    { "usb0",      0x01c1a000, 4 * KiB },
> > -    { "usb1",      0x01c1b000, 4 * KiB },
> > -    { "usb2",      0x01c1c000, 4 * KiB },
> > -    { "usb3",      0x01c1d000, 4 * KiB },
> > +    { "usb0-phy",  0x01c1a000, 4 * KiB },
> > +    { "usb1-phy",  0x01c1b000, 4 * KiB },
> > +    { "usb2-phy",  0x01c1c000, 4 * KiB },
> > +    { "usb3-phy",  0x01c1d000, 4 * KiB },
>
> As in v3 comment, this can be done in patch #1.
>

OK, I'll rename them in patch 1, so it won't show up here.


>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Thanks for reviewing and testing Philippe!
Regards,
Niek


>
> >       { "smc",       0x01c1e000, 4 * KiB },
> >       { "pio",       0x01c20800, 1 * KiB },
> >       { "owa",       0x01c21000, 1 * KiB },
> > @@ -144,6 +153,14 @@ enum {
> >       AW_H3_GIC_SPI_UART3     =3D  3,
> >       AW_H3_GIC_SPI_TIMER0    =3D 18,
> >       AW_H3_GIC_SPI_TIMER1    =3D 19,
> > +    AW_H3_GIC_SPI_EHCI0     =3D 72,
> > +    AW_H3_GIC_SPI_OHCI0     =3D 73,
> > +    AW_H3_GIC_SPI_EHCI1     =3D 74,
> > +    AW_H3_GIC_SPI_OHCI1     =3D 75,
> > +    AW_H3_GIC_SPI_EHCI2     =3D 76,
> > +    AW_H3_GIC_SPI_OHCI2     =3D 77,
> > +    AW_H3_GIC_SPI_EHCI3     =3D 78,
> > +    AW_H3_GIC_SPI_OHCI3     =3D 79,
> >   };
> >
> >   /* Allwinner H3 general constants */
> > @@ -284,6 +301,33 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
> >       qdev_init_nofail(DEVICE(&s->ccu));
> >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU])=
;
> >
> > +    /* Universal Serial Bus */
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
> > +                         qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                          AW_H3_GIC_SPI_EHCI0));
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI1],
> > +                         qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                          AW_H3_GIC_SPI_EHCI1));
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI2],
> > +                         qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                          AW_H3_GIC_SPI_EHCI2));
> > +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI3],
> > +                         qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                          AW_H3_GIC_SPI_EHCI3));
> > +
> > +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI0],
> > +                         qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                          AW_H3_GIC_SPI_OHCI0));
> > +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI1],
> > +                         qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                          AW_H3_GIC_SPI_OHCI1));
> > +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI2],
> > +                         qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                          AW_H3_GIC_SPI_OHCI2));
> > +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI3],
> > +                         qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                          AW_H3_GIC_SPI_OHCI3));
> > +
> >       /* UART0. For future clocktree API: All UARTS are connected to
> APB2_CLK. */
> >       serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
> >                      qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_UART0),
> > diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> > index 020211fd10..174c3446ef 100644
> > --- a/hw/usb/hcd-ehci-sysbus.c
> > +++ b/hw/usb/hcd-ehci-sysbus.c
> > @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info =
=3D {
> >       .class_init    =3D ehci_exynos4210_class_init,
> >   };
> >
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
> >
>
>

--=20
Niek Linnenbank

--000000000000a52783059d9c977c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 19, 2020 at 7:37 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 1/19/20 1:50 AM, Niek Linnenbank wrote:<br>
&gt; The Allwinner H3 System on Chip contains multiple USB 2.0 bus<br>
&gt; connections which provide software access using the Enhanced<br>
&gt; Host Controller Interface (EHCI) and Open Host Controller<br>
&gt; Interface (OHCI) interfaces. This commit adds support for<br>
&gt; both interfaces in the Allwinner H3 System on Chip.<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" ta=
rget=3D"_blank">kraxel@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-ehci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h |=C2=A0 8 ++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 5=
2 ++++++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-ehci-sysbus.c=C2=A0 =C2=A0 =C2=A0 | 17 ++++++++=
++++<br>
&gt;=C2=A0 =C2=A04 files changed, 74 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h<br>
&gt; index 0298238f0b..edb59311c4 100644<br>
&gt; --- a/hw/usb/hcd-ehci.h<br>
&gt; +++ b/hw/usb/hcd-ehci.h<br>
&gt; @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {<br>
&gt;=C2=A0 =C2=A0#define TYPE_SYS_BUS_EHCI &quot;sysbus-ehci-usb&quot;<br>
&gt;=C2=A0 =C2=A0#define TYPE_PLATFORM_EHCI &quot;platform-ehci-usb&quot;<b=
r>
&gt;=C2=A0 =C2=A0#define TYPE_EXYNOS4210_EHCI &quot;exynos4210-ehci-usb&quo=
t;<br>
&gt; +#define TYPE_AW_H3_EHCI &quot;aw-h3-ehci-usb&quot;<br>
&gt;=C2=A0 =C2=A0#define TYPE_TEGRA2_EHCI &quot;tegra2-ehci-usb&quot;<br>
&gt;=C2=A0 =C2=A0#define TYPE_PPC4xx_EHCI &quot;ppc4xx-ehci-usb&quot;<br>
&gt;=C2=A0 =C2=A0#define TYPE_FUSBH200_EHCI &quot;fusbh200-ehci-usb&quot;<b=
r>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index abdc20871a..4f4dcbcd17 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -56,6 +56,14 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_A1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_A2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_C,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_EHCI0,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_OHCI0,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_EHCI1,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_OHCI1,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_EHCI2,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_OHCI2,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_EHCI3,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_OHCI3,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_CCU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_PIT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_UART0,<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index 8df8e3e05e..f360625ee9 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -28,6 +28,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/sysbus.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/char/serial.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/unimp.h&quot;<br>
&gt; +#include &quot;hw/usb/hcd-ehci.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/arm/allwinner-h3.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -36,6 +37,14 @@ const hwaddr allwinner_h3_memmap[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_A1]=C2=A0 =C2=A0 =3D 0x00000000,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00044000,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0x0001=
0000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_EHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_OHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a400,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_EHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_OHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b400,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_EHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1c000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_OHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1c400,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_EHCI3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1d000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_OHCI3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1d400,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_CCU]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x01c20000,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_PIT]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x01c20c00,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_UART0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c2=
8000,<br>
&gt; @@ -73,10 +82,10 @@ struct AwH3Unimplemented {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;msgbox&quot;,=C2=A0 =C2=A0 0x01c1700=
0, 4 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;spinlock&quot;,=C2=A0 0x01c18000, 4 =
* KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;usb0-otg&quot;,=C2=A0 0x01c19000, 4 =
* KiB },<br>
&gt; -=C2=A0 =C2=A0 { &quot;usb0&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c1a000, 4 *=
 KiB },<br>
&gt; -=C2=A0 =C2=A0 { &quot;usb1&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c1b000, 4 *=
 KiB },<br>
&gt; -=C2=A0 =C2=A0 { &quot;usb2&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c1c000, 4 *=
 KiB },<br>
&gt; -=C2=A0 =C2=A0 { &quot;usb3&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c1d000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;usb0-phy&quot;,=C2=A0 0x01c1a000, 4 * KiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;usb1-phy&quot;,=C2=A0 0x01c1b000, 4 * KiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;usb2-phy&quot;,=C2=A0 0x01c1c000, 4 * KiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;usb3-phy&quot;,=C2=A0 0x01c1d000, 4 * KiB },<br=
>
<br>
As in v3 comment, this can be done in patch #1.<br></blockquote><div><br></=
div><div>OK, I&#39;ll rename them in patch 1, so it won&#39;t show up here.=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div><br><=
/div><div>Thanks for reviewing and testing Philippe!</div><div>Regards,</di=
v><div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;smc&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x01c1e000, 4 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;pio&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x01c20800, 1 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;owa&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x01c21000, 1 * KiB },<br>
&gt; @@ -144,6 +153,14 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_GIC_SPI_UART3=C2=A0 =C2=A0 =C2=A0=3D=
=C2=A0 3,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_GIC_SPI_TIMER0=C2=A0 =C2=A0 =3D 18,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_GIC_SPI_TIMER1=C2=A0 =C2=A0 =3D 19,<br=
>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_EHCI0=C2=A0 =C2=A0 =C2=A0=3D 72,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_OHCI0=C2=A0 =C2=A0 =C2=A0=3D 73,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_EHCI1=C2=A0 =C2=A0 =C2=A0=3D 74,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_OHCI1=C2=A0 =C2=A0 =C2=A0=3D 75,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_EHCI2=C2=A0 =C2=A0 =C2=A0=3D 76,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_OHCI2=C2=A0 =C2=A0 =C2=A0=3D 77,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_EHCI3=C2=A0 =C2=A0 =C2=A0=3D 78,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_OHCI3=C2=A0 =C2=A0 =C2=A0=3D 79,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* Allwinner H3 general constants */<br>
&gt; @@ -284,6 +301,33 @@ static void allwinner_h3_realize(DeviceState *dev=
, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(DEVICE(&amp;s-&gt;ccu));<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;cc=
u), 0, s-&gt;memmap[AW_H3_CCU]);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* Universal Serial Bus */<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_EHCI0],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AW_H3_GIC_SPI_EHCI0));<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_EHCI1],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AW_H3_GIC_SPI_EHCI1));<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_EHCI2],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AW_H3_GIC_SPI_EHCI2));<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H=
3_EHCI3],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AW_H3_GIC_SPI_EHCI3));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_OHCI0],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AW_H3_GIC_SPI_OHCI0));<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_OHCI1],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AW_H3_GIC_SPI_OHCI1));<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_OHCI2],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AW_H3_GIC_SPI_OHCI2));<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;mem=
map[AW_H3_OHCI3],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AW_H3_GIC_SPI_OHCI3));<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* UART0. For future clocktree API: All UART=
S are connected to APB2_CLK. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0serial_mm_init(get_system_memory(), s-&gt;me=
mmap[AW_H3_UART0], 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART0),<br>
&gt; diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c<br>
&gt; index 020211fd10..174c3446ef 100644<br>
&gt; --- a/hw/usb/hcd-ehci-sysbus.c<br>
&gt; +++ b/hw/usb/hcd-ehci-sysbus.c<br>
&gt; @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D ehci_exynos4210=
_class_init,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sec-&gt;capsbase =3D 0x0;<br>
&gt; +=C2=A0 =C2=A0 sec-&gt;opregbase =3D 0x10;<br>
&gt; +=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_USB, dc-&gt;categories);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo ehci_aw_h3_type_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_H3_=
EHCI,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_EHC=
I,<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D ehci_aw_h3_class_init,<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void ehci_tegra2_class_init(ObjectClass *oc, void *=
data)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(=
oc);<br>
&gt; @@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_platform_type=
_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_xlnx_type_inf=
o);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_exynos4210_ty=
pe_info);<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;ehci_aw_h3_type_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_tegra2_type_i=
nfo);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_ppc4xx_type_i=
nfo);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_fusbh200_type=
_info);<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000a52783059d9c977c--

