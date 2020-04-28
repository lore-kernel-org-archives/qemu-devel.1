Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE14EC83009
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB460206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACezYvVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB460206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRLn-0003Vl-PW
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jTRKE-00018Z-NX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jTRJt-0003lO-7e
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:35:06 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236]:42281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jTRFI-0006He-K9; Tue, 28 Apr 2020 10:30:00 -0400
Received: by mail-lj1-x236.google.com with SMTP id a21so21702150ljb.9;
 Tue, 28 Apr 2020 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=g8+GZKcUQHgQYZZ95fi9lhigVcG4gbt3gF74T2FLhbk=;
 b=ACezYvVdda7J6YhmWV6UVZeeyy1YCkzQc4rZpuXS03TIXfSOdHsd1ItMfmWtohCYFs
 ByemWLSBMFA+qQpIRYlFvvo3F+XRalHJ6//tkvCFUjQAKLOQnM3uYDaiFm44HaW2Y4at
 dL7A0j/mnB6TJBuC3eZ5egZP3sQ+Maz/pwqU/E0wOA9t41fYN/se75DvAXotmxBlg4lT
 NxIIT11N7QI/9XJU+uWlyd1GPaSsWFAtVx8ZuXyvYfr1/ztAip1NNLYBxB+GiuUOoxlL
 CZZB87J967l/F/0v3T+KRv1LIyMZWXFe5PPLbccYPBLT30atv4XjIB+eJGhlz4HAL15S
 wg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=g8+GZKcUQHgQYZZ95fi9lhigVcG4gbt3gF74T2FLhbk=;
 b=otRnr5RKVYUlZeTaORH+jLD8n8l4o6mlh8dFf66zFYgcHWl3u9Iz42O5gmrDE00OMi
 KfZXaXNqF11v+oWgix6OjMgMPxHTWoZ+gxj9XZst7LtuAWNcMAwxe1+vzwnRb6+fyMrL
 DANxGZ3Lt7cb8Cjmr3gpucx86WHVNk6txPySigkiNzAXi+uw5szeqREWfL9RU4HYyBKZ
 ukLdFe/UUee4FLJMlJGcViPonOH377BSgcG+zvi4DrSEovnCLDdhrW+U7I/NXXuHprpi
 U8xcGjHsvsbpy96X0OO4WAdxqsF7znJ8JmGXw8/spObAqh186lcva60trwa/qgG/rurK
 ol0g==
X-Gm-Message-State: AGi0PuYWZU0cQcRdVMTkUAAEK8gi3SrgJsLtUW3NKXauMfM0NA/e10Ng
 VRA/5wF4mUVs5x00RCYMmAPPrQU6zacolQ/v3hQ=
X-Google-Smtp-Source: APiQypJtsbwxGcTrEdRmmXSFONbnM+OS1xjxMbpao4XTWiFS1C3g6T1uLm4Ifga1Ne7uDAqxT7M5buPe0IGB8UG6d8Y=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr9400498ljm.165.1588084197746; 
 Tue, 28 Apr 2020 07:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
In-Reply-To: <87ftcoknvu.fsf@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 28 Apr 2020 22:29:48 +0800
Message-ID: <CAE2XoE87iBAKzToSgzyX4Dvm8C_=J6Q5i09gi42wkd+ycEOd2A@mail.gmail.com>
Subject: Re: About hardfloat in ppc
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007aec5605a45aaa8d"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::236
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

