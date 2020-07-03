Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 22:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C69820724
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 22:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/dkcjYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C69820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrUSE-0000dz-DJ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 18:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jrURc-0000DD-Ti
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 18:46:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jrURa-0007pL-To
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 18:46:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id o11so34250912wrv.9
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 15:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=EKzM/qk6u480sF77lCAcnK59HqZrj6N7sNml5oiekU4=;
 b=d/dkcjYXnIp+iGmhMoMGroWFR1TZXI75FGjE27xFK7gJRtdqHZeJsbaUDjr9Yu/kwg
 8unTaImnGTUw9mTmHhsyyUWjhtEE3BLp2/hNXj8U3eLGTju01lzJahZWTkTjACu20XCs
 AIW785C7ZBMBg1ZHwnynOgWiZISOqYXZCnRFon6t66FMSWPai1PVDVcrThd2GH4Jd/oj
 tCIcoqJG4rLxAJWYS6RD9m63YsfY8+1yw2nFA1AABL5ykvMDs7Km4i6PjMXQPu0PKi/G
 2HqZPf5NmDxy2xXUJFYSkNciaFi15VAxr71PYUxoXq1jmho3hBEGBno4z/aIAI2ZrnSD
 PfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=EKzM/qk6u480sF77lCAcnK59HqZrj6N7sNml5oiekU4=;
 b=c1jKuXOmRq9uMtiXNx/G1AHb2OIlak+IpTcPVYr8nhk1fZ7RigGADt9d19eegTnXvs
 p3ZG7JKwGK23eDyqP16M7oOUfiZX0x3RKc7awoAn1z01Nw34pqqu0Jn0Al5tWMIAEqHq
 qcxx+r7OWPcqd6JrEp6VCFKQyHVVeCsjzIoaUe2Jgf/qL91H+aG20qxp2J8uE20NjlXg
 ewKmBzWyD+f/xpwGZZ4AbY8UeUutwRYvLcaY9z8Lfb1iv0IZefI5HRIqkAQxh9DeGrSq
 jSlsCcLQTsMiJMMmOaN6LJRL+0HVmUQ+4ws/DmlIZxiY4NK523k/VXGmdcI8V4QmnnhR
 l2jA==
X-Gm-Message-State: AOAM532rJZnWP2GEFgbaZJTMHr/h6mTdPLfTJ4446hPYxqElttdrTs6k
 q+fULLstPmrHYoYdkBU+C3xGAlIsC5do8zNetLw=
X-Google-Smtp-Source: ABdhPJxTpmLDtto1J1vRCS/LCLYT/QbM0SsTppRWi4M1b3UUbd+ZxmoNXPyMmPlnT+TLw3ox3HglwSaDCI7YrInj5zg=
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr14696544wru.147.1593816365092; 
 Fri, 03 Jul 2020 15:46:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP;
 Fri, 3 Jul 2020 15:46:04 -0700 (PDT)
In-Reply-To: <87sgebqm1i.fsf@linaro.org>
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <878sg5svu5.fsf@linaro.org>
 <CALTWKrVx+e0oRVrvd27WeXAbAAZHVispG27cRPKwVo3HfNYbkQ@mail.gmail.com>
 <87sgebqm1i.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 4 Jul 2020 00:46:04 +0200
Message-ID: <CAHiYmc4R2hP=ROCC_O0+0sO09TcH-ybwbk3aijxQo=LPpBztpg@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000047544905a9914a91"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000047544905a9914a91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, July 1, 2020, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

>
> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
>
> > On Mon, Jun 29, 2020 at 6:03 PM Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
> wrote:
> >>
> >> Assuming your test case is constant execution (i.e. runs the same each
> >> time) you could run in through a plugins build to extract the number o=
f
> >> guest instructions, e.g.:
> >>
> >>   ./aarch64-linux-user/qemu-aarch64 -plugin tests/plugin/libinsn.so -d
> plugin ./tests/tcg/aarch64-linux-user/sha1
> >>   SHA1=3D15dd99a1991e0b3826fede3deffc1feba42278e6
> >>   insns: 158603512
> >>
> >> --
> >> Alex Benn=C3=A9e
> >
> > Hi Mr. Alex,
> > I've created a plugins build as you've said using "--enable-plugins"
> option.
> > I've searched for "libinsn.so" plugin that you've mentioned in your
> > command but it isn't in that path.
>
> make plugins
>
> and you should find them in tests/plugins/
>
>
Hi, both Alex and Ahmed,

