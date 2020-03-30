Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF602C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844902072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R95yEtJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844902072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIzgb-0006yF-JY
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 15:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jIzfl-0006Wr-Tz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jIzfj-0007BG-G7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:02:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jIzfj-0007AU-7O
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:02:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id c81so21115683wmd.4
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XrSDrH4olG4b8eAR2aRY5/QzW3wAYMJixM0FVXyofFI=;
 b=R95yEtJG365LnOHLMb2DizDVYmoIOIEdejGkP+q9gZpmviYs/lfiQCzIEjNeejWjtB
 DazO3KB1qsN6TmfED8RZe0ICgx7bHCSe4w9dQ5uH0IBXxLSMlJzatVwzDuvV7ThQONbO
 DYhd2i3cp/GbkEnfJ8FsHnAdQbnMULPTu/OzMaclOAUfHvNMmRf+jV30l/3wC9CxoSOO
 K9mOQlUTPrfwwoEWulfOyi0wV1gVq7p+i3p8mbEIZbNYlcL/mSl5SootMuTb8lPj62br
 8mf0eKYfrcwiN4Xx4WuP9Trgy0uUg+nDpk3hVR5PXJKZYmzGgAol0JconnBFT6suIVQY
 3wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XrSDrH4olG4b8eAR2aRY5/QzW3wAYMJixM0FVXyofFI=;
 b=L23Z68NKTHrk7RuVg1tEcVirzvyOcilVkEpa9TI/+0p7mnh7th8eDx0TzY3fi4yahZ
 OZ2WVnNVxltxbMTzIOsYvR9Fxm9YG64t4fceHjp2GPilDdb37gAWblhl+RMb4u2o9h7U
 sYrLSKiLv2cqm/mrM4CsE3K+iuPMGk9I/Jp8PGSRC84lt0VqmhwyDV+ZOKlWHjiSu/fD
 DbwK+aRnLvcNTEK0w/0FKFUALQ7QNy2ScnqE7H6fr7Awjn5S90O2QPrTPTYybyk66h9k
 F9sDk7tNcXsSojoYdmlvi44ADpiW8P4edEwT9wZWK4ig8/KnK/tFpgHE0ry4fW8dLb0w
 6Wcg==
X-Gm-Message-State: ANhLgQ230na2pcmbeB6vVnYq+EX+33/Wpd++ksktAvFkFfmm0QVQbHoe
 ymvMS30MwdQQxCcoMugzS/xLIacISqTtImndDe4=
X-Google-Smtp-Source: ADFU+vv8/JxZGx3Xc+iiLDvBng9jm6yXsfBjhkORtoMG6Ofpk7/QUVaf1pSdOH/LAzs9bHD5Dyfr/AynusbZIQhPaWA=
X-Received: by 2002:a1c:f407:: with SMTP id z7mr716366wma.36.1585594926062;
 Mon, 30 Mar 2020 12:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
 <39c28108-5d85-d611-c2ea-abbbf913b981@redhat.com>
 <1B369970-E78B-4A05-A80E-D7AB527E3A4E@flygoat.com>
 <bbf10da2-76ee-a4c6-275d-fa1c8fc59e1e@redhat.com>
 <80698310-CBFC-4D65-826D-3F7AA038B126@flygoat.com>
In-Reply-To: <80698310-CBFC-4D65-826D-3F7AA038B126@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 30 Mar 2020 21:01:46 +0200
Message-ID: <CAHiYmc4J5HsP2s1kgtsyS4xjQ2_o1D3mi0GSsH6Ft28DOAHp=w@mail.gmail.com>
Subject: Re: [PATCH for-5.0, v1] target/mips: Fix loongson multimedia
 condition instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="0000000000005360c905a21716ff"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: richard.henderson@linaro.org, QEMU Developers <qemu-devel@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>, aleksandar.rikalo@rt-rk.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005360c905a21716ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

18:31 Pon, 30.03.2020. Jiaxun Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
>
> =E4=BA=8E 2020=E5=B9=B43=E6=9C=8831=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=88=
12:22:43, "Philippe Mathieu-Daud=C3=A9" <
philmd@redhat.com> =E5=86=99=E5=88=B0:
> >On 3/30/20 6:18 PM, Jiaxun Yang wrote:
> >>
> >>
> >> =E4=BA=8E 2020=E5=B9=B43=E6=9C=8830=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=8811:39:44, "Philippe Mathieu-Daud=C3=A9"
> ><philmd@redhat.com> =E5=86=99=E5=88=B0:
> >>> Hi Jiaxun Yang,
> >>>
> >>> On 3/24/20 1:22 PM, Jiaxun Yang wrote:
> >>>> Loongson multimedia condition instructions were previously
> >>> implemented as
> >>>> write 0 to rd due to lack of documentation. So I just confirmed
> >with
> >>> Loongson
> >>>> about their encoding and implemented them correctly.
> >>>
> >>> If you have a binary using loongson multimedia instructions, can you
> >>> add
> >>> a test? So this code won't bitrot.
> >>
> >> I know ffmpeg uses it.
> >> But I think that's too fat.
> >
> >Looks perfect to me!
> >
> >It'll be simpler if you use a pre-build binary from a known
> >distribution.
>
> Unfortunately none of the distribution built ffmpeg with loongson insns
enabled,
> as it can't be enabled at runtime.
>
> I'll try that after fulfill Loongson Extensions in  QEMU.
>
> FFmpeg do use some other Loongson insns despite mmi.
>
> There are still 15+ instructions for me to work.
>

Jiaxun, hi.

My advice is to think about integrating Loongson-relared test into QEMU "in
background", with the intention that you possibly develop them later on.

