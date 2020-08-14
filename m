Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351D0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 03:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C4220716
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 03:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C5q91ulK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C4220716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Q9z-0005jz-74
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 23:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k6Q9C-0005HV-Ct
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 23:12:50 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:45383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k6Q9A-0004xK-Do
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 23:12:49 -0400
Received: by mail-oi1-x22d.google.com with SMTP id o21so6977205oie.12
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 20:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LZJ35ck8mjtzDpmYrWqbto/1NTd32akAob1OIsMuVag=;
 b=C5q91ulKP8th3JxNXQsDl8+tkB3QEfHLa/GCNSjpKI59br9uZhEpHsAQx3nTekva93
 2nqBYf8RMslrOWdxZxYuApoe0djayH2Q1A0Gb5ms9s1bzqVyiIU36okIOgYAEk9cAb0u
 wSTa1N9I/4CFe953dM+VmugUwWcQx7P3gAbPsJl5zKAbgls7zEqQ0ucQQH97sVvdxcSH
 dBaaWNYLxvB7HZcfQpouKb/TgsM6wZ1cKU5OpWW/7qhc3WP90iyepIxmwx3kF980rV2i
 d70VaqtVQZE4Rq6V5BxV6PrMQyUhUcaDH4kjaYonV/af3FDBFPbtUU/Ya1lWKJdcazC/
 FAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LZJ35ck8mjtzDpmYrWqbto/1NTd32akAob1OIsMuVag=;
 b=RziypdvnpNusYZpFHy7qAb91sB2ftyLb8U8iQ3YoNSMcWAh1fX1UkwUMrXQa9UO90y
 d0F5FohdvKKwWfs08/HXEcT4YLqFvM65WEsOqVDAskRmZsw3A4SbOodzEAJt6pbTw8Z6
 g/Mhx5oBJbhWdmnK1Rjd59kHrZdptvr/gvq5732C4u8MgisZf59v/3sYM8fko1pyY6PX
 Fr09g5mq9RTTQz0xojVOPojAtwsCWFEg4UYfisjKEb1V4aekrzp7gIiPqPrmWgPxZgfQ
 IsLzdEpk57PJuAZ7VNFvmkj0mMTMZGJw7WtVmYbEuUkV6W0JkG+Un80rM26s8sDIMoGq
 f8rw==
X-Gm-Message-State: AOAM531cVf3TS9pHDJ4ilyNylXDZXDWjCl5dWYlvQQc1Se9XqPr9g6mf
 VLZp6805/oa7+vuOiADD+urkcAqwscC46bAprX8ocw==
X-Google-Smtp-Source: ABdhPJy+rdlrhTtwrFf1/IzeW3YZ2LH2oqKs5y4D4Cb/BAhtEIbN9h1x0WW9xvXnHwbTK/OmQ1aNtQbTAsXJpD8nSi0=
X-Received: by 2002:aca:bd89:: with SMTP id n131mr369245oif.78.1597374766657; 
 Thu, 13 Aug 2020 20:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-13-frank.chang@sifive.com>
 <ab205cfa-80cc-411c-a87e-8c6de7c282e7@linaro.org>
In-Reply-To: <ab205cfa-80cc-411c-a87e-8c6de7c282e7@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 14 Aug 2020 11:12:35 +0800
Message-ID: <CAE_xrPiyGh28cp7p6Go5vzgD116pPN1HXhSLLkvSu-J2D0fLAQ@mail.gmail.com>
Subject: Re: [RFC v3 12/71] target/riscv: rvv-1.0: add fractional LMUL
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008a4aa805accdcb2a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x22d.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008a4aa805accdcb2a
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 7, 2020 at 2:36 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/6/20 3:46 AM, frank.chang@sifive.com wrote:
> > +    float flmul;
>
> int8_t?  It seems weird that the translator wouldn't also use...
>

It was kept for vector check functions.
However, I've removed float flmul and changed my
vector check functions to something like:

> static bool vext_check_sss(DisasContext *s, int vd, int vs1,
>                            int vs2, int vm, bool is_vs1)
> {
>     bool ret = require_vm(vm, vd);
>     if (s->lmul > 0) {
>         ret &= require_align(vd, 1 << s->lmul) &&
>                require_align(vs2, 1 << s->lmul);
>         if (is_vs1) {
>             ret &= require_align(vs1, 1 << s->lmul);
>         }
>     }
>     return ret;
> }

which use shifts to check the alignment/noover of vector registers.

The parameters passed to require_align() and require_noover()
are also changed to const uint8_t type so that the shifted value can be
wrapped within 8-bits.

int8_t lmul in DisasContext is also encoded:
ctx->lmul = sextract32(FIELD_EX32(tb_flags, TB_FLAGS, LMUL), 0, 3);


