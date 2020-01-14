Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A8EC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA0A222C3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjW3ZMo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA0A222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irVLv-0002CE-Il
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 18:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1irVKb-00010u-0b
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1irVKY-0002a1-Oc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:10:40 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:37552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1irVKY-0002YH-Gm; Tue, 14 Jan 2020 18:10:38 -0500
Received: by mail-il1-x144.google.com with SMTP id t8so13134017iln.4;
 Tue, 14 Jan 2020 15:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3FFQfPsRFaDHbuXSN67jTud0I4rWP7QwbBCeGw/FhQ4=;
 b=GjW3ZMo6h6l5AqtNz3Wc/8kJ3KRD3DSTSa2beXqPzvpaTUqp31FpAhESCs+x/azDN1
 bOxUQzneMV2NORir4howqKAiL+cUJrP8WbQgJfLDeBiAWK5ZaRbSV19U0bCqZHibx4pf
 2YJQuklsv5SB/rly/v/hVdBG5Yj+86DCHH0WFPgIMwxqcA4qjVcJAJZWlbLHs8Jlyd8M
 e8Y0hzL8iVG5l1JMkxYs6iJL1qPFMP1xhQbz8KzWN2/5h+RwL8dl9rWOBy3thLckNIPR
 kzaJIzvxtknlG5vcamy1IGrg0dMvoQ+tK0d6QRed47NGWiYHVb7ky7zXk6sJbXHJXhtj
 G0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3FFQfPsRFaDHbuXSN67jTud0I4rWP7QwbBCeGw/FhQ4=;
 b=iIseQJi12kkcGmN+xP9rbMcBOafiKQhFn/FY4JFHXOREDCx6Jp6unuuvDy/y9/nyVb
 mOd//jNHJgP8W9y2r2irfCHDDN06k2gbtTQnA0QMYyN3HCB/RhryrUURm5K15ldg/2BU
 NW9Cu4cfHyhGaV3CGo/J1BDh06hZ4xOwYxw8JRcnLHRL2koaIy0EZtG3dTtLzWxggLv8
 HHGqpRCsId+ZxWz/vxbAWILU4rXD7UbkuN9hwZsw0VLU0cIAOBj8r9uEm+HaUQ713Kkb
 8OAcTMFauna/axz6tUZNBHZF/hKLJh1xZLESBtyO5wXxLigFhWykj6h3kgBmbzSisOni
 G8Xw==
X-Gm-Message-State: APjAAAVEblGglfSP2j0V+gzGmBuCDDr/RuDr3CcX1FRvaB9oW8XEKuhc
 aV8Jt28Az0qOdDO3iO7l4nvFwgFoZnEsmTU02z4=
X-Google-Smtp-Source: APXvYqwE/Bb0D5t+dPApUvP8tLv1wuh0WjWlxol72mZemNryi3cR5pwHw2zSbfGtExDgjo+MD974kQoMxtTn4R83MDI=
X-Received: by 2002:a92:c647:: with SMTP id 7mr922065ill.28.1579043437931;
 Tue, 14 Jan 2020 15:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-11-nieklinnenbank@gmail.com>
 <9c878f16-b18c-cc1a-9e82-40dbdd31b823@redhat.com>
In-Reply-To: <9c878f16-b18c-cc1a-9e82-40dbdd31b823@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 15 Jan 2020 00:10:27 +0100
Message-ID: <CAPan3WpNxGRfixQp5CwCwTU_boCq4h-BdJgD=KJEhRrGt7S7wg@mail.gmail.com>
Subject: Re: [PATCH v3 10/17] hw/arm/allwinner-h3: add Boot ROM support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000033f06d059c21b3b2"
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

