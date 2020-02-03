Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5134AC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 21:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DB120658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 21:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfhmzVGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DB120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyjLi-000423-2u
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 16:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1iyjKf-00035U-0V
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 16:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1iyjKd-0008Uq-45
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 16:32:36 -0500
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135]:34915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>) id 1iyjKc-0008Rg-NL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 16:32:34 -0500
Received: by mail-il1-x135.google.com with SMTP id g12so14019277ild.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 13:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SYtoshaQQXOkE0Yk37PrULqhWMPDHxUPqauAc2js6t0=;
 b=kfhmzVGAx+nKt7TLW1WeCsb7ojThuHDCFkJJ9IHrc8a0ni7fss4GPSRFsmRD6aBYBx
 59/uPSx7qzuP35PGn3NOmZStjP01vCGacuZ2ACBNvy52w5CbXIs3GthIzVNgpAZMFO8M
 ODjHFDiaUGnaXP9MpHB/admFA3bi8xWl6JOxZ2BVq6UQhluIFsjnlcoJf9QtaUuVXGb/
 qiwwIYTKT0/OAvw2ltWJ+JynlK/kre9UOJwvYMgBgyXM4ogar4CgEL1hZtUxqpfz2UhW
 n5XAqatYxmzr2fXKw7ZpcU3r2TN4uJRyfb/y3uaTYMEMYo5M8763qyfDaKruyWXjEOby
 gTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SYtoshaQQXOkE0Yk37PrULqhWMPDHxUPqauAc2js6t0=;
 b=R6qgC2yYVRUCzxxzGTCXbbLbwZc5rcu7OQ0fjCy3rPkQDFs4E6YKAI+A8RUn3GI1PM
 tYjJK6uqDyGGLpgOVtxtA5GbNHwLGBM82dUvp4/WFDulAmkMrk5cTIfsEUTNeoKwoWyt
 0KOoFUK1Por9HcawjVQubcqWib44R5FHuVcSKlzK0gcFOcpC0HEq8UAnpVoifO6rqWTQ
 7ZbDeQ+8gppc/PZBI3OAfiTteXvwoQemGNFuqaqLOrkyxE2bxUsmew/vcfV796S3+rit
 VExTeLwEMsGgsRQhmMGcEoCFwNh7xf771USnZUsL6/TehgRtwNq7/nGW5Y+A62JHCRDa
 aBRg==
X-Gm-Message-State: APjAAAVN5UtUDI0Nk223wbaJJk5sdaAdRolr4T5TY691EXP33uRSMiQP
 J8/+zZKp/VToPpiC/v4w/t+m4jv6KMPm8XZT9fk=
X-Google-Smtp-Source: APXvYqxgkDrpa8YX1UpkPVxcsv5ryFM+4FKz2xKuwlztX2R5nyDbNQN+YlKhsJOQUZsCcszk3yKY4zdk33bULIpKBOw=
X-Received: by 2002:a92:8108:: with SMTP id e8mr25508828ild.138.1580765553863; 
 Mon, 03 Feb 2020 13:32:33 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nr7+6NRW6CRYRdejS_BPjizV5yX7ykfctEFTyPzh=kSVA@mail.gmail.com>
 <CAFEAcA_0RxRUkmU3YGCF2RXmJu=vP1D8SQunhdPdwW88oreCvQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_0RxRUkmU3YGCF2RXmJu=vP1D8SQunhdPdwW88oreCvQ@mail.gmail.com>
From: Wayne Li <waynli329@gmail.com>
Date: Mon, 3 Feb 2020 15:32:22 -0600
Message-ID: <CAM2K0nq1xw9XnJuCJD83vWx1DXi3DrHh8ku0d=0Ny6E6WNqJNA@mail.gmail.com>
Subject: Re: Need help understanding assertion fail.
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004fb082059db2a9b4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::135
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004fb082059db2a9b4
Content-Type: text/plain; charset="UTF-8"

I see.  So you're saying that it might be possible that my guest could be
generating TCG ops that can't be translated into PPC instructions because
the displacement value is to big.  While the same TCG ops can be translated
into x86 instructions because x86 allows for a bigger displacement value.
But on the other hand it could be some other problem causing me to have a
large displacement value.

In that case, I think it'd be super helpful if I print out this
displacement value in the TCG ops when running on PPC versus x86 because
they should be the same right?  What option in QEMU -d allows me to see
generated TCG ops?  Doing a -d --help shows the following options:

