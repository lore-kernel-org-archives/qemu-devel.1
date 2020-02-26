Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23788C4BA11
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3ECE20637
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyqdghbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ECE20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uxB-0005jw-1L
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utl-0000dA-Ve
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uti-0005lP-3A
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:41 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6uth-0005fh-Oe
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:38 -0500
Received: by mail-wm1-x344.google.com with SMTP id t14so2630351wmi.5
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AOkpdZ4pzdVZsunxeV10BYnUvH4eoQTdbhjNTFMpglY=;
 b=gyqdghbxp5VB59qTy5Jga/qoNtjqDRDhBxe+UQCly3HMASPH2WthFDkLa63THVeBmR
 bstj/MokQP8YYDq2qFhHXeRHr/0DVgf2NYAtcYvfzheXTTD1g7zHil/1BY+SGVvSDhQS
 ZAW3tsQi4ISPE7mckovKmqx34DlxfCtE1Og2i924Ftyx5ZASMJ80C8gRUAXbGdlaQ2sZ
 /a7whqoN7bJBqfkCe40yEZRDvxdSmtQicGVw0kMYnIAE9PZj5ZIJtthyDZKWIiaPag95
 YKPksXdCoXgRjro2mpm6IJmLrr+54iCmqD8yJSMXLdewGBd8s+vxls8GTpaP8ltYdt8N
 T2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AOkpdZ4pzdVZsunxeV10BYnUvH4eoQTdbhjNTFMpglY=;
 b=aExYhMuwv+XCWh9MCVBedYRPgvwASViBTSxm+pObpRv0UKUKY6Ebue/alDOr2Vprwl
 0JW1uUeA4VVNOgkUB8d5somXpXlgMf2nLxSBX63swgwe1Nhz9/PQY6Z5Js6pp7nMFEwO
 90964vHT9mLhjMRnXP5VPCHhZrQMkoCDFAIdggXUTz0AT4XhP5wXutQRgXmcjjNv4fqB
 D62E7CXOk+YIkufzbL/kz5oZTvoVSha/Uv2f78ahb145ATjEWgxgU5fuijNFGUeSqXG0
 /0U8qR/6JeawgddzTb64Z4ka3QkPVE+0EuhRvBncnLgvBMBPaM8vpIA95tOhbzS86+xK
 vs2A==
X-Gm-Message-State: APjAAAXw1S0xtP7UiB3m777XpMNmzHEehjA2PhPGtrMTj5NZfbn3eNAd
 G/gUV1w9TodtR04GHn2FCMUWi4JX
X-Google-Smtp-Source: APXvYqzPASZ8dLy9ON/FonEnBEzjymo/OnQGHq2ujqzpvXh7Cwtsq7oj9U3wuBPeUuOoa3/otD2Dzw==
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr5047992wmj.27.1582716635200; 
 Wed, 26 Feb 2020 03:30:35 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/18] qemu-doc: convert user-mode emulation to a separate
 Sphinx manual
Date: Wed, 26 Feb 2020 12:30:17 +0100
Message-Id: <20200226113034.6741-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

The final addition to the set of QEMU manuals is the user-mode emulation
manual, which right now is included in qemu-doc.texi.  Extract it and
convert it to rST, so that qemu-doc.texi covers only full system emulation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile            |   8 +-
 docs/user/conf.py   |  18 +++
 docs/user/index.rst |  16 +++
 docs/user/main.rst  | 295 ++++++++++++++++++++++++++++++++++++++
 qemu-doc.texi       | 337 --------------------------------------------
 5 files changed, 336 insertions(+), 338 deletions(-)
 create mode 100644 docs/user/conf.py
 create mode 100644 docs/user/index.rst
 create mode 100644 docs/user/main.rst

diff --git a/Makefile b/Makefile
index 15f8e53d05..73d8ed2b6a 100644
--- a/Makefile
+++ b/Makefile
@@ -786,6 +786,7 @@ distclean: clean
 	$(call clean-manual,interop)
 	$(call clean-manual,specs)
 	$(call clean-manual,system)
