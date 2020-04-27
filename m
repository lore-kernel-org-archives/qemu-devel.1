Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497FDC4CECC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 21:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097B1206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 21:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0vtAVhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097B1206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTBBM-0004cs-6Y
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 17:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jTB9M-0003g0-Re
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 17:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jTB9G-0003Rp-7U
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 17:18:46 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jTB99-0003Ni-Rq; Mon, 27 Apr 2020 17:18:36 -0400
Received: by mail-lj1-x243.google.com with SMTP id a21so16309763ljj.11;
 Mon, 27 Apr 2020 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=y5A1Wz68KSuEbWyrpzH2nFGOu9xCbxrLP1p1ybJE7kM=;
 b=g0vtAVhHn3fV85MEmxF88Gk2y+PAqvGjFS54DgQ/c21Juo4rmcxQI6x2KtoqRbHv1g
 PDkbrcWSUPLueqGGRDIqqx7U5hhSzkGuK8617nvn0DdDbBLPHqcI8JgObVBYD5Nim1Q9
 Rr10WhOCHMqf/blv3Gh0H0cLk0uJClV4axox9Lo/fLBZJnZtphzLalhLrfaumOElgQv0
 FtItp/B9zY9vdJLYTse9DPdS4KtDqbupjT2FUrzBCLkW+m9nzAbRa7XrKjB4AXwT2nkr
 WU9lzpVaioqiYSQIlEL8znQ7j4bVcuzm6q0XgX6eTvhYuJQAIMexjHp0Kywm0FjNk2xJ
 wMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=y5A1Wz68KSuEbWyrpzH2nFGOu9xCbxrLP1p1ybJE7kM=;
 b=UM6+x1uZ3752VevPke9a5ZoK6ML2ShFt0CdZeu6L2r0Egq/N2y+4kAlRYx+YwXlhOW
 SASF5jWY7SBDxmvYf11pBit4fOgke3H+egca1JG9SBnhM5atr6YzuJnm2hDlCPMxFtDH
 WS0KfA0JGOw0g9S/6xBD0hgJ8nvvuDZ1I4brQxY5Q5poTILKWBbGkCQhsV8W5+PL3fqe
 X1U2S4/J16B3VywdiFUqps0YW27/Szcs5TG3+XrLKRqUKKOU6VEif2j7hgNLgwayElwf
 kbZIP401PeJMb5wQlzlozATQwwCFhmqbBcid1MTs6fug/Dn+PCB66mUMWvKxy19dEzib
 ckiA==
X-Gm-Message-State: AGi0PuaFFPQn/yTM/qfj/Al2OlXkLaVxBqmbSIBzmBJt2AlimtnJiNHx
 cFpYO6Un2shvL7sdFVHc9s4mf6P9LReiOujxPWw=
X-Google-Smtp-Source: APiQypIlgrcihlkHfLfl1ERMRAOklI4GYHF55E6Wj23r1MY8RsgAXNaa8eVi2HkBf+t+X6nLOYamMbHZraJe6fm/wm8=
X-Received: by 2002:a2e:800f:: with SMTP id j15mr15630187ljg.27.1588022311426; 
 Mon, 27 Apr 2020 14:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
In-Reply-To: <87imhlkwun.fsf@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 28 Apr 2020 05:18:19 +0800
Message-ID: <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
Subject: Re: About hardfloat in ppc
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c4a1ae05a44c41a6"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::243
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c4a1ae05a44c41a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am confusing why only  inexact  are set then we can use hard-float.
And PPC always clearing inexact  flag before calling to soft-float
funcitons. so we can not
optimize it with hard-float.
I need some resouces about ineact flag and why always clearing inexcat in
PPC FP simualtion.
I am looking for two possible solution:
1. do not clear inexact flag in PPC simulation
2. even the inexact are cleared, we can still use alternative hard-float.

But now I am the beginner, Have no clue about all the things.

