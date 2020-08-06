Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0933C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4D42177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OStbgmkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4D42177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mLl-0002FX-H3
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lRb-0003sZ-J0
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lRX-00073h-LX
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=AwFIE+gHMatUcdbtwBjO4GnqopSs3bbCsr7ua/sQtsg=;
 b=OStbgmkLsMSQ9pLQixl0431SlhuTJ9ybFU/HDbV1Gza5xS/4/aS5lObPP8OrLWLttCkxXz
 BH/S1KSjn4idEIxlEpMvC92hELZvxzQ93VmFS6f+OOni0nG3ItsIdQeEvRXLxlcw0pdpI7
 GgagupIHDqvq3JitbLjPldoCUjNWkqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-RBBr35yeNwOq40R610HVIQ-1; Thu, 06 Aug 2020 15:20:41 -0400
X-MC-Unique: RBBr35yeNwOq40R610HVIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04FBF19200C0
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:41 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 557035F9DC
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 143/143] meson: update build-system documentation
Date: Thu,  6 Aug 2020 21:16:19 +0200
Message-Id: <1596741379-12902-144-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.txt | 373 ++++++++++++++++++++++----------------------
 1 file changed, 185 insertions(+), 188 deletions(-)

diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index fea67b2..fb62cb2 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -22,6 +22,30 @@ silent while it is checking for features. It will only display output
 when an error occurs, or to show the final feature enablement summary
 on completion.
 
+Because QEMU uses the Meson build system under the hood, only VPATH
+builds are supported.  There are two general ways to invoke configure &
+perform a build:
+
+ - VPATH, build artifacts outside of QEMU source tree entirely
+
+     cd ../
+     mkdir build
+     cd build
+     ../qemu/configure
+     make
+
+ - VPATH, build artifacts in a subdir of QEMU source tree
+
+     mkdir build
+     cd build
+     ../configure
+     make
+
+For now, checks on the compilation environment are found in configure
+rather than meson.build, though this is expected to change.  The command
+line is parsed in the configure script and, whenever needed, converted
+into the appropriate options to Meson.
+
 Adding new checks to the configure script usually comprises the
 following tasks:
 
@@ -164,145 +188,161 @@ developers in checking for system features:
    then --static will be automatically added to $ARGS
 
 
-Stage 2: makefiles
-==================
-
-The use of GNU make is required with the QEMU build system.
-
-Although the source code is spread across multiple subdirectories, the
-build system should be considered largely non-recursive in nature, in
-contrast to common practices seen with automake. There is some recursive
-invocation of make, but this is related to the things being built,
-rather than the source directory structure.
-
-QEMU currently supports both VPATH and non-VPATH builds, so there are
-three general ways to invoke configure & perform a build.
+Stage 2: Meson
+==============
 
- - VPATH, build artifacts outside of QEMU source tree entirely
+The Meson build system is currently used to describe the build
+process for:
 
-     cd ../
-     mkdir build
-     cd build
-     ../qemu/configure
-     make
-
- - VPATH, build artifacts in a subdir of QEMU source tree
+1) executables, which include:
+   - Tools - qemu-img, qemu-nbd, qga (guest agent), etc
+   - System emulators - qemu-system-$ARCH
+   - Userspace emulators - qemu-$ARCH
+   - Some (but not all) unit tests
 
-     mkdir build
-     cd build
-     ../configure
-     make
+2) documentation
 
- - non-VPATH, build artifacts everywhere
+3) ROMs, which can be either installed as binary blobs or compiled
 
-     ./configure
-     make
+4) other data files, such as icons or desktop files
 
-The QEMU maintainers generally recommend that a VPATH build is used by
-developers. Patches to QEMU are expected to ensure VPATH build still
-works.
+The source code is highly modularized, split across many files to
+facilitate building of all of these components with as little duplicated
+compilation as possible. The Meson "sourceset" functionality is used
+to list the files and their dependency on various configuration  
+symbols.
 
+Various subsystems that are common to both tools and emulators have
+their own sourceset, for example block_ss for the block device subsystem,
+chardev_ss for the character device subsystem, etc.  These sourcesets
+are then turned into static libraries as follows:
 
