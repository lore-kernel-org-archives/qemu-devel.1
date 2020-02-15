Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E78C352A3
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 21:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC532084E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 21:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjhZCIl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC532084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j34b4-0002bH-Vf
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 16:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j34ZI-0001Sn-K4
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 16:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j34ZG-0003fk-4r
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 16:01:40 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j34ZF-0003f6-VU
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 16:01:38 -0500
Received: by mail-ot1-x342.google.com with SMTP id j16so12549867otl.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zjckl4DfQQHgHbuH63bPHYS3aV6obTSxeeuSjhnEhjQ=;
 b=qjhZCIl9mB5SRzheTH4b/LtilUoc0HydEW0NC+wwqpze0nMO2puMZ6IbiILFPf4ulq
 89U53dduqhdHCEq1pqizk0mIkv3Y/iEGao2mIV/C7F5KxiGnDNc/iLyu3AWpGXvFpvBZ
 wX6EKU37nQOftv5CaCJq6TJNzA0CoSSWVd9QmcDJyWJ0rsz1oUj0H6od1u6XnKSocJrL
 nd/WAgGf6ZknycyGywr4sFSTB9gGeqhBE7Czm89xeRqGkO2QYGpeRed3AIvFLa4GBODd
 TJdzFwHDMRmwfrhueCaKPOhLO/kxQ3tgGdfg/g8rqmQ9Zoxi8epaABknrjoyVAdmdG3z
 39Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zjckl4DfQQHgHbuH63bPHYS3aV6obTSxeeuSjhnEhjQ=;
 b=HWEuV+6wwJd7NnULjEXkJx1aXjr8AOHmYaLWpDLFa4c9eZaNyfgwn8e/2ez2Li0Ii3
 w1l7TLm4e43ZUgv5KBGkV3KJlaCO0fLx9m0u9n2l8+2FuZUJNhFZP+QBs7Iyeq7pm2jf
 zGkHgedUOCGzciUF3rNejdQUNs9gT0SpFKc6QVe5ckhWuH4FxJ9GWcFh7KLczy37zVEC
 5yNFiw+8xn6hKcdHsY4THTrLR4Lv03FRcjCMHcIbqYZWdz0QqIFaPhEJCteLQ17xiDjB
 dO4Tc1L1g5a33nQQaZtTFcaebF44c5dhhFLmgoR78sFJjYeCH4FRQnxx1VW5ujCK8aaG
 vm5A==
X-Gm-Message-State: APjAAAXEWMylsS0AS4oehUrHZ1BRL8uDRS7xQg7TwN3CCdNFMVw8M1CI
 xevefBPIEusQTqHqqEoDsSmepFIIZ3Sb71lbkiQ=
X-Google-Smtp-Source: APXvYqyqqgxSEmJSaAiifwLrXokRMNR/jQ4CIYXaidRHLLqWPaYljuL3Pi6JjpK0v1bLwSkDCYfhDRuQYKTCRE4HynQ=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr6635803otb.121.1581800496826; 
 Sat, 15 Feb 2020 13:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-8-peter.maydell@linaro.org>
 <CAL1e-=iWXDGat9dVwNEKU1JUYTz1vc-wr2f1pTNiHP-e6zpPbA@mail.gmail.com>
 <CAAdtpL6JHhgPJOdwrMxs83qc8=9Q-1t6mrA0yJiyPjMkHSw3Lg@mail.gmail.com>
In-Reply-To: <CAAdtpL6JHhgPJOdwrMxs83qc8=9Q-1t6mrA0yJiyPjMkHSw3Lg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 15 Feb 2020 22:01:19 +0100
Message-ID: <CAL1e-=hgrANvvPd2oaOUTf+3EuudcsZeBtj1yOCK4Pn37nxOJg@mail.gmail.com>
Subject: Re: [PATCH v2 07/30] qapi/block-core.json: Use literal block for
 ascii art
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Content-Type: multipart/alternative; boundary="000000000000b80bc6059ea3a0a3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b80bc6059ea3a0a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

9:56 PM Sub, 15.02.2020. Philippe Mathieu-Daud=C3=A9 <philippe@mathieu-daud=
e.net>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi Aleksandar,
>
> On Fri, Feb 14, 2020 at 12:04 AM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> > 6:59 PM =C4=8Cet, 13.02.2020. Peter Maydell <peter.maydell@linaro.org> =
=D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > The ascii-art graph
> >
> > Just out of couriousity, are unicode characters allowed in rst files?
>
> I remember 2 years ago a blind developer thanked the QEMU community to
> still restrict commits to 80 characters, because while 4K display are
> available, he and other visually impaired developers cloud still
> browse the QEMU codebase with their refreshable Braille display (which
> was 80 cels). I don't know how many visually impaired developers are
> following this project. A quick google returns " There is no concept
> of Unicode in Braille. In that sense Braille is similar to old 8-bit
> code pages which represented different symbols in different languages
> for the same symbol code."
> (
https://superuser.com/questions/629443/represent-unicode-characters-in-brai=
lle
).
>
> (I'm Cc'ing Samuel who cares about Braille displays.)
>

Got it.
> >
> > The boxes could've been rendered in a much more beautifull way using
"lines and corners" group of unicode characters.
> >
> > Aleksandar

--000000000000b80bc6059ea3a0a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">9:56 PM Sub, 15.02.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:philippe@mathieu-daude.net">philippe@mathieu-daude.net</a>&g=
t; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br=
>
&gt;<br>
&gt; Hi Aleksandar,<br>
&gt;<br>
&gt; On Fri, Feb 14, 2020 at 12:04 AM Aleksandar Markovic<br>
&gt; &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@g=
mail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; 6:59 PM =C4=8Cet, 13.02.2020. Peter Maydell &lt;<a href=3D"mailto=
:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The ascii-art graph<br>
&gt; &gt;<br>
&gt; &gt; Just out of couriousity, are unicode characters allowed in rst fi=
les?<br>
&gt;<br>
&gt; I remember 2 years ago a blind developer thanked the QEMU community to=
<br>
&gt; still restrict commits to 80 characters, because while 4K display are<=
br>
&gt; available, he and other visually impaired developers cloud still<br>
&gt; browse the QEMU codebase with their refreshable Braille display (which=
<br>
&gt; was 80 cels). I don&#39;t know how many visually impaired developers a=
re<br>
&gt; following this project. A quick google returns &quot; There is no conc=
ept<br>
&gt; of Unicode in Braille. In that sense Braille is similar to old 8-bit<b=
r>
&gt; code pages which represented different symbols in different languages<=
br>
&gt; for the same symbol code.&quot;<br>
&gt; (<a href=3D"https://superuser.com/questions/629443/represent-unicode-c=
haracters-in-braille">https://superuser.com/questions/629443/represent-unic=
ode-characters-in-braille</a>).<br>
&gt;<br>
&gt; (I&#39;m Cc&#39;ing Samuel who cares about Braille displays.)<br>
&gt;</p>
<p dir=3D"ltr">Got it. <br>
&gt; &gt;<br>
&gt; &gt; The boxes could&#39;ve been rendered in a much more beautifull wa=
y using &quot;lines and corners&quot; group of unicode characters.<br>
&gt; &gt;<br>
&gt; &gt; Aleksandar<br>
</p>

--000000000000b80bc6059ea3a0a3--