out_asm    show generated host assembly code for each compiled TB
in_asm     show target assembly code for each compiled TB
op         show micro ops for each compiled TB
op_opt     show micro ops (x86 only: before eflags optimization) and
after liveness analysis
int        show interrupts/exceptions in short format
exec       show trace before each executed TB (lots of logs)
cpu        show CPU state before block translation
mmu        log MMU-related activities
pcall      x86 only: show protected mode far calls/returns/exceptions
cpu_reset  show CPU state before CPU resets
ioport     show all i/o ports accesses
unimp      log unimplemented functionality
guest_errors log when the guest OS does something invalid (eg accessing a
non-existent register)

There doesn't seem to be any option to print out the TCG ops specifically?
Maybe I'll have to go into the code to add print statements that print out
the TCG ops?

-Thanks!, Wayne Li

On Mon, Feb 3, 2020 at 10:56 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Mon, 3 Feb 2020 at 16:39, Wayne Li <waynli329@gmail.com> wrote:
> > Anyway that's the background.  The specific problem I'm having right now
> is I get the following assertion error during some of the setup stuff our
> OS does post boot-up (the OS is also custom-made):
> >
> > qemu_programs/qemu/tcg/ppc/tcg-target.inc.c:224: reloc_pc14_val:
> Assertion `disp == (int16_t) disp' failed.
> >
> > Looking at the QEMU code, "disp" is the difference between two pointers
> named "target" and "pc".  I'm not sure exactly what either of those names
> mean.  And it looks like since the assertion is checking if casting "disp"
> as a short changes the value, it's checking if the "disp" value is too
> big?  I'm just not very sure what this assertion means.
>
> This assertion is checking that we're not trying to fit too
> large a value into the host PPC branch instruction we just emitted.
> That is, tcg_out_bc() emits a PPC conditional branch instruction,
> which has a 14 bit field for the offset (it's a relative branch),
> and we know the bottom 2 bits of the target will be 0 (PPC insns
> being 4-aligned), so the distance between the current host PC
> and the target of the branch must fit in a signed 16-bit field.
>
> "disp" here stands for "displacement".
>
> The PPC TCG backend only uses this for the TCG 'brcond' and
> 'brcond2' TCG intermediate-representation ops. It seems likely
> that the code for your target is generating TCG ops which have
> too large a gap between a brcond/brcond2 and the destination label.
> You could try using the various QEMU -d options to print out the
> guest instructions and the generated TCG ops to pin down what
> part of your target is trying to generate branches over too
> much code like this.
>
> > Anyway, the thing is this problem has to be somehow related to
> > the transfer of the code from a little-endian platform to a
> > big-endian platform as our project works without any problem on
> > little-endian platforms.
>
> In this case it isn't necessarily directly an endianness issue.
> The x86 instruction set provides conditional branch instructions
> which allow a 32-bit displacement value, so you're basically never
> going to overflow a conditional-branch there. PPC, being RISC,
> has more limited branch insns. You might also run into this
> if you tried to use aarch64 (64-bit) arm hosts, which are
> little-endian but have a 19-bit branch displacement limit,
> depending on just how big you've managed to make your jumps.
> On the other hand, a 16-bit displacement is a jump over
> 64K of generated code, which is huge for a single TCG
> generated translation block, so it could well be that you
> have an endianness bug in your TCG frontend which is causing
> you to generate an enormous TB by accident.
>
> thanks
> -- PMM
>

--0000000000004fb082059db2a9b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I see.=C2=A0 So you&#39;re saying that it might be po=
ssible that my guest could be generating TCG ops that can&#39;t be translat=
ed into PPC instructions because the displacement value is to big.=C2=A0 Wh=
ile the same TCG ops can be translated into x86 instructions because x86 al=
lows for a bigger displacement value.=C2=A0 But on the other hand it could =
be some other problem causing me to have a large displacement value.<br></d=
iv><div><br></div><div>In that case, I think it&#39;d be super helpful if I=
 print out this displacement value in the TCG ops when running on PPC versu=
s x86 because they should be the same right?=C2=A0 What option in QEMU -d a=
llows me to see generated TCG ops?=C2=A0 Doing a -d --help shows the follow=
ing options:</div><div><br></div><div>out_asm =C2=A0 =C2=A0show generated h=
ost assembly code for each compiled TB<br>in_asm =C2=A0 =C2=A0 show target =
assembly code for each compiled TB<br>op =C2=A0 =C2=A0 =C2=A0 =C2=A0 show m=
icro ops for each compiled TB<br>op_opt =C2=A0 =C2=A0 show micro ops (x86 o=
nly: before eflags optimization) and<br>after liveness analysis<br>int =C2=
=A0 =C2=A0 =C2=A0 =C2=A0show interrupts/exceptions in short format<br>exec =
=C2=A0 =C2=A0 =C2=A0 show trace before each executed TB (lots of logs)<br>c=
pu =C2=A0 =C2=A0 =C2=A0 =C2=A0show CPU state before block translation<br>mm=
u =C2=A0 =C2=A0 =C2=A0 =C2=A0log MMU-related activities<br>pcall =C2=A0 =C2=
=A0 =C2=A0x86 only: show protected mode far calls/returns/exceptions<br>cpu=
_reset =C2=A0show CPU state before CPU resets<br>ioport =C2=A0 =C2=A0 show =
all i/o ports accesses<br>unimp =C2=A0 =C2=A0 =C2=A0log unimplemented funct=
ionality<br>guest_errors log when the guest OS does something invalid (eg a=
ccessing a<br>non-existent register)</div><div><br></div><div>There doesn&#=
39;t seem to be any option to print out the TCG ops specifically?=C2=A0 May=
be I&#39;ll have to go into the code to add print statements that print out=
 the TCG ops?<br></div><div><br></div><div>-Thanks!, Wayne Li<br></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On M=
on, Feb 3, 2020 at 10:56 AM Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Mon, 3 Feb 2020 at 16:39, Wayne L=
i &lt;<a href=3D"mailto:waynli329@gmail.com" target=3D"_blank">waynli329@gm=
ail.com</a>&gt; wrote:<br>
&gt; Anyway that&#39;s the background.=C2=A0 The specific problem I&#39;m h=
aving right now is I get the following assertion error during some of the s=
etup stuff our OS does post boot-up (the OS is also custom-made):<br>
&gt;<br>
&gt; qemu_programs/qemu/tcg/ppc/tcg-target.inc.c:224: reloc_pc14_val: Asser=
tion `disp =3D=3D (int16_t) disp&#39; failed.<br>
&gt;<br>
&gt; Looking at the QEMU code, &quot;disp&quot; is the difference between t=
wo pointers named &quot;target&quot; and &quot;pc&quot;.=C2=A0 I&#39;m not =
sure exactly what either of those names mean.=C2=A0 And it looks like since=
 the assertion is checking if casting &quot;disp&quot; as a short changes t=
