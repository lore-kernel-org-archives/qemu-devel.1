Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100EDC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 20:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2A6206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 20:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdCL+IIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2A6206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icbXe-0003N5-TJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 15:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1icbVX-0002cf-00
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 15:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1icbVQ-0000U2-V1
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 15:44:22 -0500
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:39469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1icbVO-00088q-Su; Wed, 04 Dec 2019 15:44:16 -0500
Received: by mail-io1-xd33.google.com with SMTP id c16so1107944ioh.6;
 Wed, 04 Dec 2019 12:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R1VDfwEqKI50zMmWhp4rcTzePsgmgtT8/VwZES8y3oU=;
 b=UdCL+IIK8UVOOWZ4kWZ0mPwcp0oklIYMl9OrenLSdFhwLSMkq0X8VSMoJQ2JSPE5+H
 0wJX9ici5qrEHmx8iaXF+2usczxLEMJiYTC2eKNzb3GjmCFLGiRnglXy/Yilu4JV5dpj
 LqlYCNaPVeN9/dosKpEN/neadPLBg5jekTl3SAf+b2SFcqXEfJNVDA6pjnKHrbOTWcWL
 0nhHHG41gk0r+ArtIcFWDQNM2IyZwUe6Ht92xO2jikK+MS+ymhpTgK0Aqyb++3i8y/cV
 8301A4lVLlCyYyBY0vKLv15ZEP2a0PT0I7jEbnPXQKIt1A4fszocF2yM6sD9I8R69rNM
 cBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R1VDfwEqKI50zMmWhp4rcTzePsgmgtT8/VwZES8y3oU=;
 b=N2ZEud446UuXAXzE6dHBkL+yA/u/UxG1XqlyCKu1XZSt48A2DQU0YvKn94/KwbZh7n
 606Ft0lwIfy7+29TTZj2RL3G/+EI+TEUeeIb7eBWiIYp3tTnEdck2ohIuWLWtUuhP+sE
 3UQh2xMrTCMV3VtwXiVYBauAkE8mGqN6bywTCv4D1MdBax2SNdd1BWPuINIgieolOm1O
 IYOv5NC8RW4eH7aEdlbHtWqKts35vISPCHlFI1tAXLvgltFyjt0r/MtCncqQ8jkVyk0S
 0hswhGt2cP0kCFmqnWxqf311T3dWyFzaAExzLxBfCEeoiUAiXbRRRwrovB8TtLDrOCe9
 RyQQ==
X-Gm-Message-State: APjAAAV2E5OzVwtLVMhoIGQ8XvlOSNjBdzWZa/sGUdtNpAlHy/5g/SrQ
 BCRQzY1TLtKMHExPcYsnxMdp9gNlVg88cWmSUwY=
X-Google-Smtp-Source: APXvYqwqrVhGnAZc/YzlN5rBiK6KEnwQ/Fc5ng9nzWgxBms5YzuO1WvjQ94PQGG/TJVEcHtAQ5TMOzaPxPZBLnDqi2w=
X-Received: by 2002:a6b:6f01:: with SMTP id k1mr3755274ioc.28.1575492251645;
 Wed, 04 Dec 2019 12:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-2-nieklinnenbank@gmail.com>
 <5d3961ca-8586-6d93-2525-fd2e29b233e1@redhat.com>
In-Reply-To: <5d3961ca-8586-6d93-2525-fd2e29b233e1@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 4 Dec 2019 21:44:00 +0100
Message-ID: <CAPan3WpeYtA249jp2iF-baFXh2YihEYMiGVtov7DLpsOVb5ZhQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] hw: arm: add Allwinner H3 System-on-Chip
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000017eb20598e6e057"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d33
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
Cc: b.galvani@gmail.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000017eb20598e6e057
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Philippe,

On Wed, Dec 4, 2019 at 5:53 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> Hi Niek,
>
> On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> > The Allwinner H3 is a System on Chip containing four ARM Cortex A7
> > processor cores. Features and specifications include DDR2/DDR3 memory,
> > SD/MMC storage cards, 10/100/1000Mbit ethernet, USB 2.0, HDMI and
> > various I/O modules. This commit adds support for the Allwinner H3
> > System on Chip.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   MAINTAINERS                     |   7 ++
> >   default-configs/arm-softmmu.mak |   1 +
> >   hw/arm/Kconfig                  |   8 ++
> >   hw/arm/Makefile.objs            |   1 +
> >   hw/arm/allwinner-h3.c           | 215 +++++++++++++++++++++++++++++++=
+
> >   include/hw/arm/allwinner-h3.h   | 118 ++++++++++++++++++
> >   6 files changed, 350 insertions(+)
> >   create mode 100644 hw/arm/allwinner-h3.c
> >   create mode 100644 include/hw/arm/allwinner-h3.h
>
> Since your series changes various files, can you have a look at the
> scripts/git.orderfile file and setup it for your QEMU contributions?
>

OK, done! I didn't know such a script existed, thanks.
I ran this command in my local repository:
 $ git config diff.orderFile scripts/git.orderfile
It seems to work, when I re-generate the patches, the order of the diff is
different.



> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5e5e3e52d6..29c9936037 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -479,6 +479,13 @@ F: hw/*/allwinner*
> >   F: include/hw/*/allwinner*
> >   F: hw/arm/cubieboard.c
> >
> > +Allwinner-h3
> > +M: Niek Linnenbank <nieklinnenbank@gmail.com>
> > +L: qemu-arm@nongnu.org
> > +S: Maintained
> > +F: hw/*/allwinner-h3*
> > +F: include/hw/*/allwinner-h3*
> > +
> >   ARM PrimeCell and CMSDK devices
> >   M: Peter Maydell <peter.maydell@linaro.org>
> >   L: qemu-arm@nongnu.org
> > diff --git a/default-configs/arm-softmmu.mak
> b/default-configs/arm-softmmu.mak
> > index 1f2e0e7fde..d75a239c2c 100644
> > --- a/default-configs/arm-softmmu.mak
> > +++ b/default-configs/arm-softmmu.mak
> > @@ -40,3 +40,4 @@ CONFIG_FSL_IMX25=3Dy
> >   CONFIG_FSL_IMX7=3Dy
> >   CONFIG_FSL_IMX6UL=3Dy
> >   CONFIG_SEMIHOSTING=3Dy
> > +CONFIG_ALLWINNER_H3=3Dy
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index c6e7782580..ebf8d2325f 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -291,6 +291,14 @@ config ALLWINNER_A10
> >       select SERIAL
> >       select UNIMP
> >
> > +config ALLWINNER_H3
> > +    bool
> > +    select ALLWINNER_A10_PIT
> > +    select SERIAL
> > +    select ARM_TIMER
> > +    select ARM_GIC
> > +    select UNIMP
> > +
> >   config RASPI
> >       bool
> >       select FRAMEBUFFER
> > diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> > index fe749f65fd..956e496052 100644
> > --- a/hw/arm/Makefile.objs
> > +++ b/hw/arm/Makefile.objs
> > @@ -34,6 +34,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o
> >   obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o
> >   obj-$(CONFIG_STRONGARM) +=3D strongarm.o
> >   obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboard.o
> > +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o
> >   obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o raspi.o
> >   obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
> >   obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu102.o
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > new file mode 100644
> > index 0000000000..470fdfebef
> > --- /dev/null
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -0,0 +1,215 @@
> > +/*
> > + * Allwinner H3 System on Chip emulation
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
> > +#include "exec/address-spaces.h"
> > +#include "qapi/error.h"
> > +#include "qemu/module.h"
> > +#include "qemu/units.h"
> > +#include "cpu.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/arm/allwinner-h3.h"
> > +#include "hw/misc/unimp.h"
> > +#include "sysemu/sysemu.h"
> > +
> > +static void aw_h3_init(Object *obj)
> > +{
> > +    AwH3State *s =3D AW_H3(obj);
> > +
> > +    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
> > +                          TYPE_ARM_GIC);
> > +
> > +    sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
> > +                          TYPE_AW_A10_PIT);
> > +}
> > +
> > +static void aw_h3_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AwH3State *s =3D AW_H3(dev);
> > +    SysBusDevice *sysbusdev =3D NULL;
> > +    Error *err =3D NULL;
> > +    unsigned i =3D 0;
> > +
> > +    /* CPUs */
> > +    for (i =3D 0; i < AW_H3_NUM_CPUS; i++) {
>
> In https://www.mail-archive.com/qemu-devel@nongnu.org/msg662942.html
> Markus noted some incorrect pattern, and apparently you inherited it.
> You should initialize 'err' in the loop.
>
> > +        Object *cpuobj =3D object_new(ARM_CPU_TYPE_NAME("cortex-a7"));
> > +        CPUState *cpustate =3D CPU(cpuobj);
>
> We loose access to the CPUs. Can you use an array of AW_H3_NUM_CPUS cpus
> in AwH3State?
>
> > +
> > +        /* Set the proper CPU index */
> > +        cpustate->cpu_index =3D i;
> > +
> > +        /* Provide Power State Coordination Interface */
> > +        object_property_set_int(cpuobj, QEMU_PSCI_CONDUIT_HVC,
> > +                                "psci-conduit", &error_abort);
>
> Here you use the error_abort shortcut.
>
> > +
> > +        /* Disable secondary CPUs */
> > +        object_property_set_bool(cpuobj, i > 0, "start-powered-off",
> &err);
> > +        if (err !=3D NULL) {
> > +            error_propagate(errp, err);
> > +            return;
>
> Here you return.
>
> > +        }
> > +
> > +        /* All exception levels required */
> > +        object_property_set_bool(cpuobj,
> > +                                 true, "has_el3", NULL);
> > +        object_property_set_bool(cpuobj,
> > +                                 true, "has_el2", NULL);
>
> Here you don't use error.
>
> Cc'ing Markus who is the expert, since he might have better suggestions.
>
> This function is called before the machine starts, and we are not
> handling with user-provided configurations, so I'd say using
> &error_abort in all places is OK.
>
> > +
> > +        /* Mark realized */
> > +        object_property_set_bool(cpuobj, true, "realized", &err);
> > +        if (err !=3D NULL) {
> > +            error_propagate(errp, err);
> > +            return;
> > +        }
> > +        object_unref(cpuobj);
> > +    }
> > +
> > +    /* Generic Interrupt Controller */
> > +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", AW_H3_GIC_NUM_SPI=
 +
> > +                                                     GIC_INTERNAL);
> > +    qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
> > +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", AW_H3_NUM_CPUS);
> > +    qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions",
> false);
> > +    qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions"=
,
> true);
> > +
> > +    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
>
> Why change API? Can we use qdev_init_nofail() instead?
>

> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +
> > +    sysbusdev =3D SYS_BUS_DEVICE(&s->gic);
> > +    sysbus_mmio_map(sysbusdev, 0, AW_H3_GIC_DIST_BASE);
> > +    sysbus_mmio_map(sysbusdev, 1, AW_H3_GIC_CPU_BASE);
> > +    sysbus_mmio_map(sysbusdev, 2, AW_H3_GIC_HYP_BASE);
> > +    sysbus_mmio_map(sysbusdev, 3, AW_H3_GIC_VCPU_BASE);
> > +
> > +    /*
> > +     * Wire the outputs from each CPU's generic timer and the GICv3
> > +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> > +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's
> inputs.
> > +     */
> > +    for (i =3D 0; i < AW_H3_NUM_CPUS; i++) {
> > +        DeviceState *cpudev =3D DEVICE(qemu_get_cpu(i));
> > +        int ppibase =3D AW_H3_GIC_NUM_SPI + i * GIC_INTERNAL +
> GIC_NR_SGIS;
> > +        int irq;
> > +        /*
> > +         * Mapping from the output timer irq lines from the CPU to the
> > +         * GIC PPI inputs used for this board.
> > +         */
> > +        const int timer_irq[] =3D {
> > +            [GTIMER_PHYS] =3D AW_H3_GIC_PPI_ARM_PHYSTIMER,
> > +            [GTIMER_VIRT] =3D AW_H3_GIC_PPI_ARM_VIRTTIMER,
> > +            [GTIMER_HYP]  =3D AW_H3_GIC_PPI_ARM_HYPTIMER,
> > +            [GTIMER_SEC]  =3D AW_H3_GIC_PPI_ARM_SECTIMER,
> > +        };
> > +
> > +        /* Connect CPU timer outputs to GIC PPI inputs */
> > +        for (irq =3D 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> > +            qdev_connect_gpio_out(cpudev, irq,
> > +                                  qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                                   ppibase +
> timer_irq[irq]));
> > +        }
> > +
> > +        /* Connect GIC outputs to CPU interrupt inputs */
> > +        sysbus_connect_irq(sysbusdev, i,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> > +        sysbus_connect_irq(sysbusdev, i + AW_H3_NUM_CPUS,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> > +        sysbus_connect_irq(sysbusdev, i + (2 * AW_H3_NUM_CPUS),
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> > +        sysbus_connect_irq(sysbusdev, i + (3 * AW_H3_NUM_CPUS),
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> > +
> > +        /* GIC maintenance signal */
> > +        sysbus_connect_irq(sysbusdev, i + (4 * AW_H3_NUM_CPUS),
> > +                           qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                            ppibase +
> AW_H3_GIC_PPI_MAINT));
> > +    }
> > +
> > +    for (i =3D 0; i < AW_H3_GIC_NUM_SPI; i++) {
> > +        s->irq[i] =3D qdev_get_gpio_in(DEVICE(&s->gic), i);
>
> Apparently we don't need the irq array in AwH3State, because ...
>
> > +    }
> > +
> > +    /* Timer */
> > +    object_property_set_bool(OBJECT(&s->timer), true, "realized", &err=
);
> > +    if (err !=3D NULL) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +    sysbusdev =3D SYS_BUS_DEVICE(&s->timer);
> > +    sysbus_mmio_map(sysbusdev, 0, AW_H3_PIT_REG_BASE);
> > +    sysbus_connect_irq(sysbusdev, 0, s->irq[AW_H3_GIC_SPI_TIMER0]);
> > +    sysbus_connect_irq(sysbusdev, 1, s->irq[AW_H3_GIC_SPI_TIMER1]);
>
> ... we can call qdev_get_gpio_in() here directly.
>
> > +
> > +    /* SRAM */
> > +    memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
> > +                            AW_H3_SRAM_A1_SIZE, &error_fatal);
> > +    memory_region_init_ram(&s->sram_a2, OBJECT(dev), "sram A2",
> > +                            AW_H3_SRAM_A2_SIZE, &error_fatal);
> > +    memory_region_init_ram(&s->sram_c, OBJECT(dev), "sram C",
> > +                            AW_H3_SRAM_C_SIZE, &error_fatal);
> > +    memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_A1_BAS=
E,
> > +                                &s->sram_a1);
> > +    memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_A2_BAS=
E,
> > +                                &s->sram_a2);
> > +    memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_C_BASE=
,
> > +                                &s->sram_c);
> > +
> > +    /* UART */
> > +    if (serial_hd(0)) {
> > +        serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
> > +                       s->irq[AW_H3_GIC_SPI_UART0], 115200,
> serial_hd(0),
>
> qdev_get_gpio_in() here too.
>
> > +                       DEVICE_NATIVE_ENDIAN);
> > +    }
> > +
> > +    /* Unimplemented devices */
> > +    create_unimplemented_device("display-engine", AW_H3_DE_BASE,
> AW_H3_DE_SIZE);
> > +    create_unimplemented_device("dma", AW_H3_DMA_BASE, AW_H3_DMA_SIZE)=
;
> > +    create_unimplemented_device("lcd0", AW_H3_LCD0_BASE,
> AW_H3_LCD0_SIZE);
> > +    create_unimplemented_device("lcd1", AW_H3_LCD1_BASE,
> AW_H3_LCD1_SIZE);
> > +    create_unimplemented_device("gpu", AW_H3_GPU_BASE, AW_H3_GPU_SIZE)=
;
> > +    create_unimplemented_device("hdmi", AW_H3_HDMI_BASE,
> AW_H3_HDMI_SIZE);
> > +    create_unimplemented_device("rtc", AW_H3_RTC_BASE, AW_H3_RTC_SIZE)=
;
> > +    create_unimplemented_device("audio-codec", AW_H3_AC_BASE,
> AW_H3_AC_SIZE);
> > +}
> > +
> > +static void aw_h3_class_init(ObjectClass *oc, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +
> > +    dc->realize =3D aw_h3_realize;
> > +    /* Reason: uses serial_hds and nd_table */
> > +    dc->user_creatable =3D false;
> > +}
> > +
> > +static const TypeInfo aw_h3_type_info =3D {
> > +    .name =3D TYPE_AW_H3,
> > +    .parent =3D TYPE_DEVICE,
> > +    .instance_size =3D sizeof(AwH3State),
> > +    .instance_init =3D aw_h3_init,
> > +    .class_init =3D aw_h3_class_init,
> > +};
> > +
> > +static void aw_h3_register_types(void)
> > +{
> > +    type_register_static(&aw_h3_type_info);
> > +}
> > +
> > +type_init(aw_h3_register_types)
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > new file mode 100644
> > index 0000000000..af368c2254
> > --- /dev/null
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -0,0 +1,118 @@
> > +/*
> > + * Allwinner H3 System on Chip emulation
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
> > +#ifndef HW_ARM_ALLWINNER_H3_H
> > +#define HW_ARM_ALLWINNER_H3_H
> > +
> > +#include "qemu/error-report.h"
> > +#include "qemu/units.h"
> > +#include "hw/char/serial.h"
> > +#include "hw/arm/boot.h"
> > +#include "hw/timer/allwinner-a10-pit.h"
> > +#include "hw/intc/arm_gic.h"
> > +#include "target/arm/cpu.h"
> > +
> > +#define AW_H3_SRAM_A1_BASE     (0x00000000)
> > +#define AW_H3_SRAM_A2_BASE     (0x00044000)
> > +#define AW_H3_SRAM_C_BASE      (0x00010000)
> > +#define AW_H3_DE_BASE          (0x01000000)
> > +#define AW_H3_SYSCON_BASE      (0x01c00000)
> > +#define AW_H3_DMA_BASE         (0x01c02000)
> > +#define AW_H3_LCD0_BASE        (0x01c0c000)
> > +#define AW_H3_LCD1_BASE        (0x01c0d000)
> > +#define AW_H3_SID_BASE         (0x01c14000)
> > +#define AW_H3_CCU_BASE         (0x01c20000)
> > +#define AW_H3_PIC_REG_BASE     (0x01c20400)
> > +#define AW_H3_PIT_REG_BASE     (0x01c20c00)
> > +#define AW_H3_AC_BASE          (0x01c22c00)
> > +#define AW_H3_UART0_REG_BASE   (0x01c28000)
> > +#define AW_H3_EMAC_BASE        (0x01c30000)
> > +#define AW_H3_MMC0_BASE        (0x01c0f000)
> > +#define AW_H3_EHCI0_BASE       (0x01c1a000)
> > +#define AW_H3_OHCI0_BASE       (0x01c1a400)
> > +#define AW_H3_EHCI1_BASE       (0x01c1b000)
> > +#define AW_H3_OHCI1_BASE       (0x01c1b400)
> > +#define AW_H3_EHCI2_BASE       (0x01c1c000)
> > +#define AW_H3_OHCI2_BASE       (0x01c1c400)
> > +#define AW_H3_EHCI3_BASE       (0x01c1d000)
> > +#define AW_H3_OHCI3_BASE       (0x01c1d400)
> > +#define AW_H3_GPU_BASE         (0x01c40000)
> > +#define AW_H3_GIC_DIST_BASE    (0x01c81000)
> > +#define AW_H3_GIC_CPU_BASE     (0x01c82000)
> > +#define AW_H3_GIC_HYP_BASE     (0x01c84000)
> > +#define AW_H3_GIC_VCPU_BASE    (0x01c86000)
> > +#define AW_H3_HDMI_BASE        (0x01ee0000)
> > +#define AW_H3_RTC_BASE         (0x01f00000)
> > +#define AW_H3_CPUCFG_BASE      (0x01f01c00)
> > +#define AW_H3_SDRAM_BASE       (0x40000000)
> > +
> > +#define AW_H3_SRAM_A1_SIZE     (64 * KiB)
> > +#define AW_H3_SRAM_A2_SIZE     (32 * KiB)
> > +#define AW_H3_SRAM_C_SIZE      (44 * KiB)
> > +#define AW_H3_DE_SIZE          (4 * MiB)
> > +#define AW_H3_DMA_SIZE         (4 * KiB)
> > +#define AW_H3_LCD0_SIZE        (4 * KiB)
> > +#define AW_H3_LCD1_SIZE        (4 * KiB)
> > +#define AW_H3_GPU_SIZE         (64 * KiB)
> > +#define AW_H3_HDMI_SIZE        (128 * KiB)
> > +#define AW_H3_RTC_SIZE         (1 * KiB)
> > +#define AW_H3_AC_SIZE          (2 * KiB)
> > +
> > +#define AW_H3_GIC_PPI_MAINT          (9)
> > +#define AW_H3_GIC_PPI_ARM_HYPTIMER  (10)
> > +#define AW_H3_GIC_PPI_ARM_VIRTTIMER (11)
> > +#define AW_H3_GIC_PPI_ARM_SECTIMER  (13)
> > +#define AW_H3_GIC_PPI_ARM_PHYSTIMER (14)
> > +
> > +#define AW_H3_GIC_SPI_UART0         (0)
> > +#define AW_H3_GIC_SPI_TIMER0        (18)
> > +#define AW_H3_GIC_SPI_TIMER1        (19)
> > +#define AW_H3_GIC_SPI_MMC0          (60)
> > +#define AW_H3_GIC_SPI_MMC1          (61)
> > +#define AW_H3_GIC_SPI_MMC2          (62)
> > +#define AW_H3_GIC_SPI_EHCI0         (72)
> > +#define AW_H3_GIC_SPI_OHCI0         (73)
> > +#define AW_H3_GIC_SPI_EHCI1         (74)
> > +#define AW_H3_GIC_SPI_OHCI1         (75)
> > +#define AW_H3_GIC_SPI_EHCI2         (76)
> > +#define AW_H3_GIC_SPI_OHCI2         (77)
> > +#define AW_H3_GIC_SPI_EHCI3         (78)
> > +#define AW_H3_GIC_SPI_OHCI3         (79)
> > +#define AW_H3_GIC_SPI_EMAC          (82)
>
> I'd move half of the previous definitions into allwinner-h3.c, since
> they are only used there.
>
> Indeed, you are right, I'll move them.

Also, I'd use an enum for the PPI/SPI.
>

Thanks, I will process all of your comments above for the next patch
version.


>
>
> +
> > +#define AW_H3_GIC_NUM_SPI           (128)
> > +#define AW_H3_NUM_CPUS              (4)
> > +
> > +#define TYPE_AW_H3 "allwinner-h3"
> > +#define AW_H3(obj) OBJECT_CHECK(AwH3State, (obj), TYPE_AW_H3)
> > +
> > +typedef struct AwH3State {
> > +    /*< private >*/
> > +    DeviceState parent_obj;
> > +    /*< public >*/
> > +
> > +    qemu_irq irq[AW_H3_GIC_NUM_SPI];
> > +    AwA10PITState timer;
> > +    GICState gic;
> > +    MemoryRegion sram_a1;
> > +    MemoryRegion sram_a2;
> > +    MemoryRegion sram_c;
> > +} AwH3State;
> > +
> > +#endif
> >
>
> Nice clean patch, for a first contribution :)
>

