Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECBFC10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9372073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XquSQoun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9372073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAyV-0006sX-Dh
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAArz-0003Qq-3N
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAArx-0004oS-Ci
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:18 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAArx-0004lp-5B
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:17 -0500
Received: by mail-wr1-x441.google.com with SMTP id v4so1857638wrs.8
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IGxEfXFrVgNJGO2aX19SsaOhtwzGMz5rkCkscjkUbsU=;
 b=XquSQoun/mCxqwAVkbbChPCGpN0/JaWd6j7WZZgEDn19LDvCA65eb9HkCbfNrC8myk
 LM0BgW/LO45BrAl8YCXkWqqvF/5dOYb30yCcIoaISGMtlbuiq14d/+hDdSuN76kwdX4t
 o+webICXuGzAFFiikbst8TE3A6HHgwIhvKjqXAiL6iwVtezfGoqUTX12oX6tZlCNzRw4
 ZYF31ttjHjIxEmzGohk/IGpsZWEW/he6xjlzPd0ZbaQczl44fBzW2MbM9bLQfwjuLs4S
 zysbgsX+6tFCncRGucM5As2B7havlRXXoClNB1puN8Rr8nMFxplX5ElnLVQpzPILP2vo
 20HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IGxEfXFrVgNJGO2aX19SsaOhtwzGMz5rkCkscjkUbsU=;
 b=f5sTz48UUtY+2ZB0vfEDrEHMzNAQ6wME9CuV/vtfMkuAHhXAOzC+YhaqZVLRoj4gnB
 tk2nIe72n1NAUTjxY/I8l1ZwAqu/cdEMdjM4PYFZCPOVkretB7HyswltvIOXqM547CT7
 GXpv/bUG6SXEYzOnsmaq2JwuWcIL04QmveUHzeUy+tXAoVCe553otAbaoKXmZommvEBV
 gSGCJUq6sirlXCSyJf/DawioCSUyM+nsogMJ5Lsge6eXud1JBO4PscZLR/6pD3xU5MWv
 2oJ0S07zfMCNgIPfJpjyNHyyfBrGA7Xx5iI+qGsv0yaHO3dOgu+EPNNnd5WHOoumcRau
 iyRA==
X-Gm-Message-State: ANhLgQ2WbRQCiltlYpoRtUNtg/TThoLpoKGVIF3UBD/xCU2JR066NycO
 8bSy1+GQ2sj5aC5wfIOg8GBX7fU7bUm3iw==
X-Google-Smtp-Source: ADFU+vtFVl7Wmtz6lEuNL7NVEg0IhRKMFnAwsuxWx6BP/xMzYhzn9SGl/04Y43tcbS3531tpx1KISw==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr3408340wrm.133.1583493015641; 
 Fri, 06 Mar 2020 03:10:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/33] qemu-doc: Remove the "CPU emulation" part of the
 "Implementation notes"
Date: Fri,  6 Mar 2020 11:09:35 +0000
Message-Id: <20200306110959.29461-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "CPU emulation" part of the "Implementation notes" in
qemu-tech.texi looks like it is documenting what features of various
CPUs we do or don't emulate.  However:
 * it covers only six of our 21 guest architectures
 * the last time anybody updated it for actual content was in
   2011/2012 for Xtensa; the content for the other five
   architectures is even older, being from 2008 or before!

What we have is out of date, misleading and incomplete.
Just delete this part of the document rather than trying to
convert it to rST.