--0000000000007aec5605a45aaa8d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 4:36 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:
>
> > I am confusing why only  inexact  are set then we can use hard-float.
>
> The inexact behaviour of the host hardware may be different from the
> guest architecture we are trying to emulate and the host hardware may
> not be configurable to emulate the guest mode.
>
> Have a look in softfloat.c and see all the places where
> float_flag_inexact is set. Can you convince yourself that the host
> hardware will do the same?
>
> > And PPC always clearing inexact  flag before calling to soft-float
> > funcitons. so we can not
> > optimize it with hard-float.
> > I need some resouces about ineact flag and why always clearing inexcat =
in
> > PPC FP simualtion.
>
> Because that is the behaviour of the PPC floating point unit. The
> inexact flag will represent the last operation done.
>
> > I am looking for two possible solution:
> > 1. do not clear inexact flag in PPC simulation
> > 2. even the inexact are cleared, we can still use alternative hard-floa=
t.
> >
> > But now I am the beginner, Have no clue about all the things.
>
> Well you'll need to learn about floating point because these are rather
> fundamental aspects of it's behaviour. In the old days QEMU used to use
> the host floating point processor with it's template based translation.
> However this led to lots of weird bugs because the floating point
> answers under qemu where different from the target it was trying to
> emulate. It was for this reason softfloat was introduced. The hardfloat
> optimisation can only be done when we are confident that we will get the
> exact same answer of the target we are trying to emulate - a "faster but
> incorrect" mode is just going to cause confusion as discussed in the
> previous thread. Have you read that yet?
>
Yeap, I've alredy read that carefully, and I know for PPC now there is no
fast and correct way to
do hard float emulation, And my intention is to finding a possible way to
do fast and correct way to
do hard float emulation for PPC target at least under x86 host.

>
> >
> > On Mon, Apr 27, 2020 at 7:10 PM Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
> wrote:
> >
> >>
> >> BALATON Zoltan <balaton@eik.bme.hu> writes:
> >>
> >> > On Mon, 27 Apr 2020, Alex Benn=C3=A9e wrote:
> >> >> =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> w=
rites:
> >> >>> Because ppc fpu-helper are always clearing float_flag_inexact,
> >> >>> So is that possible to optimize the performance when
> >> float_flag_inexact
> >> >>> are cleared?
> >> >>
> >> >> There was some discussion about this in the last thread about
> enabling
> >> >> hardfloat for PPC. See the thread:
> >> >>
> >> >>  Subject: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
> >> >>  Date: Tue, 18 Feb 2020 18:10:16 +0100
> >> >>  Message-Id: <20200218171702.979F074637D@zero.eik.bme.hu>
> >> >
> >> > I've answered this already with link to that thread here:
> >> >
> >> > On Fri, 10 Apr 2020, BALATON Zoltan wrote:
> >> > : Date: Fri, 10 Apr 2020 20:04:53 +0200 (CEST)
> >> > : From: BALATON Zoltan <balaton@eik.bme.hu>
> >> > : To: "=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)" <luoyonggang@gmail=
.com>
> >> > : Cc: qemu-devel@nongnu.org, Mark Cave-Ayland, John Arbuckle,
> >> qemu-ppc@nongnu.org, Paul Clarke, Howard Spoelstra, David Gibson
> >> > : Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
> >> > :
> >> > : On Fri, 10 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wro=
te:
> >> > :> Are this stable now? I'd like to see hard float to be landed:)
> >> > :
> >> > : If you want to see hardfloat for PPC then you should read the
> >> > replies to : this patch which can be found here:
> >> > :
> >> > : http://patchwork.ozlabs.org/patch/1240235/
> >> > :
> >> > : to understand what's needed then try to implement the solution wit=
h
> >> > FP : exceptions cached in a global that maybe could work. I won't be
> >> > able to : do that as said here:
> >> > :
> >> > :
> https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00006.html
> >> > :
> >> > : because I don't have time to learn all the details needed. I think=
 :