-Module structure
-----------------
+    libchardev = static_library('chardev', chardev_ss.sources(),
+                                name_suffix: 'fa',
+                                build_by_default: false)
 
-There are a number of key outputs of the QEMU build system:
+    chardev = declare_dependency(link_whole: libchardev)
 
- - Tools - qemu-img, qemu-nbd, qga (guest agent), etc
- - System emulators - qemu-system-$ARCH
- - Userspace emulators - qemu-$ARCH
- - Unit tests
+The special ".fa" suffix is needed as long as unit tests are built with
+the older Makefile infrastructure, and will go away later.
 
-The source code is highly modularized, split across many files to
-facilitate building of all of these components with as little duplicated
-compilation as possible. There can be considered to be two distinct
-groups of files, those which are independent of the QEMU emulation
-target and those which are dependent on the QEMU emulation target.
+Files linked into emulator targets there can be split into two distinct groups
+of files, those which are independent of the QEMU emulation target and
+those which are dependent on the QEMU emulation target.
 
 In the target-independent set lives various general purpose helper code,
 such as error handling infrastructure, standard data structures,
 platform portability wrapper functions, etc. This code can be compiled
 once only and the .o files linked into all output binaries.
+Target-independent code lives in the common_ss, softmmu_ss and user_ss
+sourcesets.  common_ss is linked into all emulators, softmmu_ss only
+in system emulators, user_ss only in user-mode emulators.
 
 In the target-dependent set lives CPU emulation, device emulation and
 much glue code. This sometimes also has to be compiled multiple times,
 once for each target being built.
 
-The utility code that is used by all binaries is built into a
-static archive called libqemuutil.a, which is then linked to all the
-binaries. In order to provide hooks that are only needed by some of the
-binaries, code in libqemuutil.a may depend on other functions that are
-not fully implemented by all QEMU binaries.  Dummy stubs for all these
-functions are also provided by this library, and will only be linked
+All binaries link with a static library libqemuutil.a, which is then
+linked to all the binaries.  libqemuutil.a is built from several
+sourcesets; most of them however host generated code, and the only two
+of general interest are util_ss and stub_ss.
+
+The separation between these two is purely for documentation purposes.
+util_ss contains generic utility files.  Even though this code is only
+linked in some binaries, sometimes it requires hooks only in some of
+these and depend on other functions that are not fully implemented by
+all QEMU binaries.  stub_ss links dummy stubs that will only be linked
 into the binary if the real implementation is not present.  In a way,
 the stubs can be thought of as a portable implementation of the weak
 symbols concept.
 
-All binaries should link to libqemuutil.a, e.g.:
+The following files concur in the definition of which files are linked
+into each emulator:
 
- qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a
+- default-configs/*.mak
+
+The files under default-configs/ control what emulated hardware is built
+into each QEMU system and userspace emulator targets. They merely contain
+a list of config variable definitions like the machines that should be
+included. For example, default-configs/aarch64-softmmu.mak has:
 
+  include arm-softmmu.mak
+  CONFIG_XLNX_ZYNQMP_ARM=y
+  CONFIG_XLNX_VERSAL=y
 
-Windows platform portability
-----------------------------
+These files rarely need changing unless new devices / hardware need to
+be enabled for a particular system/userspace emulation target
 
-On Windows, all binaries have the suffix '.exe', so all Makefile rules
-which create binaries must include the $(EXESUF) variable on the binary
-name. e.g.
+- */Kconfig
 
