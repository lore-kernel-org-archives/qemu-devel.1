Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B2CC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9642070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="44kTAMtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9642070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5nNP-00037j-8h
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 04:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1i5nKv-0002JH-El
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1i5nKt-0003g5-Db
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:41:49 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:50550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1i5nKo-0003b8-Hf; Thu, 05 Sep 2019 04:41:43 -0400
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id CB72196F65;
 Thu,  5 Sep 2019 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1567672897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grQHxR8vBHWMujaDt7LSohFXescVlKVMHDbubmERLUQ=;
 b=44kTAMtc1IPKNQlqU6tnaho9wG3zSKjvWngqBDWADbkHNocFJT3WLO7hgAbRtMacsDamiX
 Gva9Zc5U2inbBfJziAjZgKLTXipGqUdZLrh/7+BEjCPQ8ZGwGOp3PsHiQL2LxclKuczYSs
 4KT8DFYCKhXGen+ylozkzL61ofhJi1U=
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>, =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?=
 <bztemail@gmail.com>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-13-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <67b8cffa-23ae-35d3-1a74-78bfccfdcb8c@greensocs.com>
Date: Thu, 5 Sep 2019 10:41:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190904171315.8354-13-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1567672897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grQHxR8vBHWMujaDt7LSohFXescVlKVMHDbubmERLUQ=;
 b=DiOmFPiqDC8fhz3llhjhHsQqGz3h/ClPtXyT8ag+yAh290wsQcxhvearEErvYk0aGX5I06
 I8UKWtacjsZzajrOske7Rk9cU3fwJi3FnOziECA2iauzKGrpWsM5PB5sXJjz3XeINf2PbM
 Z2Wr1PMG7b3QmopLb4gh+ZpsbSuLfvU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1567672897; a=rsa-sha256; cv=none;
 b=3ahaiGH0D2Pjd98HJBM7bfZEHSOeqRpUJlh6zJDxtDor2vHcj8Y6YeylAYJRu3prtmQjwB
 rRHYGdbBlIeSiQOgFjpxPdkQWhTVmeWFxvX+IB0hN5M4UPHMnFK/qlylPaAlN28hon6cV+
 k8KHwus3Mm0f0/aokLWZYLU1JEfDkAM=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [RFC PATCH 12/14] hw/arm/bcm2836: Add the BCM2838
 which uses a GICv2
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 9/4/19 7:13 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The BCM2838 is improvement of the BCM2837:
> - Cortex-A72 instead of the A53
> - peripheral block and local soc controller are mapped differently,
> - GICv2
> - PCIe block
> - exhanced MMU to address over 4GiB of SDRAM
>=20
> See https://www.raspberrypi.org/forums/viewtopic.php?t=3D244479&start=3D=
25
> and https://patchwork.kernel.org/patch/11053097/
>=20
> This patch starts mapping the GICv2 but interrupt lines are NOT
> wired (yet).
>=20
> This is enough to start running the Ubuntu kernel8.img from [1].
>=20
> Extract the kernel with:
>=20
>    $ mkdir bootpart
>    $ guestfish \
>        --ro \
>        -a ubuntu-18.04.3-preinstalled-server-arm64+raspi4.img \
>        -m /dev/sda1
>    Welcome to guestfish, the guest filesystem shell for
>    editing virtual machine filesystems and disk images.
>=20
>    ><fs> ls /
>    COPYING.linux
>    LICENCE.broadcom
>    System.map
>    armstub8-gic.bin
>    bcm2710-rpi-3-b-plus.dtb
>    bcm2710-rpi-3-b.dtb
>    bcm2710-rpi-cm3.dtb
>    bcm2711-rpi-4-b.dtb
>    bcm2837-rpi-3-b-plus.dtb
>    bcm2837-rpi-3-b.dtb
>    cmdline.txt
>    config.txt
>    fixup4.dat
>    fixup4cd.dat
>    fixup4db.dat
>    fixup4x.dat
>    kernel8.img
>    overlays
>    start4.elf
>    start4cd.elf
>    start4db.elf
>    start4x.elf
>    ><fs> copy-out / bootpart/
>    ><fs> q
>=20
> Then some progress can be noticed running:
>=20
>    $ qemu-system-aarch64 -d unimp,guest_errors,int,in_asm \
>        -M raspi4 \
>        -kernel bootpart/kernel8.img \
>        -dtb bootpart/bcm2711-rpi-4-b.dtb \
>        -initrd bootpart/boot/initrd.img \
>        -append \
>           "earlycon=3Dpl011,0xfe201000 console=3DttyAMA0 console=3Dtty1=
 loglevel=3D8"
