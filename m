Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D3CC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 21:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2194F205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 21:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJW+zhNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2194F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy08t-000598-8R
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 16:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iy07X-0004Sq-SC
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 16:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iy07R-00051L-UM
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 16:16:03 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iy07R-00050E-JU; Sat, 01 Feb 2020 16:15:57 -0500
Received: by mail-io1-xd42.google.com with SMTP id d15so12379769iog.3;
 Sat, 01 Feb 2020 13:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8CrTI1x28AEnv7nsdh425qbQwcCSbX9hpSA2ziORwS8=;
 b=iJW+zhNzH9Nri7ryl5PRVN2WHEnCJfAguSZ2i6A/v+yHN7+IXEEOl9C0vABDt9x/HP
 B5hMOkFyrVPKJ8Xj17Cb0UuRdRis361HsxL3vrcybmYNnX0e9e5yPfacOklfXXSKD5HV
 weBR8/EmRQe2B1d3Jbpa8LOWDG3Nm4rfzJGI98+n78NW6lBovsDB9Bvl7ciGyfNeFZod
 EMPrLt1VarjA9eKOBejCVA1Q8H0EGnhx6oR+MuODbKEt2Sm+NpiLX3wmk5W+RBOCVaEa
 Yrd9KF9DHTdlDAcZYTHfYvuhZZfrQphgyumzCTwIfsqW5hk+Vlbx7xzMyejcSfrtuTet
 85gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8CrTI1x28AEnv7nsdh425qbQwcCSbX9hpSA2ziORwS8=;
 b=pCe5cherB1ijKpR3uJOgG5DLmi1sedNu8JWIYdfTKdflKaZMHGJbovbVaiDfWuqsIj
 /t+9nlI/AkJ+Kgsu3vM2kvwo75iBmvjoTS4lv0XTpqWVnTLxvke8Nm3R+myUnvCkUdG/
 qKCAPJ968wsHTjC7YmcAWA8HR8EZ071LMjirfJMa92pDLLbfFiboRJOd8me8i6g/1yX1
 hwKigH0k9ZcEjRr3Xjau++34fPbOffyigLGH45uQAQimfLqhAhizXE4sAVyccpCzUgoC
 DCR2C840oAxJa9XMYlh22aSen1SqiCTbpGazJmp24Qij85ZNjYQRBhbmTRnZvJJSIKV4
 MsHw==
X-Gm-Message-State: APjAAAXUyJPs075RKx+sIDOj8dtYTqp5hnYsp1Z1D/+G4FF23dVF33jX
 fGCkTioFwz/IrarPavTwqgoDlheYVcuWw/W6ybI=
X-Google-Smtp-Source: APXvYqwocmNVt9095e7yoUJVglyUPD5yWxh6X/RKjJzy5jQOBy8HwUcCNXrAGXzYPv8Nl0I3e1tpb22dhHJUevLhtkg=
X-Received: by 2002:a6b:7902:: with SMTP id i2mr12791358iop.67.1580591756357; 
 Sat, 01 Feb 2020 13:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-4-nieklinnenbank@gmail.com>
 <61914945-ab68-b47b-9d8d-3ed78c93640c@redhat.com>
In-Reply-To: <61914945-ab68-b47b-9d8d-3ed78c93640c@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 1 Feb 2020 22:15:45 +0100
Message-ID: <CAPan3Wr-tswXP3esO70mcNjHJrbfjKL47BVRhK_K4XzZ68W5sg@mail.gmail.com>
Subject: Re: [PATCH v4 03/20] hw/arm/allwinner-h3: add Clock Control Unit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002c33e9059d8a324f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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

