Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBDEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BCE2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy1AoD6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BCE2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfjU-00012I-7h
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 15:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihfi7-0000H1-Iz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihfi3-0003ur-Ta
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:14:19 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b]:41986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ihfi3-0003p8-D6; Wed, 18 Dec 2019 15:14:15 -0500
Received: by mail-io1-xd2b.google.com with SMTP id n11so1799723iom.9;
 Wed, 18 Dec 2019 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K/OdqGuEDKTr2+zKYT0b1sCPvCwUANs/aupGGTK6asA=;
 b=Vy1AoD6i8DA/NQHmL1R+TTJgY+d7lm+tnFSzomlnnOXp70o0ODkFoXrayAcgLXyEV5
 VuAUjVQgCrHtoZFN/bbmTM1+mONePE9Bc2kk4ESSAiIgQz41r9EdQUBo2JSXgLjs6ZNn
 a1xYAzbhf5YVkqUpvTrfXIKOwLJOj1Dl+wr0PfbKFSPH5o2we/qsfu2+TzVbLZDgl/x+
 a80rjh8sh4Uq5cD9THC1aOZTx4oyTXkFS2iKgdhCzzpprX6Wp1AFP12W6tua8J3dAJGb
 CHSYxm68Qz+FqubNd1dvT/Om5J8f1p4H/hCgbe5+DT6nDxHiUvIlFydqWxGdkBemRSTW
 t2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K/OdqGuEDKTr2+zKYT0b1sCPvCwUANs/aupGGTK6asA=;
 b=s6AHXc+kybQXqXTzAMQcG0hEQRLodS0CdwsxR4qkWMIJESkHO46ROdGqR+VRPeOvT7
 ZUWjiL+/t/WXb+VMuPdSf5mDrtKStz7dVM3U08h7k6qnFdLBEpF3xS78wU19I2FXkHXB
 yVSfQb8I+H9mVHyEsFrCia0zrGni461WUN5RRB+nDeAYKK2pIufOrqSImFt2483MrEmt
 ZfXYz5Ax/ZZJlWATN2RAkv5wbrc/WnZ/SYO0BpxBzSQAAqslvzhqHpCMgPZE6kJ0jOqG
 P8YcGp/uhu8D/H8DYBPxJltyYwdb7isbtDLE5Xw0IMM9J2Tikgu9y2+CXY2vNtVlaBtl
 eYtQ==
X-Gm-Message-State: APjAAAXm7KH2oPGXggMRlIoXjE8tn5wsW3+3O2Me776/CwD46+weN9ow
 YWZgZiwUPuQs5NNDWL6Q95CBs66yKsmRNraahKg=
X-Google-Smtp-Source: APXvYqzihjYbHBQosCEt1vDQGVC9X4rhg7CZAqISQwk/pRqflDvpcA9AOcVgXxoP966OE8cuRPQHWepO1GvcRLDWKhc=
X-Received: by 2002:a6b:d912:: with SMTP id r18mr3003884ioc.306.1576700053798; 
 Wed, 18 Dec 2019 12:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <20191216233519.29030-3-nieklinnenbank@gmail.com>
 <e66415e1-7dcc-9fa3-7ff3-6526087be799@redhat.com>
In-Reply-To: <e66415e1-7dcc-9fa3-7ff3-6526087be799@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 18 Dec 2019 21:14:02 +0100
Message-ID: <CAPan3Wq6iM1k=UBP7kFUF-hYuSu836VLH+_YNFwdWAffbmnvYQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] hw: arm: add Xunlong Orange Pi PC machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009fcf3d059a00167c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2b
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009fcf3d059a00167c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Thanks again for your quick and helpful feedback! :-)