> >> > others are in the same situation so unless somebody puts in the :
> >> > necessary effort this won't change.
> >> >
> >> > Which also had a proposed solution to the problem that you could try
> >> > to implement, in particular see this message:
> >> >
> >> >
> >>
> http://patchwork.ozlabs.org/project/qemu-devel/patch/20200218171702.979F0=
74637D@zero.eik.bme.hu/#2375124
> >> >
> >> > amd Richard's reply immediately below that. In short to optimise FPU
> >> > emulation we would either find a way to compute inexact flag quickly
> >> > without reading the FPU status (this may not be possible) or somehow
> >> > get status from the FPU but the obvious way of claring the flag and
> >> > reading them after each operation is too slow. So maybe using
> >> > exceptions and only clearing when actually there's a change could be
> >> > faster.
> >> >
> >> > As to how to use exceptions see this message in above thread:
> >> >
> >> > https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00005.html
> >> >
> >> > But that's only to show how to hook in an exception handler what it
> >> > does needs to be implemented. Then tested and benchmarked.
> >> >
> >> > I still don't know where are the extensive PPC floating point tests =
to
> >> > use for checking results though as that was never answered.
> >>
> >> Specifically for PPC we don't have them. We use the softfloat test cas=
es
> >> to exercise our softfloat/hardfloat code as part of "make
> >> check-softfloat". You can also re-build fp-bench for each guest target
> >> to measure raw throughput.
> >>
> >> >> However in short the problem is if the float_flag_inexact is clear
> you
> >> >> must use softfloat so you can properly calculate the inexact status=
.
> We
> >> >> can't take advantage of the inexact stickiness without loosing the
> >> >> fidelity of the calculation.
> >> >
> >> > I still don't get why can't we use hardware via exception handler to
> >> > detect flags for us and why do we only use hardfloat in some corner
> >> > cases. If reading the status is too costly then we could mirror it i=
n
> >> > a global which is set by an FP exception handler. Shouldn't that be
> >> > faster? Is there a reason that can't work?
> >>
> >> It would work but it would be slow. Almost every FP operation sets
> >> the inexact flag so it would generate an exception and exceptions take
> >> time to process.
> >>
> >> For the guests where we use hardfloat operations with inexact already
> >> latched is not a corner case - it is the common case which is why it
> >> helps.
> >>
> >> >
> >> > Regards,
> >> > BALATON Zoltan
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


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000007aec5605a45aaa8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 28, 2020 at 4:36 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailto:luoyonggang=
@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; writes:<br>
<br>
&gt; I am confusing why only=C2=A0 inexact=C2=A0 are set then we can use ha=
rd-float.<br>
<br>
The inexact behaviour of the host hardware may be different from the<br>
guest architecture we are trying to emulate and the host hardware may<br>
not be configurable to emulate the guest mode.<br>
<br>
Have a look in softfloat.c and see all the places where<br>
float_flag_inexact is set. Can you convince yourself that the host<br>
hardware will do the same?<br>
<br>
&gt; And PPC always clearing inexact=C2=A0 flag before calling to soft-floa=
t<br>
&gt; funcitons. so we can not<br>
&gt; optimize it with hard-float.<br>
&gt; I need some resouces about ineact flag and why always clearing inexcat=
 in<br>