--0000000000002c33e9059d8a324f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Sun, Jan 19, 2020 at 7:34 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> > The Clock Control Unit is responsible for clock signal generation,
> > configuration and distribution in the Allwinner H3 System on Chip.
> > This commit adds support for the Clock Control Unit which emulates
> > a simple read/write register interface.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   include/hw/arm/allwinner-h3.h      |   3 +
> >   include/hw/misc/allwinner-h3-ccu.h |  66 ++++++++
> >   hw/arm/allwinner-h3.c              |   9 +-
> >   hw/misc/allwinner-h3-ccu.c         | 243 ++++++++++++++++++++++++++++=
+
> >   hw/misc/Makefile.objs              |   1 +
> >   5 files changed, 321 insertions(+), 1 deletion(-)
> >   create mode 100644 include/hw/misc/allwinner-h3-ccu.h
> >   create mode 100644 hw/misc/allwinner-h3-ccu.c
> >
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index 2aac9b78ec..abdc20871a 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -39,6 +39,7 @@
> >   #include "hw/arm/boot.h"
> >   #include "hw/timer/allwinner-a10-pit.h"
> >   #include "hw/intc/arm_gic.h"
> > +#include "hw/misc/allwinner-h3-ccu.h"
> >   #include "target/arm/cpu.h"
> >
> >   /**
> > @@ -55,6 +56,7 @@ enum {
> >       AW_H3_SRAM_A1,
> >       AW_H3_SRAM_A2,
> >       AW_H3_SRAM_C,
> > +    AW_H3_CCU,
> >       AW_H3_PIT,
> >       AW_H3_UART0,
> >       AW_H3_UART1,
> > @@ -97,6 +99,7 @@ typedef struct AwH3State {
> >       ARMCPU cpus[AW_H3_NUM_CPUS];
> >       const hwaddr *memmap;
> >       AwA10PITState timer;
> > +    AwH3ClockCtlState ccu;
> >       GICState gic;
> >       MemoryRegion sram_a1;
> >       MemoryRegion sram_a2;
> > diff --git a/include/hw/misc/allwinner-h3-ccu.h
> b/include/hw/misc/allwinner-h3-ccu.h
> > new file mode 100644
> > index 0000000000..9c8a887782
> > --- /dev/null
> > +++ b/include/hw/misc/allwinner-h3-ccu.h
> > @@ -0,0 +1,66 @@
> > +/*
> > + * Allwinner H3 Clock Control Unit emulation
> > + *
> > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#ifndef HW_MISC_ALLWINNER_H3_CCU_H
> > +#define HW_MISC_ALLWINNER_H3_CCU_H
> > +
> > +#include "qom/object.h"
> > +#include "hw/sysbus.h"
> > +
> > +/**
> > + * @name Constants
> > + * @{
> > + */
> > +
> > +/** Highest register address used by CCU device */
> > +#define AW_H3_CCU_REGS_MAXADDR  (0x304)
>
> There might be a migration issue if one day we see some firmware
> accessing some undocumented register > 0x304 (you'd need to migrate more
> than 0x304/4 registers, so increase allwinner_h3_ccu_vmstate.version_id.
>
> I'd simply replace this definition by
>
>    #define AW_H3_CCU_IOSIZE 0x400
>
> And see comment in write().
>

Good point, thanks I'll change that to 0x400!


>
> > +
> > +/** Total number of known registers */
> > +#define AW_H3_CCU_REGS_NUM      (AW_H3_CCU_REGS_MAXADDR /
> sizeof(uint32_t))
> > +
> > +/** @} */
> > +
> > +/**
> > + * @name Object model
> > + * @{
> > + */
> > +
> > +#define TYPE_AW_H3_CCU    "allwinner-h3-ccu"
> > +#define AW_H3_CCU(obj) \
> > +    OBJECT_CHECK(AwH3ClockCtlState, (obj), TYPE_AW_H3_CCU)
> > +
> > +/** @} */
> > +
> > +/**
> > + * Allwinner H3 CCU object instance state.
> > + */
> > +typedef struct AwH3ClockCtlState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +    /*< public >*/
> > +
> > +    /** Maps I/O registers in physical memory */
> > +    MemoryRegion iomem;
> > +
> > +    /** Array of hardware registers */
> > +    uint32_t regs[AW_H3_CCU_REGS_NUM];
> > +
> > +} AwH3ClockCtlState;
> > +
> > +#endif /* HW_MISC_ALLWINNER_H3_CCU_H */
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index efe6042af3..8df8e3e05e 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -36,6 +36,7 @@ const hwaddr allwinner_h3_memmap[] =3D {
> >       [AW_H3_SRAM_A1]    =3D 0x00000000,
> >       [AW_H3_SRAM_A2]    =3D 0x00044000,
> >       [AW_H3_SRAM_C]     =3D 0x00010000,
> > +    [AW_H3_CCU]        =3D 0x01c20000,
> >       [AW_H3_PIT]        =3D 0x01c20c00,
> >       [AW_H3_UART0]      =3D 0x01c28000,
> >       [AW_H3_UART1]      =3D 0x01c28400,
> > @@ -77,7 +78,6 @@ struct AwH3Unimplemented {
> >       { "usb2",      0x01c1c000, 4 * KiB },
> >       { "usb3",      0x01c1d000, 4 * KiB },
> >       { "smc",       0x01c1e000, 4 * KiB },
> > -    { "ccu",       0x01c20000, 1 * KiB },
> >       { "pio",       0x01c20800, 1 * KiB },
> >       { "owa",       0x01c21000, 1 * KiB },
> >       { "pwm",       0x01c21400, 1 * KiB },
> > @@ -172,6 +172,9 @@ static void allwinner_h3_init(Object *obj)
> >                                 "clk0-freq", &error_abort);
> >       object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
> >                                 "clk1-freq", &error_abort);
> > +
> > +    sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
> > +                          TYPE_AW_H3_CCU);
> >   }
> >
> >   static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> > @@ -277,6 +280,10 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
> >       memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_C],
> >                                   &s->sram_c);
> >
> > +    /* Clock Control Unit */
> > +    qdev_init_nofail(DEVICE(&s->ccu));
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
> > +
> >       /* UART0. For future clocktree API: All UARTS are connected to
> APB2_CLK. */
> >       serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
> >                      qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_UART0),
> > diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c
> > new file mode 100644
> > index 0000000000..ccf58ccdf2
> > --- /dev/null
> > +++ b/hw/misc/allwinner-h3-ccu.c
> > @@ -0,0 +1,243 @@
> > +/*
> > + * Allwinner H3 Clock Control Unit emulation
> > + *
> > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/units.h"
> > +#include "hw/sysbus.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "hw/misc/allwinner-h3-ccu.h"
> > +
> > +/* CCU register offsets */
> > +enum {
> > +    REG_PLL_CPUX             =3D 0x0000, /* PLL CPUX Control */
> > +    REG_PLL_AUDIO            =3D 0x0008, /* PLL Audio Control */
> > +    REG_PLL_VIDEO            =3D 0x0010, /* PLL Video Control */
> > +    REG_PLL_VE               =3D 0x0018, /* PLL VE Control */
> > +    REG_PLL_DDR              =3D 0x0020, /* PLL DDR Control */
> > +    REG_PLL_PERIPH0          =3D 0x0028, /* PLL Peripherals 0 Control =
*/
> > +    REG_PLL_GPU              =3D 0x0038, /* PLL GPU Control */
> > +    REG_PLL_PERIPH1          =3D 0x0044, /* PLL Peripherals 1 Control =
*/
> > +    REG_PLL_DE               =3D 0x0048, /* PLL Display Engine Control=
 */
> > +    REG_CPUX_AXI             =3D 0x0050, /* CPUX/AXI Configuration */
> > +    REG_APB1                 =3D 0x0054, /* ARM Peripheral Bus 1 Confi=
g */
> > +    REG_APB2                 =3D 0x0058, /* ARM Peripheral Bus 2 Confi=
g */
> > +    REG_DRAM_CFG             =3D 0x00F4, /* DRAM Configuration */
> > +    REG_MBUS                 =3D 0x00FC, /* MBUS Reset */
> > +    REG_PLL_TIME0            =3D 0x0200, /* PLL Stable Time 0 */
> > +    REG_PLL_TIME1            =3D 0x0204, /* PLL Stable Time 1 */
> > +    REG_PLL_CPUX_BIAS        =3D 0x0220, /* PLL CPUX Bias */
> > +    REG_PLL_AUDIO_BIAS       =3D 0x0224, /* PLL Audio Bias */
> > +    REG_PLL_VIDEO_BIAS       =3D 0x0228, /* PLL Video Bias */
> > +    REG_PLL_VE_BIAS          =3D 0x022C, /* PLL VE Bias */
> > +    REG_PLL_DDR_BIAS         =3D 0x0230, /* PLL DDR Bias */
> > +    REG_PLL_PERIPH0_BIAS     =3D 0x0234, /* PLL Peripherals 0 Bias */
> > +    REG_PLL_GPU_BIAS         =3D 0x023C, /* PLL GPU Bias */
> > +    REG_PLL_PERIPH1_BIAS     =3D 0x0244, /* PLL Peripherals 1 Bias */
> > +    REG_PLL_DE_BIAS          =3D 0x0248, /* PLL Display Engine Bias */
> > +    REG_PLL_CPUX_TUNING      =3D 0x0250, /* PLL CPUX Tuning */
> > +    REG_PLL_DDR_TUNING       =3D 0x0260, /* PLL DDR Tuning */
> > +};
> > +
> > +#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
> > +
> > +/* CCU register flags */
> > +enum {
> > +    REG_DRAM_CFG_UPDATE      =3D (1 << 16),
> > +};
> > +
> > +enum {
> > +    REG_PLL_ENABLE           =3D (1 << 31),
> > +    REG_PLL_LOCK             =3D (1 << 28),
> > +};
> > +
> > +
> > +/* CCU register reset values */
> > +enum {
> > +    REG_PLL_CPUX_RST         =3D 0x00001000,
> > +    REG_PLL_AUDIO_RST        =3D 0x00035514,
> > +    REG_PLL_VIDEO_RST        =3D 0x03006207,
> > +    REG_PLL_VE_RST           =3D 0x03006207,
> > +    REG_PLL_DDR_RST          =3D 0x00001000,
> > +    REG_PLL_PERIPH0_RST      =3D 0x00041811,
> > +    REG_PLL_GPU_RST          =3D 0x03006207,
> > +    REG_PLL_PERIPH1_RST      =3D 0x00041811,
> > +    REG_PLL_DE_RST           =3D 0x03006207,
> > +    REG_CPUX_AXI_RST         =3D 0x00010000,
> > +    REG_APB1_RST             =3D 0x00001010,
> > +    REG_APB2_RST             =3D 0x01000000,
> > +    REG_DRAM_CFG_RST         =3D 0x00000000,
> > +    REG_MBUS_RST             =3D 0x80000000,
> > +    REG_PLL_TIME0_RST        =3D 0x000000FF,
> > +    REG_PLL_TIME1_RST        =3D 0x000000FF,
> > +    REG_PLL_CPUX_BIAS_RST    =3D 0x08100200,
> > +    REG_PLL_AUDIO_BIAS_RST   =3D 0x10100000,
> > +    REG_PLL_VIDEO_BIAS_RST   =3D 0x10100000,
> > +    REG_PLL_VE_BIAS_RST      =3D 0x10100000,
> > +    REG_PLL_DDR_BIAS_RST     =3D 0x81104000,
> > +    REG_PLL_PERIPH0_BIAS_RST =3D 0x10100010,
> > +    REG_PLL_GPU_BIAS_RST     =3D 0x10100000,
> > +    REG_PLL_PERIPH1_BIAS_RST =3D 0x10100010,
> > +    REG_PLL_DE_BIAS_RST      =3D 0x10100000,
> > +    REG_PLL_CPUX_TUNING_RST  =3D 0x0A101000,
> > +    REG_PLL_DDR_TUNING_RST   =3D 0x14880000,
> > +};
> > +
> > +static uint64_t allwinner_h3_ccu_read(void *opaque, hwaddr offset,
> > +                                      unsigned size)
> > +{
> > +    const AwH3ClockCtlState *s =3D AW_H3_CCU(opaque);
> > +    const uint32_t idx =3D REG_INDEX(offset);
> > +
> > +    if (idx >=3D AW_H3_CCU_REGS_NUM) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
>
> See comment in write().
>
> > +        return 0;
> > +    }
> > +
> > +    return s->regs[idx];
> > +}
> > +
> > +static void allwinner_h3_ccu_write(void *opaque, hwaddr offset,
> > +                                   uint64_t val, unsigned size)
> > +{
> > +    AwH3ClockCtlState *s =3D AW_H3_CCU(opaque);
> > +    const uint32_t idx =3D REG_INDEX(offset);
> > +
> > +    if (idx >=3D AW_H3_CCU_REGS_NUM) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
>
> I'd replace this check by ...
>
> > +        return;
> > +    }
> > +
> > +    switch (offset) {
> > +    case REG_DRAM_CFG:    /* DRAM Configuration */
> > +        val &=3D ~REG_DRAM_CFG_UPDATE;
> > +        break;
> > +    case REG_PLL_CPUX:    /* PLL CPUX Control */
> > +    case REG_PLL_AUDIO:   /* PLL Audio Control */
> > +    case REG_PLL_VIDEO:   /* PLL Video Control */
> > +    case REG_PLL_VE:      /* PLL VE Control */
> > +    case REG_PLL_DDR:     /* PLL DDR Control */
> > +    case REG_PLL_PERIPH0: /* PLL Peripherals 0 Control */
> > +    case REG_PLL_GPU:     /* PLL GPU Control */
> > +    case REG_PLL_PERIPH1: /* PLL Peripherals 1 Control */
> > +    case REG_PLL_DE:      /* PLL Display Engine Control */
> > +        if (val & REG_PLL_ENABLE) {
> > +            val |=3D REG_PLL_LOCK;
> > +        }
> > +        break;
>
>         case 0x304 ... AW_H3_CCU_IOSIZE:
>             qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
>                           __func__, (uint32_t)offset);
>             break;
>

