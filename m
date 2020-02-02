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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6BAC35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 19:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E996E20679
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 19:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhVklo+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E996E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyL1A-0003py-4G
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 14:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyL0A-0003Jx-Ow
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 14:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyL05-00026M-18
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 14:33:50 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:40144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iyL04-00024v-Os; Sun, 02 Feb 2020 14:33:44 -0500
Received: by mail-io1-xd43.google.com with SMTP id x1so14270851iop.7;
 Sun, 02 Feb 2020 11:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ldx6HfUnBklk5639mDL1pXWwZFumtXR+KTfzxnWQ//Q=;
 b=fhVklo+doAGcW0tsh5Aqi+Sd2DhseIINU3pUHYemzIw0PJgWXpajgMtndsSsBehNp0
 KpFF+ttRvIfLCD2OFcPS1d9KUsKmxHvyaRQqEY79OZoGCmA/AB3Ee6Rjp2r0sfGq+LfU
 7ibOBT33jJotm4NlcYfzJkLgBtpYmsPuFXTSnBxMKvy2kEkbeyUat5CMdp86nGram6uS
 XGYiXcHFhVdUIPyq9AEKjQa3GVOvb1lQkWK53leGsa1Mq2WlJMDcU/2qbsgYOWYD2TiN
 vqHQlnmdw6lvB9zIppxIkaGza9b75mMx16Fwo8bDAls31YhBgqDmwwMqvGMh2g1ju96p
 U4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ldx6HfUnBklk5639mDL1pXWwZFumtXR+KTfzxnWQ//Q=;
 b=pvbFLloqlstQrkZACl0b1RIpi1Fz/B7PyGYhfRnyC1QJv8LmC4uXGagkOrwk5UY/4N
 xi7r7WkEVpGhXL6wsqT6CGWrO5gBIXFVTD7XMwysGi0zfhkHl+THog9KtMBGKuu7Y6kc
 4z55GvBd+5zN2Epn39s+Bf+UqTbWhVM8L75SvU2gyqtq2rItYihIWF44BXMMRS0Wf97P
 +jJPp5DZLyx8bZehhr6iKH/XR9kHIbSMD0AelPGnMsFopjlYLCTudu56WhVO/hzMwqb6
 6EeIfwnM6jRDy+R0+zUlFwlx92Tx/QXdKszCG97O1lLgP58CGrRbKAwq3U6yKO3NI03n
 xpqg==
X-Gm-Message-State: APjAAAUTGp+9sekCVLfHHQd9viipkVXxrTOOCSlKAxATZWuPHIlJYcNE
 3FGJbv4qOYFLu7oh0Ylb0V9pbQi3zEetnozWHg8=
X-Google-Smtp-Source: APXvYqwuZraswCufeZIj1ghyjYX86k6H9o7NMTfeiztjSnGlYxhiT1EJOWTnN7S4KYwp5vVn4uCOOXWRNWlti7wyxF0=
X-Received: by 2002:a02:856a:: with SMTP id g97mr16469784jai.97.1580672023520; 
 Sun, 02 Feb 2020 11:33:43 -0800 (PST)
MIME-Version: 1.0
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-5-nieklinnenbank@gmail.com>
 <39b5cc92-df42-50a4-72ba-10850aa00b04@redhat.com>
 <851e2620-82f8-b911-7641-f1690238cc2a@redhat.com>
In-Reply-To: <851e2620-82f8-b911-7641-f1690238cc2a@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 2 Feb 2020 20:33:32 +0100
Message-ID: <CAPan3WqamSU7GdTQ5q-Z2KqBpZBTy3CE0p0MUW2zWOe7dKseTA@mail.gmail.com>
Subject: Re: [PATCH v4 04/20] hw/arm/allwinner-h3: add USB host controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000077ed04059d9ce2fc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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

