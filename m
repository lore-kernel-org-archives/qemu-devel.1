Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970CDC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BE820737
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eROiT/Gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BE820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHDDY-0001ev-8t
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 17:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jHDBH-0007MU-Ed
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jHDBG-00020g-0B
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:03:19 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jHDBD-0001xC-0e; Wed, 25 Mar 2020 17:03:15 -0400
Received: by mail-io1-xd42.google.com with SMTP id o127so3861339iof.0;
 Wed, 25 Mar 2020 14:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NsFh4ZWQW5xf93MxxSQq7WYTkJzxtzcQn8elvCc5naw=;
 b=eROiT/GbXRT2J3qYnSs75btYPYnYW6O60jX2kkQ9z3lXx/lfjh32w6mSBjlLmoZ0Ej
 FtNcUHqb/NB1cMz3ixScbygmAWuC8CklVpCFaFjTbIyQ+OiEgVzeUf22j0ay+Kl/zVKn
 NWJfm+c015ZE+mL7a1e/CwkzTRCBekaMcHzSRcFDsgRR0VnUfmUu62Xf++/iTpIdJgbr
 Cv/ZQqn0a5XETBA713/LtGW2s4AEJeNpRqSIFb+h9lIJj5WvG6QjAfffGxbRt9haCDVY
 eBMZ0PX3DnK0LHV5z42wB92tpBRoKEP5MbFTrpdwqALHmAZjSOtcCc/65Fc2ZYRwqrad
 hfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NsFh4ZWQW5xf93MxxSQq7WYTkJzxtzcQn8elvCc5naw=;
 b=RWTYTKkrsHbIPXyQkU9P6aIHOYdTWa8a6lp38YjQlgR2HSpo/QdRGE1SV5kP+qQPsh
 xs5E+wT8Ypu5y6uU+p/weIBbfS6bQosXoF+P7SHZPmq9JeHV0PICLBlnZdQ695r7ggqj
 0OxqU9InzpabEhyUgGiNli2HNJkXJBm2rkFvzxYondpR5hkKqqECxBBkp3ChzD5pGTza
 dHR/1Sw4aL0AwVz/1devnV/CJowlD0I8t/3N5+K4J17bueZ/IfYcGMlxRxRATcSqrXBg
 WEqq20UnJMrFUo6N0bOm62hUaRd7ntT9cQ3Z5z13C+Jo79cwbp2QArFGpIzUClU9TsMA
 UHAg==
X-Gm-Message-State: ANhLgQ0+187j9EyPR6JDAt4OkpapnXJYcJ1fus7mSn+6WTP3d/j0Sfch
 PoRHmWgS1tIVBGnUr3azPF7qQuMyWRDRDDcNHnw=
X-Google-Smtp-Source: ADFU+vu1mHNpTXHMZ9JN4KeQwoZnug3qzyESaZUxqKZAZzKW58OjAUiTpmVMOTNK7wfoB2PpLDza+bHYveelAwc6HC8=
X-Received: by 2002:a02:b616:: with SMTP id h22mr1367368jam.126.1585170193351; 
 Wed, 25 Mar 2020 14:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200324212103.7616-1-peter.maydell@linaro.org>
In-Reply-To: <20200324212103.7616-1-peter.maydell@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 25 Mar 2020 22:03:02 +0100
Message-ID: <CAPan3Wpr_ys2qZ_kTZPYyc3qfpvqPdhnDj6VYdbei8Y0_uTG2g@mail.gmail.com>
Subject: Re: [PATCH] hw/net/allwinner-sun8i-emac.c: Fix REG_ADDR_HIGH/LOW reads
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000048881405a1b4321d"
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, Jason Wang <jasowang@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000048881405a1b4321d
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 24, 2020 at 10:21 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> Coverity points out (CID 1421926) that the read code for
> REG_ADDR_HIGH reads off the end of the buffer, because it does a
> 32-bit read from byte 4 of a 6-byte buffer.
>
> The code also has an endianness issue for both REG_ADDR_HIGH and
> REG_ADDR_LOW, because it will do the wrong thing on a big-endian
> host.
>
> Rewrite the read code to use ldl_le_p() and lduw_le_p() to fix this;
> the write code is not incorrect, but for consistency we make it use
> stl_le_p() and stw_le_p().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

By the way, is the coverity output of master publically available by any
chance?

Regards,
Niek


