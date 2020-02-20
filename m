Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06904C34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 05:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69A024656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 05:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALo6EFBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69A024656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4edC-0001Ms-T6
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 00:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j4ecb-0000i2-3G
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 00:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j4ecZ-0002nl-EL
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 00:43:37 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1j4ecU-0002lV-Oe; Thu, 20 Feb 2020 00:43:30 -0500
Received: by mail-ot1-x341.google.com with SMTP id 77so2569196oty.6;
 Wed, 19 Feb 2020 21:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K9bC3NaZCTcev60UV2PMeKYRdafUok1hs8UpWCqY4Qk=;
 b=ALo6EFBeQoW6VDzkkdDFhZyQmCbD7cEoaGdxXTwk9q/gCuLMPpEtTkCM34Hd2gdAg+
 ZWKd27V8oXLCjJ8zRTMCukuzWlkTVNqMTgpnJgM+9DcQZnly+Rway07RMXJ03d0Ae3wI
 1EDEYIqFmYYuJH+A8j8BFVTxPrbXZCPA2u5jTLvqcoKK4aWgUs3WsPyrI0naPNETN9lg
 cuyD7EaxsN+Fe1MPQ5dtjxE89ULDySSpg0zVCc4WA1Y6M/aHinskmK+gioVK+YvxMcTy
 XZqAAcKzCIK8NQJvz9DkmiuyqY9/2E03hB4YXaW03VVe8MWpMrDPyo9QJLff6aJ2/XVa
 5GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K9bC3NaZCTcev60UV2PMeKYRdafUok1hs8UpWCqY4Qk=;
 b=dB5GWxgqUsyd+HLyvyyPTxagFwL6J8mwgT3XIqUvsIOkeoWb1QwGQLpxDzB2gQo1fj
 vkT6TwluDOj5AzUqL/dL+xC1UF7gm6Av7uxmefeUo838e//J6RLpvMCH3v60qwK+5vkb
 cru0amEYAathyfm4qAblz1Kgg9/fnqgcfeOtBwN8FjN7Ulk6RW8JkuEG7R73kkfO6Nzo
 XrE0mkZxW4f/2rk+2UQCpIp7rTIN+YYS1hBVHwFEVFKYqgbZmR5WudUMXA/VkUbwUrST
 AlRi0NRQoVW5rJDAM1s98n3U0A6ko7/3hnySbJv7uH+xvdf/AQMkj3zzVcibtOfClqjC
 3vBQ==
X-Gm-Message-State: APjAAAU5Il38898gjwlcI2KGgxTJjxDsyHN95tASEPvWiMIcOjnKUUrN
 iLAqtZUBsQ8jsqHmKmngF5N/sW7iAmKG7rQha34=
X-Google-Smtp-Source: APXvYqxuH7ATmBKSr9HI7qgtx2hyamzF1bnskBeGwmwe9QYu1GDAl/EV3Y680HlFFbLQBrBESG4h+fgtOlh4v+EZ84k=
X-Received: by 2002:a9d:22:: with SMTP id 31mr20935730ota.173.1582177409775;
 Wed, 19 Feb 2020 21:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <CABLmASGhqbao0ngRAoHA7KBFA5CoMXLwaVh9wzv1Ec022FRjbQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2002192001540.88848@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2002192001540.88848@zero.eik.bme.hu>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 20 Feb 2020 06:43:18 +0100
Message-ID: <CABLmASHhefWbz+wdbDmL_jLi9ad6HdWbEdFGc8f8Ei+Asy2fXw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="0000000000007b3bae059efb6221"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Paul Clarke <pc@us.ibm.com>, Programmingkid <programmingkidx@gmail.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007b3bae059efb6221
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 19, 2020 at 8:28 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Wed, 19 Feb 2020, Howard Spoelstra wrote:
> > I tested with the current ppc-for-5.0 branch and with v1 of the hardfloat
> > patches applied on top of that. There is a noticeable speed improvement
> in
> > Linux and OSX hosts. Windows 10 host doesn't seem to be impressed at
> all. I
> > saw no obvious glitches so far. The fpu performance on OSX hosts seems
> very
> > slow. This was not always the case in the past, when it was on par with
> > Linux performance.
>
> Interesting, thanks for the measurements.
>
> > Below are my results.
> >
> > Best,
> > Howard
> >
> > Host Linux (Fedora 31):
> > Mac OS tests: 9.2 with MacBench 5.0
> > Baseline(100%): G3 300Mhz
> > 5.0 branch + hardfloat patches: cpu 193%, fpu 86%
> > 5.0 branch: cpu 188%, fpu 57%
>
> Here there's a difference in cpu value before and after patch which I
> can't explain (only changed FPU stuff so it should not change others) but
> also not seen in other measurements so this could be some external
> influence such as something else using CPU while running test? Unless this
> happens consistently I'd put it down to measurement error.
>

  Yes, I would put that cpu value down to some fluctuation in the test

