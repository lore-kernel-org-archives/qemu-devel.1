Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE4C2D0EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 21:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B281B20769
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 21:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPa7SMMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B281B20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLvtc-00043D-Si
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 17:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jLvsv-0003dY-CS
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 17:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jLvss-0003k0-VW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 17:35:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jLvss-0003in-LT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 17:35:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id s8so5527688wrt.7
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S+Q4DjPrD1NrbxH/xjYejmlKrp+Edf92PWL0fm9eM6U=;
 b=VPa7SMMChhV0It5FtcOOpnJ32RhS5449kyldidg/N0ttTODoR0jddlt0bXLqhf3XNg
 N6Y5zPJbKLrQlmipk2AhjDpi5tPOtMERB9UceRglVihnB1tXd+5mdyFRLBuiH2sfAuQk
 NblWfykL2YM1s+02cAkEmJyOWNmbC04A0Qm2H2DuY0MASvb/qhmJlTEa1Yl6CizCAawy
 fst2yYx4cTlWdl67j0Yxd2gYvEvScp9hovRN80d67VI1c+/aWZjM75vWNW8ltqqtBY5i
 HJ7lyLiUbTs7U52OospVIWkE/9JRy4Dl6c5gU3ywuHTiKte6u+DJbDNGRvwqojTQRNLM
 uhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S+Q4DjPrD1NrbxH/xjYejmlKrp+Edf92PWL0fm9eM6U=;
 b=fWVKKwHoPK6Ad8bmS24vjSziRaWYd5aANPIKukz2NtoK+T24HEL5IgyY55dNmaP1eP
 83LVbuzYwov3hNZM+JVfgWDu0ADpc4xNzuD6lZ4l1sfwkRwyT7rhsxR2YTui49OMQcdY
 hqPhgPBeEeIXefsUvm+3zXYf0cIv4thcyZfkXy1ZK/wDldAv9buvTcP6f3PVm8/GPpiN
 Po00MyreczUAceXmN8CNzyoT6tIQGjKoyweqDAAprCazu9OUIy5nupqaxwwdPrU7AoTR
 pbXnlJsZt6e0j7F2WNr6yWwlclljYiQp4YWF84pnjdG+WiYrAOt5TOTKiIdvy9coNFvG
 YlkQ==
X-Gm-Message-State: AGi0PubJ8xSLP2/BbmEesRzR0i6EuJc7wOwAVb6tAH2EOPrQBZ+2i4Bj
 ZgdSsjGyj0oe4b5oePqg2h4JbRKmJlulbDP+m8o=
X-Google-Smtp-Source: APiQypLp/3XFEJR1qZT0rkpdt5VLqwRvyJh4Sawxe5jUOJS1m8ONYxZhoXZUIEI1+mTYMcIbwDxCMKrLa/L5XbzJ2Fs=
X-Received: by 2002:adf:fe52:: with SMTP id m18mr4680699wrs.162.1586295348593; 
 Tue, 07 Apr 2020 14:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200406235418.18315-1-f4bug@amsat.org>
 <CAFEAcA8rPhPKTjxh-iPkP8qpRpCCYEDgepCK=MSwy96h_kk_7w@mail.gmail.com>
 <894d16c7-4f6d-a842-ec28-f2a0b7cc2565@redhat.com>
 <cabe97ae-91ca-b88c-5690-9a18eca8c521@redhat.com>
In-Reply-To: <cabe97ae-91ca-b88c-5690-9a18eca8c521@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 7 Apr 2020 23:35:27 +0200
Message-ID: <CAHiYmc704C-JL_7A2weGe9j-F5HPDGZxOCLwaYnQWJaeQj0HDA@mail.gmail.com>
Subject: Re: [RFC PATCH-for-5.0?] target/mips/translate: Report exception in
 delay slot as UNPREDICTABLE
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c3092405a2ba2aa9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G . Cota" <cota@braap.org>,
 Brian Campbell <bacam@z273.org.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c3092405a2ba2aa9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

