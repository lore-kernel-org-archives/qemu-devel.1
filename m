Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A016320772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzXseaFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A016320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8f0-0007PR-UT
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jh8dd-0004is-Cs
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:27:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jh8dc-0003Ib-6z
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:27:45 -0400
Received: by mail-wr1-x436.google.com with SMTP id l11so9028438wru.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+2ciY5g7eNDeckNlunhTgUXdWOAXVP9xwxiX9HUqP60=;
 b=nzXseaFORFDNigaAw8oXZbRsaGzHt1qaQbLxDT9Mpxnxe6l4MHS5BeUed3Fs2Pj5jm
 Aay/w5xDkBrLKwBqFI30z5draHzrPydK4B7DOr22JdcU3NgCo59vaT1Yfnv7Qzm64/cm
 sZw6JwBEf2yR9igD6oaCUyl+RFE1vOShxYFhdxTGNYclIrJesT1Dr/Z3ZVEa9vz24dlC
 cv/CMLjkixMMKUeozOmlT2c1tf2ITnQ/yChIFm5btknUz3GF/AjkdUbjawAHO/RUdwme
 GyE/l0U1Bb5zACvom1oRwFI96MpUOiWkjHn6mKBpwLrW+6V/6J/25crLo0A9DLkxQ5Ac
 L3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+2ciY5g7eNDeckNlunhTgUXdWOAXVP9xwxiX9HUqP60=;
 b=EELYIAdofUhQtx8FLApN3vK6h+YiSIjl2rKm6HpcpdGncKZHTvA1OxUmbeH1v+2dgf
 3UTee+MCCkxsMyJVWjg7UsqOAP6Y5YXkCw3sF516P+yu/gqHSu5g2E1/kRY99NaR1MXb
 LP81TUpuiSlpwksd1U4VdSkT6MyOBZ3Gl2jcU2Z+q5BOJqN5sFqUz7KA7nHZGGY32xcm
 GJ0KvhDA5U9F+2VXg+0rij97A7aunXQ6pWeidKX+mEGkmGzmfOt4A2gZn+0QCYrD2Qb2
 KajgTUPj0GW2JCfR1X47BYnIcj52iSI0//7VhDpe2jLr1QRaTpn+8pYvtWCw6r34SBX6
 7Ycg==
X-Gm-Message-State: AOAM530XDhcKrJmsoGcUORvNEBhpVdX9oFGe3GjUn3grteGr035H4G8u
 9Taqg1EFImhag9c8EMQdBmcXCo0dDKU7JmoRKx0=
X-Google-Smtp-Source: ABdhPJxpJfdVGZ786SgLd3A5GoI+0948IMNwLL2jAnGlSVJ2RKmTUQXMYSdFRCvick95iA5Kq6WGhvoLxkwsf5nZFYE=
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr8427743wrv.162.1591349262215; 
 Fri, 05 Jun 2020 02:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <CAHiYmc7YtDSL_+LexXXBtZArdQVuU9-bwRoAxyTfseG=-6+NOQ@mail.gmail.com>
 <20200605170545.0000676c@flygoat.com>
In-Reply-To: <20200605170545.0000676c@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 5 Jun 2020 11:27:22 +0200
Message-ID: <CAHiYmc667TSjJKHKqS5MupkS=5hqFe8NA9BXrwtXmDpj6VqE6A@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="0000000000007cef3f05a752df0b"
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: chen huacai <zltjiangshi@gmail.com>, Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007cef3f05a752df0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

