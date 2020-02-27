Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F27C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4E32072D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIAVlRCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4E32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7DQe-0005KZ-Jn
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 02:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7DPr-0004lr-Fq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7DPo-0007Yz-Vf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:17:03 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j7DPn-0007PH-OO; Thu, 27 Feb 2020 02:17:00 -0500
Received: by mail-oi1-x244.google.com with SMTP id c16so2334602oic.3;
 Wed, 26 Feb 2020 23:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=bSPXgZBZB7pLsEQ7y2TmFJfPU0UDlW7jSHoV2c5gBKY=;
 b=QIAVlRCq9OHCMOSpjJmnWHTj4sldQLNI4hRcsZgxdYSEFTOWDPmN8zsBauVTkQ1dzz
 MNc6Vnc9J/co3iXJk8zgJGABzfpsR1S3CyBADVHIKvQsFhvwnBy2LTUD52xo1B0KfpGD
 EREAE76taQumZrRgW/At3KrcLDKWN0H/rMTNvaHosH02Leo02u5L/PPE0t2sQbU2V64N
 IzxKnyPYWK8exw+lobq7oiXBc47LKwTtz3ra1Qwi5dA3Q88oYeMV4nR5papTEFdIqGgf
 IfihFot9nqtOLloLvtfDw4nsZRKMUJeM0hN1SGresGfbtyocJphkTQ9YYNVPOasZSltz
 08pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=bSPXgZBZB7pLsEQ7y2TmFJfPU0UDlW7jSHoV2c5gBKY=;
 b=oTTiRKGHVehQqgVrI83EgPMKROT51OQgYtg37g+JTpJmHrJehvubwaI0sH9/aAsRK/
 +kIbm3xi68zOyUkZgsg6crnyLFT2CY06RKxiawlfoQqcPaeeIQR5wYiQaNXyXmoLBZJ/
 9QRaU/ld27VZlZsAdh1hPSLZFoiVAhPC2WhLdZuJauArK3UYJtLwTNGwREeXhPhQmtcg
 2/ymzWL5t5btcogoy9tiLZbt936i4oZbAZPe7YiRY6aqrxG8aULmLK6eASfeO6XyAHAv
 RpPpNuTzhMKj6OzIre+PLEWJKGxKF4Hd44vMh5U7absfpqiMqUyOiyu7aKX6A4ccHY3h
 L3Nw==
X-Gm-Message-State: APjAAAWHymP9MkYAPd3Zth4JSoL6DIviaZFZuWXCXVgpcVIWBgKpObYC
 pq6CXWCtF9U3QCjuMAuKDvifzrgIpv3npUdmopg=
X-Google-Smtp-Source: APXvYqw6LD8mC8imbCTLMyJi9sgdOXqtwcGjTnX84eXYTLP1pMbVcH7hUPIuwRLBxeMIqzYVfDAl1yHObknIN638WYk=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr2139927oih.79.1582787818691; 
 Wed, 26 Feb 2020 23:16:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 26 Feb 2020 23:16:58 -0800 (PST)
In-Reply-To: <2126C4B4-B0F2-4B0F-ADEC-211466989E36@gmail.com>
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
 <CAL1e-=hhhw4x4H24DWg6pTp9DmjyfwM6GFMOmWasKC66x5tR4Q@mail.gmail.com>
 <2126C4B4-B0F2-4B0F-ADEC-211466989E36@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 27 Feb 2020 08:16:58 +0100
Message-ID: <CAL1e-=iK1NEOr=ZRBm9XtJw7Mn_23w1ra74e3yDGbfKPVTA9zw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: Programmingkid <programmingkidx@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b01ed5059f898186"
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 Dino Papararo <skizzato73@msn.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b01ed5059f898186
Content-Type: text/plain; charset="UTF-8"

On Thursday, February 27, 2020, Programmingkid <programmingkidx@gmail.com>
wrote:

>
> > On Feb 26, 2020, at 12:27 PM, Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
> >
> > On Wed, Feb 26, 2020 at 6:04 PM G 3 <programmingkidx@gmail.com> wrote:
> >>
> >> Accuracy is an important part of the IEEE 754 floating point standard.
> The whole purpose of this standard is to ensure floating point calculations
> are consistent across multiple CPUs. I believe referring to this patch as
> inaccurate is itself inaccurate. That gives the impression that this patch
> produces calculations that are not inline with established standards. This
> is not true. The only part of this patch that will produce incorrect values
> are the flags. There *may* be a program or two out there that depend on
> these flags, but for the majority of programs that only care about basic
> floating point arithmetic this patch will produce correct values. Currently
> the emulated PowerPC's FPU already produces wrong values for the flags.
> This patch does set the Inexact flag (which I don't like), but since I have
> never encountered any source code that cares for this flag, I can let it
> go. I think giving the user the ability to decide which option to use is
> the best thing to do.
> >>
> >
> > From the experiments described above, the patch in question changes the
> behavior
> > of applications (for example, sound is different with and without the
> > patch), which is
> > in contradiction with your claim that you "never encountered any
> > source code that
> > cares for this flag" and that "the only part of this patch that will
> > produce incorrect
> > values are the flags".
> >
> > In other words, and playing further with them:
> >
> > The claim that "referring to this patch as inaccurate is itself
> > inaccurate" is itself inaccurate.
> >
> > Best regards,
> > Aleksandar
>
> It is inaccurate to state that just because the USB audio device seems to
> play better with the hardfloat feature enabled that this changes the fact
> that I have yet to see any source code that actually reviews the flags. I
> have reviewed both the USB audio device and Apple's AppleUSBAudio class
> code and have not seen any mention of the exception flags.
>
>
I totally disagree with your using the term "hardfloat feature enabled" in
this context, speaking about this particulat patch. This may be just
wishful thinking. The right wording would be "hardfloat feature hacked", or
"hardfloat feature fooled".

The patch itself has the wrong, intentionally misleading and confusing
title from the outset. It should be something like  "target/ppc: Cheat
hardfloat feature into beleiving that inexact flag is always set"

Best regards,
Aleksabdar

--000000000000b01ed5059f898186
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, February 27, 2020, Programmingkid &lt;<a href=3D"mailt=
o:programmingkidx@gmail.com">programmingkidx@gmail.com</a>&gt; wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><br>
&gt; On Feb 26, 2020, at 12:27 PM, Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:<b=
r>
&gt; <br>
&gt; On Wed, Feb 26, 2020 at 6:04 PM G 3 &lt;<a href=3D"mailto:programmingk=
idx@gmail.com">programmingkidx@gmail.com</a>&gt; wrote:<br>
&gt;&gt; <br>
&gt;&gt; Accuracy is an important part of the IEEE 754 floating point stand=
ard. The whole purpose of this standard is to ensure floating point calcula=
tions are consistent across multiple CPUs. I believe referring to this patc=
h as inaccurate is itself inaccurate. That gives the impression that this p=
atch produces calculations that are not inline with established standards. =
This is not true. The only part of this patch that will produce incorrect v=
alues are the flags. There *may* be a program or two out there that depend =
on these flags, but for the majority of programs that only care about basic=
 floating point arithmetic this patch will produce correct values. Currentl=
y the emulated PowerPC&#39;s FPU already produces wrong values for the flag=
s. This patch does set the Inexact flag (which I don&#39;t like), but since=
 I have never encountered any source code that cares for this flag, I can l=
et it go. I think giving the user the ability to decide which option to use=
 is the best thing to do.<br>
&gt;&gt; <br>
&gt; <br>
&gt; From the experiments described above, the patch in question changes th=
e behavior<br>
&gt; of applications (for example, sound is different with and without the<=
br>
&gt; patch), which is<br>
&gt; in contradiction with your claim that you &quot;never encountered any<=
br>
&gt; source code that<br>
&gt; cares for this flag&quot; and that &quot;the only part of this patch t=
hat will<br>
&gt; produce incorrect<br>
&gt; values are the flags&quot;.<br>
&gt; <br>
&gt; In other words, and playing further with them:<br>
&gt; <br>
&gt; The claim that &quot;referring to this patch as inaccurate is itself<b=
r>
&gt; inaccurate&quot; is itself inaccurate.<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Aleksandar<br>
<br>
It is inaccurate to state that just because the USB audio device seems to p=
lay better with the hardfloat feature enabled that this changes the fact th=
at I have yet to see any source code that actually reviews the flags. I hav=
e reviewed both the USB audio device and Apple&#39;s AppleUSBAudio class co=
de and have not seen any mention of the exception flags. <br>
<br>
</blockquote><div><br></div><div>I totally disagree with your using the ter=
m &quot;hardfloat feature enabled&quot; in this context, speaking about thi=
s particulat patch. This may be just wishful thinking. The right wording wo=
uld be &quot;hardfloat feature hacked&quot;, or &quot;hardfloat feature foo=
led&quot;.</div><div><br></div><div>The patch itself has the wrong, intenti=
onally misleading and confusing title from the outset. It should be somethi=
ng like =C2=A0&quot;target/ppc: Cheat hardfloat feature into beleiving that=
 inexact flag is always set&quot;</div><div><br></div><div>Best regards,</d=
iv><div>Aleksabdar</div><div><br></div><div><br></div><div>=C2=A0</div>

--000000000000b01ed5059f898186--