>
> > Mac OSX tests: 10.5 with Skidmarks 4.0 test
> > Baseline(100%): G4 1.0Ghz.
> > 5.0 branch + hardfloat patches: Int:131 FP:11 Vec:15
> > 5.0 branch: Int:131 FP:9 Vec:11
> >
> > Host OSX Sierra:
> > Mac OS tests: 9.2 with MacBench 5.0
> > Baseline(100%): G3 300Mhz
> > 5.0 branch + hardfloat patches: cpu 199%, fpu 66%
> > 5.0 branch: cpu 199%, fpu 40%
> > Mac OSX tests: 10.5 with Skidmarks 4.0 test
> > Baseline(100%): G4 1.0Ghz.
> > 5.0 branch + hardfloat patches: Int:129 PF:11 Vec:14
>
> These values seem to match Linux measurement above so don't seem slower
> although MacOS9 seems to be slower (66 vs. 86) so either this depends on
> the ops used or something else.
>

 Yes, the baseline speed for the fpu in Mac OS 9.2 is relatively low.

>
> > 5.0 branch: Int:129 FP:8 Vec:9
> >
> > Host Windows 10:
> > Mac OS tests: 9.2 with MacBench 5.0
> > Baseline(100%): G3 300Mhz
> > 5.0 branch + hardfloat patches: cpu 180%, fpu 54%
>

 new run 5.0 branch + hardfloat patches: cpu 184%, fpu 54%

> 5.0 branch: cpu 199%, fpu 40%
>

 new run 5.0 branch: cpu 184%, fpu 56%

It seems I misreported (copy/past without changing the values) the earlier
Windows-based results with Mac OS 9.2 guest. As said above (and this now
seems to confirm) Windows is not impressed at all and perhaps a bit slower
even.
Windows builds are particularly sensitive to any other activity on the
system. Moving the qemu window drops performance considerably. Perhaps due
to SDL not running in its own thread?

>
> Here there's again difference in cpu value but the other way so maybe if
> the cause is external CPU usage then this again may be an outlying
> measurement? You could retake these two to verify if you get same numbers
> again. The fpu value does seem to improve just not as much as the others
> and it's also lower to start with. I wonder why.
>


