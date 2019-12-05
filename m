Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF5C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 22:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE16E20675
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 22:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n65rF2x2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE16E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iczRc-0002n7-02
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 17:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iczPh-0001na-Q0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 17:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iczPe-00011N-QN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 17:15:57 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:37838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iczPe-0000wC-Gd; Thu, 05 Dec 2019 17:15:54 -0500
Received: by mail-il1-x141.google.com with SMTP id t9so4463602iln.4;
 Thu, 05 Dec 2019 14:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2s8WccqH0C1+PGklupS+pdXblcVhyHCjpleiPomaBK0=;
 b=n65rF2x2f0IRclgKMAadltc2vIdQIqaUhpWp9K+W+RU82IFFPcT93GGXdht9smRjxc
 h2dTz37GS0RvQXwx96Zhysq9wGLVUQEYPt6zC1/FM1BC2/45f8r0tzi/sJ+p5MnY6zMk
 F2cLUqOgzWA4/YqGB04fO+6iYnIrjnvRB6qamBuAL1uB6+eYyD8pwgyH4aIGZt9eKUmD
 rGjuh8Wr1NZb2S+wYrDioipk3Og5/jj5wl5atL1zwNR5lxvv4TMchAW9ZOSR3fDeoE+M
 Tztq8fy23u45QxvxdlXNaPqhyBm3YJdkHZNgtof67xaoJb3W5MjN6w1A0M7DraaWq9AQ
 m4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2s8WccqH0C1+PGklupS+pdXblcVhyHCjpleiPomaBK0=;
 b=eDT2OU+nQo1GXxT1UK1OQeT8x5KW5nGJNs8RlmxDtUeGJcG0yaR6p33qfRoMoZgFTC
 erFcR8dOjAnTIO8iL/mPykPR3fW7SZASlC/2CA3EII9q8dPaVJCwcxjxextMn8y5Un1J
 43XE437bL6KyWAnbMwDoFKHUPR0jyo6iwo3/EPmXqYafr8OsJ99Zl0W/+tb4NbYHRP36
 jKTVRwLdyNtjvjjx5E7Pi3iewGW7UY5CpRUSO9axKKPaFOKaspG8cGS2LCMiXfj0W/mg
 /XYtxbTDCBiHCjQSBe3VwSPLMu/UXbL2LpOqzyetevXwhxh69GW1Li8oau2D7ruwvL9N
 bYRg==
X-Gm-Message-State: APjAAAVkvpu3NQRYVpcQiDtYagqZ+3UnBSUm09H/080mG/UFWLizlxhM
 0QkBuevZRB2F3t9DafUI8l2DL7H1PfLOedD1rP4=
X-Google-Smtp-Source: APXvYqyw2986wwRFiHi2HHxUV9JwBM8xeKr783/11dDugroBcWmk7/4r0bsBBjvwrgleCDh/TR6SIiBAgtwVe2OlvyQ=
X-Received: by 2002:a92:5a45:: with SMTP id o66mr10761765ilb.67.1575584153123; 
 Thu, 05 Dec 2019 14:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-3-nieklinnenbank@gmail.com>
 <b14e5a75-ebe3-311e-60a8-3f71b0874a10@redhat.com>
In-Reply-To: <b14e5a75-ebe3-311e-60a8-3f71b0874a10@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 5 Dec 2019 23:15:41 +0100
Message-ID: <CAPan3WohBP_47h1ZPP12ZuyiY43B3B6tGFMH-sK=LAAjMbwpaA@mail.gmail.com>
Subject: Re: [PATCH 02/10] hw: arm: add Xunlong Orange Pi PC machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c2c3f00598fc450d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c2c3f00598fc450d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Philippe,

On Tue, Dec 3, 2019 at 10:18 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> > The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> > based embedded computer with mainline support in both U-Boot
> > and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> > 512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> > various other I/O. This commit add support for the Xunlong
> > Orange Pi PC machine.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   MAINTAINERS          |  1 +
> >   hw/arm/Makefile.objs |  2 +-
> >   hw/arm/orangepi.c    | 90 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 92 insertions(+), 1 deletion(-)
> >   create mode 100644 hw/arm/orangepi.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 29c9936037..42c913d6cb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -485,6 +485,7 @@ L: qemu-arm@nongnu.org
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
> > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > new file mode 100644
> > index 0000000000..5ef2735f81
> > --- /dev/null
> > +++ b/hw/arm/orangepi.c
> > @@ -0,0 +1,90 @@
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
> > +    .loader_start =3D AW_H3_SDRAM_BASE,
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
> > +    Error *err =3D NULL;
> > +
>
> Here I'd add:
>
>        if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) !=3D=
 0)
> {
>            error_report("This board can only be used with cortex-a7 CPU")=
;
>            exit(1);
>        }
>
> Done!

