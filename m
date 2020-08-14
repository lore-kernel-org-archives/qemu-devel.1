Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19508C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17FE206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VE+a7WLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17FE206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6X8v-00069v-3E
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VoC-0000MO-Jq
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vo2-0003Gu-IP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tZIRfs6tAqf83MlwkM87wDXpTQiCMWVriP0/p+NLWs=;
 b=VE+a7WLIXqggpjJTfsWr8Ureg4+bklr0iHmQ4vpztY8dJdfucsyPQK6tAqrbDlFIZwUaFj
 QTdFbnfIrv1B0ts/C1EQW/b/myjaQnIJqzWju2fQ2jXSp+u0YcFdnLiEq01IVQTxm8p+DQ
 6e+Jq7esST+z/Mk4YmUr/G3zMSIqWz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-KFsMF_IgMz--1IcH3XcL_g-1; Fri, 14 Aug 2020 05:15:17 -0400
X-MC-Unique: KFsMF_IgMz--1IcH3XcL_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF17F59
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE40560C04
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 150/150] docs: convert build system documentation to rST
Date: Fri, 14 Aug 2020 05:13:26 -0400
Message-Id: <20200814091326.16173-151-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 01:57:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 .../{build-system.txt => build-system.rst}    | 310 ++++++++----------
 docs/devel/index.rst                          |   1 +
 2 files changed, 142 insertions(+), 169 deletions(-)
 rename docs/devel/{build-system.txt => build-system.rst} (62%)

diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.rst
similarity index 62%
rename from docs/devel/build-system.txt
rename to docs/devel/build-system.rst
index 2ced8ca474..58bf392430 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.rst
@@ -1,5 +1,6 @@
-    The QEMU build system architecture
-    ==================================
+==================================
+The QEMU build system architecture
+==================================
 
 This document aims to help developers understand the architecture of the
 QEMU build system. As with projects using GNU autotools, the QEMU build
@@ -26,7 +27,7 @@ Because QEMU uses the Meson build system under the hood, only VPATH
 builds are supported.  There are two general ways to invoke configure &
 perform a build:
 
- - VPATH, build artifacts outside of QEMU source tree entirely
+ - VPATH, build artifacts outside of QEMU source tree entirely::
 
      cd ../
      mkdir build
@@ -34,7 +35,7 @@ perform a build:
      ../qemu/configure
      make
 
- - VPATH, build artifacts in a subdir of QEMU source tree
+ - VPATH, build artifacts in a subdir of QEMU source tree::
 
      mkdir build
      cd build
@@ -52,21 +53,21 @@ following tasks:
  - Add a Meson build option to meson_options.txt.
 
  - Add support to the command line arg parser to handle any new
-   --enable-XXX / --disable-XXX flags required by the feature XXX.
+   `--enable-XXX`/`--disable-XXX` flags required by the feature.
 
  - Add information to the help output message to report on the new
    feature flag.
 
  - Add code to perform the actual feature check.
 
- - Add code to include the feature status in config-host.h
+ - Add code to include the feature status in `config-host.h`
 
  - Add code to print out the feature status in the configure summary
    upon completion.
 
 
 Taking the probe for SDL as an example, we have the following pieces
-in configure:
+in configure::
 
   # Initial variable state
   sdl=auto
@@ -89,11 +90,11 @@ in configure:
   # Meson invocation
   -Dsdl=$sdl
 
-In meson_options.txt:
+In meson_options.txt::
 
   option('sdl', type : 'feature', value : 'auto')
 
