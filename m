Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769BAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 09:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB9420826
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmBwjyiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB9420826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jreuE-0001yU-IC
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 05:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jretT-0001X3-3U
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 05:55:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jretR-00013l-1i
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 05:55:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id q15so34207450wmj.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=SALoW10DZjlKO6Hv7f+Lx0IbZ1FznWlk4cCe2TpaOaM=;
 b=JmBwjyiKXwQTZiNpZNoVSN6aj9vpcKJvDRpp7/h5nXgu7UGJunOMzwBpUumq63HzfX
 6mz5TS3zkYvKVsfLlrxaDainY/6PpMtKeTkJv/1lzP1myKVmwlaim/lopabLWOnn3Tae
 fH9BeN7VDsBjBk1ffau9NXDL8qNi+7qSJfJk59SshgmYzSOpiOhX9ZOdL3xpByKxpFvp
 YwXZef2kfxQuGPNoxijpK7t44/arwCn11u0hn9GK0+C75alW8p9BgZ4TLvo226UItwE4
 BStUOpbK2sEPrbfsPc565IbaAyUAdQLYBVK49GM2Pu0Fd1Hi5ebv095Kd09NxzkzF90s
 xl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=SALoW10DZjlKO6Hv7f+Lx0IbZ1FznWlk4cCe2TpaOaM=;
 b=BbZnOAmpNN+qc1GRj/Gn7hl2q/UMUsFwIuDr2Xc7ZcI8zu3sDbFQoYP83FOOHsffT6
 5sfa98VRPNsvZ9TPCiAlA5vkRJ4SH/lNlVjeD5wnwEWZ6JDkwemr8nyOweWuaWpOmDGV
 Xq76xXRAP4i1XkQRcVcOVz8mDdHYS2KiK8oVD5vzZLilFNaPty/gLW5Dya2tkvzS/ma8
 SQPazP948mnVRwZvnt5RmRYRnvkmlHTfRALy9Gyr1TxlmiKa46Y9c/dgHyEJEmBl5cdl
 mh5rsBRfvI2Ea7sK+guxCk4u17gPYhxoIu0tIUEPRwKFgzc6ytLbskC858tCgeLjZdQd
 SHNw==
X-Gm-Message-State: AOAM533ih1iQE++08f5g5OT+HeCklm+Txr3ngUtwQvhspS0TytExiBdH
 pXwbMfPcPqK/I9Ga+PHaHD9psxmAPix+7zrg58o=
X-Google-Smtp-Source: ABdhPJxecOvtGofh2Wdy0/GsL0QwUT/kBd03eAkjnuL2Q3NlSOkp6UF2IMOW7sm06QqAgVaUSvRHvojvntV2DEI8WVo=
X-Received: by 2002:a1c:2602:: with SMTP id m2mr42381950wmm.50.1593856531131; 
 Sat, 04 Jul 2020 02:55:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP;
 Sat, 4 Jul 2020 02:55:30 -0700 (PDT)
In-Reply-To: <87fta7fz3n.fsf@linaro.org>
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <878sg5svu5.fsf@linaro.org>
 <CALTWKrVx+e0oRVrvd27WeXAbAAZHVispG27cRPKwVo3HfNYbkQ@mail.gmail.com>
 <87sgebqm1i.fsf@linaro.org>
 <CAHiYmc4R2hP=ROCC_O0+0sO09TcH-ybwbk3aijxQo=LPpBztpg@mail.gmail.com>
 <87fta7fz3n.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 4 Jul 2020 11:55:30 +0200
Message-ID: <CAHiYmc5Jxk-Np8YxtctAXMeLL=PmEX=t6iSyPYj3gDx5bVjP=A@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005c70b605a99aa4f4"
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32f.google.com
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

--0000000000005c70b605a99aa4f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, July 4, 2020, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

>
> Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:
>
> > On Wednesday, July 1, 2020, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> >>
> >> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
> >>
> >> > On Mon, Jun 29, 2020 at 6:03 PM Alex Benn=C3=A9e <alex.bennee@linaro=
.org>
> >> wrote:
> >> >>
> >> >> Assuming your test case is constant execution (i.e. runs the same
> each
> >> >> time) you could run in through a plugins build to extract the numbe=
r
> of
> >> >> guest instructions, e.g.:
> >> >>
> >> >>   ./aarch64-linux-user/qemu-aarch64 -plugin tests/plugin/libinsn.so
> -d
> >> plugin ./tests/tcg/aarch64-linux-user/sha1
> >> >>   SHA1=3D15dd99a1991e0b3826fede3deffc1feba42278e6
> >> >>   insns: 158603512
> >> >>
> >> >> --
> >> >> Alex Benn=C3=A9e
> >> >
> >> > Hi Mr. Alex,
> >> > I've created a plugins build as you've said using "--enable-plugins"
> >> option.
> >> > I've searched for "libinsn.so" plugin that you've mentioned in your
> >> > command but it isn't in that path.
> >>
> >> make plugins
> >>
> >> and you should find them in tests/plugins/
> >>
> >>
> > Hi, both Alex and Ahmed,
> >
> > Ahmed showed me tonight the first results with number of guest
> > instructions. It was almost eye-opening to me. The thing is, by now, I
> had
> > only vague picture that, on average, "many" host instructions are
> generated
> > per one guest instruction. Now, I could see exact ratio for each target=
,
> > for a particular example.
> >
> > A question for Alex:
> >
> > - What would be the application of this new info? (Except that one has
> nice
> > feeling, like I do, of knowing the exact ratio host/guest instruction
> for a
> > particular scenario.)
>
> Well I think the total number of guest instructions is important because
> some architectures are more efficient than others and this will an
> impact on the total executed instructions.
>
> > I just have a feeling there is more significance of this new data that =
I
> > currently see. Could it be that it can be used in analysis of
> performance?
> > Or measuring quality of emulation (TCG operation)? But how exactly? Wha=
t
> > conclusion could potentially be derived from knowing number of guest
> > instructions?
>
> Knowing the ratio (especially as it changes between workloads) means you
> can better pin point where the inefficiencies lie. You don't want to
> spend your time chasing down an inefficiency that is down to the guest
> compiler ;-)
>
>
Yes, it is definitely worth having the exact number of guest instructions!