--00000000000033f06d059c21b3b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 12:28 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> > A real Allwinner H3 SoC contains a Boot ROM which is the
> > first code that runs right after the SoC is powered on.
> > The Boot ROM is responsible for loading user code (e.g. a bootloader)
> > from any of the supported external devices and writing the downloaded
> > code to internal SRAM. After loading the SoC begins executing the code
> > written to SRAM. This commits adds emulation of the Boot ROM firmware
> > setup functionality by loading user code from SD card.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   include/hw/arm/allwinner-h3.h | 23 +++++++++++++++++++++++
> >   hw/arm/allwinner-h3.c         | 28 ++++++++++++++++++++++++++++
> >   hw/arm/orangepi.c             |  3 +++
> >   3 files changed, 54 insertions(+)
> >
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index 5d74cca28e..4b66227ac4 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -50,6 +50,7 @@
> >   #include "hw/sd/allwinner-sdhost.h"
> >   #include "hw/net/allwinner-sun8i-emac.h"
> >   #include "target/arm/cpu.h"
> > +#include "sysemu/block-backend.h"
> >
> >   /**
> >    * Allwinner H3 device list
> > @@ -130,4 +131,26 @@ typedef struct AwH3State {
> >       MemoryRegion sram_c;
> >   } AwH3State;
> >
> > +/**
> > + * Emulate Boot ROM firmware setup functionality.
> > + *
> > + * A real Allwinner H3 SoC contains a Boot ROM
> > + * which is the first code that runs right after
> > + * the SoC is powered on. The Boot ROM is responsible
> > + * for loading user code (e.g. a bootloader) from any
> > + * of the supported external devices and writing the
> > + * downloaded code to internal SRAM. After loading the SoC
> > + * begins executing the code written to SRAM.
> > + *
> > + * This function emulates the Boot ROM by copying 32 KiB
> > + * of data from the given block device and writes it to
> > + * the start of the first internal SRAM memory.
> > + *
> > + * @s: Allwinner H3 state object pointer
> > + * @blk: Block backend device object pointer
> > + * @errp: Error object pointer for raising errors
> > + */
> > +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk,
> > +                                Error **errp);
> > +
> >   #endif /* HW_ARM_ALLWINNER_H3_H */
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index e692432b4e..e7b768ad5b 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -27,6 +27,7 @@
> >   #include "hw/char/serial.h"
> >   #include "hw/misc/unimp.h"
> >   #include "hw/usb/hcd-ehci.h"
> > +#include "hw/loader.h"
> >   #include "sysemu/sysemu.h"
> >   #include "hw/arm/allwinner-h3.h"
> >
> > @@ -168,6 +169,33 @@ enum {
> >       AW_H3_GIC_NUM_SPI       =3D 128
> >   };
> >
> > +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk, Error
> **errp)
> > +{
> > +    uint8_t *buffer;
> > +    int64_t rom_size =3D 32 * KiB;
>
> Why restrict to 32K? The A1 SRAM is 64K.
>

The reason is that the actual Boot ROM on the H3 also uses 32K:
    https://linux-sunxi.org/BROM

See the 'U-Boot SPL Limitations' table at the end of the page.

You can see the comment in the table there regarding the 32 KiB:
  "Sizes larger than 32 KiB are rejected by the BROM. Exactly 32 KiB is
fine, as verified by writing a special pattern at the end of the SPL and
checking it in the SRAM."

Probably it would not harm to increase it to the full size of the SRAM, but
I tried to model
the behavior as close to the real hardware as possible.

Regards,
Niek


> > +
> > +    int64_t blk_size =3D blk_getlength(blk);
> > +    if (blk_size <=3D 0) {
> > +        error_setg(errp, "%s: failed to get BlockBackend size",
> __func__);
> > +        return;
> > +    }
> > +
> > +    if (rom_size > blk_size) {
> > +        rom_size =3D blk_size;
> > +    }
> > +
> > +    buffer =3D g_new0(uint8_t, rom_size);
> > +    if (blk_pread(blk, 8 * KiB, buffer, rom_size) < 0) {
> > +        error_setg(errp, "%s: failed to read BlockBackend data",
> __func__);
> > +        return;
> > +    }
> > +
> > +    rom_add_blob("allwinner-h3.bootrom", buffer, rom_size,
> > +                  rom_size, s->memmap[AW_H3_SRAM_A1],
> > +                  NULL, NULL, NULL, NULL, false);
> > +    g_free(buffer);
> > +}
> > +
> >   static void allwinner_h3_init(Object *obj)
> >   {
> >       AwH3State *s =3D AW_H3(obj);
> > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > index 0eb52eb813..b722f49485 100644
> > --- a/hw/arm/orangepi.c
> > +++ b/hw/arm/orangepi.c
> > @@ -93,6 +93,9 @@ static void orangepi_init(MachineState *machine)
> >       if (bios_name) {
> >           error_report("BIOS not supported for this machine");
> >           exit(1);
> > +    } else if (!machine->kernel_filename && blk_is_available(blk)) {
> > +        /* Use Boot ROM to copy data from SD card to SRAM */
> > +        allwinner_h3_bootrom_setup(s->h3, blk, &error_fatal);
> >       }
> >       orangepi_binfo.loader_start =3D s->h3->memmap[AW_H3_SDRAM];
> >       orangepi_binfo.ram_size =3D machine->ram_size;
> >
>
>

--=20
Niek Linnenbank

--00000000000033f06d059c21b3b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 14, 2020 at 12:28 AM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On 1/8/20 9:00 PM, Niek Linnenbank wrote:<br>
&gt; A real Allwinner H3 SoC contains a Boot ROM which is the<br>
&gt; first code that runs right after the SoC is powered on.<br>
&gt; The Boot ROM is responsible for loading user code (e.g. a bootloader)<=
br>
&gt; from any of the supported external devices and writing the downloaded<=
br>
&gt; code to internal SRAM. After loading the SoC begins executing the code=
<br>
&gt; written to SRAM. This commits adds emulation of the Boot ROM firmware<=
br>
&gt; setup functionality by loading user code from SD card.<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h | 23 +++++++++++++++++++++++=
<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2=
8 ++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 3 +++<br>
&gt;=C2=A0 =C2=A03 files changed, 54 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index 5d74cca28e..4b66227ac4 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -50,6 +50,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/sd/allwinner-sdhost.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/net/allwinner-sun8i-emac.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt; +#include &quot;sysemu/block-backend.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * Allwinner H3 device list<br>
&gt; @@ -130,4 +131,26 @@ typedef struct AwH3State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_c;<br>
&gt;=C2=A0 =C2=A0} AwH3State;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/**<br>
&gt; + * Emulate Boot ROM firmware setup functionality.<br>
&gt; + *<br>
&gt; + * A real Allwinner H3 SoC contains a Boot ROM<br>
&gt; + * which is the first code that runs right after<br>
&gt; + * the SoC is powered on. The Boot ROM is responsible<br>
&gt; + * for loading user code (e.g. a bootloader) from any<br>
&gt; + * of the supported external devices and writing the<br>
&gt; + * downloaded code to internal SRAM. After loading the SoC<br>
&gt; + * begins executing the code written to SRAM.<br>
&gt; + *<br>
&gt; + * This function emulates the Boot ROM by copying 32 KiB<br>
&gt; + * of data from the given block device and writes it to<br>
&gt; + * the start of the first internal SRAM memory.<br>
&gt; + *<br>
&gt; + * @s: Allwinner H3 state object pointer<br>
&gt; + * @blk: Block backend device object pointer<br>
&gt; + * @errp: Error object pointer for raising errors<br>
&gt; + */<br>
&gt; +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#endif /* HW_ARM_ALLWINNER_H3_H */<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index e692432b4e..e7b768ad5b 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -27,6 +27,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/char/serial.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/unimp.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/usb/hcd-ehci.h&quot;<br>
&gt; +#include &quot;hw/loader.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/arm/allwinner-h3.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -168,6 +169,33 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_GIC_NUM_SPI=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 128<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk, Erro=
r **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t *buffer;<br>
&gt; +=C2=A0 =C2=A0 int64_t rom_size =3D 32 * KiB;<br>
<br>
Why restrict to 32K? The A1 SRAM is 64K.<br></blockquote><div><br></div><di=
v>The reason is that the actual Boot ROM on the H3 also uses 32K:</div><div=
>=C2=A0=C2=A0=C2=A0 <a href=3D"https://linux-sunxi.org/BROM">https://linux-=
sunxi.org/BROM</a></div><div><br></div><div>See the &#39;U-Boot SPL Limitat=
ions&#39; table at the end of the page.<br></div><div><br></div><div>You ca=
n see the comment in the table there regarding the 32 KiB:</div><div>=C2=A0=
 &quot;Sizes larger than 32 KiB are rejected by the BROM. Exactly 32 KiB=20
