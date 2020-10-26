Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8A7C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1361520829
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NapQzM6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1361520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9Wz-0006Y0-Ul
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kX9Vl-0005hE-5u; Mon, 26 Oct 2020 16:54:37 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kX9Vj-0004IC-1A; Mon, 26 Oct 2020 16:54:36 -0400
Received: by mail-lj1-x243.google.com with SMTP id m20so11896534ljj.5;
 Mon, 26 Oct 2020 13:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=d2fZGfjy06CNbNEUnBOTkyjn+PZKIVuRt+JPMo4bAqE=;
 b=NapQzM6unw8mkRIiDVKVTL8NP+T5ll+sWrSLTcSTMyvfwatrN/Dwkkx+njKpbj9ioB
 23JehRmK0XiijxWoJmT2roEkAVp+knQC2zMWJGDmjx0b2GQyQo/wyNuJn+3W+9NiYFaj
 eKHSwYI5URvdzW/Q2EsRHLZTQ5CX3SC1BQyv4yK/cfe/frr2dUGXDLL2DQT+i/BWBM83
 ROV1kXbYs59dwmNjfJI91d7FAsGyN3V5SSlDwg0J7Lrcn/hliT+prh/vGulB46X5RN9W
 j9EOGKVo/DvM8qtE0v8Z0xfAICgPNw1TsGBH+Uvt5Dw0qCm6gitQwBwaer88b953GhRM
 bJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=d2fZGfjy06CNbNEUnBOTkyjn+PZKIVuRt+JPMo4bAqE=;
 b=oWGT4PyizVBESD4LpgHXuEn40xDzZdcSPVFzV9b6qzhcWpVHyN6isE7bsfOFey5/8q
 B3g9PDMMva8UKXeQwRkFtA0JdVda+LToCkJfv+9MiCX6tJ2DaFsDjHcSDUuwbpThX9Kn
 vx+hVGQzt8LEtQZ2zUgzPCoFjz4cZkUUbW2RMZBcbwYhustx3F63up1WNAA2FWYzfGGR
 vlg/YTtv3nO6Pet+cem5DDjPAyvfkCvtuqB9PkpFyHntZclYaXeG+dwUXDnq0hDN9vWb
 5Oc7YGofZyJifWfZcomOPG4vEksuR1FW7IanBRCelkNZzMxsYHWLqYUFQg9Bfp5uzBUT
 +qeg==
X-Gm-Message-State: AOAM533fwJ7vlt4kRbw/3oBA4t0sMy4Q/LWfLrfPqQnoTfjSjQTzDl5r
 DLqPHTZzsegqR4mzW0ksCJVhNW07wOpadXMFbdc=
X-Google-Smtp-Source: ABdhPJxvqPRPZIwCjAEK4szVvdGHGvipdB8fMqd+3k+rnD33Wa39Jk5fRt1MNk3A8vSRUBct9xBFXWkmyLuQsXPzVUc=
X-Received: by 2002:a2e:8e32:: with SMTP id r18mr6975532ljk.171.1603745672785; 
 Mon, 26 Oct 2020 13:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201015151829.14656-1-peter.maydell@linaro.org>
 <CAFEAcA8g-n4gqy0Az7cBsQJqcQpsc_vH2=VatqqdRt034YD5JQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8g-n4gqy0Az7cBsQJqcQpsc_vH2=VatqqdRt034YD5JQ@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 27 Oct 2020 04:54:21 +0800
