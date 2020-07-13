Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FB9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 02:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA63206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 02:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jwW4NF3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA63206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1junsq-0004BS-1O
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 22:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1junsH-0003kh-89
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 22:07:21 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:33506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1junsF-0007eg-Ei
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 22:07:20 -0400
Received: by mail-oi1-x22b.google.com with SMTP id k22so9809608oib.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ABw3Z3OuvCTl1fggcJHqjIgqh/IW2fOK0CJY+oyqysQ=;
 b=jwW4NF3Z3zVAgijcZmCN8FSH3odlPu1g808q/y/oDvILd9ixZo2TdgHktDeZpdCzsZ
 nzi6ZBSuSMYEnTBp4cOv9zQgEgrSeLTYiDu3QDra03DSUsllrNH71bG9EJwmOYeGOj6c
 07r1st4ud/p4AR0x1v9L4kp2HxUsA5G25Ex6DPShVnC4SAHkznEmuvKP+6up1r4Kfq9M
 RTr4I/AIPGaK+yD4uFU3KpLcmF1eGo1II0LTJQQE+5O9wlH/aVZBP05ktaDqJYOjkNq2
 5ePutC1VVCqhQvgPvmTP2zClCM9jXhCfEEFV/8XEt10IMEZ+d/+CGMUsQFB3peINEngT
 fAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ABw3Z3OuvCTl1fggcJHqjIgqh/IW2fOK0CJY+oyqysQ=;
 b=AHQQlBoaZ1Ey/NaQ2Ll8Gg0ektdUMJ5wZn6Koio7MlnBP1oDIihqhaZAGscL29OSS/
 +6GrAkc4qT93Fpv9yizxodufUsAp3+DztURR6ELO0alikHsLqpY0dSAQ3LFvZG96AwwU
 gtePwxmpPCeSBcXA1aAus4FdePx2acqC4gwz/kkEyHQTpgFfCByqyk4u+MuDpu48oHHq
 /Gs6+MEaLiGN9TCpxlRrjAkVV/N5857XWzsc12ZrPrWedcqnACWPDKFQ0EDPcIneti2i
 72i8AgYDME5mK//vJRmK3Pbl1f+Pispt+zqG6tbc7A1aeMdpZzD3yTIErOqRuUOFvScI
 BojQ==
X-Gm-Message-State: AOAM533fGCPWuDeSjIzqSD2p5iWcJZBpfpXM3QyTVy1yy4HqN/u0N6VQ
 +Vn/V8DE2+pMcPaErDEDD1RXCrDFskRapiuSqs2UVQ==
X-Google-Smtp-Source: ABdhPJy0ojkQKo0eSoLHsaA1vv/mwPn8WhkthBzbrq19t+voyqnbwWhaTV/sfMs8+a0LNxw48KY+CIuUIxiXHTTZJ5U=
X-Received: by 2002:aca:b203:: with SMTP id b3mr11918689oif.118.1594606038369; 
 Sun, 12 Jul 2020 19:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-14-frank.chang@sifive.com>
 <facf726b-d355-b0af-3f7f-5574593aa44c@linaro.org>
In-Reply-To: <facf726b-d355-b0af-3f7f-5574593aa44c@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 13 Jul 2020 10:07:07 +0800
Message-ID: <CAE_xrPjkhsowsGeq_OJJeJUwDAvOM5JnHo-Ovtd8aFuuziiN2Q@mail.gmail.com>
Subject: Re: [RFC 13/65] target/riscv: rvv-0.9: configure instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007950e805aa49260f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x22b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007950e805aa49260f
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 11, 2020 at 2:07 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> > -static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
> > +static bool trans_vsetvl(DisasContext *s, arg_vsetvl *a)
>
> Do not mix this change with anything else.


OK~
---
Frank Chang


> > +    rd = tcg_const_i32(a->rd);
> > +    rs1 = tcg_const_i32(a->rs1);
>
> Any time you put a register number into a tcg const, there's probably a
> better
> way to do things.


> > -    /* Using x0 as the rs1 register specifier, encodes an infinite AVL
> */
> > -    if (a->rs1 == 0) {
> > -        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
> > -        s1 = tcg_const_tl(RV_VLEN_MAX);
> > -    } else {
> > -        s1 = tcg_temp_new();
> > -        gen_get_gpr(s1, a->rs1);
> > -    }
>
> E.g. this code should be kept, and add
>
>     if (a->rd == 0 && a->rs1 == 0) {
>         s1 = tcg_temp_new();
>         tcg_gen_mov_tl(s1, cpu_vl);
>     } else ...
>
OK~

>
> > +    if ((sew > cpu->cfg.elen)
> > +        || vill
> > +        || vflmul < ((float)sew / cpu->cfg.elen)
> > +        || (ediv != 0)
> > +        || (reserved != 0)) {
> >          /* only set vill bit. */
> >          env->vtype = FIELD_DP64(0, VTYPE, VILL, 1);
> > -        env->vl = 0;
> > -        env->vstart = 0;
> >          return 0;
> >      }
>
> You do need to check 0.7.1 so long as it's supported.
>
>
> r~
>

Will drop 0.7.1 support in my first patch to prevent the confusion.

Frank Chang

--0000000000007950e805aa49260f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Jul 11, 2020 at 2:07 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 7/10/20 3:48 AM, <a href=3D"mai=
lto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a> wr=
ote:<br>
&gt; -static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)<br>
&gt; +static bool trans_vsetvl(DisasContext *s, arg_vsetvl *a)<br>
<br>
Do not mix this change with anything else.</blockquote><div>=C2=A0</div><di=
v>OK~</div><div>---</div><div>Frank Chang</div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 rd =3D tcg_const_i32(a-&gt;rd);<br>
&gt; +=C2=A0 =C2=A0 rs1 =3D tcg_const_i32(a-&gt;rs1);<br>
<br>
Any time you put a register number into a tcg const, there&#39;s probably a=
 better<br>
way to do things.</blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; -=C2=A0 =C2=A0 /* Using x0 as the rs1 register specifier, encodes an i=
nfinite AVL */<br>
&gt; -=C2=A0 =C2=A0 if (a-&gt;rs1 =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* As the mask is at least one bit, RV_VL=
EN_MAX is &gt;=3D VLMAX */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s1 =3D tcg_const_tl(RV_VLEN_MAX);<br>
&gt; -=C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s1 =3D tcg_temp_new();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_get_gpr(s1, a-&gt;rs1);<br>
&gt; -=C2=A0 =C2=A0 }<br>
<br>
E.g. this code should be kept, and add<br>
<br>
=C2=A0 =C2=A0 if (a-&gt;rd =3D=3D 0 &amp;&amp; a-&gt;rs1 =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s1 =3D tcg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(s1, cpu_vl);<br>
=C2=A0 =C2=A0 } else ...<br></blockquote><div>OK~</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 if ((sew &gt; cpu-&gt;cfg.elen)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 || vill<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 || vflmul &lt; ((float)sew / cpu-&gt;cfg.=
elen)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 || (ediv !=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 || (reserved !=3D 0)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* only set vill bit. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;vtype =3D FIELD_DP64(0, VTYP=
E, VILL, 1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;vl =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;vstart =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
You do need to check 0.7.1 so long as it&#39;s supported.<br>
<br>
<br>
r~<br></blockquote><div><br></div><div>Will drop 0.7.1 support in my first =
patch to prevent the confusion.=C2=A0</div><div><br></div><div>Frank Chang<=
/div></div></div>

--0000000000007950e805aa49260f--