11:32 Uto, 07.04.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 4/7/20 11:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 4/7/20 10:35 AM, Peter Maydell wrote:
> >> On Tue, 7 Apr 2020 at 00:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
> >> wrote:
> >>>
> >>> Using the BC1ANY4F instruction with a 24Kf core (MIPS32R2
> >>> & ASE_MIPS16) we get:
> >>>
> >>>    $ echo -ne '\x03\x20\xf8\x09EEEE' > cop1x.bin
> >>>    $ qemu-system-mipsel -bios cop1x.bin
> >>>    unknown branch 0x13000
> >>>    Aborted (core dumped)
> >>
> >>> This is because this COP1X instruction generates a Reserved
> >>> Instruction when used with this core, however we are in a delay
> >>> slot, and exceptions in delay slot are architecturally unpredictable.
> >>>
> >>> Core dumps confunse users. Instead, report a friendlier error message=
:
> >>>
> >>>    $ qemu-system-mipsel -bios cop1x.bin
> >>>    qemu-system-mipsel: Exception in delay slot is UNPREDICTABLE
> >>
> >> UNPREDICTABLE behaviour should not in QEMU include
> >> causing QEMU to exit. You can log it with LOG_GUEST_ERROR
> >> if you like but you should do something plausible (ideally what
> >> some bit of real hardware does when this situation happens).
> >
> > OK. I have no clue how real 24Kf deals with it - I don't own one -, it
> > is not in my list of interests (and my list of interests - which I can
> > reproduce - is not modeled in QEMU).
> >
> >>
> >> PS: does MIPS use the "UNPREDICTABLE" terminology? I
> >> thought it was an Arm-ism, but maybe it's caught on more widely.
> >
> > At least it appears in my MIPS32 ISA Vol II (Revision 0.95) copy from
2001:
> >
> > 1.2  UNPREDICTABLE and UNDEFINED
> >
> > 1.2.1  UNPREDICTABLE
> > UNPREDICTABLE results may vary from processor implementation to
> > implementation, instruction to instruction, oras a function of time on
> > the same implementation or instruction. Software can never depend on
> > results that are UNPREDICTABLE. UNPREDICTABLE operations may cause a
> > result to be generated or not. If a result is generated,it is
> > UNPREDICTABLE. UNPREDICTABLE operations may cause arbitrary exceptions.
> > UNPREDICTABLE results or operations have several implementation
> > restrictions:
> > =E2=80=A2 Implementations of operations generating UNPREDICTABLE result=
s must
> > not depend on any data source (memory or internal state) which is
> > inaccessible in the current processor mode
> > =E2=80=A2 UNPREDICTABLE operations must not read, write, or modify the =
contents
> > of memory or internal state which is inaccessible in the current
> > processor mode. For example, UNPREDICTABLE operations executed in user
> > mode must not access memory or internal state that is only accessible
in
> > Kernel Mode or Debug Mode or in another process
> > =E2=80=A2 UNPREDICTABLE operations must not halt or hang the processor
> >
> > 1.2.2  UNDEFINED
> > UNDEFINED operations or behavior may vary from processor implementation
> > to implementation, instruction to instruction, or as a function of time
> > on the same implementation or instruction. UNDEFINED operations or
> > behavior may vary from nothing to creating an environment in which
> > execution can no longer continue. UNDEFINED operations or behavior may
> > cause data loss.
> > UNDEFINED operations or behavior has one implementation restriction:
> > =E2=80=A2 UNDEFINED operations or behavior must not cause the processor=
 to hang