> +    s->h3 =3D AW_H3(object_new(TYPE_AW_H3));
> > +
> > +    /* Setup timer properties */
> > +    object_property_set_int(OBJECT(&s->h3->timer), 32768, "clk0-freq",
> &err);
> > +    if (err !=3D NULL) {
> > +        error_reportf_err(err, "Couldn't set clk0 frequency: ");
> > +        exit(1);
> > +    }
> > +
> > +    object_property_set_int(OBJECT(&s->h3->timer), 24000000,
> "clk1-freq",
> > +                            &err);
> > +    if (err !=3D NULL) {
> > +        error_reportf_err(err, "Couldn't set clk1 frequency: ");
> > +        exit(1);
> > +    }
> > +
> > +    /* Mark H3 object realized */
> > +    object_property_set_bool(OBJECT(s->h3), true, "realized", &err);
>
> I'm not sure if that's correct but I'd simply use &error_abort here.
>
> Done, I applied it to all the functions and removed the err variable.

> +    if (err !=3D NULL) {
> > +        error_reportf_err(err, "Couldn't realize Allwinner H3: ");
> > +        exit(1);
> > +    }
> > +
> > +    /* RAM */
> > +    memory_region_allocate_system_memory(&s->sdram, NULL,
> "orangepi.ram",
> > +                                         machine->ram_size);
>
> I'd only allow machine->ram_size =3D=3D 1 * GiB here, since the onboard D=
RAM
> is not upgradable.
>

Agree, we should add something for that. Would it be acceptable if we make
the 1GB an upper limit?
I see that the Raspberry Pi is doing that too in hw/arm/raspi.c, like so:

    if (machine->ram_size > 1 * GiB) {
        error_report("Requested ram size is too large for this machine: "
                     "maximum is 1GB");
        exit(1);
    }

I think it would be helpful to allow the flexibility to the user of
reducing the RAM to less than 1GB,
in case resources of the host OS are limited. What do you think?



> > +    memory_region_add_subregion(get_system_memory(), AW_H3_SDRAM_BASE,
> > +                                &s->sdram);
> > +
> > +    /* Load target kernel */
> > +    orangepi_binfo.ram_size =3D machine->ram_size;
> > +    orangepi_binfo.nb_cpus  =3D AW_H3_NUM_CPUS;
> > +    arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
> > +}
> > +
> > +static void orangepi_machine_init(MachineClass *mc)
> > +{
> > +    mc->desc =3D "Orange Pi PC";
> > +    mc->init =3D orangepi_init;
> > +    mc->units_per_default_bus =3D 1;
> > +    mc->min_cpus =3D AW_H3_NUM_CPUS;
> > +    mc->max_cpus =3D AW_H3_NUM_CPUS;
> > +    mc->default_cpus =3D AW_H3_NUM_CPUS;
>
>         mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
>
> > +    mc->ignore_memory_transaction_failures =3D true;
>
> You should not use this flag in new design. See the documentation in
> include/hw/boards.h:
>
>   * @ignore_memory_transaction_failures:
>   *    [...] New board models
>   *    should instead use "unimplemented-device" for all memory ranges
> where
>   *    the guest will attempt to probe for a device that QEMU doesn't
>   *    implement and a stub device is required.
>
> You already use the "unimplemented-device".
>
> Thanks, I'm working on this now. I think that at least I'll need to add
all of the devices mentioned in the 4.1 Memory Mapping chapter of the
datasheet
as an unimplemented device. Previously I only added some that I thought
were relevant.

I added all the missing devices as unimplemented and removed the
ignore_memory_transaction_failures flag
from the machine. Now it seems Linux gets a data abort while probing the
uart1 serial device at 0x01c28400,
so I'll need to debug it further. I'll post back when I have more results.

Regards,
Niek



> > +}
> > +
> > +DEFINE_MACHINE("orangepi", orangepi_machine_init)
>
> Can you name it 'orangepi-pc'? So we can add other orangepi models.
>
> Thanks,
>
> Phil.
>
>

--=20
Niek Linnenbank

--000000000000c2c3f00598fc450d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Philippe,<br></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 3, 2019 at 10:18 AM Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 12/2/19 10:09 PM, Niek Linnenbank wrote:<br>
&gt; The Xunlong Orange Pi PC is an Allwinner H3 System on Chip<br>
&gt; based embedded computer with mainline support in both U-Boot<br>
&gt; and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,<br>
&gt; 512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and<br>
&gt; various other I/O. This commit add support for the Xunlong<br>
&gt; Orange Pi PC machine.<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<=
br>
&gt;=C2=A0 =C2=A0hw/arm/Makefile.objs |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 | 90 ++++++++++++++++++++++=
++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A03 files changed, 92 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/arm/orangepi.c<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 29c9936037..42c913d6cb 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -485,6 +485,7 @@ L: <a href=3D"mailto:qemu-arm@nongnu.org" target=
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
&gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..5ef2735f81<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -0,0 +1,90 @@<br>
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
&gt; +=C2=A0 =C2=A0 .loader_start =3D AW_H3_SDRAM_BASE,<br>
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
&gt; +=C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt; +<br>
<br>
Here I&#39;d add:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(machine-&gt;cpu_type, ARM_CPU_TYPE_NA=
ME(&quot;cortex-a7&quot;)) !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;This board can =
only be used with cortex-a7 CPU&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br></blockquote><div>Done!</div><div> <br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 s-&gt;h3 =3D AW_H3(object_new(TYPE_AW_H3));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Setup timer properties */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;s-&gt;h3-&gt;timer)=
, 32768, &quot;clk0-freq&quot;, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_reportf_err(err, &quot;Couldn&#39;t=
 set clk0 frequency: &quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;s-&gt;h3-&gt;timer)=
