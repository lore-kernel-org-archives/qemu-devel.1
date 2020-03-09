Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9694AC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2FE20727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+Sb2EOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2FE20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOFI-0001Jq-Je
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBOEe-0000nb-Pj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBOEd-0002Hu-L6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:38:44 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBOEd-0002H1-E4; Mon, 09 Mar 2020 15:38:43 -0400
Received: by mail-io1-xd43.google.com with SMTP id r15so10417900iog.0;
 Mon, 09 Mar 2020 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZN45wNhpGZsLu7yaSFSio7NjmK67W30L5fYUGshtYQU=;
 b=E+Sb2EObhjdU8Mv/v6Koh5i195OCrC/xS7TKXbHjTT0jLk4b3yb+WxC6K+jXVW2oqC
 0Dm5I/UWsRanHFywrbAKtVJz4/vgqO3RXurtj8JDwG5ZuCHqzMRyxTARJnlAuR3a7xQS
 OY3WDqIiCt+tBJKJac627NACCCg08d6Ehh+aPI3xwm9VfCvRubXfhXtL7CNZf26zq/TQ
 HOTu/LASVA7TI1hj02aCJ434jdeYORf3MHcilUut8ohkInXIvSVvt94Gylay2b/bOZml
 4IlS6Y8nOlw9ntAAcmOiwV+Zw+7iDvAnpby0NF0X/xtgLVVW1GZYTMdx1e1Les71eFP8
 0FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZN45wNhpGZsLu7yaSFSio7NjmK67W30L5fYUGshtYQU=;
 b=sha3lOVAOfIZJlkSPt2T8YyHvB3Ws9ziTO5MMbOcar3YwynhmByrwEJRBqNZLGOcFQ
 6AhB7pRufH10NWeKrg1PeyYcO7f8vLKT8CTFBllFUgDdV2IjAzk6OiVyHXf7f9/vc++W
 j/XRK5tWLqGlb+6NC9Dv1vZ4u0mLKNbX3yK1MnnP60NBHRyB+fcFXNm0HOv0Fawa7qyy
 P1zbKgjpuxdVRtJ1LKowirDtGZTXJWjDpMIdnbFKVxWpHRVIbmtEq/h+GlAb3MHlf1rv
 g/dskEtY0KuEuPSDcKnQ1SYo5UFcxGLfUwNgruqsbVNW4JDgqBk5vkHrWpiWewfgMbg1
 By/A==
X-Gm-Message-State: ANhLgQ1zIbDFtb25WvKSXsuPTlscqzWR7LpW9mAPXk4l1eIM03N3l/LB
 U0V0WmdX0FcCR5UTw1uuCFMdbeSV7JrvOfH865w=
X-Google-Smtp-Source: ADFU+vt/SHSmS2iDs430K9sESUkRn+bB0LEKWrDZpDzXbeKXCrgGyfozpa+pexrLv9DTSQR5eqzKjFXOw3BNbJjYWUQ=
X-Received: by 2002:a02:caa8:: with SMTP id e8mr17026121jap.126.1583782722587; 
 Mon, 09 Mar 2020 12:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
 <CAFEAcA_6Lm-JwbXFLWeetc7+fhnrc5m2+YU28ymFw0MSoKOhwg@mail.gmail.com>
In-Reply-To: <CAFEAcA_6Lm-JwbXFLWeetc7+fhnrc5m2+YU28ymFw0MSoKOhwg@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 9 Mar 2020 20:38:31 +0100
Message-ID: <CAPan3Wo2Nf_d4AxsV5=sfOxv66rmQNfN==rpMn9=FtM5cZG9rw@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000094d1db05a071269a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000094d1db05a071269a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,


On Mon, Mar 9, 2020 at 12:22 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Wed, 4 Mar 2020 at 20:55, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
> >
> > Hello Alex,
> >
> > On Wed, Mar 4, 2020 at 11:35 AM Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
> wrote:
> >>
> >>
> >> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
> >> > ---
> >> >  docs/orangepi.rst | 226
> >> > ++++++++++++++++++++++++++++++++++++++++++++++
> >>
> >> I suspect there is a better place to put this is than the top level. I
> >> wonder if it should be docs/specs?
> >
> >
> > Yeah I'm fine to move it to a different subdirectory if needed. Right
> now its placed in docs,
> > as it seems that documents for machines are also placed there, for
> example docs/microvm.rst
>
> The only things in the top level docs/ are a handful of
> legacy-ish files that went there because we didn't yet have
> a better place to put them. We should avoid increasing the
> number of orphan files in the top level (and indeed should
> try to move the existing orphans elsewhere).
>
> >> When Peter's document PR goes in later this week there will also be a:
> >>
> >>   docs/system/target-arm.rst
> >>
> >> which would benefit from a section for the Orange Pi in it.
>
> Yes, this is now the right place to put arm board-specific
> documentation (the rearranging and conversion from texinfo
> is now in master). I should move microvm.rst's contents there
> I guess.
>

OK, I'll move orangepi.rst to docs/system/orangepi.rst and add a short
section
about the Orange Pi PC machine to docs/system/target-arm.rst as well.

Regards,
Niek



>
> thanks
> -- PMM
>


--=20
Niek Linnenbank

--00000000000094d1db05a071269a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Peter,</div><div><br></div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Mar 9, 2020 at 12:22 PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell=
@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Wed, 4 Mar 2020 at 20:55, Niek Linn=
enbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">ni=
eklinnenbank@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello Alex,<br>
&gt;<br>
&gt; On Wed, Mar 4, 2020 at 11:35 AM Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; w=
rote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" ta=
rget=3D"_blank">nieklinnenbank@gmail.com</a>&gt; writes:<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 docs/orangepi.rst | 226<br>
&gt;&gt; &gt; ++++++++++++++++++++++++++++++++++++++++++++++<br>
&gt;&gt;<br>
&gt;&gt; I suspect there is a better place to put this is than the top leve=
l. I<br>
&gt;&gt; wonder if it should be docs/specs?<br>
&gt;<br>
&gt;<br>
&gt; Yeah I&#39;m fine to move it to a different subdirectory if needed. Ri=
ght now its placed in docs,<br>
&gt; as it seems that documents for machines are also placed there, for exa=
mple docs/microvm.rst<br>
<br>
The only things in the top level docs/ are a handful of<br>
legacy-ish files that went there because we didn&#39;t yet have<br>
a better place to put them. We should avoid increasing the<br>
number of orphan files in the top level (and indeed should<br>
try to move the existing orphans elsewhere).<br>
<br>
&gt;&gt; When Peter&#39;s document PR goes in later this week there will al=
so be a:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0docs/system/target-arm.rst<br>
&gt;&gt;<br>
&gt;&gt; which would benefit from a section for the Orange Pi in it.<br>
<br>
Yes, this is now the right place to put arm board-specific<br>
documentation (the rearranging and conversion from texinfo<br>
is now in master). I should move microvm.rst&#39;s contents there<br>
I guess.<br></blockquote><div><br></div><div>OK, I&#39;ll move orangepi.rst=
 to docs/system/orangepi.rst and add a short section</div><div>about the Or=
ange Pi PC machine to docs/system/target-arm.rst as well.</div><div><br></d=
iv><div>Regards,</div><div>Niek<br></div><div><br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000094d1db05a071269a--

