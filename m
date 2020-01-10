Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693F2C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 21:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226BA2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 21:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuVRIdIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226BA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq1jC-0004gb-9E
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 16:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iq1iR-0003zR-SE
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 16:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iq1iP-0006AV-Nq
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 16:21:11 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:44357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iq1iP-00063i-Et; Fri, 10 Jan 2020 16:21:09 -0500
Received: by mail-il1-x144.google.com with SMTP id z12so2883056iln.11;
 Fri, 10 Jan 2020 13:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zGViK/4t2XByOYwKHjaIFhYhH44jNeUXKn2puVX+wvM=;
 b=DuVRIdIyu2M9dSqtBwkuYH4tnVNm/Xj9Dd6JKBgTDpuHMB89GHgesLxn3VKhsbRxDy
 RibfGbpbxXHWUetjUlAKc9KIYvHf6CgI4X1UFb1TA3GkcIcQ50y1sE2uAxLJYbtAA5EY
 dIVnKW9YNOhKvvAqChtZAiNwvPpkBxfP6NyJLlAX5FDeSQYslaLRb2QQvfJgeNxFob0d
 InBqYea9cT4T2a4LYnNdc8HnsbQh4yWXHw08hxINRcmfqtkddXHmyrbGxaYZH160mEp5
 BA/MPDg77TdMramLoLDB3PxG8A1RiTRxuVkZOGafGD72QlYXMc1X3eOTOHIHEQIIjNMD
 JKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zGViK/4t2XByOYwKHjaIFhYhH44jNeUXKn2puVX+wvM=;
 b=bnKvS8cZ73RZRIMGCOEDt147u8yo44mOaG6avJy61GgaANxPhtefx6dchVdSdi/O96
 buwGfCqbkILai3zozrWKbyqz1kFVzFnQOnslbbCW02zFTzKOgfj5b1gzIvd3oVmG7eW0
 r8vJP7PbTDuCmWUecrIGAdE5auB95eFmBHOiZ/1mvocAkJGr9liYRIXfW2FMSi6ACVCc
 8L2r4y9zUg7Fm/DVmBEUvw4t7QyPFEoSJknMeC6sF51AuTUVRFJUGuA/GEGSH3pBA1zc
 0OGbRlpnRzKbIMkp5x1JxWHqHPeoiUxrBXR+jaQyMcJNZl8TtiDMbBAiuarRN1nkEeey
 FtzA==
X-Gm-Message-State: APjAAAUjXReu5wLDXFLLw306DxgdJe/87CaVzVIvn1zqt0HZ/ZIk+l1D
 r5pWpfORPrgkgfmwXZEJcXce5UWyccesmNdcVhQ=
X-Google-Smtp-Source: APXvYqzPKAWCY+vek+fYXmD4t+ZeoyrIBrA/Qan4SjWRvw8ZBLEKk/HQEp4S4iiPkikemu4g58uEnSO0pCid3vnOSGE=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr4301514ilq.306.1578691267833; 
 Fri, 10 Jan 2020 13:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-3-nieklinnenbank@gmail.com>
 <c41068dc-7684-3da2-e53e-649e3e4aded1@redhat.com>
In-Reply-To: <c41068dc-7684-3da2-e53e-649e3e4aded1@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 10 Jan 2020 22:20:56 +0100
Message-ID: <CAPan3WohW3fPFvGT62c_+3XmP59Zps74=32=5w4GFu9BVxNDCA@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] hw/arm: add Xunlong Orange Pi PC machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003ab315059bcfb4e8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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