On Tue, Dec 17, 2019 at 8:31 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Niek,
>
> On 12/17/19 12:35 AM, Niek Linnenbank wrote:
> > The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> > based embedded computer with mainline support in both U-Boot
> > and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> > 512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> > various other I/O. This commit add support for the Xunlong
> > Orange Pi PC machine.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
> > ---
> >   hw/arm/orangepi.c    | 101 ++++++++++++++++++++++++++++++++++++++++++=
+
> >   MAINTAINERS          |   1 +
> >   hw/arm/Makefile.objs |   2 +-
> >   3 files changed, 103 insertions(+), 1 deletion(-)
> >   create mode 100644 hw/arm/orangepi.c
> >
> > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > new file mode 100644
> > index 0000000000..62cefc8c06
> > --- /dev/null
> > +++ b/hw/arm/orangepi.c
> > @@ -0,0 +1,101 @@
> > +/*
> > + * Orange Pi emulation
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
> > +#include "cpu.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/boards.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/arm/allwinner-h3.h"
> > +
> > +static struct arm_boot_info orangepi_binfo =3D {
> > +    .board_id =3D -1,
> > +};
> > +
> > +typedef struct OrangePiState {
> > +    AwH3State *h3;
> > +    MemoryRegion sdram;
> > +} OrangePiState;
> > +
> > +static void orangepi_init(MachineState *machine)
> > +{
> > +    OrangePiState *s =3D g_new(OrangePiState, 1);
> > +
> > +    /* Only allow Cortex-A7 for this board */
> > +    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) !=3D=
 0)
> {
> > +        error_report("This board can only be used with cortex-a7 CPU")=
;
> > +        exit(1);
> > +    }
> > +
> > +    s->h3 =3D AW_H3(object_new(TYPE_AW_H3));
> > +
> > +    /* Setup timer properties */
> > +    object_property_set_int(OBJECT(&s->h3->timer), 32768, "clk0-freq",
> > +                            &error_abort);
>
> You access the timer object which is contained inside the soc object,
> but the soc isn't realized yet... I wonder if this is OK. Usually what
> we do is, either:
> - add a 'xtal-freq-hz' property to the SoC, set it here in the board,
> then in soc::realize() set the property to the timer
> - add an alias in the SoC to the timer 'freq-hz' property:
>      object_property_add_alias(soc, "xtal-freq-hz", OBJECT(&s->timer),
>                                     "freq-hz", &error_abort);
>
Good point. I shall rework that part using your suggestion.
Actually, I copied the timer support code from the existing cubieboard.c
that has
the Allwinner A10, so potentially the same problem is there.

While looking more closer at this part, I now also discovered that the
timer module from the Allwinner H3 is
mostly a stripped down version of the timer module in the Allwinner A10:

  Allwinner A10, 10.2 Timer Register List, page 85:
  https://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manual_V1.5.pdf

The A10 version has six timers, where the H3 has only two. That should be
fine I would say, the guest would simply
use those available on H3 and ignore the rest. There is however one
conflicting difference: the WDOG0 registers in the Allwinner H3 start
at a different offset and are also different. The current A10 timer does
not currently implement the watchdog part.

The watchdog part of this timer is relevant for the 'reset' command in
U-Boot: that does not work right now, because
U-Boot implements the reset for the Allwinner H3 boards by letting this
watchdog expire (and we dont emulate it).
Also, this timer module is required for booting Linux, without it the
kernel crashes using the sunxi_defconfig:

[    0.000000] PC is at sun4i_timer_init+0x34/0x168
[    0.000000] LR is at sun4i_timer_init+0x2c/0x168
[    0.000000] pc : [<c07fa634>]    lr : [<c07fa62c>]    psr: 600000d3
[    0.000000] sp : c0a03f70  ip : eec00188  fp : ef7ed040
...
[    0.000000] [<c07fa634>] (sun4i_timer_init) from [<c07fa4e8>]
(timer_probe+0x74/0xe4)
[    0.000000] [<c07fa4e8>] (timer_probe) from [<c07d9c10>]
(start_kernel+0x2e0/0x440)
[    0.000000] [<c07d9c10>] (start_kernel) from [<00000000>] (0x0)


So in my opinion its a bit of a trade off here: we can keep it like this
and re-use the A10 timer for now, and perhaps
attempt to generalize that module for proper use in both SoCs. Or we can
introduce a new H3 specific timer module.
What do you think?


>
> Also, if you use &error_abort, a failure in object_property_set_int()
> triggers abort(). See "qapi/error.h":
>
>   * If @errp is &error_abort, print a suitable message and abort().
>   * If @errp is &error_fatal, print a suitable message and exit(1).
>
> > +    if (error_abort !=3D NULL) {
> > +        error_reportf_err(error_abort, "Couldn't set clk0 frequency: "=
);
> > +        exit(1);
> > +    }
>
> So this if() block is useless.
>
> Ah ok, I'll remove them.


