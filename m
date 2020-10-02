Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2015AC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A558B20719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6Dj/jp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A558B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOIJ-0005vQ-Na
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOOHP-00052P-Fc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:51:35 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:40326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOOHM-0006gR-V6
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:51:35 -0400
Received: by mail-ot1-x331.google.com with SMTP id c2so1987832otp.7
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2MsAnNRIGP374awQgIsuNsBbAbPA2QmHblcABmdg1no=;
 b=N6Dj/jp51smkVfOgBubhshZtCGZ2ZeI3PIjWWQlFcewpRY445bN4y1cA4waJqCxgjS
 au00OvoKHEqBJV86YihkEXvr9cHNqb0MA/fdxDB/nmnWN+FALqT5bp0RbUvo4v+WdX98
 M/ZnDNhpejmuu7pYws+cebGzYfP0FIjgv+UAYAfiqMI1HxQ6Xwgwlc58p32JGcGA8p2f
 /PQpMW9jC18dQ5WcvVnN7Qp1Yg0k+tyPgOjEUwIU0C45IzcE760VQAPlITEH0ATuffZf
 164O1eKftPmN9kUg5iC0WioH95ZxJql8+ktJ+lEE7cj5pgtUj9MDARSselRYSPqTA6zJ
 1Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2MsAnNRIGP374awQgIsuNsBbAbPA2QmHblcABmdg1no=;
 b=d4/Vby1/8xheex7KE3jMGWNg3lqUKamVyufwsO+uTSuQebH/0tYfyMjpBbbFIWD5t+
 tgqquTlKGnPk68EoR3vqM5yIolrWFlOd7SjRubERMTj651xk1G2rQou81TIGrcSoETRr
 V9Ym5ogZgtZmPONwEbCOTBLO/wTz2q6AEKkylM9ua/GnsdpCkjBvwen425r5P8IgbPTz
 75wkyM96uK0rrjS9tINNgi03fOoLp2FA1yeL2eq+JUcb3AKSRILBGcC6Eyh/CdzTfbRB
 1AwbfmWVESXOWLXcqLxwCCLKtyRfVQ7BOa3XX3B2tPe1cT6f1tGrJMbk84GsXJt4h0F3
 ZL0Q==
X-Gm-Message-State: AOAM533S5+RaQez/fpxVSVcrB1DFJN+sMeUlHWC5a7SYQtLILwEE/b/0
 6BOKq7vmBS1K1cvB2Lglf5w8Uucnd6BrlTve
X-Google-Smtp-Source: ABdhPJxQkhXfrVSAEfws72lMhvtgvm80EesPjC9ZVtHBx0UZ9yekGbUTa73G471jaRe67YH+GO2+sw==
X-Received: by 2002:a9d:7a2:: with SMTP id 31mr2247992oto.141.1601657491132;
 Fri, 02 Oct 2020 09:51:31 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id 189sm367235oid.40.2020.10.02.09.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 09:51:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/11] capstone: Convert Makefile bits to meson bits
Date: Fri,  2 Oct 2020 11:51:27 -0500
Message-Id: <20201002165127.130369-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002165127.130369-1-richard.henderson@linaro.org>
References: <20201002165127.130369-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are better ways to do this, e.g. meson cmake subproject,
but that requires cmake 3.7 and some of our CI environments
only provide cmake 3.5.

Nor can we add a meson.build file to capstone/, because the git
submodule would then always report "untracked files".  Fixing that
would require creating our own branch on the qemu git mirror, at
which point we could just as easily create a native meson subproject.

Instead, build the library via the main meson.build.

This improves the current state of affairs in that we will re-link
the qemu executables against a changed libcapstone.a, which we wouldn't
do before-hand.  In addition, the use of the configuration header file
instead of command-line -DEFINES means that we will rebuild the
capstone objects with changes to meson.build.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure         |  68 ++++------------------------
 Makefile          |  18 ++------
 meson.build       | 111 +++++++++++++++++++++++++++++++++++++++++++---
 meson_options.txt |   4 ++
 4 files changed, 121 insertions(+), 80 deletions(-)

