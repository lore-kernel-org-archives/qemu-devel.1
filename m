Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D689C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D50A2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJbCaH9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D50A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY7Du-00040s-Vl
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 08:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kY7CL-0003Do-8R
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:38:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kY7CI-0007nR-Rs
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:38:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id h22so2279535wmb.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 05:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fvuoYY20C3ek147vBCvnJ24/RM9xkfBIUInp6nJrUiY=;
 b=BJbCaH9Cazg9vMWD0X1XDH1mTni5Js8l+tI188KagkyApfOfGUinpTWK9DWnBGSQxn
 famBDfJvMrLozQ2tE12K6czvyy82a9mlDZQBadv1zi7ODJ6we004d8v3VR0NPIWdnjqg
 Vq7CllbGsZgr+WDxYuS6q5wsJHtxhXoaJFOqeRVrYo3ynrbLK8is4M93tSLnqt6lbtsM
 /H2bZvFALyZhGSvTMEOXSmJ7nunw35PbPF0zYHMO8FjLtzzlPkdHjhOOTchstDRBo5uQ
 0E1w2jr0CAtfVhlqe7TUbrYYLnUJQYPYj3dtCA0caHc7VxcsffU76CgQJJXtOmXtwONf
 w0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=fvuoYY20C3ek147vBCvnJ24/RM9xkfBIUInp6nJrUiY=;
 b=sSd5/nFvpZQz/eb5sBHgfwSSo6OfZHYvdPLHOlqxv2c9m20ptIwf/+WyK9LYO8GVWe
 GqQuy9HuO5k8KikFn+xm42eYE86Hiqv9tVj7yzKEdyz0/IDsHmohKoNjdxf4pb/2KpYA
 35XMiI+X1dAmgB2gZhLB272YVhsFRCQeYyd9oNHZWQqSJzenn+DxW9oG70v/ujbW85Zp
 BK3cKBSFbMplFhQTrS8z/N40yCumArpaIxJHLbMh1Vh/CcD3qDJlaqc763wPQO0oCa+d
 dXMdij2CikmtNPxr/dLCMpf7ERtosba7Eha/5k575hR9NisYVPQq93pV026pefBqSlcT
 1R6A==
X-Gm-Message-State: AOAM533BnsVmlGTdvn+zG76rw36nyoOWwBU1ibkTg8of4yJuIWaQGrDt
 AjSzNZlmyxSZZfaOp3ChZJ3xSdwpodE=
X-Google-Smtp-Source: ABdhPJyv6mq893nN7i1MBxtGIuQmnZ/5zltSLr4YEODFsfdfvfHoz2etisMy5s/tlfVWjXiWfBCUjQ==
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr4111216wmm.135.1603975108537; 
 Thu, 29 Oct 2020 05:38:28 -0700 (PDT)
Received: from avogadro.redhat.com ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id
 t62sm4179806wmf.22.2020.10.29.05.38.27 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 05:38:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: expand sourceset documentation
Date: Thu, 29 Oct 2020 13:38:26 +0100
Message-Id: <20201029123826.502771-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 replay/meson.build          |   1 +
 3 files changed, 108 insertions(+), 53 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 6fcf8854b7..1c8ea8ce0a 100644
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
+  into .o files, Meson needs to pick *both* the `if_true` and
+  `if_false` sides to cater for targets that need either side.  For
+  that reason, you need to add a special rule using the ``CONFIG_ALL``
+  symbol::
+
+    # This is not enough
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
+  file for each emulator[#cfgtarget]_.  However, the ``TARGET_ARCH``
+  and ``TARGET_BASE_ARCH`` will also be used to select the `hw/` and
+  `target/` subdirectories that are compiled into each target.
+
+.. [#cfgtarget] This header is included by `qemu/osdep.h` when
+   compiling files from the target-specific sourcesets.
 
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
diff --git a/replay/meson.build b/replay/meson.build
index 21aefad220..6d82308341 100644
--- a/replay/meson.build
+++ b/replay/meson.build
@@ -11,3 +11,4 @@ softmmu_ss.add(when: 'CONFIG_TCG', if_true: files(
   'replay-random.c',
   'replay-debugging.c',
 ), if_false: files('stubs-system.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('stubs-system.c'))
-- 
2.26.2