> > +
> > +    object_property_set_int(OBJECT(&s->h3->timer), 24000000,
> "clk1-freq",
> > +                            &error_abort);
> > +    if (error_abort !=3D NULL) {
> > +        error_reportf_err(error_abort, "Couldn't set clk1 frequency: "=
);
> > +        exit(1);
> > +    }
>
> Similarly, remove if() block.
>
> > +
> > +    /* Mark H3 object realized */
> > +    object_property_set_bool(OBJECT(s->h3), true, "realized",
> &error_abort);
> > +    if (error_abort !=3D NULL) {
> > +        error_reportf_err(error_abort, "Couldn't realize Allwinner H3:
> ");
> > +        exit(1);
> > +    }
>
> Similarly, remove if() block.
>
> > +
> > +    /* RAM */
> > +    if (machine->ram_size > 1 * GiB) {
> > +        error_report("Requested ram size is too large for this machine=
:
> "
> > +                     "maximum is 1GB");
>
> Per http://www.orangepi.org/orangepipc/ this board comes with a specific
> amount of RAM. I'd enforce the default (1GiB) and refuse other cases.
>

OK sure, I'll change it to a enforcing 1GiB. I do recall we briefly
discussed this
in v1. Then we agreed to make it an upper limit for use cases where
resources are
limited which is why I changed it like this.


> I noticed this by testing your series, without specifying the memory
> size you suggested in the cover (512) it defaults to 128 MiB, and the
> Raspian userland fails:
>

Indeed! By the way, this is also the case for U-Boot: it freezes when using
128MiB.
Actually when working on the initial code I searched a bit for a way
to set a default ram size, but could not find it at that time. But now I
see in your comment below,
it can be done simply with mc->default_ram_size. Thanks a lot, I will
surely add that!


>
> [ ***  ] (2 of 4) A start job is running for=E2=80=A6Persistent Storage (=
37s /
> 2min 1s)
> [  *** ] (2 of 4) A start job is running for=E2=80=A6Persistent Storage (=
38s /
> 2min 1s)
> [  OK  ] Started Flush Journal to Persistent Storage.
> Starting Create Volatile Files and Directories...
> Starting Armbian ZRAM config...
> [    **] (3 of 6) A start job is running for=E2=80=A6s and Directories (5=
5s / no
> limit)
> [     *] (3 of 6) A start job is running for=E2=80=A6s and Directories (5=
5s / no
> limit)
> [    **] (3 of 6) A start job is running for=E2=80=A6s and Directories (5=
6s / no
> limit)
> [  OK  ] Started Create Volatile Files and Directories.
> [***   ] (5 of 6) A start job is running for=E2=80=A6 ZRAM config (1min 1=
0s /
> 1min 19s)
> [**    ] (5 of 6) A start job is running for=E2=80=A6 ZRAM config (1min 1=
2s /
> 1min 19s)
> [*     ] (5 of 6) A start job is running for=E2=80=A6 ZRAM config (1min 1=
3s /
> 1min 19s)
> [FAILED] Failed to start Armbian ZRAM config.
> See 'systemctl status armbian-zram-config.service' for details.
>
> > +        exit(1);
> > +    }
> > +    memory_region_allocate_system_memory(&s->sdram, NULL,
> "orangepi.ram",
>
> There is only one type of ram on this machine, I'd simply name this
> "sdram".
>

OK!


> > +                                         machine->ram_size);
> > +    memory_region_add_subregion(get_system_memory(),
> s->h3->memmap[AW_H3_SDRAM],
> > +                                &s->sdram);
> > +
> > +    /* Load target kernel */
> > +    orangepi_binfo.loader_start =3D s->h3->memmap[AW_H3_SDRAM];
> > +    orangepi_binfo.ram_size =3D machine->ram_size;
> > +    orangepi_binfo.nb_cpus  =3D AW_H3_NUM_CPUS;
> > +    arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
>
> I wonder if we should tell the user '-bios' is not supported on this
> machine.
>

Good suggestion, its not handled, at least not anywhere in the code I added
for H3 support.
Shall I make it an error_report followed by exit(1), similar to the 1GiB
check?


>
> > +}
> > +
> > +static void orangepi_machine_init(MachineClass *mc)
> > +{
> > +    mc->desc =3D "Orange Pi PC";
> > +    mc->init =3D orangepi_init;
> > +    mc->units_per_default_bus =3D 1;
>
> Maybe "units_per_default_bus =3D 1" belongs to patch 9 "add SD/MMC host
> controller".
>
True, it should be in patch 9 indeed. I overlooked this when separating the
work in individual patches.
Now I am also wondering if I actually need this setting. Without it, the SD
device still works fine.
I did some greps in the code to discover what it is used for, but its not
very clear to me yet. Is this ment to
restrict machines to only one harddisk (or SD card)? If I try to supply
multiple SD cards with multiple -sd arguments,
this error is printed, regardless of having units_per_default_bus=3D1 or no=
t:
   qemu-system-arm: -sd test3.ext2: machine type does not support
if=3Dsd,bus=3D1,unit=3D0


>
> > +    mc->min_cpus =3D AW_H3_NUM_CPUS;
> > +    mc->max_cpus =3D AW_H3_NUM_CPUS;
> > +    mc->default_cpus =3D AW_H3_NUM_CPUS;
> > +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
>
> Please add:
>
>         mc->default_ram_size =3D 1 * GiB;
>
Yes, thanks!


>
> > +}
> > +
> > +DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aae1a049b4..db682e49ca 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -486,6 +486,7 @@ L: qemu-arm@nongnu.org
> >   S: Maintained
> >   F: hw/*/allwinner-h3*
> >   F: include/hw/*/allwinner-h3*
> > +F: hw/arm/orangepi.c
> >
> >   ARM PrimeCell and CMSDK devices
> >   M: Peter Maydell <peter.maydell@linaro.org>
> > diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> > index 956e496052..8d5ea453d5 100644
> > --- a/hw/arm/Makefile.objs
> > +++ b/hw/arm/Makefile.objs
> > @@ -34,7 +34,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o
> >   obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o
> >   obj-$(CONFIG_STRONGARM) +=3D strongarm.o
> >   obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboard.o
> > -obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o
> > +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o orangepi.o
> >   obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o raspi.o
> >   obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
> >   obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu102.o
> >
>
>
Regards,
Niek

