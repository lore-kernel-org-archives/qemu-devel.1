Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A5C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998BB206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdRqePel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998BB206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv8Xs-0003mG-QP
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 18:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv8XK-0003L9-2K
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv8XI-0005Xl-Oo
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:38:50 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iv8XI-0005XS-Jt
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:38:48 -0500
Received: by mail-oi1-x244.google.com with SMTP id c16so1229605oic.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 15:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=bobFM9QSLTXtDDyIo/yJYvnJlh1qMX8i5BAB156yWyE=;
 b=EdRqePelbfFgyHYI6rXtwsGmnUpEKgYZVo/DkK1L9wpPsVv/vEsCCifmg1/GSQDDUm
 UHOm3p+Ro2lgbxT5qS5eg10U/IfJu3c9L1o4T+zz2PcPaLdaezs/aOCaG/Xzc8cajbGg
 GQHz9xEyWrZb87OExRnHqTGncBDgdUt+76CieX3FO06YDnW4o0JzakVJrhF/Lp7BhdDJ
 7pEeQ5sAZTkNPGIb2FpUP6QHMBQGuuxf8nNutYVEfoog72ZkNNddbl0Hm+tx9MZoZmC8
 ein17K4HbdArasvPkrru9/CiaGIkCs0YADMkputfE3r8zeMZC7u7e87ZoHXHnbubWg//
 Mj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=bobFM9QSLTXtDDyIo/yJYvnJlh1qMX8i5BAB156yWyE=;
 b=WPhzvGa9wCqmy2bnqrxCSagUHEoW54alpLQFuA42g6WHt6Dy5JshGd6tfWom6VIDnw
 wjfXw7c2uLhbBNifJv6SiU/pUyC41Heyc6nzNcLOdkG6FMw0LR26TJrONd+9n9Uy4ZFX
 7yuf/72/0kFbsVlUAHcndamDVxsVg61n/mihRZ3rMWUldOZsO7L/HlodHiloXJ0+Zh/l
 qPiqUo+j10+a9fFFTtZOkOdYWtx+8esXDuYKOgqAL8bYygtzKekgkwjXlHPybB2a9SSq
 pOAURWrL7ZHxA51SQa3GMXyilKJqMMpWJv6SMvhmo1Gh/SKVh83bKoxyjOtycHrIl5xG
 Rgfw==
X-Gm-Message-State: APjAAAWGmYHb8GSn4QgDVoX7FNC4Bg+WEssOKRTl6XWN/ii0VFkzw/7o
 5S9hwom5ob4LyXy6E/JN/kp+vnRY2rd336SQlyw=
X-Google-Smtp-Source: APXvYqyamQReP1eAINrF7/JpH0NqpXxPD5d1nq/oH3YgatvuNoWgdICGDOvpLd8n3H+cuhWbzNPdD+CGacDeFXTjy9o=
X-Received: by 2002:a05:6808:6c5:: with SMTP id
 m5mr888631oih.106.1579909127579; 
 Fri, 24 Jan 2020 15:38:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 24 Jan 2020 15:38:47 -0800 (PST)
In-Reply-To: <c3c80f0a-e348-4c7c-e8c4-579b16ec22a4@linaro.org>
References: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579883929-1517-7-git-send-email-aleksandar.markovic@rt-rk.com>
 <779b7b35-16a8-0538-ad87-fac218c93e82@linaro.org>
 <CAL1e-=hqgWesfm9f8fsSQ8JS54LybNMMGygbCNi0O+VyfSAJvg@mail.gmail.com>
 <c3c80f0a-e348-4c7c-e8c4-579b16ec22a4@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 25 Jan 2020 00:38:47 +0100
Message-ID: <CAL1e-=g89vC8gw6xNiGcNAhDixX2xZgnDjKgvDsChkvHHpduQA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] disas: mips: Add micromips R6 disassembler -
 infrastructure and 16-bit instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000053ac40059ceb420f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000053ac40059ceb420f
Content-Type: text/plain; charset="UTF-8"

On Friday, January 24, 2020, Richard Henderson <richard.henderson@linaro.org>
wrote:

> On 1/24/20 10:56 AM, Aleksandar Markovic wrote:
> >
> >
> > On Friday, January 24, 2020, Richard Henderson <
> richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>> wrote:
> >
> >     On 1/24/20 6:38 AM, Aleksandar Markovic wrote:
> >     > The basic disassembly logic was obtained by somewhat modified
> script
> >     > decodetree.py, and such output was further manually modified to
> >     > handle numerous details of micromips 32R6 instruction coding
> scheme.
> >
> >     What modifications to the script?
> >     What manual modifications to the output?
> >
> >     It's been a while since I looked at micromips, but I don't recall
> anything so
> >     odd that it couldn't be handled with the current output of
> decodetree.py.
> >
> >
> > I don't have dev setup at hand right now, but I can look it up in few
> days.
> > Some of the changes are purely of cosmetic nature (like outputing binary
> > instead of hex codes), but some are not. I can send you the whole
> modified
> > script, once I come back to my desk. There are some not-so-obvious
> micromips
> > oddities, if one delves enough into the coding scheme.
>
> The thing I'm concerned about here is any future maintenance of this
> file.  One
> would surely prefer to edit the original decodetree input than this output.
>
>
Here is the deal: This dissasembler is meant to reflect the  documentation
of a particular ISA, and as the documentation largely stays constant
(except adding some insignificant errata), the disassembler will stay
virtually constant, we wouldn't like even to touch it, and we like it this
way.


> r~
>

--00000000000053ac40059ceb420f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, January 24, 2020, Richard Henderson &lt;<a href=3D"mailt=
o:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On 1/24/20 10:56 AM, Aleksandar Markovic=
 wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Friday, January 24, 2020, Richard Henderson &lt;<a href=3D"mailto:r=
ichard.henderson@linaro.org">richard.henderson@linaro.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 1/24/20 6:38 AM, Aleksandar Markovic wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The basic disassembly logic was obtained by so=
mewhat modified script<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; decodetree.py, and such output was further man=
ually modified to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; handle numerous details of micromips 32R6 inst=
ruction coding scheme.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0What modifications to the script?<br>
&gt;=C2=A0 =C2=A0 =C2=A0What manual modifications to the output?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It&#39;s been a while since I looked at micromips, =
but I don&#39;t recall anything so<br>
&gt;=C2=A0 =C2=A0 =C2=A0odd that it couldn&#39;t be handled with the curren=
t output of decodetree.py.<br>
&gt; <br>
&gt; <br>
&gt; I don&#39;t have dev setup at hand right now, but I can look it up in =
few days.<br>
&gt; Some of the changes are purely of cosmetic nature (like outputing bina=
ry<br>
&gt; instead of hex codes), but some are not. I can send you the whole modi=
fied<br>
&gt; script, once I come back to my desk. There are some not-so-obvious mic=
romips<br>
&gt; oddities, if one delves enough into the coding scheme.<br>
<br>
The thing I&#39;m concerned about here is any future maintenance of this fi=
le.=C2=A0 One<br>
would surely prefer to edit the original decodetree input than this output.=
<br>
<br></blockquote><div><br></div><div>Here is the deal: This dissasembler is=
 meant to reflect the =C2=A0documentation of a particular ISA, and as the d=
ocumentation largely stays constant (except adding some insignificant errat=
a), the disassembler will stay virtually constant, we wouldn&#39;t like eve=
n to touch it, and we like it this way.</div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
r~<br>
</blockquote>

--00000000000053ac40059ceb420f--