Thank you Philippe!

Regards,
Niek

--=20
Niek Linnenbank

--000000000000017eb20598e6e057
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Philippe,<br></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 4, 2019 at 5:53 PM Phi=
lippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi Niek,<br>
<br>
On 12/2/19 10:09 PM, Niek Linnenbank wrote:<br>
&gt; The Allwinner H3 is a System on Chip containing four ARM Cortex A7<br>
&gt; processor cores. Features and specifications include DDR2/DDR3 memory,=
<br>
&gt; SD/MMC storage cards, 10/100/1000Mbit ethernet, USB 2.0, HDMI and<br>
&gt; various I/O modules. This commit adds support for the Allwinner H3<br>
&gt; System on Chip.<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 ++<br>
&gt;=C2=A0 =C2=A0default-configs/arm-softmmu.mak |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 ++<br>
&gt;=C2=A0 =C2=A0hw/arm/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 215 ++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0| 118 ++++++++++=
++++++++<br>
&gt;=C2=A0 =C2=A06 files changed, 350 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/arm/allwinner-h3.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/arm/allwinner-h3.h<br>
<br>
Since your series changes various files, can you have a look at the <br>
scripts/git.orderfile file and setup it for your QEMU contributions?<br></b=
lockquote><div><br></div><div>OK, done! I didn&#39;t know such a script exi=
sted, thanks.</div><div>I ran this command in my local repository:</div><di=
v>=C2=A0$ git config diff.orderFile scripts/git.orderfile<br></div><div>It =
seems to work, when I re-generate the patches, the order of the diff is dif=
ferent.<br></div><div>=C2=A0</div><div><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 5e5e3e52d6..29c9936037 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -479,6 +479,13 @@ F: hw/*/allwinner*<br>
&gt;=C2=A0 =C2=A0F: include/hw/*/allwinner*<br>
&gt;=C2=A0 =C2=A0F: hw/arm/cubieboard.c<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +Allwinner-h3<br>
&gt; +M: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" ta=
rget=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; +L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank">qemu-arm@=
nongnu.org</a><br>
&gt; +S: Maintained<br>
&gt; +F: hw/*/allwinner-h3*<br>
&gt; +F: include/hw/*/allwinner-h3*<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0ARM PrimeCell and CMSDK devices<br>
&gt;=C2=A0 =C2=A0M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank=
">qemu-arm@nongnu.org</a><br>
&gt; diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak<br>
&gt; index 1f2e0e7fde..d75a239c2c 100644<br>
&gt; --- a/default-configs/arm-softmmu.mak<br>
&gt; +++ b/default-configs/arm-softmmu.mak<br>
&gt; @@ -40,3 +40,4 @@ CONFIG_FSL_IMX25=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_FSL_IMX7=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_FSL_IMX6UL=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_SEMIHOSTING=3Dy<br>
&gt; +CONFIG_ALLWINNER_H3=3Dy<br>
&gt; diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
&gt; index c6e7782580..ebf8d2325f 100644<br>
&gt; --- a/hw/arm/Kconfig<br>
&gt; +++ b/hw/arm/Kconfig<br>
&gt; @@ -291,6 +291,14 @@ config ALLWINNER_A10<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select SERIAL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select UNIMP<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config ALLWINNER_H3<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 select ALLWINNER_A10_PIT<br>
&gt; +=C2=A0 =C2=A0 select SERIAL<br>
&gt; +=C2=A0 =C2=A0 select ARM_TIMER<br>
&gt; +=C2=A0 =C2=A0 select ARM_GIC<br>
&gt; +=C2=A0 =C2=A0 select UNIMP<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0config RASPI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select FRAMEBUFFER<br>
&gt; diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs<br>
&gt; index fe749f65fd..956e496052 100644<br>
&gt; --- a/hw/arm/Makefile.objs<br>
&gt; +++ b/hw/arm/Makefile.objs<br>
&gt; @@ -34,6 +34,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_STRONGARM) +=3D strongarm.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboar=
d.o<br>
&gt; +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o r=
aspi.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu1=
02.o<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..470fdfebef<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -0,0 +1,215 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 System on Chip emulation<br>
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
&gt; +#include &quot;exec/address-spaces.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;hw/arm/allwinner-h3.h&quot;<br>
&gt; +#include &quot;hw/misc/unimp.h&quot;<br>
&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt; +<br>
&gt; +static void aw_h3_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3State *s =3D AW_H3(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;gic&quot;, &amp;s-&gt;=
gic, sizeof(s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_ARM_GIC);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;timer&quot;, &amp;s-&g=
t;timer, sizeof(s-&gt;timer),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_A10_PIT);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_realize(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3State *s =3D AW_H3(dev);<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sysbusdev =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 unsigned i =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* CPUs */<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; AW_H3_NUM_CPUS; i++) {<br>
<br>
In <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg662942.=
html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qem=
u-devel@nongnu.org/msg662942.html</a><br>
Markus noted some incorrect pattern, and apparently you inherited it.<br>
You should initialize &#39;err&#39; in the loop.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Object *cpuobj =3D object_new(ARM_CPU_TYP=
E_NAME(&quot;cortex-a7&quot;));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUState *cpustate =3D CPU(cpuobj);<br>
<br>
We loose access to the CPUs. Can you use an array of AW_H3_NUM_CPUS cpus <b=
r>
in AwH3State?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the proper CPU index */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpustate-&gt;cpu_index =3D i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Provide Power State Coordination Inter=
face */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_int(cpuobj, QEMU_PSCI=
_CONDUIT_HVC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;psci-conduit&quot;, &amp;e=
rror_abort);<br>
<br>
Here you use the error_abort shortcut.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Disable secondary CPUs */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(cpuobj, i &gt; 0=
, &quot;start-powered-off&quot;, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
Here you return.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* All exception levels required */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(cpuobj,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true, &quot;has_el3&quot;,=
 NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(cpuobj,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true, &quot;has_el2&quot;,=
 NULL);<br>
<br>
Here you don&#39;t use error.<br>
<br>
Cc&#39;ing Markus who is the expert, since he might have better suggestions=
.<br>
<br>
This function is called before the machine starts, and we are not <br>
handling with user-provided configurations, so I&#39;d say using <br>
&amp;error_abort in all places is OK.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Mark realized */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(cpuobj, true, &q=
uot;realized&quot;, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unref(cpuobj);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Generic Interrupt Controller */<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;gic), &quot;num-=
irq&quot;, AW_H3_GIC_NUM_SPI +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GIC_INTERNAL);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;gic), &quot;revi=
sion&quot;, 2);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;gic), &quot;num-=
cpu&quot;, AW_H3_NUM_CPUS);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_bit(DEVICE(&amp;s-&gt;gic), &quot;has-sec=
urity-extensions&quot;, false);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_bit(DEVICE(&amp;s-&gt;gic), &quot;has-vir=
tualization-extensions&quot;, true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;gic), true, =
&quot;realized&quot;, &amp;err);<br>
<br>
Why change API? Can we use qdev_init_nofail() instead?<br></blockquote><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 if (err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbusdev =3D SYS_BUS_DEVICE(&amp;s-&gt;gic);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(sysbusdev, 0, AW_H3_GIC_DIST_BASE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(sysbusdev, 1, AW_H3_GIC_CPU_BASE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(sysbusdev, 2, AW_H3_GIC_HYP_BASE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(sysbusdev, 3, AW_H3_GIC_VCPU_BASE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Wire the outputs from each CPU&#39;s generic ti=
mer and the GICv3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* maintenance interrupt signal to the appropriate=
 GIC PPI inputs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and the GIC&#39;s IRQ/FIQ/VIRQ/VFIQ interrupt o=
utputs to the CPU&#39;s inputs.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; AW_H3_NUM_CPUS; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *cpudev =3D DEVICE(qemu_get_c=
pu(i));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ppibase =3D AW_H3_GIC_NUM_SPI + i * G=
IC_INTERNAL + GIC_NR_SGIS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int irq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Mapping from the output timer irq=
 lines from the CPU to the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* GIC PPI inputs used for this boar=
d.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int timer_irq[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [GTIMER_PHYS] =3D AW_H3_GIC=
_PPI_ARM_PHYSTIMER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [GTIMER_VIRT] =3D AW_H3_GIC=
_PPI_ARM_VIRTTIMER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [GTIMER_HYP]=C2=A0 =3D AW_H=
3_GIC_PPI_ARM_HYPTIMER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [GTIMER_SEC]=C2=A0 =3D AW_H=
3_GIC_PPI_ARM_SECTIMER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Connect CPU timer outputs to GIC PPI i=
nputs */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (irq =3D 0; irq &lt; ARRAY_SIZE(timer=
_irq); irq++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(cpude=
v, irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&=
amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ppibase + timer_irq[irq]));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Connect GIC outputs to CPU interrupt i=
nputs */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(sysbusdev, i,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(sysbusdev, i + AW_H3_N=
UM_CPUS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(sysbusdev, i + (2 * AW=
_H3_NUM_CPUS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(sysbusdev, i + (3 * AW=
_H3_NUM_CPUS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* GIC maintenance signal */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(sysbusdev, i + (4 * AW=
_H3_NUM_CPUS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ppibase + AW_H3_GIC_PPI_MAINT));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; AW_H3_GIC_NUM_SPI; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq[i] =3D qdev_get_gpio_in(DEVICE(=
&amp;s-&gt;gic), i);<br>
<br>
Apparently we don&#39;t need the irq array in AwH3State, because ...<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Timer */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;timer), true=
, &quot;realized&quot;, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 sysbusdev =3D SYS_BUS_DEVICE(&amp;s-&gt;timer);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(sysbusdev, 0, AW_H3_PIT_REG_BASE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(sysbusdev, 0, s-&gt;irq[AW_H3_GIC_SP=
I_TIMER0]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(sysbusdev, 1, s-&gt;irq[AW_H3_GIC_SP=
I_TIMER1]);<br>
<br>
... we can call qdev_get_gpio_in() here directly.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* SRAM */<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_ram(&amp;s-&gt;sram_a1, OBJECT(dev),=
 &quot;sram A1&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AW_H3_SRAM_A1_SIZE, &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_ram(&amp;s-&gt;sram_a2, OBJECT(dev),=
 &quot;sram A2&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AW_H3_SRAM_A2_SIZE, &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_ram(&amp;s-&gt;sram_c, OBJECT(dev), =
&quot;sram C&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AW_H3_SRAM_C_SIZE, &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), AW_H3_=
SRAM_A1_BASE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sram_a1);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), AW_H3_=
SRAM_A2_BASE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sram_a2);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), AW_H3_=
SRAM_C_BASE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sram_c);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* UART */<br>
&gt; +=C2=A0 =C2=A0 if (serial_hd(0)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_mm_init(get_system_memory(), AW_H3=
_UART0_REG_BASE, 2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_UART0], 115200, serial_hd(0),<br>
<br>
qdev_get_gpio_in() here too.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0DEVICE_NATIVE_ENDIAN);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Unimplemented devices */<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;display-engine&quot;,=
 AW_H3_DE_BASE, AW_H3_DE_SIZE);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;dma&quot;, AW_H3_DMA_=
BASE, AW_H3_DMA_SIZE);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;lcd0&quot;, AW_H3_LCD=
0_BASE, AW_H3_LCD0_SIZE);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;lcd1&quot;, AW_H3_LCD=
1_BASE, AW_H3_LCD1_SIZE);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;gpu&quot;, AW_H3_GPU_=
BASE, AW_H3_GPU_SIZE);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;hdmi&quot;, AW_H3_HDM=
I_BASE, AW_H3_HDMI_SIZE);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;rtc&quot;, AW_H3_RTC_=
BASE, AW_H3_RTC_SIZE);<br>
&gt; +=C2=A0 =C2=A0 create_unimplemented_device(&quot;audio-codec&quot;, AW=
_H3_AC_BASE, AW_H3_AC_SIZE);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_class_init(ObjectClass *oc, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D aw_h3_realize;<br>
&gt; +=C2=A0 =C2=A0 /* Reason: uses serial_hds and nd_table */<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;user_creatable =3D false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo aw_h3_type_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_AW_H3,<br>
&gt; +=C2=A0 =C2=A0 .parent =3D TYPE_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwH3State),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D aw_h3_init,<br>
&gt; +=C2=A0 =C2=A0 .class_init =3D aw_h3_class_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void aw_h3_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;aw_h3_type_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(aw_h3_register_types)<br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..af368c2254<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -0,0 +1,118 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 System on Chip emulation<br>
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
&gt; +#ifndef HW_ARM_ALLWINNER_H3_H<br>
&gt; +#define HW_ARM_ALLWINNER_H3_H<br>
&gt; +<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;hw/char/serial.h&quot;<br>
&gt; +#include &quot;hw/arm/boot.h&quot;<br>
&gt; +#include &quot;hw/timer/allwinner-a10-pit.h&quot;<br>
&gt; +#include &quot;hw/intc/arm_gic.h&quot;<br>
&gt; +#include &quot;target/arm/cpu.h&quot;<br>
&gt; +<br>
&gt; +#define AW_H3_SRAM_A1_BASE=C2=A0 =C2=A0 =C2=A0(0x00000000)<br>
&gt; +#define AW_H3_SRAM_A2_BASE=C2=A0 =C2=A0 =C2=A0(0x00044000)<br>
&gt; +#define AW_H3_SRAM_C_BASE=C2=A0 =C2=A0 =C2=A0 (0x00010000)<br>
&gt; +#define AW_H3_DE_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x01000000)<=
br>
&gt; +#define AW_H3_SYSCON_BASE=C2=A0 =C2=A0 =C2=A0 (0x01c00000)<br>
&gt; +#define AW_H3_DMA_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c02000)<=
br>
&gt; +#define AW_H3_LCD0_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x01c0c000)<br>
&gt; +#define AW_H3_LCD1_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x01c0d000)<br>
&gt; +#define AW_H3_SID_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c14000)<=
br>
&gt; +#define AW_H3_CCU_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c20000)<=
br>
&gt; +#define AW_H3_PIC_REG_BASE=C2=A0 =C2=A0 =C2=A0(0x01c20400)<br>
&gt; +#define AW_H3_PIT_REG_BASE=C2=A0 =C2=A0 =C2=A0(0x01c20c00)<br>
&gt; +#define AW_H3_AC_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x01c22c00)<=
br>
&gt; +#define AW_H3_UART0_REG_BASE=C2=A0 =C2=A0(0x01c28000)<br>
&gt; +#define AW_H3_EMAC_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x01c30000)<br>
&gt; +#define AW_H3_MMC0_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x01c0f000)<br>
&gt; +#define AW_H3_EHCI0_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c1a000)<br>
&gt; +#define AW_H3_OHCI0_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c1a400)<br>
&gt; +#define AW_H3_EHCI1_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c1b000)<br>
&gt; +#define AW_H3_OHCI1_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c1b400)<br>
&gt; +#define AW_H3_EHCI2_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c1c000)<br>
&gt; +#define AW_H3_OHCI2_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c1c400)<br>
&gt; +#define AW_H3_EHCI3_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c1d000)<br>
&gt; +#define AW_H3_OHCI3_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c1d400)<br>
&gt; +#define AW_H3_GPU_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01c40000)<=
br>
&gt; +#define AW_H3_GIC_DIST_BASE=C2=A0 =C2=A0 (0x01c81000)<br>
&gt; +#define AW_H3_GIC_CPU_BASE=C2=A0 =C2=A0 =C2=A0(0x01c82000)<br>
&gt; +#define AW_H3_GIC_HYP_BASE=C2=A0 =C2=A0 =C2=A0(0x01c84000)<br>
&gt; +#define AW_H3_GIC_VCPU_BASE=C2=A0 =C2=A0 (0x01c86000)<br>
&gt; +#define AW_H3_HDMI_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x01ee0000)<br>
&gt; +#define AW_H3_RTC_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x01f00000)<=
br>
&gt; +#define AW_H3_CPUCFG_BASE=C2=A0 =C2=A0 =C2=A0 (0x01f01c00)<br>
&gt; +#define AW_H3_SDRAM_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x40000000)<br>
&gt; +<br>
&gt; +#define AW_H3_SRAM_A1_SIZE=C2=A0 =C2=A0 =C2=A0(64 * KiB)<br>
&gt; +#define AW_H3_SRAM_A2_SIZE=C2=A0 =C2=A0 =C2=A0(32 * KiB)<br>
&gt; +#define AW_H3_SRAM_C_SIZE=C2=A0 =C2=A0 =C2=A0 (44 * KiB)<br>
&gt; +#define AW_H3_DE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (4 * MiB)<br>
&gt; +#define AW_H3_DMA_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(4 * KiB)<br>
&gt; +#define AW_H3_LCD0_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (4 * KiB)<br>
&gt; +#define AW_H3_LCD1_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (4 * KiB)<br>
&gt; +#define AW_H3_GPU_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(64 * KiB)<br=
>
&gt; +#define AW_H3_HDMI_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (128 * KiB)<br>
&gt; +#define AW_H3_RTC_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 * KiB)<br>
&gt; +#define AW_H3_AC_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (2 * KiB)<br>
&gt; +<br>
&gt; +#define AW_H3_GIC_PPI_MAINT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (9)<br>
&gt; +#define AW_H3_GIC_PPI_ARM_HYPTIMER=C2=A0 (10)<br>
&gt; +#define AW_H3_GIC_PPI_ARM_VIRTTIMER (11)<br>
&gt; +#define AW_H3_GIC_PPI_ARM_SECTIMER=C2=A0 (13)<br>
&gt; +#define AW_H3_GIC_PPI_ARM_PHYSTIMER (14)<br>
&gt; +<br>
&gt; +#define AW_H3_GIC_SPI_UART0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0)<br>
&gt; +#define AW_H3_GIC_SPI_TIMER0=C2=A0 =C2=A0 =C2=A0 =C2=A0 (18)<br>
&gt; +#define AW_H3_GIC_SPI_TIMER1=C2=A0 =C2=A0 =C2=A0 =C2=A0 (19)<br>
&gt; +#define AW_H3_GIC_SPI_MMC0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (60)<br>
&gt; +#define AW_H3_GIC_SPI_MMC1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (61)<br>
&gt; +#define AW_H3_GIC_SPI_MMC2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (62)<br>
&gt; +#define AW_H3_GIC_SPI_EHCI0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(72)<br>
&gt; +#define AW_H3_GIC_SPI_OHCI0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(73)<br>
&gt; +#define AW_H3_GIC_SPI_EHCI1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(74)<br>
&gt; +#define AW_H3_GIC_SPI_OHCI1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(75)<br>
&gt; +#define AW_H3_GIC_SPI_EHCI2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(76)<br>
&gt; +#define AW_H3_GIC_SPI_OHCI2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(77)<br>
&gt; +#define AW_H3_GIC_SPI_EHCI3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(78)<br>
&gt; +#define AW_H3_GIC_SPI_OHCI3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(79)<br>
&gt; +#define AW_H3_GIC_SPI_EMAC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (82)<br>
<br>
I&#39;d move half of the previous definitions into allwinner-h3.c, since <b=
r>
they are only used there.<br>
<br></blockquote><div>Indeed, you are right, I&#39;ll move them.<br></div><=
div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Also, I&#39;d use an enum for the PPI/SPI. <br></blockquote><div><br></div>=
<div></div><div> Thanks, I will process all of your comments above for the =
next patch version.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">=C2=A0
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +#define AW_H3_GIC_NUM_SPI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(12=
8)<br>
&gt; +#define AW_H3_NUM_CPUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (4)<br>
&gt; +<br>
&gt; +#define TYPE_AW_H3 &quot;allwinner-h3&quot;<br>
&gt; +#define AW_H3(obj) OBJECT_CHECK(AwH3State, (obj), TYPE_AW_H3)<br>
&gt; +<br>
&gt; +typedef struct AwH3State {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 DeviceState parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq[AW_H3_GIC_NUM_SPI];<br>
&gt; +=C2=A0 =C2=A0 AwA10PITState timer;<br>
&gt; +=C2=A0 =C2=A0 GICState gic;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion sram_a1;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion sram_a2;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion sram_c;<br>
&gt; +} AwH3State;<br>
&gt; +<br>
&gt; +#endif<br>
&gt; <br>
<br>
Nice clean patch, for a first contribution :)<br></blockquote><div><br></di=
v><div>Thank you Philippe!=C2=A0 <br></div></div><div><br></div><div>Regard=
s,</div><div>Niek<br></div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signa=
ture"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>

--000000000000017eb20598e6e057--

