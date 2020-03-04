Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA34C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B63D24679
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5DufMVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B63D24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Z0y-0006qI-E4
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 13:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j9Yzu-0005U1-Cl
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j9Yzs-0006c8-Vc
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:43:58 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133]:42109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j9Yzs-0006Xg-Kl; Wed, 04 Mar 2020 13:43:56 -0500
Received: by mail-lf1-x133.google.com with SMTP id t21so2366462lfe.9;
 Wed, 04 Mar 2020 10:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=DYiu37dwsk21hL7lcAPw7i5jgwAjbcKdoNnsujluBro=;
 b=c5DufMVUbtzoM2CNM0S1Xuae+k/CZhUGvfezPeEz0zzoFni3dIunngqvrZ0coEMlDa
 L5FLjA2ZiMr6KFRukmqkDePMZJatOloGZYhcqWg+PI9V42kOQiDuBMyG47wk2jRfCYwg
 97DL/0FCRtOvxzVqqH2WMQsPNK60m+CHZprlfG1/yCg8lXjJPdPEXp4Ri13o/yIatwgP
 XQqh7tGp7wnDSnx+ZSwkzySuk/tPYdthf/9CX5Gl3jqLtM6CQfNUt0j2r+2E2b++HK2h
 hFQECW8P9ZFWYegEiDmzUUP5WL74QdXBGrfIFKpwhpt9snm0+nAEGm9fqNfY10Q6qo7b
 BSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=DYiu37dwsk21hL7lcAPw7i5jgwAjbcKdoNnsujluBro=;
 b=OODFgdcCun5eM8DNDMzPwNSQnG9zZOM8g6TIKGGi1YQ7Xph0jYMtR2aNUY6TkSgqkF
 KPZTpQab+V8XHgUpEKDG92rBSX85imst7ca75R1r6WOXUh9JA5TvsyILJZF/siUdtpNb
 4j7WyiFDgTBZHP9/R9bMS18egaxCzIE+f9qevO4sCx+tIU8HYESmmuFNZpN49tR/QuY8
 yIVX8xOP1Fcv8I+hnjDUyvU/xDKpxp9fINbihRYN0IbXwG7WCMjohifELPlHonBZDzOt
 q3okTKCk6ka6eXeZ0m3t2LYMGu4/jjm/lDagrnrTe+ueh95Tk3bBwyI3SRyoVghaDf4I
 dXqg==
X-Gm-Message-State: ANhLgQ1OilBiIOOBpa7kzf1DR80Xwf3hFshNvqdx/XOl5DTMRIy8i+wd
 7dXQNgDJSRAj7Yk9NsEZSh2eoBRE205BxJEYxaA=
X-Google-Smtp-Source: ADFU+vtmY0vSOUPfMefj9S93lzD9Ln5TIkBjUEfJWGG7pAqabkb4psq+D8D2WWrWtBlZrtfDmXjvAwJgkfMG0JRbm00=
X-Received: by 2002:ac2:532f:: with SMTP id f15mr2769085lfh.3.1583347434048;
 Wed, 04 Mar 2020 10:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>
 <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
 <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87eeuhxw0y.fsf@linaro.org>
 <CAL1e-=gGsEV4_a4gJr2x0L3r_UK7isnpjOWoJRCDhqpG_XT3Ww@mail.gmail.com>
 <CAKyx-3MCENJREWm0BxO3ES9sDB04KV3FzYoVFKK20Fh_iwh7wg@mail.gmail.com>
 <878skpxltm.fsf@linaro.org> <FE03C155-E46D-4925-BA2B-FABBE2518C8C@gmail.com>
 <2576fd41-8b01-91a0-ca56-792ce65b5092@linaro.org>
 <alpine.BSF.2.22.395.2003021218180.72848@zero.eik.bme.hu>
 <d136165f-46c7-8983-9725-2b224742deef@linaro.org>
 <alpine.BSF.2.22.395.2003030002340.47473@zero.eik.bme.hu>
 <CAKyx-3Pt2qLPXWQjBwrHn-nxR-9e++TioGp4cKFC3adMN3rtiw@mail.gmail.com>
In-Reply-To: <CAKyx-3Pt2qLPXWQjBwrHn-nxR-9e++TioGp4cKFC3adMN3rtiw@mail.gmail.com>
From: G 3 <programmingkidx@gmail.com>
Date: Wed, 4 Mar 2020 13:43:41 -0500
Message-ID: <CAKyx-3OAVOvOiaWqUbVa4P35RtFS6bN0wbPuWa=6SFcB2zhL3Q@mail.gmail.com>
Subject: Fwd: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dino Papararo <skizzato73@msn.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, 
 luigi burdo <intermediadc@hotmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000005ccfe105a00bcdd7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::133
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005ccfe105a00bcdd7
Content-Type: text/plain; charset="UTF-8"