&gt; PPC FP simualtion.<br>
<br>
Because that is the behaviour of the PPC floating point unit. The<br>
inexact flag will represent the last operation done.<br>
<br>
&gt; I am looking for two possible solution:<br>
&gt; 1. do not clear inexact flag in PPC simulation<br>
&gt; 2. even the inexact are cleared, we can still use alternative hard-flo=
at.<br>
&gt;<br>
&gt; But now I am the beginner, Have no clue about all the things.<br>
<br>
Well you&#39;ll need to learn about floating point because these are rather=
<br>
fundamental aspects of it&#39;s behaviour. In the old days QEMU used to use=
<br>
the host floating point processor with it&#39;s template based translation.=
<br>
However this led to lots of weird bugs because the floating point<br>
answers under qemu where different from the target it was trying to<br>
emulate. It was for this reason softfloat was introduced. The hardfloat<br>
optimisation can only be done when we are confident that we will get the<br=
>
exact same answer of the target we are trying to emulate - a &quot;faster b=
ut<br>
incorrect&quot; mode is just going to cause confusion as discussed in the<b=
r>
previous thread. Have you read that yet?<br></blockquote><div>Yeap, I&#39;v=
e alredy read that carefully, and I know for PPC now there is no fast and c=
orrect way to</div><div>do hard float emulation, And my intention is to fin=
ding a possible way to do fast and correct way to=C2=A0</div><div>do hard f=
loat emulation for PPC target at least under x86 host.=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; On Mon, Apr 27, 2020 at 7:10 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D=
"_blank">balaton@eik.bme.hu</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Mon, 27 Apr 2020, Alex Benn=C3=A9e wrote:<br>
&gt;&gt; &gt;&gt; =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=3D"=
mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&g=
t; writes:<br>
&gt;&gt; &gt;&gt;&gt; Because ppc fpu-helper are always clearing float_flag=
_inexact,<br>
&gt;&gt; &gt;&gt;&gt; So is that possible to optimize the performance when<=
br>
&gt;&gt; float_flag_inexact<br>
&gt;&gt; &gt;&gt;&gt; are cleared?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; There was some discussion about this in the last thread a=
bout enabling<br>
&gt;&gt; &gt;&gt; hardfloat for PPC. See the thread:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 Subject: [RFC PATCH v2] target/ppc: Enable hardfloa=
t for PPC<br>
&gt;&gt; &gt;&gt;=C2=A0 Date: Tue, 18 Feb 2020 18:10:16 +0100<br>
&gt;&gt; &gt;&gt;=C2=A0 Message-Id: &lt;<a href=3D"mailto:20200218171702.97=
9F074637D@zero.eik.bme.hu" target=3D"_blank">20200218171702.979F074637D@zer=
o.eik.bme.hu</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I&#39;ve answered this already with link to that thread here:=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Fri, 10 Apr 2020, BALATON Zoltan wrote:<br>
&gt;&gt; &gt; : Date: Fri, 10 Apr 2020 20:04:53 +0200 (CEST)<br>
&gt;&gt; &gt; : From: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.=
hu" target=3D"_blank">balaton@eik.bme.hu</a>&gt;<br>
&gt;&gt; &gt; : To: &quot;=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)&quot; &=
lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@g=
mail.com</a>&gt;<br>
&gt;&gt; &gt; : Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_bla=
nk">qemu-devel@nongnu.org</a>, Mark Cave-Ayland, John Arbuckle,<br>
&gt;&gt; <a href=3D"mailto:qemu-ppc@nongnu.org" target=3D"_blank">qemu-ppc@=
nongnu.org</a>, Paul Clarke, Howard Spoelstra, David Gibson<br>
&gt;&gt; &gt; : Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat fo=
r PPC<br>
&gt;&gt; &gt; :<br>
&gt;&gt; &gt; : On Fri, 10 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang L=
uo) wrote:<br>
&gt;&gt; &gt; :&gt; Are this stable now? I&#39;d like to see hard float to =
be landed:)<br>
&gt;&gt; &gt; :<br>
&gt;&gt; &gt; : If you want to see hardfloat for PPC then you should read t=
he<br>
&gt;&gt; &gt; replies to : this patch which can be found here:<br>
&gt;&gt; &gt; :<br>
&gt;&gt; &gt; : <a href=3D"http://patchwork.ozlabs.org/patch/1240235/" rel=
=3D"noreferrer" target=3D"_blank">http://patchwork.ozlabs.org/patch/1240235=
/</a><br>
&gt;&gt; &gt; :<br>
&gt;&gt; &gt; : to understand what&#39;s needed then try to implement the s=
olution with<br>
&gt;&gt; &gt; FP : exceptions cached in a global that maybe could work. I w=
on&#39;t be<br>
&gt;&gt; &gt; able to : do that as said here:<br>
&gt;&gt; &gt; :<br>
&gt;&gt; &gt; : <a href=3D"https://lists.nongnu.org/archive/html/qemu-ppc/2=
020-03/msg00006.html" rel=3D"noreferrer" target=3D"_blank">https://lists.no=
ngnu.org/archive/html/qemu-ppc/2020-03/msg00006.html</a><br>
&gt;&gt; &gt; :<br>
&gt;&gt; &gt; : because I don&#39;t have time to learn all the details need=
ed. I think :<br>
&gt;&gt; &gt; others are in the same situation so unless somebody puts in t=
he :<br>
&gt;&gt; &gt; necessary effort this won&#39;t change.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Which also had a proposed solution to the problem that you co=
uld try<br>
&gt;&gt; &gt; to implement, in particular see this message:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; <a href=3D"http://patchwork.ozlabs.org/project/qemu-devel/patch/20=
200218171702.979F074637D@zero.eik.bme.hu/#2375124" rel=3D"noreferrer" targe=
t=3D"_blank">http://patchwork.ozlabs.org/project/qemu-devel/patch/202002181=
71702.979F074637D@zero.eik.bme.hu/#2375124</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; amd Richard&#39;s reply immediately below that. In short to o=
ptimise FPU<br>
&gt;&gt; &gt; emulation we would either find a way to compute inexact flag =
quickly<br>
&gt;&gt; &gt; without reading the FPU status (this may not be possible) or =
somehow<br>
&gt;&gt; &gt; get status from the FPU but the obvious way of claring the fl=
ag and<br>
&gt;&gt; &gt; reading them after each operation is too slow. So maybe using=
<br>
&gt;&gt; &gt; exceptions and only clearing when actually there&#39;s a chan=
ge could be<br>
&gt;&gt; &gt; faster.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; As to how to use exceptions see this message in above thread:=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-ppc/202=
0-03/msg00005.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nong=
nu.org/archive/html/qemu-ppc/2020-03/msg00005.html</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; But that&#39;s only to show how to hook in an exception handl=
er what it<br>
&gt;&gt; &gt; does needs to be implemented. Then tested and benchmarked.<br=
>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I still don&#39;t know where are the extensive PPC floating p=
oint tests to<br>
&gt;&gt; &gt; use for checking results though as that was never answered.<b=
r>
&gt;&gt;<br>
&gt;&gt; Specifically for PPC we don&#39;t have them. We use the softfloat =
test cases<br>
&gt;&gt; to exercise our softfloat/hardfloat code as part of &quot;make<br>
&gt;&gt; check-softfloat&quot;. You can also re-build fp-bench for each gue=
st target<br>
&gt;&gt; to measure raw throughput.<br>
&gt;&gt;<br>
&gt;&gt; &gt;&gt; However in short the problem is if the float_flag_inexact=
 is clear you<br>