Message-ID: <CAE2XoE-dNO-guN8P6Btpzr_mB1C8kx4svoG=LioPYABF5HtBQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] armv7m_systick: Rewrite to use ptimers
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000022f56405b2992360"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000022f56405b2992360
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 4:44 AM Peter Maydell <peter.maydell@linaro.org>
wrote:
>
> Ping for review ?
>
Maybe nobody can review this, anyway, is that possible add a test case for
this?
I found https://github.com/oxidecomputer/qemu-systick-bug are simple enough=
.
> thanks
> -- PMM
>
> On Thu, 15 Oct 2020 at 16:18, Peter Maydell <peter.maydell@linaro.org>
wrote:
> >
> > This patch series rewrites our implementation of the armv7m systick
> > timer to use ptimers.
> >
> > The armv7m systick timer is a 24-bit decrementing, wrap-on-zero,
> > clear-on-write counter.  Our current implementation has various bugs
> > and dubious workarounds in it (for instance see
> > https://bugs.launchpad.net/qemu/+bug/1872237).
> >
> > We have an implementation of a simple decrementing counter and we put
> > a lot of effort into making sure it handles the interesting corner
> > cases (like "spend a cycle at 0 before reloading"), so rather than
> > trying to fix these all over again in systick's hand-rolled countdown
> > code it's much simpler to just rewrite it to use a ptimer.
> >
> > Unfortunately this is a migration compatibility break, which will
> > affect all M-profile boards.
> >
> > Among other bugs, this fixes
> > https://bugs.launchpad.net/qemu/+bug/1872237 : now writes to SYST_CVR
> > when the timer is enabled correctly do nothing; when the timer is
> > enabled via SYST_CSR.ENABLE, the ptimer code will (because of
> > POLICY_NO_IMMEDIATE_RELOAD) arrange that after one timer tick the
> > counter is reloaded from SYST_RVR and then counts down from there, as
> > the architecture requires.
> >
> > Side note: the trace from the test program in LP1872237 won't look
> > quite like it does on the hardware: under QEMU the "waiting for 1000
> > ms" debug printing generally reports a SYST_CVR value of 0.  This is
> > because QEMU's emulated CPU is comparatively fast and our systick has a
> > hard-wired value of 1MHz for the frequency of the 'external reference
> > clock', which means that execution of the guest code reaches "read
> > SYST_CVR" before the first tick of the timer clock after enabling of
> > the timer (which is where the reload of SYST_CVR from SYST_RVR is
> > required).  The exception is the first iteration, where the time QEMU
> > takes to translate the guest code is enough that the timer tick
> > happens before the register read.  You can also get the timer tick to
> > win the race by fiddling around with the -icount option (which
> > effectively is slowing down the emulated CPU speed).
> >
> > Some day we should model both the 'system_clock_scale' (ie the CPU
> > clock frequency) and the 'external reference clock' as QEMU clock
> > source/sinks so that board code can specify the correct reference
> > clock frequency.
> >
> > Patch 1 is a minor tweak to the ptimer code to suppress a spurious
> > warning message for the "timer callback function disabled the ptimer"
> > case, which the systick timer uses.  Patch 2 is the actual
> > conversion.
> >
> > thanks
> > -- PMM
> >
> >
> > Peter Maydell (2):
> >   hw/core/ptimer: Support ptimer being disabled by timer callback
> >   hw/timer/armv7m_systick: Rewrite to use ptimers
> >
> >  include/hw/timer/armv7m_systick.h |   3 +-
> >  hw/core/ptimer.c                  |   4 +
> >  hw/timer/armv7m_systick.c         | 124 +++++++++++++-----------------
> >  3 files changed, 58 insertions(+), 73 deletions(-)
> >
> > --
> > 2.20.1
> >
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000022f56405b2992360
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Oct 27, 2020 at 4:44 AM Peter Maydell &lt;=
<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt=
; wrote:<br>&gt;<br>&gt; Ping for review ?<br>&gt;<div>Maybe nobody can rev=
iew this, anyway, is that possible add a test case for this?</div><div>I fo=
und=C2=A0<a href=3D"https://github.com/oxidecomputer/qemu-systick-bug">http=
s://github.com/oxidecomputer/qemu-systick-bug</a> are simple enough.<br>&gt=
; thanks<br>&gt; -- PMM<br>&gt;<br>&gt; On Thu, 15 Oct 2020 at 16:18, Peter=
 Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lina=
ro.org</a>&gt; wrote:<br>&gt; &gt;<br>&gt; &gt; This patch series rewrites =
our implementation of the armv7m systick<br>&gt; &gt; timer to use ptimers.=
<br>&gt; &gt;<br>&gt; &gt; The armv7m systick timer is a 24-bit decrementin=
g, wrap-on-zero,<br>&gt; &gt; clear-on-write counter.=C2=A0 Our current imp=
lementation has various bugs<br>&gt; &gt; and dubious workarounds in it (fo=
r instance see<br>&gt; &gt; <a href=3D"https://bugs.launchpad.net/qemu/+bug=
/1872237">https://bugs.launchpad.net/qemu/+bug/1872237</a>).<br>&gt; &gt;<b=
r>&gt; &gt; We have an implementation of a simple decrementing counter and =
we put<br>&gt; &gt; a lot of effort into making sure it handles the interes=
ting corner<br>&gt; &gt; cases (like &quot;spend a cycle at 0 before reload=
ing&quot;), so rather than<br>&gt; &gt; trying to fix these all over again =
in systick&#39;s hand-rolled countdown<br>&gt; &gt; code it&#39;s much simp=
ler to just rewrite it to use a ptimer.<br>&gt; &gt;<br>&gt; &gt; Unfortuna=
tely this is a migration compatibility break, which will<br>&gt; &gt; affec=
t all M-profile boards.<br>&gt; &gt;<br>&gt; &gt; Among other bugs, this fi=
xes<br>&gt; &gt; <a href=3D"https://bugs.launchpad.net/qemu/+bug/1872237">h=
ttps://bugs.launchpad.net/qemu/+bug/1872237</a> : now writes to SYST_CVR<br=
>&gt; &gt; when the timer is enabled correctly do nothing; when the timer i=
s<br>&gt; &gt; enabled via SYST_CSR.ENABLE, the ptimer code will (because o=
f<br>&gt; &gt; POLICY_NO_IMMEDIATE_RELOAD) arrange that after one timer tic=
k the<br>&gt; &gt; counter is reloaded from SYST_RVR and then counts down f=
rom there, as<br>&gt; &gt; the architecture requires.<br>&gt; &gt;<br>&gt; =
&gt; Side note: the trace from the test program in LP1872237 won&#39;t look=
<br>&gt; &gt; quite like it does on the hardware: under QEMU the &quot;wait=
ing for 1000<br>&gt; &gt; ms&quot; debug printing generally reports a SYST_=
CVR value of 0.=C2=A0 This is<br>&gt; &gt; because QEMU&#39;s emulated CPU =
is comparatively fast and our systick has a<br>&gt; &gt; hard-wired value o=
f 1MHz for the frequency of the &#39;external reference<br>&gt; &gt; clock&=
#39;, which means that execution of the guest code reaches &quot;read<br>&g=
t; &gt; SYST_CVR&quot; before the first tick of the timer clock after enabl=
ing of<br>&gt; &gt; the timer (which is where the reload of SYST_CVR from S=
YST_RVR is<br>&gt; &gt; required).=C2=A0 The exception is the first iterati=
on, where the time QEMU<br>&gt; &gt; takes to translate the guest code is e=
nough that the timer tick<br>&gt; &gt; happens before the register read.=C2=
=A0 You can also get the timer tick to<br>&gt; &gt; win the race by fiddlin=
g around with the -icount option (which<br>&gt; &gt; effectively is slowing=
 down the emulated CPU speed).<br>&gt; &gt;<br>&gt; &gt; Some day we should=
 model both the &#39;system_clock_scale&#39; (ie the CPU<br>&gt; &gt; clock=
 frequency) and the &#39;external reference clock&#39; as QEMU clock<br>&gt=
; &gt; source/sinks so that board code can specify the correct reference<br=
>&gt; &gt; clock frequency.<br>&gt; &gt;<br>&gt; &gt; Patch 1 is a minor tw=
eak to the ptimer code to suppress a spurious<br>&gt; &gt; warning message =
for the &quot;timer callback function disabled the ptimer&quot;<br>&gt; &gt=
; case, which the systick timer uses.=C2=A0 Patch 2 is the actual<br>&gt; &=
gt; conversion.<br>&gt; &gt;<br>&gt; &gt; thanks<br>&gt; &gt; -- PMM<br>&gt=
; &gt;<br>&gt; &gt;<br>&gt; &gt; Peter Maydell (2):<br>&gt; &gt; =C2=A0 hw/=
core/ptimer: Support ptimer being disabled by timer callback<br>&gt; &gt; =
=C2=A0 hw/timer/armv7m_systick: Rewrite to use ptimers<br>&gt; &gt;<br>&gt;=
 &gt; =C2=A0include/hw/timer/armv7m_systick.h | =C2=A0 3 +-<br>&gt; &gt; =
=C2=A0hw/core/ptimer.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 4 +<br>&gt; &gt; =C2=A0hw/timer/armv7m_systick.c =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 124 +++++++++++++-----------------<br>&gt; &gt; =C2=
=A03 files changed, 58 insertions(+), 73 deletions(-)<br>&gt; &gt;<br>&gt; =
&gt; --<br>&gt; &gt; 2.20.1<br>&gt; &gt;<br>&gt;<br><br><br>--<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=
=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div><=
/div>

--00000000000022f56405b2992360--

