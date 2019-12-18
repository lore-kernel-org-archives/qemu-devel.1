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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42650C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04ED52072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMpkN3LD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04ED52072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUH3-0006hL-3e
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihUFt-0005m5-Ot
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihUFo-0006It-EQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:00:25 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ihUFn-0006HM-Re; Wed, 18 Dec 2019 03:00:20 -0500
Received: by mail-ot1-x342.google.com with SMTP id r27so1365501otc.8;
 Wed, 18 Dec 2019 00:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=JVg5swbti9AOC9j2cReONmB/j54YHwCcla5puT1Fw9k=;
 b=JMpkN3LDA9P1R3Nz6bjWK0wdn/gYJ9F8Hc2kiNbWI9z8zdVx85D3oF4/Y9jRE7+hvn
 pg5GU3qnqfU0pVZE8DA47f1s8F10/Vi8H3qPu7SMs+7jOUNmqdgkZ8V/6OVrkavbO6Pc
 FdvasuscH4/449gcawLtsHO8AEal0gQmwh81OZnLvKC4QIMllxkd0sCBn3CKmGHZQev2
 UlC1gk5P/9WkHpo2AhfLReQhsuIw2ppe+gvCcLWF8EsmR+nCazf3RnhL90OHUK4LctcV
 QVlilYx6cgDpSeK/TlGCsHq5I8kpr7wCYncPlWTWJLreU3DNuHyavQo+bKmDVRRwZBO7
 osqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=JVg5swbti9AOC9j2cReONmB/j54YHwCcla5puT1Fw9k=;
 b=AJdNZgQEwD9E5CiALp/9VHGTmyAdocF3AjuAlfvAuOGLWm35uBEf6RA3VGcYeEBzCB
 5ZWpfwxbEqef4Hw0KaBJ/6jTukFwMZ1RHSsgVEApJcJTfYuCew9Mgrhvciiw+cEw5I6q
 7JrNeDw98Yo8BzYUDMgWLcHjeBF8L+BUKo6LRyimACjtdXnbnJf3IXGSbpw9th7Veq/I
 SaBgtN6OokT81n9JuoKmXdlmlGUcerI+OrGK9hxNUMdu8cQhsjbR4c9jtTH3BzoIFInC
 yLq2HX4EmIKRs0OoyuCVww3OCMokg3+G+Mnh6Iu/5ZgHqnKwazwqF6FlQD/5khWTvvxh
 tVfQ==
X-Gm-Message-State: APjAAAWOwzeCIkTknxWaHDmfYuHV8dKg5M363zNcdZOG9uYCDIdDi9Tg
 lhg/S1D6Cko/wR6znvuYNY9t2r0vg65UhMMvsZo=
X-Google-Smtp-Source: APXvYqz2Cf4NRh6bsfKgT8Mqda057xivdINKLU+mwyKu3rxpJemaCJt9VVBH3r22KVjLscppbsHsEafl6ydALrVDxR0=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr1251528otk.64.1576656018700;
 Wed, 18 Dec 2019 00:00:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 18 Dec 2019 00:00:18 -0800 (PST)
In-Reply-To: <20191217173425.5082-4-philmd@redhat.com>
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-4-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 18 Dec 2019 09:00:18 +0100
Message-ID: <CAL1e-=ixaEP6o6=OfPuYsj=b-wuuUsk6Y7bMwosLhRsPqfw7yQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] hw/net/imx_fec: Rewrite fall through comments
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ed7c3f0599f5d58f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ed7c3f0599f5d58f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, December 17, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> GCC9 is confused by this comment when building with CFLAG
> -Wimplicit-fallthrough=3D2:
>
>   hw/net/imx_fec.c: In function =E2=80=98imx_eth_write=E2=80=99:
>   hw/net/imx_fec.c:906:12: error: this statement may fall through
> [-Werror=3Dimplicit-fallthrough=3D]
>     906 |         if (unlikely(single_tx_ring)) {
>         |            ^
>   hw/net/imx_fec.c:912:5: note: here
>     912 |     case ENET_TDAR:     /* FALLTHROUGH */
>         |     ^~~~
>   cc1: all warnings being treated as errors
>
> Rewrite the comments in the correct place,  using 'fall through'
> which is recognized by GCC and static analyzers.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/net/imx_fec.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
>
Here we can truly say that gcc is confused (as opposed to another patch
from this series).

The new positions of comments/annotations are good.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index bd99236864..30cc07753d 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -901,15 +901,17 @@ static void imx_eth_write(void *opaque, hwaddr
> offset, uint64_t value,
>              s->regs[index] =3D 0;
>          }
>          break;
> -    case ENET_TDAR1:    /* FALLTHROUGH */
> -    case ENET_TDAR2:    /* FALLTHROUGH */
> +        /* fall through */
> +    case ENET_TDAR1:
> +    case ENET_TDAR2:
>          if (unlikely(single_tx_ring)) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "[%s]%s: trying to access TDAR2 or TDAR1\n",
>                            TYPE_IMX_FEC, __func__);
>              return;
>          }
> -    case ENET_TDAR:     /* FALLTHROUGH */
> +        /* fall through */
> +    case ENET_TDAR:
>          if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
>              s->regs[index] =3D ENET_TDAR_TDAR;
>              imx_eth_do_tx(s, index);
> --
> 2.21.0
>
>
>

