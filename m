Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351FCC35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 22:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E341A20661
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 22:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJt5uB/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E341A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyNTw-00020Y-5B
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 17:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyNSl-0001Xc-Al
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 17:11:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyNSf-0000SF-OK
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 17:11:31 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iyNSf-0000Rh-Fz; Sun, 02 Feb 2020 17:11:25 -0500
Received: by mail-io1-xd42.google.com with SMTP id x1so14534032iop.7;
 Sun, 02 Feb 2020 14:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hpNRUVgQkadJR2Tjc4Zw9xbnZm5gmJDENV0KheuIeys=;
 b=hJt5uB/LRUZY16viM/29sOxBdXKaax2WVJKCvAmM3hL4A7zlPdBccOpCX6w/Sx5oIw
 NCcNfjSgCujuapfYysXG63gu+QKRquPAFKH894CTkRdGDuxFI3nr9WYK2qu/n3saf1BN
 uqSuHqBopDfDERasdFloRB2R5r7QezkDLHYdrHc6Q2jfn3gxN948nXd7alMdzMAZeVET
 5Xz21BnVfW7V4a5bTrrBkCG0dAMEoh+pkp5FTr9Pc+UmnJwAEsoJ0PgLeQMsBeDYdWgj
 WEUedJRAvScWu4CJQl2CUjy1HBD1OoDN8DDl8/BbnQ6RNnRTDNKhskOM0XGqwXa6SbY7
 swZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hpNRUVgQkadJR2Tjc4Zw9xbnZm5gmJDENV0KheuIeys=;
 b=Mf0EteTK+ZUF+Md6J+Q50F82U2s1uiDfknKCtGCJ7YDu98Fa6VWLg8i64I94rLDdVt
 IvqpokAjeZrlgx4u/hd+UBy9q2V87vG6bDhiREYlSbHBdebLi39PhIzCC2/bcJN1vDzr
 b3ktwlD25qPPqiUBUwwJRUPC/l3wDGmzFLPOHjq46fbVCj9WMLnqNXXoQFsGCDEt7QSM
 s3fzzcjdUGJ5qX4uXk2mD8QlloySAnsDwZZ8P/tVSwH1hhOsFNwRULC+RBlzPZSz+/rJ
 WQ8HuHt3i7VyLU+1dZ29HdR4XCGSR2aeMHNe3v83glqrCdVSBa5FI//0KJJYjsklPte9
 jNxQ==
X-Gm-Message-State: APjAAAVqfGDj1J8fPpcqJKeEVNa3iwQdtZIm9LbYGBXfMciIBgOdSnvT
 6NiCqrS1fbWq/Ty1eZKE0n6F/PNteiPkjNsnX8Q=
X-Google-Smtp-Source: APXvYqwQ997SqqAzdj3ngl0iUpOt5i2e4kvb/aF1acVoEV8a2T16IQb2vFtf3z4aeKmn+tXviREhXqU+3bev28EqALU=
X-Received: by 2002:a6b:6f01:: with SMTP id k1mr17026198ioc.28.1580681484449; 
 Sun, 02 Feb 2020 14:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-11-nieklinnenbank@gmail.com>
 <1179d8a3-e61d-ad1f-bde9-3a73fde766a8@redhat.com>
In-Reply-To: <1179d8a3-e61d-ad1f-bde9-3a73fde766a8@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 2 Feb 2020 23:11:13 +0100
Message-ID: <CAPan3Wo6hNXyJees53jJhw5i94JVu-eYG6YW+rZTMpCNPsDYNA@mail.gmail.com>
Subject: Re: [PATCH v4 10/20] hw/arm/allwinner-h3: add Boot ROM support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000623cf6059d9f1652"
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

--000000000000623cf6059d9f1652
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2020 at 8:14 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> > A real Allwinner H3 SoC contains a Boot ROM which is the
> > first code that runs right after the SoC is powered on.
> > The Boot ROM is responsible for loading user code (e.g. a bootloader)
> > from any of the supported external devices and writing the downloaded
> > code to internal SRAM. After loading the SoC begins executing the code
> > written to SRAM.
> >
> > This commits adds emulation of the Boot ROM firmware setup functionalit=
y
> > by loading user code from SD card in the A1 SRAM. While the A1 SRAM is
> > 64KiB, we limit the size to 32KiB because the real H3 Boot ROM also
> rejects
> > sizes larger than 32KiB. For reference, this behaviour is documented
> > by the Linux Sunxi project wiki at:
> >
> >    https://linux-sunxi.org/BROM#U-Boot_SPL_limitations
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   include/hw/arm/allwinner-h3.h | 23 +++++++++++++++++++++++
> >   hw/arm/allwinner-h3.c         | 28 ++++++++++++++++++++++++++++
> >   hw/arm/orangepi.c             |  5 +++++
> >   3 files changed, 56 insertions(+)
> >
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index f9b9a02373..f5e16266cd 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -46,6 +46,7 @@
> >   #include "hw/sd/allwinner-sdhost.h"
> >   #include "hw/net/allwinner-sun8i-emac.h"
> >   #include "target/arm/cpu.h"
> > +#include "sysemu/block-backend.h"
> >
> >   /**
> >    * Allwinner H3 device list
> > @@ -129,4 +130,26 @@ typedef struct AwH3State {
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
> > index 1085223812..3d0470825a 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -29,6 +29,7 @@
> >   #include "hw/char/serial.h"
> >   #include "hw/misc/unimp.h"
> >   #include "hw/usb/hcd-ehci.h"
> > +#include "hw/loader.h"
> >   #include "sysemu/sysemu.h"
> >   #include "hw/arm/allwinner-h3.h"
> >
> > @@ -170,6 +171,33 @@ enum {
> >       AW_H3_GIC_NUM_SPI       =3D 128
> >   };
> >
> > +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk, Error
> **errp)
> > +{
> > +    uint8_t *buffer;
> > +    int64_t rom_size =3D 32 * KiB;
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
>
> This doesn't seem correct, have you tried to use a 1MB file?
>
> This can't be bigger than the SRAM size, 64KB.
>

This check was supposed to take into account the possibility that
the BlockBackend is smaller than the rom_size. However, if the rom cannot
be read from the BlockBackend it will return an error code anyway.

So the check can simply be removed. Thanks!


>
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
> > index 25bf85f8fc..9d4c79885e 100644
> > --- a/hw/arm/orangepi.c
> > +++ b/hw/arm/orangepi.c
> > @@ -95,6 +95,11 @@ static void orangepi_init(MachineState *machine)
> >       memory_region_add_subregion(get_system_memory(),
> s->h3->memmap[AW_H3_SDRAM],
> >                                   &s->sdram);
> >
> > +    /* Load target kernel or start using BootROM */
> > +    if (!machine->kernel_filename && blk_is_available(blk)) {
> > +        /* Use Boot ROM to copy data from SD card to SRAM */
> > +        allwinner_h3_bootrom_setup(s->h3, blk, &error_fatal);
> allwinner_h3_bootrom_setup() doesn't need the errp argument, you can use
> error_fatal directly there.
>

OK, I'll use error_fatal and remove the errp argument.

Regards,
Niek


>
> > +    }
> >       orangepi_binfo.loader_start =3D s->h3->memmap[AW_H3_SDRAM];
> >       orangepi_binfo.ram_size =3D machine->ram_size;
> >       arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
> >
>
>