diff --git a/configure b/configure
index a5841241be..f46f433649 100755
--- a/configure
+++ b/configure
@@ -478,7 +478,7 @@ opengl=""
 opengl_dmabuf="no"
 cpuid_h="no"
 avx2_opt=""
-capstone=""
+capstone="auto"
 lzo=""
 snappy=""
 bzip2=""
@@ -1575,11 +1575,11 @@ for opt do
   ;;
   --enable-vhost-kernel) vhost_kernel="yes"
   ;;
-  --disable-capstone) capstone="no"
+  --disable-capstone) capstone="disabled"
   ;;
-  --enable-capstone) capstone="yes"
+  --enable-capstone) capstone="enabled"
   ;;
-  --enable-capstone=git) capstone="git"
+  --enable-capstone=git) capstone="internal"
   ;;
   --enable-capstone=system) capstone="system"
   ;;
@@ -5017,51 +5017,11 @@ fi
 # capstone
 
 case "$capstone" in
-  "" | yes)
-    if $pkg_config capstone; then
-      capstone=system
-    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
-      capstone=git
-    elif test -e "${source_path}/capstone/Makefile" ; then
-      capstone=internal
-    elif test -z "$capstone" ; then
-      capstone=no
-    else
-      feature_not_found "capstone" "Install capstone devel or git submodule"
-    fi
-    ;;
-
-  system)
-    if ! $pkg_config capstone; then
-      feature_not_found "capstone" "Install capstone devel"
-    fi
-    ;;
-esac
-
-case "$capstone" in
-  git | internal)
-    if test "$capstone" = git; then
+  auto | enabled | internal)
+    # Simpler to always update submodule, even if not needed.
+    if test -e "${source_path}/.git" && test $git_update = 'yes' ; then
       git_submodules="${git_submodules} capstone"
     fi
-    mkdir -p capstone
-    if test "$mingw32" = "yes"; then
-      LIBCAPSTONE=capstone.lib
-    else
-      LIBCAPSTONE=libcapstone.a
-    fi
-    capstone_libs="-Lcapstone -lcapstone"
-    capstone_cflags="-I${source_path}/capstone/include"
-    ;;
-
-  system)
-    capstone_libs="$($pkg_config --libs capstone)"
-    capstone_cflags="$($pkg_config --cflags capstone)"
-    ;;
-
-  no)
-    ;;
-  *)
-    error_exit "Unknown state for capstone: $capstone"
     ;;
 esac
 
@@ -7142,11 +7102,6 @@ fi
 if test "$ivshmem" = "yes" ; then
   echo "CONFIG_IVSHMEM=y" >> $config_host_mak
 fi
-if test "$capstone" != "no" ; then
-  echo "CONFIG_CAPSTONE=y" >> $config_host_mak
-  echo "CAPSTONE_CFLAGS=$capstone_cflags" >> $config_host_mak
-  echo "CAPSTONE_LIBS=$capstone_libs" >> $config_host_mak
-fi
 if test "$debug_mutex" = "yes" ; then
   echo "CONFIG_DEBUG_MUTEX=y" >> $config_host_mak
 fi
@@ -7664,13 +7619,7 @@ done # for target in $targets
 if [ "$fdt" = "git" ]; then
   subdirs="$subdirs dtc"
 fi
-if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
-  subdirs="$subdirs capstone"
-fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
-if test -n "$LIBCAPSTONE"; then
-  echo "LIBCAPSTONE=$LIBCAPSTONE" >> $config_host_mak
-fi
 
 if test "$numa" = "yes"; then
   echo "CONFIG_NUMA=y" >> $config_host_mak
@@ -7846,7 +7795,8 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
 	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
 	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
+	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
+	-Dcapstone=$capstone \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/Makefile b/Makefile
index 54fc1a9d10..f27bd4b2eb 100644
--- a/Makefile
+++ b/Makefile
@@ -156,21 +156,11 @@ dtc/all: .git-submodule-status dtc/libfdt
 dtc/%: .git-submodule-status
 	@mkdir -p $@
 