-In meson.build:
+In meson.build::
 
   # Detect dependency
   sdl = dependency('sdl2',
@@ -114,63 +115,51 @@ Helper functions
 The configure script provides a variety of helper functions to assist
 developers in checking for system features:
 
- - do_cc $ARGS...
-
+`do_cc $ARGS...`
    Attempt to run the system C compiler passing it $ARGS...
 
- - do_cxx $ARGS...
-
+`do_cxx $ARGS...`
    Attempt to run the system C++ compiler passing it $ARGS...
 
- - compile_object $CFLAGS
-
+`compile_object $CFLAGS`
    Attempt to compile a test program with the system C compiler using
    $CFLAGS. The test program must have been previously written to a file
    called $TMPC.
 
- - compile_prog $CFLAGS $LDFLAGS
-
+`compile_prog $CFLAGS $LDFLAGS`
    Attempt to compile a test program with the system C compiler using
    $CFLAGS and link it with the system linker using $LDFLAGS. The test
    program must have been previously written to a file called $TMPC.
 
- - has $COMMAND
-
+`has $COMMAND`
    Determine if $COMMAND exists in the current environment, either as a
    shell builtin, or executable binary, returning 0 on success.
 
- - path_of $COMMAND
-
+`path_of $COMMAND`
    Return the fully qualified path of $COMMAND, printing it to stdout,
    and returning 0 on success.
 
- - check_define $NAME
-
+`check_define $NAME`
    Determine if the macro $NAME is defined by the system C compiler
 
- - check_include $NAME
-
+`check_include $NAME`
    Determine if the include $NAME file is available to the system C
    compiler
 
- - write_c_skeleton
-
+`write_c_skeleton`
    Write a minimal C program main() function to the temporary file
    indicated by $TMPC
 
- - feature_not_found $NAME $REMEDY
-
+`feature_not_found $NAME $REMEDY`
    Print a message to stderr that the feature $NAME was not available
    on the system, suggesting the user try $REMEDY to address the
    problem.
 
- - error_exit $MESSAGE $MORE...
-
+`error_exit $MESSAGE $MORE...`
    Print $MESSAGE to stderr, followed by $MORE... and then exit from the
    configure script with non-zero status
 
- - query_pkg_config $ARGS...
-
+`query_pkg_config $ARGS...`
    Run pkg-config passing it $ARGS. If QEMU is doing a static build,
    then --static will be automatically added to $ARGS
 
@@ -182,9 +171,13 @@ The Meson build system is currently used to describe the build
 process for:
 
 1) executables, which include:
+
    - Tools - qemu-img, qemu-nbd, qga (guest agent), etc
+
    - System emulators - qemu-system-$ARCH
+
    - Userspace emulators - qemu-$ARCH
+
    - Some (but not all) unit tests
 
 2) documentation
@@ -200,9 +193,9 @@ to list the files and their dependency on various configuration
 symbols.
 
 Various subsystems that are common to both tools and emulators have
