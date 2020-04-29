Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353D1C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C422072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnFiQ0Ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C422072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlyg-00026f-51
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jTlug-0005da-2J
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jTlub-0007EL-Pf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:34:05 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:40650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jTluC-0006gq-55; Wed, 29 Apr 2020 08:33:36 -0400
Received: by mail-lj1-x22a.google.com with SMTP id y4so2396499ljn.7;
 Wed, 29 Apr 2020 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=czth14zIIqiaE4wTI0V7ysNruKqgZDtST/ndQsNxImg=;
 b=XnFiQ0CtiQvUaGuxjgop+UyLwQgrMBY04ThAGk0tIFkpI9idnEhpD59Daum77k6hWY
 oMwhkObMtHPN1BRAoO+wrV2BvLYetcyTcKCq8o/FiP8THD64GaKVDuDrCL4vp7jglXVq
 1sxd7JyM7YNhOuJxMrk8ANmBWJ9sChqezimwjjCsBdHAVXO+urhEsHOBRQKKGsqb5Pm6
 FNJfv+zc0OIQUzI0Hqke5shogO0gsRc8VGYvqW3SQpXh5ILSyFVeBxl7V5SpfrB9dErM
 A2wbWRXrGTcVECzeii0NOnILAyo8O3RbqLpThEoj2/NgP/Y3gQtgjkAgb2HpqKow6NUi
 aFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=czth14zIIqiaE4wTI0V7ysNruKqgZDtST/ndQsNxImg=;
 b=OwstUFhk2vRUDsmxO5DUkaeridb96Q8ol5mSG6QzC7UfqAwhsJJToKcYtNF2uXyeHJ
 uqqr4pJVOS/PrzMLKKGHA0scWyXLS5im1f2UL3KkdBJ7No4wfd70LIZ7tFbi+GqswHyY
 3hNn9+ZqnyfKz8S1CxZU40yUTv7o1X3b2GBi2GBqAge0QyLgfdmln+coFHI9L9twLQZV
 xyf6xATLZz6zrxmkUCX+sZRYsXba3NzpgpIElGp9ubN26f+kIf/V/AYqDXo9ZaKScPCD
 5pZ/ba5RCsG13sDIDXg9GHunmhD0WZa55lgOIUptzP8/mOS460gUCIyWgv5gE/xWNe+P
 PPJQ==
X-Gm-Message-State: AGi0Pubs3jVag7hFxTqn19iMUG5E8hVa4intBywxmu54zR3k+1DbBNQ8
 4QDuDDMieAQmSXL9x56zV2btI+pUe5H3dbhwM40=
X-Google-Smtp-Source: APiQypLqJ6oSciePA+zmBNJgdYlCjqcGHnUP4ZSSZAI6evOwQjDKc0luxD19Z2PupeDy3ogZxzL8r69nAMgQpC6RLiY=
X-Received: by 2002:a2e:800f:: with SMTP id j15mr21165196ljg.27.1588163605243; 
 Wed, 29 Apr 2020 05:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
In-Reply-To: <871ro6ld2f.fsf@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 29 Apr 2020 20:33:13 +0800
Message-ID: <CAE2XoE-6bRUsgJ2rvcb6Wb_OqSDoQEkMy2T==h_qjU5k7XawPA@mail.gmail.com>
Subject: Re: R: About hardfloat in ppc
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000089300105a46d271f"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::22a
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000089300105a46d271f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 7:57 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Dino Papararo <skizzato73@msn.com> writes:
>
> > Hello,
> > about handling of PPC fpu exceptions and Hard Floats support we could
> consider a different approach for different instructions.
> > i.e. not all fpu instructions take care about inexact or exceptions
> bits: if I take a simple fadd f0,f1,f2 I'll copy value derived from addin=
g
> f1+f2 into f1 register and no one will check about inexact or exception
> bits raised into FPSCR register.
> > Instead if I'll take fadd. f0,f1,f2 the dot following the add
> instructions means I want take inexact or exceptions bits into account.
> > So I could use hard floats for first case and softfloats for second cas=
e.
> > Could this be a fast solution to start implement hard floats for PPC??
>
> While it may be true that normal software practice is not to read the
> exception registers for every operation we can't base our emulation on
> that. We must always be able to re-create the state of the exception
> registers whenever they may be read by the program. There are 3 cases
> this may happen:
>
>   - a direct read of the inexact register
>   - checking the sigcontext of a synchronous exception (e.g. fault)
>   - checking the sigcontext of an asynchronous exception (e.g. timer/IPI)
>
> Given the way the translator works we can simplify the asynchronous case
> because we know they are only ever delivered at the start of translated
> blocks. We must have a fully rectified system state at the end of every
> block. So lets consider some cases:
>
>   fpOpA
>   clear flags
>   fpOpB
>   clear flags
>   fpOpC
>   read flags
>
So we only need clear flags for before the fp op that are running before
the read flags are
triggered?  So the key point is finding all the read flags op, and find the
latest clear flags op
before the latest fp op instuction that before the read flags. May this be
expressed in TCG ops?