--=20
Niek Linnenbank

--0000000000009fcf3d059a00167c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br></div><div><br></div><div=
>Thanks again for your quick and helpful feedback! :-)<br></div><div><br></=
div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Dec 17, 2019 at 8:31 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto=
:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi Niek,<br>
<br>
On 12/17/19 12:35 AM, Niek Linnenbank wrote:<br>
&gt; The Xunlong Orange Pi PC is an Allwinner H3 System on Chip<br>
&gt; based embedded computer with mainline support in both U-Boot<br>
&gt; and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,<br>
&gt; 512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and<br>
&gt; various other I/O. This commit add support for the Xunlong<br>
&gt; Orange Pi PC machine.<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; Tested-by: KONRAD Frederic &lt;<a href=3D"mailto:frederic.konrad@adaco=
re.com" target=3D"_blank">frederic.konrad@adacore.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 | 101 +++++++++++++++++++++=
++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A01 +<br>
&gt;=C2=A0 =C2=A0hw/arm/Makefile.objs |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A03 files changed, 103 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/arm/orangepi.c<br>
&gt; <br>
&gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..62cefc8c06<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -0,0 +1,101 @@<br>
&gt; +/*<br>
&gt; + * Orange Pi emulation<br>
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
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;hw/boards.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/arm/allwinner-h3.h&quot;<br>
&gt; +<br>
&gt; +static struct arm_boot_info orangepi_binfo =3D {<br>
&gt; +=C2=A0 =C2=A0 .board_id =3D -1,<br>
&gt; +};<br>
&gt; +<br>
&gt; +typedef struct OrangePiState {<br>
&gt; +=C2=A0 =C2=A0 AwH3State *h3;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion sdram;<br>
&gt; +} OrangePiState;<br>
&gt; +<br>
&gt; +static void orangepi_init(MachineState *machine)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OrangePiState *s =3D g_new(OrangePiState, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Only allow Cortex-A7 for this board */<br>
&gt; +=C2=A0 =C2=A0 if (strcmp(machine-&gt;cpu_type, ARM_CPU_TYPE_NAME(&quo=
t;cortex-a7&quot;)) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;This board can only be=
 used with cortex-a7 CPU&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;h3 =3D AW_H3(object_new(TYPE_AW_H3));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Setup timer properties */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;s-&gt;h3-&gt;timer)=