-their own sourceset, for example block_ss for the block device subsystem,
-chardev_ss for the character device subsystem, etc.  These sourcesets
-are then turned into static libraries as follows:
+their own sourceset, for example `block_ss` for the block device subsystem,
+`chardev_ss` for the character device subsystem, etc.  These sourcesets
+are then turned into static libraries as follows::
 
     libchardev = static_library('chardev', chardev_ss.sources(),
                                 name_suffix: 'fa',
@@ -210,7 +203,7 @@ are then turned into static libraries as follows:
 
     chardev = declare_dependency(link_whole: libchardev)
 
-The special ".fa" suffix is needed as long as unit tests are built with
+The special `.fa` suffix is needed as long as unit tests are built with
 the older Makefile infrastructure, and will go away later.
 
 Files linked into emulator targets there can be split into two distinct groups
@@ -221,24 +214,24 @@ In the target-independent set lives various general purpose helper code,
 such as error handling infrastructure, standard data structures,
 platform portability wrapper functions, etc. This code can be compiled
 once only and the .o files linked into all output binaries.
-Target-independent code lives in the common_ss, softmmu_ss and user_ss
-sourcesets.  common_ss is linked into all emulators, softmmu_ss only
-in system emulators, user_ss only in user-mode emulators.
+Target-independent code lives in the `common_ss`, `softmmu_ss` and
+`user_ss` sourcesets.  `common_ss` is linked into all emulators, `softmmu_ss`
+only in system emulators, `user_ss` only in user-mode emulators.
 
 In the target-dependent set lives CPU emulation, device emulation and
 much glue code. This sometimes also has to be compiled multiple times,
 once for each target being built.
 
-All binaries link with a static library libqemuutil.a, which is then
-linked to all the binaries.  libqemuutil.a is built from several
+All binaries link with a static library `libqemuutil.a`, which is then
+linked to all the binaries.  `libqemuutil.a` is built from several
 sourcesets; most of them however host generated code, and the only two
-of general interest are util_ss and stub_ss.
+of general interest are `util_ss` and `stub_ss`.
 
 The separation between these two is purely for documentation purposes.
-util_ss contains generic utility files.  Even though this code is only
+`util_ss` contains generic utility files.  Even though this code is only
 linked in some binaries, sometimes it requires hooks only in some of
 these and depend on other functions that are not fully implemented by
-all QEMU binaries.  stub_ss links dummy stubs that will only be linked
+all QEMU binaries.  `stub_ss` links dummy stubs that will only be linked
 into the binary if the real implementation is not present.  In a way,
 the stubs can be thought of as a portable implementation of the weak
 symbols concept.
@@ -246,45 +239,43 @@ symbols concept.
 The following files concur in the definition of which files are linked
 into each emulator:
 
-- default-configs/*.mak
+`default-configs/*.mak`
+  The files under default-configs/ control what emulated hardware is built
+  into each QEMU system and userspace emulator targets. They merely contain
+  a list of config variable definitions like the machines that should be
+  included. For example, default-configs/aarch64-softmmu.mak has::
 
-The files under default-configs/ control what emulated hardware is built
-into each QEMU system and userspace emulator targets. They merely contain
-a list of config variable definitions like the machines that should be
-included. For example, default-configs/aarch64-softmmu.mak has:
+    include arm-softmmu.mak
+    CONFIG_XLNX_ZYNQMP_ARM=y
+    CONFIG_XLNX_VERSAL=y
 
-  include arm-softmmu.mak
-  CONFIG_XLNX_ZYNQMP_ARM=y
-  CONFIG_XLNX_VERSAL=y
+`*/Kconfig`
+  These files are processed together with `default-configs/*.mak` and
+  describe the dependencies between various features, subsystems and
+  device models.  They are described in kconfig.rst.
 
 These files rarely need changing unless new devices / hardware need to
 be enabled for a particular system/userspace emulation target
 
-- */Kconfig
-
-These files are processed together with default-configs/*.mak and
-describe the dependencies between various features, subsystems and
-device models.  They are described in kconfig.rst.
-
 
 Support scripts
 ---------------
 
 Meson has a special convention for invoking Python scripts: if their
-first line is "#! /usr/bin/env python3" and the file is *not* executable,
+first line is `#! /usr/bin/env python3` and the file is *not* executable,
 find_program() arranges to invoke the script under the same Python
 interpreter that was used to invoke Meson.  This is the most common
 and preferred way to invoke support scripts from Meson build files,
 because it automatically uses the value of configure's --python= option.
 
-In case the script is not written in Python, use a "#! /usr/bin/env ..."
+In case the script is not written in Python, use a `#! /usr/bin/env ...`
 line and make the script executable.
 
 Scripts written in Python, where it is desirable to make the script
 executable (for example for test scripts that developers may want to
 invoke from the command line, such as tests/qapi-schema/test-qapi.py),
-should be invoked through the "python" variable in meson.build. For
-example:
+should be invoked through the `python` variable in meson.build. For
+example::
 
   test('QAPI schema regression tests', python,
        args: files('test-qapi.py'),
@@ -307,35 +298,35 @@ rules and wraps them so that e.g. submodules are built before QEMU.
 The resulting build system is largely non-recursive in nature, in
 contrast to common practices seen with automake.
 
-Tests are also ran by the Makefile with the traditional "make check"
-phony target.  Meson test suites such as "unit" can be ran with "make
-check-unit" too.  It is also possible to run tests defined in meson.build
-with "meson test".
+Tests are also ran by the Makefile with the traditional `make check`
+phony target.  Meson test suites such as `unit` can be ran with `make
+check-unit` too.  It is also possible to run tests defined in meson.build
+with `meson test`.
 
 The following text is only relevant for unit tests which still have to
 be converted to Meson.
 
-All binaries should link to libqemuutil.a, e.g.:
+All binaries should link to `libqemuutil.a`, e.g.:
 
    qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a
 
-On Windows, all binaries have the suffix '.exe', so all Makefile rules
+On Windows, all binaries have the suffix `.exe`, so all Makefile rules
 which create binaries must include the $(EXESUF) variable on the binary
 name. e.g.
 
    qemu-img$(EXESUF): qemu-img.o ..snip..
 
-This expands to '.exe' on Windows, or '' on other platforms.
+This expands to `.exe` on Windows, or an empty string on other platforms.
 
 Variable naming
 ---------------
 
 The QEMU convention is to define variables to list different groups of
 object files. These are named with the convention $PREFIX-obj-y.  The
-Meson "chardev" variable in the previous example corresponds to a
+Meson `chardev` variable in the previous example corresponds to a
 variable 'chardev-obj-y'.
 
-Likewise, tests that are executed by "make check-unit" are grouped into
+Likewise, tests that are executed by `make check-unit` are grouped into
 a variable check-unit-y, like this:
 
   check-unit-y += tests/test-visitor-serialization$(EXESUF)
@@ -355,8 +346,8 @@ On Windows this expands to
 
   check-unit-n += tests/vmstate.exe
 
-Since the "check-unit" target only runs tests included in "$(check-unit-y)",
-POSIX specific tests listed in $(util-obj-n) are ignored on the Windows
+Since the `check-unit` target only runs tests included in `$(check-unit-y)`,
+POSIX specific tests listed in `$(util-obj-n)` are ignored on the Windows
 platform builds.
 
 
@@ -397,47 +388,37 @@ The following key files are statically defined in the source tree, with
 the rules needed to build QEMU. Their behaviour is influenced by a
 number of dynamically created files listed later.
 
-- Makefile
-
-The main entry point used when invoking make to build all the components
-of QEMU. The default 'all' target will naturally result in the build of
-every component. Makefile takes care of recursively building submodules
-directly via a non-recursive set of rules.
-
-- Makefile.objs
-
-Defines *-obj-y files corresponding to 
-
-- */meson.build
-
-The meson.build file in the root directory is the main entry point for the
-Meson build system, and it coordinates the configuration and build of all
-executables.  Build rules for various subdirectories are included in
-other meson.build files spread throughout the QEMU source tree.
-
-- rules.mak
-
-This file provides the generic helper rules for invoking build tools, in
-particular the compiler and linker.
-
-- tests/Makefile.include
-
-Rules for building the unit tests. This file is included directly by the
-top level Makefile, so anything defined in this file will influence the
-entire build system. Care needs to be taken when writing rules for tests
-to ensure they only apply to the unit test execution / build.
-
-- tests/docker/Makefile.include
-
-Rules for Docker tests. Like tests/Makefile, this file is included
-directly by the top level Makefile, anything defined in this file will
-influence the entire build system.
-
-- tests/vm/Makefile.include
-
-Rules for VM-based tests. Like tests/Makefile, this file is included
-directly by the top level Makefile, anything defined in this file will
-influence the entire build system.
+`Makefile`
+  The main entry point used when invoking make to build all the components
+  of QEMU. The default 'all' target will naturally result in the build of
+  every component. Makefile takes care of recursively building submodules
+  directly via a non-recursive set of rules.
+
+`*/meson.build`
+  The meson.build file in the root directory is the main entry point for the
+  Meson build system, and it coordinates the configuration and build of all
+  executables.  Build rules for various subdirectories are included in
+  other meson.build files spread throughout the QEMU source tree.
+
+`rules.mak`
+  This file provides the generic helper rules for invoking build tools, in
+  particular the compiler and linker.
+
+`tests/Makefile.include`
+  Rules for building the unit tests. This file is included directly by the
+  top level Makefile, so anything defined in this file will influence the
+  entire build system. Care needs to be taken when writing rules for tests
+  to ensure they only apply to the unit test execution / build.
+
+`tests/docker/Makefile.include`
+  Rules for Docker tests. Like tests/Makefile, this file is included
+  directly by the top level Makefile, anything defined in this file will
+  influence the entire build system.
+
+`tests/vm/Makefile.include`
+  Rules for VM-based tests. Like tests/Makefile, this file is included
+  directly by the top level Makefile, anything defined in this file will
+  influence the entire build system.
 
 Dynamically created files
 -------------------------
@@ -450,79 +431,70 @@ Makefile.
 
 Built by configure:
 
-- config-host.mak
-
-When configure has determined the characteristics of the build host it
-will write a long list of variables to config-host.mak file. This
-provides the various install directories, compiler / linker flags and a
-variety of CONFIG_* variables related to optionally enabled features.
-This is imported by the top level Makefile and meson.build in order to
-tailor the build output.
-
-config-host.mak is also used as a dependency checking mechanism. If make
-sees that the modification timestamp on configure is newer than that on
-config-host.mak, then configure will be re-run.
+`config-host.mak`
+  When configure has determined the characteristics of the build host it
+  will write a long list of variables to config-host.mak file. This
+  provides the various install directories, compiler / linker flags and a
+  variety of `CONFIG_*` variables related to optionally enabled features.
+  This is imported by the top level Makefile and meson.build in order to
+  tailor the build output.
 
-The variables defined here are those which are applicable to all QEMU
-build outputs. Variables which are potentially different for each
-emulator target are defined by the next file...
+  config-host.mak is also used as a dependency checking mechanism. If make
+  sees that the modification timestamp on configure is newer than that on
+  config-host.mak, then configure will be re-run.
 
-- $TARGET-NAME/config-target.mak
+  The variables defined here are those which are applicable to all QEMU
+  build outputs. Variables which are potentially different for each
+  emulator target are defined by the next file...
 
-TARGET-NAME is the name of a system or userspace emulator, for example,
-x86_64-softmmu denotes the system emulator for the x86_64 architecture.
-This file contains the variables which need to vary on a per-target
-basis. For example, it will indicate whether KVM or Xen are enabled for
-the target and any other potential custom libraries needed for linking
-the target.
+`$TARGET-NAME/config-target.mak`
+  TARGET-NAME is the name of a system or userspace emulator, for example,
+  x86_64-softmmu denotes the system emulator for the x86_64 architecture.
+  This file contains the variables which need to vary on a per-target
+  basis. For example, it will indicate whether KVM or Xen are enabled for
+  the target and any other potential custom libraries needed for linking
+  the target.
 
 
 Built by Meson:
 
-- ${TARGET-NAME}-config-devices.mak
-
-TARGET-NAME is again the name of a system or userspace emulator. The
-config-devices.mak file is automatically generated by make using the
-scripts/make_device_config.sh program, feeding it the
-default-configs/$TARGET-NAME file as input.
-
-- config-host.h
-- $TARGET-NAME/config-target.h
-- $TARGET-NAME/config-devices.h
+`${TARGET-NAME}-config-devices.mak`
+  TARGET-NAME is again the name of a system or userspace emulator. The
+  config-devices.mak file is automatically generated by make using the
+  scripts/make_device_config.sh program, feeding it the
+  default-configs/$TARGET-NAME file as input.
 
-These files are used by source code to determine what features
-are enabled.  They are generated from the contents of the corresponding
-*.h files using the scripts/create_config program. This extracts
-relevant variables and formats them as C preprocessor macros.
+`config-host.h`, `$TARGET-NAME/config-target.h`, `$TARGET-NAME/config-devices.h`
+  These files are used by source code to determine what features
+  are enabled.  They are generated from the contents of the corresponding
+  `*.h` files using the scripts/create_config program. This extracts
+  relevant variables and formats them as C preprocessor macros.
 
-- build.ninja
+`build.ninja`
+  The build rules.
 
 
 Built by Makefile:
 
-- Makefile.ninja:
+`Makefile.ninja`
+  A Makefile conversion of the build rules in build.ninja.  The conversion
+  is straightforward and, were it necessary to debug the rules produced
+  by Meson, it should be enough to look at build.ninja.  The conversion
+  is performed by scripts/ninjatool.py.
 
-A Makefile conversion of the build rules in build.ninja.  The conversion
-is straightforward and, were it necessary to debug the rules produced
-by Meson, it should be enough to look at build.ninja.  The conversion
-is performed by scripts/ninjatool.py.
-
-- Makefile.mtest:
-
-The Makefile definitions that let "make check" run tests defined in
-meson.build.  The rules are produced from Meson's JSON description of
-tests (obtained with "meson introspect --tests") through the script
-scripts/mtest2make.py.
+`Makefile.mtest`
+  The Makefile definitions that let "make check" run tests defined in
+  meson.build.  The rules are produced from Meson's JSON description of
+  tests (obtained with "meson introspect --tests") through the script
+  scripts/mtest2make.py.
 
 
 Useful make targets
-===================
-
-- help
+-------------------
 
+`help`
   Print a help message for the most common build targets.
 
-- print-VAR
-
+`print-VAR`
   Print the value of the variable VAR. Useful for debugging the build
   system.
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index ae6eac7c9c..04773ce076 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -13,6 +13,7 @@ Contents:
 .. toctree::
    :maxdepth: 2
 
+   build-system
    kconfig
    loads-stores
    memory
-- 
2.26.2