--00000000000077ed04059d9ce2fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2020 at 7:44 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 1/19/20 7:37 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> >> The Allwinner H3 System on Chip contains multiple USB 2.0 bus
> >> connections which provide software access using the Enhanced
> >> Host Controller Interface (EHCI) and Open Host Controller
> >> Interface (OHCI) interfaces. This commit adds support for
> >> both interfaces in the Allwinner H3 System on Chip.
> >>
> >> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> >> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> >> ---
> >>   hw/usb/hcd-ehci.h             |  1 +
> >>   include/hw/arm/allwinner-h3.h |  8 ++++++
> >>   hw/arm/allwinner-h3.c         | 52 ++++++++++++++++++++++++++++++++-=
--
> >>   hw/usb/hcd-ehci-sysbus.c      | 17 ++++++++++++
> >>   4 files changed, 74 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> >> index 0298238f0b..edb59311c4 100644
> >> --- a/hw/usb/hcd-ehci.h
> >> +++ b/hw/usb/hcd-ehci.h
> >> @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
> >>   #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
> >>   #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
> >>   #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
> >> +#define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
> >>   #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
> >>   #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
> >>   #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
> >> diff --git a/include/hw/arm/allwinner-h3.h
> >> b/include/hw/arm/allwinner-h3.h
> >> index abdc20871a..4f4dcbcd17 100644
> >> --- a/include/hw/arm/allwinner-h3.h
> >> +++ b/include/hw/arm/allwinner-h3.h
> >> @@ -56,6 +56,14 @@ enum {
> >>       AW_H3_SRAM_A1,
> >>       AW_H3_SRAM_A2,
> >>       AW_H3_SRAM_C,
> >> +    AW_H3_EHCI0,
> >> +    AW_H3_OHCI0,
> >> +    AW_H3_EHCI1,
> >> +    AW_H3_OHCI1,
> >> +    AW_H3_EHCI2,
> >> +    AW_H3_OHCI2,
> >> +    AW_H3_EHCI3,
> >> +    AW_H3_OHCI3,
> >>       AW_H3_CCU,
> >>       AW_H3_PIT,
> >>       AW_H3_UART0,
> >> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> >> index 8df8e3e05e..f360625ee9 100644
> >> --- a/hw/arm/allwinner-h3.c
> >> +++ b/hw/arm/allwinner-h3.c
> >> @@ -28,6 +28,7 @@
> >>   #include "hw/sysbus.h"
> >>   #include "hw/char/serial.h"
> >>   #include "hw/misc/unimp.h"
> >> +#include "hw/usb/hcd-ehci.h"
> >>   #include "sysemu/sysemu.h"
> >>   #include "hw/arm/allwinner-h3.h"
> >> @@ -36,6 +37,14 @@ const hwaddr allwinner_h3_memmap[] =3D {
> >>       [AW_H3_SRAM_A1]    =3D 0x00000000,
> >>       [AW_H3_SRAM_A2]    =3D 0x00044000,
> >>       [AW_H3_SRAM_C]     =3D 0x00010000,
> >> +    [AW_H3_EHCI0]      =3D 0x01c1a000,
> >> +    [AW_H3_OHCI0]      =3D 0x01c1a400,
> >> +    [AW_H3_EHCI1]      =3D 0x01c1b000,
> >> +    [AW_H3_OHCI1]      =3D 0x01c1b400,
> >> +    [AW_H3_EHCI2]      =3D 0x01c1c000,
> >> +    [AW_H3_OHCI2]      =3D 0x01c1c400,
> >> +    [AW_H3_EHCI3]      =3D 0x01c1d000,
> >> +    [AW_H3_OHCI3]      =3D 0x01c1d400,
> >>       [AW_H3_CCU]        =3D 0x01c20000,
> >>       [AW_H3_PIT]        =3D 0x01c20c00,
> >>       [AW_H3_UART0]      =3D 0x01c28000,
> >> @@ -73,10 +82,10 @@ struct AwH3Unimplemented {
> >>       { "msgbox",    0x01c17000, 4 * KiB },
> >>       { "spinlock",  0x01c18000, 4 * KiB },
> >>       { "usb0-otg",  0x01c19000, 4 * KiB },
> >> -    { "usb0",      0x01c1a000, 4 * KiB },
> >> -    { "usb1",      0x01c1b000, 4 * KiB },
> >> -    { "usb2",      0x01c1c000, 4 * KiB },
> >> -    { "usb3",      0x01c1d000, 4 * KiB },
> >> +    { "usb0-phy",  0x01c1a000, 4 * KiB },
> >> +    { "usb1-phy",  0x01c1b000, 4 * KiB },
> >> +    { "usb2-phy",  0x01c1c000, 4 * KiB },
> >> +    { "usb3-phy",  0x01c1d000, 4 * KiB },
> >
> > As in v3 comment, this can be done in patch #1.
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Err, this patch is incomplete, when using ./configure
> --without-default-devices:
>
> $ qemu-system-arm -M orangepi-pc
> qemu-system-arm: invalid accelerator kvm
> qemu-system-arm: falling back to tcg
> qemu-system-arm: Unknown device 'aw-h3-ehci-usb' for default sysbus
> qemu-system-arm: Unknown device 'sysbus-ohci' for default sysbus
> Aborted (core dumped)
>

Thanks for pointing this out, I was not aware at all that the
--without-default-devices option existed.
It's not in the configure --help message also.

I tried to re-produce the error by running:
$ ./configure --target-list=3Darm-softmmu --without-default-devices; make -=
j5
$ ./arm-softmmu/qemu-system-arm -M orangepi-pc

On my laptop it didn't give the error, I think because somehow the build
system did select
the USB config items (even tho they were missing for the ALLWINNER_H3 item
in hw/arm/Kconfig):

$ grep USB arm-softmmu/config-devices.mak
CONFIG_TUSB6010=3Dy
CONFIG_USB=3Dy
CONFIG_USB_EHCI=3Dy
CONFIG_USB_EHCI_SYSBUS=3Dy
CONFIG_USB_MUSB=3Dy
CONFIG_USB_OHCI=3Dy

Is there any other option you used in addition to --without-default-devices
to trigger the error?
I also searched for something in configure to select/filter on machines to
build, but I don't see that yet.

Nevertheless I will surely add the fix below to the patch.

Regards,
Niek



> You need to amend:
>
> -- >8 --
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index bb75c1de17..57b29cc522 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -302,6 +302,8 @@ config ALLWINNER_H3
>       select ARM_TIMER
>       select ARM_GIC
>       select UNIMP
> +    select USB_OHCI
> +    select USB_EHCI_SYSBUS
>
>   config RASPI
>       bool
> ---
>
> R/T-b tags can stay with this amended.
>
> >>       { "smc",       0x01c1e000, 4 * KiB },
> >>       { "pio",       0x01c20800, 1 * KiB },
> >>       { "owa",       0x01c21000, 1 * KiB },
> >> @@ -144,6 +153,14 @@ enum {
> >>       AW_H3_GIC_SPI_UART3     =3D  3,
> >>       AW_H3_GIC_SPI_TIMER0    =3D 18,
> >>       AW_H3_GIC_SPI_TIMER1    =3D 19,
> >> +    AW_H3_GIC_SPI_EHCI0     =3D 72,
> >> +    AW_H3_GIC_SPI_OHCI0     =3D 73,
> >> +    AW_H3_GIC_SPI_EHCI1     =3D 74,
> >> +    AW_H3_GIC_SPI_OHCI1     =3D 75,
> >> +    AW_H3_GIC_SPI_EHCI2     =3D 76,
> >> +    AW_H3_GIC_SPI_OHCI2     =3D 77,
> >> +    AW_H3_GIC_SPI_EHCI3     =3D 78,
> >> +    AW_H3_GIC_SPI_OHCI3     =3D 79,
> >>   };
> >>   /* Allwinner H3 general constants */
> >> @@ -284,6 +301,33 @@ static void allwinner_h3_realize(DeviceState
> >> *dev, Error **errp)
> >>       qdev_init_nofail(DEVICE(&s->ccu));
> >>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]=
);
> >> +    /* Universal Serial Bus */
> >> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
> >> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> >> +                                          AW_H3_GIC_SPI_EHCI0));
> >> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI1],
> >> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> >> +                                          AW_H3_GIC_SPI_EHCI1));
> >> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI2],
> >> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> >> +                                          AW_H3_GIC_SPI_EHCI2));
> >> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI3],
> >> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> >> +                                          AW_H3_GIC_SPI_EHCI3));
> >> +
> >> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI0],
> >> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> >> +                                          AW_H3_GIC_SPI_OHCI0));
> >> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI1],
> >> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> >> +                                          AW_H3_GIC_SPI_OHCI1));
> >> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI2],
> >> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> >> +                                          AW_H3_GIC_SPI_OHCI2));
> >> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI3],
> >> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> >> +                                          AW_H3_GIC_SPI_OHCI3));
> >> +
> >>       /* UART0. For future clocktree API: All UARTS are connected to
> >> APB2_CLK. */
> >>       serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
> >>                      qdev_get_gpio_in(DEVICE(&s->gic),
> >> AW_H3_GIC_SPI_UART0),
> >> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> >> index 020211fd10..174c3446ef 100644
> >> --- a/hw/usb/hcd-ehci-sysbus.c
> >> +++ b/hw/usb/hcd-ehci-sysbus.c
> >> @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info =
=3D {
> >>       .class_init    =3D ehci_exynos4210_class_init,
> >>   };
> >> +static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
> >> +{
> >> +    SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
> >> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> >> +
> >> +    sec->capsbase =3D 0x0;
> >> +    sec->opregbase =3D 0x10;
> >> +    set_bit(DEVICE_CATEGORY_USB, dc->categories);
> >> +}
> >> +
> >> +static const TypeInfo ehci_aw_h3_type_info =3D {
> >> +    .name          =3D TYPE_AW_H3_EHCI,
> >> +    .parent        =3D TYPE_SYS_BUS_EHCI,
> >> +    .class_init    =3D ehci_aw_h3_class_init,
> >> +};
> >> +
> >>   static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
> >>   {
> >>       SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
> >> @@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)
> >>       type_register_static(&ehci_platform_type_info);
> >>       type_register_static(&ehci_xlnx_type_info);
> >>       type_register_static(&ehci_exynos4210_type_info);
> >> +    type_register_static(&ehci_aw_h3_type_info);
> >>       type_register_static(&ehci_tegra2_type_info);
> >>       type_register_static(&ehci_ppc4xx_type_info);
> >>       type_register_static(&ehci_fusbh200_type_info);
> >>
>
>