>
> Assuming we know the fpOps can't generate exceptions we can know that
> only fpOpC will ever generate a user visible floating point flags so we
> can indeed use hardfloat for fpOpA and fpOpB. However if we see the
> pattern:
>
>   fpOpA
>   ld/st
>
What does ld/st means? load and store float point values?


>   clear flags
>   fpOpB
>   read flags
>
> we must have the fully rectified version of the flags because the ld/st
> may fault. However it's not guaranteed it will fault so we could defer
> the flag calculation for fpOpA until such time as we need it. The
> easiest way would be to save the values going into the operation and
> then re-run it in softfloat when required (hopefully never ;-).
>
> A lot will depend on the behaviour of the architecture. For example:
>
>   fpOpA
>   fpOpB
>   read flags
>
> whether or not we need to be able to calculate the flags for fpOpA will
> depend on if fpOpB completely resets the flags visible or if the result
> is additive.
>
> So in short I think there may be scope for using hardfloat but it will
> require knowledge of front-end knowing if it is safe to skip flag
> calculation in particular cases. We might even need support within TCG
> for saving (and marking) temporaries over potentially faulting
> boundaries so these lazy evaluations can be done. We can certainly add a
> fp-status less set of primitives to softfloat which can use the
> hardfloat path when we know we are using normal numbers.
>
> >
> > A little of documentation here:
> http://mirror.informatimago.com/next/developer.apple.com/documentation/ma=
c/PPCNumerics/PPCNumerics-154.html
> >
> > Regards,
> > Dino Papararo
> >
> > -----Messaggio originale-----
> > Da: Qemu-devel <qemu-devel-bounces+skizzato73=3Dmsn.com@nongnu.org> Per
> conto di Alex Benn=C3=A9e
> > Inviato: marted=C3=AC 28 aprile 2020 10:37
> > A: luoyonggang@gmail.com
> > Cc: qemu-ppc@nongnu.org; qemu-devel@nongnu.org
> > Oggetto: Re: About hardfloat in ppc
> >
> >
> > =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> write=
s:
> >
> >> I am confusing why only  inexact  are set then we can use hard-float.
> >
> > The inexact behaviour of the host hardware may be different from the
> guest architecture we are trying to emulate and the host hardware may not
> be configurable to emulate the guest mode.
> >
> > Have a look in softfloat.c and see all the places where
> float_flag_inexact is set. Can you convince yourself that the host hardwa=
re
> will do the same?
> >
> >> And PPC always clearing inexact  flag before calling to soft-float
> >> funcitons. so we can not optimize it with hard-float.
> >> I need some resouces about ineact flag and why always clearing inexcat
> >> in PPC FP simualtion.
> >
> > Because that is the behaviour of the PPC floating point unit. The
> inexact flag will represent the last operation done.
> >
> >> I am looking for two possible solution:
> >> 1. do not clear inexact flag in PPC simulation 2. even the inexact are
> >> cleared, we can still use alternative hard-float.
> >>
> >> But now I am the beginner, Have no clue about all the things.
> >
> > Well you'll need to learn about floating point because these are rather
> fundamental aspects of it's behaviour. In the old days QEMU used to use t=
he
> host floating point processor with it's template based translation.
> > However this led to lots of weird bugs because the floating point
> answers under qemu where different from the target it was trying to
> emulate. It was for this reason softfloat was introduced. The hardfloat
> optimisation can only be done when we are confident that we will get the
> exact same answer of the target we are trying to emulate - a "faster but
> incorrect" mode is just going to cause confusion as discussed in the
> previous thread. Have you read that yet?
> >
> >>
> >> On Mon, Apr 27, 2020 at 7:10 PM Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg>
> wrote:
> >>
> >>>
> >>> BALATON Zoltan <balaton@eik.bme.hu> writes:
> >>>
> >>> > On Mon, 27 Apr 2020, Alex Benn=C3=A9e wrote:
> >>> >> =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> =
writes:
> >>> >>> Because ppc fpu-helper are always clearing float_flag_inexact, So
> >>> >>> is that possible to optimize the performance when
> >>> float_flag_inexact
> >>> >>> are cleared?
> >>> >>
> >>> >> There was some discussion about this in the last thread about
> >>> >> enabling hardfloat for PPC. See the thread:
> >>> >>
> >>> >>  Subject: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
> >>> >>  Date: Tue, 18 Feb 2020 18:10:16 +0100
> >>> >>  Message-Id: <20200218171702.979F074637D@zero.eik.bme.hu>
> >>> >
> >>> > I've answered this already with link to that thread here:
> >>> >
> >>> > On Fri, 10 Apr 2020, BALATON Zoltan wrote:
> >>> > : Date: Fri, 10 Apr 2020 20:04:53 +0200 (CEST)
> >>> > : From: BALATON Zoltan <balaton@eik.bme.hu>
> >>> > : To: "=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)" <luoyonggang@gmai=
l.com>
> >>> > : Cc: qemu-devel@nongnu.org, Mark Cave-Ayland, John Arbuckle,
> >>> qemu-ppc@nongnu.org, Paul Clarke, Howard Spoelstra, David Gibson
> >>> > : Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
> >>> > :
> >>> > : On Fri, 10 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wr=
ote:
> >>> > :> Are this stable now? I'd like to see hard float to be landed:)
> >>> > :
> >>> > : If you want to see hardfloat for PPC then you should read the
> >>> > replies to : this patch which can be found here:
> >>> > :
> >>> > : http://patchwork.ozlabs.org/patch/1240235/
> >>> > :
> >>> > : to understand what's needed then try to implement the solution
> >>> > with FP : exceptions cached in a global that maybe could work. I
> >>> > won't be able to : do that as said here:
> >>> > :
> >>> > :
> >>> > https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00006.htm
> >>> > l
> >>> > :
> >>> > : because I don't have time to learn all the details needed. I thin=
k
> :
> >>> > others are in the same situation so unless somebody puts in the :
> >>> > necessary effort this won't change.
> >>> >
> >>> > Which also had a proposed solution to the problem that you could
> >>> > try to implement, in particular see this message:
> >>> >
> >>> >
> >>> http://patchwork.ozlabs.org/project/qemu-devel/patch/20200218171702.9
> >>> 79F074637D@zero.eik.bme.hu/#2375124
> >>> >
> >>> > amd Richard's reply immediately below that. In short to optimise
> >>> > FPU emulation we would either find a way to compute inexact flag
> >>> > quickly without reading the FPU status (this may not be possible)
> >>> > or somehow get status from the FPU but the obvious way of claring
> >>> > the flag and reading them after each operation is too slow. So
> >>> > maybe using exceptions and only clearing when actually there's a
> >>> > change could be faster.
> >>> >
> >>> > As to how to use exceptions see this message in above thread:
> >>> >
> >>> > https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00005.htm
> >>> > l
> >>> >
> >>> > But that's only to show how to hook in an exception handler what it
> >>> > does needs to be implemented. Then tested and benchmarked.
> >>> >
> >>> > I still don't know where are the extensive PPC floating point tests
> >>> > to use for checking results though as that was never answered.
> >>>
> >>> Specifically for PPC we don't have them. We use the softfloat test
> >>> cases to exercise our softfloat/hardfloat code as part of "make
> >>> check-softfloat". You can also re-build fp-bench for each guest
> >>> target to measure raw throughput.
> >>>
> >>> >> However in short the problem is if the float_flag_inexact is clear
> >>> >> you must use softfloat so you can properly calculate the inexact
> >>> >> status. We can't take advantage of the inexact stickiness without
> >>> >> loosing the fidelity of the calculation.
> >>> >
> >>> > I still don't get why can't we use hardware via exception handler
> >>> > to detect flags for us and why do we only use hardfloat in some
> >>> > corner cases. If reading the status is too costly then we could
> >>> > mirror it in a global which is set by an FP exception handler.
> >>> > Shouldn't that be faster? Is there a reason that can't work?
> >>>
> >>> It would work but it would be slow. Almost every FP operation sets
> >>> the inexact flag so it would generate an exception and exceptions
> >>> take time to process.
> >>>
> >>> For the guests where we use hardfloat operations with inexact already
> >>> latched is not a corner case - it is the common case which is why it
> >>> helps.
> >>>
> >>> >
> >>> > Regards,
> >>> > BALATON Zoltan
> >>>
> >>>
> >>> --
> >>> Alex Benn=C3=A9e
> >>>
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

