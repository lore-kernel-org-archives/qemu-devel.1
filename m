Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D4C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1DD20691
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2qbtuge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1DD20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC7IX-0001w1-Da
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 15:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC7Hf-0000zp-8G
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 15:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC7Hd-0005VO-LL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 15:44:51 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jC7Hd-0005Uy-FX; Wed, 11 Mar 2020 15:44:49 -0400
Received: by mail-io1-xd43.google.com with SMTP id k4so3221246ior.4;
 Wed, 11 Mar 2020 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sStzUROPFbNgloBsdUZk7FIRcE4lmU9fOgPFV9ssxS4=;
 b=p2qbtugeBILQGO4pSkJxkVpz/SmS7SqAPQ6lr+fGC5haRlBSVR5MfQ22itCe4/8OKn
 eDDtzAN9u+HsIKi4qJuW8QuL6lVt0cXg8O9rl5fTm5q5nvFfkvm0iTeu1p5tuiEdJx3M
 2S+8YbwOL+2OTpdv9IEOrgSSL79UrUfdtwrZOOYNhDjmMxHhxan3UZdDhtA2XYfmeDd5
 1Jpg1D1nLXshx6wt1Q63GeLKsGjFGuGKBgYjftcVTqlqcvhL3PiZThd1MkjkRz7qvKHK
 KKQPZ2N7PX4Pv0rdXHDsPlPu/lmU1NsshcFT8MB/jnUI4p0wDr+FjbjvhYjr+8R54srg
 BGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sStzUROPFbNgloBsdUZk7FIRcE4lmU9fOgPFV9ssxS4=;
 b=fl/ZB6maPVDhvdElxGFojMMDjekfn2HKZo6p/E8cle/0iF84CWb3QivfJbKLyeivqt
 9v548MXzj7JqLE5Vbfrg2U2JxUHXlaxte9yF3zUrFUx599MLY3x6FtFhMFXg7qsl1qHm
 /W8tPcp+OGnvIeglUoKWa4q2drc+IG06bPOO+k2k/Zjo7PUPvRjg2DYeTMvI4Nu4EzcZ
 I+dLJpx2Y3/NqPS2C9SWZdZIw4S49pLlcsebl1tPzV+9kTlIIdnqIVfaShEojHVGI5FI
 LSJPXyupDAMKVyrlfj1HPYaVNhLt7PvJmdwYqTo/8ZBKkFrE7dj5fOEJCNM7XYbSO/I7
 nDQQ==
X-Gm-Message-State: ANhLgQ1ZCJruCcr/g59OwPxva7GrsyyTKl9Kb2zt832xfbdr0TAnWz+V
 pVSliHGz+io+e1ehExF4ibrFW8+ODtkjhUO5fsU=
X-Google-Smtp-Source: ADFU+vtm7ewqMrLdb8tycFjLtjWP91VMIM3UTnsa9gbf9gYxP6H+yTd9pYTUX2q8quHQ0ZeIYojLsESU4pMASx8DyxY=
X-Received: by 2002:a02:cf1b:: with SMTP id q27mr4269831jar.99.1583955888556; 
 Wed, 11 Mar 2020 12:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-11-nieklinnenbank@gmail.com> <87eetzgfim.fsf@linaro.org>
In-Reply-To: <87eetzgfim.fsf@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 20:44:37 +0100
Message-ID: <CAPan3Wpebnx0Reikv156Z1R_05WnGHTxBh2pr4yiNJC9zo69ZA@mail.gmail.com>
Subject: Re: [PATCH v7 10/18] hw/arm/allwinner-h3: add Boot ROM support
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000013cf7f05a0997845"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000013cf7f05a0997845
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 2:58 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>
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
> >   https://linux-sunxi.org/BROM#U-Boot_SPL_limitations
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >  include/hw/arm/allwinner-h3.h | 21 +++++++++++++++++++++
> >  hw/arm/allwinner-h3.c         | 18 ++++++++++++++++++
> >  hw/arm/orangepi.c             |  5 +++++
> >  3 files changed, 44 insertions(+)
> >
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index f9b9a02373..d338003724 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -46,6 +46,7 @@
> >  #include "hw/sd/allwinner-sdhost.h"
> >  #include "hw/net/allwinner-sun8i-emac.h"
> >  #include "target/arm/cpu.h"
> > +#include "sysemu/block-backend.h"
> >
> >  /**
> >   * Allwinner H3 device list
> > @@ -129,4 +130,24 @@ typedef struct AwH3State {
> >      MemoryRegion sram_c;
> >  } AwH3State;
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
> > + */
> > +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk);
> > +
> >  #endif /* HW_ARM_ALLWINNER_H3_H */
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index d1245d2b01..56b5c563a8 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -29,6 +29,7 @@
> >  #include "hw/char/serial.h"
> >  #include "hw/misc/unimp.h"
> >  #include "hw/usb/hcd-ehci.h"
> > +#include "hw/loader.h"
> >  #include "sysemu/sysemu.h"
> >  #include "hw/arm/allwinner-h3.h"
> >
> > @@ -170,6 +171,23 @@ enum {
> >      AW_H3_GIC_NUM_SPI       =3D 128
> >  };
> >
> > +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk)
> > +{
> > +    const int64_t rom_size =3D 32 * KiB;
> > +    uint8_t *buffer =3D g_new0(uint8_t, rom_size);
>
> There is an opportunity to use g_autofree here so you can skip..
>
> > +    g_free(buffer);
> > +}
> > +
> <snip>
>