--0000000000003ab315059bcfb4e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2020 at 11:44 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 1/8/20 9:00 PM, Niek Linnenbank wrote:
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
> >   hw/arm/orangepi.c    | 93 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   MAINTAINERS          |  1 +
> >   hw/arm/Makefile.objs |  2 +-
> >   3 files changed, 95 insertions(+), 1 deletion(-)
> >   create mode 100644 hw/arm/orangepi.c
> >
> > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > new file mode 100644
> > index 0000000000..051184f14f
> > --- /dev/null
> > +++ b/hw/arm/orangepi.c
> > @@ -0,0 +1,93 @@
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
> > +#include "sysemu/sysemu.h"
> > +
> > +static struct arm_boot_info orangepi_binfo =3D {
> > +    .board_id =3D -1,
>
> Since you use a dtb, I suppose Linux ignores this board_id.
>
> Nitpick, you can set this here:
>
>         .nb_cpus =3D AW_H3_NUM_CPUS,
>
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
>
> I'd do the bios check first, as it is cheap and avoid allocating RAM + H3=
:
>
>         /* Load target kernel or start using BootROM */
>         if (bios_name) {
>             error_report("BIOS not supported for this machine");
>             exit(1);
>         }
>
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
> > +    object_property_set_int(OBJECT(s->h3), 32768, "clk0-freq",
> > +                            &error_abort);
> > +    object_property_set_int(OBJECT(s->h3), 24000000, "clk1-freq",
>
> I find 24 * 1000 * 1000 easier to review.
>
> > +                            &error_abort);
> > +
> > +    /* Mark H3 object realized */
> > +    object_property_set_bool(OBJECT(s->h3), true, "realized",
> &error_abort);
> > +
> > +    /* SDRAM */
> > +    if (machine->ram_size !=3D 1 * GiB) {
> > +        error_report("Requested ram size is not supported for this
> machine: "
> > +                     "restricted to 1GiB");
>
> Maybe easier as "This machine can only be used with 1GiB of RAM"
>
> > +        exit(1);
> > +    }
> > +    memory_region_allocate_system_memory(&s->sdram, NULL, "sdram",
> > +                                         machine->ram_size);
> > +    memory_region_add_subregion(get_system_memory(),
> s->h3->memmap[AW_H3_SDRAM],
> > +                                &s->sdram);
> > +
> > +    /* Load target kernel or start using BootROM */
> > +    if (bios_name) {
> > +        error_report("BIOS not supported for this machine");
> > +        exit(1);
> > +    }
> > +    orangepi_binfo.loader_start =3D s->h3->memmap[AW_H3_SDRAM];
> > +    orangepi_binfo.ram_size =3D machine->ram_size;
> > +    orangepi_binfo.nb_cpus  =3D AW_H3_NUM_CPUS;
> > +    arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
> > +}
> > +
> > +static void orangepi_machine_init(MachineClass *mc)
> > +{
> > +    mc->desc =3D "Orange Pi PC";
> > +    mc->init =3D orangepi_init;
> > +    mc->min_cpus =3D AW_H3_NUM_CPUS;
> > +    mc->max_cpus =3D AW_H3_NUM_CPUS;
> > +    mc->default_cpus =3D AW_H3_NUM_CPUS;
> > +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
> > +    mc->default_ram_size =3D 1 * GiB;
> > +}
> > +
> > +DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dc2d7991bf..6e1b92b5fa 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -487,6 +487,7 @@ L: qemu-arm@nongnu.org
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
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Thanks Philippe! I will update the file with your comments and add the
reviewed by.

Regards
Niek

--=20
Niek Linnenbank

--0000000000003ab315059bcfb4e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 8, 2020 at 11:44 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 1/8/20 9:00 PM, Niek Linnenbank wrote:<br>
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
&gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 | 93 ++++++++++++++++++++++=
++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<=
br>
&gt;=C2=A0 =C2=A0hw/arm/Makefile.objs |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A03 files changed, 95 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/arm/orangepi.c<br>
&gt; <br>
&gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..051184f14f<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -0,0 +1,93 @@<br>
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
&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt; +<br>
&gt; +static struct arm_boot_info orangepi_binfo =3D {<br>
&gt; +=C2=A0 =C2=A0 .board_id =3D -1,<br>
<br>
Since you use a dtb, I suppose Linux ignores this board_id.<br>
<br>
Nitpick, you can set this here:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .nb_cpus =3D AW_H3_NUM_CPUS,<br>
<br>
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
<br>
I&#39;d do the bios check first, as it is cheap and avoid allocating RAM + =
H3:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Load target kernel or start using BootROM */=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bios_name) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;BIOS not suppo=
rted for this machine&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
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
&gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT(s-&gt;h3), 32768, &quot;=
clk0-freq&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT(s-&gt;h3), 24000000, &qu=
ot;clk1-freq&quot;,<br>
<br>
I find 24 * 1000 * 1000 easier to review.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Mark H3 object realized */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(s-&gt;h3), true, &quot;=
realized&quot;, &amp;error_abort);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* SDRAM */<br>
&gt; +=C2=A0 =C2=A0 if (machine-&gt;ram_size !=3D 1 * GiB) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Requested ram size is =
not supported for this machine: &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;restricted to 1GiB&quot;);<br>
<br>
Maybe easier as &quot;This machine can only be used with 1GiB of RAM&quot;<=
br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 memory_region_allocate_system_memory(&amp;s-&gt;sdram, =
NULL, &quot;sdram&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0machine-&gt;ram_size);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
h3-&gt;memmap[AW_H3_SDRAM],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sdram);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Load target kernel or start using BootROM */<br>
&gt; +=C2=A0 =C2=A0 if (bios_name) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;BIOS not supported for=
 this machine&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 orangepi_binfo.loader_start =3D s-&gt;h3-&gt;memmap[AW_=
H3_SDRAM];<br>
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
&gt; +=C2=A0 =C2=A0 mc-&gt;min_cpus =3D AW_H3_NUM_CPUS;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;max_cpus =3D AW_H3_NUM_CPUS;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_cpus =3D AW_H3_NUM_CPUS;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D ARM_CPU_TYPE_NAME(&quot;cor=
tex-a7&quot;);<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_ram_size =3D 1 * GiB;<br>
&gt; +}<br>
&gt; +<br>
&gt; +DEFINE_MACHINE(&quot;orangepi-pc&quot;, orangepi_machine_init)<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index dc2d7991bf..6e1b92b5fa 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -487,6 +487,7 @@ L: <a href=3D"mailto:qemu-arm@nongnu.org" target=
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
<br></blockquote><div>Thanks Philippe! I will update the file with your com=
ments and add the reviewed by. <br></div></div><div><br></div><div>Regards<=
/div><div>Niek<br></div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signatur=
e"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>

--0000000000003ab315059bcfb4e8--