11:06 Pet, 05.06.2020. Jiaxun Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Fri, 5 Jun 2020 10:38:36 +0200
> Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> wrote:
>
> > =D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:38 Huacai Che=
n <zltjiangshi@gmail.com> =D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and
> > > Loongson-3B R1/R2.
> >
> > Hi, Huacai,
> >
> > The documents you kindly provided contain some valuable info on
> > Loongson-3A R1/R2/R3/R4 and Loongson-3B R1/R2. However, I
> > couldn't find detailed instruction-by-instruction specifications.
> >
> > In fact, I don't need all the details right now, but some form of
> > overview of instructions sets of Loongson-3A R1/R2/R3/R4 and
> > Loongson-3B R1/R2. Could you please provide textual description
> > (one of two paragraph) of supported instructions for each of these
> > models:
> >
>
> Hi Aleksandar,
>
> I'm going to explain this according to the names of vendor specified
> ASEs name in GCC & Binutils.
>
> There are some instruction that not covered by public documents, that's
> out of our scope so I'm not going to talk them.
>
> Firstly, there are some ASEs not being upstreamed yet:
>  - Loongson-AMO (Atomic Opreations, Looks like RISC-V)
>  - Loongson-EXT3 (Loongson Extention 3)
>  - Loongson-CSR (Core Status Registers, instructions to read some
>    private core register, including something called "stable-counter"
>    (TSC like timer) and CPUCFG(something like cpuid in x86))
>
>  - MIPS-MSA-Ctypto (Including AES, SHA, MD5 stuff)
>  - MIPS MSA2 (256-bit MSA instructions)
>
> And there is a ASE that only being used in kernel so not even being
> mentioned in toolchain.
>  - Loongson-SPW (LWPTE, LDPTE used to help with pagetable walking)
>
> ALl these processors have mips64r2 as baseline.
>
> > * Loongson-3A R1
> Loongson-MMI, Loongson-EXT
>
> > * Loongson-3A R2
> Loongson-MMI, Loongson-EXT, Looongson-EXT2, Loongson-SPW, DSP, DSPr2
>
> > * Loongson-3A R3
> Same as R2. This revision mainly focus on bugfix and improve clock
> speed.
>
> > * Loongson-3A R4
> Loongson-MMI, Loongson-EXT, Looongson-EXT2, Loongson-SPW, Loongson-AMO,
> Loongson-EXT3, Loongson-CSR, MSA Crypto, MSA2
>
> This processor even support hardware unaligned accessing.
>
> > * Loongson-3B R1
> > * Loongson-3B R2
> Loongson-3B R1 and R2 are mostly identical with Loongson-3A R1, the
> difference is it have 8-cores in a package. It was designed for HPC so
> there are some domain specific SIMD instructions, but they're not
> available to public.
>
> And a new family member of Loongson64:
> Loongson-2K (R1):
> Loongson-MMI, Loongson-EXT, Looongson-EXT2, MSA.
>

Thanks for your detailed response, Juaxun.

I will think over the weekend about the new aspects you mentioned here. All
this is valuable info for long-term planning. But also in short-term - for
this very series. Expect my answer early next week.

Best Regards and Best Health!

Aleksandar


> >
> > (what is the base instructuin set; the difference to the previous
> > model; what SIMD extension (LMI/MSA) is supported other specifics
> > around supported instructions)
> >
> > Based on your answer I may bring forward some suggestions on the
> > improvement of v4 of this series.
> >
> > Truly yours,
> > Aleksandar
> >
>
> Thank a lot.
>
> - Jiaxun

