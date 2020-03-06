Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5515FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2231F20848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="biestkwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2231F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAwP-0003J6-AC
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAArw-0003KM-Lr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAArs-0004Yy-OS
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:16 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAArs-0004Vz-GD
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:12 -0500
Received: by mail-wr1-x433.google.com with SMTP id s17so955683wrs.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JOna8LKhtleQtjiKaXcgaGEoiplWxi2ucM1nzHdSZwA=;
 b=biestkwMy73EPkOJpxuYC9J3H4mCgLDXihEyflgnMDriU0gFTSF/MC8fUFCB0u7fMg
 meV1NOWZyWbCbirGokjxw5fpoXvkOW1FMkyivVjbZ6UTULNus6MlI2iv9jJF5jrKchNa
 abzd/3uwrGPY6zYpEBAz19+zFw4Nbpqz7r5/VZGClUB2cTvp99GZLYnzLcwzSar2gQaP
 OookDvUO/SOGS79HBM9WRFEk9brejEZsBXLO1v56nQtRMW6Q09G+xx4T2TtCy2ZLly1H
 FnQ8DypCnvK3g/br6aniu5HDfuFho5kyUOh/4GeO1D5Gs89xjl5kAHu0Ov4OD3BMoB3Q
 NH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JOna8LKhtleQtjiKaXcgaGEoiplWxi2ucM1nzHdSZwA=;
 b=TMwZoBIt1y2r6bJzIIzw+2duhS5vTRWkgxWeN7FDbzLIOO/RBOw0MEOD2pUSlJkcZP
 NwLyDT1OWLlNqbQVHmoXPfN2+X3AbAQof3LVtWNU+xhPtLiuoXSEMZ2uqSfpogL/CBTV
 n5wFMaBbniyqQnsiEw2jYTsoHmfrb0iBPyWthqFzxGd4s30y+rgzYtoOOLWD05GeF/0s
 F+2eKvnbjqS8TrQGbSUI1Rjn1suWI0XuL8MFdMlLNPuLHaGd+CinG2RWjtsXJ16ZzD/s
 KpgtBUZNZ1uyo0LAgITcmj07aY2AHc0rVZvtiTbRBEZcONsuuBXzEdFAmjmYGZKUpZTt
 GIsw==
X-Gm-Message-State: ANhLgQ1SF8BcyNLxQuuJO1EVUoCpcWmUQJqP1ws1cM/bPQtVojDcR4md
 f72kLdHXVzNdS/RQmE/KkurvRX/+2tmg9g==
X-Google-Smtp-Source: ADFU+vvv2uYBZ+yAhThLvlxuZj5zBlqzxJOZ0yNKPASuDC4aZuvzIl15CwcMJd0F5hXRinwBuL7hFw==
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr3692620wrp.247.1583493011129; 
 Fri, 06 Mar 2020 03:10:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/33] qemu-doc: extract common system emulator documentation
 from the PC section
Date: Fri,  6 Mar 2020 11:09:32 +0000
Message-Id: <20200306110959.29461-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

From: Paolo Bonzini <pbonzini@redhat.com>

Move the section on PC peripherals together with other targets.
While some x86-specific information remains in the main system
emulation chapter, it can be tackled more easily a section at a
time.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200228153619.9906-7-peter.maydell@linaro.org
Message-id: 20200226113034.6741-7-pbonzini@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/quickstart.texi |   2 +-
 qemu-doc.texi               | 102 ++++++++++++++++++++----------------
 2 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/docs/system/quickstart.texi b/docs/system/quickstart.texi
index 8cd5b4bc6e5..ed7295de7a2 100644
--- a/docs/system/quickstart.texi
+++ b/docs/system/quickstart.texi
@@ -2,7 +2,7 @@
 @section Quick Start
 @cindex quick start
 
