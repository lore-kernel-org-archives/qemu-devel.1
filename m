Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB07EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F50206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBktb9Te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F50206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPq1-0002Fr-RI
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiPoS-0000I6-QS
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiPoR-0007TD-6X
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:27:56 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:38848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iiPoQ-0007KG-QL; Fri, 20 Dec 2019 16:27:55 -0500
Received: by mail-il1-x141.google.com with SMTP id f5so9154478ilq.5;
 Fri, 20 Dec 2019 13:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5FKcFFoz/FT1jFBsPVyN5pMqwGAlqiO1LFE+/xNc0UA=;
 b=tBktb9Te0Cy0czwH6xaDZSPAhCAn/X4Zs1txiJTvo4H8qMFHdXeqlS0X5CXF4xxEBJ
 jMdnWc2p6fbFF8F+DalqECCNQ1VtzFCMX/cMU27dOqukNHgxICoF9/ZT7+0vIwZ1BOD7
 fhgKi+efaZKodH24LZYhKmfK2LvD67Y8DpIALoOjrtf39jye9I9jQsH+z6OJd6plpZRb
 lHvlnrlifIBJN7NgbOc6ibIukpRQJpqgMwx7BrjmFa7o82La30FCIKVdjVuDOMJADK53
 lUyzVYK/eLIfIWvRgXeaP+AUwd7twibcFilwnJk641IGZxztkJ2MOqeLnXD/LQJJwR7P
 4X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5FKcFFoz/FT1jFBsPVyN5pMqwGAlqiO1LFE+/xNc0UA=;
 b=sOcGJpKQWROR0Edr1y+V0vdcuaQh902pq8jZlXShzHuhBMPzi3fZtEWCfQehpbmUvM
 jXpHSoTDoWyGUkGofhRe7tGqK2CGCEfKbO1wfrbZnSJY5MHTFEEVFQO/6zd6Q6mq4Tk5
 T7ZsJmjivvXo76vhJpv2pl9Ild0Yl/FJ8fUZ+xxdIYMm9/MaA6qKPxQ5vG9N8v4d+oA5
 zN0qWpNkKVPGm51d1nrqusMbtK8WnalYr/cAXzBYv7uldec0y98iqnAvxisOTrIF0U6z
 qQlmQyNH74hPA4z08JHDRZSyRqCQs4fMmG99dQ6augwU72ANsMOobOgdD4zgrc84MeRe
 bU1g==
X-Gm-Message-State: APjAAAX2pKhXFIn5s8NDnghYB8Z+GSIPzkExaHaqHDgj8R7xYY4cwVGv
 Y+9ZyCqrbFPd9E8rmE5G9ZtAYXuR7t9G4dNo92s=
X-Google-Smtp-Source: APXvYqwUikgHVtfEuW+pvMNsJ8zEV6yAAGNu4df6ofkReXjKvvhSrjr1rG+mJZPBkxAiC1n5wT6HmFHjpgD5S98wKlI=
X-Received: by 2002:a92:5a45:: with SMTP id o66mr13722170ilb.67.1576877272941; 
 Fri, 20 Dec 2019 13:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20191219185127.24388-1-f4bug@amsat.org>
 <20191219185127.24388-3-f4bug@amsat.org>