-# Overriding CFLAGS causes us to lose defines added in the sub-makefile.
-# Not overriding CFLAGS leads to mis-matches between compilation modes.
-# Therefore we replicate some of the logic in the sub-makefile.
-# Remove all the extra -Warning flags that QEMU uses that Capstone doesn't;
-# no need to annoy QEMU developers with such things.
-CAP_CFLAGS = $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS)) $(CAPSTONE_CFLAGS)
-CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
-CAP_CFLAGS += -DCAPSTONE_HAS_ARM
-CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
-CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
-CAP_CFLAGS += -DCAPSTONE_HAS_X86
-
+# Retain for a while so that incremental build across this patch
+# does not raise an error for missing target "capstone/all", which
+# comes from the saved SUBDIRS value.
 .PHONY: capstone/all
-capstone/all: .git-submodule-status
-	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
+capstone/all:
 
 .PHONY: slirp/all
 slirp/all: .git-submodule-status
diff --git a/meson.build b/meson.build
index 3161c1f037..cd01da48ca 100644
--- a/meson.build
+++ b/meson.build
@@ -10,6 +10,7 @@ else
   keyval = import('unstable-keyval')
 endif
 ss = import('sourceset')
+fs = import('fs')
 
 sh = find_program('sh')
 cc = meson.get_compiler('c')
@@ -495,11 +496,6 @@ if 'CONFIG_USB_LIBUSB' in config_host
   libusb = declare_dependency(compile_args: config_host['LIBUSB_CFLAGS'].split(),
                               link_args: config_host['LIBUSB_LIBS'].split())
 endif