OK, looks more compact indeed.


>
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset
> 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
> > +        break;
> > +    }
> > +
> > +    s->regs[idx] =3D (uint32_t) val;
> > +}
>
> That said,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Thanks!

Niek


>
> > +
> > +static const MemoryRegionOps allwinner_h3_ccu_ops =3D {
> > +    .read =3D allwinner_h3_ccu_read,
> > +    .write =3D allwinner_h3_ccu_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +    .impl.min_access_size =3D 4,
> > +};
> > +
> > +static void allwinner_h3_ccu_reset(DeviceState *dev)
> > +{
> > +    AwH3ClockCtlState *s =3D AW_H3_CCU(dev);
> > +
> > +    /* Set default values for registers */
> > +    s->regs[REG_INDEX(REG_PLL_CPUX)] =3D REG_PLL_CPUX_RST;
> > +    s->regs[REG_INDEX(REG_PLL_AUDIO)] =3D REG_PLL_AUDIO_RST;
> > +    s->regs[REG_INDEX(REG_PLL_VIDEO)] =3D REG_PLL_VIDEO_RST;
> > +    s->regs[REG_INDEX(REG_PLL_VE)] =3D REG_PLL_VE_RST;
> > +    s->regs[REG_INDEX(REG_PLL_DDR)] =3D REG_PLL_DDR_RST;
> > +    s->regs[REG_INDEX(REG_PLL_PERIPH0)] =3D REG_PLL_PERIPH0_RST;
> > +    s->regs[REG_INDEX(REG_PLL_GPU)] =3D REG_PLL_GPU_RST;
> > +    s->regs[REG_INDEX(REG_PLL_PERIPH1)] =3D REG_PLL_PERIPH1_RST;
> > +    s->regs[REG_INDEX(REG_PLL_DE)] =3D REG_PLL_DE_RST;
> > +    s->regs[REG_INDEX(REG_CPUX_AXI)] =3D REG_CPUX_AXI_RST;
> > +    s->regs[REG_INDEX(REG_APB1)] =3D REG_APB1_RST;
> > +    s->regs[REG_INDEX(REG_APB2)] =3D REG_APB2_RST;
> > +    s->regs[REG_INDEX(REG_DRAM_CFG)] =3D REG_DRAM_CFG_RST;
> > +    s->regs[REG_INDEX(REG_MBUS)] =3D REG_MBUS_RST;
> > +    s->regs[REG_INDEX(REG_PLL_TIME0)] =3D REG_PLL_TIME0_RST;
> > +    s->regs[REG_INDEX(REG_PLL_TIME1)] =3D REG_PLL_TIME1_RST;
> > +    s->regs[REG_INDEX(REG_PLL_CPUX_BIAS)] =3D REG_PLL_CPUX_BIAS_RST;
> > +    s->regs[REG_INDEX(REG_PLL_AUDIO_BIAS)] =3D REG_PLL_AUDIO_BIAS_RST;
> > +    s->regs[REG_INDEX(REG_PLL_VIDEO_BIAS)] =3D REG_PLL_VIDEO_BIAS_RST;
> > +    s->regs[REG_INDEX(REG_PLL_VE_BIAS)] =3D REG_PLL_VE_BIAS_RST;
> > +    s->regs[REG_INDEX(REG_PLL_DDR_BIAS)] =3D REG_PLL_DDR_BIAS_RST;
> > +    s->regs[REG_INDEX(REG_PLL_PERIPH0_BIAS)] =3D REG_PLL_PERIPH0_BIAS_=
RST;
> > +    s->regs[REG_INDEX(REG_PLL_GPU_BIAS)] =3D REG_PLL_GPU_BIAS_RST;
> > +    s->regs[REG_INDEX(REG_PLL_PERIPH1_BIAS)] =3D REG_PLL_PERIPH1_BIAS_=
RST;
> > +    s->regs[REG_INDEX(REG_PLL_DE_BIAS)] =3D REG_PLL_DE_BIAS_RST;
> > +    s->regs[REG_INDEX(REG_PLL_CPUX_TUNING)] =3D REG_PLL_CPUX_TUNING_RS=
T;
> > +    s->regs[REG_INDEX(REG_PLL_DDR_TUNING)] =3D REG_PLL_DDR_TUNING_RST;
> > +}
> > +
> > +static void allwinner_h3_ccu_init(Object *obj)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    AwH3ClockCtlState *s =3D AW_H3_CCU(obj);
> > +
> > +    /* Memory mapping */
> > +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_ccu_ops,
> s,
> > +                          TYPE_AW_H3_CCU, 1 * KiB);
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +}
> > +
> > +static const VMStateDescription allwinner_h3_ccu_vmstate =3D {
> > +    .name =3D "allwinner-h3-ccu",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32_ARRAY(regs, AwH3ClockCtlState,
> AW_H3_CCU_REGS_NUM),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void allwinner_h3_ccu_class_init(ObjectClass *klass, void *data=
)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->reset =3D allwinner_h3_ccu_reset;
> > +    dc->vmsd =3D &allwinner_h3_ccu_vmstate;
> > +}
> > +
> > +static const TypeInfo allwinner_h3_ccu_info =3D {
> > +    .name          =3D TYPE_AW_H3_CCU,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_init =3D allwinner_h3_ccu_init,
> > +    .instance_size =3D sizeof(AwH3ClockCtlState),
> > +    .class_init    =3D allwinner_h3_ccu_class_init,
> > +};
> > +
> > +static void allwinner_h3_ccu_register(void)
> > +{
> > +    type_register_static(&allwinner_h3_ccu_info);
> > +}
> > +
> > +type_init(allwinner_h3_ccu_register)
> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > index da993f45b7..5e635b74d5 100644
> > --- a/hw/misc/Makefile.objs
> > +++ b/hw/misc/Makefile.objs
> > @@ -28,6 +28,7 @@ common-obj-$(CONFIG_MACIO) +=3D macio/
> >
> >   common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o
> >
> > +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-ccu.o
> >   common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o
> >   common-obj-$(CONFIG_NSERIES) +=3D cbus.o
> >   common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o
> >
>
>

