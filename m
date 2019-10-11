Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D67AC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 22:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DB02084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 22:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Beqntp9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DB02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ2yj-0000T9-2i
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 18:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iJ2xc-0008CH-Sd
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 18:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iJ2xa-0003dz-Vs
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 18:00:32 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iJ2xa-0003dn-JR; Fri, 11 Oct 2019 18:00:30 -0400
Received: by mail-lj1-x242.google.com with SMTP id a22so11258066ljd.0;
 Fri, 11 Oct 2019 15:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GeRrffJPAcWK8bPnIORtmSTEkZUm+mHxmMxBGxmazI0=;
 b=Beqntp9jjnons/HJwM649D3OFOpaWusibTaZU9bvAjj8ZXKU4vuXBv/krL1ejkwenv
 tsQlU2+saDea23uUeJ1LOfPhv8/vJIgOl2g5K6edNw8+SAY7MR6FG+zeKPYJRIn+mQ9F
 drAUauk+Nrzrx/bMIjVhZj73n2rb+EYLl/8P00uJSHFa4ynnEQbwcPe7ZUeurYFNvaCO
 5+q34hU+UkYVD/kkux8bTJ+FbA1TdpGGU+uFiw78rDLRtWS6iS453YW7U08zUAStHd0w
 F9jPS6dm2LkrwZIHq4r1hi/wdolarTX3QOwK3A4oo9QU0S2WVoTxOUkZSPRIHqnX2AuT
 v5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GeRrffJPAcWK8bPnIORtmSTEkZUm+mHxmMxBGxmazI0=;
 b=ufT1GxNQzIW5AoXar6beATLJR69IzaPKxwOU6Ulc1/gJetBh1JkSvu07N8Nyw2N5s5
 D0sEstmorteWgbgnndyf6aUdqq68ZynT481M5ietFRo5uOGc1AYMln3FPTZRSoz7Ke/6
 /QXYLySp/lnM/5f3qdlBtkhSvFfSeAaFBT9qhxFDc5icUGa91lHrDaER+5hL5MfVx0k4
 I2hoRKA9dvstwSRZ6XBXy7hi5Joh6Zfjx/CLufB7Eus3yLy7ddZmdoUJcfPQmcCJThZD
 Ug5pRYgSC9a831Ph6MHoT25QLyEG+2ykR7n1mgsZw9IYSFWD9ptRIsZ4SgPQbTjav7B3
 DrBQ==
X-Gm-Message-State: APjAAAXHErNgj7d3Ck4s6BupvpTM6CU7+GUO67ms9nUtBR2pj7ncGYTz
 rG3YrMQVkxjOHPt+eNNBoL2n1yGAXMgdIWuIny0=
X-Google-Smtp-Source: APXvYqze5UN6eHNlof3IQenGoSt4Oo+pERiPa7NoSCb2r3MxkLymlVnDsjfqcg0QMtOJuXoU0vOYTXie4IcmPA+LARo=
X-Received: by 2002:a2e:894b:: with SMTP id b11mr10269620ljk.152.1570831228442; 
 Fri, 11 Oct 2019 15:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-6-f4bug@amsat.org>
 <CAKmqyKP+ABP9J=1UJEA+HEO4+UBuyjOoyzZVEJEDiM7N63bMag@mail.gmail.com>
 <d2ab9145-cf4e-008c-8351-51f271fa37f8@amsat.org>