> ---
>  hw/net/allwinner-sun8i-emac.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
> index 3fc5e346401..fc67a1be70a 100644
> --- a/hw/net/allwinner-sun8i-emac.c
> +++ b/hw/net/allwinner-sun8i-emac.c
> @@ -611,10 +611,10 @@ static uint64_t allwinner_sun8i_emac_read(void
> *opaque, hwaddr offset,
>          value = s->mii_data;
>          break;
>      case REG_ADDR_HIGH:         /* MAC Address High */
> -        value = *(((uint32_t *) (s->conf.macaddr.a)) + 1);
> +        value = lduw_le_p(s->conf.macaddr.a + 4);
>          break;
>      case REG_ADDR_LOW:          /* MAC Address Low */
> -        value = *(uint32_t *) (s->conf.macaddr.a);
> +        value = ldl_le_p(s->conf.macaddr.a);
>          break;
>      case REG_TX_DMA_STA:        /* Transmit DMA Status */
>          break;
> @@ -728,14 +728,10 @@ static void allwinner_sun8i_emac_write(void *opaque,
> hwaddr offset,
>          s->mii_data = value;
>          break;
>      case REG_ADDR_HIGH:         /* MAC Address High */
> -        s->conf.macaddr.a[4] = (value & 0xff);
> -        s->conf.macaddr.a[5] = (value & 0xff00) >> 8;
> +        stw_le_p(s->conf.macaddr.a + 4, value);
>          break;
>      case REG_ADDR_LOW:          /* MAC Address Low */
> -        s->conf.macaddr.a[0] = (value & 0xff);
> -        s->conf.macaddr.a[1] = (value & 0xff00) >> 8;
> -        s->conf.macaddr.a[2] = (value & 0xff0000) >> 16;
> -        s->conf.macaddr.a[3] = (value & 0xff000000) >> 24;
> +        stl_le_p(s->conf.macaddr.a, value);
>          break;
>      case REG_TX_DMA_STA:        /* Transmit DMA Status */
>      case REG_TX_CUR_DESC:       /* Transmit Current Descriptor */
> --
> 2.20.1
>
>

-- 
Niek Linnenbank

--00000000000048881405a1b4321d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24, 2020 at 10:21 PM Pete=
r Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lin=
aro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Coverity points out (CID 1421926) that the read code for<br>
REG_ADDR_HIGH reads off the end of the buffer, because it does a<br>
32-bit read from byte 4 of a 6-byte buffer.<br>
<br>
The code also has an endianness issue for both REG_ADDR_HIGH and<br>
REG_ADDR_LOW, because it will do the wrong thing on a big-endian<br>
host.<br>
<br>
Rewrite the read code to use ldl_le_p() and lduw_le_p() to fix this;<br>
the write code is not incorrect, but for consistency we make it use<br>
stl_le_p() and stw_le_p().<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br></blockquote><div>T=
ested-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">n=
ieklinnenbank@gmail.com</a>&gt;</div><div>Reviewed-by: Niek Linnenbank &lt;=
<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt=
;<br></div><div><br></div><div>By the way, is the coverity output of master=
 publically available by any chance?<br></div><div><br></div><div>Regards,<=
/div><div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
---<br>
=C2=A0hw/net/allwinner-sun8i-emac.c | 12 ++++--------<br>
=C2=A01 file changed, 4 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c<=
br>
index 3fc5e346401..fc67a1be70a 100644<br>
--- a/hw/net/allwinner-sun8i-emac.c<br>
+++ b/hw/net/allwinner-sun8i-emac.c<br>
@@ -611,10 +611,10 @@ static uint64_t allwinner_sun8i_emac_read(void *opaqu=
e, hwaddr offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D s-&gt;mii_data;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case REG_ADDR_HIGH:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 MAC Address High */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D *(((uint32_t *) (s-&gt;conf.macaddr.=
a)) + 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D lduw_le_p(s-&gt;conf.macaddr.a + 4);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case REG_ADDR_LOW:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 MAC Address Low */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D *(uint32_t *) (s-&gt;conf.macaddr.a)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D ldl_le_p(s-&gt;conf.macaddr.a);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case REG_TX_DMA_STA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Tran=
smit DMA Status */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -728,14 +728,10 @@ static void allwinner_sun8i_emac_write(void *opaque, =
hwaddr offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mii_data =3D value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case REG_ADDR_HIGH:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 MAC Address High */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[4] =3D (value &amp; 0xff)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[5] =3D (value &amp; 0xff0=
0) &gt;&gt; 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_le_p(s-&gt;conf.macaddr.a + 4, value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case REG_ADDR_LOW:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 MAC Address Low */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[0] =3D (value &amp; 0xff)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[1] =3D (value &amp; 0xff0=
0) &gt;&gt; 8;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[2] =3D (value &amp; 0xff0=
000) &gt;&gt; 16;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[3] =3D (value &amp; 0xff0=
00000) &gt;&gt; 24;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stl_le_p(s-&gt;conf.macaddr.a, value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case REG_TX_DMA_STA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Tran=
smit DMA Status */<br>
=C2=A0 =C2=A0 =C2=A0case REG_TX_CUR_DESC:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Tran=
smit Current Descriptor */<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000048881405a1b4321d--