> > Mac OSX tests: 10.5 with Skidmarks 4.0 test
> > Baseline(100%): G4 1.0Ghz.
> > 5.0 branch + hardfloat patches: Int:130 FP:9 Vec:10
> > 5.0 branch: Int:130 FP:10 Vec:11
> >
> > All tests done on the same host with v1 of the hardfloat patches
> > Intel i7-4770K at 3.50Ghz. 32Gb memory
> > All guests set to 1024x768 and "thousands" of colors.
>
> Does it mean this host machine were rebooted into these OSes or these were
> run in a VM. In case using VM, were all three running in VM or one was on
> host (I'd guess OSX host with Linux and Windows VMs).
>
> > Linux and OSX (with brew) use default compilers.
> > Windows build cross-compiled from Fedora with x86_64-win64-mingw32
>
> I assume Linux and OSX were 64 bit builds, is Windows 32 bit or 64 bit
> exe?
>

No virtualisation. I run all on the same bare metal, so booted into these
three separately from separate SSDs. You might guess OSX Sierra is running
on less "official" hardware and you would be right. All qemu builds were 64
bit.

Best,
Howard

--0000000000007b3bae059efb6221
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 19, 2020 at 8:28 PM BALAT=
ON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On We=
d, 19 Feb 2020, Howard Spoelstra wrote:<br>
&gt; I tested with the current ppc-for-5.0 branch and with v1 of the hardfl=
oat<br>
&gt; patches applied on top of that. There is a noticeable speed improvemen=
t in<br>
&gt; Linux and OSX hosts. Windows 10 host doesn&#39;t seem to be impressed =
at all. I<br>
&gt; saw no obvious glitches so far. The fpu performance on OSX hosts seems=
 very<br>
&gt; slow. This was not always the case in the past, when it was on par wit=
h<br>
&gt; Linux performance.<br>
<br>
Interesting, thanks for the measurements.<br>
<br>
&gt; Below are my results.<br>
&gt;<br>
&gt; Best,<br>
&gt; Howard<br>
&gt;<br>
&gt; Host Linux (Fedora 31):<br>
&gt; Mac OS tests: 9.2 with MacBench 5.0<br>
&gt; Baseline(100%): G3 300Mhz<br>
&gt; 5.0 branch + hardfloat patches: cpu 193%, fpu 86%<br>
&gt; 5.0 branch: cpu 188%, fpu 57%<br>
<br>
Here there&#39;s a difference in cpu value before and after patch which I <=
br>
can&#39;t explain (only changed FPU stuff so it should not change others) b=
ut <br>
also not seen in other measurements so this could be some external <br>
influence such as something else using CPU while running test? Unless this =
<br>
happens consistently I&#39;d put it down to measurement error.<br></blockqu=
ote><div><br></div><div>=C2=A0 Yes, I would put that cpu value down to some=
 fluctuation in the test</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; Mac OSX tests: 10.5 with Skidmarks 4.0 test<br>
&gt; Baseline(100%): G4 1.0Ghz.<br>
&gt; 5.0 branch + hardfloat patches: Int:131 FP:11 Vec:15<br>
&gt; 5.0 branch: Int:131 FP:9 Vec:11<br>
&gt;<br>
&gt; Host OSX Sierra:<br>
&gt; Mac OS tests: 9.2 with MacBench 5.0<br>
&gt; Baseline(100%): G3 300Mhz<br>
&gt; 5.0 branch + hardfloat patches: cpu 199%, fpu 66%<br>
&gt; 5.0 branch: cpu 199%, fpu 40%<br>
&gt; Mac OSX tests: 10.5 with Skidmarks 4.0 test<br>
&gt; Baseline(100%): G4 1.0Ghz.<br>
&gt; 5.0 branch + hardfloat patches: Int:129 PF:11 Vec:14<br>
<br>
These values seem to match Linux measurement above so don&#39;t seem slower=
 <br>
although MacOS9 seems to be slower (66 vs. 86) so either this depends on <b=
r>
the ops used or something else.<br></blockquote><div><br></div><div>=C2=A0Y=
es, the baseline speed for the fpu in Mac OS 9.2 is relatively low.=C2=A0 <=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; 5.0 branch: Int:129 FP:8 Vec:9<br>
&gt;<br>
&gt; Host Windows 10:<br>
&gt; Mac OS tests: 9.2 with MacBench 5.0<br>
&gt; Baseline(100%): G3 300Mhz<br>
&gt; 5.0 branch + hardfloat patches: cpu 180%, fpu 54%<br></blockquote><div=
><br></div><div>=C2=A0new run
5.0 branch + hardfloat patches: cpu 184%, fpu 54%</div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
&gt; 5.0 branch: cpu 199%, fpu 40%<br></blockquote><div><br></div><div>=C2=
=A0new run
5.0 branch: cpu 184%, fpu 56% <br></div><div><br></div><div>It seems I misr=
eported (copy/past without changing the values) the earlier Windows-based r=
esults with Mac OS 9.2=20
guest. As said above (and this now seems to confirm) Windows is not impress=
ed at=20
all and perhaps a bit slower even. <br></div><div>Windows builds are partic=
ularly sensitive to any other activity on the system. Moving the qemu windo=
w drops performance considerably. Perhaps due to SDL not running in its own=
 thread?<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Here there&#39;s again difference in cpu value but the other way so maybe i=
f <br>
the cause is external CPU usage then this again may be an outlying <br>
measurement? You could retake these two to verify if you get same numbers <=
br>
again. The fpu value does seem to improve just not as much as the others <b=
r>
and it&#39;s also lower to start with. I wonder why.<br></blockquote><br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Mac OSX tests: 10.5 with Skidmarks 4.0 test<br>
&gt; Baseline(100%): G4 1.0Ghz.<br>
&gt; 5.0 branch + hardfloat patches: Int:130 FP:9 Vec:10<br>
&gt; 5.0 branch: Int:130 FP:10 Vec:11<br>
&gt;<br>
&gt; All tests done on the same host with v1 of the hardfloat patches<br>
&gt; Intel i7-4770K at 3.50Ghz. 32Gb memory<br>
&gt; All guests set to 1024x768 and &quot;thousands&quot; of colors.<br>
<br>
Does it mean this host machine were rebooted into these OSes or these were =
<br>
run in a VM. In case using VM, were all three running in VM or one was on <=
br>
host (I&#39;d guess OSX host with Linux and Windows VMs).<br>
<br>
&gt; Linux and OSX (with brew) use default compilers.<br>
&gt; Windows build cross-compiled from Fedora with x86_64-win64-mingw32<br>
<br>
I assume Linux and OSX were 64 bit builds, is Windows 32 bit or 64 bit <br>
exe?<br></blockquote><div>=C2=A0</div><div>No virtualisation. I run all on =
the same bare metal, so booted into=20
these three separately from separate SSDs. You might guess OSX Sierra is
 running on less &quot;official&quot; hardware and you would be right. All =
qemu=20
builds were 64 bit.</div><div><br></div><div>Best,</div><div>Howard<br></di=
v></div></div>

--0000000000007b3bae059efb6221--