+	$(call clean-manual,user)
 	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
@@ -843,6 +844,7 @@ install-sphinxdocs: sphinxdocs
 	$(call install-manual,interop)
 	$(call install-manual,specs)
 	$(call install-manual,system)
+	$(call install-manual,user)
 
 install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
@@ -1036,7 +1038,8 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
 sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
             $(MANUAL_BUILDDIR)/interop/index.html \
             $(MANUAL_BUILDDIR)/specs/index.html \
-            $(MANUAL_BUILDDIR)/system/index.html
+            $(MANUAL_BUILDDIR)/system/index.html \
+            $(MANUAL_BUILDDIR)/user/index.html
 
 # Canned command to build a single manual
 # Arguments: $1 = manual name, $2 = Sphinx builder ('html' or 'man')
@@ -1069,6 +1072,9 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 	$(call build-manual,system,html)
 
+$(MANUAL_BUILDDIR)/user/index.html: $(call manual-deps,user)
+	$(call build-manual,user,html)
+
 $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
        virtiofsd.1 virtfs-proxy-helper.1,\
diff --git a/docs/user/conf.py b/docs/user/conf.py
new file mode 100644
index 0000000000..b3e1b2318a
--- /dev/null
+++ b/docs/user/conf.py
@@ -0,0 +1,18 @@
+# -*- coding: utf-8 -*-
+#
+# QEMU documentation build configuration file for the 'system' manual.
+#
+# This includes the top level conf file and then makes any necessary tweaks.
+import sys
+import os
+
+qemu_docdir = os.path.abspath("..")
+parent_config = os.path.join(qemu_docdir, "conf.py")
+exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
+
+# This slightly misuses the 'description', but is the best way to get
+# the manual title to appear in the sidebar.
+html_theme_options['description'] = u'User Mode Emulation User''s Guide'
+# One entry per manual page. List of tuples
+# (source start file, name, description, authors, manual section).
+man_pages = []
diff --git a/docs/user/index.rst b/docs/user/index.rst
new file mode 100644
index 0000000000..c81d2898cd
--- /dev/null
+++ b/docs/user/index.rst
@@ -0,0 +1,16 @@
+.. This is the top level page for the 'system' manual.
+
+
+QEMU User Mode Emulation User's Guide
+=====================================
+
+This manual is the overall guide for users using QEMU
+for user-mode emulation.  In this mode, QEMU can launch
+processes compiled for one CPU on another CPU.
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
+
+   main
diff --git a/docs/user/main.rst b/docs/user/main.rst
new file mode 100644
index 0000000000..ca69f7727d
--- /dev/null
+++ b/docs/user/main.rst
@@ -0,0 +1,295 @@
+QEMU User space emulator
+========================
+
+Supported Operating Systems
+---------------------------
+
+The following OS are supported in user space emulation:
+
+-  Linux (referred as qemu-linux-user)
+
+-  BSD (referred as qemu-bsd-user)
+
+Features
+--------
+
+QEMU user space emulation has the following notable features:
+
+**System call translation:**
+   QEMU includes a generic system call translator. This means that the
+   parameters of the system calls can be converted to fix endianness and
+   32/64-bit mismatches between hosts and targets. IOCTLs can be
+   converted too.
+
+**POSIX signal handling:**
+   QEMU can redirect to the running program all signals coming from the
+   host (such as ``SIGALRM``), as well as synthesize signals from
+   virtual CPU exceptions (for example ``SIGFPE`` when the program
+   executes a division by zero).
+
+   QEMU relies on the host kernel to emulate most signal system calls,
+   for example to emulate the signal mask. On Linux, QEMU supports both
+   normal and real-time signals.
+
+**Threading:**
+   On Linux, QEMU can emulate the ``clone`` syscall and create a real
+   host thread (with a separate virtual CPU) for each emulated thread.
+   Note that not all targets currently emulate atomic operations
+   correctly. x86 and ARM use a global lock in order to preserve their
+   semantics.
+
+QEMU was conceived so that ultimately it can emulate itself. Although it
+is not very useful, it is an important test to show the power of the
+emulator.
+
+Linux User space emulator
+-------------------------
+
+Quick Start
+~~~~~~~~~~~
+
+In order to launch a Linux process, QEMU needs the process executable
+itself and all the target (x86) dynamic libraries used by it.
+
+-  On x86, you can just try to launch any process by using the native
+   libraries::
+
+      qemu-i386 -L / /bin/ls
+
+   ``-L /`` tells that the x86 dynamic linker must be searched with a
+   ``/`` prefix.
+
+-  Since QEMU is also a linux process, you can launch QEMU with QEMU
+   (NOTE: you can only do that if you compiled QEMU from the sources)::
+
+      qemu-i386 -L / qemu-i386 -L / /bin/ls
+
+-  On non x86 CPUs, you need first to download at least an x86 glibc
+   (``qemu-runtime-i386-XXX-.tar.gz`` on the QEMU web page). Ensure that
+   ``LD_LIBRARY_PATH`` is not set::
+
+      unset LD_LIBRARY_PATH
+
+   Then you can launch the precompiled ``ls`` x86 executable::
+
+      qemu-i386 tests/i386/ls
+
+   You can look at ``scripts/qemu-binfmt-conf.sh`` so that QEMU is
+   automatically launched by the Linux kernel when you try to launch x86
+   executables. It requires the ``binfmt_misc`` module in the Linux
+   kernel.
+
+-  The x86 version of QEMU is also included. You can try weird things
+   such as::
+
+      qemu-i386 /usr/local/qemu-i386/bin/qemu-i386 \
+                /usr/local/qemu-i386/bin/ls-i386
+
+Wine launch
+~~~~~~~~~~~
+
+-  Ensure that you have a working QEMU with the x86 glibc distribution
+   (see previous section). In order to verify it, you must be able to
+   do::
+
+      qemu-i386 /usr/local/qemu-i386/bin/ls-i386
+
+-  Download the binary x86 Wine install (``qemu-XXX-i386-wine.tar.gz``
+   on the QEMU web page).
+
+-  Configure Wine on your account. Look at the provided script
+   ``/usr/local/qemu-i386/bin/wine-conf.sh``. Your previous
+   ``${HOME}/.wine`` directory is saved to ``${HOME}/.wine.org``.
+
+-  Then you can try the example ``putty.exe``::
+
+      qemu-i386 /usr/local/qemu-i386/wine/bin/wine \
+                /usr/local/qemu-i386/wine/c/Program\ Files/putty.exe
+
+Command line options
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g port] [-B offset] [-R size] program [arguments...]
+
+``-h``
+   Print the help
+
+``-L path``
+   Set the x86 elf interpreter prefix (default=/usr/local/qemu-i386)
+
+``-s size``
+   Set the x86 stack size in bytes (default=524288)
+
+``-cpu model``
+   Select CPU model (-cpu help for list and additional feature
+   selection)
+
+``-E var=value``
+   Set environment var to value.
+
+``-U var``
+   Remove var from the environment.
+
+``-B offset``
+   Offset guest address by the specified number of bytes. This is useful
+   when the address region required by guest applications is reserved on
+   the host. This option is currently only supported on some hosts.
+
+``-R size``
+   Pre-allocate a guest virtual address space of the given size (in
+   bytes). \"G\", \"M\", and \"k\" suffixes may be used when specifying
+   the size.
+
+Debug options:
+
+``-d item1,...``
+   Activate logging of the specified items (use '-d help' for a list of
+   log items)
+
+``-p pagesize``
+   Act as if the host page size was 'pagesize' bytes
+
+``-g port``
+   Wait gdb connection to port
+
+``-singlestep``
+   Run the emulation in single step mode.
+
+Environment variables:
+
+QEMU_STRACE
+   Print system calls and arguments similar to the 'strace' program
+   (NOTE: the actual 'strace' program will not work because the user
+   space emulator hasn't implemented ptrace). At the moment this is
+   incomplete. All system calls that don't have a specific argument
+   format are printed with information for six arguments. Many
+   flag-style arguments don't have decoders and will show up as numbers.
+
+Other binaries
+~~~~~~~~~~~~~~
+
+user mode (Alpha)
+``qemu-alpha`` TODO.
+
+user mode (ARM)
+``qemu-armeb`` TODO.
+
+user mode (ARM)
+``qemu-arm`` is also capable of running ARM \"Angel\" semihosted ELF
+binaries (as implemented by the arm-elf and arm-eabi Newlib/GDB
+configurations), and arm-uclinux bFLT format binaries.
+
+user mode (ColdFire)
+user mode (M68K)
+``qemu-m68k`` is capable of running semihosted binaries using the BDM
+(m5xxx-ram-hosted.ld) or m68k-sim (sim.ld) syscall interfaces, and
+coldfire uClinux bFLT format binaries.
+
+The binary format is detected automatically.
+
+user mode (Cris)
+``qemu-cris`` TODO.
+
+user mode (i386)
+``qemu-i386`` TODO. ``qemu-x86_64`` TODO.
+
+user mode (Microblaze)
+``qemu-microblaze`` TODO.
+
+user mode (MIPS)
+``qemu-mips`` executes 32-bit big endian MIPS binaries (MIPS O32 ABI).
+
+``qemu-mipsel`` executes 32-bit little endian MIPS binaries (MIPS O32
+ABI).
+
+``qemu-mips64`` executes 64-bit big endian MIPS binaries (MIPS N64 ABI).
+
+``qemu-mips64el`` executes 64-bit little endian MIPS binaries (MIPS N64
+ABI).
+
+``qemu-mipsn32`` executes 32-bit big endian MIPS binaries (MIPS N32
+ABI).
+
+``qemu-mipsn32el`` executes 32-bit little endian MIPS binaries (MIPS N32
+ABI).
+
+user mode (NiosII)
+``qemu-nios2`` TODO.
+
+user mode (PowerPC)
+``qemu-ppc64abi32`` TODO. ``qemu-ppc64`` TODO. ``qemu-ppc`` TODO.
+
+user mode (SH4)
+``qemu-sh4eb`` TODO. ``qemu-sh4`` TODO.
+
+user mode (SPARC)
+``qemu-sparc`` can execute Sparc32 binaries (Sparc32 CPU, 32 bit ABI).
+
+``qemu-sparc32plus`` can execute Sparc32 and SPARC32PLUS binaries
+(Sparc64 CPU, 32 bit ABI).
+
+``qemu-sparc64`` can execute some Sparc64 (Sparc64 CPU, 64 bit ABI) and
+SPARC32PLUS binaries (Sparc64 CPU, 32 bit ABI).
+
+BSD User space emulator
+-----------------------
+
+BSD Status
+~~~~~~~~~~
+
+-  target Sparc64 on Sparc64: Some trivial programs work.
+
+Quick Start
+~~~~~~~~~~~
+
+In order to launch a BSD process, QEMU needs the process executable
+itself and all the target dynamic libraries used by it.
+
+-  On Sparc64, you can just try to launch any process by using the
+   native libraries::
+
+      qemu-sparc64 /bin/ls
+
+Command line options
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   qemu-sparc64 [-h] [-d] [-L path] [-s size] [-bsd type] program [arguments...]
+
+``-h``
+   Print the help
+
+``-L path``
+   Set the library root path (default=/)
+
+``-s size``
+   Set the stack size in bytes (default=524288)
+
+``-ignore-environment``
+   Start with an empty environment. Without this option, the initial
+   environment is a copy of the caller's environment.
+
+``-E var=value``
+   Set environment var to value.
+
+``-U var``
+   Remove var from the environment.
+
+``-bsd type``
+   Set the type of the emulated BSD Operating system. Valid values are
+   FreeBSD, NetBSD and OpenBSD (default).
+
+Debug options:
+
+``-d item1,...``
+   Activate logging of the specified items (use '-d help' for a list of
+   log items)
+
+``-p pagesize``
+   Act as if the host page size was 'pagesize' bytes
+
+``-singlestep``
+   Run the emulation in single step mode.
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 33b9597b1d..6636816b85 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -38,7 +38,6 @@
 * Introduction::
 * QEMU PC System emulator::
 * QEMU System emulator for non PC targets::
-* QEMU User space emulator::
 * System requirements::
 * Security::
 * Implementation notes::
@@ -2487,342 +2486,6 @@ so should only be used with trusted guest OS.
 
 @c man end
 
-@node QEMU User space emulator
-@chapter QEMU User space emulator
-
-@menu
-* Supported Operating Systems ::
-* Features::
-* Linux User space emulator::
-* BSD User space emulator ::
-@end menu
-
-@node Supported Operating Systems
-@section Supported Operating Systems
-
-The following OS are supported in user space emulation:
-
-@itemize @minus
-@item
-Linux (referred as qemu-linux-user)
-@item
-BSD (referred as qemu-bsd-user)
-@end itemize
-
-@node Features
-@section Features
-
-QEMU user space emulation has the following notable features:
-
-@table @strong
-@item System call translation:
-QEMU includes a generic system call translator.  This means that
-the parameters of the system calls can be converted to fix
-endianness and 32/64-bit mismatches between hosts and targets.
-IOCTLs can be converted too.
-
-@item POSIX signal handling:
-QEMU can redirect to the running program all signals coming from
-the host (such as @code{SIGALRM}), as well as synthesize signals from
-virtual CPU exceptions (for example @code{SIGFPE} when the program
-executes a division by zero).
-
-QEMU relies on the host kernel to emulate most signal system
-calls, for example to emulate the signal mask.  On Linux, QEMU
-supports both normal and real-time signals.
-
-@item Threading:
-On Linux, QEMU can emulate the @code{clone} syscall and create a real
-host thread (with a separate virtual CPU) for each emulated thread.
-Note that not all targets currently emulate atomic operations correctly.
-x86 and ARM use a global lock in order to preserve their semantics.
-@end table
-
-QEMU was conceived so that ultimately it can emulate itself. Although
-it is not very useful, it is an important test to show the power of the
-emulator.
-
-@node Linux User space emulator
-@section Linux User space emulator
-
-@menu
-* Quick Start::
-* Wine launch::
-* Command line options::
-* Other binaries::
-@end menu
-
-@node Quick Start
-@subsection Quick Start
-
-In order to launch a Linux process, QEMU needs the process executable
-itself and all the target (x86) dynamic libraries used by it.
-
-@itemize
-
-@item On x86, you can just try to launch any process by using the native
-libraries:
-
-@example
-qemu-i386 -L / /bin/ls
-@end example
-
-@code{-L /} tells that the x86 dynamic linker must be searched with a
-@file{/} prefix.
-
-@item Since QEMU is also a linux process, you can launch QEMU with
-QEMU (NOTE: you can only do that if you compiled QEMU from the sources):
-
-@example
-qemu-i386 -L / qemu-i386 -L / /bin/ls
-@end example
-
-@item On non x86 CPUs, you need first to download at least an x86 glibc
-(@file{qemu-runtime-i386-XXX-.tar.gz} on the QEMU web page). Ensure that
-@code{LD_LIBRARY_PATH} is not set:
-
-@example
-unset LD_LIBRARY_PATH
-@end example
-
-Then you can launch the precompiled @file{ls} x86 executable:
-
-@example
-qemu-i386 tests/i386/ls
-@end example
-You can look at @file{scripts/qemu-binfmt-conf.sh} so that
-QEMU is automatically launched by the Linux kernel when you try to
-launch x86 executables. It requires the @code{binfmt_misc} module in the
-Linux kernel.
-
-@item The x86 version of QEMU is also included. You can try weird things such as:
-@example
-qemu-i386 /usr/local/qemu-i386/bin/qemu-i386 \
-          /usr/local/qemu-i386/bin/ls-i386
-@end example
-
-@end itemize
-
-@node Wine launch
-@subsection Wine launch
-
-@itemize
-
-@item Ensure that you have a working QEMU with the x86 glibc
-distribution (see previous section). In order to verify it, you must be
-able to do:
-
-@example
-qemu-i386 /usr/local/qemu-i386/bin/ls-i386
-@end example
-
-@item Download the binary x86 Wine install
-(@file{qemu-XXX-i386-wine.tar.gz} on the QEMU web page).
-
-@item Configure Wine on your account. Look at the provided script
-@file{/usr/local/qemu-i386/@/bin/wine-conf.sh}. Your previous
-@code{$@{HOME@}/.wine} directory is saved to @code{$@{HOME@}/.wine.org}.
-
-@item Then you can try the example @file{putty.exe}:
-
-@example
-qemu-i386 /usr/local/qemu-i386/wine/bin/wine \
-          /usr/local/qemu-i386/wine/c/Program\ Files/putty.exe
-@end example
-
-@end itemize
-
-@node Command line options
-@subsection Command line options
-
-@example
-@command{qemu-i386} [@option{-h]} [@option{-d]} [@option{-L} @var{path}] [@option{-s} @var{size}] [@option{-cpu} @var{model}] [@option{-g} @var{port}] [@option{-B} @var{offset}] [@option{-R} @var{size}] @var{program} [@var{arguments}...]
-@end example
-
-@table @option
-@item -h
-Print the help
-@item -L path
-Set the x86 elf interpreter prefix (default=/usr/local/qemu-i386)
-@item -s size
-Set the x86 stack size in bytes (default=524288)
-@item -cpu model
-Select CPU model (-cpu help for list and additional feature selection)
-@item -E @var{var}=@var{value}
-Set environment @var{var} to @var{value}.
-@item -U @var{var}
-Remove @var{var} from the environment.
-@item -B offset
-Offset guest address by the specified number of bytes.  This is useful when
-the address region required by guest applications is reserved on the host.
-This option is currently only supported on some hosts.
-@item -R size
-Pre-allocate a guest virtual address space of the given size (in bytes).
-"G", "M", and "k" suffixes may be used when specifying the size.
-@end table
-
-Debug options:
-
-@table @option
-@item -d item1,...
-Activate logging of the specified items (use '-d help' for a list of log items)
-@item -p pagesize
-Act as if the host page size was 'pagesize' bytes
-@item -g port
-Wait gdb connection to port
-@item -singlestep
-Run the emulation in single step mode.
-@end table
-
-Environment variables:
-
-@table @env
-@item QEMU_STRACE
-Print system calls and arguments similar to the 'strace' program
-(NOTE: the actual 'strace' program will not work because the user
-space emulator hasn't implemented ptrace).  At the moment this is
-incomplete.  All system calls that don't have a specific argument
-format are printed with information for six arguments.  Many
-flag-style arguments don't have decoders and will show up as numbers.
-@end table
-
-@node Other binaries
-@subsection Other binaries
-
-@cindex user mode (Alpha)
-@command{qemu-alpha} TODO.
-
-@cindex user mode (ARM)
-@command{qemu-armeb} TODO.
-
-@cindex user mode (ARM)
-@command{qemu-arm} is also capable of running ARM "Angel" semihosted ELF
-binaries (as implemented by the arm-elf and arm-eabi Newlib/GDB
-configurations), and arm-uclinux bFLT format binaries.
-
-@cindex user mode (ColdFire)
-@cindex user mode (M68K)
-@command{qemu-m68k} is capable of running semihosted binaries using the BDM
-(m5xxx-ram-hosted.ld) or m68k-sim (sim.ld) syscall interfaces, and
-coldfire uClinux bFLT format binaries.
-
-The binary format is detected automatically.
-
-@cindex user mode (Cris)
-@command{qemu-cris} TODO.
-
-@cindex user mode (i386)
-@command{qemu-i386} TODO.
-@command{qemu-x86_64} TODO.
-
-@cindex user mode (Microblaze)
-@command{qemu-microblaze} TODO.
-
-@cindex user mode (MIPS)
-@command{qemu-mips} executes 32-bit big endian MIPS binaries (MIPS O32 ABI).
-
-@command{qemu-mipsel} executes 32-bit little endian MIPS binaries (MIPS O32 ABI).
-
-@command{qemu-mips64} executes 64-bit big endian MIPS binaries (MIPS N64 ABI).
-
-@command{qemu-mips64el} executes 64-bit little endian MIPS binaries (MIPS N64 ABI).
-
-@command{qemu-mipsn32} executes 32-bit big endian MIPS binaries (MIPS N32 ABI).
-
-@command{qemu-mipsn32el} executes 32-bit little endian MIPS binaries (MIPS N32 ABI).
-
-@cindex user mode (NiosII)
-@command{qemu-nios2} TODO.
-
-@cindex user mode (PowerPC)
-@command{qemu-ppc64abi32} TODO.
-@command{qemu-ppc64} TODO.
-@command{qemu-ppc} TODO.
-
-@cindex user mode (SH4)
-@command{qemu-sh4eb} TODO.
-@command{qemu-sh4} TODO.
-
-@cindex user mode (SPARC)
-@command{qemu-sparc} can execute Sparc32 binaries (Sparc32 CPU, 32 bit ABI).
-
-@command{qemu-sparc32plus} can execute Sparc32 and SPARC32PLUS binaries
-(Sparc64 CPU, 32 bit ABI).
-
-@command{qemu-sparc64} can execute some Sparc64 (Sparc64 CPU, 64 bit ABI) and
-SPARC32PLUS binaries (Sparc64 CPU, 32 bit ABI).
-
-@node BSD User space emulator
-@section BSD User space emulator
-
-@menu
-* BSD Status::
-* BSD Quick Start::
-* BSD Command line options::
-@end menu
-
-@node BSD Status
-@subsection BSD Status
-
-@itemize @minus
-@item
-target Sparc64 on Sparc64: Some trivial programs work.
-@end itemize
-
-@node BSD Quick Start
-@subsection Quick Start
-
-In order to launch a BSD process, QEMU needs the process executable
-itself and all the target dynamic libraries used by it.
-
-@itemize
-
-@item On Sparc64, you can just try to launch any process by using the native
-libraries:
-
-@example
-qemu-sparc64 /bin/ls
-@end example
-
-@end itemize
-
-@node BSD Command line options
-@subsection Command line options
-
-@example
-@command{qemu-sparc64} [@option{-h]} [@option{-d]} [@option{-L} @var{path}] [@option{-s} @var{size}] [@option{-bsd} @var{type}] @var{program} [@var{arguments}...]
-@end example
-
-@table @option
-@item -h
-Print the help
-@item -L path
-Set the library root path (default=/)
-@item -s size
-Set the stack size in bytes (default=524288)
-@item -ignore-environment
-Start with an empty environment. Without this option,
-the initial environment is a copy of the caller's environment.
-@item -E @var{var}=@var{value}
-Set environment @var{var} to @var{value}.
-@item -U @var{var}
-Remove @var{var} from the environment.
-@item -bsd type
-Set the type of the emulated BSD Operating system. Valid values are
-FreeBSD, NetBSD and OpenBSD (default).
-@end table
-
-Debug options:
-
-@table @option
-@item -d item1,...
-Activate logging of the specified items (use '-d help' for a list of log items)
-@item -p pagesize
-Act as if the host page size was 'pagesize' bytes
-@item -singlestep
-Run the emulation in single step mode.
-@end table
-
 @node System requirements
 @chapter System requirements
 
-- 
2.21.1