- qemu-img$(EXESUF): qemu-img.o ..snip..
+These files are processed together with default-configs/*.mak and
+describe the dependencies between various features, subsystems and
+device models.  They are described in kconfig.rst.
 
-This expands to '.exe' on Windows, or '' on other platforms.
 
-A further complication for the system emulator binaries is that
-two separate binaries need to be generated.
+Stage 3: makefiles
+==================
 
-The main binary (e.g. qemu-system-x86_64.exe) is linked against the
-Windows console runtime subsystem. These are expected to be run from a
-command prompt window, and so will print stderr to the console that
-launched them.
+The use of GNU make is required with the QEMU build system.
 
-The second binary generated has a 'w' on the end of its name (e.g.
-qemu-system-x86_64w.exe) and is linked against the Windows graphical
-runtime subsystem. These are expected to be run directly from the
-desktop and will open up a dedicated console window for stderr output.
+The output of Meson is a build.ninja file, which is used with the Ninja
+build system.  QEMU uses a different approach, where Makefile rules are
+synthesized from the build.ninja file.  The main Makefile includes these
+rules and wraps them so that e.g. submodules are built before QEMU.
+The resulting build system is largely non-recursive in nature, in
+contrast to common practices seen with automake.
 
-The Makefile.target will generate the binary for the graphical subsystem
-first, and then use objcopy to relink it against the console subsystem
-to generate the second binary.
+Tests are also ran by the Makefile with the traditional "make check"
+phony target.  Meson test suites such as "unit" can be ran with "make
+check-unit" too.  It is also possible to run tests defined in meson.build
+with "meson test".
 
+The following text is only relevant for unit tests which still have to
+be converted to Meson.
 
-Object variable naming
-----------------------
+All binaries should link to libqemuutil.a, e.g.:
+
+   qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a
+
+On Windows, all binaries have the suffix '.exe', so all Makefile rules
+which create binaries must include the $(EXESUF) variable on the binary
+name. e.g.
+
+   qemu-img$(EXESUF): qemu-img.o ..snip..
+
+This expands to '.exe' on Windows, or '' on other platforms.
+
+Variable naming
+---------------
 
 The QEMU convention is to define variables to list different groups of
-object files. These are named with the convention $PREFIX-obj-y. For
-example the libqemuutil.a file will be linked with all objects listed
-in a variable 'util-obj-y'. So, for example, util/Makefile.obj will
-contain a set of definitions looking like
+object files. These are named with the convention $PREFIX-obj-y.  The
+Meson "chardev" variable in the previous example corresponds to a
+variable 'chardev-obj-y'.
+
+Likewise, tests that are executed by "make check-unit" are grouped into
+a variable check-unit-y, like this:
 
-  util-obj-y += bitmap.o bitops.o hbitmap.o
-  util-obj-y += fifo8.o
-  util-obj-y += acl.o
-  util-obj-y += error.o qemu-error.o
+  check-unit-y += tests/test-visitor-serialization$(EXESUF)
+  check-unit-y += tests/test-iov$(EXESUF)
+  check-unit-y += tests/test-bitmap$(EXESUF)
 
-When there is an object file which needs to be conditionally built based
+When a test or object file which needs to be conditionally built based
 on some characteristic of the host system, the configure script will
 define a variable for the conditional. For example, on Windows it will
 define $(CONFIG_POSIX) with a value of 'n' and $(CONFIG_WIN32) with a
 value of 'y'. It is now possible to use the config variables when
 listing object files. For example,
 
-  util-obj-$(CONFIG_WIN32) += oslib-win32.o qemu-thread-win32.o
-  util-obj-$(CONFIG_POSIX) += oslib-posix.o qemu-thread-posix.o
+  check-unit-$(CONFIG_POSIX) += tests/test-vmstate$(EXESUF)
 
 On Windows this expands to
 
-  util-obj-y += oslib-win32.o qemu-thread-win32.o
-  util-obj-n += oslib-posix.o qemu-thread-posix.o
+  check-unit-n += tests/vmstate.exe
 
-Since libqemutil.a links in $(util-obj-y), the POSIX specific files
-listed against $(util-obj-n) are ignored on the Windows platform builds.
+Since the "check-unit" target only runs tests included in "$(check-unit-y)",
+POSIX specific tests listed in $(util-obj-n) are ignored on the Windows
+platform builds.
 
 
 CFLAGS / LDFLAGS / LIBS handling
@@ -316,27 +356,25 @@ avoided in QEMU, since it would apply to too many build targets.
 Flags that are needed by any QEMU code (i.e. everything *except* GIT
 submodule projects) are put in $(QEMU_CFLAGS) variable. For linker
 flags the $(LIBS) variable is sometimes used, but a couple of more
-targeted variables are preferred. $(libs_softmmu) is used for
-libraries that must be linked to system emulator targets, $(LIBS_TOOLS)
-is used for tools like qemu-img, qemu-nbd, etc and $(LIBS_QGA) is used
-for the QEMU guest agent. There is currently no specific variable for
-the userspace emulator targets as the global $(LIBS), or more targeted
-variables shown below, are sufficient.
+targeted variables are preferred.
 
 In addition to these variables, it is possible to provide cflags and
 libs against individual source code files, by defining variables of the
-form $FILENAME-cflags and $FILENAME-libs. For example, the curl block
-driver needs to link to the libcurl library, so block/Makefile defines
-some variables:
+form $FILENAME-cflags and $FILENAME-libs. For example, the test
+test-crypto-tlscredsx509 needs to link to the libtasn1 library,
+so tests/Makefile.include defines some variables:
 
-  curl.o-cflags      := $(CURL_CFLAGS)
-  curl.o-libs        := $(CURL_LIBS)
+  tests/crypto-tls-x509-helpers.o-cflags := $(TASN1_CFLAGS)
+  tests/crypto-tls-x509-helpers.o-libs := $(TASN1_LIBS)
 
 The scope is a little different between the two variables. The libs get
 used when linking any target binary that includes the curl.o object
 file, while the cflags get used when compiling the curl.c file only.
 
 
+Important files for the build system
+====================================
+
 Statically defined files
 ------------------------
 
@@ -348,81 +386,26 @@ number of dynamically created files listed later.
 
 The main entry point used when invoking make to build all the components
 of QEMU. The default 'all' target will naturally result in the build of
-every component. The various tools and helper binaries are built
+every component. Makefile takes care of recursively building submodules
 directly via a non-recursive set of rules.
 
-Each system/userspace emulation target needs to have a slightly
-different set of make rules / variables. Thus, make will be recursively
-invoked for each of the emulation targets.
-
-The recursive invocation will end up processing the toplevel
-Makefile.target file (more on that later).
-
-
-- */Makefile.objs
-
-Since the source code is spread across multiple directories, the rules
-for each file are similarly modularized. Thus each subdirectory
-containing .c files will usually also contain a Makefile.objs file.
-These files are not directly invoked by a recursive make, but instead
-they are imported by the top level Makefile and/or Makefile.target
+- Makefile.objs
 