Ahmed and I knew from the outset, like everybody else for that matter, that
workload and guest compiler and architecture itself immensly impact any
measurement.

However, if we keep the same guest, guest compiler, and workload as well,
and change just qemu, than we should be able to draw conclusion on
qemu-specific issues, and hopefully remove some inefficiencies. I hope you
will see that approach in next Ahmed's reports.

Aleksandar





> >
> > Sorry for a "stupid" question.
> >
> > Aleksandar
> >
> >
> >
> >
> >> >
> >> > Are there any other options that I should configure my build with?
> >> > Thanks in advance.
> >> >
> >> > Regards,
> >> > Ahmed Karaman
> >>
> >>
> >> --
> >> Alex Benn=C3=A9e
> >>
>
>
> --
> Alex Benn=C3=A9e
>

--0000000000005c70b605a99aa4f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, July 4, 2020, Alex Benn=C3=A9e &lt;<a href=3D"mailto:a=
lex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><br>
Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">=
aleksandar.qemu.devel@gmail.<wbr>com</a>&gt; writes:<br>
<br>
&gt; On Wednesday, July 1, 2020, Alex Benn=C3=A9e &lt;<a href=3D"mailto:ale=
x.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">=
ahmedkhaledkaraman@gmail.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Mon, Jun 29, 2020 at 6:03 PM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Assuming your test case is constant execution (i.e. runs =
the same each<br>
&gt;&gt; &gt;&gt; time) you could run in through a plugins build to extract=
 the number of<br>
&gt;&gt; &gt;&gt; guest instructions, e.g.:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0./aarch64-linux-user/qemu-<wbr>aarch64 -plugi=
n tests/plugin/libinsn.so -d<br>
&gt;&gt; plugin ./tests/tcg/aarch64-linux-<wbr>user/sha1<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0SHA1=3D<wbr>15dd99a1991e0b3826fede3deffc1f<wb=
r>eba42278e6<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0insns: 158603512<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; Alex Benn=C3=A9e<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi Mr. Alex,<br>
&gt;&gt; &gt; I&#39;ve created a plugins build as you&#39;ve said using &qu=
ot;--enable-plugins&quot;<br>
&gt;&gt; option.<br>
&gt;&gt; &gt; I&#39;ve searched for &quot;libinsn.so&quot; plugin that you&=
#39;ve mentioned in your<br>
&gt;&gt; &gt; command but it isn&#39;t in that path.<br>
&gt;&gt;<br>
&gt;&gt; make plugins<br>
&gt;&gt;<br>
&gt;&gt; and you should find them in tests/plugins/<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Hi, both Alex and Ahmed,<br>
&gt;<br>
&gt; Ahmed showed me tonight the first results with number of guest<br>
&gt; instructions. It was almost eye-opening to me. The thing is, by now, I=
 had<br>
&gt; only vague picture that, on average, &quot;many&quot; host instruction=
s are generated<br>
&gt; per one guest instruction. Now, I could see exact ratio for each targe=
t,<br>
&gt; for a particular example.<br>
&gt;<br>
&gt; A question for Alex:<br>
&gt;<br>
&gt; - What would be the application of this new info? (Except that one has=
 nice<br>
&gt; feeling, like I do, of knowing the exact ratio host/guest instruction =
for a<br>
&gt; particular scenario.)<br>
<br>
Well I think the total number of guest instructions is important because<br=
>
some architectures are more efficient than others and this will an<br>
impact on the total executed instructions.<br>
<br>
&gt; I just have a feeling there is more significance of this new data that=
 I<br>
&gt; currently see. Could it be that it can be used in analysis of performa=
nce?<br>
&gt; Or measuring quality of emulation (TCG operation)? But how exactly? Wh=
at<br>
&gt; conclusion could potentially be derived from knowing number of guest<b=
r>
&gt; instructions?<br>
<br>
Knowing the ratio (especially as it changes between workloads) means you<br=
>
can better pin point where the inefficiencies lie. You don&#39;t want to<br=
>
spend your time chasing down an inefficiency that is down to the guest<br>
compiler ;-) <br>
<br></blockquote><div><br></div><div>Yes, it is definitely worth having the=
 exact number of guest instructions!</div><div><br></div><div>Ahmed and I k=
new from the outset, like everybody else for that matter, that workload and=
 guest compiler and architecture itself immensly impact any measurement.</d=
iv><div><br></div><div>However, if we keep the same guest, guest compiler, =
and workload as well, and change just qemu, than we should be able to draw =
conclusion on qemu-specific issues, and hopefully remove some inefficiencie=
s. I hope you will see that approach in next Ahmed&#39;s reports.</div><div=
><br></div><div>Aleksandar</div><div><br></div><div><br></div><div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt;<br>
&gt; Sorry for a &quot;stupid&quot; question.<br>
&gt;<br>
&gt; Aleksandar<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Are there any other options that I should configure my build =
with?<br>
&gt;&gt; &gt; Thanks in advance.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Regards,<br>
&gt;&gt; &gt; Ahmed Karaman<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Alex Benn=C3=A9e<br>
&gt;&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote>

--0000000000005c70b605a99aa4f4--