--=20
Niek Linnenbank

--00000000000077ed04059d9ce2fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 19, 2020 at 7:44 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 1/19/20 7:37 PM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; On 1/19/20 1:50 AM, Niek Linnenbank wrote:<br>
&gt;&gt; The Allwinner H3 System on Chip contains multiple USB 2.0 bus<br>
&gt;&gt; connections which provide software access using the Enhanced<br>
&gt;&gt; Host Controller Interface (EHCI) and Open Host Controller<br>
&gt;&gt; Interface (OHCI) interfaces. This commit adds support for<br>
&gt;&gt; both interfaces in the Allwinner H3 System on Chip.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenban=
k@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt;&gt; Reviewed-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com=
" target=3D"_blank">kraxel@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 hw/usb/hcd-ehci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +<br>
&gt;&gt; =C2=A0 include/hw/arm/allwinner-h3.h |=C2=A0 8 ++++++<br>
&gt;&gt; =C2=A0 hw/arm/allwinner-h3.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 52 ++++++++++++++++++++++++++++++++---<br>
&gt;&gt; =C2=A0 hw/usb/hcd-ehci-sysbus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17=
 ++++++++++++<br>
&gt;&gt; =C2=A0 4 files changed, 74 insertions(+), 4 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h<br>
&gt;&gt; index 0298238f0b..edb59311c4 100644<br>
&gt;&gt; --- a/hw/usb/hcd-ehci.h<br>
&gt;&gt; +++ b/hw/usb/hcd-ehci.h<br>
&gt;&gt; @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {<br>
&gt;&gt; =C2=A0 #define TYPE_SYS_BUS_EHCI &quot;sysbus-ehci-usb&quot;<br>
&gt;&gt; =C2=A0 #define TYPE_PLATFORM_EHCI &quot;platform-ehci-usb&quot;<br=
>
&gt;&gt; =C2=A0 #define TYPE_EXYNOS4210_EHCI &quot;exynos4210-ehci-usb&quot=
;<br>
&gt;&gt; +#define TYPE_AW_H3_EHCI &quot;aw-h3-ehci-usb&quot;<br>
&gt;&gt; =C2=A0 #define TYPE_TEGRA2_EHCI &quot;tegra2-ehci-usb&quot;<br>
&gt;&gt; =C2=A0 #define TYPE_PPC4xx_EHCI &quot;ppc4xx-ehci-usb&quot;<br>
&gt;&gt; =C2=A0 #define TYPE_FUSBH200_EHCI &quot;fusbh200-ehci-usb&quot;<br=
>
&gt;&gt; diff --git a/include/hw/arm/allwinner-h3.h <br>
&gt;&gt; b/include/hw/arm/allwinner-h3.h<br>
&gt;&gt; index abdc20871a..4f4dcbcd17 100644<br>
&gt;&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt;&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt;&gt; @@ -56,6 +56,14 @@ enum {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_SRAM_A1,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_SRAM_A2,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_SRAM_C,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_EHCI0,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_OHCI0,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_EHCI1,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_OHCI1,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_EHCI2,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_OHCI2,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_EHCI3,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_OHCI3,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_CCU,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_PIT,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_UART0,<br>
&gt;&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt;&gt; index 8df8e3e05e..f360625ee9 100644<br>
&gt;&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt;&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt;&gt; @@ -28,6 +28,7 @@<br>
&gt;&gt; =C2=A0 #include &quot;hw/sysbus.h&quot;<br>
&gt;&gt; =C2=A0 #include &quot;hw/char/serial.h&quot;<br>
&gt;&gt; =C2=A0 #include &quot;hw/misc/unimp.h&quot;<br>
&gt;&gt; +#include &quot;hw/usb/hcd-ehci.h&quot;<br>
&gt;&gt; =C2=A0 #include &quot;sysemu/sysemu.h&quot;<br>
&gt;&gt; =C2=A0 #include &quot;hw/arm/allwinner-h3.h&quot;<br>
&gt;&gt; @@ -36,6 +37,14 @@ const hwaddr allwinner_h3_memmap[] =3D {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_SRAM_A1]=C2=A0=C2=A0=C2=A0 =
=3D 0x00000000,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_SRAM_A2]=C2=A0=C2=A0=C2=A0 =
=3D 0x00044000,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_SRAM_C]=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x00010000,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 [AW_H3_EHCI0]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1a000,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 [AW_H3_OHCI0]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1a400,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 [AW_H3_EHCI1]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1b000,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 [AW_H3_OHCI1]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1b400,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 [AW_H3_EHCI2]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1c000,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 [AW_H3_OHCI2]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1c400,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 [AW_H3_EHCI3]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1d000,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 [AW_H3_OHCI3]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1d400,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_CCU]=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 0x01c20000,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_PIT]=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 0x01c20c00,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_UART0]=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 0x01c28000,<br>
&gt;&gt; @@ -73,10 +82,10 @@ struct AwH3Unimplemented {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { &quot;msgbox&quot;,=C2=A0=C2=A0=
=C2=A0 0x01c17000, 4 * KiB },<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { &quot;spinlock&quot;,=C2=A0 0x01c=
18000, 4 * KiB },<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { &quot;usb0-otg&quot;,=C2=A0 0x01c=
19000, 4 * KiB },<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 { &quot;usb0&quot;,=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x01c1a000, 4 * KiB },<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 { &quot;usb1&quot;,=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x01c1b000, 4 * KiB },<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 { &quot;usb2&quot;,=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x01c1c000, 4 * KiB },<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 { &quot;usb3&quot;,=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x01c1d000, 4 * KiB },<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 { &quot;usb0-phy&quot;,=C2=A0 0x01c1a000, 4 * =
KiB },<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 { &quot;usb1-phy&quot;,=C2=A0 0x01c1b000, 4 * =
KiB },<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 { &quot;usb2-phy&quot;,=C2=A0 0x01c1c000, 4 * =
KiB },<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 { &quot;usb3-phy&quot;,=C2=A0 0x01c1d000, 4 * =
KiB },<br>
&gt; <br>
&gt; As in v3 comment, this can be done in patch #1.<br>
&gt; <br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@re=
dhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
<br>
Err, this patch is incomplete, when using ./configure <br>
--without-default-devices:<br>
<br>
$ qemu-system-arm -M orangepi-pc<br>
qemu-system-arm: invalid accelerator kvm<br>
qemu-system-arm: falling back to tcg<br>
qemu-system-arm: Unknown device &#39;aw-h3-ehci-usb&#39; for default sysbus=
<br>
qemu-system-arm: Unknown device &#39;sysbus-ohci&#39; for default sysbus<br=
>
Aborted (core dumped)<br></blockquote><div><br></div><div>Thanks for pointi=
ng this out, I was not aware at all that the --without-default-devices opti=
on existed.<br></div><div>It&#39;s not in the configure --help message also=
.<br></div><div><br></div><div>I tried to re-produce the error by running:<=
/div><div>$ ./configure --target-list=3Darm-softmmu --without-default-devic=
es; make -j5</div><div>$ ./arm-softmmu/qemu-system-arm -M orangepi-pc<br> <=
/div><div><br></div><div>On my laptop it didn&#39;t give the error, I think=
 because somehow the build system did select</div><div>the USB config items=
 (even tho they were missing for the ALLWINNER_H3 item in hw/arm/Kconfig):<=
/div><div><br></div><div>$ grep USB arm-softmmu/config-devices.mak<br>CONFI=
G_TUSB6010=3Dy<br>CONFIG_USB=3Dy<br>CONFIG_USB_EHCI=3Dy<br>CONFIG_USB_EHCI_=
SYSBUS=3Dy<br>CONFIG_USB_MUSB=3Dy<br>CONFIG_USB_OHCI=3Dy<br></div><div><br>=
</div><div>Is there any other option you used in addition to --without-defa=
ult-devices to trigger the error?</div><div>I also searched for something i=
n configure to select/filter on machines to build, but I don&#39;t see that=
 yet.<br></div><div><br></div><div>Nevertheless I will surely add the fix b=
elow to the patch.</div><div><br></div><div>Regards,</div><div>Niek<br></di=
v><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
You need to amend:<br>
<br>
-- &gt;8 --<br>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
index bb75c1de17..57b29cc522 100644<br>
--- a/hw/arm/Kconfig<br>
+++ b/hw/arm/Kconfig<br>
@@ -302,6 +302,8 @@ config ALLWINNER_H3<br>
=C2=A0 =C2=A0 =C2=A0 select ARM_TIMER<br>
=C2=A0 =C2=A0 =C2=A0 select ARM_GIC<br>
=C2=A0 =C2=A0 =C2=A0 select UNIMP<br>
+=C2=A0 =C2=A0 select USB_OHCI<br>
+=C2=A0 =C2=A0 select USB_EHCI_SYSBUS<br>
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 config RASPI<br>
=C2=A0 =C2=A0 =C2=A0 bool<br>
---<br>
<br>
R/T-b tags can stay with this amended.<br>
<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { &quot;smc&quot;,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x01c1e000, 4 * KiB },<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { &quot;pio&quot;,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x01c20800, 1 * KiB },<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { &quot;owa&quot;,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x01c21000, 1 * KiB },<br>
&gt;&gt; @@ -144,6 +153,14 @@ enum {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_UART3=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D=C2=A0 3,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_TIMER0=C2=A0=C2=A0=C2=
=A0 =3D 18,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_TIMER1=C2=A0=C2=A0=C2=
=A0 =3D 19,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_EHCI0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 72,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_OHCI0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 73,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_EHCI1=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 74,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_OHCI1=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 75,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_EHCI2=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 76,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_OHCI2=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 77,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_EHCI3=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 78,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_OHCI3=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 79,<br>
&gt;&gt; =C2=A0 };<br>
&gt;&gt; =C2=A0 /* Allwinner H3 general constants */<br>
&gt;&gt; @@ -284,6 +301,33 @@ static void allwinner_h3_realize(DeviceState =
<br>
&gt;&gt; *dev, Error **errp)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;=
ccu));<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp=
;s-&gt;ccu), 0, s-&gt;memmap[AW_H3_CCU]);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* Universal Serial Bus */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;me=
mmap[AW_H3_EHCI0],<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_EHCI0));<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;me=
mmap[AW_H3_EHCI1],<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_EHCI1));<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;me=
mmap[AW_H3_EHCI2],<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_EHCI2));<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;me=
mmap[AW_H3_EHCI3],<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_EHCI3));<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, =
s-&gt;memmap[AW_H3_OHCI0],<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_OHCI0));<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, =
s-&gt;memmap[AW_H3_OHCI1],<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_OHCI1));<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, =
s-&gt;memmap[AW_H3_OHCI2],<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_OHCI2));<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, =
s-&gt;memmap[AW_H3_OHCI3],<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_GIC_SPI_OHCI3));<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* UART0. For future clocktree API:=
 All UARTS are connected to <br>
