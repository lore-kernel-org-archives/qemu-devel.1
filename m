Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B3C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D2E2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIMhcUuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D2E2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjQ2-0006Aj-8P
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihjPG-0005hj-Cm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgSg-0007Ol-6V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:02:27 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:39167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ihgSV-0006dK-23; Wed, 18 Dec 2019 16:02:16 -0500
Received: by mail-il1-x143.google.com with SMTP id x5so2914653ila.6;
 Wed, 18 Dec 2019 13:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZHGtntswR8W4mR3O18kwKAC9ejq3lYrTZEGigFPxDeI=;
 b=aIMhcUuwnOSRH7aLtb/p3PcYjjrEgbuqUXOC+Mg9eopCE6A5B3tQe4R594GTjYvJEy
 T5OzfzkxnQZwlx0Zq6z18tHfH0wpcir65t3cIdmiN8wyFyxxD/RTcTOjot0r7cxpKuwd
 Uu6bT9qafpeNaLNuwtEKhBo4gFpSe8ulYIHiZWTKOv6vqrCQvSs1VL7hCtrXGhHbG9oO
 oS1oLnrVNxXzsprcS6u8iEAnm7a3S5Gjb1bhq92TDsuCjrogTOfp4sIv9c+LP0K+Neo7
 2h1dlv49e/1qgKzy1Sx7SrFnP5cItyA5ekE7K6s2NBkIxJqKqOBiZytF5ZyRZuhkI5wd
 Apgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZHGtntswR8W4mR3O18kwKAC9ejq3lYrTZEGigFPxDeI=;
 b=NUKDFlKLqs9UQW7l4+5MsoqNbK7T2weMRebb0Pr8p4dMs2eEN33BhHUQi/ZrSKa+fv
 pqtKMTEcbLNmg3XLWraa3YbMElQIuGJKixAtn6gRv4ne8/DjdM8Ti9sDqrNfKWuo55W4
 4wgarpeoUpqTXyqirc45a490KhbxH5FuYN+vEMRD7fJBbSs3lUZPMImyXGEjUc54+Wq0
 LZ8HACxERL41IOflEgHGzekQLdphAYkTd9PnD+sRixm+V7Rtgm6AC4HJfSi6zDbKWlh+
 BPIGYElWLDFa+2H44hL4VkzrjzawWn+32rl/5PbejgXkfbNyKiqXXKMLjZSLCr/npplU
 ghTw==
X-Gm-Message-State: APjAAAVCKGFZdnMN6qw1ELV9miRvnFB55BFNwOIME7pnDN6hIbTe+kDR
 yNYwmdAK1P1tMC+yKkqg/e7QsAavFYoZ1T4Zetg=
X-Google-Smtp-Source: APXvYqzEdHEXc8x71A7Lpg+O8/J2t/UQpCJw7Pvw0MsGMq9LcLw2529wHUXGewWV/tUwdU/h2fs1Tloh6y3sII83o9I=
X-Received: by 2002:a92:5a45:: with SMTP id o66mr3672544ilb.67.1576702925654; 
 Wed, 18 Dec 2019 13:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <20191216233519.29030-7-nieklinnenbank@gmail.com>
 <CAPan3WpW1Q3zpnqgk=MWRWe99=MQ4XoW2kw8L3tioFxfEBXd+Q@mail.gmail.com>
 <CAFEAcA8Viii4Em_bf4Y=AG0jU+EFFFTX6dO-52qd=RT4uHbCVw@mail.gmail.com>
 <19e4f2ac-6067-f61f-f340-108545fb0f02@linaro.org>
In-Reply-To: <19e4f2ac-6067-f61f-f340-108545fb0f02@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 18 Dec 2019 22:01:54 +0100
Message-ID: <CAPan3WrcvE_43=3+b4Ybn==TEQcKj+F_VWjJRBJ6MyXNrcpUbw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] arm/arm-powerctl: rebuild hflags after setting
 CP15 bits in arm_set_cpu_on()
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cccf81059a00c1c9"
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cccf81059a00c1c9
Content-Type: text/plain; charset="UTF-8"

Hello Richard,

On Tue, Dec 17, 2019 at 5:41 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 12/17/19 6:12 AM, Peter Maydell wrote:
> > Cc'ing Richard : this is one for you I think... (surely we
> > need to rebuild the hflags from scratch when we power up
> > a CPU anyway?)
>
> We do compute hflags from scratch in reset.
>
> It has also turned out that there were a few board models that poked at the
> contents of the cpu and needed special help.  Some of that I would imagine
> would be fixed properly with the multi-phase reset patches, where we could
> rebuild hflags when *leaving* reset.
>
> In arm_set_cpu_on_async_work, we start by resetting the cpu and then start
> poking at the contents of some system registers.  So, yes, we do need to
> rebuild after doing that.  Also, I'm not sure how this function should fit
> into
> the multi-phase reset future.
>

Great, thanks a lot for confirming and clarifying this!
You mention the multi-phase reset feature, is that going to replace the
arm_set_cpu_on() functionality?
Currently I chose to use this function for implementing the CPU
configuration module in the Allwinner H3 Soc.
U-Boot needs the CPU configuration module to provide PSCI which Linux uses
to bring up the secondary cores.
And basically the CPU configuration module needs something to let the
secondary CPUs power on, reset and start executing at some address.

Would you suggest to keep using arm_set_cpu_on() for this, or should I
instead use a different function?

Regards,
Niek