--00000000000089300105a46d271f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 29, 2020 at 7:57 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
Dino Papararo &lt;<a href=3D"mailto:skizzato73@msn.com" target=3D"_blank">s=
kizzato73@msn.com</a>&gt; writes:<br>
<br>
&gt; Hello,<br>
&gt; about handling of PPC fpu exceptions and Hard Floats support we could =
consider a different approach for different instructions.<br>
&gt; i.e. not all fpu instructions take care about inexact or exceptions bi=
ts: if I take a simple fadd f0,f1,f2 I&#39;ll copy value derived from addin=
g f1+f2 into f1 register and no one will check about inexact or exception b=
its raised into FPSCR register.<br>
&gt; Instead if I&#39;ll take fadd. f0,f1,f2 the dot following the add inst=
ructions means I want take inexact or exceptions bits into account.<br>
&gt; So I could use hard floats for first case and softfloats for second ca=
se.<br>
&gt; Could this be a fast solution to start implement hard floats for PPC??=
<br>
<br>
While it may be true that normal software practice is not to read the<br>
exception registers for every operation we can&#39;t base our emulation on<=
br>
that. We must always be able to re-create the state of the exception<br>
registers whenever they may be read by the program. There are 3 cases<br>
this may happen:<br>
<br>
=C2=A0 - a direct read of the inexact register<br>
=C2=A0 - checking the sigcontext of a synchronous exception (e.g. fault)<br=
>
=C2=A0 - checking the sigcontext of an asynchronous exception (e.g. timer/I=
PI)<br>
<br>
Given the way the translator works we can simplify the asynchronous case<br=
>
because we know they are only ever delivered at the start of translated<br>
blocks. We must have a fully rectified system state at the end of every<br>
block. So lets consider some cases:<br>
<br>
=C2=A0 fpOpA<br>
=C2=A0 clear flags<br>
=C2=A0 fpOpB<br>
=C2=A0 clear flags<br>
=C2=A0 fpOpC<br>
=C2=A0 read flags<br></blockquote><div>So we only need clear flags for befo=
re the fp op that are running before the read flags are=C2=A0</div><div>tri=
ggered?=C2=A0 So the key point is finding all the read flags op, and find t=
he latest clear flags op</div><div>before the latest fp op instuction=C2=A0=
that before the read flags. May this be expressed in TCG ops?</div><div><br=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Assuming we know the fpOps can&#39;t generate exceptions we can know that<b=
r>
only fpOpC will ever generate a user visible floating point flags so we<br>
can indeed use hardfloat for fpOpA and fpOpB. However if we see the<br>
pattern:<br>
<br>
=C2=A0 fpOpA<br>
=C2=A0 ld/st<br></blockquote><div>What does ld/st means? load and store flo=
at point values?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
=C2=A0 clear flags<br>
=C2=A0 fpOpB<br>
=C2=A0 read flags<br>
<br>
we must have the fully rectified version of the flags because the ld/st<br>
may fault. However it&#39;s not guaranteed it will fault so we could defer<=
br>
the flag calculation for fpOpA until such time as we need it. The<br>
easiest way would be to save the values going into the operation and<br>
then re-run it in softfloat when required (hopefully never ;-).<br>
<br>
A lot will depend on the behaviour of the architecture. For example:<br>
<br>
=C2=A0 fpOpA<br>
=C2=A0 fpOpB<br>
=C2=A0 read flags<br>
<br>
whether or not we need to be able to calculate the flags for fpOpA will<br>
depend on if fpOpB completely resets the flags visible or if the result<br>
is additive.<br>
<br>
So in short I think there may be scope for using hardfloat but it will<br>
require knowledge of front-end knowing if it is safe to skip flag<br>
calculation in particular cases. We might even need support within TCG<br>
for saving (and marking) temporaries over potentially faulting<br>
boundaries so these lazy evaluations can be done. We can certainly add a<br=
>
fp-status less set of primitives to softfloat which can use the<br>
hardfloat path when we know we are using normal numbers.<br>
<br>
&gt;<br>
&gt; A little of documentation here: <a href=3D"http://mirror.informatimago=
.com/next/developer.apple.com/documentation/mac/PPCNumerics/PPCNumerics-154=
.html" rel=3D"noreferrer" target=3D"_blank">http://mirror.informatimago.com=
/next/developer.apple.com/documentation/mac/PPCNumerics/PPCNumerics-154.htm=
l</a><br>
&gt;<br>
&gt; Regards,<br>
&gt; Dino Papararo<br>
&gt;<br>
&gt; -----Messaggio originale-----<br>
&gt; Da: Qemu-devel &lt;qemu-devel-bounces+skizzato73=3D<a href=3D"mailto:m=
sn.com@nongnu.org" target=3D"_blank">msn.com@nongnu.org</a>&gt; Per conto d=
i Alex Benn=C3=A9e<br>
&gt; Inviato: marted=C3=AC 28 aprile 2020 10:37<br>
&gt; A: <a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyongg=
ang@gmail.com</a><br>
&gt; Cc: <a href=3D"mailto:qemu-ppc@nongnu.org" target=3D"_blank">qemu-ppc@=
nongnu.org</a>; <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">=
qemu-devel@nongnu.org</a><br>
&gt; Oggetto: Re: About hardfloat in ppc<br>
&gt;<br>
&gt;<br>
&gt; =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailto:luoyon=
ggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; writes:<br=
>
&gt;<br>
&gt;&gt; I am confusing why only=C2=A0 inexact=C2=A0 are set then we can us=
e hard-float.<br>
&gt;<br>
&gt; The inexact behaviour of the host hardware may be different from the g=
uest architecture we are trying to emulate and the host hardware may not be=
 configurable to emulate the guest mode.<br>