In-Reply-To: <20191219185127.24388-3-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 20 Dec 2019 22:27:41 +0100
Message-ID: <CAPan3Wqq99FOj9ye1ozVab1gd9hWpb4dNDOs+a8i55PZe0mGtw@mail.gmail.com>
Subject: Re: [PATCH 02/13] hw/timer/allwinner: Add AW_PIT_TIMER_MAX definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000b54b3e059a2959eb"
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b54b3e059a2959eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 7:51 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> This controller is able to use up to 6 timers.
> Later we will reuse part of it to model other similar controllers
> but with less timers. To simplify the VMSTATE, we'll keep a max
> of 6 timers. Add a definition for that value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/timer/allwinner-a10-pit.h | 14 ++++++++------
>  hw/timer/allwinner-a10-pit.c         |  8 ++++----
>  2 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/timer/allwinner-a10-pit.h
> b/include/hw/timer/allwinner-a10-pit.h
> index 6aceda81ee..54c40c7db6 100644
> --- a/include/hw/timer/allwinner-a10-pit.h
> +++ b/include/hw/timer/allwinner-a10-pit.h
> @@ -7,6 +7,8 @@
>  #define TYPE_AW_A10_PIT "allwinner-A10-timer"
>  #define AW_A10_PIT(obj) OBJECT_CHECK(AwA10PITState, (obj),
> TYPE_AW_A10_PIT)
>
> +#define AW_PIT_TIMER_MAX        6
> +
>  #define AW_A10_PIT_TIMER_NR    6
>  #define AW_A10_PIT_TIMER_IRQ   0x1
>  #define AW_A10_PIT_WDOG_IRQ    0x100
> @@ -47,17 +49,17 @@ struct AwA10PITState {
>      /*< private >*/
>      SysBusDevice parent_obj;
>      /*< public >*/
> -    qemu_irq irq[AW_A10_PIT_TIMER_NR];
> -    ptimer_state * timer[AW_A10_PIT_TIMER_NR];
> -    AwA10TimerContext timer_context[AW_A10_PIT_TIMER_NR];
> +    qemu_irq irq[AW_PIT_TIMER_MAX];
> +    ptimer_state * timer[AW_PIT_TIMER_MAX];
> +    AwA10TimerContext timer_context[AW_PIT_TIMER_MAX];
>      MemoryRegion iomem;
>      uint32_t clk_freq[4];
>
>      uint32_t irq_enable;
>      uint32_t irq_status;
> -    uint32_t control[AW_A10_PIT_TIMER_NR];
> -    uint32_t interval[AW_A10_PIT_TIMER_NR];
> -    uint32_t count[AW_A10_PIT_TIMER_NR];
> +    uint32_t control[AW_PIT_TIMER_MAX];
> +    uint32_t interval[AW_PIT_TIMER_MAX];
> +    uint32_t count[AW_PIT_TIMER_MAX];
>      uint32_t watch_dog_mode;
>      uint32_t watch_dog_control;
>      uint32_t count_lo;
> diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
> index 117e5c7bf8..b31a0bcd43 100644
> --- a/hw/timer/allwinner-a10-pit.c
> +++ b/hw/timer/allwinner-a10-pit.c
> @@ -203,15 +203,15 @@ static const VMStateDescription vmstate_a10_pit =3D=
 {
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32(irq_enable, AwA10PITState),
>          VMSTATE_UINT32(irq_status, AwA10PITState),
> -        VMSTATE_UINT32_ARRAY(control, AwA10PITState, AW_A10_PIT_TIMER_NR=
),
> -        VMSTATE_UINT32_ARRAY(interval, AwA10PITState,
> AW_A10_PIT_TIMER_NR),
> -        VMSTATE_UINT32_ARRAY(count, AwA10PITState, AW_A10_PIT_TIMER_NR),
> +        VMSTATE_UINT32_ARRAY(control, AwA10PITState, AW_PIT_TIMER_MAX),
> +        VMSTATE_UINT32_ARRAY(interval, AwA10PITState, AW_PIT_TIMER_MAX),
> +        VMSTATE_UINT32_ARRAY(count, AwA10PITState, AW_PIT_TIMER_MAX),
>          VMSTATE_UINT32(watch_dog_mode, AwA10PITState),
>          VMSTATE_UINT32(watch_dog_control, AwA10PITState),
>          VMSTATE_UINT32(count_lo, AwA10PITState),
>          VMSTATE_UINT32(count_hi, AwA10PITState),
>          VMSTATE_UINT32(count_ctl, AwA10PITState),
> -        VMSTATE_PTIMER_ARRAY(timer, AwA10PITState, AW_A10_PIT_TIMER_NR),
> +        VMSTATE_PTIMER_ARRAY(timer, AwA10PITState, AW_PIT_TIMER_MAX),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> --
> 2.21.0
>
> Looks good and works fine with -M orangepi-pc and -M cubieboard.

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>


--=20
Niek Linnenbank

--000000000000b54b3e059a2959eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 19, 2019 at 7:51 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">This controller is able to use up to 6 timers.<br>
Later we will reuse part of it to model other similar controllers<br>
but with less timers. To simplify the VMSTATE, we&#39;ll keep a max<br>
of 6 timers. Add a definition for that value.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0include/hw/timer/allwinner-a10-pit.h | 14 ++++++++------<br>
=C2=A0hw/timer/allwinner-a10-pit.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 8 ++++----<br>
=C2=A02 files changed, 12 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwin=
ner-a10-pit.h<br>
index 6aceda81ee..54c40c7db6 100644<br>
--- a/include/hw/timer/allwinner-a10-pit.h<br>
+++ b/include/hw/timer/allwinner-a10-pit.h<br>
@@ -7,6 +7,8 @@<br>
=C2=A0#define TYPE_AW_A10_PIT &quot;allwinner-A10-timer&quot;<br>
=C2=A0#define AW_A10_PIT(obj) OBJECT_CHECK(AwA10PITState, (obj), TYPE_AW_A1=
0_PIT)<br>
<br>
+#define AW_PIT_TIMER_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 6<br>
+<br>
=C2=A0#define AW_A10_PIT_TIMER_NR=C2=A0 =C2=A0 6<br>
=C2=A0#define AW_A10_PIT_TIMER_IRQ=C2=A0 =C2=A00x1<br>
=C2=A0#define AW_A10_PIT_WDOG_IRQ=C2=A0 =C2=A0 0x100<br>
@@ -47,17 +49,17 @@ struct AwA10PITState {<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; private &gt;*/<br>
=C2=A0 =C2=A0 =C2=A0SysBusDevice parent_obj;<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; public &gt;*/<br>
-=C2=A0 =C2=A0 qemu_irq irq[AW_A10_PIT_TIMER_NR];<br>
-=C2=A0 =C2=A0 ptimer_state * timer[AW_A10_PIT_TIMER_NR];<br>
-=C2=A0 =C2=A0 AwA10TimerContext timer_context[AW_A10_PIT_TIMER_NR];<br>
+=C2=A0 =C2=A0 qemu_irq irq[AW_PIT_TIMER_MAX];<br>
+=C2=A0 =C2=A0 ptimer_state * timer[AW_PIT_TIMER_MAX];<br>
+=C2=A0 =C2=A0 AwA10TimerContext timer_context[AW_PIT_TIMER_MAX];<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion iomem;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t clk_freq[4];<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint32_t irq_enable;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t irq_status;<br>
-=C2=A0 =C2=A0 uint32_t control[AW_A10_PIT_TIMER_NR];<br>
-=C2=A0 =C2=A0 uint32_t interval[AW_A10_PIT_TIMER_NR];<br>
-=C2=A0 =C2=A0 uint32_t count[AW_A10_PIT_TIMER_NR];<br>
+=C2=A0 =C2=A0 uint32_t control[AW_PIT_TIMER_MAX];<br>
+=C2=A0 =C2=A0 uint32_t interval[AW_PIT_TIMER_MAX];<br>
+=C2=A0 =C2=A0 uint32_t count[AW_PIT_TIMER_MAX];<br>
=C2=A0 =C2=A0 =C2=A0uint32_t watch_dog_mode;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t watch_dog_control;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t count_lo;<br>
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c<br=
>
index 117e5c7bf8..b31a0bcd43 100644<br>
--- a/hw/timer/allwinner-a10-pit.c<br>
+++ b/hw/timer/allwinner-a10-pit.c<br>
@@ -203,15 +203,15 @@ static const VMStateDescription vmstate_a10_pit =3D {=
<br>
=C2=A0 =C2=A0 =C2=A0.fields =3D (VMStateField[]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(irq_enable, AwA10PITState)=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(irq_status, AwA10PITState)=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(control, AwA10PITState, A=
W_A10_PIT_TIMER_NR),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(interval, AwA10PITState, =
AW_A10_PIT_TIMER_NR),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(count, AwA10PITState, AW_=
A10_PIT_TIMER_NR),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(control, AwA10PITState, A=
W_PIT_TIMER_MAX),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(interval, AwA10PITState, =
AW_PIT_TIMER_MAX),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(count, AwA10PITState, AW_=
PIT_TIMER_MAX),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(watch_dog_mode, AwA10PITSt=
ate),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(watch_dog_control, AwA10PI=
TState),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(count_lo, AwA10PITState),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(count_hi, AwA10PITState),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(count_ctl, AwA10PITState),=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_PTIMER_ARRAY(timer, AwA10PITState, AW_=
A10_PIT_TIMER_NR),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_PTIMER_ARRAY(timer, AwA10PITState, AW_=
PIT_TIMER_MAX),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div><div>Looks good and works fine with -M orangepi-pc and -=
M cubieboard.</div><div><br></div><div>Reviewed-by: Niek Linnenbank &lt;<a =
href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</=
div><div>Tested-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com">nieklinnenbank@gmail.com</a>&gt;<br></div><div><br></div><br>-- <b=
r><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Niek Lin=
nenbank<br><br></div></div></div></div>

--000000000000b54b3e059a2959eb--