>
> So:
>
> >> On Tue, Dec 17, 2019 at 12:36 AM Niek Linnenbank <
> nieklinnenbank@gmail.com> wrote:
> >>>
> >>> After setting CP15 bits in arm_set_cpu_on() the cached hflags must
> >>> be rebuild to reflect the changed processor state. Without rebuilding,
> >>> the cached hflags would be inconsistent until the next call to
> >>> arm_rebuild_hflags(). When QEMU is compiled with debugging enabled
> >>> (--enable-debug), this problem is captured shortly after the first
> >>> call to arm_set_cpu_on() for CPUs running in ARM 32-bit non-secure
> mode:
> >>>
> >>>   qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state:
> >>>   Assertion `flags == rebuild_hflags_internal(env)' failed.
> >>>   Aborted (core dumped)
> >>>
> >>> Fixes: 0c7f8c43daf65
> >>> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> >>> ---
> >>>  target/arm/arm-powerctl.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> >>> index b064513d44..b75f813b40 100644
> >>> --- a/target/arm/arm-powerctl.c
> >>> +++ b/target/arm/arm-powerctl.c
> >>> @@ -127,6 +127,9 @@ static void arm_set_cpu_on_async_work(CPUState
> *target_cpu_state,
> >>>          target_cpu->env.regs[0] = info->context_id;
> >>>      }
> >>>
> >>> +    /* CP15 update requires rebuilding hflags */
> >>> +    arm_rebuild_hflags(&target_cpu->env);
> >>> +
> >>>      /* Start the new CPU at the requested address */
> >>>      cpu_set_pc(target_cpu_state, info->entry);
> >>>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>


-- 
Niek Linnenbank

--000000000000cccf81059a00c1c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Richard,<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 17, 2019 at 5:41 PM Ric=
hard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.=
henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On 12/17/19 6:12 AM, Peter Maydell wrote:<br>
&gt; Cc&#39;ing Richard : this is one for you I think... (surely we<br>
&gt; need to rebuild the hflags from scratch when we power up<br>
&gt; a CPU anyway?)<br>
<br>
We do compute hflags from scratch in reset.<br>
<br>
It has also turned out that there were a few board models that poked at the=
<br>
contents of the cpu and needed special help.=C2=A0 Some of that I would ima=
gine<br>
would be fixed properly with the multi-phase reset patches, where we could<=
br>
rebuild hflags when *leaving* reset.<br>
<br>
In arm_set_cpu_on_async_work, we start by resetting the cpu and then start<=
br>
poking at the contents of some system registers.=C2=A0 So, yes, we do need =
to<br>
rebuild after doing that.=C2=A0 Also, I&#39;m not sure how this function sh=
ould fit into<br>
the multi-phase reset future.<br></blockquote><div><br></div><div>Great, th=
anks a lot for confirming and clarifying this!</div><div>You mention the mu=
lti-phase reset feature, is that going to replace the arm_set_cpu_on() func=
tionality?</div><div>Currently I chose to use this function for implementin=
g the CPU configuration module in the Allwinner H3 Soc.</div><div><div>U-Bo=
ot needs the CPU configuration module to provide PSCI which Linux uses to b=
ring up the secondary cores.</div></div><div>And basically the CPU configur=
ation module needs something to let the secondary CPUs power on, reset and =
start executing at some address.</div><div><br></div><div>Would you suggest=
 to keep using arm_set_cpu_on() for this, or should I instead use a differe=
nt function?<br></div><div><br></div><div>Regards,</div><div>Niek<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
So:<br>
<br>
&gt;&gt; On Tue, Dec 17, 2019 at 12:36 AM Niek Linnenbank &lt;<a href=3D"ma=
ilto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</=
a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; After setting CP15 bits in arm_set_cpu_on() the cached hflags =
must<br>
&gt;&gt;&gt; be rebuild to reflect the changed processor state. Without reb=
uilding,<br>
&gt;&gt;&gt; the cached hflags would be inconsistent until the next call to=
<br>
&gt;&gt;&gt; arm_rebuild_hflags(). When QEMU is compiled with debugging ena=
bled<br>
&gt;&gt;&gt; (--enable-debug), this problem is captured shortly after the f=
irst<br>
&gt;&gt;&gt; call to arm_set_cpu_on() for CPUs running in ARM 32-bit non-se=
cure mode:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0qemu-system-arm: target/arm/helper.c:11359: cpu_ge=
t_tb_cpu_state:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0Assertion `flags =3D=3D rebuild_hflags_internal(en=
v)&#39; failed.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0Aborted (core dumped)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Fixes: 0c7f8c43daf65<br>
&gt;&gt;&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 target/arm/arm-powerctl.c | 3 +++<br>
&gt;&gt;&gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerc=
tl.c<br>
&gt;&gt;&gt; index b064513d44..b75f813b40 100644<br>
&gt;&gt;&gt; --- a/target/arm/arm-powerctl.c<br>
&gt;&gt;&gt; +++ b/target/arm/arm-powerctl.c<br>
&gt;&gt;&gt; @@ -127,6 +127,9 @@ static void arm_set_cpu_on_async_work(CPUS=
tate *target_cpu_state,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cpu-&gt;env.regs[0] =
=3D info-&gt;context_id;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 /* CP15 update requires rebuilding hflags */<br=
>
&gt;&gt;&gt; +=C2=A0 =C2=A0 arm_rebuild_hflags(&amp;target_cpu-&gt;env);<br=
>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 /* Start the new CPU at the requested addr=
ess */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 cpu_set_pc(target_cpu_state, info-&gt;entr=
y);<br>
&gt;&gt;&gt;<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
<br>
r~<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000cccf81059a00c1c9--