, 32768, &quot;clk0-freq&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>
<br>
You access the timer object which is contained inside the soc object, <br>
but the soc isn&#39;t realized yet... I wonder if this is OK. Usually what =
<br>
we do is, either:<br>
- add a &#39;xtal-freq-hz&#39; property to the SoC, set it here in the boar=
d, <br>
then in soc::realize() set the property to the timer<br>
- add an alias in the SoC to the timer &#39;freq-hz&#39; property:<br>
=C2=A0 =C2=A0 =C2=A0object_property_add_alias(soc, &quot;xtal-freq-hz&quot;=
, OBJECT(&amp;s-&gt;timer),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;freq-hz&quot;, &=
amp;error_abort);<br></blockquote><div>Good point. I shall rework that part=
 using your suggestion.</div><div>Actually, I copied the timer support code=
 from the existing cubieboard.c that has</div><div>the Allwinner A10, so po=
tentially the same problem is there.<br></div><div><br></div><div>While loo=
king more closer at this part, I now also discovered that the timer module =
from the Allwinner H3 is</div><div>mostly a stripped down version of the ti=
mer module in the Allwinner A10:</div><div><div><br></div><div>=C2=A0 Allwi=
nner A10, 10.2 Timer Register List, page 85:<br></div><div>=C2=A0 <a href=
=3D"https://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manual_V1.5.pdf"=
>https://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manual_V1.5.pdf</a>=
</div></div><div><br></div><div> The A10 version has six timers, where the =
H3 has only two. That should be fine I would say, the guest would simply</d=
iv><div>use those available on H3 and ignore the rest. There is however one=
 conflicting difference: the WDOG0 registers in the Allwinner H3 start</div=
><div>at a different offset and are also different. The current A10 timer d=
oes not currently implement the watchdog part.</div><div><br></div><div>The=
 watchdog part of this timer is relevant for the &#39;reset&#39; command in=
 U-Boot: that does not work right now, because</div><div>U-Boot implements =