> > (that is, enter a state from which there is no exit other than powering
> > down the processor). The assertion of any of the reset signals must
> > restore the processorto an operational state
> >
> > Then:
> >
> > Jump and Link Register (JALR)
> >
> > Processor operation is UNPREDICTABLE if a branch, jump, ERET, DERET, or
> > WAIT instruction is placed in the delay slot of a branch or jump.
> >
> > ---
> >
> > On Vol I Rev 6.01:
> >
> > 5.3.2.1  Control Transfer Instructions in Delay Slots and Forbidden
Slots
> >
> > In MIPS architectures prior to Release 6. if a control transfer
> > instruction (CTI) is placed in a branch delay slot, the operation of
> > both instructions is UNPREDICTABLE. In Release 6, if a CTI is placed in
> > a branch delay slot or a compact branch forbidden slot, implementations
> > are required to signal a Reserved Instruction exception.
>
> Which also means this patch is incorrect for CPUs implementing the
> Release 6 (which I'm not familiar with).
>
> >
> > The following instructions are forbidden in branch delay slots and
> > forbidden slots: any CTI, including branches and jumps, ERET, ERETNC,
> > DERET, WAIT, and PAUSE. Their occurrence is required to signal a
> > Reserved Instruction exception.
> >
> > 5.3.2.2  Exceptions and Delay and Forbidden Slots
> >
> > If an exception or interrupt prevents the completion of an instruction
> > in a delay slot or forbidden slot, the hardware reports an Exception PC
> > (CP0 EPC) of the branch, with a status bit set (StatusBD) to indicate
> > that the exception was for the instruction in the delay slot of the
branch.
> > By convention, if an exception or interrupt prevents the completion of
> > an instruction in a branch delay or forbidden slot, the branch
> > instruction is re-executed and branch instructions must be restartable
> > to permit this. In particular, procedure calls must be restartable. To
> > insure that a procedure call is restartable, procedure calls that have
a
> > delay slot or forbidden slot (branch/jump-and-link instructions) should
> > not use the register in which the return link is stored (usu-ally GPR
> > 31) as a source register. This applies to all branch/jump-and-link
> > instructions that have both a slot (delay or forbidden) and source
> > registers, both for conditions (e.g., BGEZAL or BGEZALC) or for jump
> > targets (JALR).
> >
> > ---
> >
> > I would have expected the behavior match the UNDEFINED description, as
> > Yongbok Kim commented here:
> > https://bugs.launchpad.net/qemu/+bug/1663287/comments/3
> >
> >    branches in a delay slot is "undefined" in the pre-Release
> >    6 architecture. MIPS architectre release 6 defines to signal
> >    Reserved Instruction exceptions for such cases.
> >
> > But it really appears as UNPREDICTABLE.
>

Folks,

Thanks for everyone involved, esp. Philippe for devising the proposal and
citing the manual about UNPREDICTABLE meaning, but I think this is too late
to fix it in 5.0 (too risky), so let's talk about it in 5.0+.

Yours,
Aleksandar

--000000000000c3092405a2ba2aa9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">11:32 Uto, 07.04.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 4/7/20 11:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt; On 4/7/20 10:35 AM, Peter Maydell wrote:<br>
&gt; &gt;&gt; On Tue, 7 Apr 2020 at 00:55, Philippe Mathieu-Daud=C3=A9 &lt;=
<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; <br>
&gt; &gt;&gt; wrote:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Using the BC1ANY4F instruction with a 24Kf core (MIPS32R2=
<br>
&gt; &gt;&gt;&gt; &amp; ASE_MIPS16) we get:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; =C2=A0=C2=A0 $ echo -ne &#39;\x03\x20\xf8\x09EEEE&#39; &g=
t; cop1x.bin<br>
&gt; &gt;&gt;&gt; =C2=A0=C2=A0 $ qemu-system-mipsel -bios cop1x.bin<br>
&gt; &gt;&gt;&gt; =C2=A0=C2=A0 unknown branch 0x13000<br>
&gt; &gt;&gt;&gt; =C2=A0=C2=A0 Aborted (core dumped)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; This is because this COP1X instruction generates a Reserv=
ed<br>
&gt; &gt;&gt;&gt; Instruction when used with this core, however we are in a=
 delay<br>
&gt; &gt;&gt;&gt; slot, and exceptions in delay slot are architecturally un=
predictable.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Core dumps confunse users. Instead, report a friendlier e=
rror message:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; =C2=A0=C2=A0 $ qemu-system-mipsel -bios cop1x.bin<br>
&gt; &gt;&gt;&gt; =C2=A0=C2=A0 qemu-system-mipsel: Exception in delay slot =
is UNPREDICTABLE<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; UNPREDICTABLE behaviour should not in QEMU include<br>
&gt; &gt;&gt; causing QEMU to exit. You can log it with LOG_GUEST_ERROR<br>
&gt; &gt;&gt; if you like but you should do something plausible (ideally wh=
at<br>
&gt; &gt;&gt; some bit of real hardware does when this situation happens).<=
br>
&gt; &gt; <br>
&gt; &gt; OK. I have no clue how real 24Kf deals with it - I don&#39;t own =
one -, it <br>
&gt; &gt; is not in my list of interests (and my list of interests - which =
I can <br>
&gt; &gt; reproduce - is not modeled in QEMU).<br>
&gt; &gt; <br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; PS: does MIPS use the &quot;UNPREDICTABLE&quot; terminology? =
I<br>
&gt; &gt;&gt; thought it was an Arm-ism, but maybe it&#39;s caught on more =
widely.<br>
&gt; &gt; <br>
&gt; &gt; At least it appears in my MIPS32 ISA Vol II (Revision 0.95) copy =
from 2001:<br>
&gt; &gt; <br>
&gt; &gt; 1.2=C2=A0 UNPREDICTABLE and UNDEFINED<br>
&gt; &gt; <br>
&gt; &gt; 1.2.1=C2=A0 UNPREDICTABLE<br>
&gt; &gt; UNPREDICTABLE results may vary from processor implementation to <=
br>
&gt; &gt; implementation, instruction to instruction, oras a function of ti=
me on <br>
&gt; &gt; the same implementation or instruction. Software can never depend=
 on <br>
&gt; &gt; results that are UNPREDICTABLE. UNPREDICTABLE operations may caus=
e a <br>
&gt; &gt; result to be generated or not. If a result is generated,it is <br=
>
&gt; &gt; UNPREDICTABLE. UNPREDICTABLE operations may cause arbitrary excep=
tions.<br>
&gt; &gt; UNPREDICTABLE results or operations have several implementation <=
br>
&gt; &gt; restrictions:<br>
&gt; &gt; =E2=80=A2 Implementations of operations generating UNPREDICTABLE =
results must <br>
&gt; &gt; not depend on any data source (memory or internal state) which is=
 <br>
&gt; &gt; inaccessible in the current processor mode<br>
&gt; &gt; =E2=80=A2 UNPREDICTABLE operations must not read, write, or modif=
y the contents <br>
&gt; &gt; of memory or internal state which is inaccessible in the current =
<br>
&gt; &gt; processor mode. For example, UNPREDICTABLE operations executed in=
 user <br>
&gt; &gt; mode must not access memory or internal state that is only access=
ible in <br>
&gt; &gt; Kernel Mode or Debug Mode or in another process<br>
&gt; &gt; =E2=80=A2 UNPREDICTABLE operations must not halt or hang the proc=
essor<br>
&gt; &gt; <br>
&gt; &gt; 1.2.2=C2=A0 UNDEFINED<br>
&gt; &gt; UNDEFINED operations or behavior may vary from processor implemen=
tation <br>
&gt; &gt; to implementation, instruction to instruction, or as a function o=
f time <br>
&gt; &gt; on the same implementation or instruction. UNDEFINED operations o=
r <br>
&gt; &gt; behavior may vary from nothing to creating an environment in whic=
h <br>
&gt; &gt; execution can no longer continue. UNDEFINED operations or behavio=
r may <br>
&gt; &gt; cause data loss.<br>
&gt; &gt; UNDEFINED operations or behavior has one implementation restricti=
on:<br>
&gt; &gt; =E2=80=A2 UNDEFINED operations or behavior must not cause the pro=
cessor to hang <br>
&gt; &gt; (that is, enter a state from which there is no exit other than po=
wering <br>
&gt; &gt; down the processor). The assertion of any of the reset signals mu=
st <br>
&gt; &gt; restore the processorto an operational state<br>
&gt; &gt; <br>
&gt; &gt; Then:<br>
&gt; &gt; <br>
&gt; &gt; Jump and Link Register (JALR)<br>
&gt; &gt; <br>
&gt; &gt; Processor operation is UNPREDICTABLE if a branch, jump, ERET, DER=
ET, or <br>
&gt; &gt; WAIT instruction is placed in the delay slot of a branch or jump.=
<br>
&gt; &gt; <br>
&gt; &gt; ---<br>
&gt; &gt; <br>
&gt; &gt; On Vol I Rev 6.01:<br>
&gt; &gt; <br>
&gt; &gt; 5.3.2.1=C2=A0 Control Transfer Instructions in Delay Slots and Fo=
rbidden Slots<br>
&gt; &gt; <br>
&gt; &gt; In MIPS architectures prior to Release 6. if a control transfer <=
br>
&gt; &gt; instruction (CTI) is placed in a branch delay slot, the operation=
 of <br>
&gt; &gt; both instructions is UNPREDICTABLE. In Release 6, if a CTI is pla=
ced in <br>
&gt; &gt; a branch delay slot or a compact branch forbidden slot, implement=
ations <br>
&gt; &gt; are required to signal a Reserved Instruction exception.<br>
&gt;<br>
&gt; Which also means this patch is incorrect for CPUs implementing the <br=
>
&gt; Release 6 (which I&#39;m not familiar with).<br>
&gt;<br>
&gt; &gt; <br>
&gt; &gt; The following instructions are forbidden in branch delay slots an=
d <br>
&gt; &gt; forbidden slots: any CTI, including branches and jumps, ERET, ERE=
TNC, <br>
&gt; &gt; DERET, WAIT, and PAUSE. Their occurrence is required to signal a =
<br>
&gt; &gt; Reserved Instruction exception.<br>
&gt; &gt; <br>
&gt; &gt; 5.3.2.2=C2=A0 Exceptions and Delay and Forbidden Slots<br>
&gt; &gt; <br>
&gt; &gt; If an exception or interrupt prevents the completion of an instru=
ction <br>
&gt; &gt; in a delay slot or forbidden slot, the hardware reports an Except=
ion PC <br>
&gt; &gt; (CP0 EPC) of the branch, with a status bit set (StatusBD) to indi=
cate <br>
&gt; &gt; that the exception was for the instruction in the delay slot of t=
he branch.<br>
&gt; &gt; By convention, if an exception or interrupt prevents the completi=
on of <br>
&gt; &gt; an instruction in a branch delay or forbidden slot, the branch <b=
r>
&gt; &gt; instruction is re-executed and branch instructions must be restar=
table <br>
&gt; &gt; to permit this. In particular, procedure calls must be restartabl=
e. To <br>
&gt; &gt; insure that a procedure call is restartable, procedure calls that=
 have a <br>
&gt; &gt; delay slot or forbidden slot (branch/jump-and-link instructions) =
should <br>
&gt; &gt; not use the register in which the return link is stored (usu-ally=
 GPR <br>
&gt; &gt; 31) as a source register. This applies to all branch/jump-and-lin=
k <br>
&gt; &gt; instructions that have both a slot (delay or forbidden) and sourc=
e <br>
&gt; &gt; registers, both for conditions (e.g., BGEZAL or BGEZALC) or for j=
ump <br>
&gt; &gt; targets (JALR).<br>
&gt; &gt; <br>
&gt; &gt; ---<br>
&gt; &gt; <br>
&gt; &gt; I would have expected the behavior match the UNDEFINED descriptio=
n, as <br>
&gt; &gt; Yongbok Kim commented here:<br>
&gt; &gt; <a href=3D"https://bugs.launchpad.net/qemu/+bug/1663287/comments/=
3">https://bugs.launchpad.net/qemu/+bug/1663287/comments/3</a><br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 branches in a delay slot is &quot;undefined&quot; in=
 the pre-Release<br>
&gt; &gt;=C2=A0 =C2=A0 6 architecture. MIPS architectre release 6 defines t=
o signal<br>
&gt; &gt;=C2=A0 =C2=A0 Reserved Instruction exceptions for such cases.<br>
&gt; &gt; <br>
&gt; &gt; But it really appears as UNPREDICTABLE.<br>
&gt;<br></p>
<p dir=3D"ltr">Folks,</p>
<p dir=3D"ltr">Thanks for everyone involved, esp. Philippe for devising the=
 proposal and citing the manual about UNPREDICTABLE meaning, but I think th=
is is too late to fix it in 5.0 (too risky), so let&#39;s talk about it in =
5.0+.</p>
<p dir=3D"ltr">Yours,<br>
Aleksandar</p>

--000000000000c3092405a2ba2aa9--

