Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931B1C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C0B215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN3yfYaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C0B215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFb2c-0008LU-Qe
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 05:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iFb1T-0007tx-8s
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iFb1R-0005tn-Dm
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:34:14 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iFb1R-0005tP-8W
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:34:13 -0400
Received: by mail-ot1-x344.google.com with SMTP id 67so14128771oto.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=0eicz6oinauka8bY4pnY6YNnW1vvv/s7P+s7EoxBjgI=;
 b=gN3yfYaLrkaa/tzjZaUPFXLDWP5hm7G3NawRWkEuBW9r8dpDX3tw+6EtCTFmvTcgZG
 OwiRNUh4P2ZNhrKUD/AHeYyQxVn2iFxpi0c8SLttMmL/rqRHiC0yrycMkBZqQwCnmcHW
 02NW8VjhHCpgrIhm6lLjYldLLCmKh1HwWLY/wZ/jL4GCLWLehjyGpjHRH3/UG1qFfisC
 9DNcPN2zpPD8BxheY590Q6hldGrxcGq122oLtyyDsErEHPsji1ecDz9Xd47VQWA01ljD
 OTRbeFCW7MIC256BdAKvwyXj/sR6SUQXbpP4onRqxj/PqXwnYJUi1AXrXyp/Ro0OlYeg
 QjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=0eicz6oinauka8bY4pnY6YNnW1vvv/s7P+s7EoxBjgI=;
 b=nVOn9zc5Cu3lrm2NKXNQHfDwBRE8JG+WXpNi/Mo9s3Xxo5NARDy5RCkm1CzT3VrVb/
 FPGhlILDN5GehK4GFBvtHNPKaxulOtggPbozt2qPEJcCBk94KEr+Jy/n4MdXayqld1GJ
 oBeF2ehc4e8z0Mb7nzF54jl2P4q6NMtWjmoSd4qXRRGRMkl2I7hn7HXZsdyRB86Ibadv
 AwNiMGJS/K/WkB3liVDE+ND7nPU5yrJH+ZMN0B06L7vbTvc3EVahJSVw41RpepvW+iiz
 GbApP0bR2ssxpwFLoRtGphz5/T/HtNsX0Qs6fdGUyPRfjFwg5exLW2daz5h5QxREhdoq
 TyCQ==
X-Gm-Message-State: APjAAAWVVRsudxB0smKFAmDSc9pwpxfk6Il1B/8uN/kQ71CtYDeEIHHp
 gAuZPqm7/DxQrgOgOXEqS/7YR9zU1BM+uLSr2pw=
X-Google-Smtp-Source: APXvYqwRwL0HsQdBG/3gJsnQH1qnPKwQCgoZbNHb5lUilU2dK/DZMMqGyyOjtPDbnDs31OwjKrFAi7CeH37iVd0oq0k=
X-Received: by 2002:a9d:7d02:: with SMTP id v2mr1328486otn.295.1570008852339; 
 Wed, 02 Oct 2019 02:34:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Wed, 2 Oct 2019 02:34:10 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Wed, 2 Oct 2019 02:34:10 -0700 (PDT)
In-Reply-To: <010a361d-ae39-8462-8b92-68127c51ea31@ilande.co.uk>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
 <010a361d-ae39-8462-8b92-68127c51ea31@ilande.co.uk>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 2 Oct 2019 11:34:10 +0200
Message-ID: <CAL1e-=jezYbZtF8QKBu3VeAp2XYg-kuYA5T5CxxmR19Cr6rdCA@mail.gmail.com>
Subject: Re: [PATCH v7 00/22] tcg/ppc: Add vector opcodes
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="000000000000f01f220593ea2b11"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f01f220593ea2b11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

