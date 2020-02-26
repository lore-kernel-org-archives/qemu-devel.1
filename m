Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB32C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4460F24685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOGyY2Qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4460F24685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6v4B-0007BC-DB
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6uwA-0004QA-CX
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:33:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6uw6-00071q-9y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:33:10 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j6uw6-0006ww-3Y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:33:06 -0500
Received: by mail-oi1-x243.google.com with SMTP id i1so2668710oie.8
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=PwUpGkJnbPW07PC5FnVKpnq3qviosIVPIxfK34xtJ4Y=;
 b=lOGyY2Qg90XgAOZJAV+4yDNJtahj2Ot6mmqhSvWI3lieV0xlbihuv/yQOuKZD00wV+
 x3t7D3fYW6PLkvW90Ea2aJu0HaMBvzs7Dnexiv2VpV74s0u8Pnv/a0m7171w3ccXguMz
 Y20dDo14ud8thTt/SCuoQ78D+O2FRI2S800RbH+fA7yrx/im9YyEFgpb3uWWtw531rzL
 GZ5WFFhLlOTEG4ciSn9S9lMG7ZL3yyeuG+YaoGpvroF8C69rLUHgMWVJ7b73HoTARQXU
 TAQxEEDdVMXS+g5+82w6XMRRNioDJNlM59iWebkzWtBvw9B5JmZPnw0vF7w2Zvp0VoTe
 637g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=PwUpGkJnbPW07PC5FnVKpnq3qviosIVPIxfK34xtJ4Y=;
 b=XIrDBxAhDEegYG6GcMy91PfD5pFucO0mP1bQr9iFLmYZtyVbQ/08o8+9sc8v8R1oqh
 dqGIOqqB6PNCucFnQNB0g13y+n5kpyaEYsNX+Yrn0D9QhsFrBhqz6eXgNfgpjrzOUTju
 N0Se8U1u145FDN1lBJ2hqG8/Y+fvC15Ly6t8Is9AF0BYvYQ/+w3eMfmaFgQoo4+jvN+W
 iadojXb6K1LXeba5gKF7qSspBDllVRahIujMD1f2l7zoCavD4XrstEV5hzdxpqugZhLa
 ZqX5jSclGXQ6IYPKg/TTtwrIJfpr7RhGDZJSxpHB/wLip4oncS9i1kHLqOVpAvaJBSJg
 tLzg==
X-Gm-Message-State: APjAAAW79B0HKzyTUFiEClw5Fsy+2Fax1TFdt4z+CKPyNsk+u+5X6eYg
 scszXZ5R1lCyHpFId8547EXpCMVzBdxNP51Ndys=
X-Google-Smtp-Source: APXvYqzRgJnweowczKsHPFSR0x3PT9A0JNBdyCUtldC0VFzC9BQZFLH0MDqB3kunEaAYTSaKbMET6OfGNzdz8ibVUvc=
X-Received: by 2002:aca:4ece:: with SMTP id c197mr2679620oib.53.1582716784996; 
 Wed, 26 Feb 2020 03:33:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 26 Feb 2020 03:33:04 -0800 (PST)
In-Reply-To: <20200225154121.21116-3-peter.maydell@linaro.org>
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <20200225154121.21116-3-peter.maydell@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 26 Feb 2020 12:33:04 +0100
Message-ID: <CAL1e-=gQd7Xb1LZR5nGtjraAFz1AUsHy+_76CZbtL8TuBXX3rQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] docs: Remove the "CPU emulation" part of the
 "Implementation notes"
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bff4ef059f78f742"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bff4ef059f78f742
Content-Type: text/plain; charset="UTF-8"

On Tuesday, February 25, 2020, Peter Maydell <peter.maydell@linaro.org>
wrote:

> The "CPU emulation" part of the "Implementation notes" in
> qemu-tech.texi looks like it is documenting what features of various
> CPUs we do or don't emulate.  However:
>  * it covers only six of our 21 guest architectures
>  * the last time anybody updated it for actual content was in
>    2011/2012 for Xtensa; the content for the other five
>    architectures is even older, being from 2008 or before!
>
> What we have is out of date, misleading and incomplete.
> Just delete this part of the document rather than trying to
> convert it to rST.
>
> (It would be nice eventually to have documentation of the
> scope and limitations of our emulation; but we will want to
> separate out the generic "system emulation" information from
> the parts that are specific to linux-user anyway, as they will
> be in different manuals.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---


I agree with the intent and the outcome of this patch, including the last
paragraph in braces.

FWIW:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


 qemu-tech.texi | 153 -------------------------------------------------
>  1 file changed, 153 deletions(-)
>
> diff --git a/qemu-tech.texi b/qemu-tech.texi
> index 0380de77b62..35da6a40af1 100644
> --- a/qemu-tech.texi
> +++ b/qemu-tech.texi
> @@ -2,162 +2,9 @@
>  @appendix Implementation notes
>
>  @menu
> -* CPU emulation::
>  * Managed start up options::
>  @end menu
>
> -@node CPU emulation
> -@section CPU emulation
> -
> -@menu
> -* x86::     x86 and x86-64 emulation
> -* ARM::     ARM emulation
> -* MIPS::    MIPS emulation
> -* PPC::     PowerPC emulation
> -* SPARC::   Sparc32 and Sparc64 emulation
> -* Xtensa::  Xtensa emulation
> -@end menu
> -
> -@node x86
> -@subsection x86 and x86-64 emulation
> -
> -QEMU x86 target features:
> -
> -@itemize
> -
> -@item The virtual x86 CPU supports 16 bit and 32 bit addressing with
> segmentation.
> -LDT/GDT and IDT are emulated. VM86 mode is also supported to run
> -DOSEMU. There is some support for MMX/3DNow!, SSE, SSE2, SSE3, SSSE3,
> -and SSE4 as well as x86-64 SVM.
> -
> -@item Support of host page sizes bigger than 4KB in user mode emulation.
> -
> -@item QEMU can emulate itself on x86.
> -
> -@item An extensive Linux x86 CPU test program is included
> @file{tests/test-i386}.
> -It can be used to test other x86 virtual CPUs.
> -
> -@end itemize
> -
> -Current QEMU limitations:
> -
> -@itemize
> -
> -@item Limited x86-64 support.
> -
> -@item IPC syscalls are missing.
> -
> -@item The x86 segment limits and access rights are not tested at every
> -memory access (yet). Hopefully, very few OSes seem to rely on that for
> -normal use.
> -
> -@end itemize
> -
> -@node ARM
> -@subsection ARM emulation
> -
> -@itemize
> -
> -@item Full ARM 7 user emulation.
> -
> -@item NWFPE FPU support included in user Linux emulation.
> -
> -@item Can run most ARM Linux binaries.
> -
> -@end itemize
> -
> -@node MIPS
> -@subsection MIPS emulation
> -
> -@itemize
> -
> -@item The system emulation allows full MIPS32/MIPS64 Release 2 emulation,
> -including privileged instructions, FPU and MMU, in both little and big
> -endian modes.
> -
> -@item The Linux userland emulation can run many 32 bit MIPS Linux
> binaries.
> -
> -@end itemize
> -
> -Current QEMU limitations:
> -
> -@itemize
> -
> -@item Self-modifying code is not always handled correctly.
> -
> -@item 64 bit userland emulation is not implemented.
> -
> -@item The system emulation is not complete enough to run real firmware.
> -
> -@item The watchpoint debug facility is not implemented.
> -
> -@end itemize
> -
> -@node PPC
> -@subsection PowerPC emulation
> -
> -@itemize
> -
> -@item Full PowerPC 32 bit emulation, including privileged instructions,
> -FPU and MMU.
> -
> -@item Can run most PowerPC Linux binaries.
> -
> -@end itemize
> -
> -@node SPARC
> -@subsection Sparc32 and Sparc64 emulation
> -
> -@itemize
> -
> -@item Full SPARC V8 emulation, including privileged
> -instructions, FPU and MMU. SPARC V9 emulation includes most privileged
> -and VIS instructions, FPU and I/D MMU. Alignment is fully enforced.
> -
> -@item Can run most 32-bit SPARC Linux binaries, SPARC32PLUS Linux
> binaries and
> -some 64-bit SPARC Linux binaries.
> -
> -@end itemize
> -
> -Current QEMU limitations:
> -
> -@itemize
> -
> -@item IPC syscalls are missing.
> -
> -@item Floating point exception support is buggy.
> -
> -@item Atomic instructions are not correctly implemented.
> -
> -@item There are still some problems with Sparc64 emulators.
> -
> -@end itemize
> -
> -@node Xtensa
> -@subsection Xtensa emulation
> -
> -@itemize
> -
> -@item Core Xtensa ISA emulation, including most options: code density,
> -loop, extended L32R, 16- and 32-bit multiplication, 32-bit division,
> -MAC16, miscellaneous operations, boolean, FP coprocessor, coprocessor
> -context, debug, multiprocessor synchronization,
> -conditional store, exceptions, relocatable vectors, unaligned exception,
> -interrupts (including high priority and timer), hardware alignment,
> -region protection, region translation, MMU, windowed registers, thread
> -pointer, processor ID.
> -
> -@item Not implemented options: data/instruction cache (including cache
> -prefetch and locking), XLMI, processor interface. Also options not
> -covered by the core ISA (e.g. FLIX, wide branches) are not implemented.
> -
> -@item Can run most Xtensa Linux binaries.
> -
> -@item New core configuration that requires no additional instructions
> -may be created from overlay with minimal amount of hand-written code.
> -
> -@end itemize
> -
>  @node Managed start up options
>  @section Managed start up options
>
> --
> 2.20.1
>
>
>

--000000000000bff4ef059f78f742
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, February 25, 2020, Peter Maydell &lt;<a href=3D"mailto:=
peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">The &quot;CPU emulation&quot; part of the &quot;Im=
plementation notes&quot; in<br>
qemu-tech.texi looks like it is documenting what features of various<br>
CPUs we do or don&#39;t emulate.=C2=A0 However:<br>
=C2=A0* it covers only six of our 21 guest architectures<br>
=C2=A0* the last time anybody updated it for actual content was in<br>
=C2=A0 =C2=A02011/2012 for Xtensa; the content for the other five<br>
=C2=A0 =C2=A0architectures is even older, being from 2008 or before!<br>
<br>
What we have is out of date, misleading and incomplete.<br>
Just delete this part of the document rather than trying to<br>
convert it to rST.<br>
<br>
(It would be nice eventually to have documentation of the<br>
scope and limitations of our emulation; but we will want to<br>
separate out the generic &quot;system emulation&quot; information from<br>
the parts that are specific to linux-user anyway, as they will<br>
be in different manuals.)<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
">peter.maydell@linaro.org</a>&gt;<br>
---</blockquote><div><br></div><div>I agree with the intent and the outcome=
 of this patch, including the last paragraph in braces.</div><div>=C2=A0</d=
iv><div>FWIW:</div><div><br></div><div>Reviewed-by: Aleksandar Markovic &lt=
;<a href=3D"mailto:amarkovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;</=
div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0qemu-tech.texi | 153 ------------------------------<wbr>-------------=
------<br>
=C2=A01 file changed, 153 deletions(-)<br>
<br>
diff --git a/qemu-tech.texi b/qemu-tech.texi<br>
index 0380de77b62..35da6a40af1 100644<br>
--- a/qemu-tech.texi<br>
+++ b/qemu-tech.texi<br>
@@ -2,162 +2,9 @@<br>
=C2=A0@appendix Implementation notes<br>
<br>
=C2=A0@menu<br>
-* CPU emulation::<br>
=C2=A0* Managed start up options::<br>
=C2=A0@end menu<br>
<br>
-@node CPU emulation<br>
-@section CPU emulation<br>
-<br>
-@menu<br>
-* x86::=C2=A0 =C2=A0 =C2=A0x86 and x86-64 emulation<br>
-* ARM::=C2=A0 =C2=A0 =C2=A0ARM emulation<br>
-* MIPS::=C2=A0 =C2=A0 MIPS emulation<br>
-* PPC::=C2=A0 =C2=A0 =C2=A0PowerPC emulation<br>
-* SPARC::=C2=A0 =C2=A0Sparc32 and Sparc64 emulation<br>
-* Xtensa::=C2=A0 Xtensa emulation<br>
-@end menu<br>
-<br>
-@node x86<br>
-@subsection x86 and x86-64 emulation<br>
-<br>
-QEMU x86 target features:<br>
-<br>
-@itemize<br>
-<br>
-@item The virtual x86 CPU supports 16 bit and 32 bit addressing with segme=
ntation.<br>
-LDT/GDT and IDT are emulated. VM86 mode is also supported to run<br>
-DOSEMU. There is some support for MMX/3DNow!, SSE, SSE2, SSE3, SSSE3,<br>
-and SSE4 as well as x86-64 SVM.<br>
-<br>
-@item Support of host page sizes bigger than 4KB in user mode emulation.<b=
r>
-<br>
-@item QEMU can emulate itself on x86.<br>
-<br>
-@item An extensive Linux x86 CPU test program is included @file{tests/test=
-i386}.<br>
-It can be used to test other x86 virtual CPUs.<br>
-<br>
-@end itemize<br>
-<br>
-Current QEMU limitations:<br>
-<br>
-@itemize<br>
-<br>
-@item Limited x86-64 support.<br>
-<br>
-@item IPC syscalls are missing.<br>
-<br>
-@item The x86 segment limits and access rights are not tested at every<br>
-memory access (yet). Hopefully, very few OSes seem to rely on that for<br>
-normal use.<br>
-<br>
-@end itemize<br>
-<br>
-@node ARM<br>
-@subsection ARM emulation<br>
-<br>
-@itemize<br>
-<br>
-@item Full ARM 7 user emulation.<br>
-<br>
-@item NWFPE FPU support included in user Linux emulation.<br>
-<br>
-@item Can run most ARM Linux binaries.<br>
-<br>
-@end itemize<br>
-<br>
-@node MIPS<br>
-@subsection MIPS emulation<br>
-<br>
-@itemize<br>
-<br>
-@item The system emulation allows full MIPS32/MIPS64 Release 2 emulation,<=
br>
-including privileged instructions, FPU and MMU, in both little and big<br>
-endian modes.<br>
-<br>
-@item The Linux userland emulation can run many 32 bit MIPS Linux binaries=
.<br>
-<br>
-@end itemize<br>
-<br>
-Current QEMU limitations:<br>
-<br>
-@itemize<br>
-<br>
-@item Self-modifying code is not always handled correctly.<br>
-<br>
-@item 64 bit userland emulation is not implemented.<br>
-<br>
-@item The system emulation is not complete enough to run real firmware.<br=
>
-<br>
-@item The watchpoint debug facility is not implemented.<br>
-<br>
-@end itemize<br>
-<br>
-@node PPC<br>
-@subsection PowerPC emulation<br>
-<br>
-@itemize<br>
-<br>
-@item Full PowerPC 32 bit emulation, including privileged instructions,<br=
>
-FPU and MMU.<br>
-<br>
-@item Can run most PowerPC Linux binaries.<br>
-<br>
-@end itemize<br>
-<br>
-@node SPARC<br>
-@subsection Sparc32 and Sparc64 emulation<br>
-<br>
-@itemize<br>
-<br>
-@item Full SPARC V8 emulation, including privileged<br>
-instructions, FPU and MMU. SPARC V9 emulation includes most privileged<br>
-and VIS instructions, FPU and I/D MMU. Alignment is fully enforced.<br>
-<br>
-@item Can run most 32-bit SPARC Linux binaries, SPARC32PLUS Linux binaries=
 and<br>
-some 64-bit SPARC Linux binaries.<br>
-<br>
-@end itemize<br>
-<br>
-Current QEMU limitations:<br>
-<br>
-@itemize<br>
-<br>
-@item IPC syscalls are missing.<br>
-<br>
-@item Floating point exception support is buggy.<br>
-<br>
-@item Atomic instructions are not correctly implemented.<br>
-<br>
-@item There are still some problems with Sparc64 emulators.<br>
-<br>
-@end itemize<br>
-<br>
-@node Xtensa<br>
-@subsection Xtensa emulation<br>
-<br>
-@itemize<br>
-<br>
-@item Core Xtensa ISA emulation, including most options: code density,<br>
-loop, extended L32R, 16- and 32-bit multiplication, 32-bit division,<br>
-MAC16, miscellaneous operations, boolean, FP coprocessor, coprocessor<br>
-context, debug, multiprocessor synchronization,<br>
-conditional store, exceptions, relocatable vectors, unaligned exception,<b=
r>
-interrupts (including high priority and timer), hardware alignment,<br>
-region protection, region translation, MMU, windowed registers, thread<br>
-pointer, processor ID.<br>
-<br>
-@item Not implemented options: data/instruction cache (including cache<br>
-prefetch and locking), XLMI, processor interface. Also options not<br>
-covered by the core ISA (e.g. FLIX, wide branches) are not implemented.<br=
>
-<br>
-@item Can run most Xtensa Linux binaries.<br>
-<br>
-@item New core configuration that requires no additional instructions<br>
-may be created from overlay with minimal amount of hand-written code.<br>
-<br>
-@end itemize<br>
-<br>
=C2=A0@node Managed start up options<br>
=C2=A0@section Managed start up options<br>
=C2=A0<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--000000000000bff4ef059f78f742--