On Mon, Apr 27, 2020 at 7:10 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>
> > On Mon, 27 Apr 2020, Alex Benn=C3=A9e wrote:
> >> =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writ=
es:
> >>> Because ppc fpu-helper are always clearing float_flag_inexact,
> >>> So is that possible to optimize the performance when
> float_flag_inexact
> >>> are cleared?
> >>
> >> There was some discussion about this in the last thread about enabling
> >> hardfloat for PPC. See the thread:
> >>
> >>  Subject: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
> >>  Date: Tue, 18 Feb 2020 18:10:16 +0100
> >>  Message-Id: <20200218171702.979F074637D@zero.eik.bme.hu>
> >
> > I've answered this already with link to that thread here:
> >
> > On Fri, 10 Apr 2020, BALATON Zoltan wrote:
> > : Date: Fri, 10 Apr 2020 20:04:53 +0200 (CEST)
> > : From: BALATON Zoltan <balaton@eik.bme.hu>
> > : To: "=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)" <luoyonggang@gmail.co=
m>
> > : Cc: qemu-devel@nongnu.org, Mark Cave-Ayland, John Arbuckle,
> qemu-ppc@nongnu.org, Paul Clarke, Howard Spoelstra, David Gibson
> > : Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
> > :
> > : On Fri, 10 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > :> Are this stable now? I'd like to see hard float to be landed:)
> > :
> > : If you want to see hardfloat for PPC then you should read the
> > replies to : this patch which can be found here:
> > :
> > : http://patchwork.ozlabs.org/patch/1240235/
> > :
> > : to understand what's needed then try to implement the solution with
> > FP : exceptions cached in a global that maybe could work. I won't be
> > able to : do that as said here:
> > :
> > : https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00006.html
> > :
> > : because I don't have time to learn all the details needed. I think :
> > others are in the same situation so unless somebody puts in the :
> > necessary effort this won't change.
> >
> > Which also had a proposed solution to the problem that you could try
> > to implement, in particular see this message:
> >
> >
> http://patchwork.ozlabs.org/project/qemu-devel/patch/20200218171702.979F0=
74637D@zero.eik.bme.hu/#2375124
> >
> > amd Richard's reply immediately below that. In short to optimise FPU
> > emulation we would either find a way to compute inexact flag quickly
> > without reading the FPU status (this may not be possible) or somehow
> > get status from the FPU but the obvious way of claring the flag and
> > reading them after each operation is too slow. So maybe using
> > exceptions and only clearing when actually there's a change could be
> > faster.
> >
> > As to how to use exceptions see this message in above thread:
> >
> > https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00005.html
> >
> > But that's only to show how to hook in an exception handler what it
> > does needs to be implemented. Then tested and benchmarked.
> >
> > I still don't know where are the extensive PPC floating point tests to
> > use for checking results though as that was never answered.
>
> Specifically for PPC we don't have them. We use the softfloat test cases
> to exercise our softfloat/hardfloat code as part of "make
> check-softfloat". You can also re-build fp-bench for each guest target
> to measure raw throughput.
>
> >> However in short the problem is if the float_flag_inexact is clear you
> >> must use softfloat so you can properly calculate the inexact status. W=
e
> >> can't take advantage of the inexact stickiness without loosing the
> >> fidelity of the calculation.
> >
> > I still don't get why can't we use hardware via exception handler to
> > detect flags for us and why do we only use hardfloat in some corner
> > cases. If reading the status is too costly then we could mirror it in
> > a global which is set by an FP exception handler. Shouldn't that be
> > faster? Is there a reason that can't work?
>
> It would work but it would be slow. Almost every FP operation sets
> the inexact flag so it would generate an exception and exceptions take
> time to process.
>
> For the guests where we use hardfloat operations with inexact already
> latched is not a corner case - it is the common case which is why it
> helps.
>
> >
> > Regards,
> > BALATON Zoltan
>
>
> --
> Alex Benn=C3=A9e
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000c4a1ae05a44c41a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am confusing why only=C2=A0

inexact=C2=A0 are set then we can use hard-float.<div>And PPC always cleari=
ng