&gt;<br>
&gt; Have a look in softfloat.c and see all the places where float_flag_ine=
xact is set. Can you convince yourself that the host hardware will do the s=
ame?<br>
&gt;<br>
&gt;&gt; And PPC always clearing inexact=C2=A0 flag before calling to soft-=
float <br>
&gt;&gt; funcitons. so we can not optimize it with hard-float.<br>
&gt;&gt; I need some resouces about ineact flag and why always clearing ine=
xcat <br>
&gt;&gt; in PPC FP simualtion.<br>
&gt;<br>
&gt; Because that is the behaviour of the PPC floating point unit. The inex=
act flag will represent the last operation done.<br>
&gt;<br>
&gt;&gt; I am looking for two possible solution:<br>
&gt;&gt; 1. do not clear inexact flag in PPC simulation 2. even the inexact=
 are <br>
&gt;&gt; cleared, we can still use alternative hard-float.<br>
&gt;&gt;<br>
&gt;&gt; But now I am the beginner, Have no clue about all the things.<br>
&gt;<br>
&gt; Well you&#39;ll need to learn about floating point because these are r=
ather fundamental aspects of it&#39;s behaviour. In the old days QEMU used =
to use the host floating point processor with it&#39;s template based trans=
lation.<br>
&gt; However this led to lots of weird bugs because the floating point answ=
ers under qemu where different from the target it was trying to emulate. It=
 was for this reason softfloat was introduced. The hardfloat optimisation c=
