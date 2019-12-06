Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ED9C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 22:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6E4206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 22:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlCjZLTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6E4206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idLvC-0003Nr-Fn
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 17:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1idLtN-0002iS-Sc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 17:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1idLtK-0007l8-CZ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 17:16:05 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:47042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1idLtJ-0007aw-Ur; Fri, 06 Dec 2019 17:16:02 -0500
Received: by mail-io1-xd43.google.com with SMTP id i11so8843635iol.13;
 Fri, 06 Dec 2019 14:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s/7OdeqmZUFG/ihDfSirzk0p9NzkShThT+s7z8P7mpE=;
 b=MlCjZLTacz8jXTW90H/+4HvcVgZkXw04W9zw9uUByxgOGK+3exgno7jzijCKP3NK56
 7UpxMdDJ09Ur55szOv10QoGIUi6dD8xhzV1xbl38IXxxGsvnJvisHklgeAcs7HhdJpLW
 3OGT2S53/CbXSlaBXuhQ0No+imlQDkufb56PLvD9IFPbhsyfmQyUAOH7BHPIAqViZyMS
 QBvxhZu3f8N6PTw7q559BMthz3XxYhqYs6yYScEb1wfnpvxv+T5gvpMQJciTiOQG2EnE
 hK3RNr8mvBZHtgDFCnIQu+2eaNhfeZKHbpQTd4HxULruYlu9xPcpyPKA/ji1ZzVg/Ieq
 URzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s/7OdeqmZUFG/ihDfSirzk0p9NzkShThT+s7z8P7mpE=;
 b=e/4NQKV0KkIMWVI0tQHKSxtZJlaeET3rMm4IWfl5mSWkJ2AVkb7m21EX2/Xu+XZQlK
 v4PDs6sOCK6ezC42DaFWZLsIVxGpBrC7tALJo2F9ZMMS8RYy1ZDV4/8dKdrAvdzlG6ZN
 1OmK+wR/ouAVRhUMjsrD83BO9ILKvF4QklJ+hAznAhxCB560kDG+yPwsNhn5iv4XmPtk
 ZKGqNKyo0n3NMltoUzBvkqjJKG571fBo6g2a2YpiBlBcOTMHCc/bEwFAzOU5c61uB1nM
 CoKNc3ufT7anzDkkEn85GXbG+mwkYbKc6B0wlo9a+hzYhZ+1yyeOSyvhlPBUkaPAh5Ck
 bStA==
X-Gm-Message-State: APjAAAUNm125rX0wg9Uf7WjUKKKPrQ6VNdcGehGMP4o/FkNDozZftTeM
 8yAdF7DzkgfNaSI6MW1yKD2XRkrPEv4TqfukAuM=
X-Google-Smtp-Source: APXvYqzbBWp8fDiQEJTOkzCVQ0jkS3tRT7AUMRPZAKXZFTEn/ShATKtmPzDo/s4/0VXh31m3J5KCTyCB9iawfw/votQ=
X-Received: by 2002:a6b:d912:: with SMTP id r18mr12132192ioc.306.1575670559704; 
 Fri, 06 Dec 2019 14:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-3-nieklinnenbank@gmail.com>
 <b14e5a75-ebe3-311e-60a8-3f71b0874a10@redhat.com>
 <CAPan3WohBP_47h1ZPP12ZuyiY43B3B6tGFMH-sK=LAAjMbwpaA@mail.gmail.com>
 <ce2125dd-004c-a5a2-81cf-b8aaae76444e@redhat.com>