-Each Makefile.objs usually just declares a set of variables listing the
-.o files that need building from the source files in the directory. They
-will also define any custom linker or compiler flags. For example in
-block/Makefile.objs
+Defines *-obj-y files corresponding to 
 
-  block-obj-$(CONFIG_LIBISCSI) += iscsi.o
-  block-obj-$(CONFIG_CURL) += curl.o
-
-  ..snip...
-
-  iscsi.o-cflags     := $(LIBISCSI_CFLAGS)
-  iscsi.o-libs       := $(LIBISCSI_LIBS)
-  curl.o-cflags      := $(CURL_CFLAGS)
-  curl.o-libs        := $(CURL_LIBS)
-
-If there are any rules defined in the Makefile.objs file, they should
-all use $(obj) as a prefix to the target, e.g.
-
-  $(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
-
-
-- Makefile.target
-
-This file provides the entry point used to build each individual system
-or userspace emulator target. Each enabled target has its own
-subdirectory. For example if configure is run with the argument
-'--target-list=x86_64-softmmu', then a sub-directory 'x86_64-softmmu'
-will be created, containing a 'Makefile' which symlinks back to
-Makefile.target
-
-So when the recursive '$(MAKE) -C x86_64-softmmu' is invoked, it ends up
-using Makefile.target for the build rules.
+- */meson.build
 
+The meson.build file in the root directory is the main entry point for the
+Meson build system, and it coordinates the configuration and build of all
+executables.  Build rules for various subdirectories are included in
+other meson.build files spread throughout the QEMU source tree.
 
 - rules.mak
 
 This file provides the generic helper rules for invoking build tools, in
 particular the compiler and linker.
 
-
-- default-configs/*.mak
-
-The files under default-configs/ control what emulated hardware is built
-into each QEMU system and userspace emulator targets. They merely contain
-a list of config variable definitions like the machines that should be
-included. For example, default-configs/aarch64-softmmu.mak has:
-
-  include arm-softmmu.mak
-  CONFIG_XLNX_ZYNQMP_ARM=y
-  CONFIG_XLNX_VERSAL=y
-
-These files rarely need changing unless new devices / hardware need to
-be enabled for a particular system/userspace emulation target
-
-
-- tests/Makefile
+- tests/Makefile.include
 
 Rules for building the unit tests. This file is included directly by the
 top level Makefile, so anything defined in this file will influence the
@@ -435,11 +418,11 @@ Rules for Docker tests. Like tests/Makefile, this file is included
 directly by the top level Makefile, anything defined in this file will
 influence the entire build system.
 
-- po/Makefile
-
-Rules for building and installing the binary message catalogs from the
-text .po file sources. This almost never needs changing for any reason.
+- tests/vm/Makefile.include
 
+Rules for VM-based tests. Like tests/Makefile, this file is included
+directly by the top level Makefile, anything defined in this file will
+influence the entire build system.
 
 Dynamically created files
 -------------------------
@@ -450,6 +433,7 @@ the need for QEMU makefiles to go through any pre-processing as seen
 with autotools, where Makefile.am generates Makefile.in which generates
 Makefile.
 
+Built by configure:
 
 - config-host.mak
 
@@ -457,27 +441,17 @@ When configure has determined the characteristics of the build host it
 will write a long list of variables to config-host.mak file. This
 provides the various install directories, compiler / linker flags and a
 variety of CONFIG_* variables related to optionally enabled features.
-This is imported by the top level Makefile in order to tailor the build
-output.
+This is imported by the top level Makefile and meson.build in order to
+tailor the build output.
+
+config-host.mak is also used as a dependency checking mechanism. If make
+sees that the modification timestamp on configure is newer than that on
+config-host.mak, then configure will be re-run.
 
 The variables defined here are those which are applicable to all QEMU
 build outputs. Variables which are potentially different for each
 emulator target are defined by the next file...
 
-It is also used as a dependency checking mechanism. If make sees that
-the modification timestamp on configure is newer than that on
-config-host.mak, then configure will be re-run.
-
-
-- config-host.h
-
-The config-host.h file is used by source code to determine what features
-are enabled. It is generated from the contents of config-host.mak using
-the scripts/create_config program. This extracts all the CONFIG_* variables,
-most of the HOST_* variables and a few other misc variables from
-config-host.mak, formatting them as C preprocessor macros.
-
-
 - $TARGET-NAME/config-target.mak
 
 TARGET-NAME is the name of a system or userspace emulator, for example,
@@ -488,19 +462,42 @@ the target and any other potential custom libraries needed for linking
 the target.
 
 
-- $TARGET-NAME/config-devices.mak
+Built by Meson:
+
+- ${TARGET-NAME}-config-devices.mak
 
 TARGET-NAME is again the name of a system or userspace emulator. The
 config-devices.mak file is automatically generated by make using the
 scripts/make_device_config.sh program, feeding it the
 default-configs/$TARGET-NAME file as input.
 
+- config-host.h
+- $TARGET-NAME/config-target.h
+- $TARGET-NAME/config-devices.h
+
+These files are used by source code to determine what features
+are enabled.  They are generated from the contents of the corresponding
+*.h files using the scripts/create_config program. This extracts
+relevant variables and formats them as C preprocessor macros.
+
+- build.ninja
+
+
+Built by Makefile:
+
+- Makefile.ninja:
+
+A Makefile conversion of the build rules in build.ninja.  The conversion
+is straightforward and, were it necessary to debug the rules produced
+by Meson, it should be enough to look at build.ninja.  The conversion
+is performed by scripts/ninjatool.py.
 
-- $TARGET-NAME/Makefile
+- Makefile.mtest:
 
-This is the entrypoint used when make recurses to build a single system
-or userspace emulator target. It is merely a symlink back to the
-Makefile.target in the top level.
+The Makefile definitions that let "make check" run tests defined in
+meson.build.  The rules are produced from Meson's JSON description of
+tests (obtained with "meson introspect --tests") through the script
+scripts/mtest2make.py.
 
 
 Useful make targets
-- 
1.8.3.1


