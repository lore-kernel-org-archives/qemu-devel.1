Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20113C388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710BA2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlNHdpii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710BA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKO8-00034G-DY
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIZ-00031d-TA
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIS-00061W-LR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604502120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMtM0pTqeXzqcCDSsCXTsRBZRjtYvGbmLqmPyOLS46I=;
 b=BlNHdpiiv4b8tI/T4mb3BFA/XHu1nFIrg+ILust6KI8x6HRbsYstleu9kjmrkrk8P/whrt
 fSR15RRBs7FZn90nhhv1zavgSuOeAgExZuw7/TQZiuqB1RNINU9XsCZbZcAtqLO2FFgQwd
 DPQehk3OAwmuQhqUoR80EMa0nAzYghA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-U8NkS_gUOCKhzqlBMmb59g-1; Wed, 04 Nov 2020 10:01:56 -0500
X-MC-Unique: U8NkS_gUOCKhzqlBMmb59g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 904CF804744
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 15:01:55 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5403C1002D41
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 15:01:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] docs: expand sourceset documentation
Date: Wed,  4 Nov 2020 10:01:35 -0500
Message-Id: <20201104150153.541326-3-pbonzini@redhat.com>
In-Reply-To: <20201104150153.541326-1-pbonzini@redhat.com>
References: <20201104150153.541326-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Expand on the usage of sourcesets and describe the CONFIG_ALL
symbol.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 158 ++++++++++++++++++++++++------------
 docs/devel/kconfig.rst      |   2 +
 2 files changed, 107 insertions(+), 53 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 6fcf8854b7..31f4dced2a 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -187,21 +187,23 @@ process for:
 
 4) other data files, such as icons or desktop files
 
-The source code is highly modularized, split across many files to
-facilitate building of all of these components with as little duplicated
-compilation as possible. The Meson "sourceset" functionality is used
-to list the files and their dependency on various configuration  
-symbols.
-
 All executables are built by default, except for some `contrib/`
 binaries that are known to fail to build on some platforms (for example
 32-bit or big-endian platforms).  Tests are also built by default,
 though that might change in the future.
 