In-Reply-To: <d2ab9145-cf4e-008c-8351-51f271fa37f8@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2019 14:55:25 -0700
Message-ID: <CAKmqyKOifObHz9vsrnk5=FaaQPZcQYF2AN946P2eY13VxZQ9Ew@mail.gmail.com>
Subject: Re: [PATCH 05/19] hw/arm/bcm2835: Add various unimplemented
 peripherals
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 8, 2019 at 2:43 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Hi Alistair,
>
> On 9/27/19 11:42 PM, Alistair Francis wrote:
> >   On Thu, Sep 26, 2019 at 10:44 AM Philippe Mathieu-Daud=C3=A9
> > <f4bug@amsat.org> wrote:
> >>
> >> Base addresses and sizes taken from the "BCM2835 ARM Peripherals"
> >> datasheet from February 06 2012:
> >> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripheral=
s.pdf
> >>
> >> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>   hw/arm/bcm2835_peripherals.c         | 31 ++++++++++++++++++++++++++=
++
> >>   include/hw/arm/bcm2835_peripherals.h | 15 ++++++++++++++
> >>   include/hw/arm/raspi_platform.h      |  8 +++++++
> >>   3 files changed, 54 insertions(+)
> >>
> >> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals=
.c
> >> index 1bd2ff41d5..fdcf616c56 100644
> >> --- a/hw/arm/bcm2835_peripherals.c
> >> +++ b/hw/arm/bcm2835_peripherals.c
> >> @@ -22,6 +22,20 @@
> >>   /* Capabilities for SD controller: no DMA, high-speed, default clock=
s etc. */
> >>   #define BCM2835_SDHC_CAPAREG 0x52134b4
> >>
> >> +static void create_unimp(BCM2835PeripheralState *ps,
> >> +                         UnimplementedDeviceState *uds,
> >> +                         const char *name, hwaddr ofs, hwaddr size)
> >> +{
> >> +    sysbus_init_child_obj(OBJECT(ps), name, uds,
> >> +                          sizeof(UnimplementedDeviceState),
> >> +                          TYPE_UNIMPLEMENTED_DEVICE);
> >> +    qdev_prop_set_string(DEVICE(uds), "name", name);
> >> +    qdev_prop_set_uint64(DEVICE(uds), "size", size);
> >> +    object_property_set_bool(OBJECT(uds), true, "realized", &error_fa=
tal);
> >> +    memory_region_add_subregion_overlap(&ps->peri_mr, ofs,
> >> +                    sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0), -=
1000);
> >
> > Why not just use create_unimplemented_device() and not bother saving
> > the UnimplementedDeviceState members in the struct?
>
> create_unimplemented_device() calls
>   -> sysbus_mmio_map_overlap()
>      -> sysbus_mmio_map_common()
>        -> memory_region_del_subregion(get_system_memory())
>
> So it maps the device at *absolute* offset in the system memory.
>
> create_unimp() maps the device at offset *relative* to peri_mr.
>
> Patch 8 of this series maps the PERI (container) block at peri_base
> (fixed at BCM2836_PERI_BASE=3D0x3F000000 for the 2836/2837), then patch 1=
2
> adds the 2838 which has PERI mapped at 0xfe000000. So we have the same
> "container" block mapped at different addresses.
> Not the PERI block itself doesn't know its base address, all offsets are
> relative.
>
> So using create_unimp() allow to use the same block in two different SoCs=
.

Ah, makes sense.

Maybe that is worth adding in the commit message, unless it's just
obvious and I am missing something.

