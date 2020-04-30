Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA08C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 00:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76B220731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 00:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsw4LSQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76B220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTwxt-0002hW-P6
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 20:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jTwwv-00029N-7l
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 20:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jTwwu-0005yJ-Pc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 20:21:09 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:46113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jTwwr-0005xd-Pk; Wed, 29 Apr 2020 20:21:05 -0400
Received: by mail-lj1-x22b.google.com with SMTP id f18so4553902lja.13;
 Wed, 29 Apr 2020 17:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=bvvY2WvMHHhD+5v+vYgSFdhu8XC9ne08tdFPDGrIpW4=;
 b=Wsw4LSQ1wookR3ONbxFwWFtFk9fgrEXj1EVGmiUmdL+5OTOW1Cm074PVNYB5Q1dO6i
 QYBP7TvR6gqiadvLVfAs0aKJwkq9R2Xg9LDiNP7y9QW82hzM7jmaEfKkB8wGuOSswCR0
 N2bF601gETfCtjMvJBUrC52Eei7zsNvIyu4sUhNVrXLDo8I3ReA4I2r7TEiX8tcuH+AM
 Dfr2kGZP4LcpjsBlYsbsIXnQ48G/Sji5ULiLnrKvnpUbiiJAPJF8p+wxlgUWruchntOW
 GOeclkGB2X7qj2+EIW54NiIAivwbBxE1X6nQ3nQ1UwGPlCb/cr8skspehb5TFn5ECQi1
 rTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=bvvY2WvMHHhD+5v+vYgSFdhu8XC9ne08tdFPDGrIpW4=;
 b=WkekbCM4tAEoFQyGnqSKLdxt+4X6ObHE7ORTeQ4BX4sM0hM1usWY9eEhXorAbJOMAA
 X3ShymlOkYHulx5rvR9I7Ud2pTwWt1DyFUS0x8EIAcZJomYqd7D9pDlWBcGVBULHi0WS
 Jbckyl/VclNZxDK/MFnHsKZ3kF19oyZLzEF3gTREyU6Fq36e5+JkI9zFonV0M/54uLHs
 oljs7WHBJ+zEabBY/fH/PgXVbWwGlUKprt7cUjvf29WOUxuTpuYtRW4My0ZwwqsaeYDh
 r+4eGPFRDYtWqJEJJNXyLcGiV5tZuRhfcNaU1sHiyFb7q/zrlktiAM6AZLFgdhQ8Ahp0
 jtvg==
X-Gm-Message-State: AGi0PuZAkSOsS5FZVoxOzEGg19UtWBvR7bA2IRL/EoRPYmBFo0Z/VOq+
 4IEC0ptq9oSNrVjw5PYl7zdvs5ySEMeTdpXtinc=
X-Google-Smtp-Source: APiQypLLf90Q0I+QLOsIgbdHfOAzsLjP2SWQUnVff5609ydPWWfL2cLJGZTyxRqnqIjLPdJTIRASQCZBj3xccC0vVu0=
X-Received: by 2002:a2e:9117:: with SMTP id m23mr440435ljg.43.1588206063345;
 Wed, 29 Apr 2020 17:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87sggmjgit.fsf@linaro.org>
In-Reply-To: <87sggmjgit.fsf@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 30 Apr 2020 08:20:51 +0800
Message-ID: <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
Subject: Re: R: R: About hardfloat in ppc
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003c65ba05a4770aef"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22b.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::22b
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
Reply-To: luoyonggang@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003c65ba05a4770aef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Question, in hard-float, if we don't want to read the fp register.
for example: If we wanna compute c =3D a + b in fp32
if c =3D a + b In hard float
and if b1 =3D c - a in hard float
if b1 !=3D b at bitwise level, the we se the inexat to 1, otherwsie
we set inexat bit to 0? are this valid?

we can also do it for a * b, a - b, a / b.


On Thu, Apr 30, 2020 at 2:25 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Dino Papararo <skizzato73@msn.com> writes:
>
> > Hi Alex,
> <snip>
> >
> > I leave to you TCG's experts how it works and how to implement it, I'm
> > only tryng to explain a possible fast way to go (if ever possible) =F0=
=9F=98=8A
>
> This is all a theoretical discussion unless someone cares enough to
> improve the situation. While I have an interest in improving TCG
> performance I'm afraid there are many more easier wins before tackling a
> target specific hack for which I'm not familiar. No doubt this thread
> will be referred to next time someone wants something done about it.
>
> > ..Large majority of software don't check for exceptions at all and if
> > I really want to pursue max precision I'll go for a software
> > multiprecision library like GMP or MPFR Libraries.
>
> However for QEMU we regard failure to correctly emulate the architecture
> as a bug - we don't code to common software patterns because there is
> plenty of software out there that doesn't follow it.
>
> > So the hardfloats 'should' be set as first choice and only if
> > instruction requires precision/error check process it in softfloats.
>
> Sure but someone will have to do the work to support that.
>
> --
> Alex Benn=C3=A9e
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003c65ba05a4770aef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Question, in hard-float, if we don&#39;t want to read the =
fp register.<div>for example: If we wanna compute c =3D a=C2=A0+ b in fp32<=
/div><div>if c =3D a=C2=A0+ b In hard float</div><div>and if b1 =3D c - a i=
n hard float</div><div>if b1 !=3D b at bitwise level, the we se the=C2=A0in=
exat=C2=A0to 1, otherwsie=C2=A0</div><div>we set inexat=C2=A0bit to 0? are =
this valid?</div><div><br></div><div>we can also do it for a * b, a - b, a =
/ b.=C2=A0</div><div><br></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Thu, Apr 30, 2020 at 2:25 AM Alex Benn=C3=
=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><b=
r>
Dino Papararo &lt;<a href=3D"mailto:skizzato73@msn.com" target=3D"_blank">s=
kizzato73@msn.com</a>&gt; writes:<br>
<br>
&gt; Hi Alex,<br>
&lt;snip&gt;<br>
&gt;<br>
&gt; I leave to you TCG&#39;s experts how it works and how to implement it,=
 I&#39;m<br>
&gt; only tryng to explain a possible fast way to go (if ever possible) =F0=
=9F=98=8A<br>
<br>
This is all a theoretical discussion unless someone cares enough to<br>
improve the situation. While I have an interest in improving TCG<br>
performance I&#39;m afraid there are many more easier wins before tackling =
a<br>
target specific hack for which I&#39;m not familiar. No doubt this thread<b=
r>
will be referred to next time someone wants something done about it.<br>
<br>
&gt; ..Large majority of software don&#39;t check for exceptions at all and=
 if<br>
&gt; I really want to pursue max precision I&#39;ll go for a software<br>
&gt; multiprecision library like GMP or MPFR Libraries.<br>
<br>
However for QEMU we regard failure to correctly emulate the architecture<br=
>
as a bug - we don&#39;t code to common software patterns because there is<b=
r>
plenty of software out there that doesn&#39;t follow it.<br>
<br>
&gt; So the hardfloats &#39;should&#39; be set as first choice and only if<=
br>
&gt; instruction requires precision/error check process it in softfloats.<b=
r>
<br>
Sure but someone will have to do the work to support that.<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--0000000000003c65ba05a4770aef--

