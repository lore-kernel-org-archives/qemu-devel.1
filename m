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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B65C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 20:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EACE2073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 20:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io8FyGOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EACE2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icbAC-00033u-Fn
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 15:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1icb8k-0002OP-Bl
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 15:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1icb8i-000105-3H
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 15:20:50 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:34966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1icb8h-0000w7-9R; Wed, 04 Dec 2019 15:20:48 -0500
Received: by mail-io1-xd42.google.com with SMTP id v18so1071048iol.2;
 Wed, 04 Dec 2019 12:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xPJxrSztFlFEdpfOr2gCi5I691E4UF6NIoWtO3B06sE=;
 b=io8FyGOa9L3xA0HRd4ZaE4YaBwIJ/vM/D89sBIJJxkgrCtnTkduo8a4TeVbS+cgPdL
 zEgt70djGtINfu+ZsJkss6kkLsEuUQb/AlxrZGDn4EdFuyZML9MvjTuerCi5IYw/MDD/
 LpjHovZdWYRZpE4nY3H8CeLnCGdTjgnIW6SwBiuetgL/pl9jM5hngw2UQER2w/5AmHqf
 GZ7v05q6FY2rliv41iPygtopHfkcF9Y5TZLrgDwk76NO0v0fCf7Qb3q0TlD8G5feYA2W
 zxS8tmZVrKVRgehQunE4SUpcVGHzcQ0f8qKmTZQtqv+JjdwNsPPHnxY5vXkP986a4Erk
 ombg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xPJxrSztFlFEdpfOr2gCi5I691E4UF6NIoWtO3B06sE=;
 b=gJBxp7f/aPLlIJdpdp8yhYsjFOboX3MwOYi8s7CVDWK99PrEqGGC5zI4O48/FiPkW7
 8bsBPzjSYjH2F34yidnoOMnmOYL87hakmqE04nL8CKvjX3UPk/52vSqJkWfHRzYOjQUT
 0yV7n035oL36aBfft1qTKO3Zenl/8I9KtddtokRGV08YMpAhSy+idAv6XnJYvrDDU4Ia
 2erZ6uFFye4e1EcocVSIchpm/61ZGPfnfjoOGLuAuQdfaSdvmCSFCBUPFML1OjMCIyzm
 QO7q966h6a70qbJjbLKbBAK1+DuAJg1VGORDsgInoP6wOuWyr7cQJNHwKHkNnqq9MyQZ
 7dNQ==
X-Gm-Message-State: APjAAAWZfCFFwui86vJULIbOqPMFCPdaok1h5jlENXi5MXN6iYxwMBtq
 FLVeF9SYmxnDnNgcjqJOZk3mu4TBxG+T1b+JNsY=
X-Google-Smtp-Source: APXvYqyzz5Arr3qpyZfmpyw21ENq55Y10LZVduz0yt136YhFMZAInQa7zIdxi/RQswbrpenaeK4Ty++d4DIQWwKL6F8=
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr4824173jac.126.1575490844837; 
 Wed, 04 Dec 2019 12:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-5-nieklinnenbank@gmail.com>
 <CAL1e-=gVMXsWKAdo8c8QtjAYeK6p0AyTmi_a-sFHL2x4wGq6Vg@mail.gmail.com>
In-Reply-To: <CAL1e-=gVMXsWKAdo8c8QtjAYeK6p0AyTmi_a-sFHL2x4wGq6Vg@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 4 Dec 2019 21:20:33 +0100
Message-ID: <CAPan3WrXiz-DxQ+ZV6F3bSPXMTeOLehD8i85WqqT3xPddPBwsw@mail.gmail.com>
Subject: Re: [PATCH 04/10] arm: allwinner-h3: add USB host controller
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000002753aa0598e68c8a"
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
Cc: "b.galvani@gmail.com" <b.galvani@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002753aa0598e68c8a
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 4, 2019 at 5:11 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Monday, December 2, 2019, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
>
>> The Allwinner H3 System on Chip contains multiple USB 2.0 bus
>> connections which provide software access using the Enhanced
>> Host Controller Interface (EHCI) and Open Host Controller
>> Interface (OHCI) interfaces. This commit adds support for
>> both interfaces in the Allwinner H3 System on Chip.
>>
>> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>> ---
>
>
> Niek, hi!
>
> I would like to clarify a detail here:
>
> The spec of the SoC enumerates (in 8.5.2.4. USB Host Register List) a
> number of registers for reading various USB-related states, but also for
> setting some of USB features.
>
> Does this series cover these registers, and interaction with them? If yes,
> how and where? If not, do you think it is not necessary at all? Or perhaps
> that it is a non-crucial limitation of this series?
>