&gt;&gt; APB2_CLK. */<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_mm_init(get_system_memory(),=
 s-&gt;memmap[AW_H3_UART0], 2,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_get_gpio_in(DEV=
ICE(&amp;s-&gt;gic), <br>
&gt;&gt; AW_H3_GIC_SPI_UART0),<br>
&gt;&gt; diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c<b=
r>
&gt;&gt; index 020211fd10..174c3446ef 100644<br>
&gt;&gt; --- a/hw/usb/hcd-ehci-sysbus.c<br>
&gt;&gt; +++ b/hw/usb/hcd-ehci-sysbus.c<br>
&gt;&gt; @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_in=
fo =3D {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D e=
hci_exynos4210_class_init,<br>
&gt;&gt; =C2=A0 };<br>
&gt;&gt; +static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)<br=
>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc=
);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sec-&gt;capsbase =3D 0x0;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sec-&gt;opregbase =3D 0x10;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_USB, dc-&gt;categories=
);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static const TypeInfo ehci_aw_h3_type_info =3D {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D TYPE_AW_H3_EHCI,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D TYPE_SYS_BUS_EHCI,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D ehci_aw_h3_c=
lass_init,<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 static void ehci_tegra2_class_init(ObjectClass *oc, void *d=
ata)<br>
&gt;&gt; =C2=A0 {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SysBusEHCIClass *sec =3D SYS_BUS_EH=
CI_CLASS(oc);<br>
&gt;&gt; @@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)<b=
r>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_register_static(&amp;ehci_plat=
form_type_info);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_register_static(&amp;ehci_xlnx=
_type_info);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_register_static(&amp;ehci_exyn=
os4210_type_info);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 type_register_static(&amp;ehci_aw_h3_type_info=
);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_register_static(&amp;ehci_tegr=
a2_type_info);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_register_static(&amp;ehci_ppc4=
xx_type_info);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_register_static(&amp;ehci_fusb=
h200_type_info);<br>
&gt;&gt;<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000077ed04059d9ce2fc--

