Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E1CC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3ADC2166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsLkZbeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ADC2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jK4-0003Mc-0H
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jHc-0000ok-Fw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jHb-0007wj-0L
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:30:48 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8jHa-0007uy-PC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:30:46 -0500
Received: by mail-wr1-x441.google.com with SMTP id r7so12130460wro.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NizV0zswbq3YK4NUa8c1Bbn2oQmM5O6jk8yopwuXdys=;
 b=HsLkZbeIF/E1CcEQKGVXOdwB5BRhAMuwc+L1KTzOxzQSeJo8qCcVoEplXtmoSjvMyd
 i3OGTMofSvq30V0YvLVkR9Dsuu1yx9tV4WMb4OXbT7m4sz7XiNHznwUgKQejK608/IXp
 jXeYhNMlaniC1UXowzBsT1vMGeAQPORuz2xYQeGFBY1qL33M+ydKAUQqaxCzbLgv8MDL
 6JcPW0alB+9yffd1bmpH7c9onujdhqc/4aRulc++aqZ25Rgk8Z81vJEMnuqqW9UJVWOv
 zkZiWxzgLkxDCA874gV2dCKmNZfkI41CyN3W85X7ltFf7Mz9LL1VlfMdJc30co2OI6NP
 jRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NizV0zswbq3YK4NUa8c1Bbn2oQmM5O6jk8yopwuXdys=;
 b=soVD6NQg+fVj64kKHHvTmWmSFNAhuykTaK6pORf1e1UZ/Ns9AkN49y7UICpPhR+zuZ
 EdEtmStmVQgNtC1LQclBzqpZqBkPowm1RTfg8b6JD9OvB5Lu8PvhQTl3qd2PBKbYsXx/
 oiQh0bEGoNuYk9PuGRYWNanTs1bW2D1KspFNay789jvJ2HVNqEbSL0A4tSdek3U1S2+P
 BmOTSBLdnBSaynKhnuwFwBUWEuf8382OGXSVeJL7Q1uwqVhyGXzEK/AvibE0nw/3Jscd
 s06ZLn1vffE0whY+KaOPlS2X0Rjo/0Qak7XLXqjBrdyKNQxy+cNesgLw1Ewy2nZyDaVs
 Uwhw==
X-Gm-Message-State: APjAAAVByuEvJcghIVgVOwvUobggd2UnhPTwUjcgpYQ5MGuRx1X8PtdH
 FgYeTWkKcVCZfKa4o899sJfVWA==
X-Google-Smtp-Source: APXvYqwa67DQYjkwH8Vp0m08zGfThucwiQsobmH+Rg8XfKiJRy9Bvwj1D3Q6t0pDYtX3th2kkBxOJw==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr23086063wrs.166.1583148645417; 
 Mon, 02 Mar 2020 03:30:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y10sm14604393wma.26.2020.03.02.03.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:30:44 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9BCC71FF87;
 Mon,  2 Mar 2020 11:30:43 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-10-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 09/33] qemu-doc: Remove the "CPU emulation" part of
 the "Implementation notes"
In-reply-to: <20200228153619.9906-10-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 11:30:43 +0000
Message-ID: <87o8tfat98.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

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

Ahh I guess this is what would be the TCG specifics. I wonder if what
replaces this is more suitable as developer documentation? Anyway happy
to delete the cruft:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Message-id: 20200226113034.6741-10-pbonzini@redhat.com
> Message-Id: <20200225154121.21116-3-peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qemu-tech.texi | 153 -------------------------------------------------
>  1 file changed, 153 deletions(-)
>
> diff --git a/qemu-tech.texi b/qemu-tech.texi
> index 0380de77b62..35da6a40af1 100644
> --- a/qemu-tech.texi
> +++ b/qemu-tech.texi
> @@ -2,162 +2,9 @@
>  @appendix Implementation notes
>=20=20
>  @menu
> -* CPU emulation::
>  * Managed start up options::
>  @end menu
>=20=20
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
> -@item The virtual x86 CPU supports 16 bit and 32 bit addressing with seg=
mentation.
> -LDT/GDT and IDT are emulated. VM86 mode is also supported to run
> -DOSEMU. There is some support for MMX/3DNow!, SSE, SSE2, SSE3, SSSE3,
> -and SSE4 as well as x86-64 SVM.
> -
> -@item Support of host page sizes bigger than 4KB in user mode emulation.
> -
> -@item QEMU can emulate itself on x86.
> -
> -@item An extensive Linux x86 CPU test program is included @file{tests/te=
st-i386}.
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
> -@item The Linux userland emulation can run many 32 bit MIPS Linux binari=
es.
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
> -@item Can run most 32-bit SPARC Linux binaries, SPARC32PLUS Linux binari=
es and
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


--=20
Alex Benn=C3=A9e