--=20
Niek Linnenbank

--0000000000002c33e9059d8a324f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 19, 2020 at 7:34 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 1/19/20 1:50 AM, Niek Linnenbank wrote:<br>
&gt; The Clock Control Unit is responsible for clock signal generation,<br>
&gt; configuration and distribution in the Allwinner H3 System on Chip.<br>
&gt; This commit adds support for the Clock Control Unit which emulates<br>
&gt; a simple read/write register interface.<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A03 +<br>
&gt;=C2=A0 =C2=A0include/hw/misc/allwinner-h3-ccu.h |=C2=A0 66 ++++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A09 +-<br>
&gt;=C2=A0 =C2=A0hw/misc/allwinner-h3-ccu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 243 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A05 files changed, 321 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinner-h3-ccu.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-h3-ccu.c<br>
&gt; <br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index 2aac9b78ec..abdc20871a 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -39,6 +39,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/arm/boot.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/timer/allwinner-a10-pit.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/intc/arm_gic.h&quot;<br>
&gt; +#include &quot;hw/misc/allwinner-h3-ccu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt; @@ -55,6 +56,7 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_A1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_A2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_C,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_CCU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_PIT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_UART0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_UART1,<br>
&gt; @@ -97,6 +99,7 @@ typedef struct AwH3State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ARMCPU cpus[AW_H3_NUM_CPUS];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const hwaddr *memmap;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwA10PITState timer;<br>
&gt; +=C2=A0 =C2=A0 AwH3ClockCtlState ccu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GICState gic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
&gt; diff --git a/include/hw/misc/allwinner-h3-ccu.h b/include/hw/misc/allw=
inner-h3-ccu.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..9c8a887782<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/misc/allwinner-h3-ccu.h<br>
&gt; @@ -0,0 +1,66 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 Clock Control Unit emulation<br>
&gt; + *<br>
&gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HW_MISC_ALLWINNER_H3_CCU_H<br>
&gt; +#define HW_MISC_ALLWINNER_H3_CCU_H<br>
&gt; +<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @name Constants<br>
&gt; + * @{<br>
&gt; + */<br>
&gt; +<br>
&gt; +/** Highest register address used by CCU device */<br>
&gt; +#define AW_H3_CCU_REGS_MAXADDR=C2=A0 (0x304)<br>
<br>
There might be a migration issue if one day we see some firmware <br>
accessing some undocumented register &gt; 0x304 (you&#39;d need to migrate =
more <br>
than 0x304/4 registers, so increase allwinner_h3_ccu_vmstate.version_id.<br=
>
<br>
I&#39;d simply replace this definition by<br>
<br>
=C2=A0 =C2=A0#define AW_H3_CCU_IOSIZE 0x400<br>
<br>
And see comment in write().<br></blockquote><div><br></div><div>Good point,=
 thanks I&#39;ll change that to 0x400!<br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +/** Total number of known registers */<br>
&gt; +#define AW_H3_CCU_REGS_NUM=C2=A0 =C2=A0 =C2=A0 (AW_H3_CCU_REGS_MAXADD=
R / sizeof(uint32_t))<br>
&gt; +<br>
&gt; +/** @} */<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @name Object model<br>
&gt; + * @{<br>
&gt; + */<br>
&gt; +<br>
&gt; +#define TYPE_AW_H3_CCU=C2=A0 =C2=A0 &quot;allwinner-h3-ccu&quot;<br>
&gt; +#define AW_H3_CCU(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CHECK(AwH3ClockCtlState, (obj), TYPE_AW_H3_CCU)<=
br>
&gt; +<br>
&gt; +/** @} */<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Allwinner H3 CCU object instance state.<br>
&gt; + */<br>
&gt; +typedef struct AwH3ClockCtlState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Maps I/O registers in physical memory */<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Array of hardware registers */<br>
&gt; +=C2=A0 =C2=A0 uint32_t regs[AW_H3_CCU_REGS_NUM];<br>
&gt; +<br>
&gt; +} AwH3ClockCtlState;<br>
&gt; +<br>
&gt; +#endif /* HW_MISC_ALLWINNER_H3_CCU_H */<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index efe6042af3..8df8e3e05e 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -36,6 +36,7 @@ const hwaddr allwinner_h3_memmap[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_A1]=C2=A0 =C2=A0 =3D 0x00000000,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00044000,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0x0001=
0000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_CCU]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20000,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_PIT]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x01c20c00,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_UART0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c2=
8000,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_UART1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c2=
8400,<br>
&gt; @@ -77,7 +78,6 @@ struct AwH3Unimplemented {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;usb2&quot;,=C2=A0 =C2=A0 =C2=A0 0x01=
c1c000, 4 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;usb3&quot;,=C2=A0 =C2=A0 =C2=A0 0x01=
c1d000, 4 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;smc&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x01c1e000, 4 * KiB },<br>
&gt; -=C2=A0 =C2=A0 { &quot;ccu&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c20000=
, 1 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;pio&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x01c20800, 1 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;owa&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x01c21000, 1 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;pwm&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x01c21400, 1 * KiB },<br>
&gt; @@ -172,6 +172,9 @@ static void allwinner_h3_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;clk0-freq&quot;, &amp=
;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_add_alias(obj, &quot;clk1-fr=
eq&quot;, OBJECT(&amp;s-&gt;timer),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;clk1-freq&quot;, &amp=
;error_abort);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;ccu&quot;, &amp;s-&gt;=
ccu, sizeof(s-&gt;ccu),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_CCU);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void allwinner_h3_realize(DeviceState *dev, Error *=
*errp)<br>
&gt; @@ -277,6 +280,10 @@ static void allwinner_h3_realize(DeviceState *dev=
, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(get_system_memor=
y(), s-&gt;memmap[AW_H3_SRAM_C],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&gt;sram_c);<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* Clock Control Unit */<br>
&gt; +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;ccu));<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;ccu), 0, s-&g=
t;memmap[AW_H3_CCU]);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* UART0. For future clocktree API: All UART=
S are connected to APB2_CLK. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0serial_mm_init(get_system_memory(), s-&gt;me=
mmap[AW_H3_UART0], 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART0),<br>
&gt; diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c<b=
r>
&gt; new file mode 100644<br>
&gt; index 0000000000..ccf58ccdf2<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/misc/allwinner-h3-ccu.c<br>
&gt; @@ -0,0 +1,243 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 Clock Control Unit emulation<br>
&gt; + *<br>
&gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;hw/misc/allwinner-h3-ccu.h&quot;<br>
&gt; +<br>
&gt; +/* CCU register offsets */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_CPUX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 0x0000, /* PLL CPUX Control */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_AUDIO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0x0008, /* PLL Audio Control */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_VIDEO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0x0010, /* PLL Video Control */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_VE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 0x0018, /* PLL VE Control */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_DDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D 0x0020, /* PLL DDR Control */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_PERIPH0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x0028, /* PLL Peripherals 0 Control */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_GPU=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D 0x0038, /* PLL GPU Control */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_PERIPH1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x0044, /* PLL Peripherals 1 Control */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_DE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 0x0048, /* PLL Display Engine Control */<br>
&gt; +=C2=A0 =C2=A0 REG_CPUX_AXI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 0x0050, /* CPUX/AXI Configuration */<br>
&gt; +=C2=A0 =C2=A0 REG_APB1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D 0x0054, /* ARM Peripheral Bus 1 Config */<br>
&gt; +=C2=A0 =C2=A0 REG_APB2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D 0x0058, /* ARM Peripheral Bus 2 Config */<br>
&gt; +=C2=A0 =C2=A0 REG_DRAM_CFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 0x00F4, /* DRAM Configuration */<br>
&gt; +=C2=A0 =C2=A0 REG_MBUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D 0x00FC, /* MBUS Reset */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_TIME0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0x0200, /* PLL Stable Time 0 */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_TIME1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0x0204, /* PLL Stable Time 1 */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_CPUX_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0220=
, /* PLL CPUX Bias */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_AUDIO_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0224=
, /* PLL Audio Bias */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_VIDEO_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0228=
, /* PLL Video Bias */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_VE_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x022C, /* PLL VE Bias */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_DDR_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0=
x0230, /* PLL DDR Bias */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_PERIPH0_BIAS=C2=A0 =C2=A0 =C2=A0=3D 0x0234, /* =
PLL Peripherals 0 Bias */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_GPU_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0=
x023C, /* PLL GPU Bias */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_PERIPH1_BIAS=C2=A0 =C2=A0 =C2=A0=3D 0x0244, /* =
PLL Peripherals 1 Bias */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_DE_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x0248, /* PLL Display Engine Bias */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_CPUX_TUNING=C2=A0 =C2=A0 =C2=A0 =3D 0x0250, /* =
PLL CPUX Tuning */<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_DDR_TUNING=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0260=
, /* PLL DDR Tuning */<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define REG_INDEX(offset)=C2=A0 =C2=A0 (offset / sizeof(uint32_t))<br=
>
&gt; +<br>
&gt; +/* CCU register flags */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 REG_DRAM_CFG_UPDATE=C2=A0 =C2=A0 =C2=A0 =3D (1 &lt;&lt;=
 16),<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_ENABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D (1 &lt;&lt; 31),<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_LOCK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D (1 &lt;&lt; 28),<br>