an only be done when we are confident that we will get the exact same answe=
r of the target we are trying to emulate - a &quot;faster but incorrect&quo=
t; mode is just going to cause confusion as discussed in the previous threa=
d. Have you read that yet?<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Apr 27, 2020 at 7:10 PM Alex Benn=C3=A9e &lt;<a href=3D"ma=
ilto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&g=
t; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" targe=
t=3D"_blank">balaton@eik.bme.hu</a>&gt; writes:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt; On Mon, 27 Apr 2020, Alex Benn=C3=A9e wrote:<br>
&gt;&gt;&gt; &gt;&gt; =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=
=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</=
a>&gt; writes:<br>
&gt;&gt;&gt; &gt;&gt;&gt; Because ppc fpu-helper are always clearing float_=
flag_inexact, So <br>
&gt;&gt;&gt; &gt;&gt;&gt; is that possible to optimize the performance when=
<br>
&gt;&gt;&gt; float_flag_inexact<br>
&gt;&gt;&gt; &gt;&gt;&gt; are cleared?<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; There was some discussion about this in the last thre=
ad about <br>
&gt;&gt;&gt; &gt;&gt; enabling hardfloat for PPC. See the thread:<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 Subject: [RFC PATCH v2] target/ppc: Enable hard=
float for PPC<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 Date: Tue, 18 Feb 2020 18:10:16 +0100<br>
&gt;&gt;&gt; &gt;&gt;=C2=A0 Message-Id: &lt;<a href=3D"mailto:2020021817170=
2.979F074637D@zero.eik.bme.hu" target=3D"_blank">20200218171702.979F074637D=
@zero.eik.bme.hu</a>&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; I&#39;ve answered this already with link to that thread h=
ere:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; On Fri, 10 Apr 2020, BALATON Zoltan wrote:<br>
&gt;&gt;&gt; &gt; : Date: Fri, 10 Apr 2020 20:04:53 +0200 (CEST)<br>
&gt;&gt;&gt; &gt; : From: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.=
bme.hu" target=3D"_blank">balaton@eik.bme.hu</a>&gt;<br>
&gt;&gt;&gt; &gt; : To: &quot;=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)&quo=
t; &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyongga=
ng@gmail.com</a>&gt;<br>
&gt;&gt;&gt; &gt; : Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"=
_blank">qemu-devel@nongnu.org</a>, Mark Cave-Ayland, John Arbuckle,<br>
&gt;&gt;&gt; <a href=3D"mailto:qemu-ppc@nongnu.org" target=3D"_blank">qemu-=
ppc@nongnu.org</a>, Paul Clarke, Howard Spoelstra, David Gibson<br>
&gt;&gt;&gt; &gt; : Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloa=
t for PPC<br>
&gt;&gt;&gt; &gt; :<br>
&gt;&gt;&gt; &gt; : On Fri, 10 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yongga=
ng Luo) wrote:<br>
&gt;&gt;&gt; &gt; :&gt; Are this stable now? I&#39;d like to see hard float=
 to be landed:)<br>