Let's focus first on the code you want to add to enhance core
Loongson-related QEMU features, and we'll help you later on about Loongton
tests that could also be added to QEMU upstream.

I am sure you have some informal tests for all code you develop, but there
is a long way from these tests to the test that can be integrated in QEMU
upetream.

Just for reference, and something for you to think about in breaks between
real coding:

Basically, in QEMU, there are several kind of tests you could have in mind:

1) Unit tests yhat typically test emulation of just a single instruction
(see /tests/tcg/mips/user/ase/msa for example);

2) Acceptance test that test boot/shutdown and possibly other features of
virtual machines prepared in advance (kernel, rootfs, etc.), residing in
test/acceptance;

3) Tests that may use tests made for libraries and applicstions that use
the functionality of your newly-added features;

4) Other test that you may devise by your own and think are usefull and
make sense.

But again, let's focus and show us the main body of your code (as you
already started doing), let's start from there, and see how is it going and
what happens.

Thanks again for your work so far!

Yours,
Aleksandar

> Thanks
> --
> Jiaxun Yang

--0000000000005360c905a21716ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">18:31 Pon, 30.03.2020. Jiaxun Yang &lt;<a href=3D"mailto:jia=
xun.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =E4=BA=8E 2020=E5=B9=B43=E6=9C=8831=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=
=8812:22:43, &quot;Philippe Mathieu-Daud=C3=A9&quot; &lt;<a href=3D"mailto:=
philmd@redhat.com">philmd@redhat.com</a>&gt; =E5=86=99=E5=88=B0:<br>
&gt; &gt;On 3/30/20 6:18 PM, Jiaxun Yang wrote:<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; =E4=BA=8E 2020=E5=B9=B43=E6=9C=8830=E6=97=A5 GMT+08:00 =E4=B8=
=8B=E5=8D=8811:39:44, &quot;Philippe Mathieu-Daud=C3=A9&quot;<br>
&gt; &gt;&lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt;=
 =E5=86=99=E5=88=B0:<br>
&gt; &gt;&gt;&gt; Hi Jiaxun Yang,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On 3/24/20 1:22 PM, Jiaxun Yang wrote:<br>
&gt; &gt;&gt;&gt;&gt; Loongson multimedia condition instructions were previ=
ously<br>
&gt; &gt;&gt;&gt; implemented as<br>
&gt; &gt;&gt;&gt;&gt; write 0 to rd due to lack of documentation. So I just=
 confirmed<br>
&gt; &gt;with<br>
&gt; &gt;&gt;&gt; Loongson<br>
&gt; &gt;&gt;&gt;&gt; about their encoding and implemented them correctly.<=
br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; If you have a binary using loongson multimedia instructio=
ns, can you<br>
&gt; &gt;&gt;&gt; add<br>
&gt; &gt;&gt;&gt; a test? So this code won&#39;t bitrot.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; I know ffmpeg uses it.<br>
&gt; &gt;&gt; But I think that&#39;s too fat.<br>
&gt; &gt;<br>
&gt; &gt;Looks perfect to me!<br>
&gt; &gt;<br>
&gt; &gt;It&#39;ll be simpler if you use a pre-build binary from a known<br=
>
&gt; &gt;distribution.<br>
&gt;<br>
&gt; Unfortunately none of the distribution built ffmpeg with loongson insn=
s enabled,<br>
&gt; as it can&#39;t be enabled at runtime.<br>
&gt;<br>
&gt; I&#39;ll try that after fulfill Loongson Extensions in=C2=A0 QEMU.<br>
&gt;<br>
&gt; FFmpeg do use some other Loongson insns despite mmi. <br>
&gt;<br>
&gt; There are still 15+ instructions for me to work.<br>
&gt;</p>
<p dir=3D"ltr">Jiaxun, hi.</p>
<p dir=3D"ltr">My advice is to think about integrating Loongson-relared tes=
t into QEMU &quot;in background&quot;, with the intention that you possibly=
 develop them later on.</p>
<p dir=3D"ltr">Let&#39;s focus first on the code you want to add to enhance=
 core Loongson-related QEMU features, and we&#39;ll help you later on about=
 Loongton tests that could also be added to QEMU upstream.</p>
<p dir=3D"ltr">I am sure you have some informal tests for all code you deve=
lop, but there is a long way from these tests to the test that can be integ=
rated in QEMU upetream.</p>
<p dir=3D"ltr">Just for reference, and something for you to think about in =
breaks between real coding:</p>
<p dir=3D"ltr">Basically, in QEMU, there are several kind of tests you coul=
d have in mind:</p>
<p dir=3D"ltr">1) Unit tests yhat typically test emulation of just a single=
 instruction (see /tests/tcg/mips/user/ase/msa for example);</p>
<p dir=3D"ltr">2) Acceptance test that test boot/shutdown and possibly othe=
r features of virtual machines prepared in advance (kernel, rootfs, etc.), =
residing in test/acceptance;</p>
<p dir=3D"ltr">3) Tests that may use tests made for libraries and applicsti=
ons that use the functionality of your newly-added features;</p>
<p dir=3D"ltr">4) Other test that you may devise by your own and think are =
usefull and make sense.</p>
<p dir=3D"ltr">But again, let&#39;s focus and show us the main body of your=
 code (as you already started doing), let&#39;s start from there, and see h=
ow is it going and what happens.</p>
<p dir=3D"ltr">Thanks again for your work so far!</p>
<p dir=3D"ltr">Yours,<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; Thanks<br>
&gt; -- <br>
&gt; Jiaxun Yang<br>
</p>

--0000000000005360c905a21716ff--