&gt; +};<br>
&gt; +<br>
&gt; +<br>
&gt; +/* CCU register reset values */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_CPUX_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0=
x00001000,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_AUDIO_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0003=
5514,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_VIDEO_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0300=
6207,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_VE_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0x03006207,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_DDR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x00001000,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_PERIPH0_RST=C2=A0 =C2=A0 =C2=A0 =3D 0x00041811,=
<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_GPU_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x03006207,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_PERIPH1_RST=C2=A0 =C2=A0 =C2=A0 =3D 0x00041811,=
<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_DE_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0x03006207,<br>
&gt; +=C2=A0 =C2=A0 REG_CPUX_AXI_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0=
x00010000,<br>
&gt; +=C2=A0 =C2=A0 REG_APB1_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 0x00001010,<br>
&gt; +=C2=A0 =C2=A0 REG_APB2_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 0x01000000,<br>
&gt; +=C2=A0 =C2=A0 REG_DRAM_CFG_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0=
x00000000,<br>
&gt; +=C2=A0 =C2=A0 REG_MBUS_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 0x80000000,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_TIME0_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0000=
00FF,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_TIME1_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0000=
00FF,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_CPUX_BIAS_RST=C2=A0 =C2=A0 =3D 0x08100200,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_AUDIO_BIAS_RST=C2=A0 =C2=A0=3D 0x10100000,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_VIDEO_BIAS_RST=C2=A0 =C2=A0=3D 0x10100000,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_VE_BIAS_RST=C2=A0 =C2=A0 =C2=A0 =3D 0x10100000,=
<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_DDR_BIAS_RST=C2=A0 =C2=A0 =C2=A0=3D 0x81104000,=
<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_PERIPH0_BIAS_RST =3D 0x10100010,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_GPU_BIAS_RST=C2=A0 =C2=A0 =C2=A0=3D 0x10100000,=
<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_PERIPH1_BIAS_RST =3D 0x10100010,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_DE_BIAS_RST=C2=A0 =C2=A0 =C2=A0 =3D 0x10100000,=
<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_CPUX_TUNING_RST=C2=A0 =3D 0x0A101000,<br>
&gt; +=C2=A0 =C2=A0 REG_PLL_DDR_TUNING_RST=C2=A0 =C2=A0=3D 0x14880000,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static uint64_t allwinner_h3_ccu_read(void *opaque, hwaddr offset,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned si=
ze)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const AwH3ClockCtlState *s =3D AW_H3_CCU(opaque);<br>
&gt; +=C2=A0 =C2=A0 const uint32_t idx =3D REG_INDEX(offset);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (idx &gt;=3D AW_H3_CCU_REGS_NUM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
<br>
See comment in write().<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;regs[idx];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_h3_ccu_write(void *opaque, hwaddr offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val, unsig=
ned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3ClockCtlState *s =3D AW_H3_CCU(opaque);<br>
&gt; +=C2=A0 =C2=A0 const uint32_t idx =3D REG_INDEX(offset);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (idx &gt;=3D AW_H3_CCU_REGS_NUM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
<br>
I&#39;d replace this check by ...<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_DRAM_CFG:=C2=A0 =C2=A0 /* DRAM Configuration *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val &amp;=3D ~REG_DRAM_CFG_UPDATE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_PLL_CPUX:=C2=A0 =C2=A0 /* PLL CPUX Control */<=
br>
&gt; +=C2=A0 =C2=A0 case REG_PLL_AUDIO:=C2=A0 =C2=A0/* PLL Audio Control */=
<br>
&gt; +=C2=A0 =C2=A0 case REG_PLL_VIDEO:=C2=A0 =C2=A0/* PLL Video Control */=
<br>
&gt; +=C2=A0 =C2=A0 case REG_PLL_VE:=C2=A0 =C2=A0 =C2=A0 /* PLL VE Control =
*/<br>
&gt; +=C2=A0 =C2=A0 case REG_PLL_DDR:=C2=A0 =C2=A0 =C2=A0/* PLL DDR Control=
 */<br>
&gt; +=C2=A0 =C2=A0 case REG_PLL_PERIPH0: /* PLL Peripherals 0 Control */<b=
r>
&gt; +=C2=A0 =C2=A0 case REG_PLL_GPU:=C2=A0 =C2=A0 =C2=A0/* PLL GPU Control=
 */<br>
&gt; +=C2=A0 =C2=A0 case REG_PLL_PERIPH1: /* PLL Peripherals 1 Control */<b=
r>
&gt; +=C2=A0 =C2=A0 case REG_PLL_DE:=C2=A0 =C2=A0 =C2=A0 /* PLL Display Eng=
ine Control */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; REG_PLL_ENABLE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D REG_PLL_LOCK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x304 ... AW_H3_CCU_IOSIZE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &q=
uot;%s: out-of-bounds offset <br>
0x%04x\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br></blockquote><div><br><=
/div><div>OK, looks more compact indeed.<br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: unimpl=
emented write offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[idx] =3D (uint32_t) val;<br>
&gt; +}<br>
<br>
That said,<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div><br><=
/div><div>Thanks!</div><div><br></div><div>Niek<br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +static const MemoryRegionOps allwinner_h3_ccu_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D allwinner_h3_ccu_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D allwinner_h3_ccu_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_ccu_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3ClockCtlState *s =3D AW_H3_CCU(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Set default values for registers */<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_CPUX)] =3D REG_PLL_CPUX_RS=
T;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_AUDIO)] =3D REG_PLL_AUDIO_=
RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_VIDEO)] =3D REG_PLL_VIDEO_=
RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_VE)] =3D REG_PLL_VE_RST;<b=
r>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_DDR)] =3D REG_PLL_DDR_RST;=
<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_PERIPH0)] =3D REG_PLL_PERI=
PH0_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_GPU)] =3D REG_PLL_GPU_RST;=
<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_PERIPH1)] =3D REG_PLL_PERI=
PH1_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_DE)] =3D REG_PLL_DE_RST;<b=
r>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_CPUX_AXI)] =3D REG_CPUX_AXI_RS=
T;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_APB1)] =3D REG_APB1_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_APB2)] =3D REG_APB2_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_DRAM_CFG)] =3D REG_DRAM_CFG_RS=
T;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_MBUS)] =3D REG_MBUS_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_TIME0)] =3D REG_PLL_TIME0_=
RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_TIME1)] =3D REG_PLL_TIME1_=
RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_CPUX_BIAS)] =3D REG_PLL_CP=
UX_BIAS_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_AUDIO_BIAS)] =3D REG_PLL_A=
UDIO_BIAS_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_VIDEO_BIAS)] =3D REG_PLL_V=
IDEO_BIAS_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_VE_BIAS)] =3D REG_PLL_VE_B=
IAS_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_DDR_BIAS)] =3D REG_PLL_DDR=
_BIAS_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_PERIPH0_BIAS)] =3D REG_PLL=
_PERIPH0_BIAS_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_GPU_BIAS)] =3D REG_PLL_GPU=
_BIAS_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_PERIPH1_BIAS)] =3D REG_PLL=
_PERIPH1_BIAS_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_DE_BIAS)] =3D REG_PLL_DE_B=
IAS_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_CPUX_TUNING)] =3D REG_PLL_=
CPUX_TUNING_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_DDR_TUNING)] =3D REG_PLL_D=
DR_TUNING_RST;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_h3_ccu_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
&gt; +=C2=A0 =C2=A0 AwH3ClockCtlState *s =3D AW_H3_CCU(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Memory mapping */<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), &amp=
;allwinner_h3_ccu_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_CCU, 1 * KiB);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateDescription allwinner_h3_ccu_vmstate =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;allwinner-h3-ccu&quot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(regs, AwH3ClockCtlSt=
ate, AW_H3_CCU_REGS_NUM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_ccu_class_init(ObjectClass *klass, void *dat=
a)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D allwinner_h3_ccu_reset;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;allwinner_h3_ccu_vmstate;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo allwinner_h3_ccu_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_H3_=
CCU,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D allwinner_h3_ccu_init,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwH3ClockCtlState),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_h3_ccu_class_ini=
t,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_ccu_register(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_h3_ccu_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(allwinner_h3_ccu_register)<br>
&gt; diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs<br>
&gt; index da993f45b7..5e635b74d5 100644<br>
&gt; --- a/hw/misc/Makefile.objs<br>
&gt; +++ b/hw/misc/Makefile.objs<br>
&gt; @@ -28,6 +28,7 @@ common-obj-$(CONFIG_MACIO) +=3D macio/<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-ccu.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_NSERIES) +=3D cbus.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000002c33e9059d8a324f--

