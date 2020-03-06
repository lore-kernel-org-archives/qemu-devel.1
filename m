Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35493C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2BAC2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXzjV5C/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BAC2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAwW-0003YA-Vi
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAs4-0003e4-1g
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAs1-000502-Hg
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:23 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAs1-0004yp-83
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id a132so1934334wme.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dQ7uQWHPnlVErAB4L0byEijgk6LslSpBchTS6V+rMYw=;
 b=bXzjV5C/jycqUmnpZw0KTFFr8eMksFzd1rLWcOd6xPrnZwche7Sr0JGi4WJfvzYxL7
 N92DL+5+rTLD0yBBXfO4jCZ+wBVTHFkIrM/Y5mKZxPLKUCSgHmWY+XrxCOOjM9xYijIm
 NT/lfe0e3R4yCodjmuMC4C2Q7SV27H+i7nax7ebsVTe9vouDPxFX/YgxON+s5bPSRgr+
 TV8uQ5kbfX1ey/PliQ/I6DAI/QQke61PgJGruLq/jBWMl0NjTG/6Gh+/RjPZPfMp/1nL
 MkQIDpCvpRKLoLYt7Sx+8TdMJd/ywSS6/2ALMxDnNFvTUqou0/tvPm/2FOdAX/CJku2g
 TPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dQ7uQWHPnlVErAB4L0byEijgk6LslSpBchTS6V+rMYw=;
 b=rrgwvUJE5AGNWQGQm3qZDP6BqVEfhuNEMoctgC8+xRNIlKYdXodaLI+c63rUfCQ5Xb
 j6Jp7Z+EiUJk/kbW0H8lSATbSr8P3Zc1y5nH4NhRo5LSETwpgy8zAZnHQJZ+qRVLwhN5
 QJjNQRkCiufA20NY+sQfFGkZ5o1K2bIBU5QpXeLHOsR7j57gfrvfhYkCdkYpr3ad1edA
 lfX4uvwGnnBXqyc7UPsY4S/Bsuyc1SgMWqDtXaEXm6HVlJM1YrCUzGppInhuzrrhCNYO
 3s+9Isv5UDlFU/z5eckzs+O3Uwp1QAC2EHxetncyAmx/iXsCY9u2UV025eB3upkaEMUe
 txlQ==
X-Gm-Message-State: ANhLgQ1hEEa9InwzEOvYQ+/i8uCCNvdZP0kM4/jVptoTh9xzIz88CLee
 RrbYElwAN0nrva2sNEuucAh3rWxKlZbuAg==
X-Google-Smtp-Source: ADFU+vsHTnsWMAqEhwiW6Dk/JQlw0rqC6bFMgNX4hrTAwKyyjcVSefAKh0pcZX0EYN3IRG4DhENkQA==
X-Received: by 2002:a1c:8041:: with SMTP id b62mr3412769wmd.76.1583493019314; 
 Fri, 06 Mar 2020 03:10:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/33] qemu-doc: remove indices other than findex
Date: Fri,  6 Mar 2020 11:09:38 +0000
Message-Id: <20200306110959.29461-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

These indices are not well-maintained, and pandoc also chokes on the
directives.  Just nuke them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200228153619.9906-13-peter.maydell@linaro.org
Message-id: 20200226113034.6741-13-pbonzini@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/keys.texi           | 10 --------
 docs/system/monitor.texi        |  1 -
 docs/system/mux-chardev.texi    |  7 ------
 docs/system/quickstart.texi     |  1 -
 docs/system/target-arm.texi     |  1 -
 docs/system/target-i386.texi    |  1 -
 docs/system/target-m68k.texi    |  2 --
 docs/system/target-mips.texi    |  2 --
 docs/system/target-ppc.texi     |  1 -
 docs/system/target-sparc.texi   |  1 -
 docs/system/target-sparc64.texi |  1 -
 docs/system/target-xtensa.texi  |  1 -
 qemu-doc.texi                   | 44 ---------------------------------
 13 files changed, 73 deletions(-)

diff --git a/docs/system/keys.texi b/docs/system/keys.texi
index 4c74b3bf4dd..c04daf54f23 100644
--- a/docs/system/keys.texi
+++ b/docs/system/keys.texi
@@ -10,23 +10,18 @@ then the modifier is Ctrl-Alt-Shift (instead of Ctrl-Alt) and if you use
 
 @table @key
 @item Ctrl-Alt-f
-@kindex Ctrl-Alt-f
 Toggle full screen
 
 @item Ctrl-Alt-+
-@kindex Ctrl-Alt-+
 Enlarge the screen
 
 @item Ctrl-Alt--
-@kindex Ctrl-Alt--
 Shrink the screen
 
 @item Ctrl-Alt-u