Thanks Alex, I'll use g_autofree here.

Regards,
Niek


>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --
> Alex Benn=C3=A9e
>


--=20
Niek Linnenbank

--00000000000013cf7f05a0997845
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 11, 2020 at 2:58 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_=
blank">nieklinnenbank@gmail.com</a>&gt; writes:<br>
<br>
&gt; A real Allwinner H3 SoC contains a Boot ROM which is the<br>
&gt; first code that runs right after the SoC is powered on.<br>
&gt; The Boot ROM is responsible for loading user code (e.g. a bootloader)<=
br>
&gt; from any of the supported external devices and writing the downloaded<=
br>
&gt; code to internal SRAM. After loading the SoC begins executing the code=
<br>
&gt; written to SRAM.<br>
&gt;<br>
&gt; This commits adds emulation of the Boot ROM firmware setup functionali=
ty<br>
&gt; by loading user code from SD card in the A1 SRAM. While the A1 SRAM is=
<br>
&gt; 64KiB, we limit the size to 32KiB because the real H3 Boot ROM also re=
jects<br>
&gt; sizes larger than 32KiB. For reference, this behaviour is documented<b=
r>
&gt; by the Linux Sunxi project wiki at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://linux-sunxi.org/BROM#U-Boot_SPL_limitat=
ions" rel=3D"noreferrer" target=3D"_blank">https://linux-sunxi.org/BROM#U-B=
oot_SPL_limitations</a><br>
&gt;<br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/hw/arm/allwinner-h3.h | 21 +++++++++++++++++++++<br>
&gt;=C2=A0 hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 ++++=
++++++++++++++<br>
&gt;=C2=A0 hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 5 +++++<br>
&gt;=C2=A0 3 files changed, 44 insertions(+)<br>
&gt;<br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index f9b9a02373..d338003724 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -46,6 +46,7 @@<br>
&gt;=C2=A0 #include &quot;hw/sd/allwinner-sdhost.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/net/allwinner-sun8i-emac.h&quot;<br>
&gt;=C2=A0 #include &quot;target/arm/cpu.h&quot;<br>
&gt; +#include &quot;sysemu/block-backend.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* Allwinner H3 device list<br>
&gt; @@ -129,4 +130,24 @@ typedef struct AwH3State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion sram_c;<br>
&gt;=C2=A0 } AwH3State;<br>
&gt;=C2=A0 <br>
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
&gt; + */<br>
&gt; +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk);<br>
&gt; +<br>
&gt;=C2=A0 #endif /* HW_ARM_ALLWINNER_H3_H */<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index d1245d2b01..56b5c563a8 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -29,6 +29,7 @@<br>
&gt;=C2=A0 #include &quot;hw/char/serial.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/misc/unimp.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/usb/hcd-ehci.h&quot;<br>
&gt; +#include &quot;hw/loader.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/arm/allwinner-h3.h&quot;<br>
&gt;=C2=A0 <br>
&gt; @@ -170,6 +171,23 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AW_H3_GIC_NUM_SPI=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 12=
8<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const int64_t rom_size =3D 32 * KiB;<br>
&gt; +=C2=A0 =C2=A0 uint8_t *buffer =3D g_new0(uint8_t, rom_size);<br>
<br>
There is an opportunity to use g_autofree here so you can skip..<br>
<br>
&gt; +=C2=A0 =C2=A0 g_free(buffer);<br>
&gt; +}<br>
&gt; +<br>
&lt;snip&gt;<br></blockquote><div><br></div><div>Thanks Alex, I&#39;ll use =
g_autofree here.</div><div><br></div><div>Regards,</div><div>Niek<br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Otherwise:<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000013cf7f05a0997845--

