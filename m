Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA28C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAFC24685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKJSj2Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAFC24685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6v1b-0003A0-3U
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utu-0000rn-S5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uts-0006Yk-OM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:50 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6uts-0006Ub-Et
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:48 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so2543190wrn.6
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C1Czdr2m5DCpm3/C+F4+eTk0CwrmAVdgxwfK1fMPVT8=;
 b=aKJSj2EpylLCpchD4TTM9rViZt3fAqg2z/7FuomWWS7Math7a21ss9FzVGL0mMj/SY
 UXjTw+0IxR33gnXMqZjmkCZGvUqsqN6tTpnhRBNw7zK/2zO1oJ5DT2oFEqYPsejst2CT
 plZmDX1WNrLHXz7NMhRCzCa34JT9Gn2tT3O6TWoovbtHzflTsnw/JxpAuXCA/1s8OO8F
 cgsTYKZ0du81dhogF5kxaL+5XuCWWw2WSwnXeW9WSpvAM09mkxwSmaE2eOaASigpWs6u
 XcXmZcHTtvxnls0liUnB0ErbG4DbJh8tmMiXCcta8gLls+W7aLsPGJPOCSDhaeIKFR1T
 6k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=C1Czdr2m5DCpm3/C+F4+eTk0CwrmAVdgxwfK1fMPVT8=;
 b=M9fL7aL82LIrQolQPClKYJ6YxMvijFhkegYppZFRYuBowvcJN90FDzKjH0ojmDB3VU
 Mxv9voCND16z4O1OJTv4eq/tUJd3ZP+p+q1HpEoTF/QUISJjEhgMBQ1cD2fefjYhvbsQ
 /I7DKX74ICK+b86VA2R6enkwXD/iaY+zPLK4bD687hkoB5Kk1JM805z+xYJpIbj11A/2
 VSszkF/4C5mUHPUZPYXqh8J5AepG+f9TlU1bj+h+YXEDWecLcLV3M5m/zJ2aRGVenOPb
 7wqz0G7ruOCm4yNx2PaAx82ZsJJSzNbNcXDW/xwrqFOb7eSUrlQJDVvmVZzfyzWw6iS8
 /ECg==
X-Gm-Message-State: APjAAAWoeWGluiafVsQc0MTqFosaLT/OQp7iuHKuf1w8JVVtmiF80Hhs
 /uI5pntDoHb7T9TDcmkPVeJifASi
X-Google-Smtp-Source: APXvYqyqOCWyZz2MJT5h4DGJndpePP8zFx+Bne2/zTPqdyZzJwMZHuwS9FKZiJ72ZsKufAt1XirD8g==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr4961881wrk.407.1582716646942; 
 Wed, 26 Feb 2020 03:30:46 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/18] qemu-doc: remove indices other than findex
Date: Wed, 26 Feb 2020 12:30:28 +0100
Message-Id: <20200226113034.6741-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These indices are not well-maintained, and pandoc also chokes on the
directives.  Just nuke them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 4c74b3bf4d..c04daf54f2 100644
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
index c5b6a9b38e..b41b144885 100644
--- a/docs/system/monitor.texi
+++ b/docs/system/monitor.texi
@@ -1,6 +1,5 @@
 @node pcsys_monitor
 @section QEMU Monitor
-@cindex QEMU monitor
 
 The QEMU monitor is used to give complex commands to the QEMU
 emulator. You can use it to:
diff --git a/docs/system/mux-chardev.texi b/docs/system/mux-chardev.texi
index c9a2d14cb8..b21c2c5654 100644
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
index ed7295de7a..baceaa96eb 100644
--- a/docs/system/quickstart.texi
+++ b/docs/system/quickstart.texi
@@ -1,6 +1,5 @@
 @node pcsys_quickstart
 @section Quick Start
-@cindex quick start
 
 Download and uncompress a PC hard disk image with Linux installed (e.g.
 @file{linux.img}) and type:
diff --git a/docs/system/target-arm.texi b/docs/system/target-arm.texi
index 040d77b5e0..c56b5f6ebf 100644
--- a/docs/system/target-arm.texi
+++ b/docs/system/target-arm.texi
@@ -1,6 +1,5 @@
 @node ARM System emulator
 @section ARM System emulator
-@cindex system emulation (ARM)
 
 Use the executable @file{qemu-system-arm} to simulate a ARM
 machine. The ARM Integrator/CP board is emulated with the following
diff --git a/docs/system/target-i386.texi b/docs/system/target-i386.texi
index 49ab6dbafc..bed076d807 100644
--- a/docs/system/target-i386.texi
+++ b/docs/system/target-i386.texi
@@ -1,6 +1,5 @@
 @node x86 (PC) System emulator
 @section x86 (PC) System emulator
-@cindex system emulation (PC)
 
 @menu
 * pcsys_devices::      Peripherals
diff --git a/docs/system/target-m68k.texi b/docs/system/target-m68k.texi
index b5bc9df40a..a77b19ea0f 100644
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
index f722c00912..fe12ee94c7 100644
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
index c2c254d3d2..55f98f65b1 100644
--- a/docs/system/target-ppc.texi
+++ b/docs/system/target-ppc.texi
@@ -1,6 +1,5 @@
 @node PowerPC System emulator
 @section PowerPC System emulator
-@cindex system emulation (PowerPC)
 
 Use the executable @file{qemu-system-ppc} to simulate a complete 40P (PREP)
 or PowerMac PowerPC system.
diff --git a/docs/system/target-sparc.texi b/docs/system/target-sparc.texi
index 7fe0aec9c3..7748001f73 100644
--- a/docs/system/target-sparc.texi
+++ b/docs/system/target-sparc.texi
@@ -1,6 +1,5 @@
 @node Sparc32 System emulator
 @section Sparc32 System emulator
-@cindex system emulation (Sparc32)
 
 Use the executable @file{qemu-system-sparc} to simulate the following
 Sun4m architecture machines:
diff --git a/docs/system/target-sparc64.texi b/docs/system/target-sparc64.texi
index 9e7a27de0c..4db4ca3842 100644
--- a/docs/system/target-sparc64.texi
+++ b/docs/system/target-sparc64.texi
@@ -1,6 +1,5 @@
 @node Sparc64 System emulator
 @section Sparc64 System emulator
-@cindex system emulation (Sparc64)
 
 Use the executable @file{qemu-system-sparc64} to simulate a Sun4u
 (UltraSPARC PC-like machine), Sun4v (T1 PC-like machine), or generic
diff --git a/docs/system/target-xtensa.texi b/docs/system/target-xtensa.texi
index 08b0b36299..40327de6fa 100644
--- a/docs/system/target-xtensa.texi
+++ b/docs/system/target-xtensa.texi
@@ -1,6 +1,5 @@
 @node Xtensa System emulator
 @section Xtensa System emulator
-@cindex system emulation (Xtensa)
 
 Two executables cover simulation of both Xtensa endian options,
 @file{qemu-system-xtensa} and @file{qemu-system-xtensaeb}.
diff --git a/qemu-doc.texi b/qemu-doc.texi
index d3e743719a..c2b9c87c64 100644
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
-
-@node Concept Index
-@section Concept Index
-This is the main index. Should we combine all keywords in one index? TODO
-@printindex cp
 
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
2.21.1