-@kindex Ctrl-Alt-u
 Restore the screen's un-scaled dimensions
 
 @item Ctrl-Alt-n
-@kindex Ctrl-Alt-n
 Switch to virtual console 'n'. Standard console mappings are:
 @table @emph
 @item 1
@@ -38,14 +33,9 @@ Serial port
 @end table
 
 @item Ctrl-Alt
-@kindex Ctrl-Alt
 Toggle mouse and keyboard grab.
 @end table
 
-@kindex Ctrl-Up
-@kindex Ctrl-Down
-@kindex Ctrl-PageUp
-@kindex Ctrl-PageDown
 In the virtual consoles, you can use @key{Ctrl-Up}, @key{Ctrl-Down},
 @key{Ctrl-PageUp} and @key{Ctrl-PageDown} to move in the back log.
 
diff --git a/docs/system/monitor.texi b/docs/system/monitor.texi
index c5b6a9b38e4..b41b144885d 100644
--- a/docs/system/monitor.texi
+++ b/docs/system/monitor.texi
@@ -1,6 +1,5 @@
 @node pcsys_monitor
 @section QEMU Monitor
-@cindex QEMU monitor
 
 The QEMU monitor is used to give complex commands to the QEMU
 emulator. You can use it to:
diff --git a/docs/system/mux-chardev.texi b/docs/system/mux-chardev.texi
index c9a2d14cb88..b21c2c56540 100644
--- a/docs/system/mux-chardev.texi
+++ b/docs/system/mux-chardev.texi
@@ -12,26 +12,19 @@ you're using the default.
 
 @table @key
 @item Ctrl-a h
-@kindex Ctrl-a h
 Print this help
 @item Ctrl-a x
-@kindex Ctrl-a x
 Exit emulator
 @item Ctrl-a s
-@kindex Ctrl-a s
 Save disk data back to file (if -snapshot)
 @item Ctrl-a t
-@kindex Ctrl-a t
 Toggle console timestamps
 @item Ctrl-a b
-@kindex Ctrl-a b
 Send break (magic sysrq in Linux)
 @item Ctrl-a c
-@kindex Ctrl-a c
 Rotate between the frontends connected to the multiplexer (usually
 this switches between the monitor and the console)
 @item Ctrl-a Ctrl-a
-@kindex Ctrl-a Ctrl-a
 Send the escape character to the frontend
 @end table
 @c man end
diff --git a/docs/system/quickstart.texi b/docs/system/quickstart.texi
index ed7295de7a2..baceaa96eb2 100644
--- a/docs/system/quickstart.texi
+++ b/docs/system/quickstart.texi
@@ -1,6 +1,5 @@
 @node pcsys_quickstart
 @section Quick Start
-@cindex quick start
 
 Download and uncompress a PC hard disk image with Linux installed (e.g.
 @file{linux.img}) and type:
diff --git a/docs/system/target-arm.texi b/docs/system/target-arm.texi
index 040d77b5e05..c56b5f6ebfe 100644
--- a/docs/system/target-arm.texi
+++ b/docs/system/target-arm.texi
@@ -1,6 +1,5 @@
 @node ARM System emulator
 @section ARM System emulator
-@cindex system emulation (ARM)
 
 Use the executable @file{qemu-system-arm} to simulate a ARM
 machine. The ARM Integrator/CP board is emulated with the following
diff --git a/docs/system/target-i386.texi b/docs/system/target-i386.texi
index edd23fa8df5..cc352b89a84 100644
--- a/docs/system/target-i386.texi
+++ b/docs/system/target-i386.texi
@@ -1,6 +1,5 @@
 @node x86 (PC) System emulator
 @section x86 (PC) System emulator
-@cindex system emulation (PC)
 
 @menu
 * pcsys_devices::      Peripherals
diff --git a/docs/system/target-m68k.texi b/docs/system/target-m68k.texi
index b5bc9df40ae..a77b19ea0f1 100644
--- a/docs/system/target-m68k.texi
+++ b/docs/system/target-m68k.texi
@@ -1,7 +1,5 @@
 @node ColdFire System emulator
 @section ColdFire System emulator
-@cindex system emulation (ColdFire)
-@cindex system emulation (M68K)
 
 Use the executable @file{qemu-system-m68k} to simulate a ColdFire machine.
 The emulator is able to boot a uClinux kernel.
diff --git a/docs/system/target-mips.texi b/docs/system/target-mips.texi
index f722c00912a..fe12ee94c73 100644
--- a/docs/system/target-mips.texi
+++ b/docs/system/target-mips.texi
@@ -1,6 +1,5 @@
 @node MIPS System emulator
 @section MIPS System emulator
-@cindex system emulation (MIPS)
 
 @menu
 * recommendations_cpu_models_MIPS:: Supported CPU model configurations on MIPS hosts