&gt;&gt; &gt;&gt; must use softfloat so you can properly calculate the inex=
act status. We<br>
&gt;&gt; &gt;&gt; can&#39;t take advantage of the inexact stickiness withou=
t loosing the<br>
&gt;&gt; &gt;&gt; fidelity of the calculation.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I still don&#39;t get why can&#39;t we use hardware via excep=
tion handler to<br>
&gt;&gt; &gt; detect flags for us and why do we only use hardfloat in some =
corner<br>
&gt;&gt; &gt; cases. If reading the status is too costly then we could mirr=
or it in<br>
&gt;&gt; &gt; a global which is set by an FP exception handler. Shouldn&#39=
;t that be<br>
&gt;&gt; &gt; faster? Is there a reason that can&#39;t work?<br>
&gt;&gt;<br>
&gt;&gt; It would work but it would be slow. Almost every FP operation sets=
<br>
&gt;&gt; the inexact flag so it would generate an exception and exceptions =
take<br>
&gt;&gt; time to process.<br>
&gt;&gt;<br>
&gt;&gt; For the guests where we use hardfloat operations with inexact alre=
ady<br>
&gt;&gt; latched is not a corner case - it is the common case which is why =
it<br>
&gt;&gt; helps.<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Regards,<br>
&gt;&gt; &gt; BALATON Zoltan<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Alex Benn=C3=A9e<br>
&gt;&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000007aec5605a45aaa8d--

