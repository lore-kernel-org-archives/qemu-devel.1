Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FDFC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B5D238D6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/HrFf90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B5D238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLbm4-0001eW-7h
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbw-0000m2-5r
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbp-00008Y-KN
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNCEViIdoSebfjQl8s5yIziaxq9c3EXzZxhiW3EngQs=;
 b=a/HrFf90EqZ8CPZKXEvfI88wZg/s1CHfGcLAA8Dc4ugBqB6t3PEmX01IrATOMNPjdIBXJm
 iOsl/qxuVS8VWpO7HbSfupLbscOsXxsIlbdw21QeqYxQTiDRG5G8HKj0aiDwEUNkPFFWMq
 CK48reNBNrCGeQmndou321DMsBXCQc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-td7EA4NFNparSDPPotjQcw-1; Thu, 24 Sep 2020 20:29:03 -0400
X-MC-Unique: td7EA4NFNparSDPPotjQcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 680DB188C125
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:02 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A1765D9F1;
 Fri, 25 Sep 2020 00:29:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/47] [DO-NOT-MERGE] docs: replace single backtick (`)
 with double-backtick (``)
Date: Thu, 24 Sep 2020 20:28:14 -0400
Message-Id: <20200925002900.465855-2-jsnow@redhat.com>
In-Reply-To: <20200925002900.465855-1-jsnow@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The single backtick in ReST is the "default role". Currently, Sphinx's
default role is called "content". Sphinx suggests you can use the "Any"
role instead to turn any single-backtick enclosed item into a
cross-reference.

Before we do that, though, we'll need to turn all existing usages of the
"content" role to inline verbatim markup by using double backticks
instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/build-system.rst            | 118 ++++++++++++-------------
 docs/devel/migration.rst               |  59 +++++++------
 docs/devel/tcg-plugins.rst             |  14 +--
 docs/devel/testing.rst                 |   2 +-
 docs/interop/live-block-operations.rst |   4 +-
 docs/system/arm/cpu-features.rst       | 110 +++++++++++------------
 docs/system/arm/nuvoton.rst            |   2 +-
 docs/system/s390x/protvirt.rst         |  10 +--
 8 files changed, 161 insertions(+), 158 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 08e85c69e1..a4711cd4e1 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -53,14 +53,14 @@ following tasks:
  - Add a Meson build option to meson_options.txt.
 
  - Add support to the command line arg parser to handle any new
-   `--enable-XXX`/`--disable-XXX` flags required by the feature.
+   ``--enable-XXX``/``--disable-XXX`` flags required by the feature.
 
  - Add information to the help output message to report on the new
    feature flag.
 
  - Add code to perform the actual feature check.
 
- - Add code to include the feature status in `config-host.h`
+ - Add code to include the feature status in ``config-host.h``
 
  - Add code to print out the feature status in the configure summary
    upon completion.
@@ -116,51 +116,51 @@ Helper functions
 The configure script provides a variety of helper functions to assist
 developers in checking for system features:
 
-`do_cc $ARGS...`
+``do_cc $ARGS...``
    Attempt to run the system C compiler passing it $ARGS...
 
-`do_cxx $ARGS...`
+``do_cxx $ARGS...``
    Attempt to run the system C++ compiler passing it $ARGS...
 
-`compile_object $CFLAGS`
+``compile_object $CFLAGS``
    Attempt to compile a test program with the system C compiler using
    $CFLAGS. The test program must have been previously written to a file
-   called $TMPC.  The replacement in Meson is the compiler object `cc`,
-   which has methods such as `cc.compiles()`,
-   `cc.check_header()`, `cc.has_function()`.
+   called $TMPC.  The replacement in Meson is the compiler object ``cc``,
+   which has methods such as ``cc.compiles()``,
+   ``cc.check_header()``, ``cc.has_function()``.
 
-`compile_prog $CFLAGS $LDFLAGS`
+``compile_prog $CFLAGS $LDFLAGS``
    Attempt to compile a test program with the system C compiler using
    $CFLAGS and link it with the system linker using $LDFLAGS. The test
    program must have been previously written to a file called $TMPC.
-   The replacement in Meson is `cc.find_library()` and `cc.links()`.
+   The replacement in Meson is ``cc.find_library()`` and ``cc.links()``.
 
-`has $COMMAND`
+``has $COMMAND``
    Determine if $COMMAND exists in the current environment, either as a
    shell builtin, or executable binary, returning 0 on success.  The
-   replacement in Meson is `find_program()`.
+   replacement in Meson is ``find_program()``.
 
-`check_define $NAME`
+``check_define $NAME``
    Determine if the macro $NAME is defined by the system C compiler
 
-`check_include $NAME`
+``check_include $NAME``
    Determine if the include $NAME file is available to the system C
-   compiler.  The replacement in Meson is `cc.has_header()`.
+   compiler.  The replacement in Meson is ``cc.has_header()``.
 
-`write_c_skeleton`
+``write_c_skeleton``
    Write a minimal C program main() function to the temporary file
    indicated by $TMPC
 
-`feature_not_found $NAME $REMEDY`
+``feature_not_found $NAME $REMEDY``
    Print a message to stderr that the feature $NAME was not available
    on the system, suggesting the user try $REMEDY to address the
    problem.
 
-`error_exit $MESSAGE $MORE...`
+``error_exit $MESSAGE $MORE...``
    Print $MESSAGE to stderr, followed by $MORE... and then exit from the
    configure script with non-zero status
 
-`query_pkg_config $ARGS...`
+``query_pkg_config $ARGS...``
    Run pkg-config passing it $ARGS. If QEMU is doing a static build,
    then --static will be automatically added to $ARGS
 
@@ -194,8 +194,8 @@ to list the files and their dependency on various configuration
 symbols.
 
 Various subsystems that are common to both tools and emulators have
-their own sourceset, for example `block_ss` for the block device subsystem,
-`chardev_ss` for the character device subsystem, etc.  These sourcesets
+their own sourceset, for example ``block_ss`` for the block device subsystem,
+``chardev_ss`` for the character device subsystem, etc.  These sourcesets
 are then turned into static libraries as follows::
 
     libchardev = static_library('chardev', chardev_ss.sources(),
@@ -204,8 +204,8 @@ are then turned into static libraries as follows::
 
     chardev = declare_dependency(link_whole: libchardev)
 
-As of Meson 0.55.1, the special `.fa` suffix should be used for everything
-that is used with `link_whole`, to ensure that the link flags are placed
+As of Meson 0.55.1, the special ``.fa`` suffix should be used for everything
+that is used with ``link_whole``, to ensure that the link flags are placed
 correctly in the command line.
 
 Files linked into emulator targets there can be split into two distinct groups
@@ -216,25 +216,25 @@ In the target-independent set lives various general purpose helper code,
 such as error handling infrastructure, standard data structures,
 platform portability wrapper functions, etc. This code can be compiled
 once only and the .o files linked into all output binaries.
-Target-independent code lives in the `common_ss`, `softmmu_ss` and
-`user_ss` sourcesets.  `common_ss` is linked into all emulators, `softmmu_ss`
-only in system emulators, `user_ss` only in user-mode emulators.
+Target-independent code lives in the ``common_ss``, ``softmmu_ss`` and
+``user_ss`` sourcesets.  ``common_ss`` is linked into all emulators, ``softmmu_ss``
+only in system emulators, ``user_ss`` only in user-mode emulators.
 
 In the target-dependent set lives CPU emulation, device emulation and
 much glue code. This sometimes also has to be compiled multiple times,
 once for each target being built.  Target-dependent files are included
-in the `specific_ss` sourceset.
+in the ``specific_ss`` sourceset.
 
-All binaries link with a static library `libqemuutil.a`, which is then
-linked to all the binaries.  `libqemuutil.a` is built from several
+All binaries link with a static library ``libqemuutil.a``, which is then
+linked to all the binaries.  ``libqemuutil.a`` is built from several
 sourcesets; most of them however host generated code, and the only two
-of general interest are `util_ss` and `stub_ss`.
+of general interest are ``util_ss`` and ``stub_ss``.
 
 The separation between these two is purely for documentation purposes.
-`util_ss` contains generic utility files.  Even though this code is only
+``util_ss`` contains generic utility files.  Even though this code is only
 linked in some binaries, sometimes it requires hooks only in some of
 these and depend on other functions that are not fully implemented by
-all QEMU binaries.  `stub_ss` links dummy stubs that will only be linked
+all QEMU binaries.  ``stub_ss`` links dummy stubs that will only be linked
 into the binary if the real implementation is not present.  In a way,
 the stubs can be thought of as a portable implementation of the weak
 symbols concept.
@@ -242,7 +242,7 @@ symbols concept.
 The following files concur in the definition of which files are linked
 into each emulator:
 
-`default-configs/*.mak`
+``default-configs/*.mak``
   The files under default-configs/ control what emulated hardware is built
   into each QEMU system and userspace emulator targets. They merely contain
   a list of config variable definitions like the machines that should be
@@ -252,8 +252,8 @@ into each emulator:
     CONFIG_XLNX_ZYNQMP_ARM=y
     CONFIG_XLNX_VERSAL=y
 
-`*/Kconfig`
-  These files are processed together with `default-configs/*.mak` and
+``*/Kconfig``
+  These files are processed together with ``default-configs/*.mak`` and
   describe the dependencies between various features, subsystems and
   device models.  They are described in kconfig.rst.
 
@@ -265,19 +265,19 @@ Support scripts
 ---------------
 
 Meson has a special convention for invoking Python scripts: if their
-first line is `#! /usr/bin/env python3` and the file is *not* executable,
+first line is ``#! /usr/bin/env python3`` and the file is *not* executable,
 find_program() arranges to invoke the script under the same Python
 interpreter that was used to invoke Meson.  This is the most common
 and preferred way to invoke support scripts from Meson build files,
 because it automatically uses the value of configure's --python= option.
 
-In case the script is not written in Python, use a `#! /usr/bin/env ...`
+In case the script is not written in Python, use a ``#! /usr/bin/env ...``
 line and make the script executable.
 
 Scripts written in Python, where it is desirable to make the script
 executable (for example for test scripts that developers may want to
 invoke from the command line, such as tests/qapi-schema/test-qapi.py),
-should be invoked through the `python` variable in meson.build. For
+should be invoked through the ``python`` variable in meson.build. For
 example::
 
   test('QAPI schema regression tests', python,
@@ -301,10 +301,10 @@ rules and wraps them so that e.g. submodules are built before QEMU.
 The resulting build system is largely non-recursive in nature, in
 contrast to common practices seen with automake.
 
-Tests are also ran by the Makefile with the traditional `make check`
-phony target, while benchmarks are run with `make bench`.  Meson test
-suites such as `unit` can be ran with `make check-unit` too.  It is also
-possible to run tests defined in meson.build with `meson test`.
+Tests are also ran by the Makefile with the traditional ``make check``
+phony target, while benchmarks are run with ``make bench``.  Meson test
+suites such as ``unit`` can be ran with ``make check-unit`` too.  It is also
+possible to run tests defined in meson.build with ``meson test``.
 
 Important files for the build system
 ====================================
@@ -316,28 +316,28 @@ The following key files are statically defined in the source tree, with
 the rules needed to build QEMU. Their behaviour is influenced by a
 number of dynamically created files listed later.
 
-`Makefile`
+``Makefile``
   The main entry point used when invoking make to build all the components
   of QEMU. The default 'all' target will naturally result in the build of
   every component. Makefile takes care of recursively building submodules
   directly via a non-recursive set of rules.
 
-`*/meson.build`
+``*/meson.build``
   The meson.build file in the root directory is the main entry point for the
   Meson build system, and it coordinates the configuration and build of all
   executables.  Build rules for various subdirectories are included in
   other meson.build files spread throughout the QEMU source tree.
 
-`tests/Makefile.include`
+``tests/Makefile.include``
   Rules for external test harnesses. These include the TCG tests,
-  `qemu-iotests` and the Avocado-based acceptance tests.
+  ``qemu-iotests`` and the Avocado-based acceptance tests.
 
-`tests/docker/Makefile.include`
+``tests/docker/Makefile.include``
   Rules for Docker tests. Like tests/Makefile, this file is included
   directly by the top level Makefile, anything defined in this file will
   influence the entire build system.
 
-`tests/vm/Makefile.include`
+``tests/vm/Makefile.include``
   Rules for VM-based tests. Like tests/Makefile, this file is included
   directly by the top level Makefile, anything defined in this file will
   influence the entire build system.
@@ -353,11 +353,11 @@ Makefile.
 
 Built by configure:
 
-`config-host.mak`
+``config-host.mak``
   When configure has determined the characteristics of the build host it
   will write a long list of variables to config-host.mak file. This
   provides the various install directories, compiler / linker flags and a
-  variety of `CONFIG_*` variables related to optionally enabled features.
+  variety of ``CONFIG_*`` variables related to optionally enabled features.
   This is imported by the top level Makefile and meson.build in order to
   tailor the build output.
 
@@ -369,7 +369,7 @@ Built by configure:
   build outputs. Variables which are potentially different for each
   emulator target are defined by the next file...
 
-`$TARGET-NAME/config-target.mak`
+``$TARGET-NAME/config-target.mak``
   TARGET-NAME is the name of a system or userspace emulator, for example,
   x86_64-softmmu denotes the system emulator for the x86_64 architecture.
   This file contains the variables which need to vary on a per-target
@@ -380,31 +380,31 @@ Built by configure:
 
 Built by Meson:
 
-`${TARGET-NAME}-config-devices.mak`
+``${TARGET-NAME}-config-devices.mak``
   TARGET-NAME is again the name of a system or userspace emulator. The
   config-devices.mak file is automatically generated by make using the
   scripts/make_device_config.sh program, feeding it the
   default-configs/$TARGET-NAME file as input.
 
-`config-host.h`, `$TARGET-NAME/config-target.h`, `$TARGET-NAME/config-devices.h`
+``config-host.h``, ``$TARGET-NAME/config-target.h``, ``$TARGET-NAME/config-devices.h``
   These files are used by source code to determine what features
   are enabled.  They are generated from the contents of the corresponding
-  `*.h` files using the scripts/create_config program. This extracts
+  ``*.h`` files using the scripts/create_config program. This extracts
   relevant variables and formats them as C preprocessor macros.
 
-`build.ninja`
+``build.ninja``
   The build rules.
 
 
 Built by Makefile:
 
-`Makefile.ninja`
+``Makefile.ninja``
   A Makefile conversion of the build rules in build.ninja.  The conversion
   is straightforward and, were it necessary to debug the rules produced
   by Meson, it should be enough to look at build.ninja.  The conversion
   is performed by scripts/ninjatool.py.
 
-`Makefile.mtest`
+``Makefile.mtest``
   The Makefile definitions that let "make check" run tests defined in
   meson.build.  The rules are produced from Meson's JSON description of
   tests (obtained with "meson introspect --tests") through the script
@@ -414,9 +414,9 @@ Built by Makefile:
 Useful make targets
 -------------------
 
-`help`
+``help``
   Print a help message for the most common build targets.
 
-`print-VAR`
+``print-VAR``
   Print the value of the variable VAR. Useful for debugging the build
   system.
diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 49112bb27a..f50e125035 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -53,7 +53,7 @@ savevm/loadvm functionality.
 Debugging
 =========
 
-The migration stream can be analyzed thanks to `scripts/analyze_migration.py`.
+The migration stream can be analyzed thanks to ``scripts/analyze_migration.py``.
 
 Example usage:
 
@@ -74,8 +74,8 @@ Common infrastructure
 =====================
 
 The files, sockets or fd's that carry the migration stream are abstracted by
-the  ``QEMUFile`` type (see `migration/qemu-file.h`).  In most cases this
-is connected to a subtype of ``QIOChannel`` (see `io/`).
+the  ``QEMUFile`` type (see ``migration/qemu-file.h``).  In most cases this
+is connected to a subtype of ``QIOChannel`` (see ``io/``).
 
 
 Saving the state of one device
@@ -165,14 +165,14 @@ An example (from hw/input/pckbd.c)
   };
 
 We are declaring the state with name "pckbd".
-The `version_id` is 3, and the fields are 4 uint8_t in a KBDState structure.
+The ``version_id`` is 3, and the fields are 4 uint8_t in a KBDState structure.
 We registered this with:
 
 .. code:: c
 
     vmstate_register(NULL, 0, &vmstate_kbd, s);
 
-For devices that are `qdev` based, we can register the device in the class
+For devices that are ``qdev`` based, we can register the device in the class
 init function:
 
 .. code:: c
@@ -209,9 +209,9 @@ another to load the state back.
                            SaveVMHandlers *ops,
                            void *opaque);
 
-Two functions in the ``ops`` structure are the `save_state`
-and `load_state` functions.  Notice that `load_state` receives a version_id
-parameter to know what state format is receiving.  `save_state` doesn't
+Two functions in the ``ops`` structure are the ``save_state``
+and ``load_state`` functions.  Notice that ``load_state`` receives a version_id
+parameter to know what state format is receiving.  ``save_state`` doesn't
 have a version_id parameter because it always uses the latest version.
 
 Note that because the VMState macros still save the data in a raw
@@ -384,26 +384,28 @@ migration of a device, and using them breaks backward-migration
 compatibility; in general most changes can be made by adding Subsections
 (see above) or _TEST macros (see above) which won't break compatibility.
 
-Each version is associated with a series of fields saved.  The `save_state` always saves
-the state as the newer version.  But `load_state` sometimes is able to
-load state from an older version.
+Each version is associated with a series of fields saved.  The
+``save_state`` always saves the state as the newer version.  But
+``load_state`` sometimes is able to load state from an older version.
 
 You can see that there are several version fields:
 
-- `version_id`: the maximum version_id supported by VMState for that device.
-- `minimum_version_id`: the minimum version_id that VMState is able to understand
-  for that device.
-- `minimum_version_id_old`: For devices that were not able to port to vmstate, we can
-  assign a function that knows how to read this old state. This field is
-  ignored if there is no `load_state_old` handler.
+- ``version_id``: the maximum version_id supported by VMState for that
+  device.
+- ``minimum_version_id``: the minimum version_id that VMState is able to
+  understand for that device.
+- ``minimum_version_id_old``: For devices that were not able to port to
+  vmstate, we can assign a function that knows how to read this old
+  state. This field is ignored if there is no ``load_state_old``
+  handler.
 
 VMState is able to read versions from minimum_version_id to
 version_id.  And the function ``load_state_old()`` (if present) is able to
 load state from minimum_version_id_old to minimum_version_id.  This
 function is deprecated and will be removed when no more users are left.
 
-There are *_V* forms of many ``VMSTATE_`` macros to load fields for version dependent fields,
-e.g.
+There are *_V* forms of many ``VMSTATE_`` macros to load fields for
+version dependent fields, e.g.
 
 .. code:: c
 
@@ -453,7 +455,7 @@ data and then transferred to the main structure.
 
 If you use memory API functions that update memory layout outside
 initialization (i.e., in response to a guest action), this is a strong
-indication that you need to call these functions in a `post_load` callback.
+indication that you need to call these functions in a ``post_load`` callback.
 Examples of such memory API functions are:
 
   - memory_region_add_subregion()
@@ -818,17 +820,18 @@ Postcopy now works with hugetlbfs backed memory:
 Postcopy with shared memory
 ---------------------------
 
-Postcopy migration with shared memory needs explicit support from the other
-processes that share memory and from QEMU. There are restrictions on the type of
-memory that userfault can support shared.
+Postcopy migration with shared memory needs explicit support from the
+other processes that share memory and from QEMU. There are restrictions
+on the type of memory that userfault can support shared.
 
-The Linux kernel userfault support works on `/dev/shm` memory and on `hugetlbfs`
-(although the kernel doesn't provide an equivalent to `madvise(MADV_DONTNEED)`
-for hugetlbfs which may be a problem in some configurations).
+The Linux kernel userfault support works on ``/dev/shm`` memory and on
+``hugetlbfs`` (although the kernel doesn't provide an equivalent to
+``madvise(MADV_DONTNEED)`` for hugetlbfs which may be a problem in some
+configurations).
 
 The vhost-user code in QEMU supports clients that have Postcopy support,
-and the `vhost-user-bridge` (in `tests/`) and the DPDK package have changes
-to support postcopy.
+and the ``vhost-user-bridge`` (in ``tests/``) and the DPDK package have
+changes to support postcopy.
 
 The client needs to open a userfaultfd and register the areas
 of memory that it maps with userfault.  The client must then pass the
diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 0568dfa6a4..5057b6e1b2 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -34,11 +34,11 @@ version they were built against. This can be done simply by::
   QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
 The core code will refuse to load a plugin that doesn't export a
-`qemu_plugin_version` symbol or if plugin version is outside of QEMU's
+``qemu_plugin_version`` symbol or if plugin version is outside of QEMU's
 supported range of API versions.
 
-Additionally the `qemu_info_t` structure which is passed to the
-`qemu_plugin_install` method of a plugin will detail the minimum and
+Additionally the ``qemu_info_t`` structure which is passed to the
+``qemu_plugin_install`` method of a plugin will detail the minimum and
 current API versions supported by QEMU. The API version will be
 incremented if new APIs are added. The minimum API version will be
 incremented if existing APIs are changed or removed.
@@ -140,12 +140,12 @@ Example Plugins
 
 There are a number of plugins included with QEMU and you are
 encouraged to contribute your own plugins plugins upstream. There is a
-`contrib/plugins` directory where they can go.
+``contrib/plugins`` directory where they can go.
 
 - tests/plugins
 
 These are some basic plugins that are used to test and exercise the
-API during the `make check-tcg` target.
+API during the ``make check-tcg`` target.
 
 - contrib/plugins/hotblocks.c
 
@@ -157,7 +157,7 @@ with linux-user execution as system emulation tends to generate
 re-translations as blocks from different programs get swapped in and
 out of system memory.
 
-If your program is single-threaded you can use the `inline` option for
+If your program is single-threaded you can use the ``inline`` option for
 slightly faster (but not thread safe) counters.
 
 Example::
@@ -245,7 +245,7 @@ which will lead to a sorted list after the class breakdown::
   ...
 
 To find the argument shorthand for the class you need to examine the
-source code of the plugin at the moment, specifically the `*opt`
+source code of the plugin at the moment, specifically the ``*opt``
 argument in the InsnClassExecCount tables.
 
 - contrib/plugins/lockstep.c
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bd64c1bdcd..666c4d7240 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -749,7 +749,7 @@ The base test class has also support for tests with more than one
 QEMUMachine. The way to get machines is through the ``self.get_vm()``
 method which will return a QEMUMachine instance. The ``self.get_vm()``
 method accepts arguments that will be passed to the QEMUMachine creation
-and also an optional `name` attribute so you can identify a specific
+and also an optional ``name`` attribute so you can identify a specific
 machine and get it more than once through the tests methods. A simple
 and hypothetical example follows:
 
diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-block-operations.rst
index e13f5a21f8..5a3f045827 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -638,7 +638,7 @@ at this point:
         (QEMU) block-job-complete device=job0
 
 In either of the above cases, if you once again run the
-`query-block-jobs` command, there should not be any active block
+``query-block-jobs`` command, there should not be any active block
 operation.
 
 Comparing 'commit' and 'mirror': In both then cases, the overlay images
@@ -777,7 +777,7 @@ the content of image [D].
         }
 
 (6) [On *destination* QEMU] Finally, resume the guest vCPUs by issuing the
-    QMP command `cont`::
+    QMP command ``cont``::
 
         (QEMU) cont
         {
diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 2d5c06cd01..640ee09f88 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -10,22 +10,22 @@ is the Performance Monitoring Unit (PMU).  CPU types such as the
 Cortex-A15 and the Cortex-A57, which respectively implement Arm
 architecture reference manuals ARMv7-A and ARMv8-A, may both optionally
 implement PMUs.  For example, if a user wants to use a Cortex-A15 without
-a PMU, then the `-cpu` parameter should contain `pmu=off` on the QEMU
-command line, i.e. `-cpu cortex-a15,pmu=off`.
+a PMU, then the ``-cpu`` parameter should contain ``pmu=off`` on the QEMU
+command line, i.e. ``-cpu cortex-a15,pmu=off``.
 
 As not all CPU types support all optional CPU features, then whether or
 not a CPU property exists depends on the CPU type.  For example, CPUs
 that implement the ARMv8-A architecture reference manual may optionally
 support the AArch32 CPU feature, which may be enabled by disabling the
-`aarch64` CPU property.  A CPU type such as the Cortex-A15, which does
-not implement ARMv8-A, will not have the `aarch64` CPU property.
+``aarch64`` CPU property.  A CPU type such as the Cortex-A15, which does
+not implement ARMv8-A, will not have the ``aarch64`` CPU property.
 
 QEMU's support may be limited for some CPU features, only partially
 supporting the feature or only supporting the feature under certain
-configurations.  For example, the `aarch64` CPU feature, which, when
+configurations.  For example, the ``aarch64`` CPU feature, which, when
 disabled, enables the optional AArch32 CPU feature, is only supported
 when using the KVM accelerator and when running on a host CPU type that
-supports the feature.  While `aarch64` currently only works with KVM,
+supports the feature.  While ``aarch64`` currently only works with KVM,
 it could work with TCG.  CPU features that are specific to KVM are
 prefixed with "kvm-" and are described in "KVM VCPU Features".
 
@@ -33,12 +33,12 @@ CPU Feature Probing
 ===================
 
 Determining which CPU features are available and functional for a given
-CPU type is possible with the `query-cpu-model-expansion` QMP command.
-Below are some examples where `scripts/qmp/qmp-shell` (see the top comment
+CPU type is possible with the ``query-cpu-model-expansion`` QMP command.
+Below are some examples where ``scripts/qmp/qmp-shell`` (see the top comment
 block in the script for usage) is used to issue the QMP commands.
 
-1. Determine which CPU features are available for the `max` CPU type
-   (Note, we started QEMU with qemu-system-aarch64, so `max` is
+1. Determine which CPU features are available for the ``max`` CPU type
+   (Note, we started QEMU with qemu-system-aarch64, so ``max`` is
    implementing the ARMv8-A reference manual in this case)::
 
       (QEMU) query-cpu-model-expansion type=full model={"name":"max"}
@@ -51,9 +51,9 @@ block in the script for usage) is used to issue the QMP commands.
         "sve896": true, "sve1280": true, "sve2048": true
       }}}}
 
-We see that the `max` CPU type has the `pmu`, `aarch64`, `sve`, and many
-`sve<N>` CPU features.  We also see that all the CPU features are
-enabled, as they are all `true`.  (The `sve<N>` CPU features are all
+We see that the ``max`` CPU type has the ``pmu``, ``aarch64``, ``sve``, and many
+``sve<N>`` CPU features.  We also see that all the CPU features are
+enabled, as they are all ``true``.  (The ``sve<N>`` CPU features are all
 optional SVE vector lengths (see "SVE CPU Properties").  While with TCG
 all SVE vector lengths can be supported, when KVM is in use it's more
 likely that only a few lengths will be supported, if SVE is supported at
@@ -71,9 +71,9 @@ all.)
         "sve896": true, "sve1280": true, "sve2048": true
       }}}}
 
-We see it worked, as `pmu` is now `false`.
+We see it worked, as ``pmu`` is now ``false``.
 
-(3) Let's try to disable `aarch64`, which enables the AArch32 CPU feature::
+(3) Let's try to disable ``aarch64``, which enables the AArch32 CPU feature::
 
       (QEMU) query-cpu-model-expansion type=full model={"name":"max","props":{"aarch64":false}}
       {"error": {
@@ -84,7 +84,7 @@ We see it worked, as `pmu` is now `false`.
 It looks like this feature is limited to a configuration we do not
 currently have.
 
-(4) Let's disable `sve` and see what happens to all the optional SVE
+(4) Let's disable ``sve`` and see what happens to all the optional SVE
     vector lengths::
 
       (QEMU) query-cpu-model-expansion type=full model={"name":"max","props":{"sve":false}}
@@ -97,14 +97,14 @@ currently have.
         "sve896": false, "sve1280": false, "sve2048": false
       }}}}
 
-As expected they are now all `false`.
+As expected they are now all ``false``.
 
 (5) Let's try probing CPU features for the Cortex-A15 CPU type::
 
       (QEMU) query-cpu-model-expansion type=full model={"name":"cortex-a15"}
       {"return": {"model": {"name": "cortex-a15", "props": {"pmu": true}}}}
 
-Only the `pmu` CPU feature is available.
+Only the ``pmu`` CPU feature is available.
 
 A note about CPU feature dependencies
 -------------------------------------
@@ -123,29 +123,29 @@ A note about CPU models and KVM
 -------------------------------
 
 Named CPU models generally do not work with KVM.  There are a few cases
-that do work, e.g. using the named CPU model `cortex-a57` with KVM on a
-seattle host, but mostly if KVM is enabled the `host` CPU type must be
+that do work, e.g. using the named CPU model ``cortex-a57`` with KVM on a
+seattle host, but mostly if KVM is enabled the ``host`` CPU type must be
 used.  This means the guest is provided all the same CPU features as the
-host CPU type has.  And, for this reason, the `host` CPU type should
+host CPU type has.  And, for this reason, the ``host`` CPU type should
 enable all CPU features that the host has by default.  Indeed it's even
 a bit strange to allow disabling CPU features that the host has when using
-the `host` CPU type, but in the absence of CPU models it's the best we can
+the ``host`` CPU type, but in the absence of CPU models it's the best we can
 do if we want to launch guests without all the host's CPU features enabled.
 
-Enabling KVM also affects the `query-cpu-model-expansion` QMP command.  The
+Enabling KVM also affects the ``query-cpu-model-expansion`` QMP command.  The
 affect is not only limited to specific features, as pointed out in example
 (3) of "CPU Feature Probing", but also to which CPU types may be expanded.
-When KVM is enabled, only the `max`, `host`, and current CPU type may be
+When KVM is enabled, only the ``max``, ``host``, and current CPU type may be
 expanded.  This restriction is necessary as it's not possible to know all
 CPU types that may work with KVM, but it does impose a small risk of users
 experiencing unexpected errors.  For example on a seattle, as mentioned
-above, the `cortex-a57` CPU type is also valid when KVM is enabled.
-Therefore a user could use the `host` CPU type for the current type, but
-then attempt to query `cortex-a57`, however that query will fail with our
+above, the ``cortex-a57`` CPU type is also valid when KVM is enabled.
+Therefore a user could use the ``host`` CPU type for the current type, but
+then attempt to query ``cortex-a57``, however that query will fail with our
 restrictions.  This shouldn't be an issue though as management layers and
-users have been preferring the `host` CPU type for use with KVM for quite
+users have been preferring the ``host`` CPU type for use with KVM for quite
 some time.  Additionally, if the KVM-enabled QEMU instance running on a
-seattle host is using the `cortex-a57` CPU type, then querying `cortex-a57`
+seattle host is using the ``cortex-a57`` CPU type, then querying ``cortex-a57``
 will work.
 
 Using CPU Features
@@ -158,12 +158,12 @@ QEMU command line with that CPU type::
   $ qemu-system-aarch64 -M virt -cpu max,pmu=off,sve=on,sve128=on,sve256=on
 
 The example above disables the PMU and enables the first two SVE vector
-lengths for the `max` CPU type.  Note, the `sve=on` isn't actually
-necessary, because, as we observed above with our probe of the `max` CPU
-type, `sve` is already on by default.  Also, based on our probe of
+lengths for the ``max`` CPU type.  Note, the ``sve=on`` isn't actually
+necessary, because, as we observed above with our probe of the ``max`` CPU
+type, ``sve`` is already on by default.  Also, based on our probe of
 defaults, it would seem we need to disable many SVE vector lengths, rather
 than only enabling the two we want.  This isn't the case, because, as
-disabling many SVE vector lengths would be quite verbose, the `sve<N>` CPU
+disabling many SVE vector lengths would be quite verbose, the ``sve<N>`` CPU
 properties have special semantics (see "SVE CPU Property Parsing
 Semantics").
 
@@ -203,49 +203,49 @@ the list of KVM VCPU features and their descriptions.
 SVE CPU Properties
 ==================
 
-There are two types of SVE CPU properties: `sve` and `sve<N>`.  The first
-is used to enable or disable the entire SVE feature, just as the `pmu`
+There are two types of SVE CPU properties: ``sve`` and ``sve<N>``.  The first
+is used to enable or disable the entire SVE feature, just as the ``pmu``
 CPU property completely enables or disables the PMU.  The second type
-is used to enable or disable specific vector lengths, where `N` is the
-number of bits of the length.  The `sve<N>` CPU properties have special
+is used to enable or disable specific vector lengths, where ``N`` is the
+number of bits of the length.  The ``sve<N>`` CPU properties have special
 dependencies and constraints, see "SVE CPU Property Dependencies and
 Constraints" below.  Additionally, as we want all supported vector lengths
 to be enabled by default, then, in order to avoid overly verbose command
-lines (command lines full of `sve<N>=off`, for all `N` not wanted), we
+lines (command lines full of ``sve<N>=off``, for all ``N`` not wanted), we
 provide the parsing semantics listed in "SVE CPU Property Parsing
 Semantics".
 
 SVE CPU Property Dependencies and Constraints
 ---------------------------------------------
 
-  1) At least one vector length must be enabled when `sve` is enabled.
+  1) At least one vector length must be enabled when ``sve`` is enabled.
 
-  2) If a vector length `N` is enabled, then, when KVM is enabled, all
+  2) If a vector length ``N`` is enabled, then, when KVM is enabled, all
      smaller, host supported vector lengths must also be enabled.  If
      KVM is not enabled, then only all the smaller, power-of-two vector
      lengths must be enabled.  E.g. with KVM if the host supports all
-     vector lengths up to 512-bits (128, 256, 384, 512), then if `sve512`
+     vector lengths up to 512-bits (128, 256, 384, 512), then if ``sve512``
      is enabled, the 128-bit vector length, 256-bit vector length, and
      384-bit vector length must also be enabled. Without KVM, the 384-bit
      vector length would not be required.
 
   3) If KVM is enabled then only vector lengths that the host CPU type
      support may be enabled.  If SVE is not supported by the host, then
-     no `sve*` properties may be enabled.
+     no ``sve*`` properties may be enabled.
 
 SVE CPU Property Parsing Semantics
 ----------------------------------
 
-  1) If SVE is disabled (`sve=off`), then which SVE vector lengths
+  1) If SVE is disabled (``sve=off``), then which SVE vector lengths
      are enabled or disabled is irrelevant to the guest, as the entire
      SVE feature is disabled and that disables all vector lengths for
-     the guest.  However QEMU will still track any `sve<N>` CPU
-     properties provided by the user.  If later an `sve=on` is provided,
-     then the guest will get only the enabled lengths.  If no `sve=on`
+     the guest.  However QEMU will still track any ``sve<N>`` CPU
+     properties provided by the user.  If later an ``sve=on`` is provided,
+     then the guest will get only the enabled lengths.  If no ``sve=on``
      is provided and there are explicitly enabled vector lengths, then
      an error is generated.
 
-  2) If SVE is enabled (`sve=on`), but no `sve<N>` CPU properties are
+  2) If SVE is enabled (``sve=on``), but no ``sve<N>`` CPU properties are
      provided, then all supported vector lengths are enabled, which when
      KVM is not in use means including the non-power-of-two lengths, and,
      when KVM is in use, it means all vector lengths supported by the host
@@ -261,7 +261,7 @@ SVE CPU Property Parsing Semantics
      constraint (2) of "SVE CPU Property Dependencies and Constraints").
 
   5) When KVM is enabled, if the host does not support SVE, then an error
-     is generated when attempting to enable any `sve*` properties (see
+     is generated when attempting to enable any ``sve*`` properties (see
      constraint (3) of "SVE CPU Property Dependencies and Constraints").
 
   6) When KVM is enabled, if the host does support SVE, then an error is
@@ -269,8 +269,8 @@ SVE CPU Property Parsing Semantics
      by the host (see constraint (3) of "SVE CPU Property Dependencies and
      Constraints").
 
-  7) If one or more `sve<N>` CPU properties are set `off`, but no `sve<N>`,
-     CPU properties are set `on`, then the specified vector lengths are
+  7) If one or more ``sve<N>`` CPU properties are set ``off``, but no ``sve<N>``,
+     CPU properties are set ``on``, then the specified vector lengths are
      disabled but the default for any unspecified lengths remains enabled.
      When KVM is not enabled, disabling a power-of-two vector length also
      disables all vector lengths larger than the power-of-two length.
@@ -278,15 +278,15 @@ SVE CPU Property Parsing Semantics
      disables all larger vector lengths (see constraint (2) of "SVE CPU
      Property Dependencies and Constraints").
 
-  8) If one or more `sve<N>` CPU properties are set to `on`, then they
+  8) If one or more ``sve<N>`` CPU properties are set to ``on``, then they
      are enabled and all unspecified lengths default to disabled, except
      for the required lengths per constraint (2) of "SVE CPU Property
      Dependencies and Constraints", which will even be auto-enabled if
      they were not explicitly enabled.
 
-  9) If SVE was disabled (`sve=off`), allowing all vector lengths to be
+  9) If SVE was disabled (``sve=off``), allowing all vector lengths to be
      explicitly disabled (i.e. avoiding the error specified in (3) of
-     "SVE CPU Property Parsing Semantics"), then if later an `sve=on` is
+     "SVE CPU Property Parsing Semantics"), then if later an ``sve=on`` is
      provided an error will be generated.  To avoid this error, one must
      enable at least one vector length prior to enabling SVE.
 
@@ -297,12 +297,12 @@ SVE CPU Property Examples
 
      $ qemu-system-aarch64 -M virt -cpu max,sve=off
 
-  2) Implicitly enable all vector lengths for the `max` CPU type::
+  2) Implicitly enable all vector lengths for the ``max`` CPU type::
 
      $ qemu-system-aarch64 -M virt -cpu max
 
   3) When KVM is enabled, implicitly enable all host CPU supported vector
-     lengths with the `host` CPU type::
+     lengths with the ``host`` CPU type::
 
      $ qemu-system-aarch64 -M virt,accel=kvm -cpu host
 
diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index e3e1a3a3a7..b0a35b54bd 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -77,7 +77,7 @@ Boot options
 ------------
 
 The Nuvoton machines can boot from an OpenBMC firmware image, or directly into
-a kernel using the ``-kernel`` option. OpenBMC images for `quanta-gsj` and
+a kernel using the ``-kernel`` option. OpenBMC images for ``quanta-gsj`` and
 possibly others can be downloaded from the OpenPOWER jenkins :
 
    https://openpower.xyz/
diff --git a/docs/system/s390x/protvirt.rst b/docs/system/s390x/protvirt.rst
index 712974ad87..d208c12a96 100644
--- a/docs/system/s390x/protvirt.rst
+++ b/docs/system/s390x/protvirt.rst
@@ -14,11 +14,11 @@ Prerequisites
 To run PVMs, a machine with the Protected Virtualization feature, as
 indicated by the Ultravisor Call facility (stfle bit 158), is
 required. The Ultravisor needs to be initialized at boot by setting
-`prot_virt=1` on the host's kernel command line.
+``prot_virt=1`` on the host's kernel command line.
 
 Running PVMs requires using the KVM hypervisor.
 
-If those requirements are met, the capability `KVM_CAP_S390_PROTECTED`
+If those requirements are met, the capability ``KVM_CAP_S390_PROTECTED``
 will indicate that KVM can support PVMs on that LPAR.
 
 
@@ -26,8 +26,8 @@ QEMU Settings
 -------------
 
 To indicate to the VM that it can transition into protected mode, the
-`Unpack facility` (stfle bit 161 represented by the feature
-`unpack`/`S390_FEAT_UNPACK`) needs to be part of the cpu model of
+``Unpack facility`` (stfle bit 161 represented by the feature
+``unpack``/``S390_FEAT_UNPACK``) needs to be part of the cpu model of
 the VM.
 
 All I/O devices need to use the IOMMU.
@@ -56,5 +56,5 @@ from the disk boot. This memory layout includes the encrypted
 components (kernel, initrd, cmdline), the stage3a loader and
 metadata. In case this boot method is used, the command line
 options -initrd and -cmdline are ineffective. The preparation of a PVM
-image is done via the `genprotimg` tool from the s390-tools
+image is done via the ``genprotimg`` tool from the s390-tools
 collection.
-- 
2.26.2