@@ -126,7 +125,6 @@ MIPSnet network emulation
 
 @node nanoMIPS System emulator
 @subsection nanoMIPS System emulator
-@cindex system emulation (nanoMIPS)
 
 Executable @file{qemu-system-mipsel} also covers simulation of
 32-bit nanoMIPS system in little endian mode:
diff --git a/docs/system/target-ppc.texi b/docs/system/target-ppc.texi
index c2c254d3d23..55f98f65b12 100644
--- a/docs/system/target-ppc.texi
+++ b/docs/system/target-ppc.texi
@@ -1,6 +1,5 @@
 @node PowerPC System emulator
 @section PowerPC System emulator
-@cindex system emulation (PowerPC)
 
 Use the executable @file{qemu-system-ppc} to simulate a complete 40P (PREP)
 or PowerMac PowerPC system.
diff --git a/docs/system/target-sparc.texi b/docs/system/target-sparc.texi
index 7fe0aec9c39..7748001f734 100644
--- a/docs/system/target-sparc.texi
+++ b/docs/system/target-sparc.texi
@@ -1,6 +1,5 @@
 @node Sparc32 System emulator
 @section Sparc32 System emulator
-@cindex system emulation (Sparc32)
 
 Use the executable @file{qemu-system-sparc} to simulate the following
 Sun4m architecture machines:
diff --git a/docs/system/target-sparc64.texi b/docs/system/target-sparc64.texi
index 9e7a27de0ce..4db4ca3842b 100644
--- a/docs/system/target-sparc64.texi
+++ b/docs/system/target-sparc64.texi
@@ -1,6 +1,5 @@
 @node Sparc64 System emulator
 @section Sparc64 System emulator
-@cindex system emulation (Sparc64)
 
 Use the executable @file{qemu-system-sparc64} to simulate a Sun4u
 (UltraSPARC PC-like machine), Sun4v (T1 PC-like machine), or generic
diff --git a/docs/system/target-xtensa.texi b/docs/system/target-xtensa.texi
index 08b0b362991..40327de6fa7 100644
--- a/docs/system/target-xtensa.texi
+++ b/docs/system/target-xtensa.texi
@@ -1,6 +1,5 @@
 @node Xtensa System emulator
 @section Xtensa System emulator
-@cindex system emulation (Xtensa)
 
 Two executables cover simulation of both Xtensa endian options,
 @file{qemu-system-xtensa} and @file{qemu-system-xtensaeb}.
diff --git a/qemu-doc.texi b/qemu-doc.texi
index d3e743719ab..c2b9c87c645 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -62,17 +62,14 @@
 QEMU is a FAST! processor emulator using dynamic translation to
 achieve good emulation speed.
 
-@cindex operating modes
 QEMU has two operating modes:
 
 @itemize
-@cindex system emulation
 @item Full system emulation. In this mode, QEMU emulates a full system (for
 example a PC), including one or several processors and various
 peripherals. It can be used to launch different Operating Systems
 without rebooting the PC or to debug system code.
 
-@cindex user mode emulation
 @item User mode emulation. In this mode, QEMU can launch
 processes compiled for one CPU on another CPU. It can be used to
 launch the Wine Windows API emulator (@url{https://www.winehq.org}) or
@@ -127,7 +124,6 @@ accelerator is required to use more than one host CPU for emulation.
 
 @node QEMU System emulator
 @chapter QEMU System emulator
-@cindex system emulation
 
 @menu
 * pcsys_quickstart::   Quick start
@@ -163,7 +159,6 @@ accelerator is required to use more than one host CPU for emulation.
 
 @node QEMU System emulator targets
 @chapter QEMU System emulator targets
-@cindex system emulation (PC)
 
 QEMU is a generic emulator and it emulates many machines. Most of the
 options are similar for all machines. Specific information about the
@@ -200,46 +195,7 @@ various targets are mentioned in the following sections.
 
 @node Index
 @appendix Index
-@menu
-* Concept Index::
-* Function Index::
-* Keystroke Index::
-* Program Index::
-* Data Type Index::
-* Variable Index::
-@end menu
 
-@node Concept Index
-@section Concept Index
-This is the main index. Should we combine all keywords in one index? TODO
-@printindex cp
-
-@node Function Index
-@section Function Index
-This index could be used for command line options and monitor functions.
 @printindex fn
 
-@node Keystroke Index
-@section Keystroke Index
-
-This is a list of all keystrokes which have a special function
-in system emulation.
-
-@printindex ky
-
-@node Program Index
-@section Program Index
-@printindex pg
-
-@node Data Type Index
-@section Data Type Index
-
-This index could be used for qdev device names and options.
-
-@printindex tp
-
-@node Variable Index
-@section Variable Index
-@printindex vr
-
 @bye
-- 
2.20.1