Ahmed showed me tonight the first results with number of guest
instructions. It was almost eye-opening to me. The thing is, by now, I had
only vague picture that, on average, "many" host instructions are generated
per one guest instruction. Now, I could see exact ratio for each target,
for a particular example.

A question for Alex:

- What would be the application of this new info? (Except that one has nice
feeling, like I do, of knowing the exact ratio host/guest instruction for a
particular scenario.)

I just have a feeling there is more significance of this new data that I
currently see. Could it be that it can be used in analysis of performance?
Or measuring quality of emulation (TCG operation)? But how exactly? What
conclusion could potentially be derived from knowing number of guest
instructions?

Sorry for a "stupid" question.

Aleksandar




> >
> > Are there any other options that I should configure my build with?
> > Thanks in advance.
> >
> > Regards,
> > Ahmed Karaman
>
>
> --
> Alex Benn=C3=A9e
>

--00000000000047544905a9914a91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, July 1, 2020, Alex Benn=C3=A9e &lt;<a href=3D"mailto:=
alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><br>
Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhal=
edkaraman@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Mon, Jun 29, 2020 at 6:03 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Assuming your test case is constant execution (i.e. runs the same =
each<br>
&gt;&gt; time) you could run in through a plugins build to extract the numb=
er of<br>
&gt;&gt; guest instructions, e.g.:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0./aarch64-linux-user/qemu-<wbr>aarch64 -plugin tests/p=
lugin/libinsn.so -d plugin ./tests/tcg/aarch64-linux-<wbr>user/sha1<br>
&gt;&gt;=C2=A0 =C2=A0SHA1=3D<wbr>15dd99a1991e0b3826fede3deffc1f<wbr>eba4227=
8e6<br>
&gt;&gt;=C2=A0 =C2=A0insns: 158603512<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Alex Benn=C3=A9e<br>
&gt;<br>
&gt; Hi Mr. Alex,<br>
&gt; I&#39;ve created a plugins build as you&#39;ve said using &quot;--enab=
le-plugins&quot; option.<br>
&gt; I&#39;ve searched for &quot;libinsn.so&quot; plugin that you&#39;ve me=
ntioned in your<br>
&gt; command but it isn&#39;t in that path.<br>
<br>
make plugins<br>
<br>
and you should find them in tests/plugins/<br>
<br></blockquote><div><br></div><div>Hi, both Alex and Ahmed,</div><div><br=
></div><div>Ahmed showed me tonight the first results with number of guest =
instructions. It was almost eye-opening to me. The thing is, by now, I had =
only vague picture that, on average, &quot;many&quot; host instructions are=
 generated per one guest instruction. Now, I could see exact ratio for each=
 target, for a particular example.</div><div><br></div><div>A question for =
Alex:</div><div><br></div><div>- What would be the application of this new =
info? (Except that one has nice feeling, like I do, of knowing the exact ra=
tio host/guest instruction for a particular scenario.)</div><div><br></div>=
<div>I just have a feeling there is more significance of this new data that=
 I currently see. Could it be that it can be used in analysis of performanc=
e? Or measuring quality of emulation (TCG operation)? But how exactly? What=
 conclusion could potentially be derived from knowing number of guest instr=
uctions?</div><div><br></div><div>Sorry for a &quot;stupid&quot; question.<=
/div><div><br></div><div>Aleksandar</div><div><br></div><div><br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
&gt;<br>
&gt; Are there any other options that I should configure my build with?<br>
&gt; Thanks in advance.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Ahmed Karaman<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote>

--00000000000047544905a9914a91--