-capstone = not_found
-if 'CONFIG_CAPSTONE' in config_host
-  capstone = declare_dependency(compile_args: config_host['CAPSTONE_CFLAGS'].split(),
-                                link_args: config_host['CAPSTONE_LIBS'].split())
-endif
 libpmem = not_found
 if 'CONFIG_LIBPMEM' in config_host
   libpmem = declare_dependency(compile_args: config_host['LIBPMEM_CFLAGS'].split(),
@@ -581,7 +577,6 @@ foreach k, v: config_host
     config_host_data.set(k, v == 'y' ? 1 : v)
   endif
 endforeach
-genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
 minikconf = find_program('scripts/minikconf.py')
 config_all = {}
@@ -736,6 +731,108 @@ config_all += {
   'CONFIG_ALL': true,
 }
 
+# Submodules
+
+capstone = not_found
+capstone_opt = get_option('capstone')
+if capstone_opt == 'disabled'
+  capstone_opt = false
+elif capstone_opt in ['enabled', 'auto', 'system']
+  have_internal = fs.exists('capstone/Makefile')
+  capstone = dependency('capstone', static: enable_static,
+                        required: capstone_opt == 'system' or
+                                  capstone_opt == 'enabled' and not have_internal)
+  if capstone.found()
+    capstone_opt = 'system'
+  elif have_internal
+    capstone_opt = 'internal'
+  else
+    capstone_opt = false
+  endif
+endif
+if capstone_opt == 'internal'
+  capstone_data = configuration_data()
+  capstone_data.set('CAPSTONE_USE_SYS_DYN_MEM', '1')
+
+  capstone_files = files(
+    'capstone/cs.c',
+    'capstone/MCInst.c',
+    'capstone/MCInstrDesc.c',
+    'capstone/MCRegisterInfo.c',
+    'capstone/SStream.c',
+    'capstone/utils.c'
+  )
+
+  if 'CONFIG_ARM_DIS' in config_all_disas
+    capstone_data.set('CAPSTONE_HAS_ARM', '1')
+    capstone_files += files(
+      'capstone/arch/ARM/ARMDisassembler.c',
+      'capstone/arch/ARM/ARMInstPrinter.c',
+      'capstone/arch/ARM/ARMMapping.c',
+      'capstone/arch/ARM/ARMModule.c'
+    )
+  endif
+
+  # FIXME: This config entry currently depends on a c++ compiler.
+  # Which is needed for building libvixl, but not for capstone.
+  if 'CONFIG_ARM_A64_DIS' in config_all_disas
+    capstone_data.set('CAPSTONE_HAS_ARM64', '1')
+    capstone_files += files(
+      'capstone/arch/AArch64/AArch64BaseInfo.c',
+      'capstone/arch/AArch64/AArch64Disassembler.c',
+      'capstone/arch/AArch64/AArch64InstPrinter.c',
+      'capstone/arch/AArch64/AArch64Mapping.c',
+      'capstone/arch/AArch64/AArch64Module.c'
+    )
+  endif
+
+  if 'CONFIG_PPC_DIS' in config_all_disas
+    capstone_data.set('CAPSTONE_HAS_POWERPC', '1')
+    capstone_files += files(
+      'capstone/arch/PowerPC/PPCDisassembler.c',
+      'capstone/arch/PowerPC/PPCInstPrinter.c',
+      'capstone/arch/PowerPC/PPCMapping.c',
+      'capstone/arch/PowerPC/PPCModule.c'
+    )
+  endif
+
+  if 'CONFIG_I386_DIS' in config_all_disas
+    capstone_data.set('CAPSTONE_HAS_X86', 1)
+    capstone_files += files(
+      'capstone/arch/X86/X86Disassembler.c',
+      'capstone/arch/X86/X86DisassemblerDecoder.c',
+      'capstone/arch/X86/X86ATTInstPrinter.c',
+      'capstone/arch/X86/X86IntelInstPrinter.c',
+      'capstone/arch/X86/X86Mapping.c',
+      'capstone/arch/X86/X86Module.c'
+    )
+  endif
+
+  configure_file(output: 'capstone-defs.h', configuration: capstone_data)
+
+  capstone_cargs = [
+    # FIXME: There does not seem to be a way to completely replace the c_args
+    # that come from add_project_arguments() -- we can only add to them.
+    # So: disable all warnings with a big hammer.
+    '-Wno-error', '-w',
+
+    # Include all configuration defines via a header file, which will wind up
+    # as a dependency on the object file, and thus changes here will result
+    # in a rebuild.
+    '-include', 'capstone-defs.h'
+  ]
+
+  libcapstone = static_library('capstone',
+                               sources: capstone_files,
+                               c_args: capstone_cargs,
+                               include_directories: 'capstone/include')
+  capstone = declare_dependency(link_with: libcapstone,
+                                include_directories: 'capstone/include')
+endif
+config_host_data.set('CONFIG_CAPSTONE', capstone.found())
+
+genh += configure_file(output: 'config-host.h', configuration: config_host_data)
+
 # Generators
 
 hxtool = find_program('scripts/hxtool')
@@ -1566,7 +1663,7 @@ summary_info += {'vvfat support':     config_host.has_key('CONFIG_VVFAT')}
 summary_info += {'qed support':       config_host.has_key('CONFIG_QED')}
 summary_info += {'parallels support': config_host.has_key('CONFIG_PARALLELS')}
 summary_info += {'sheepdog support':  config_host.has_key('CONFIG_SHEEPDOG')}
-summary_info += {'capstone':          config_host.has_key('CONFIG_CAPSTONE')}
+summary_info += {'capstone':          capstone_opt}
 summary_info += {'libpmem support':   config_host.has_key('CONFIG_LIBPMEM')}
 summary_info += {'libdaxctl support': config_host.has_key('CONFIG_LIBDAXCTL')}
 summary_info += {'libudev':           libudev.found()}
diff --git a/meson_options.txt b/meson_options.txt
index 46ea1d889a..a1228d29a9 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -31,3 +31,7 @@ option('vnc_sasl', type : 'feature', value : 'auto',
        description: 'SASL authentication for VNC server')
 option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
+
+option('capstone', type: 'combo', value: 'auto',
+       choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
+       description: 'Whether and how to find the capstone library')
-- 
2.25.1