&gt;&gt;&gt; &gt; :<br>
&gt;&gt;&gt; &gt; : If you want to see hardfloat for PPC then you should re=
ad the <br>
&gt;&gt;&gt; &gt; replies to : this patch which can be found here:<br>
&gt;&gt;&gt; &gt; :<br>
&gt;&gt;&gt; &gt; : <a href=3D"http://patchwork.ozlabs.org/patch/1240235/" =
rel=3D"noreferrer" target=3D"_blank">http://patchwork.ozlabs.org/patch/1240=
235/</a><br>
&gt;&gt;&gt; &gt; :<br>
&gt;&gt;&gt; &gt; : to understand what&#39;s needed then try to implement t=
he solution <br>
&gt;&gt;&gt; &gt; with FP : exceptions cached in a global that maybe could =
work. I <br>
&gt;&gt;&gt; &gt; won&#39;t be able to : do that as said here:<br>
&gt;&gt;&gt; &gt; :<br>
&gt;&gt;&gt; &gt; : <br>
&gt;&gt;&gt; &gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-ppc=
/2020-03/msg00006.htm" rel=3D"noreferrer" target=3D"_blank">https://lists.n=
ongnu.org/archive/html/qemu-ppc/2020-03/msg00006.htm</a><br>
&gt;&gt;&gt; &gt; l<br>
&gt;&gt;&gt; &gt; :<br>
&gt;&gt;&gt; &gt; : because I don&#39;t have time to learn all the details =
needed. I think :<br>
&gt;&gt;&gt; &gt; others are in the same situation so unless somebody puts =
in the :<br>
&gt;&gt;&gt; &gt; necessary effort this won&#39;t change.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Which also had a proposed solution to the problem that yo=
u could <br>
&gt;&gt;&gt; &gt; try to implement, in particular see this message:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; <a href=3D"http://patchwork.ozlabs.org/project/qemu-devel/patc=
h/20200218171702.9" rel=3D"noreferrer" target=3D"_blank">http://patchwork.o=
zlabs.org/project/qemu-devel/patch/20200218171702.9</a><br>
&gt;&gt;&gt; <a href=3D"http://79F074637D@zero.eik.bme.hu/#2375124" rel=3D"=
noreferrer" target=3D"_blank">79F074637D@zero.eik.bme.hu/#2375124</a><br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; amd Richard&#39;s reply immediately below that. In short =
to optimise <br>
&gt;&gt;&gt; &gt; FPU emulation we would either find a way to compute inexa=
ct flag <br>
&gt;&gt;&gt; &gt; quickly without reading the FPU status (this may not be p=
ossible) <br>
&gt;&gt;&gt; &gt; or somehow get status from the FPU but the obvious way of=
 claring <br>