01.10.2019. 23.21, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 30/09/2019 21:21, Richard Henderson wrote:
>
> > Changes since v6:
> >   * The have_foo tests have been split so that VSX is not
> >     combined with ISA revision.
> >   * The power{7,8,9} patches have been split by isa extension.
> >   * Force the [TABC]X bits on within the VSX instruction defines,
> >     making the usage of the VSX insns clearer, since we have no
> >     additional or'ing of seemingly random bits.
> >
> > Changes since v5:
> >   * Disable runtime altivec detection until all of the required
> >     opcodes are implemented.
> >     Because dup2 was last, that really means all of the pure altivec
> >     bits, so the initial patches are not bisectable in any meaningful
> >     sense.  I thought about reshuffling dup2 earlier, but that created
> >     too many conflicts and I was too lazy.
> >   * Rearranged the patches a little bit to make sure that each
> >     one actually builds, which was not the case before.
> >   * Folded in the fix to tcg_out_mem_long, as discussed in the
> >     followup within the v4 thread.
> >
> > Changes since v4:
> >   * Patch 1, "tcg/ppc: Introduce Altivec registers", is divided into
> >     ten smaller patches.
> >   * The net result (code-wise) is not changed between former patch 1
> >     and ten new patches.
> >   * Remaining (2-7) patches from v4 are applied verbatim.
> >   * This means that code-wise v5 and v4 do not differ.
> >   * v5 is devised to help debugging, and to better organize the code.
> >
> > Changes since v3:
> >   * Add support for bitsel, with the vsx xxsel insn.
> >   * Rely on the new relocation overflow handling, so
> >     we don't require 3 insns for a vector load.
> >
> > Changes since v2:
> >   * Several generic tcg patches to improve dup vs dupi vs dupm.
> >     In particular, if a global temp (like guest r10) is not in
> >     a host register, we should duplicate from memory instead of
> >     loading to an integer register, spilling to stack, loading
> >     to a vector register, and then duplicating.
> >   * I have more confidence that 32-bit ppc host should work
> >     this time around.  No testing on that front yet, but I've
> >     unified some code sequences with 64-bit ppc host.
> >   * Base altivec now supports V128 only.  Moved V64 support to
> >     Power7 (v2.06), which has 64-bit load/store.
> >   * Dropped support for 64-bit vector multiply using Power8.
> >     The expansion was too large compared to using integer regs.
> >
> > Richard Henderson (22):
> >   tcg/ppc: Introduce Altivec registers
> >   tcg/ppc: Introduce macro VX4()
> >   tcg/ppc: Introduce macros VRT(), VRA(), VRB(), VRC()
> >   tcg/ppc: Create TCGPowerISA and have_isa
> >   tcg/ppc: Replace HAVE_ISA_2_06
> >   tcg/ppc: Replace HAVE_ISEL macro with a variable
> >   tcg/ppc: Enable tcg backend vector compilation
> >   tcg/ppc: Add support for load/store/logic/comparison
> >   tcg/ppc: Add support for vector maximum/minimum
> >   tcg/ppc: Add support for vector add/subtract
> >   tcg/ppc: Add support for vector saturated add/subtract
> >   tcg/ppc: Support vector shift by immediate
> >   tcg/ppc: Support vector multiply
> >   tcg/ppc: Support vector dup2
> >   tcg/ppc: Enable Altivec detection
> >   tcg/ppc: Update vector support for VSX
> >   tcg/ppc: Update vector support for v2.07 Altivec
> >   tcg/ppc: Update vector support for v2.07 VSX
> >   tcg/ppc: Update vector support for v2.07 FP
> >   tcg/ppc: Update vector support for v3.00 Altivec
> >   tcg/ppc: Update vector support for v3.00 load/store
> >   tcg/ppc: Update vector support for v3.00 dup/dupi
> >
> >  tcg/ppc/tcg-target.h     |   51 +-
> >  tcg/ppc/tcg-target.opc.h |   13 +
> >  tcg/ppc/tcg-target.inc.c | 1118 +++++++++++++++++++++++++++++++++++---
> >  3 files changed, 1101 insertions(+), 81 deletions(-)
> >  create mode 100644 tcg/ppc/tcg-target.opc.h
>
> I've just tried this version with my OS X/MacOS 9 CDROM boot tests and it
looks good
> here: no crashes or visible artefacts AFAICT:
>
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (PPC32)
>
>
>

For all patches in this series:

Reviewed-by: Aleksandar Markovic
<amarkovic@wavecomp.com>

--000000000000f01f220593ea2b11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
01.10.2019. 23.21, &quot;Mark Cave-Ayland&quot; &lt;<a href=3D"mailto:mark.=
cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>&gt; =D1=98=D0=
=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 30/09/2019 21:21, Richard Henderson wrote:<br>
&gt;<br>
&gt; &gt; Changes since v6:<br>
&gt; &gt;=C2=A0 =C2=A0* The have_foo tests have been split so that VSX is n=
ot<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0combined with ISA revision.<br>
&gt; &gt;=C2=A0 =C2=A0* The power{7,8,9} patches have been split by isa ext=
ension.<br>
&gt; &gt;=C2=A0 =C2=A0* Force the [TABC]X bits on within the VSX instructio=
n defines,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0making the usage of the VSX insns clearer, sin=
ce we have no<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0additional or&#39;ing of seemingly random bits=
.<br>
&gt; &gt; <br>
&gt; &gt; Changes since v5:<br>
&gt; &gt;=C2=A0 =C2=A0* Disable runtime altivec detection until all of the =
required<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0opcodes are implemented.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Because dup2 was last, that really means all o=
f the pure altivec<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0bits, so the initial patches are not bisectabl=
e in any meaningful<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0sense.=C2=A0 I thought about reshuffling dup2 =
earlier, but that created<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0too many conflicts and I was too lazy.<br>
&gt; &gt;=C2=A0 =C2=A0* Rearranged the patches a little bit to make sure th=
at each<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0one actually builds, which was not the case be=
fore.<br>
&gt; &gt;=C2=A0 =C2=A0* Folded in the fix to tcg_out_mem_long, as discussed=
 in the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0followup within the v4 thread.<br>