---------- Forwarded message ---------
From: G 3 <programmingkidx@gmail.com>
Date: Wed, Mar 4, 2020 at 1:35 PM
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: BALATON Zoltan <balaton@eik.bme.hu>




On Mon, Mar 2, 2020 at 6:16 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Mon, 2 Mar 2020, Richard Henderson wrote:
> > On 3/2/20 3:42 AM, BALATON Zoltan wrote:
> >>> The "hardfloat" option works (with other targets) only with ieee745
> >>> accumulative exceptions, when the most common of those exceptions,
> inexact, has
> >>> already been raised.  And thus need not be raised a second time.
> >>
> >> Why exactly it's done that way? What are the differences between IEEE FP
> >> implementations that prevents using hardfloat most of the time instead
> of only
> >> using it in some (although supposedly common) special cases?
> >
> > While it is possible to read the host's ieee exception word after the
> hardfloat
> > operation, there are two reasons that is undesirable:
> >
> > (1) It is *slow*.  So slow that it's faster to run the softfloat code
> instead.
> > I thought it would be easier to find the benchmark numbers that Emilio
> > generated when this was tested, but I can't find it.
>
> I remember those benchmarks too and this is also what the paper Alex
> referred to also confirmed. Also I've found that enabling hardfloat for
> PPC without doing anything else is slightly slower (on a recent CPU, on
> older CPUs could be even slower). Interetingly however it does give a
> speedup for vector instructions (maybe because they don't clear flags
> between each sub operation). Does that mean these vector instruction
> helpers are also buggy regarding exceptions?
>

I am all intrigued by these vector instructions. Apple was really big on
using them back in the day so programs like Quicktime and iTunes definitely
use them. I'm not sure if the PowerPC's altivec vector instructions map to
host vector instructions already, but if they don't, mapping them would
give us a huge speedup in certain places. Would anyone know if this was
already done in QEMU?

--0000000000005ccfe105a00bcdd7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">---------- Forwarded message ---------<br>From: <b class=3D=
"gmail_sendername" dir=3D"auto">G 3</b> <span dir=3D"auto">&lt;<a href=3D"m=
ailto:programmingkidx@gmail.com">programmingkidx@gmail.com</a>&gt;</span><b=
r>Date: Wed, Mar 4, 2020 at 1:35 PM<br>Subject: Re: [RFC PATCH v2] target/p=
pc: Enable hardfloat for PPC<br>To: BALATON Zoltan &lt;<a href=3D"mailto:ba=
laton@eik.bme.hu">balaton@eik.bme.hu</a>&gt;<br></div><br><br><div dir=3D"l=
tr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Mar 2, 2020 at 6:16 PM BALATON Zoltan &lt;=
<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blank">balaton@eik.bme.hu<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Mon, 2 Mar 2020, Richard Henderson wrote:<br>
&gt; On 3/2/20 3:42 AM, BALATON Zoltan wrote:<br>
&gt;&gt;&gt; The &quot;hardfloat&quot; option works (with other targets) on=
ly with ieee745<br>
&gt;&gt;&gt; accumulative exceptions, when the most common of those excepti=
ons, inexact, has<br>
&gt;&gt;&gt; already been raised.=C2=A0 And thus need not be raised a secon=
d time.<br>
&gt;&gt;<br>
&gt;&gt; Why exactly it&#39;s done that way? What are the differences betwe=
en IEEE FP<br>
&gt;&gt; implementations that prevents using hardfloat most of the time ins=
tead of only<br>
&gt;&gt; using it in some (although supposedly common) special cases?<br>
&gt;<br>
&gt; While it is possible to read the host&#39;s ieee exception word after =
the hardfloat<br>
&gt; operation, there are two reasons that is undesirable:<br>
&gt;<br>
&gt; (1) It is *slow*.=C2=A0 So slow that it&#39;s faster to run the softfl=
oat code instead.<br>
&gt; I thought it would be easier to find the benchmark numbers that Emilio=
<br>
&gt; generated when this was tested, but I can&#39;t find it.<br>
<br>
I remember those benchmarks too and this is also what the paper Alex <br>
referred to also confirmed. Also I&#39;ve found that enabling hardfloat for=
 <br>
PPC without doing anything else is slightly slower (on a recent CPU, on <br=
>
older CPUs could be even slower). Interetingly however it does give a <br>
speedup for vector instructions (maybe because they don&#39;t clear flags <=
br>
between each sub operation). Does that mean these vector instruction <br>
helpers are also buggy regarding exceptions?<br></blockquote><div><br></div=
><div>I am all intrigued by these vector instructions. Apple was really big=
 on using them back in the day so programs like Quicktime and iTunes defini=
tely use them. I&#39;m not sure if the PowerPC&#39;s altivec vector instruc=
tions map to host vector instructions already, but if they don&#39;t, mappi=
ng them would give us a huge speedup in certain places. Would anyone know i=
f this was already done in QEMU?<br></div></div></div>
</div></div>

--0000000000005ccfe105a00bcdd7--