inexact=C2=A0 flag before calling to soft-float funcitons. so we can not=C2=
=A0</div><div>optimize it with hard-float.</div><div>I need some resouces=
=C2=A0about ineact=C2=A0flag and why always clearing inexcat in PPC FP simu=
altion.</div><div>I am looking for two possible solution:</div><div>1. do n=
ot clear inexact flag in PPC simulation</div><div>2. even the inexact are c=
leared, we can still use alternative hard-float.</div><div><br></div><div>B=
ut now I am the beginner, Have no clue about all the things.=C2=A0</div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Mon, Apr 27, 2020 at 7:10 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.be=
nnee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><br>
BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blank">=
balaton@eik.bme.hu</a>&gt; writes:<br>
<br>
&gt; On Mon, 27 Apr 2020, Alex Benn=C3=A9e wrote:<br>
&gt;&gt; =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailto:lu=
oyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; writes=
:<br>
&gt;&gt;&gt; Because ppc fpu-helper are always clearing float_flag_inexact,=
<br>
&gt;&gt;&gt; So is that possible to optimize the performance when=C2=A0 flo=
at_flag_inexact<br>
&gt;&gt;&gt; are cleared?<br>
&gt;&gt;<br>
&gt;&gt; There was some discussion about this in the last thread about enab=
ling<br>
&gt;&gt; hardfloat for PPC. See the thread:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 Subject: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC=
<br>
&gt;&gt;=C2=A0 Date: Tue, 18 Feb 2020 18:10:16 +0100<br>
&gt;&gt;=C2=A0 Message-Id: &lt;<a href=3D"mailto:20200218171702.979F074637D=
@zero.eik.bme.hu" target=3D"_blank">20200218171702.979F074637D@zero.eik.bme=
.hu</a>&gt;<br>
&gt;<br>
&gt; I&#39;ve answered this already with link to that thread here:<br>
&gt;<br>
&gt; On Fri, 10 Apr 2020, BALATON Zoltan wrote:<br>
&gt; : Date: Fri, 10 Apr 2020 20:04:53 +0200 (CEST)<br>
&gt; : From: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" targe=
t=3D"_blank">balaton@eik.bme.hu</a>&gt;<br>
&gt; : To: &quot;=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)&quot; &lt;<a hre=
f=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com<=
/a>&gt;<br>
&gt; : Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-=
devel@nongnu.org</a>, Mark Cave-Ayland, John Arbuckle, <a href=3D"mailto:qe=
mu-ppc@nongnu.org" target=3D"_blank">qemu-ppc@nongnu.org</a>, Paul Clarke, =
Howard Spoelstra, David Gibson<br>
&gt; : Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC<br>
&gt; :<br>
&gt; : On Fri, 10 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote=
:<br>
&gt; :&gt; Are this stable now? I&#39;d like to see hard float to be landed=
:)<br>
&gt; :<br>
&gt; : If you want to see hardfloat for PPC then you should read the<br>
&gt; replies to : this patch which can be found here:<br>
&gt; :<br>
&gt; : <a href=3D"http://patchwork.ozlabs.org/patch/1240235/" rel=3D"norefe=
rrer" target=3D"_blank">http://patchwork.ozlabs.org/patch/1240235/</a><br>
&gt; :<br>
&gt; : to understand what&#39;s needed then try to implement the solution w=
ith<br>
&gt; FP : exceptions cached in a global that maybe could work. I won&#39;t =
be<br>
&gt; able to : do that as said here:<br>
&gt; :<br>
&gt; : <a href=3D"https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/ms=
g00006.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/=
archive/html/qemu-ppc/2020-03/msg00006.html</a><br>
&gt; :<br>
&gt; : because I don&#39;t have time to learn all the details needed. I thi=
nk :<br>
&gt; others are in the same situation so unless somebody puts in the :<br>
&gt; necessary effort this won&#39;t change.<br>
&gt;<br>
&gt; Which also had a proposed solution to the problem that you could try<b=
r>
&gt; to implement, in particular see this message:<br>
&gt;<br>
&gt; <a href=3D"http://patchwork.ozlabs.org/project/qemu-devel/patch/202002=
18171702.979F074637D@zero.eik.bme.hu/#2375124" rel=3D"noreferrer" target=3D=
"_blank">http://patchwork.ozlabs.org/project/qemu-devel/patch/2020021817170=
2.979F074637D@zero.eik.bme.hu/#2375124</a><br>
&gt;<br>
&gt; amd Richard&#39;s reply immediately below that. In short to optimise F=
PU<br>
&gt; emulation we would either find a way to compute inexact flag quickly <=
br>
&gt; without reading the FPU status (this may not be possible) or somehow<b=
r>
&gt; get status from the FPU but the obvious way of claring the flag and<br=
>
&gt; reading them after each operation is too slow. So maybe using<br>
&gt; exceptions and only clearing when actually there&#39;s a change could =
be<br>
&gt; faster.<br>
&gt;<br>
&gt; As to how to use exceptions see this message in above thread:<br>
&gt;<br>
&gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg0=
0005.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/ar=
chive/html/qemu-ppc/2020-03/msg00005.html</a><br>
&gt;<br>
&gt; But that&#39;s only to show how to hook in an exception handler what i=
t<br>
&gt; does needs to be implemented. Then tested and benchmarked.<br>
&gt;<br>
&gt; I still don&#39;t know where are the extensive PPC floating point test=
s to<br>
&gt; use for checking results though as that was never answered.<br>
<br>
Specifically for PPC we don&#39;t have them. We use the softfloat test case=
s<br>
to exercise our softfloat/hardfloat code as part of &quot;make<br>
check-softfloat&quot;. You can also re-build fp-bench for each guest target=
<br>
to measure raw throughput.<br>
<br>
&gt;&gt; However in short the problem is if the float_flag_inexact is clear=
 you<br>
&gt;&gt; must use softfloat so you can properly calculate the inexact statu=
s. We<br>
&gt;&gt; can&#39;t take advantage of the inexact stickiness without loosing=
 the<br>
&gt;&gt; fidelity of the calculation.<br>
&gt;<br>
&gt; I still don&#39;t get why can&#39;t we use hardware via exception hand=
ler to<br>
&gt; detect flags for us and why do we only use hardfloat in some corner<br=
>
&gt; cases. If reading the status is too costly then we could mirror it in<=
br>
&gt; a global which is set by an FP exception handler. Shouldn&#39;t that b=
e<br>
&gt; faster? Is there a reason that can&#39;t work?<br>
<br>
It would work but it would be slow. Almost every FP operation sets<br>
the inexact flag so it would generate an exception and exceptions take<br>
time to process.<br>
<br>
For the guests where we use hardfloat operations with inexact already<br>
latched is not a corner case - it is the common case which is why it<br>
helps.<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; BALATON Zoltan<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000c4a1ae05a44c41a6--

