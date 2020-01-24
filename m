Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6DDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5562071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc5UAtYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5562071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv619-0007ZP-02
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv60R-00076p-2l
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv60P-0003UY-4E
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:56:42 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iv60N-0003LR-B9
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:56:39 -0500
Received: by mail-oi1-x243.google.com with SMTP id l7so805947oil.12
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=VaoNX9dljWSOju/GbtS0nQ8JZ42lO4gQK40C2PZQZwI=;
 b=Pc5UAtYAjHZZZmr4vmRnI6TjwJut3qZcvNpAD/36sRo4khvttl1IGPMv+WdtQbBsQ8
 itBm5pCr198yWKKIp9yrVo1wobcfhJelb4M4Nn8EfH8+BVdn8zWHZZJ9y5jxRbOTmIss
 ++7y6NvnjFVHsIHzfnEL7eCJ9yJSqs2PmrQQ3+97W0Q1obzv9BVgQQNUXhY+Cp8E98mC
 n8WQEDMYTL7DbgF7r3o+y4Zh6I4scxknt31T5V9aiDo4cLa7K59ZK4b7ZCPCM+z8NUHp
 y5YEohncU9lkVV4BFYNKpYCvN5/VDSRV9NBJzf1vupT70Ek2iTqMGiwOCEx6mYpK82fz
 Dqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=VaoNX9dljWSOju/GbtS0nQ8JZ42lO4gQK40C2PZQZwI=;
 b=T0L7MgJnt12gUUB/nTtGT7Lk4vetSo5gHozU7IHhZ/RF+D8SBBfO2J7geiVhb1SSdp
 eQf/zauTiJQ/sWJ0ke6NTXfsUtfeURzTmqmtji+QWyLBgwMIbJKL6KNEjAcHX3ky9KBO
 j4mMThMHjMZTGemeek68oljD9BIth5gsVNu4Qimho1kP4Ug/4Sn8J0aZT3kMciab09wH
 Rl/hGn/Mr0fA7B/h5LpvvShwye4luWOtgFghCdDURsNaXoagEE+vBlUug7OilFjdIon9
 ovmiRC3WMxxJ1usLB5sDxhoGd35kvuJLUCSe9ADcVyuB1k5WPNn5vTepaYqsjBYvVPoK
 5YRw==
X-Gm-Message-State: APjAAAUOakP5h31MU2JIXvXgwJKqItCs0KzVk+pNaFYjyMKHq5FdjdQ9
 xY7nEbhL/Ntd94oJM6apsDzX8q5iU2MPqAOhFwE=
X-Google-Smtp-Source: APXvYqw6+2RC+5JIXgxSqE6NwpG0jB/24ZyaVeVM7Zzu7Xq0t64T6ns81MJOL3jDYp8Yp2LUxCKOzzyGzqFu/7vu2pk=
X-Received: by 2002:a05:6808:6c5:: with SMTP id
 m5mr498199oih.106.1579899398113; 
 Fri, 24 Jan 2020 12:56:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 24 Jan 2020 12:56:37 -0800 (PST)
In-Reply-To: <779b7b35-16a8-0538-ad87-fac218c93e82@linaro.org>
References: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579883929-1517-7-git-send-email-aleksandar.markovic@rt-rk.com>
 <779b7b35-16a8-0538-ad87-fac218c93e82@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 24 Jan 2020 21:56:37 +0100
Message-ID: <CAL1e-=hqgWesfm9f8fsSQ8JS54LybNMMGygbCNi0O+VyfSAJvg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] disas: mips: Add micromips R6 disassembler -
 infrastructure and 16-bit instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000067cccb059ce8fe25"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

--00000000000067cccb059ce8fe25
Content-Type: text/plain; charset="UTF-8"

On Friday, January 24, 2020, Richard Henderson <richard.henderson@linaro.org>
wrote:

> On 1/24/20 6:38 AM, Aleksandar Markovic wrote:
> > The basic disassembly logic was obtained by somewhat modified script
> > decodetree.py, and such output was further manually modified to
> > handle numerous details of micromips 32R6 instruction coding scheme.
>
> What modifications to the script?
> What manual modifications to the output?
>
> It's been a while since I looked at micromips, but I don't recall anything
> so
> odd that it couldn't be handled with the current output of decodetree.py.
>

I don't have dev setup at hand right now, but I can look it up in few days.
Some of the changes are purely of cosmetic nature (like outputing binary
instead of hex codes), but some are not. I can send you the whole modified
script, once I come back to my desk. There are some not-so-obvious
micromips oddities, if one delves enough into the coding scheme.