(It would be nice eventually to have documentation of the
scope and limitations of our emulation; but we will want to
separate out the generic "system emulation" information from
the parts that are specific to linux-user anyway, as they will
be in different manuals.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20200228153619.9906-10-peter.maydell@linaro.org
Message-id: 20200226113034.6741-10-pbonzini@redhat.com
Message-Id: <20200225154121.21116-3-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-tech.texi | 153 -------------------------------------------------
 1 file changed, 153 deletions(-)

diff --git a/qemu-tech.texi b/qemu-tech.texi
index 0380de77b62..35da6a40af1 100644
--- a/qemu-tech.texi
+++ b/qemu-tech.texi
@@ -2,162 +2,9 @@
 @appendix Implementation notes
 
 @menu
-* CPU emulation::
 * Managed start up options::
 @end menu
 
-@node CPU emulation
-@section CPU emulation
-
-@menu
-* x86::     x86 and x86-64 emulation
-* ARM::     ARM emulation
-* MIPS::    MIPS emulation
-* PPC::     PowerPC emulation
-* SPARC::   Sparc32 and Sparc64 emulation
-* Xtensa::  Xtensa emulation
-@end menu
-
-@node x86
-@subsection x86 and x86-64 emulation
-
-QEMU x86 target features:
-
-@itemize
-
-@item The virtual x86 CPU supports 16 bit and 32 bit addressing with segmentation.
-LDT/GDT and IDT are emulated. VM86 mode is also supported to run
-DOSEMU. There is some support for MMX/3DNow!, SSE, SSE2, SSE3, SSSE3,
-and SSE4 as well as x86-64 SVM.
-
-@item Support of host page sizes bigger than 4KB in user mode emulation.
-
-@item QEMU can emulate itself on x86.
-
-@item An extensive Linux x86 CPU test program is included @file{tests/test-i386}.
-It can be used to test other x86 virtual CPUs.
-
-@end itemize
-
-Current QEMU limitations:
-
-@itemize
-
-@item Limited x86-64 support.
-
-@item IPC syscalls are missing.
-
-@item The x86 segment limits and access rights are not tested at every
-memory access (yet). Hopefully, very few OSes seem to rely on that for
-normal use.
-
-@end itemize
-
-@node ARM
-@subsection ARM emulation
-
-@itemize
-
-@item Full ARM 7 user emulation.
-
-@item NWFPE FPU support included in user Linux emulation.
-
-@item Can run most ARM Linux binaries.
-
-@end itemize
-
-@node MIPS
-@subsection MIPS emulation
-
-@itemize
-
-@item The system emulation allows full MIPS32/MIPS64 Release 2 emulation,
-including privileged instructions, FPU and MMU, in both little and big
-endian modes.
-
-@item The Linux userland emulation can run many 32 bit MIPS Linux binaries.
-
-@end itemize
-
-Current QEMU limitations:
-
-@itemize
-
-@item Self-modifying code is not always handled correctly.
-
-@item 64 bit userland emulation is not implemented.
-
-@item The system emulation is not complete enough to run real firmware.
-
-@item The watchpoint debug facility is not implemented.
-
-@end itemize
-
-@node PPC
-@subsection PowerPC emulation
-
-@itemize
-
-@item Full PowerPC 32 bit emulation, including privileged instructions,
-FPU and MMU.
-
-@item Can run most PowerPC Linux binaries.
-
-@end itemize
-
-@node SPARC
-@subsection Sparc32 and Sparc64 emulation
-
-@itemize
-
-@item Full SPARC V8 emulation, including privileged
-instructions, FPU and MMU. SPARC V9 emulation includes most privileged
-and VIS instructions, FPU and I/D MMU. Alignment is fully enforced.
-
-@item Can run most 32-bit SPARC Linux binaries, SPARC32PLUS Linux binaries and
-some 64-bit SPARC Linux binaries.
-
-@end itemize
-
-Current QEMU limitations:
-
-@itemize
-
-@item IPC syscalls are missing.
-
-@item Floating point exception support is buggy.
-
-@item Atomic instructions are not correctly implemented.
-
-@item There are still some problems with Sparc64 emulators.
-
-@end itemize
-
-@node Xtensa
-@subsection Xtensa emulation
-
-@itemize
-
-@item Core Xtensa ISA emulation, including most options: code density,
-loop, extended L32R, 16- and 32-bit multiplication, 32-bit division,
-MAC16, miscellaneous operations, boolean, FP coprocessor, coprocessor
-context, debug, multiprocessor synchronization,
-conditional store, exceptions, relocatable vectors, unaligned exception,
-interrupts (including high priority and timer), hardware alignment,
-region protection, region translation, MMU, windowed registers, thread
-pointer, processor ID.
-
-@item Not implemented options: data/instruction cache (including cache
-prefetch and locking), XLMI, processor interface. Also options not
-covered by the core ISA (e.g. FLIX, wide branches) are not implemented.
-
-@item Can run most Xtensa Linux binaries.
-
-@item New core configuration that requires no additional instructions
-may be created from overlay with minimal amount of hand-written code.
-
-@end itemize
-
 @node Managed start up options
 @section Managed start up options
 
-- 
2.20.1