>=20
> Not very interesting, but it runs until configuring the GIC.
> (remove 'in_asm' if too verbose).
>=20
> TODO:
>=20
> - wire IRQs to the GIC :)
>=20
> - map the SPI bootrom from [3] (boot sequence: [4])
>=20
> - per [2] we could try booting without using the GIC, adding "enable_gi=
c=3D0"
>    in config.txt. this variable is parsed by the firmware:
>=20
>    $ fgrep -r enable_gic bootpart
>    Binary file bootpart/start4x.elf matches
>    Binary file bootpart/start4.elf matches
>    Binary file bootpart/start4db.elf matches
>    Binary file bootpart/start4cd.elf matches
>    bootpart/config.txt:enable_gic=3D1
>=20
>    the stub [5] doesn't seem to check a register for it.
>    maybe it falls back to kernel7l?
>=20
> - decompile start4.elf to check how 'enable_gic' is used
>    using vc4 toolchain from [6]
>=20
> [1] https://github.com/TheRemote/Ubuntu-Server-raspi4-unofficial/releas=
es
> [2] https://jamesachambers.com/raspberry-pi-ubuntu-server-18-04-2-insta=
llation-guide/
> [3] https://www.raspberrypi.org/documentation/hardware/raspberrypi/boot=
eeprom.md
> [4] https://raspberrypi.stackexchange.com/questions/10442/what-is-the-b=
oot-sequence
> [5] https://github.com/raspberrypi/tools/commit/7f4a937e1bacbc111a22552=
169bc890b4bb26a94#diff-8c41083e9fa0c98f1c3015e11b897444
> [6] https://github.com/christinaa/rpi-open-firmware
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/arm/bcm2836.c         | 75 +++++++++++++++++++++++++++++++++++++++=
+
>   include/hw/arm/bcm2836.h |  3 ++
>   2 files changed, 78 insertions(+)
>=20
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 019e67b906..d89d7cd71d 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -21,6 +21,7 @@ struct BCM283XInfo {
>       const char *cpu_type;
>       hwaddr peri_base; /* Peripheral base address seen by the CPU */
>       hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
> +    hwaddr gic_base;
>       int clusterid;
>   };
>  =20
> @@ -40,9 +41,25 @@ static const BCM283XInfo bcm283x_socs[] =3D {
>           .ctrl_base =3D 0x40000000,
>           .clusterid =3D 0x0,
>       },
> +    {
> +        .name =3D TYPE_BCM2838,
> +        .cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a72"),
> +        .peri_base =3D 0xfe000000,
> +        .ctrl_base =3D 0xff800000,
> +        .gic_base =3D 0x40000,
> +    },
>   #endif
>   };
>  =20
> +#define GIC_NUM_IRQS                256
> +
> +#define GIC_BASE_OFS                0x0000
> +#define GIC_DIST_OFS                0x1000
> +#define GIC_CPU_OFS                 0x2000
> +#define GIC_VIFACE_THIS_OFS         0x4000
> +#define GIC_VIFACE_OTHER_OFS(cpu)  (0x5000 + (cpu) * 0x200)
> +#define GIC_VCPU_OFS                0x6000
> +
>   static void bcm2836_init(Object *obj)
>   {
>       BCM283XState *s =3D BCM283X(obj);
> @@ -55,6 +72,11 @@ static void bcm2836_init(Object *obj)
>                                   info->cpu_type, &error_abort, NULL);
>       }
>  =20
> +    if (info->gic_base) {
> +        sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
> +                              TYPE_ARM_GIC);
> +    }
> +
>       sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->cont=
rol),
>                             TYPE_BCM2836_CONTROL);
>  =20
> @@ -115,6 +137,59 @@ static void bcm2836_realize(DeviceState *dev, Erro=
r **errp)
>  =20
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
>  =20
> +    /* bcm2838 GICv2 */
> +    if (info->gic_base) {
> +        object_property_set_uint(OBJECT(&s->gic), 2, "revision", &err)=
;
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        object_property_set_uint(OBJECT(&s->gic),
> +                                 BCM283X_NCPUS, "num-cpu", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        object_property_set_uint(OBJECT(&s->gic),
> +                                 32 + GIC_NUM_IRQS, "num-irq", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        object_property_set_bool(OBJECT(&s->gic),
> +                                 true, "has-virtualization-extensions"=
, &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        object_property_set_bool(OBJECT(&s->gic), true, "realized", &e=
rr);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
> +                        info->ctrl_base + info->gic_base + GIC_DIST_OF=
S);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
> +                        info->ctrl_base + info->gic_base + GIC_CPU_OFS=
);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
> +                        info->ctrl_base + info->gic_base + GIC_VIFACE_=
THIS_OFS);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
> +                        info->ctrl_base + info->gic_base + GIC_VCPU_OF=
S);
> +
> +        for (n =3D 0; n < BCM283X_NCPUS; n++) {
> +            sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 4 + n,
> +                            info->ctrl_base + info->gic_base
> +                            + GIC_VIFACE_OTHER_OFS(n));> +        }
> +
> +        /* TODO wire IRQs!!! */