is fine, as verified by writing a special pattern at the end of the SPL=20
and checking it in the SRAM.&quot;</div><div>=C2=A0</div><div>Probably it w=
ould not harm to increase it to the full size of the SRAM, but I tried to m=
odel</div><div>the behavior as close to the real hardware as possible.</div=
><div><br></div><div>Regards,</div><div>Niek<br></div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 int64_t blk_size =3D blk_getlength(blk);<br>
&gt; +=C2=A0 =C2=A0 if (blk_size &lt;=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s: failed to get =
BlockBackend size&quot;, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (rom_size &gt; blk_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_size =3D blk_size;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 buffer =3D g_new0(uint8_t, rom_size);<br>
&gt; +=C2=A0 =C2=A0 if (blk_pread(blk, 8 * KiB, buffer, rom_size) &lt; 0) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s: failed to read=
 BlockBackend data&quot;, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rom_add_blob(&quot;allwinner-h3.bootrom&quot;, buffer, =
rom_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_si=
ze, s-&gt;memmap[AW_H3_SRAM_A1],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, =
NULL, NULL, NULL, false);<br>
&gt; +=C2=A0 =C2=A0 g_free(buffer);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void allwinner_h3_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3State *s =3D AW_H3(obj);<br>
&gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; index 0eb52eb813..b722f49485 100644<br>
&gt; --- a/hw/arm/orangepi.c<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -93,6 +93,9 @@ static void orangepi_init(MachineState *machine)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bios_name) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;BIOS not su=
pported for this machine&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
&gt; +=C2=A0 =C2=A0 } else if (!machine-&gt;kernel_filename &amp;&amp; blk_=
is_available(blk)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Use Boot ROM to copy data from SD card=
 to SRAM */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_h3_bootrom_setup(s-&gt;h3, blk,=
 &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0orangepi_binfo.loader_start =3D s-&gt;h3-&gt=
;memmap[AW_H3_SDRAM];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0orangepi_binfo.ram_size =3D machine-&gt;ram_=
size;<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000033f06d059c21b3b2--