Either way:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> 8:  https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00678.html
> 12: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00684.html
>
> >> +}
> >> +
> >>   static void bcm2835_peripherals_init(Object *obj)
> >>   {
> >>       BCM2835PeripheralState *s =3D BCM2835_PERIPHERALS(obj);
> >> @@ -323,6 +337,23 @@ static void bcm2835_peripherals_realize(DeviceSta=
te *dev, Error **errp)
> >>           error_propagate(errp, err);
> >>           return;
> >>       }
> >> +
> >> +    create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFF=
SET, 0x40);
> >> +    create_unimp(s, &s->systmr, "bcm2835-systimer", ST_OFFSET, 0x20);
> >> +    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x10=
00);
> >> +    create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
> >> +    create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
> >> +    create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
> >> +    create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
> >> +    create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
> >> +    create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
> >> +    create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
> >> +    create_unimp(s, &s->i2c[2], "bcm2835-i2c2", BSC2_OFFSET, 0x20);
> >> +    create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
> >> +    create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
> >> +    create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
> >> +    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x1000);
> >> +    create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x10=
0);
> >>   }
> >>
> >>   static void bcm2835_peripherals_class_init(ObjectClass *oc, void *da=
ta)
> >> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm=
2835_peripherals.h
> >> index 6b17f6a382..62a4c7b559 100644
> >> --- a/include/hw/arm/bcm2835_peripherals.h
> >> +++ b/include/hw/arm/bcm2835_peripherals.h
> >> @@ -23,6 +23,7 @@
> >>   #include "hw/sd/sdhci.h"
> >>   #include "hw/sd/bcm2835_sdhost.h"
> >>   #include "hw/gpio/bcm2835_gpio.h"
> >> +#include "hw/misc/unimp.h"
> >>
> >>   #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
> >>   #define BCM2835_PERIPHERALS(obj) \
> >> @@ -37,6 +38,10 @@ typedef struct BCM2835PeripheralState {
> >>       MemoryRegion ram_alias[4];
> >>       qemu_irq irq, fiq;
> >>
> >> +    UnimplementedDeviceState systmr;
> >> +    UnimplementedDeviceState armtmr;
> >> +    UnimplementedDeviceState cprman;
> >> +    UnimplementedDeviceState a2w;
> >>       PL011State uart0;
> >>       BCM2835AuxState aux;
> >>       BCM2835FBState fb;
> >> @@ -48,6 +53,16 @@ typedef struct BCM2835PeripheralState {
> >>       SDHCIState sdhci;
> >>       BCM2835SDHostState sdhost;
> >>       BCM2835GpioState gpio;
> >> +    UnimplementedDeviceState i2s;
> >> +    UnimplementedDeviceState spi[1];
> >> +    UnimplementedDeviceState i2c[3];
> >> +    UnimplementedDeviceState otp;
> >> +    UnimplementedDeviceState dbus;
> >> +    UnimplementedDeviceState ave0;
> >> +    UnimplementedDeviceState bscsl;
> >> +    UnimplementedDeviceState smi;
> >> +    UnimplementedDeviceState dwc2;
> >> +    UnimplementedDeviceState sdramc;
> >>   } BCM2835PeripheralState;
> >>
> >>   #endif /* BCM2835_PERIPHERALS_H */
> >> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_pl=
atform.h
> >> index 66969fac5d..cdcbca943f 100644
> >> --- a/include/hw/arm/raspi_platform.h
> >> +++ b/include/hw/arm/raspi_platform.h
> >> @@ -38,6 +38,8 @@
> >>                                                         * Doorbells & =
Mailboxes */
> >>   #define CPRMAN_OFFSET           0x100000 /* Power Management, Watchd=
og */
> >>   #define CM_OFFSET               0x101000 /* Clock Management */
> >> +#define A2W_OFFSET              0x102000 /* Reset controller */
> >> +#define AVS_OFFSET              0x103000 /* Audio Video Standard */
> >>   #define RNG_OFFSET              0x104000
> >>   #define GPIO_OFFSET             0x200000
> >>   #define UART0_OFFSET            0x201000
> >> @@ -45,11 +47,17 @@
> >>   #define I2S_OFFSET              0x203000
> >>   #define SPI0_OFFSET             0x204000
> >>   #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
> >> +#define OTP_OFFSET              0x20f000
> >> +#define BSC_SL_OFFSET           0x214000 /* SPI slave */
> >>   #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
> >>   #define EMMC1_OFFSET            0x300000
> >>   #define SMI_OFFSET              0x600000
> >>   #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
> >> +#define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
> >> +#define DBUS_OFFSET             0x900000
> >> +#define AVE0_OFFSET             0x910000
> >>   #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller *=
/
> >> +#define SDRAMC_OFFSET           0xe00000
> >>   #define DMA15_OFFSET            0xE05000 /* DMA controller, channel =
15 */
> >>
> >>   /* GPU interrupts */
> >> --
> >> 2.20.1
> >>
> >>