&gt;&gt;&gt; &gt; the flag and reading them after each operation is too slo=
w. So <br>
&gt;&gt;&gt; &gt; maybe using exceptions and only clearing when actually th=
ere&#39;s a <br>
&gt;&gt;&gt; &gt; change could be faster.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; As to how to use exceptions see this message in above thr=
ead:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-ppc=
/2020-03/msg00005.htm" rel=3D"noreferrer" target=3D"_blank">https://lists.n=
ongnu.org/archive/html/qemu-ppc/2020-03/msg00005.htm</a><br>
&gt;&gt;&gt; &gt; l<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; But that&#39;s only to show how to hook in an exception h=
andler what it <br>
&gt;&gt;&gt; &gt; does needs to be implemented. Then tested and benchmarked=
.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; I still don&#39;t know where are the extensive PPC floati=
ng point tests <br>
&gt;&gt;&gt; &gt; to use for checking results though as that was never answ=
ered.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Specifically for PPC we don&#39;t have them. We use the softfl=
oat test <br>
&gt;&gt;&gt; cases to exercise our softfloat/hardfloat code as part of &quo=
t;make <br>
&gt;&gt;&gt; check-softfloat&quot;. You can also re-build fp-bench for each=
 guest <br>
&gt;&gt;&gt; target to measure raw throughput.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; However in short the problem is if the float_flag_ine=
xact is clear <br>
&gt;&gt;&gt; &gt;&gt; you must use softfloat so you can properly calculate =
the inexact <br>
&gt;&gt;&gt; &gt;&gt; status. We can&#39;t take advantage of the inexact st=
ickiness without <br>
&gt;&gt;&gt; &gt;&gt; loosing the fidelity of the calculation.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; I still don&#39;t get why can&#39;t we use hardware via e=
xception handler <br>
&gt;&gt;&gt; &gt; to detect flags for us and why do we only use hardfloat i=
n some <br>
&gt;&gt;&gt; &gt; corner cases. If reading the status is too costly then we=
 could <br>
&gt;&gt;&gt; &gt; mirror it in a global which is set by an FP exception han=
dler. <br>
&gt;&gt;&gt; &gt; Shouldn&#39;t that be faster? Is there a reason that can&=
#39;t work?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; It would work but it would be slow. Almost every FP operation =
sets <br>
&gt;&gt;&gt; the inexact flag so it would generate an exception and excepti=
ons <br>
&gt;&gt;&gt; take time to process.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; For the guests where we use hardfloat operations with inexact =
already <br>
&gt;&gt;&gt; latched is not a corner case - it is the common case which is =
why it <br>
&gt;&gt;&gt; helps.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Regards,<br>
&gt;&gt;&gt; &gt; BALATON Zoltan<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Alex Benn=C3=A9e<br>
&gt;&gt;&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000089300105a46d271f--