&gt; &gt; <br>
&gt; &gt; Changes since v4:<br>
&gt; &gt;=C2=A0 =C2=A0* Patch 1, &quot;tcg/ppc: Introduce Altivec registers=
&quot;, is divided into<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0ten smaller patches.<br>
&gt; &gt;=C2=A0 =C2=A0* The net result (code-wise) is not changed between f=
ormer patch 1<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0and ten new patches.<br>
&gt; &gt;=C2=A0 =C2=A0* Remaining (2-7) patches from v4 are applied verbati=
m.<br>
&gt; &gt;=C2=A0 =C2=A0* This means that code-wise v5 and v4 do not differ.<=
br>
&gt; &gt;=C2=A0 =C2=A0* v5 is devised to help debugging, and to better orga=
nize the code.<br>
&gt; &gt; <br>
&gt; &gt; Changes since v3:<br>
&gt; &gt;=C2=A0 =C2=A0* Add support for bitsel, with the vsx xxsel insn.<br=
>
&gt; &gt;=C2=A0 =C2=A0* Rely on the new relocation overflow handling, so<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0we don&#39;t require 3 insns for a vector load=
.<br>
&gt; &gt; <br>
&gt; &gt; Changes since v2:<br>
&gt; &gt;=C2=A0 =C2=A0* Several generic tcg patches to improve dup vs dupi =
vs dupm.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0In particular, if a global temp (like guest r1=
0) is not in<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0a host register, we should duplicate from memo=
ry instead of<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0loading to an integer register, spilling to st=
ack, loading<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0to a vector register, and then duplicating.<br=
>
&gt; &gt;=C2=A0 =C2=A0* I have more confidence that 32-bit ppc host should =
work<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0this time around.=C2=A0 No testing on that fro=
nt yet, but I&#39;ve<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0unified some code sequences with 64-bit ppc ho=
st.<br>
&gt; &gt;=C2=A0 =C2=A0* Base altivec now supports V128 only.=C2=A0 Moved V6=
4 support to<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Power7 (v2.06), which has 64-bit load/store.<b=
r>
&gt; &gt;=C2=A0 =C2=A0* Dropped support for 64-bit vector multiply using Po=
wer8.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0The expansion was too large compared to using =
integer regs.<br>
&gt; &gt; <br>
&gt; &gt; Richard Henderson (22):<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Introduce Altivec registers<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Introduce macro VX4()<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Introduce macros VRT(), VRA(), VRB(), VRC()<=
br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Create TCGPowerISA and have_isa<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Replace HAVE_ISA_2_06<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Replace HAVE_ISEL macro with a variable<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Enable tcg backend vector compilation<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Add support for load/store/logic/comparison<=
br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Add support for vector maximum/minimum<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Add support for vector add/subtract<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Add support for vector saturated add/subtrac=
t<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Support vector shift by immediate<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Support vector multiply<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Support vector dup2<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Enable Altivec detection<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Update vector support for VSX<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Update vector support for v2.07 Altivec<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Update vector support for v2.07 VSX<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Update vector support for v2.07 FP<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Update vector support for v3.00 Altivec<br>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Update vector support for v3.00 load/store<b=
r>
&gt; &gt;=C2=A0 =C2=A0tcg/ppc: Update vector support for v3.00 dup/dupi<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 tcg/ppc/tcg-target.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A051 +-=
<br>
&gt; &gt;=C2=A0 tcg/ppc/tcg-target.opc.h |=C2=A0 =C2=A013 +<br>
&gt; &gt;=C2=A0 tcg/ppc/tcg-target.inc.c | 1118 +++++++++++++++++++++++++++=
++++++++---<br>
&gt; &gt;=C2=A0 3 files changed, 1101 insertions(+), 81 deletions(-)<br>
&gt; &gt;=C2=A0 create mode 100644 tcg/ppc/tcg-target.opc.h<br>
&gt;<br>
&gt; I&#39;ve just tried this version with my OS X/MacOS 9 CDROM boot tests=
 and it looks good<br>
&gt; here: no crashes or visible artefacts AFAICT:<br>
&gt;<br>
&gt; Tested-by: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ila=
nde.co.uk">mark.cave-ayland@ilande.co.uk</a>&gt; (PPC32)<br>
&gt;<br>
&gt;<br>
&gt;</p>
<p dir=3D"ltr">For all patches in this series:</p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic<br>
&lt;<a href=3D"mailto:amarkovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt=
;<br>
</p>

--000000000000f01f220593ea2b11--