the reset for the Allwinner H3 boards by letting this watchdog expire (and =
we dont emulate it).</div><div>Also, this timer module is required for boot=
ing Linux, without it the kernel crashes using the sunxi_defconfig:</div><d=
iv><br></div><div><pre>[    0.000000] PC is at sun4i_timer_init+0x34/0x168
[    0.000000] LR is at sun4i_timer_init+0x2c/0x168
[    0.000000] pc : [&lt;c07fa634&gt;]    lr : [&lt;c07fa62c&gt;]    psr: 6=
00000d3
[    0.000000] sp : c0a03f70  ip : eec00188  fp : ef7ed040<br>...<br>[    0=
.000000] [&lt;c07fa634&gt;] (sun4i_timer_init) from [&lt;c07fa4e8&gt;] (tim=
er_probe+0x74/0xe4)
[    0.000000] [&lt;c07fa4e8&gt;] (timer_probe) from [&lt;c07d9c10&gt;] (st=
art_kernel+0x2e0/0x440)
[    0.000000] [&lt;c07d9c10&gt;] (start_kernel) from [&lt;00000000&gt;] (0=
x0)
</pre></div><div><br></div><div>So in my opinion its a bit of a trade off h=
ere: we can keep it like this and re-use the A10 timer for now, and perhaps=
</div><div>attempt to generalize that module for proper use in both SoCs. O=
r we can introduce a new H3 specific timer module.</div><div>What do you th=
ink?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
Also, if you use &amp;error_abort, a failure in object_property_set_int() <=
br>
triggers abort(). See &quot;qapi/error.h&quot;:<br>
<br>
=C2=A0 * If @errp is &amp;error_abort, print a suitable message and abort()=
.<br>
=C2=A0 * If @errp is &amp;error_fatal, print a suitable message and exit(1)=
.<br>
<br>
&gt; +=C2=A0 =C2=A0 if (error_abort !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_reportf_err(error_abort, &quot;Coul=
dn&#39;t set clk0 frequency: &quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
So this if() block is useless.<br>
<br></blockquote><div>Ah ok, I&#39;ll remove them.<br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;s-&gt;h3-&gt;timer)=
, 24000000, &quot;clk1-freq&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>
&gt; +=C2=A0 =C2=A0 if (error_abort !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_reportf_err(error_abort, &quot;Coul=
dn&#39;t set clk1 frequency: &quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Similarly, remove if() block.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Mark H3 object realized */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(s-&gt;h3), true, &quot;=
realized&quot;, &amp;error_abort);<br>
&gt; +=C2=A0 =C2=A0 if (error_abort !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_reportf_err(error_abort, &quot;Coul=
dn&#39;t realize Allwinner H3: &quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Similarly, remove if() block.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* RAM */<br>
&gt; +=C2=A0 =C2=A0 if (machine-&gt;ram_size &gt; 1 * GiB) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Requested ram size is =
too large for this machine: &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;maximum is 1GB&quot;);<br>
<br>
Per <a href=3D"http://www.orangepi.org/orangepipc/" rel=3D"noreferrer" targ=
et=3D"_blank">http://www.orangepi.org/orangepipc/</a> this board comes with=
 a specific <br>
amount of RAM. I&#39;d enforce the default (1GiB) and refuse other cases.<b=
r></blockquote><div><br></div><div>OK sure, I&#39;ll change it to a enforci=
ng 1GiB. I do recall we briefly discussed this</div><div>in v1. Then we agr=
eed to make it an upper limit for use cases where resources are</div><div>l=
imited which is why I changed it like this.</div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
I noticed this by testing your series, without specifying the memory <br>
size you suggested in the cover (512) it defaults to 128 MiB, and the <br>
Raspian userland fails: <br></blockquote><div><br></div><div>Indeed! By the=
 way, this is also the case for U-Boot: it freezes when using 128MiB.</div>=
<div>Actually when working on the initial code I searched a bit for a way</=
div><div>to set a default ram size, but could not find it at that time. But=
 now I see in your comment below,</div><div>it can be done simply with mc-&=
gt;default_ram_size. Thanks a lot, I will surely add that!<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[ ***=C2=A0 ] (2 of 4) A start job is running for=E2=80=A6Persistent Storag=
e (37s / <br>
2min 1s)<br>
[=C2=A0 *** ] (2 of 4) A start job is running for=E2=80=A6Persistent Storag=
e (38s / <br>
2min 1s)<br>
[=C2=A0 OK=C2=A0 ] Started Flush Journal to Persistent Storage.<br>
Starting Create Volatile Files and Directories...<br>
Starting Armbian ZRAM config...<br>
[=C2=A0 =C2=A0 **] (3 of 6) A start job is running for=E2=80=A6s and Direct=
ories (55s / no <br>
limit)<br>
[=C2=A0 =C2=A0 =C2=A0*] (3 of 6) A start job is running for=E2=80=A6s and D=
irectories (55s / no <br>
limit)<br>
[=C2=A0 =C2=A0 **] (3 of 6) A start job is running for=E2=80=A6s and Direct=
ories (56s / no <br>
limit)<br>
[=C2=A0 OK=C2=A0 ] Started Create Volatile Files and Directories.<br>
[***=C2=A0 =C2=A0] (5 of 6) A start job is running for=E2=80=A6 ZRAM config=
 (1min 10s / <br>
1min 19s)<br>
[**=C2=A0 =C2=A0 ] (5 of 6) A start job is running for=E2=80=A6 ZRAM config=
 (1min 12s / <br>
1min 19s)<br>
[*=C2=A0 =C2=A0 =C2=A0] (5 of 6) A start job is running for=E2=80=A6 ZRAM c=
onfig (1min 13s / <br>
1min 19s)<br>
[FAILED] Failed to start Armbian ZRAM config.<br>
See &#39;systemctl status armbian-zram-config.service&#39; for details.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 memory_region_allocate_system_memory(&amp;s-&gt;sdram, =
NULL, &quot;orangepi.ram&quot;,<br>
<br>
There is only one type of ram on this machine, I&#39;d simply name this &qu=
ot;sdram&quot;.<br></blockquote><div><br></div><div>OK!</div><div> <br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0machine-&gt;ram_size);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
h3-&gt;memmap[AW_H3_SDRAM],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sdram);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Load target kernel */<br>
&gt; +=C2=A0 =C2=A0 orangepi_binfo.loader_start =3D s-&gt;h3-&gt;memmap[AW_=
H3_SDRAM];<br>
&gt; +=C2=A0 =C2=A0 orangepi_binfo.ram_size =3D machine-&gt;ram_size;<br>
&gt; +=C2=A0 =C2=A0 orangepi_binfo.nb_cpus=C2=A0 =3D AW_H3_NUM_CPUS;<br>
&gt; +=C2=A0 =C2=A0 arm_load_kernel(ARM_CPU(first_cpu), machine, &amp;orang=
epi_binfo);<br>
<br>
I wonder if we should tell the user &#39;-bios&#39; is not supported on thi=
s <br>
machine.<br></blockquote><div><br></div><div>Good suggestion, its not handl=
ed, at least not anywhere in the code I added for H3 support.</div><div>Sha=
ll I make it an error_report followed by exit(1), similar to the 1GiB check=
?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void orangepi_machine_init(MachineClass *mc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Orange Pi PC&quot;;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;init =3D orangepi_init;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;units_per_default_bus =3D 1;<br>
<br>
Maybe &quot;units_per_default_bus =3D 1&quot; belongs to patch 9 &quot;add =
SD/MMC host <br>
controller&quot;.<br></blockquote><div>True, it should be in patch 9 indeed=
. I overlooked this when separating the work in individual patches.</div><d=
iv>Now I am also wondering if I actually need this setting. Without it, the=
 SD device still works fine.</div><div>I did some greps in the code to disc=
over what it is used for, but its not very clear to me yet. Is this ment to=
</div><div>restrict machines to only one harddisk (or SD card)? If I try to=
 supply multiple SD cards with multiple -sd arguments,</div><div>this error=
 is printed, regardless of having units_per_default_bus=3D1 or not:</div><d=
iv><span style=3D"font-family:monospace">=C2=A0=C2=A0 qemu-system-arm: -sd =
test3.ext2: machine type does not support if=3Dsd,bus=3D1,unit=3D0</span><b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;min_cpus =3D AW_H3_NUM_CPUS;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;max_cpus =3D AW_H3_NUM_CPUS;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_cpus =3D AW_H3_NUM_CPUS;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D ARM_CPU_TYPE_NAME(&quot;cor=
tex-a7&quot;);<br>
<br>
Please add:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mc-&gt;default_ram_size =3D 1 * GiB;<br></block=
quote><div>Yes, thanks!<br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
&gt; +}<br>
&gt; +<br>
&gt; +DEFINE_MACHINE(&quot;orangepi-pc&quot;, orangepi_machine_init)<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index aae1a049b4..db682e49ca 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -486,6 +486,7 @@ L: <a href=3D"mailto:qemu-arm@nongnu.org" target=
=3D"_blank">qemu-arm@nongnu.org</a><br>
&gt;=C2=A0 =C2=A0S: Maintained<br>
&gt;=C2=A0 =C2=A0F: hw/*/allwinner-h3*<br>
&gt;=C2=A0 =C2=A0F: include/hw/*/allwinner-h3*<br>
&gt; +F: hw/arm/orangepi.c<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0ARM PrimeCell and CMSDK devices<br>
&gt;=C2=A0 =C2=A0M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs<br>
&gt; index 956e496052..8d5ea453d5 100644<br>
&gt; --- a/hw/arm/Makefile.objs<br>
&gt; +++ b/hw/arm/Makefile.objs<br>
&gt; @@ -34,7 +34,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_STRONGARM) +=3D strongarm.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboar=
d.o<br>
&gt; -obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o<br>
&gt; +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o orangepi.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o r=
aspi.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu1=
02.o<br>
&gt; <br>
<br>
</blockquote></div><div><br></div><div>Regards,</div><div>Niek<br></div><br=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Ni=
ek Linnenbank<br><br></div></div></div></div>

--0000000000009fcf3d059a00167c--

