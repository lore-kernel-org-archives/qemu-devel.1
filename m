Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0738C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B533B2080C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDpaZWer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B533B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8lwA-0007Hl-Qa
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 09:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1j8lvV-0006iJ-B0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1j8lvU-0002b8-0S
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:20:09 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1j8lvT-0002a0-Je; Mon, 02 Mar 2020 09:20:07 -0500
Received: by mail-lf1-x143.google.com with SMTP id 7so8192790lfz.11;
 Mon, 02 Mar 2020 06:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KJrtEdPJ2SAb4JoHKL3JdyltZQZyjNQylqk3c3NRDOI=;
 b=HDpaZWerVHaZs56omrBVz/2XvkuwraB3CtAd0uBNpSIGGdg0yww4Y9HJjqwsVVMgms
 NKOcdr4whJ1E1bB7RdV5EEvyU3eUFy6JMHUa1cx/1LqFBWAvyZRZoav321ZDPXhrQuGi
 QTfb+apJV5PUtNNCp7tUk3LLIxcsGGs1Q5fxtGDLtdYC7hfgsNXZ+wFjH3VaXyWonU+y
 TKU1do+KPvNcB43ksO0gAik9g1wRROAurELAC1oG7tmEtZhcBQ4EanYeuE9PNT+zMXnh
 zy1fIbOTUtzgtkrIV9H8g/r9Q8EPJEHEtdPMN1+v8SeOq8iCYpgbfHET6iy5eyd7A0nz
 sWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KJrtEdPJ2SAb4JoHKL3JdyltZQZyjNQylqk3c3NRDOI=;
 b=poWB7FZ9/Tu5y6nlhF2Dp7LK1gT/FcqDgSeSMzGuniENea2WCV4UlialHrC1csLHf7
 l70iqq1rPpSxVMge+xLWstHj7D97i978cUX6vucAeU9UwDlHOURUkjdlT+NC2msQoZfL
 nxz+FVj6Gamk+wI2eJe+FXvKsOZZ3FVvJmY46ipEboh6AC+xCiovsW3d+wVzgfvtgtO+
 OB2fkvl2qhH+/e4sCqoYikMJAGGeda6O63CMduMKsR0SViaoVii3l91qmJymFZli+LUr
 zZzWNYUfUrBP/syLvyhTWNXu8+SISr/LklG9d32NrjVBNbhcsFnutTMMjm8Atxqo6yoH
 XnMA==
X-Gm-Message-State: ANhLgQ1sgnLPKL/eEn5Byg7IwVB9KcG0GKUDy119RS+aULItukz9jTIb
 07KuaoRrBzAUVQz8D4PNBnT0MF6ThPy+i9vrgE8=
X-Google-Smtp-Source: ADFU+vsKn8d3EIosn7+llY7DEsvnDT6tGX8EhlAuJSuoHJJxBNHFXInotGpVwZCgOm8dXSBiRpE+ytalXpiFoSUSBds=
X-Received: by 2002:a19:ee0d:: with SMTP id g13mr11164993lfb.179.1583158805747; 
 Mon, 02 Mar 2020 06:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
 <20200302130715.29440-11-kuhn.chenqun@huawei.com>
In-Reply-To: <20200302130715.29440-11-kuhn.chenqun@huawei.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 2 Mar 2020 08:19:52 -0600
Message-ID: <CAJy5ezqf08b=FVGY9WHYuOif5Kb8VpENQxomKNg2MXP3y_CDXw@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] dma/xlnx-zdma: Remove redundant statement in
 zdma_write_dst()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: multipart/alternative; boundary="0000000000003d5c32059fdfe24c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Euler Robot <euler.robot@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003d5c32059fdfe24c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar. 2020, 07:09 Chen Qun, <kuhn.chenqun@huawei.com> wrote:

> Clang static code analyzer show warning:
> hw/dma/xlnx-zdma.c:399:13: warning: Value stored to 'dst_type' is never
> read
>             dst_type =3D FIELD_EX32(s->dsc_dst.words[3],
> ZDMA_CH_DST_DSCR_WORD3,
>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



            ^
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> v1->v2: move the 'dst_type' declaration.(Base on Philippe's suggestion).
> ---
>  hw/dma/xlnx-zdma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 8fb83f5b07..eeacad59ce 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -373,7 +373,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s,
> bool type,
>  static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
>  {
>      uint32_t dst_size, dlen;
> -    bool dst_intr, dst_type;
> +    bool dst_intr;
>      unsigned int ptype =3D ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0,
> POINT_TYPE);
>      unsigned int rw_mode =3D ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, MO=
DE);
>      unsigned int burst_type =3D ARRAY_FIELD_EX32(s->regs, ZDMA_CH_DATA_A=
TTR,
> @@ -387,17 +387,17 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t
> *buf, uint32_t len)
>      while (len) {
>          dst_size =3D FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WO=
RD2,
>                                SIZE);
> -        dst_type =3D FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WO=
RD3,
> -                              TYPE);
>          if (dst_size =3D=3D 0 && ptype =3D=3D PT_MEM) {
>              uint64_t next;
> +            bool dst_type =3D FIELD_EX32(s->dsc_dst.words[3],
> +                                       ZDMA_CH_DST_DSCR_WORD3,
> +                                       TYPE);
> +
>              next =3D zdma_update_descr_addr(s, dst_type,
>                                            R_ZDMA_CH_DST_CUR_DSCR_LSB);
>              zdma_load_descriptor(s, next, &s->dsc_dst);
>              dst_size =3D FIELD_EX32(s->dsc_dst.words[2],
> ZDMA_CH_DST_DSCR_WORD2,
>                                    SIZE);
> -            dst_type =3D FIELD_EX32(s->dsc_dst.words[3],
> ZDMA_CH_DST_DSCR_WORD3,
> -                                  TYPE);
>          }
>
>          /* Match what hardware does by ignoring the dst_size and only
> using
> --
> 2.23.0
>
>
>

--0000000000003d5c32059fdfe24c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, 2 Mar. 2020, 07:09 Chen Qun, &lt;<a href=3D"ma=
ilto:kuhn.chenqun@huawei.com">kuhn.chenqun@huawei.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Clang static code analyzer show warning:<=
br>
hw/dma/xlnx-zdma.c:399:13: warning: Value stored to &#39;dst_type&#39; is n=
ever read<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_type =3D FIELD_EX32(s-&gt;dsc=
_dst.words[3], ZDMA_CH_DST_DSCR_WORD3,<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"></blockquote></div></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar=
.iglesias@xilinx.com">edgar.iglesias@xilinx.com</a>&gt;</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
Reported-by: Euler Robot &lt;<a href=3D"mailto:euler.robot@huawei.com" targ=
et=3D"_blank" rel=3D"noreferrer">euler.robot@huawei.com</a>&gt;<br>
Signed-off-by: Chen Qun &lt;<a href=3D"mailto:kuhn.chenqun@huawei.com" targ=
et=3D"_blank" rel=3D"noreferrer">kuhn.chenqun@huawei.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt;<br>
Reviewed-by: Francisco Iglesias &lt;<a href=3D"mailto:frasse.iglesias@gmail=
.com" target=3D"_blank" rel=3D"noreferrer">frasse.iglesias@gmail.com</a>&gt=
;<br>
Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.co=
m" target=3D"_blank" rel=3D"noreferrer">alistair.francis@wdc.com</a>&gt;<br=
>
---<br>
Cc: Alistair Francis &lt;<a href=3D"mailto:alistair@alistair23.me" target=
=3D"_blank" rel=3D"noreferrer">alistair@alistair23.me</a>&gt;<br>
Cc: &quot;Edgar E. Iglesias&quot; &lt;<a href=3D"mailto:edgar.iglesias@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">edgar.iglesias@gmail.com</a>&gt=
;<br>
Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>
Cc: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" ta=
rget=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt;<br>
<br>
v1-&gt;v2: move the &#39;dst_type&#39; declaration.(Base on Philippe&#39;s =
suggestion).<br>
---<br>
=C2=A0hw/dma/xlnx-zdma.c | 10 +++++-----<br>
=C2=A01 file changed, 5 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c<br>
index 8fb83f5b07..eeacad59ce 100644<br>
--- a/hw/dma/xlnx-zdma.c<br>
+++ b/hw/dma/xlnx-zdma.c<br>
@@ -373,7 +373,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s, boo=
l type,<br>
=C2=A0static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t dst_size, dlen;<br>
-=C2=A0 =C2=A0 bool dst_intr, dst_type;<br>
+=C2=A0 =C2=A0 bool dst_intr;<br>
=C2=A0 =C2=A0 =C2=A0unsigned int ptype =3D ARRAY_FIELD_EX32(s-&gt;regs, ZDM=
A_CH_CTRL0, POINT_TYPE);<br>
=C2=A0 =C2=A0 =C2=A0unsigned int rw_mode =3D ARRAY_FIELD_EX32(s-&gt;regs, Z=
DMA_CH_CTRL0, MODE);<br>
=C2=A0 =C2=A0 =C2=A0unsigned int burst_type =3D ARRAY_FIELD_EX32(s-&gt;regs=
, ZDMA_CH_DATA_ATTR,<br>
@@ -387,17 +387,17 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf,=
 uint32_t len)<br>
=C2=A0 =C2=A0 =C2=A0while (len) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_size =3D FIELD_EX32(s-&gt;dsc_dst.wor=
ds[2], ZDMA_CH_DST_DSCR_WORD2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SIZE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_type =3D FIELD_EX32(s-&gt;dsc_dst.words[3]=
, ZDMA_CH_DST_DSCR_WORD3,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dst_size =3D=3D 0 &amp;&amp; ptype =
=3D=3D PT_MEM) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t next;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool dst_type =3D FIELD_EX32(s-&=
gt;dsc_dst.words[3],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ZDMA_CH_D=
ST_DSCR_WORD3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE);<br=
>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next =3D zdma_update_descr_=
addr(s, dst_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0R_ZDMA_CH_DST_CUR_DSCR_LSB);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zdma_load_descriptor(s, nex=
t, &amp;s-&gt;dsc_dst);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_size =3D FIELD_EX32(s-&=
gt;dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SIZE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_type =3D FIELD_EX32(s-&gt;ds=
c_dst.words[3], ZDMA_CH_DST_DSCR_WORD3,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Match what hardware does by ignoring t=
he dst_size and only using<br>
-- <br>
2.23.0<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000003d5c32059fdfe24c--