-Various subsystems that are common to both tools and emulators have
-their own sourceset, for example `block_ss` for the block device subsystem,
-`chardev_ss` for the character device subsystem, etc.  These sourcesets
-are then turned into static libraries as follows::
+The source code is highly modularized, split across many files to
+facilitate building of all of these components with as little duplicated
+compilation as possible. Using the Meson "sourceset" functionality,
+`meson.build` files group the source files in rules that are
+enabled according to the available system libraries and to various
+configuration symbols.  Sourcesets belong to one of four groups:
+
+Subsystem sourcesets:
+  Various subsystems that are common to both tools and emulators have
+  their own sourceset, for example `block_ss` for the block device subsystem,
+  `chardev_ss` for the character device subsystem, etc.  These sourcesets
+  are then turned into static libraries as follows::
 
     libchardev = static_library('chardev', chardev_ss.sources(),
                                 name_suffix: 'fa',
@@ -209,61 +211,111 @@ are then turned into static libraries as follows::
 
     chardev = declare_dependency(link_whole: libchardev)
 
-As of Meson 0.55.1, the special `.fa` suffix should be used for everything
-that is used with `link_whole`, to ensure that the link flags are placed
-correctly in the command line.
-
-Files linked into emulator targets there can be split into two distinct groups
-of files, those which are independent of the QEMU emulation target and
-those which are dependent on the QEMU emulation target.
-
-In the target-independent set lives various general purpose helper code,
-such as error handling infrastructure, standard data structures,
-platform portability wrapper functions, etc. This code can be compiled
-once only and the .o files linked into all output binaries.
-Target-independent code lives in the `common_ss`, `softmmu_ss` and
-`user_ss` sourcesets.  `common_ss` is linked into all emulators, `softmmu_ss`
-only in system emulators, `user_ss` only in user-mode emulators.
-
-In the target-dependent set lives CPU emulation, device emulation and
-much glue code. This sometimes also has to be compiled multiple times,
-once for each target being built.  Target-dependent files are included
-in the `specific_ss` sourceset.
-
-All binaries link with a static library `libqemuutil.a`, which is then
-linked to all the binaries.  `libqemuutil.a` is built from several
-sourcesets; most of them however host generated code, and the only two
-of general interest are `util_ss` and `stub_ss`.
-
-The separation between these two is purely for documentation purposes.
-`util_ss` contains generic utility files.  Even though this code is only
-linked in some binaries, sometimes it requires hooks only in some of
-these and depend on other functions that are not fully implemented by
-all QEMU binaries.  `stub_ss` links dummy stubs that will only be linked
-into the binary if the real implementation is not present.  In a way,
-the stubs can be thought of as a portable implementation of the weak
-symbols concept.
+  As of Meson 0.55.1, the special `.fa` suffix should be used for everything
+  that is used with `link_whole`, to ensure that the link flags are placed
+  correctly in the command line.
+
+Target-independent emulator sourcesets:
+  Various general purpose helper code is compiled only once and
+  the .o files are linked into all output binaries that need it.
+  This includes error handling infrastructure, standard data structures,
+  platform portability wrapper functions, etc.
+
+  Target-independent code lives in the `common_ss`, `softmmu_ss` and
+  `user_ss` sourcesets.  `common_ss` is linked into all emulators,
+  `softmmu_ss` only in system emulators, `user_ss` only in user-mode
+  emulators.
+
+  Target-independent sourcesets must exercise particular care when using
+  `if_false` rules.  The `if_false` rule will be used correctly when linking
+  emulator binaries; however, when *compiling* target-independent files
+  into .o files, Meson may need to pick *both* the `if_true` and
+  `if_false` sides to cater for targets that want either side.  To
+  achieve that, you can add a special rule using the ``CONFIG_ALL``
+  symbol::
+
+    # Some targets have CONFIG_ACPI, some don't, so this is not enough
+    softmmu_ss.add(when: 'CONFIG_ACPI`, if_true: files('acpi.c'),
+                                        if_false: files('acpi-stub.c'))
+
+    # This is required as well:
+    softmmu_ss.add(when: 'CONFIG_ALL`, if_true: files('acpi-stub.c'))
+
+Target-dependent emulator sourcesets:
+  In the target-dependent set lives CPU emulation, some device emulation and
+  much glue code. This sometimes also has to be compiled multiple times,
+  once for each target being built.  Target-dependent files are included
+  in the `specific_ss` sourceset.
+
+  Each emulator also includes sources for files in the `hw/` and `target/`
+  subdirectories.  The subdirectory used for each emulator comes
+  from the target's definition of ``TARGET_BASE_ARCH`` or (if missing)
+  ``TARGET_ARCH``, as found in `default-configs/targets/*.mak`.
+
+  Each subdirectory in `hw/` adds one sourceset to the `hw_arch` dictionary,
+  for example::
+
+    arm_ss = ss.source_set()
+    arm_ss.add(files('boot.c'), fdt)
+    ...
+    hw_arch += {'arm': arm_ss}
+
+  The sourceset is only used for system emulators.
+
+  Each subdirectory in `target/` instead should add one sourceset to each
+  of the `target_arch` and `target_softmmu_arch`, which are used respectively
+  for all emulators and for system emulators only.  For example::
+
+    arm_ss = ss.source_set()
+    arm_softmmu_ss = ss.source_set()
+    ...
+    target_arch += {'arm': arm_ss}
+    target_softmmu_arch += {'arm': arm_softmmu_ss}
+
+Utility sourcesets:
+  All binaries link with a static library `libqemuutil.a`.  This library
+  is built from several sourcesets; most of them however host generated
+  code, and the only two of general interest are `util_ss` and `stub_ss`.
+
+  The separation between these two is purely for documentation purposes.
+  `util_ss` contains generic utility files.  Even though this code is only
+  linked in some binaries, sometimes it requires hooks only in some of
+  these and depend on other functions that are not fully implemented by
+  all QEMU binaries.  `stub_ss` links dummy stubs that will only be linked
+  into the binary if the real implementation is not present.  In a way,
+  the stubs can be thought of as a portable implementation of the weak
+  symbols concept.
+
 
 The following files concur in the definition of which files are linked
 into each emulator:
 
-`default-configs/*.mak`
-  The files under default-configs/ control what emulated hardware is built
-  into each QEMU system and userspace emulator targets. They merely contain
-  a list of config variable definitions like the machines that should be
-  included. For example, default-configs/aarch64-softmmu.mak has::
+`default-configs/devices/*.mak`
+  The files under `default-configs/devices/` control the boards and devices
+  that are built into each QEMU system emulation targets. They merely contain
+  a list of config variable definitions such as::
 
     include arm-softmmu.mak
     CONFIG_XLNX_ZYNQMP_ARM=y
     CONFIG_XLNX_VERSAL=y
 
 `*/Kconfig`
-  These files are processed together with `default-configs/*.mak` and
+  These files are processed together with `default-configs/devices/*.mak` and
   describe the dependencies between various features, subsystems and
-  device models.  They are described in kconfig.rst.
+  device models.  They are described in :ref:`kconfig`
+
+`default-configs/targets/*.mak`
+  These files mostly define symbols that appear in the `*-config-target.h`
+  file for each emulator [#cfgtarget]_.  However, the ``TARGET_ARCH``
+  and ``TARGET_BASE_ARCH`` will also be used to select the `hw/` and
+  `target/` subdirectories that are compiled into each target.
+
+.. [#cfgtarget] This header is included by `qemu/osdep.h` when
+                compiling files from the target-specific sourcesets.
 
-These files rarely need changing unless new devices / hardware need to
-be enabled for a particular system/userspace emulation target
+These files rarely need changing unless you are adding a completely
+new target, or enabling new devices or hardware for a particular
+system/userspace emulation target
 
 
 Support scripts
diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
index e5df72b342..336ba0e8e5 100644
--- a/docs/devel/kconfig.rst
+++ b/docs/devel/kconfig.rst
@@ -1,3 +1,5 @@
+.. _kconfig:
+
 ================
 QEMU and Kconfig
 ================
-- 
2.26.2