> +static void getAlias(char *buffer, int regNo)
> > +{
> > +    switch (regNo) {
> > +    case 0:
> > +        strncpy(buffer, "zero", 5);
> > +        break;
> > +    case 1:
> > +        strncpy(buffer, "at", 5);
> > +        break;
> > +    case 2:
> > +    case 3:
> > +        sprintf(buffer, "v%d", regNo - 2);
> > +        break;
> > +    case 4:
> > +    case 5:
> > +    case 6:
> > +    case 7:
> > +        sprintf(buffer, "a%d", regNo - 4);
> > +        break;
> > +    case 8:
> > +    case 9:
> > +    case 10:
> > +    case 11:
> > +    case 12:
> > +    case 13:
> > +    case 14:
> > +    case 15:
> > +        sprintf(buffer, "t%d", regNo - 8);
> > +        break;
> > +    case 16:
> > +    case 17:
> > +    case 18:
> > +    case 19:
> > +    case 20:
> > +    case 21:
> > +    case 22:
> > +    case 23:
> > +        sprintf(buffer, "s%d", regNo - 16);
> > +        break;
> > +    case 24:
> > +    case 25:
> > +        sprintf(buffer, "t%d", regNo - 16);
> > +        break;
> > +    case 28:
> > +        strncpy(buffer, "gp", 5);
> > +        break;
> > +    case 29:
> > +        strncpy(buffer, "sp", 5);
> > +        break;
> > +    case 30:
> > +        strncpy(buffer, "s8", 5);
> > +        break;
> > +    case 31:
> > +        strncpy(buffer, "ra", 5);
> > +        break;
> > +    default:
> > +        sprintf(buffer, "r%d", regNo);
> > +        break;
> > +    }
> > +}
>
> Surely this would be better as a const array of string literals.  There are
> only 32 of them after all.
>
> Then you can just return the const char *, which is much better than
> sprintf'ing into a caller-provided buffer of unknown size.
>
>
Right. Thank you. This is anyway still code-in-development, made just to do
the job, but it can be implemented better, like in the way you suggested.

Thanks again,

Aleksandar



>
> r~
>
>

--00000000000067cccb059ce8fe25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, January 24, 2020, Richard Henderson &lt;<a href=3D"mailt=
o:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On 1/24/20 6:38 AM, Aleksandar Markovic =
wrote:<br>
&gt; The basic disassembly logic was obtained by somewhat modified script<b=
r>
&gt; decodetree.py, and such output was further manually modified to<br>
&gt; handle numerous details of micromips 32R6 instruction coding scheme.<b=
r>
<br>
What modifications to the script?<br>
What manual modifications to the output?<br>
<br>
It&#39;s been a while since I looked at micromips, but I don&#39;t recall a=
nything so<br>
odd that it couldn&#39;t be handled with the current output of decodetree.p=
y.<br></blockquote><div><br></div><div>I don&#39;t have dev setup at hand r=
ight now, but I can look it up in few days. Some of the changes are purely =
of cosmetic nature (like outputing binary instead of hex codes), but some a=
re not. I can send you the whole modified script, once I come back to my de=
sk. There are some not-so-obvious micromips oddities, if one delves enough =
into the coding scheme.</div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; +static void getAlias(char *buffer, int regNo)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 switch (regNo) {<br>
&gt; +=C2=A0 =C2=A0 case 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;zero&quot;, 5);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;at&quot;, 5);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 2:<br>
&gt; +=C2=A0 =C2=A0 case 3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;v%d&quot;, regNo - =
2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 4:<br>
&gt; +=C2=A0 =C2=A0 case 5:<br>
&gt; +=C2=A0 =C2=A0 case 6:<br>
&gt; +=C2=A0 =C2=A0 case 7:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;a%d&quot;, regNo - =
4);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 8:<br>
&gt; +=C2=A0 =C2=A0 case 9:<br>
&gt; +=C2=A0 =C2=A0 case 10:<br>
&gt; +=C2=A0 =C2=A0 case 11:<br>
&gt; +=C2=A0 =C2=A0 case 12:<br>
&gt; +=C2=A0 =C2=A0 case 13:<br>
&gt; +=C2=A0 =C2=A0 case 14:<br>
&gt; +=C2=A0 =C2=A0 case 15:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;t%d&quot;, regNo - =
8);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 16:<br>
&gt; +=C2=A0 =C2=A0 case 17:<br>
&gt; +=C2=A0 =C2=A0 case 18:<br>
&gt; +=C2=A0 =C2=A0 case 19:<br>
&gt; +=C2=A0 =C2=A0 case 20:<br>
&gt; +=C2=A0 =C2=A0 case 21:<br>
&gt; +=C2=A0 =C2=A0 case 22:<br>
&gt; +=C2=A0 =C2=A0 case 23:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;s%d&quot;, regNo - =
16);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 24:<br>
&gt; +=C2=A0 =C2=A0 case 25:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;t%d&quot;, regNo - =
16);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 28:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;gp&quot;, 5);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 29:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;sp&quot;, 5);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 30:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;s8&quot;, 5);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 31:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;ra&quot;, 5);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;r%d&quot;, regNo);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
<br>
Surely this would be better as a const array of string literals.=C2=A0 Ther=
e are<br>
only 32 of them after all.<br>
<br>
Then you can just return the const char *, which is much better than<br>
sprintf&#39;ing into a caller-provided buffer of unknown size.<br>
<br></blockquote><div><br></div><div>Right. Thank you. This is anyway still=
 code-in-development, made just to do the job, but it can be implemented be=
tter, like in the way you suggested.</div><div><br></div><div>Thanks again,=
</div><div><br></div><div>Aleksandar</div><div><br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
r~<br>
<br>
</blockquote>

--00000000000067cccb059ce8fe25--