> > +/*
> > + * Encode LMUL to lmul as following:
> > + *     LMUL    vlmul    lmul
> > + *      1       000       0
> > + *      2       001       1
> > + *      4       010       2
> > + *      8       011       3
> > + *      -       100       -
> > + *     1/8      101      -3
> > + *     1/4      110      -2
> > + *     1/2      111      -1
> > + */
> > +static inline int32_t vext_lmul(uint32_t desc)
> >  {
> > -    return FIELD_EX32(simd_data(desc), VDATA, LMUL);
> > +    uint32_t lmul = FIELD_EX32(simd_data(desc), VDATA, LMUL);
> > +    return (int8_t)(lmul << 5) >> 5;
> >  }
>
> ... this encoding?
>
> Oh, and sextract32(lmul, 0, 3) instead of those shifts.
>

OK~


>
>
> r~
>

Thanks
Frank Chang

--0000000000008a4aa805accdcb2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Aug 7, 2020 at 2:36 AM Richard He=
nderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.henders=
on@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On 8/6/20 3:46 AM, <a href=3D"mailt=
o:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a> wrot=
e:<br>
&gt; +=C2=A0 =C2=A0 float flmul;<br>
<br>
int8_t?=C2=A0 It seems weird that the translator wouldn&#39;t also use...<b=
r></blockquote><div><br></div><div>It was kept for vector check functions.<=
/div><div>However, I&#39;ve removed float flmul and changed my</div><div>ve=
ctor check functions to something like:</div><div><br></div><div>&gt; stati=
c bool vext_check_sss(DisasContext *s, int vd, int vs1,<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int vs2, int vm, bool is_vs1)<br>&gt; {<br>&gt; =C2=A0 =C2=A0 =
bool ret =3D require_vm(vm, vd);<br>&gt; =C2=A0 =C2=A0 if (s-&gt;lmul &gt; =
0) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret &amp;=3D require_align(vd, 1 &=
lt;&lt; s-&gt;lmul) &amp;&amp;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0require_align(vs2, 1 &lt;&lt; s-&gt;lmul);<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (is_vs1) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ret &amp;=3D require_align(vs1, 1 &lt;&lt; s-&gt;lmul);<br>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; =C2=A0 =C2=A0 }<br>&gt; =C2=A0 =C2=
=A0 return ret;<br>&gt; }<br></div><div><br></div><div>which use shifts to =
check the alignment/noover of vector registers.</div><div><br></div><div>Th=
e parameters passed to=C2=A0require_align() and=C2=A0require_noover()</div>=
<div>are also changed to=C2=A0const uint8_t type so that the shifted value =
can be</div><div>wrapped within 8-bits.</div><div><br></div><div>int8_t lmu=
l in=C2=A0DisasContext is also encoded:</div><div>ctx-&gt;lmul =3D sextract=
32(FIELD_EX32(tb_flags, TB_FLAGS, LMUL), 0, 3);<br></div><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +/*<br>
&gt; + * Encode LMUL to lmul as following:<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0LMUL=C2=A0 =C2=A0 vlmul=C2=A0 =C2=A0 lmul<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0000=C2=A0 =C2=A0 =
=C2=A0 =C2=A00<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 2=C2=A0 =C2=A0 =C2=A0 =C2=A0001=C2=A0 =C2=A0 =
=C2=A0 =C2=A01<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 4=C2=A0 =C2=A0 =C2=A0 =C2=A0010=C2=A0 =C2=A0 =
=C2=A0 =C2=A02<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 8=C2=A0 =C2=A0 =C2=A0 =C2=A0011=C2=A0 =C2=A0 =
=C2=A0 =C2=A03<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 -=C2=A0 =C2=A0 =C2=A0 =C2=A0100=C2=A0 =C2=A0 =
=C2=A0 =C2=A0-<br>
&gt; + *=C2=A0 =C2=A0 =C2=A01/8=C2=A0 =C2=A0 =C2=A0 101=C2=A0 =C2=A0 =C2=A0=
 -3<br>
&gt; + *=C2=A0 =C2=A0 =C2=A01/4=C2=A0 =C2=A0 =C2=A0 110=C2=A0 =C2=A0 =C2=A0=
 -2<br>
&gt; + *=C2=A0 =C2=A0 =C2=A01/2=C2=A0 =C2=A0 =C2=A0 111=C2=A0 =C2=A0 =C2=A0=
 -1<br>
&gt; + */<br>
&gt; +static inline int32_t vext_lmul(uint32_t desc)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 return FIELD_EX32(simd_data(desc), VDATA, LMUL);<br>
&gt; +=C2=A0 =C2=A0 uint32_t lmul =3D FIELD_EX32(simd_data(desc), VDATA, LM=
UL);<br>
&gt; +=C2=A0 =C2=A0 return (int8_t)(lmul &lt;&lt; 5) &gt;&gt; 5;<br>
&gt;=C2=A0 }<br>
<br>
... this encoding?<br>
<br>
Oh, and sextract32(lmul, 0, 3) instead of those shifts.<br></blockquote><di=
v><br></div><div>OK~</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
<br>
r~<br></blockquote><div><br></div><div>Thanks</div><div>Frank Chang=C2=A0</=
div></div></div>

--0000000000008a4aa805accdcb2a--