Hello Aleksandar!

Very good question, I will try to explain what I did to support USB for the
Allwinner H3 emulation.
EHCI and OHCI are both standardized interfaces to the USB bus and both
provide their own standardized software interface.
Because they are standards, operatings system drivers can implement a
generic driver which uses the defined interface and
re-use it in multiple boards/platforms. Things that can be different
between boards are, for example the base address in
memory where the registers are provided.

In QEMU I found that both the OHCI and EHCI host controllers are already
emulated and used by other boards as well. For example,
you can find the OHCI registers from 8.5.2.4 implemented in the file
hw/usb/hcd-ohci.c:1515 in ohci_mem_read(). So for the Allwinner
H3 I simply had to define the base address for both controllers and create
the objects. At that point, the Linux kernel can access
the USB bus with the generic EHCI/OHCI platform drivers. In the Linux code,
you can see in the file ./arch/arm/boot/dts/sunxi-h3-h5.dtsi:281
the definitions named ehci0-ehci3 and ohci0-ohci3 where it specifies in the
device tree configuration to load the generic drivers.


>
> Thanks in advance, and congrats for your, it seems, first submission!
>
>
Thank you Aleksandar! Indeed, it is my first submission. I will do my best
to
update the patches to comply with the QEMU coding style and best practises.

Regards,
Niek