--000000000000ed7c3f0599f5d58f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, December 17, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">GCC9 is confused by this comment when building wit=
h CFLAG<br>
-Wimplicit-fallthrough=3D2:<br>
<br>
=C2=A0 hw/net/imx_fec.c: In function =E2=80=98imx_eth_write=E2=80=99:<br>
=C2=A0 hw/net/imx_fec.c:906:12: error: this statement may fall through [-We=
rror=3Dimplicit-fallthrough=3D<wbr>]<br>
=C2=A0 =C2=A0 906 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(single_tx=
_ring)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br=
>
=C2=A0 hw/net/imx_fec.c:912:5: note: here<br>
=C2=A0 =C2=A0 912 |=C2=A0 =C2=A0 =C2=A0case ENET_TDAR:=C2=A0 =C2=A0 =C2=A0/=
* FALLTHROUGH */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~<br>
=C2=A0 cc1: all warnings being treated as errors<br>
<br>
Rewrite the comments in the correct place,=C2=A0 using &#39;fall through&#3=
9;<br>
which is recognized by GCC and static analyzers.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
Cc: Peter Chubb &lt;<a href=3D"mailto:peter.chubb@nicta.com.au">peter.chubb=
@nicta.com.au</a>&gt;<br>
Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.may=
dell@linaro.org</a>&gt;<br>
Cc: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.c=
om</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-arm@nongnu.org">qemu-arm@nongnu.org</a><br>
---<br>
=C2=A0hw/net/imx_fec.c | 8 +++++---<br>
=C2=A01 file changed, 5 insertions(+), 3 deletions(-)<br>
<br></blockquote><div><br></div><div>Here we can truly say that gcc is conf=
used (as opposed to another patch from this series).</div><div><br></div><d=
iv>The new positions of comments/annotations are good.</div><div><br></div>=
<div>Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavec=
omp.com">amarkovic@wavecomp.com</a>&gt;</div><div><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c<br>
index bd99236864..30cc07753d 100644<br>
--- a/hw/net/imx_fec.c<br>
+++ b/hw/net/imx_fec.c<br>
@@ -901,15 +901,17 @@ static void imx_eth_write(void *opaque, hwaddr offset=
, uint64_t value,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[index] =3D 0;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case ENET_TDAR1:=C2=A0 =C2=A0 /* FALLTHROUGH */<br>
-=C2=A0 =C2=A0 case ENET_TDAR2:=C2=A0 =C2=A0 /* FALLTHROUGH */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */<br>
+=C2=A0 =C2=A0 case ENET_TDAR1:<br>
+=C2=A0 =C2=A0 case ENET_TDAR2:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(single_tx_ring)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERR=
OR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;[%s]%s: trying to access TDAR2 or TDAR1\n&quo=
t;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0TYPE_IMX_FEC, __func__);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 case ENET_TDAR:=C2=A0 =C2=A0 =C2=A0/* FALLTHROUGH */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */<br>
+=C2=A0 =C2=A0 case ENET_TDAR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;regs[ENET_ECR] &amp; ENET_ECR_E=
THEREN) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[index] =3D ENET_=
TDAR_TDAR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0imx_eth_do_tx(s, index);<br=
>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000ed7c3f0599f5d58f--