he value, it&#39;s checking if the &quot;disp&quot; value is too big?=C2=A0=
 I&#39;m just not very sure what this assertion means.<br>
<br>
This assertion is checking that we&#39;re not trying to fit too<br>
large a value into the host PPC branch instruction we just emitted.<br>
That is, tcg_out_bc() emits a PPC conditional branch instruction,<br>
which has a 14 bit field for the offset (it&#39;s a relative branch),<br>
and we know the bottom 2 bits of the target will be 0 (PPC insns<br>
being 4-aligned), so the distance between the current host PC<br>
and the target of the branch must fit in a signed 16-bit field.<br>
<br>
&quot;disp&quot; here stands for &quot;displacement&quot;.<br>
<br>
The PPC TCG backend only uses this for the TCG &#39;brcond&#39; and<br>
&#39;brcond2&#39; TCG intermediate-representation ops. It seems likely<br>
that the code for your target is generating TCG ops which have<br>
too large a gap between a brcond/brcond2 and the destination label.<br>
You could try using the various QEMU -d options to print out the<br>
guest instructions and the generated TCG ops to pin down what<br>
part of your target is trying to generate branches over too<br>
much code like this.<br>
<br>
&gt; Anyway, the thing is this problem has to be somehow related to<br>
&gt; the transfer of the code from a little-endian platform to a<br>
&gt; big-endian platform as our project works without any problem on<br>
&gt; little-endian platforms.<br>
<br>
In this case it isn&#39;t necessarily directly an endianness issue.<br>
The x86 instruction set provides conditional branch instructions<br>
which allow a 32-bit displacement value, so you&#39;re basically never<br>
going to overflow a conditional-branch there. PPC, being RISC,<br>
has more limited branch insns. You might also run into this<br>
if you tried to use aarch64 (64-bit) arm hosts, which are<br>
little-endian but have a 19-bit branch displacement limit,<br>
depending on just how big you&#39;ve managed to make your jumps.<br>
On the other hand, a 16-bit displacement is a jump over<br>
64K of generated code, which is huge for a single TCG<br>
generated translation block, so it could well be that you<br>
have an endianness bug in your TCG frontend which is causing<br>
you to generate an enormous TB by accident.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000004fb082059db2a9b4--