-Download and uncompress a hard disk image with Linux installed (e.g.
+Download and uncompress a PC hard disk image with Linux installed (e.g.
 @file{linux.img}) and type:
 
 @example
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 33d24caf946..88e84300e91 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -36,8 +36,8 @@
 
 @menu
 * Introduction::
-* QEMU PC System emulator::
-* QEMU System emulator for non PC targets::
+* QEMU System emulator::
+* QEMU System emulator targets::
 * System requirements::
 * Security::
 * Implementation notes::
@@ -127,19 +127,16 @@ accelerator is required to use more than one host CPU for emulation.
 
 @end itemize
 
-
-@node QEMU PC System emulator
-@chapter QEMU PC System emulator
-@cindex system emulation (PC)
+@node QEMU System emulator
+@chapter QEMU System emulator
+@cindex system emulation
 
 @menu
-* pcsys_introduction:: Introduction
-* pcsys_quickstart::   Quick Start
+* pcsys_quickstart::   Quick start
 * sec_invocation::     Invocation
 * pcsys_keys::         Keys in the graphical frontends
 * mux_keys::           Keys in the character backend multiplexer
 * pcsys_monitor::      QEMU Monitor
-* cpu_models_x86::     Supported CPU model configurations on x86 hosts
 * disk_images::        Disk Images
 * pcsys_network::      Network emulation
 * pcsys_usb::          USB emulation
@@ -150,13 +147,57 @@ accelerator is required to use more than one host CPU for emulation.
 * gdb_usage::          GDB usage
 @end menu
 
-@node pcsys_introduction
-@section Introduction
+@include docs/system/quickstart.texi
+@include docs/system/invocation.texi
+@include docs/system/keys.texi
+@include docs/system/mux-chardev.texi
+@include docs/system/monitor.texi
+@include docs/system/images.texi
+@include docs/system/net.texi
+@include docs/system/usb.texi
+@include docs/system/ivshmem.texi
+@include docs/system/linuxboot.texi
+@include docs/system/vnc-security.texi
+@include docs/system/tls.texi
+@include docs/system/gdb.texi
+
+@node QEMU System emulator targets
+@chapter QEMU System emulator targets
+@cindex system emulation (PC)
+
+QEMU is a generic emulator and it emulates many machines. Most of the
+options are similar for all machines. Specific information about the
+various targets are mentioned in the following sections.
+
+@menu
+* x86 (PC) System emulator::
+* PowerPC System emulator::
+* Sparc32 System emulator::
+* Sparc64 System emulator::
+* MIPS System emulator::
+* ARM System emulator::
+* ColdFire System emulator::
+* Cris System emulator::
+* Microblaze System emulator::
+* SH4 System emulator::
+* Xtensa System emulator::
+@end menu
+
+@node x86 (PC) System emulator
+@section x86 (PC) System emulator
+@cindex system emulation (PC)
+
+@menu
+* pcsys_devices::      Peripherals
+* cpu_models_x86::     Supported CPU model configurations on x86 hosts
+@end menu
+
+@node pcsys_devices
+@subsection Peripherals
 
 @c man begin DESCRIPTION
 
-The QEMU PC System emulator simulates the
-following peripherals:
+The QEMU PC System emulator simulates the following peripherals:
 
 @itemize @minus
 @item
@@ -222,40 +263,9 @@ CS4231A is the chip used in Windows Sound System and GUSMAX products
 
 @c man end
 
-@include docs/system/quickstart.texi
-@include docs/system/invocation.texi
-@include docs/system/keys.texi
-@include docs/system/mux-chardev.texi
-@include docs/system/monitor.texi
+@lowersections
 @include docs/system/cpu-models-x86.texi
-@include docs/system/images.texi
-@include docs/system/net.texi
-@include docs/system/usb.texi
-@include docs/system/ivshmem.texi
-@include docs/system/linuxboot.texi
-@include docs/system/vnc-security.texi
-@include docs/system/tls.texi
-@include docs/system/gdb.texi
-
-@node QEMU System emulator for non PC targets
-@chapter QEMU System emulator for non PC targets
-
-QEMU is a generic emulator and it emulates many non PC
-machines. Most of the options are similar to the PC emulator. The
-differences are mentioned in the following sections.
-
-@menu
-* PowerPC System emulator::
-* Sparc32 System emulator::
-* Sparc64 System emulator::
-* MIPS System emulator::
-* ARM System emulator::
-* ColdFire System emulator::
-* Cris System emulator::
-* Microblaze System emulator::
-* SH4 System emulator::
-* Xtensa System emulator::
-@end menu
+@raisesections
 
 @node PowerPC System emulator
 @section PowerPC System emulator
-- 
2.20.1