I think as a bare minimum, you must wire:
  - the ARM generic timer IRQs going out of all the CPUs, into their
respective PPI. Looking at [1], they seem to be connected to the usual
PPIs (at least we have the same mapping in the vexpress, the xynqmp and
the virt board).
  - The PMU interrupts
  - Possibly the GICv2 maintenance interrupt, but I can't find the IRQ
number in the DTS. This is related to the virtualization extension. It
should not prevent Linux from booting if it's not connected (I think KVM
does not even use the GICv2 maintenance interrupts anyway).
  - Finally, Connect the four GICv2 output (irq, fiq, virq, vfiq) to
their respective CPU inputs.


[1]
https://github.com/raspberrypi/linux/blob/rpi-5.3.y/arch/arm/boot/dts/bcm=
2838.dtsi


Here is a snippet of the virt board, quickly adapted foc this SoC (I
didn't test it):

#define BCM2838_ARCH_TIMER_VIRT_IRQ   11
#define BCM2838_ARCH_TIMER_S_EL1_IRQ  13
#define BCM2838_ARCH_TIMER_NS_EL1_IRQ 14
#define BCM2838_ARCH_TIMER_NS_EL2_IRQ 10

#define BCM2838_PMU_SPI_BASE          16
[...]

 for (i =3D 0; i < BCM283X_NCPUS; i++) {
        DeviceState *cpudev =3D DEVICE(qemu_get_cpu(i));
        int ppibase =3D GIC_NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
        int irq;

        /* Mapping from the output timer irq lines from the CPU to the
         * GIC PPI inputs.
         */
        const int timer_irq[] =3D {
            [GTIMER_PHYS] =3D BCM2838_ARCH_TIMER_NS_EL1_IRQ,
            [GTIMER_VIRT] =3D BCM2838_ARCH_TIMER_VIRT_IRQ,
            [GTIMER_HYP]  =3D BCM2838_ARCH_TIMER_NS_EL2_IRQ,
            [GTIMER_SEC]  =3D BCM2838_ARCH_TIMER_S_EL1_IRQ,
        };

        for (irq =3D 0; irq < ARRAY_SIZE(timer_irq); irq++) {
            qdev_connect_gpio_out(cpudev, irq,
                                  qdev_get_gpio_in(gicdev,
                                                   ppibase +
timer_irq[irq]));
        }

        /* I don't know the maintenance IRQ number for the this SoC */
#if 0
        qemu_irq irq =3D qdev_get_gpio_in(gicdev,
                                        ppibase + ARCH_GIC_MAINT_IRQ);
        sysbus_connect_irq(SYS_BUS_DEVICE(gicbusdevs->gic), i + 4 *
smp_cpus, irq);
#endif

        /* PMU interrupt */
        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
                                    qdev_get_gpio_in(gicdev,
BCM2838_PMU_SPI_BASE + i));

        /* Connect the GICv2 outputs to the CPU */
        sysbus_connect_irq(SYS_BUS_DEVICE(gicbusdevs->gic), i,
                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
        sysbus_connect_irq(SYS_BUS_DEVICE(gicbusdevs->gic), i + smp_cpus,
                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
        sysbus_connect_irq(SYS_BUS_DEVICE(gicbusdevs->gic), i + 2 *
smp_cpus,
                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
        sysbus_connect_irq(SYS_BUS_DEVICE(gicbusdevs->gic), i + 3 *
smp_cpus,
                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
    }



HTH!

--=20
Luc

> +    }
> +
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
>           qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
> diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
> index 97187f72be..31c8fb90bd 100644
> --- a/include/hw/arm/bcm2836.h
> +++ b/include/hw/arm/bcm2836.h
> @@ -13,6 +13,7 @@
>  =20
>   #include "hw/arm/bcm2835_peripherals.h"
>   #include "hw/intc/bcm2836_control.h"
> +#include "hw/intc/arm_gic.h"
>   #include "target/arm/cpu.h"
>  =20
>   #define TYPE_BCM283X "bcm283x"
> @@ -26,6 +27,7 @@
>    */
>   #define TYPE_BCM2836 "bcm2836"
>   #define TYPE_BCM2837 "bcm2837"
> +#define TYPE_BCM2838 "bcm2838"
>  =20
>   typedef struct BCM283XState {
>       /*< private >*/
> @@ -36,6 +38,7 @@ typedef struct BCM283XState {
>       uint32_t enabled_cpus;
>  =20
>       ARMCPU cpus[BCM283X_NCPUS];
> +    GICState gic;
>       BCM2836ControlState control;
>       BCM2835PeripheralState peripherals;
>   } BCM283XState;
>=20