, 24000000, &quot;clk1-freq&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;err);<br>
&gt; +=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_reportf_err(err, &quot;Couldn&#39;t=
 set clk1 frequency: &quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Mark H3 object realized */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(s-&gt;h3), true, &quot;=
realized&quot;, &amp;err);<br>
<br>
I&#39;m not sure if that&#39;s correct but I&#39;d simply use &amp;error_ab=
ort here.<br>
<br></blockquote><div>Done, I applied it to all the functions and removed t=
he err variable.<br></div><div> <br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
&gt; +=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_reportf_err(err, &quot;Couldn&#39;t=
 realize Allwinner H3: &quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* RAM */<br>
&gt; +=C2=A0 =C2=A0 memory_region_allocate_system_memory(&amp;s-&gt;sdram, =
NULL, &quot;orangepi.ram&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0machine-&gt;ram_size);<br>
<br>
I&#39;d only allow machine-&gt;ram_size =3D=3D 1 * GiB here, since the onbo=
ard DRAM <br>
is not upgradable.<br></blockquote><div><br></div><div>Agree, we should add=
 something for that. Would it be acceptable if we make the 1GB an upper lim=
it?</div><div>I see that the Raspberry Pi is doing that too in hw/arm/raspi=
.c, like so:</div><div><br></div><div>=C2=A0 =C2=A0 if (machine-&gt;ram_siz=
e &gt; 1 * GiB) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Request=
ed ram size is too large for this machine: &quot;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;maximum is 1GB=
&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>=C2=A0 =C2=A0 }</div><d=
iv><br></div><div>I think it would be helpful to allow the flexibility to t=
he user of reducing the RAM to less than 1GB,</div><div>in case resources o=
f the host OS are limited. What do you think?<br></div><div>=C2=A0</div><di=
v><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), AW_H3_=
SDRAM_BASE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sdram);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Load target kernel */<br>
&gt; +=C2=A0 =C2=A0 orangepi_binfo.ram_size =3D machine-&gt;ram_size;<br>
&gt; +=C2=A0 =C2=A0 orangepi_binfo.nb_cpus=C2=A0 =3D AW_H3_NUM_CPUS;<br>
&gt; +=C2=A0 =C2=A0 arm_load_kernel(ARM_CPU(first_cpu), machine, &amp;orang=
epi_binfo);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void orangepi_machine_init(MachineClass *mc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Orange Pi PC&quot;;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;init =3D orangepi_init;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;units_per_default_bus =3D 1;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;min_cpus =3D AW_H3_NUM_CPUS;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;max_cpus =3D AW_H3_NUM_CPUS;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_cpus =3D AW_H3_NUM_CPUS;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D ARM_CPU_TYPE_NAME(&=
quot;cortex-a7&quot;);<br>
<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;ignore_memory_transaction_failures =3D true;<br>
<br>
You should not use this flag in new design. See the documentation in <br>
include/hw/boards.h:<br>
<br>
=C2=A0 * @ignore_memory_transaction_failures:<br>
=C2=A0 *=C2=A0 =C2=A0 [...] New board models<br>
=C2=A0 *=C2=A0 =C2=A0 should instead use &quot;unimplemented-device&quot; f=
or all memory ranges where<br>
=C2=A0 *=C2=A0 =C2=A0 the guest will attempt to probe for a device that QEM=
U doesn&#39;t<br>
=C2=A0 *=C2=A0 =C2=A0 implement and a stub device is required.<br>
<br>
You already use the &quot;unimplemented-device&quot;.<br>
<br></blockquote><div>Thanks, I&#39;m working on this now. I think that at =
least I&#39;ll need to add</div><div>all of the devices mentioned in the 4.=
1 Memory Mapping chapter of the datasheet</div><div>as an unimplemented dev=
ice. Previously I only added some that I thought were relevant.</div><div><=
br></div><div>I added all the missing devices as unimplemented and removed =
the ignore_memory_transaction_failures flag</div><div>from the machine. Now=
 it seems Linux gets a data abort while probing the uart1 serial device at =
0x01c28400,</div><div>so I&#39;ll need to debug it further. I&#39;ll post b=
ack when I have more results.</div><div><br></div><div>Regards,</div><div>N=
iek<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
&gt; +}<br>
&gt; +<br>
&gt; +DEFINE_MACHINE(&quot;orangepi&quot;, orangepi_machine_init)<br>
<br>
Can you name it &#39;orangepi-pc&#39;? So we can add other orangepi models.=
<br>
<br>
Thanks,<br>
<br>
Phil.<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000c2c3f00598fc450d--