> Aleksandar
>
>
>  hw/arm/allwinner-h3.c    | 20 ++++++++++++++++++++
>>  hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++
>>  hw/usb/hcd-ehci.h        |  1 +
>>  3 files changed, 38 insertions(+)
>>
>> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
>> index 5566e979ec..afeb49c0ac 100644
>> --- a/hw/arm/allwinner-h3.c
>> +++ b/hw/arm/allwinner-h3.c
>> @@ -26,6 +26,7 @@
>>  #include "hw/sysbus.h"
>>  #include "hw/arm/allwinner-h3.h"
>>  #include "hw/misc/unimp.h"
>> +#include "hw/usb/hcd-ehci.h"
>>  #include "sysemu/sysemu.h"
>>
>>  static void aw_h3_init(Object *obj)
>> @@ -183,6 +184,25 @@ static void aw_h3_realize(DeviceState *dev, Error
>> **errp)
>>      }
>>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, AW_H3_CCU_BASE);
>>
>> +    /* Universal Serial Bus */
>> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
>> +                         s->irq[AW_H3_GIC_SPI_EHCI0]);
>> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI1_BASE,
>> +                         s->irq[AW_H3_GIC_SPI_EHCI1]);
>> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI2_BASE,
>> +                         s->irq[AW_H3_GIC_SPI_EHCI2]);
>> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI3_BASE,
>> +                         s->irq[AW_H3_GIC_SPI_EHCI3]);
>> +
>> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI0_BASE,
>> +                         s->irq[AW_H3_GIC_SPI_OHCI0]);
>> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI1_BASE,
>> +                         s->irq[AW_H3_GIC_SPI_OHCI1]);
>> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI2_BASE,
>> +                         s->irq[AW_H3_GIC_SPI_OHCI2]);
>> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI3_BASE,
>> +                         s->irq[AW_H3_GIC_SPI_OHCI3]);
>> +
>>      /* UART */
>>      if (serial_hd(0)) {
>>          serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
>> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
>> index 020211fd10..174c3446ef 100644
>> --- a/hw/usb/hcd-ehci-sysbus.c
>> +++ b/hw/usb/hcd-ehci-sysbus.c
>> @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info = {
>>      .class_init    = ehci_exynos4210_class_init,
>>  };
>>
>> +static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
>> +{
>> +    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +
>> +    sec->capsbase = 0x0;
>> +    sec->opregbase = 0x10;
>> +    set_bit(DEVICE_CATEGORY_USB, dc->categories);
>> +}
>> +
>> +static const TypeInfo ehci_aw_h3_type_info = {
>> +    .name          = TYPE_AW_H3_EHCI,
>> +    .parent        = TYPE_SYS_BUS_EHCI,
>> +    .class_init    = ehci_aw_h3_class_init,
>> +};
>> +
>>  static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
>>  {
>>      SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
>> @@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)
>>      type_register_static(&ehci_platform_type_info);
>>      type_register_static(&ehci_xlnx_type_info);
>>      type_register_static(&ehci_exynos4210_type_info);
>> +    type_register_static(&ehci_aw_h3_type_info);
>>      type_register_static(&ehci_tegra2_type_info);
>>      type_register_static(&ehci_ppc4xx_type_info);
>>      type_register_static(&ehci_fusbh200_type_info);
>> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
>> index 0298238f0b..edb59311c4 100644
>> --- a/hw/usb/hcd-ehci.h
>> +++ b/hw/usb/hcd-ehci.h
>> @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
>>  #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
>>  #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
>>  #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
>> +#define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
>>  #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
>>  #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
>>  #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
>> --
>> 2.17.1
>>
>>
>>

-- 
Niek Linnenbank

--0000000000002753aa0598e68c8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 4, 2019 at 5:11 PM Aleksa=
ndar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar=
.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><br><br>On Monday, December 2, 2019, Niek Linnenbank &lt;<=
a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank=
@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">The Allwinner H3 System on Chip contains multiple USB 2.0 bus<br>
connections which provide software access using the Enhanced<br>
Host Controller Interface (EHCI) and Open Host Controller<br>
Interface (OHCI) interfaces. This commit adds support for<br>
both interfaces in the Allwinner H3 System on Chip.<br>
<br>
Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
---</blockquote><div><br></div><div>Niek, hi!</div><div><br></div><div>I wo=
uld like to clarify a detail here:</div><div><br></div><div>The spec of the=
 SoC enumerates (in 8.5.2.4. USB Host Register List) a number of registers =
for reading various USB-related states, but also for setting some of USB fe=
atures.</div><div>=C2=A0</div><div>Does this series cover these registers, =
and interaction with them? If yes, how and where? If not, do you think it i=
s not necessary at all? Or perhaps that it is a non-crucial limitation of t=
his series?</div></blockquote><div><br></div><div>Hello Aleksandar!</div><d=
iv><br></div><div>Very good question, I will try to explain what I did to s=
upport USB for the Allwinner H3 emulation.</div><div>EHCI and OHCI are both=
 standardized interfaces to the USB bus and both provide their own standard=
ized software interface.</div><div>Because they are standards, operatings s=
ystem drivers can implement a generic driver which uses the defined interfa=
ce and</div><div>re-use it in multiple boards/platforms. Things that can be=
 different between boards are, for example the base address in</div><div>me=
mory where the registers are provided.</div><div><br></div><div>In QEMU I f=
ound that both the OHCI and EHCI host controllers are already emulated and =
used by other boards as well. For example,</div><div>you can find the OHCI =
registers from 8.5.2.4 implemented in the file hw/usb/hcd-ohci.c:1515 in oh=
ci_mem_read(). So for the Allwinner</div><div>H3 I simply had to define the=
 base address for both controllers and create the objects. At that point, t=
he Linux kernel can access</div><div>the USB bus with the generic EHCI/OHCI=
 platform drivers. In the Linux code, you can see in the file ./arch/arm/bo=
ot/dts/sunxi-h3-h5.dtsi:281</div><div>the definitions named ehci0-ehci3 and=
 ohci0-ohci3 where it specifies in the device tree configuration to load th=
e generic drivers.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div><br></div><div>Thanks in advance, and congrats for you=
r, it seems, first submission!</div><div><br></div></blockquote><div><br></=
div><div>Thank you Aleksandar! Indeed, it is my first submission. I will do=
 my best to</div><div>update the patches to comply with the QEMU coding sty=
le and best practises.</div><div><br></div><div>Regards,</div><div>Niek<br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv></div><div>Aleksandar</div><div><br></div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
=C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 | 20 ++++++++++++++++++++<br>
=C2=A0hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++<br>
=C2=A0hw/usb/hcd-ehci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A03 files changed, 38 insertions(+)<br>
<br>
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
index 5566e979ec..afeb49c0ac 100644<br>
--- a/hw/arm/allwinner-h3.c<br>
+++ b/hw/arm/allwinner-h3.c<br>
@@ -26,6 +26,7 @@<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;hw/arm/allwinner-h3.h&quot;<br>
=C2=A0#include &quot;hw/misc/unimp.h&quot;<br>
+#include &quot;hw/usb/hcd-ehci.h&quot;<br>
=C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
<br>
=C2=A0static void aw_h3_init(Object *obj)<br>
@@ -183,6 +184,25 @@ static void aw_h3_realize(DeviceState *dev, Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;ccu), 0, AW_H=
3_CCU_BASE);<br>
<br>
+=C2=A0 =C2=A0 /* Universal Serial Bus */<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI0]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI1_BASE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI1]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI2_BASE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI2]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI3_BASE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI3]);<br>
+<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, AW_H3_OHCI0_BA=
SE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI0]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, AW_H3_OHCI1_BA=
SE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI1]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, AW_H3_OHCI2_BA=
SE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI2]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, AW_H3_OHCI3_BA=
SE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI3]);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* UART */<br>
=C2=A0 =C2=A0 =C2=A0if (serial_hd(0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial_mm_init(get_system_memory(), AW_H3=
_UART0_REG_BASE, 2,<br>
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c<br>
index 020211fd10..174c3446ef 100644<br>
--- a/hw/usb/hcd-ehci-sysbus.c<br>
+++ b/hw/usb/hcd-ehci-sysbus.c<br>
@@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info =3D {<=
br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D ehci_exynos4210_class_init=
,<br>
=C2=A0};<br>
<br>
+static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 sec-&gt;capsbase =3D 0x0;<br>
+=C2=A0 =C2=A0 sec-&gt;opregbase =3D 0x10;<br>
+=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_USB, dc-&gt;categories);<br>
+}<br>
+<br>
+static const TypeInfo ehci_aw_h3_type_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_H3_EHCI,=
<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_EHCI,<br=
>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D ehci_aw_h3_class_init,<br>
+};<br>
+<br>
=C2=A0static void ehci_tegra2_class_init(ObjectClass *oc, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);<br>
@@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_platform_type_info);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_xlnx_type_info);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_exynos4210_type_info);<b=
r>
+=C2=A0 =C2=A0 type_register_static(&amp;ehci_aw_h3_type_info);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_tegra2_type_info);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_ppc4xx_type_info);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_fusbh200_type_info);<br>
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h<br>
index 0298238f0b..edb59311c4 100644<br>
--- a/hw/usb/hcd-ehci.h<br>
+++ b/hw/usb/hcd-ehci.h<br>
@@ -342,6 +342,7 @@ typedef struct EHCIPCIState {<br>
=C2=A0#define TYPE_SYS_BUS_EHCI &quot;sysbus-ehci-usb&quot;<br>
=C2=A0#define TYPE_PLATFORM_EHCI &quot;platform-ehci-usb&quot;<br>
=C2=A0#define TYPE_EXYNOS4210_EHCI &quot;exynos4210-ehci-usb&quot;<br>
+#define TYPE_AW_H3_EHCI &quot;aw-h3-ehci-usb&quot;<br>
=C2=A0#define TYPE_TEGRA2_EHCI &quot;tegra2-ehci-usb&quot;<br>
=C2=A0#define TYPE_PPC4xx_EHCI &quot;ppc4xx-ehci-usb&quot;<br>
=C2=A0#define TYPE_FUSBH200_EHCI &quot;fusbh200-ehci-usb&quot;<br>
-- <br>
2.17.1<br>
<br>
<br>
</blockquote>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000002753aa0598e68c8a--