--=20
Niek Linnenbank

--000000000000623cf6059d9f1652
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 19, 2020 at 8:14 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 1/19/20 1:50 AM, Niek Linnenbank wrote:<br>
&gt; A real Allwinner H3 SoC contains a Boot ROM which is the<br>
&gt; first code that runs right after the SoC is powered on.<br>
&gt; The Boot ROM is responsible for loading user code (e.g. a bootloader)<=
br>
&gt; from any of the supported external devices and writing the downloaded<=
br>
&gt; code to internal SRAM. After loading the SoC begins executing the code=
<br>
&gt; written to SRAM.<br>
&gt; <br>
&gt; This commits adds emulation of the Boot ROM firmware setup functionali=
ty<br>
&gt; by loading user code from SD card in the A1 SRAM. While the A1 SRAM is=
<br>
&gt; 64KiB, we limit the size to 32KiB because the real H3 Boot ROM also re=
jects<br>
&gt; sizes larger than 32KiB. For reference, this behaviour is documented<b=
r>
&gt; by the Linux Sunxi project wiki at:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://linux-sunxi.org/BROM#U-Boot_SPL_limita=
tions" rel=3D"noreferrer" target=3D"_blank">https://linux-sunxi.org/BROM#U-=
Boot_SPL_limitations</a><br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h | 23 +++++++++++++++++++++++=
<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2=
8 ++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 5 +++++<br>
&gt;=C2=A0 =C2=A03 files changed, 56 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index f9b9a02373..f5e16266cd 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -46,6 +46,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/sd/allwinner-sdhost.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/net/allwinner-sun8i-emac.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt; +#include &quot;sysemu/block-backend.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * Allwinner H3 device list<br>
&gt; @@ -129,4 +130,26 @@ typedef struct AwH3State {<br>
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
&gt; index 1085223812..3d0470825a 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -29,6 +29,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/char/serial.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/unimp.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/usb/hcd-ehci.h&quot;<br>
&gt; +#include &quot;hw/loader.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/arm/allwinner-h3.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -170,6 +171,33 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_GIC_NUM_SPI=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 128<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk, Erro=
r **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t *buffer;<br>
&gt; +=C2=A0 =C2=A0 int64_t rom_size =3D 32 * KiB;<br>
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
<br>
This doesn&#39;t seem correct, have you tried to use a 1MB file?<br>
<br>
This can&#39;t be bigger than the SRAM size, 64KB.<br></blockquote><div><br=
></div><div>This check was supposed to take into account the possibility th=
at</div><div>the BlockBackend is smaller than the rom_size. However, if the=
 rom cannot</div><div>be read from the BlockBackend it will return an error=
 code anyway.</div><div><br></div><div>So the check can simply be removed. =
Thanks!<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
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
&gt; index 25bf85f8fc..9d4c79885e 100644<br>
&gt; --- a/hw/arm/orangepi.c<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -95,6 +95,11 @@ static void orangepi_init(MachineState *machine)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(get_system_memor=
y(), s-&gt;h3-&gt;memmap[AW_H3_SDRAM],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&gt;sdram);<b=
r>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* Load target kernel or start using BootROM */<br>
&gt; +=C2=A0 =C2=A0 if (!machine-&gt;kernel_filename &amp;&amp; blk_is_avai=
lable(blk)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Use Boot ROM to copy data from SD card=
 to SRAM */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_h3_bootrom_setup(s-&gt;h3, blk,=
 &amp;error_fatal);<br>
allwinner_h3_bootrom_setup() doesn&#39;t need the errp argument, you can us=
e <br>
error_fatal directly there.<br></blockquote><div><br></div><div>OK, I&#39;l=
l use error_fatal and remove the errp argument.</div><div><br></div><div>Re=
gards,</div><div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0orangepi_binfo.loader_start =3D s-&gt;h3-&gt=
;memmap[AW_H3_SDRAM];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0orangepi_binfo.ram_size =3D machine-&gt;ram_=
size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0arm_load_kernel(ARM_CPU(first_cpu), machine,=
 &amp;orangepi_binfo);<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000623cf6059d9f1652--