In-Reply-To: <ce2125dd-004c-a5a2-81cf-b8aaae76444e@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 6 Dec 2019 23:15:48 +0100
Message-ID: <CAPan3WrN28W-h9RYA88LbA8eWP6Me9VcNisnZhwNgC2WOgVLxg@mail.gmail.com>
Subject: Re: [PATCH 02/10] hw: arm: add Xunlong Orange Pi PC machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fe8a3705991063e9"
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fe8a3705991063e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Fri, Dec 6, 2019 at 6:41 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> On 12/5/19 11:15 PM, Niek Linnenbank wrote:
> > Hello Philippe,
> >
> > On Tue, Dec 3, 2019 at 10:18 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >     On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> >      > The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> >      > based embedded computer with mainline support in both U-Boot
> >      > and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> >      > 512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> >      > various other I/O. This commit add support for the Xunlong
> >      > Orange Pi PC machine.
> >      >
> >      > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>>
> >      > ---
> >      >   MAINTAINERS          |  1 +
> >      >   hw/arm/Makefile.objs |  2 +-
> >      >   hw/arm/orangepi.c    | 90
> >     ++++++++++++++++++++++++++++++++++++++++++++
> >      >   3 files changed, 92 insertions(+), 1 deletion(-)
> >      >   create mode 100644 hw/arm/orangepi.c
> >      >
> >      > diff --git a/MAINTAINERS b/MAINTAINERS
> >      > index 29c9936037..42c913d6cb 100644
> >      > --- a/MAINTAINERS
> >      > +++ b/MAINTAINERS
> >      > @@ -485,6 +485,7 @@ L: qemu-arm@nongnu.org
> >     <mailto:qemu-arm@nongnu.org>
> >      >   S: Maintained
> >      >   F: hw/*/allwinner-h3*
> >      >   F: include/hw/*/allwinner-h3*
> >      > +F: hw/arm/orangepi.c
> >      >
> >      >   ARM PrimeCell and CMSDK devices
> >      >   M: Peter Maydell <peter.maydell@linaro.org
> >     <mailto:peter.maydell@linaro.org>>
> >      > diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> >      > index 956e496052..8d5ea453d5 100644
> >      > --- a/hw/arm/Makefile.objs
> >      > +++ b/hw/arm/Makefile.objs
> >      > @@ -34,7 +34,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o
> >      >   obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o
> >      >   obj-$(CONFIG_STRONGARM) +=3D strongarm.o
> >      >   obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboard.o
> >      > -obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o
> >      > +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o orangepi.o
> >      >   obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o raspi=
.o
> >      >   obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
> >      >   obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu102.o
> >      > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> >      > new file mode 100644
> >      > index 0000000000..5ef2735f81
> >      > --- /dev/null
> >      > +++ b/hw/arm/orangepi.c
> >      > @@ -0,0 +1,90 @@
> >      > +/*
> >      > + * Orange Pi emulation
> >      > + *
> >      > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>>
> >      > + *
> >      > + * This program is free software: you can redistribute it and/o=
r
> >     modify
> >      > + * it under the terms of the GNU General Public License as
> >     published by
> >      > + * the Free Software Foundation, either version 2 of the
> License, or
> >      > + * (at your option) any later version.
> >      > + *
> >      > + * This program is distributed in the hope that it will be
> useful,
> >      > + * but WITHOUT ANY WARRANTY; without even the implied warranty =
of
> >      > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See th=
e
> >      > + * GNU General Public License for more details.
> >      > + *
> >      > + * You should have received a copy of the GNU General Public
> License
> >      > + * along with this program.  If not, see
> >     <http://www.gnu.org/licenses/>.
> >      > + */
> >      > +
> >      > +#include "qemu/osdep.h"
> >      > +#include "exec/address-spaces.h"
> >      > +#include "qapi/error.h"
> >      > +#include "cpu.h"
> >      > +#include "hw/sysbus.h"
> >      > +#include "hw/boards.h"
> >      > +#include "hw/qdev-properties.h"
> >      > +#include "hw/arm/allwinner-h3.h"
> >      > +
> >      > +static struct arm_boot_info orangepi_binfo =3D {
> >      > +    .loader_start =3D AW_H3_SDRAM_BASE,
> >      > +    .board_id =3D -1,
> >      > +};
> >      > +
> >      > +typedef struct OrangePiState {
> >      > +    AwH3State *h3;
> >      > +    MemoryRegion sdram;
> >      > +} OrangePiState;
> >      > +
> >      > +static void orangepi_init(MachineState *machine)
> >      > +{
> >      > +    OrangePiState *s =3D g_new(OrangePiState, 1);
> >      > +    Error *err =3D NULL;
> >      > +
> >
> >     Here I'd add:
> >
> >             if (strcmp(machine->cpu_type,
> >     ARM_CPU_TYPE_NAME("cortex-a7")) !=3D 0) {
> >                 error_report("This board can only be used with cortex-a=
7
> >     CPU");
> >                 exit(1);
> >             }
> >
> > Done!
> >
> >      > +    s->h3 =3D AW_H3(object_new(TYPE_AW_H3));
> >      > +
> >      > +    /* Setup timer properties */
> >      > +    object_property_set_int(OBJECT(&s->h3->timer), 32768,
> >     "clk0-freq", &err);
> >      > +    if (err !=3D NULL) {
> >      > +        error_reportf_err(err, "Couldn't set clk0 frequency: ")=
;
> >      > +        exit(1);
> >      > +    }
> >      > +
> >      > +    object_property_set_int(OBJECT(&s->h3->timer), 24000000,
> >     "clk1-freq",
> >      > +                            &err);
> >      > +    if (err !=3D NULL) {
> >      > +        error_reportf_err(err, "Couldn't set clk1 frequency: ")=
;
> >      > +        exit(1);
> >      > +    }
> >      > +
> >      > +    /* Mark H3 object realized */
> >      > +    object_property_set_bool(OBJECT(s->h3), true, "realized",
> &err);
> >
> >     I'm not sure if that's correct but I'd simply use &error_abort here=
.
> >
> > Done, I applied it to all the functions and removed the err variable.
> >
> >      > +    if (err !=3D NULL) {
> >      > +        error_reportf_err(err, "Couldn't realize Allwinner H3:
> ");
> >      > +        exit(1);
> >      > +    }
> >      > +
> >      > +    /* RAM */
> >      > +    memory_region_allocate_system_memory(&s->sdram, NULL,
> >     "orangepi.ram",
> >      > +                                         machine->ram_size);
> >
> >     I'd only allow machine->ram_size =3D=3D 1 * GiB here, since the onb=
oard
> >     DRAM
> >     is not upgradable.
> >
> >
> > Agree, we should add something for that. Would it be acceptable if we
> > make the 1GB an upper limit?
> > I see that the Raspberry Pi is doing that too in hw/arm/raspi.c, like s=
o:
> >
> >      if (machine->ram_size > 1 * GiB) {
> >          error_report("Requested ram size is too large for this machine=
:
> "
> >                       "maximum is 1GB");
> >          exit(1);
> >      }
> >
> > I think it would be helpful to allow the flexibility to the user of
> > reducing the RAM to less than 1GB,
> > in case resources of the host OS are limited. What do you think?
>
> Sure, good idea.
>
> FIY (in case you add more models) we recently noticed there is a problem
> when using 2GiB default on 32-bit hosts, so the workaround is to use <=3D
> 1GiB default.
>
> >      > +    memory_region_add_subregion(get_system_memory(),
> >     AW_H3_SDRAM_BASE,
> >      > +                                &s->sdram);
> >      > +
> >      > +    /* Load target kernel */
> >      > +    orangepi_binfo.ram_size =3D machine->ram_size;
> >      > +    orangepi_binfo.nb_cpus  =3D AW_H3_NUM_CPUS;
> >      > +    arm_load_kernel(ARM_CPU(first_cpu), machine,
> &orangepi_binfo);
> >      > +}
> >      > +
> >      > +static void orangepi_machine_init(MachineClass *mc)
> >      > +{
> >      > +    mc->desc =3D "Orange Pi PC";
> >      > +    mc->init =3D orangepi_init;
> >      > +    mc->units_per_default_bus =3D 1;
> >      > +    mc->min_cpus =3D AW_H3_NUM_CPUS;
> >      > +    mc->max_cpus =3D AW_H3_NUM_CPUS;
> >      > +    mc->default_cpus =3D AW_H3_NUM_CPUS;
> >
> >              mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
> >
> >      > +    mc->ignore_memory_transaction_failures =3D true;
> >
> >     You should not use this flag in new design. See the documentation i=
n
> >     include/hw/boards.h:
> >
> >        * @ignore_memory_transaction_failures:
> >        *    [...] New board models
> >        *    should instead use "unimplemented-device" for all memory
> >     ranges where
> >        *    the guest will attempt to probe for a device that QEMU
> doesn't
> >        *    implement and a stub device is required.
> >
> >     You already use the "unimplemented-device".
> >
> > Thanks, I'm working on this now. I think that at least I'll need to add
> > all of the devices mentioned in the 4.1 Memory Mapping chapter of the
> > datasheet
> > as an unimplemented device. Previously I only added some that I thought
> > were relevant.
> >
> > I added all the missing devices as unimplemented and removed the
> > ignore_memory_transaction_failures flag
>
> I was going to say, "instead of adding *all* the devices regions you can
> add the likely bus decoding regions", probably:
>
> 0x01c0.0000   128KiB   AMBA AXI
> 0x01c2.0000   64KiB    AMBA APB
>
> But too late.
>

Hehe its okey, I can change it to whichever is preferable: the minimum set
with unimplemented device entries to get a working linux kernel / u-boot or
just cover the full memory space from the datasheet. My initial thought was
that if
we only provide the minimum set, and the linux kernel later adds a new
driver for a device
which is not marked unimplemented, it will trigger the data abort and
potentially resulting in a non-booting kernel.

But I'm not sure what is normally done here. I do see other board files
using the create_unimplemented_device() function,
but I dont know if they are covering the whole memory space or not.

Any thoughts? :-)


>
> > from the machine. Now it seems Linux gets a data abort while probing th=
e
> > uart1 serial device at 0x01c28400,
>
> Did you add the UART1 as UNIMP or 16550?
>
>
I discovered what goes wrong here. See this kernel oops message:

[    1.084985] [f08600f8] *pgd=3D6f00a811, *pte=3D01c28653, *ppte=3D01c2845=
3
[    1.085564] Internal error: : 8 [#1] SMP ARM
[    1.085698] Modules linked in:
[    1.085940] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.4.0-11747-g2f13437b8917 #4
[    1.085968] Hardware name: Allwinner sun8i Family
[    1.086447] PC is at dw8250_setup_port+0x10/0x10c
[    1.086478] LR is at dw8250_probe+0x500/0x56c

It tries to access the UART0 at base address 0x01c28400, which I did
provide. The strange
thing is that is accesses offset 0xf8, thus address 0x01c284f8. The
datasheet does not mention this register
but if we provide the 1KiB (0x400) I/O space it should at least read as
zero and writes ignored. Unfortunately the emulated
serial driver only maps a small portion until 0x1f:

(qemu) info mtree
...
    0000000001c28000-0000000001c2801f (prio 0, i/o): serial
    0000000001c28400-0000000001c2841f (prio 0, i/o): serial
    0000000001c28800-0000000001c2881f (prio 0, i/o): serial


Apparently, the register that the mainline linux kernel is using is
DesignWare specific:

drivers/tty/serial/8250/8250_dwlib.c:13:

/* Offsets for the DesignWare specific registers */
#define DW_UART_DLF<--->0xc0 /* Divisor Latch Fraction Register */
#define DW_UART_CPR<--->0xf4 /* Component Parameter Register */
#define DW_UART_UCV<--->0xf8 /* UART Component Version */

I tried to find a way to increase the memory mapped size of the serial
device I created with serial_mm_init(),
but I don't think its possible with that interface.

I did manage to get it working by overlaying the UART0 with another
unimplemented device
that does have an I/O size of 0x400, but I guess that is probably not the
solution we are looking for?

I wonder, did any of the other SoC / boards have this problem when removing
mc->ignore_memory_transaction_failures?

Regards,
Niek

> so I'll need to debug it further. I'll post back when I have more results=
.
> >
> > Regards,
> > Niek
> >
> >      > +}
> >      > +
> >      > +DEFINE_MACHINE("orangepi", orangepi_machine_init)
> >
> >     Can you name it 'orangepi-pc'? So we can add other orangepi models.
> >
> >     Thanks,
> >
> >     Phil.
> >
> >
> >
> > --
> > Niek Linnenbank
> >
>
>

--=20
Niek Linnenbank

--000000000000fe8a3705991063e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 6, 2019 =
at 6:41 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 12/5/19 11:15 PM, Niek Linnenbank wrote:<br>
&gt; Hello Philippe,<br>
&gt; <br>
&gt; On Tue, Dec 3, 2019 at 10:18 AM Philippe Mathieu-Daud=C3=A9 <br>
&gt; &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redh=
at.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank=
">philmd@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 12/2/19 10:09 PM, Niek Linnenbank wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The Xunlong Orange Pi PC is an Allwinner H3 S=
ystem on Chip<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; based embedded computer with mainline support=
 in both U-Boot<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; and Linux. The board comes with a Quad Core C=
ortex A7 @ 1.3GHz,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB=
, HDMI and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; various other I/O. This commit add support fo=
r the Xunlong<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Orange Pi PC machine.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D=
"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.co=
m</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/arm/Makefile.objs |=C2=A0 2 +-=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 | =
90<br>
&gt;=C2=A0 =C2=A0 =C2=A0++++++++++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A03 files changed, 92 insertions(+)=
, 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 hw/arm/orangep=
i.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 29c9936037..42c913d6cb 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/MAINTAINERS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/MAINTAINERS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -485,6 +485,7 @@ L: <a href=3D"mailto:qemu=
-arm@nongnu.org" target=3D"_blank">qemu-arm@nongnu.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:qemu-arm@nongnu.org" t=
arget=3D"_blank">qemu-arm@nongnu.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0S: Maintained<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0F: hw/*/allwinner-h3*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0F: include/hw/*/allwinner-h3*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +F: hw/arm/orangepi.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0ARM PrimeCell and CMSDK devices<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0M: Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:peter.maydell@linaro.o=
rg" target=3D"_blank">peter.maydell@linaro.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/arm/Makefile.objs b/hw/arm/Ma=
kefile.objs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 956e496052..8d5ea453d5 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/arm/Makefile.objs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/arm/Makefile.objs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -34,7 +34,7 @@ obj-$(CONFIG_DIGIC) +=3D di=
gic.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0obj-$(CONFIG_OMAP) +=3D omap1.o o=
map2.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0obj-$(CONFIG_STRONGARM) +=3D stro=
ngarm.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0obj-$(CONFIG_ALLWINNER_A10) +=3D =
allwinner-a10.o cubieboard.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3=
.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3=
.o orangepi.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0obj-$(CONFIG_RASPI) +=3D bcm2835_=
peripherals.o bcm2836.o raspi.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0obj-$(CONFIG_STM32F205_SOC) +=3D =
stm32f205_soc.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=
=3D xlnx-zynqmp.o xlnx-zcu102.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orang=
epi.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 0000000000..5ef2735f81<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/arm/orangepi.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,90 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Orange Pi emulation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a=
 href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@=
gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This program is free software: you can re=
distribute it and/or<br>
&gt;=C2=A0 =C2=A0 =C2=A0modify<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * it under the terms of the GNU General Pub=
lic License as<br>
&gt;=C2=A0 =C2=A0 =C2=A0published by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * the Free Software Foundation, either vers=
ion 2 of the License, or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * (at your option) any later version.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This program is distributed in the hope t=
hat it will be useful,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * but WITHOUT ANY WARRANTY; without even th=
e implied warranty of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE.=C2=A0 See the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * GNU General Public License for more detai=
ls.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * You should have received a copy of the GN=
U General Public License<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * along with this program.=C2=A0 If not, se=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://www.gnu.org/licenses/" rel=3D=
"noreferrer" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;exec/address-spaces.h&quot;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;cpu.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/boards.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/qdev-properties.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/arm/allwinner-h3.h&quot;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static struct arm_boot_info orangepi_binfo =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .loader_start =3D AW_H3_SDRAM_=
BASE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .board_id =3D -1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct OrangePiState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AwH3State *h3;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemoryRegion sdram;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} OrangePiState;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void orangepi_init(MachineState *mach=
ine)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 OrangePiState *s =3D g_new(Ora=
ngePiState, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Here I&#39;d add:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(machine-&gt;=
cpu_type,<br>
&gt;=C2=A0 =C2=A0 =C2=A0ARM_CPU_TYPE_NAME(&quot;cortex-a7&quot;)) !=3D 0) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_rep=
ort(&quot;This board can only be used with cortex-a7<br>
&gt;=C2=A0 =C2=A0 =C2=A0CPU&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; Done!<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;h3 =3D AW_H3(object_new(=
TYPE_AW_H3));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Setup timer properties */<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT=
(&amp;s-&gt;h3-&gt;timer), 32768,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;clk0-freq&quot;, &amp;err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_reportf_er=
r(err, &quot;Couldn&#39;t set clk0 frequency: &quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT=
(&amp;s-&gt;h3-&gt;timer), 24000000,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;clk1-freq&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_reportf_er=
r(err, &quot;Couldn&#39;t set clk1 frequency: &quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Mark H3 object realized */<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJEC=
T(s-&gt;h3), true, &quot;realized&quot;, &amp;err);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;m not sure if that&#39;s correct but I&#39;d =
simply use &amp;error_abort here.<br>
&gt; <br>
&gt; Done, I applied it to all the functions and removed the err variable.<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_reportf_er=
r(err, &quot;Couldn&#39;t realize Allwinner H3: &quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* RAM */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_allocate_system_=
memory(&amp;s-&gt;sdram, NULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;orangepi.ram&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0machine-&gt;ram_size);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;d only allow machine-&gt;ram_size =3D=3D 1 * =
GiB here, since the onboard<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRAM<br>
&gt;=C2=A0 =C2=A0 =C2=A0is not upgradable.<br>
&gt; <br>
&gt; <br>
&gt; Agree, we should add something for that. Would it be acceptable if we =
<br>
&gt; make the 1GB an upper limit?<br>
&gt; I see that the Raspberry Pi is doing that too in hw/arm/raspi.c, like =
so:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (machine-&gt;ram_size &gt; 1 * GiB) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Requested ram siz=
e is too large for this machine: &quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&quot;maximum is 1GB&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; I think it would be helpful to allow the flexibility to the user of <b=
r>
&gt; reducing the RAM to less than 1GB,<br>
&gt; in case resources of the host OS are limited. What do you think?<br>
<br>
Sure, good idea.<br>
<br>
FIY (in case you add more models) we recently noticed there is a problem <b=
r>
when using 2GiB default on 32-bit hosts, so the workaround is to use &lt;=
=3D <br>
1GiB default.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_add_subregion(ge=
t_system_memory(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0AW_H3_SDRAM_BASE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;=
s-&gt;sdram);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Load target kernel */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 orangepi_binfo.ram_size =3D ma=
chine-&gt;ram_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 orangepi_binfo.nb_cpus=C2=A0 =
=3D AW_H3_NUM_CPUS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 arm_load_kernel(ARM_CPU(first_=
cpu), machine, &amp;orangepi_binfo);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void orangepi_machine_init(MachineCla=
ss *mc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Orange P=
i PC&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;init =3D orangepi_init;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;units_per_default_bus =
=3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;min_cpus =3D AW_H3_NUM_=
CPUS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;max_cpus =3D AW_H3_NUM_=
CPUS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;default_cpus =3D AW_H3_=
NUM_CPUS;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mc-&gt;default_cpu_typ=
e =3D ARM_CPU_TYPE_NAME(&quot;cortex-a7&quot;);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;ignore_memory_transacti=
on_failures =3D true;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You should not use this flag in new design. See the=
 documentation in<br>
&gt;=C2=A0 =C2=A0 =C2=A0include/hw/boards.h:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @ignore_memory_transaction_failures:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 [...] New board models<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 should instead use &quot;uni=
mplemented-device&quot; for all memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0ranges where<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 the guest will attempt to pr=
obe for a device that QEMU doesn&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 implement and a stub device =
is required.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You already use the &quot;unimplemented-device&quot=
;.<br>
&gt; <br>
&gt; Thanks, I&#39;m working on this now. I think that at least I&#39;ll ne=
ed to add<br>
&gt; all of the devices mentioned in the 4.1 Memory Mapping chapter of the =
<br>
&gt; datasheet<br>
&gt; as an unimplemented device. Previously I only added some that I though=
t <br>
&gt; were relevant.<br>
&gt; <br>
&gt; I added all the missing devices as unimplemented and removed the <br>
&gt; ignore_memory_transaction_failures flag<br>
<br>
I was going to say, &quot;instead of adding *all* the devices regions you c=
an <br>
add the likely bus decoding regions&quot;, probably:<br>
<br>
0x01c0.0000=C2=A0 =C2=A0128KiB=C2=A0 =C2=A0AMBA AXI<br>
0x01c2.0000=C2=A0 =C2=A064KiB=C2=A0 =C2=A0 AMBA APB<br>
<br>
But too late.<br></blockquote><div><br></div><div>Hehe its okey, I can chan=
ge it to whichever is preferable: the minimum set</div><div>with unimplemen=
ted device entries to get a working linux kernel / u-boot or <br></div><div=
>just cover the full memory space from the datasheet. My initial thought wa=
s that if</div><div>we only provide the minimum set, and the linux kernel l=
ater adds a new driver for a device</div><div>which is not marked unimpleme=
nted, it will trigger the data abort and potentially resulting in a non-boo=
ting kernel.<br></div><div><br></div><div>But I&#39;m not sure what is norm=
ally done here. I do see other board files using the create_unimplemented_d=
evice() function,</div><div>but I dont know if they are covering the whole =
memory space or not.</div><div><br></div><div>Any thoughts? :-)<br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; from the machine. Now it seems Linux gets a data abort while probing t=
he <br>
&gt; uart1 serial device at 0x01c28400,<br>
<br>
Did you add the UART1 as UNIMP or 16550?<br>
<br></blockquote><div><br></div><div>I discovered what goes wrong here. See=
 this kernel oops message:</div><div><br></div><div><pre>[    1.084985] [f0=
8600f8] *pgd=3D6f00a811, *pte=3D01c28653, *ppte=3D01c28453
[    1.085564] Internal error: : 8 [#1] SMP ARM
[    1.085698] Modules linked in:
[    1.085940] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-11747-g2f134=
37b8917 #4
[    1.085968] Hardware name: Allwinner sun8i Family
[    1.086447] PC is at dw8250_setup_port+0x10/0x10c
[    1.086478] LR is at dw8250_probe+0x500/0x56c
</pre></div><div>It tries to access the UART0 at base address 0x01c28400, w=
hich I did provide. The strange</div><div>thing is that is accesses offset =
0xf8, thus address 0x01c284f8. The datasheet does not mention this register=
</div><div>but if we provide the 1KiB (0x400) I/O space it should at least =
read as zero and writes ignored. Unfortunately the emulated</div><div>seria=
l driver only maps a small portion until 0x1f:</div><div><pre>(qemu) info m=
tree
...=20
    0000000001c28000-0000000001c2801f (prio 0, i/o): serial
    0000000001c28400-0000000001c2841f (prio 0, i/o): serial
    0000000001c28800-0000000001c2881f (prio 0, i/o): serial</pre></div><div=
><br></div><div>Apparently, the register that the mainline linux kernel is =
using is DesignWare specific:<br></div><div><pre>drivers/tty/serial/8250/82=
50_dwlib.c:13:

/* Offsets for the DesignWare specific registers */
#define DW_UART_DLF&lt;---&gt;0xc0 /* Divisor Latch Fraction Register */
#define DW_UART_CPR&lt;---&gt;0xf4 /* Component Parameter Register */
#define DW_UART_UCV&lt;---&gt;0xf8 /* UART Component Version */</pre></div>=
<div>I tried to find a way to increase the memory mapped size of the serial=
 device I created with serial_mm_init(),</div><div>but I don&#39;t think it=
s possible with that interface. <br></div><div><br></div><div>I did manage =
to get it working by overlaying the UART0 with another unimplemented device=
</div><div>that does have an I/O size of 0x400, but I guess that is probabl=
y not the solution we are looking for?<br></div><div><br></div><div>I wonde=
r, did any of the other SoC / boards have this problem when removing mc-&gt=
;ignore_memory_transaction_failures?<br></div><div>=C2=A0</div><div>Regards=
,</div><div>Niek<br></div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
&gt; so I&#39;ll need to debug it further. I&#39;ll post back when I have m=
ore results.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Niek<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +DEFINE_MACHINE(&quot;orangepi&quot;, orangep=
i_machine_init)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Can you name it &#39;orangepi-pc&#39;? So we can ad=
d other orangepi models.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Phil.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Niek Linnenbank<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div></div>

--000000000000fe8a3705991063e9--