--0000000000007cef3f05a752df0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">11:06 Pet, 05.06.2020. Jiaxun Yang &lt;<a href=3D"mailto:jia=
xun.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On Fri, 5 Jun 2020 10:38:36 +0200<br>
&gt; Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.=
com">aleksandar.qemu.devel@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; =D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:38 Huac=
ai Chen &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zltjiangshi@gmail.com<=
/a>&gt; =D1=98=D0=B5<br>
&gt; &gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and<br=
>
&gt; &gt; &gt; Loongson-3B R1/R2.=C2=A0 <br>
&gt; &gt; <br>
&gt; &gt; Hi, Huacai,<br>
&gt; &gt; <br>
&gt; &gt; The documents you kindly provided contain some valuable info on<b=
r>
&gt; &gt; Loongson-3A R1/R2/R3/R4 and Loongson-3B R1/R2. However, I<br>
&gt; &gt; couldn&#39;t find detailed instruction-by-instruction specificati=
ons.<br>
&gt; &gt; <br>
&gt; &gt; In fact, I don&#39;t need all the details right now, but some for=
m of<br>
&gt; &gt; overview of instructions sets of Loongson-3A R1/R2/R3/R4 and<br>
&gt; &gt; Loongson-3B R1/R2. Could you please provide textual description<b=
r>
&gt; &gt; (one of two paragraph) of supported instructions for each of thes=
e<br>
&gt; &gt; models:<br>
&gt; &gt; <br>
&gt;<br>
&gt; Hi Aleksandar,<br>
&gt;<br>
&gt; I&#39;m going to explain this according to the names of vendor specifi=
ed<br>
&gt; ASEs name in GCC &amp; Binutils.<br>
&gt;<br>
&gt; There are some instruction that not covered by public documents, that&=
#39;s<br>
&gt; out of our scope so I&#39;m not going to talk them.<br>
&gt;<br>
&gt; Firstly, there are some ASEs not being upstreamed yet:<br>
&gt; =C2=A0- Loongson-AMO (Atomic Opreations, Looks like RISC-V)<br>
&gt; =C2=A0- Loongson-EXT3 (Loongson Extention 3)<br>
&gt; =C2=A0- Loongson-CSR (Core Status Registers, instructions to read some=
<br>
&gt; =C2=A0 =C2=A0private core register, including something called &quot;s=
table-counter&quot;<br>
&gt; =C2=A0 =C2=A0(TSC like timer) and CPUCFG(something like cpuid in x86))=
<br>
&gt;<br>
&gt; =C2=A0- MIPS-MSA-Ctypto (Including AES, SHA, MD5 stuff)<br>
&gt; =C2=A0- MIPS MSA2 (256-bit MSA instructions)<br>
&gt;<br>
&gt; And there is a ASE that only being used in kernel so not even being<br=
>
&gt; mentioned in toolchain.<br>
&gt; =C2=A0- Loongson-SPW (LWPTE, LDPTE used to help with pagetable walking=
)<br>
&gt;<br>
&gt; ALl these processors have mips64r2 as baseline.<br>
&gt;<br>
&gt; &gt; * Loongson-3A R1<br>
&gt; Loongson-MMI, Loongson-EXT<br>
&gt;<br>
&gt; &gt; * Loongson-3A R2<br>
&gt; Loongson-MMI, Loongson-EXT, Looongson-EXT2, Loongson-SPW, DSP, DSPr2<b=
r>
&gt;<br>
&gt; &gt; * Loongson-3A R3<br>
&gt; Same as R2. This revision mainly focus on bugfix and improve clock<br>
&gt; speed.<br>
&gt;<br>
&gt; &gt; * Loongson-3A R4<br>
&gt; Loongson-MMI, Loongson-EXT, Looongson-EXT2, Loongson-SPW, Loongson-AMO=
,<br>
&gt; Loongson-EXT3, Loongson-CSR, MSA Crypto, MSA2<br>
&gt;<br>
&gt; This processor even support hardware unaligned accessing.<br>
&gt;<br>
&gt; &gt; * Loongson-3B R1<br>
&gt; &gt; * Loongson-3B R2<br>
&gt; Loongson-3B R1 and R2 are mostly identical with Loongson-3A R1, the<br=
>
&gt; difference is it have 8-cores in a package. It was designed for HPC so=
<br>
&gt; there are some domain specific SIMD instructions, but they&#39;re not<=
br>
&gt; available to public.<br>
&gt;<br>
&gt; And a new family member of Loongson64:<br>
&gt; Loongson-2K (R1):<br>
&gt; Loongson-MMI, Loongson-EXT, Looongson-EXT2, MSA.<br>
&gt;</p>
<p dir=3D"ltr">Thanks for your detailed response, Juaxun.</p>
<p dir=3D"ltr">I will think over the weekend about the new aspects you ment=
ioned here. All this is valuable info for long-term planning. But also in s=
hort-term - for this very series. Expect my answer early next week.</p>
<p dir=3D"ltr">Best Regards and Best Health!</p>
<p dir=3D"ltr">Aleksandar<br><br><br></p>
<p dir=3D"ltr">&gt; &gt; <br>
&gt; &gt; (what is the base instructuin set; the difference to the previous=
<br>
&gt; &gt; model; what SIMD extension (LMI/MSA) is supported other specifics=
<br>
&gt; &gt; around supported instructions)<br>
&gt; &gt; <br>
&gt; &gt; Based on your answer I may bring forward some suggestions on the<=
br>
&gt; &gt; improvement of v4 of this series.<br>
&gt; &gt; <br>
&gt; &gt; Truly yours,<br>
&gt; &gt; Aleksandar<br>
&gt; &gt; <br>
&gt;<br>
&gt; Thank a lot.<br>
&gt;<br>
&gt; - Jiaxun<br>
</p>

--0000000000007cef3f05a752df0b--

