Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFB3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A61207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+TyBtcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A61207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQzq-0008TA-8c
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQyS-00078T-08
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:56:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQyO-0000NT-S0
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:56:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id k10so9683837wru.6
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U7sNZB2VXonlY+9BgEDJ21Ard5jJhPjK31W+FYncWDk=;
 b=H+TyBtcIfwbf1aFsmsGBXxStLECRz/OSrT+CQaY8inLX+VuJOaBfSIj5j1HSr682vg
 TCOztDVSDrp/zQIebgq8xne4oQ3aTgh1wsveWNBkGqB9sGuBA3iEMlPsThxBj5hVAWNE
 qel3artLMA/fmsrbERFJuwz+DHgEf1EzkzpBNHviPxwFfN2s7Sc4BfOjrk2hYChsIp4g
 Fq01KhZ9Oemo9mRik1JFsGE04aDEnkSHSacouJjDLj9okx1wL5NwzkiFPOFbshLwwHPd
 8tKjo4Xn50ECEJhDRziD2tAU6yJlEmRD+PrmwO8OIrtuogL2zMTuoFuJq50jGFHl8Rfo
 Igqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=U7sNZB2VXonlY+9BgEDJ21Ard5jJhPjK31W+FYncWDk=;
 b=rZCtdmMzQMH3FIqk2p7d4474Hnz+yNTApsxopQNogbpFIoRJG0ycseazSfQFDO1Thz
 Fvzeq1UqVVCU2sICG1yuNdDKZyXSCDCza+8mmehJ6zM5GSfTqpoqlIYaa9JXtH/APT1Z
 OcnXzTz94rze6Ap+ZCkZUZ2/TsCEL+Rmtt3inOSIfA4nXsD5VJAjKGv7O5qYMvqHWXGH
 5wvVrZWAdbcmVCjhgNbzQ1DSOivRIVU3P3C11/tD1Sqp5zHMOcv2RUV2B9IuCJrHexf0
 o/3DdCFHj8kSnu+nSOnvNWGuG6jnNfL0Gp2OOZfFbnpWCydWB6/pZOFo1o4E20/Mt+MC
 /mXA==
X-Gm-Message-State: AOAM533FXLTlBPTySaHWEKrypYdJ5PtYEva/a++00MhRHqKSf7ioa9VJ
 svk4MA1B+PQp9zJ6fhBylv5TtYbs50A=
X-Google-Smtp-Source: ABdhPJzvyksxF/JK/7tQBh3sRITDzqCkhyLe9ivCkSO9I2H6lAS+utBvl0HcWiOgClmrL6FY4nt4Iw==
X-Received: by 2002:a05:6000:10ce:: with SMTP id
 b14mr6002072wrx.204.1601906174831; 
 Mon, 05 Oct 2020 06:56:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id c8sm13406559wmd.18.2020.10.05.06.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 06:56:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] dtc: Convert Makefile bits to meson bits
Date: Mon,  5 Oct 2020 15:56:11 +0200
Message-Id: <20201005135613.435932-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005135613.435932-1-pbonzini@redhat.com>
References: <20201005135613.435932-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
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
Cc: marcandre.lureau@redhat.com, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build the library via the main meson.build just like for capstone.
This improves the current state of affairs in that we will re-link
the qemu executables against a changed libfdt.a, which we wouldn't
do before-hand, and lets us remove the whole recursive make machinery.

The list of targets that require FDT is now obtained from default-configs/
instead of being hardcoded in the configure script.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                                      | 23 +----
 configure                                     | 93 ++++---------------
 default-configs/targets/aarch64-softmmu.mak   |  1 +
 default-configs/targets/arm-softmmu.mak       |  1 +
 .../targets/microblaze-softmmu.mak            |  1 +
 .../targets/microblazeel-softmmu.mak          |  1 +
 default-configs/targets/mips64el-softmmu.mak  |  1 +
 default-configs/targets/ppc-softmmu.mak       |  1 +
 default-configs/targets/ppc64-softmmu.mak     |  1 +
 default-configs/targets/riscv32-softmmu.mak   |  1 +
 default-configs/targets/riscv64-softmmu.mak   |  1 +
 default-configs/targets/rx-softmmu.mak        |  1 +
 meson.build                                   | 61 ++++++++++--
 meson_options.txt                             |  3 +
 14 files changed, 84 insertions(+), 106 deletions(-)

diff --git a/Makefile b/Makefile
index 9d6b7fc8c0..c37e513431 100644
--- a/Makefile
+++ b/Makefile
@@ -142,28 +142,6 @@ SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
 include $(SRC_PATH)/tests/Makefile.include
 
 all: recurse-all
-Makefile: $(addsuffix /all, $(SUBDIRS))
-
-# LIBFDT_lib="": avoid breaking existing trees with objects requiring -fPIC
-DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_lib=""
-DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
-DTC_CPPFLAGS=-I$(SRC_PATH)/dtc/libfdt
-
-.PHONY: dtc/all
-dtc/all: .git-submodule-status dtc/libfdt
-	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt,)
-
-dtc/%: .git-submodule-status
-	@mkdir -p $@
-
-# Retain for a while so that incremental build across this patch
-# does not raise an error for missing target "capstone/all", which
-# comes from the saved SUBDIRS value.
-.PHONY: capstone/all
-capstone/all:
-
-.PHONY: slirp/all
-slirp/all:
 
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
diff --git a/configure b/configure
index 51f4e978be..2fdb4339e8 100755
--- a/configure
+++ b/configure
@@ -296,7 +296,7 @@ brlapi=""
 curl=""
 curses=""
 docs=""
-fdt=""
+fdt="auto"
 netmap="no"
 sdl="auto"
 sdl_image="auto"
@@ -1181,9 +1181,13 @@ for opt do
   ;;
   --enable-curl) curl="yes"
   ;;
-  --disable-fdt) fdt="no"
+  --disable-fdt) fdt="disabled"
   ;;
-  --enable-fdt) fdt="yes"
+  --enable-fdt) fdt="enabled"
+  ;;
+  --enable-fdt=git) fdt="internal"
+  ;;
+  --enable-fdt=system) fdt="system"
   ;;
   --disable-linux-aio) linux_aio="no"
   ;;
@@ -3941,67 +3945,15 @@ fi
 
 ##########################################
 # fdt probe
-# fdt support is mandatory for at least some target architectures,
-# so insist on it if we're building those system emulators.
-fdt_required=no
-for target in $target_list; do
-  case $target in
-    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|riscv*-softmmu|rx-softmmu)
-      fdt_required=yes
-    ;;
-  esac
-done
-
-if test "$fdt_required" = "yes"; then
-  if test "$fdt" = "no"; then
-    error_exit "fdt disabled but some requested targets require it." \
-      "You can turn off fdt only if you also disable all the system emulation" \
-      "targets which need it (by specifying a cut down --target-list)."
-  fi
-  fdt=yes
-elif test "$fdt" != "yes" ; then
-  fdt=no
-fi
-
-# fdt is only required when building softmmu targets
-if test -z "$fdt" -a "$softmmu" != "yes" ; then
-    fdt="no"
-fi
 
-if test "$fdt" != "no" ; then
-  fdt_libs="-lfdt"
-  # explicitly check for libfdt_env.h as it is missing in some stable installs
-  # and test for required functions to make sure we are on a version >= 1.4.2
-  cat > $TMPC << EOF
-#include <libfdt.h>
-#include <libfdt_env.h>
-int main(void) { fdt_check_full(NULL, 0); return 0; }
-EOF
-  if compile_prog "" "$fdt_libs" ; then
-    # system DTC is good - use it
-    fdt=system
-  else
-      # have GIT checkout, so activate dtc submodule
-      if test -e "${source_path}/.git" ; then
-          git_submodules="${git_submodules} dtc"
-      fi
-      if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
-          fdt=git
-          mkdir -p dtc
-          fdt_cflags="-I${source_path}/dtc/libfdt"
-          fdt_ldflags="-Ldtc/libfdt"
-          fdt_libs="$fdt_libs"
-      elif test "$fdt" = "yes" ; then
-          # Not a git build & no libfdt found, prompt for system install
-          error_exit "DTC (libfdt) version >= 1.4.2 not present." \
-                     "Please install the DTC (libfdt) devel package"
-      else
-          # don't have and don't want
-          fdt_libs=
-          fdt=no
-      fi
-  fi
-fi
+case "$fdt" in
+  auto | enabled | internal)
+    # Simpler to always update submodule, even if not needed.
+    if test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+      git_submodules="${git_submodules} dtc"
+    fi
+    ;;
+esac
 
 ##########################################
 # opengl probe (for sdl2, gtk, milkymist-tmu2)
@@ -6107,9 +6059,6 @@ fi
 if test $git_update = 'yes' ; then
     (cd "${source_path}" && GIT="$git" "./scripts/git-submodule.sh" update "$git_submodules")
 fi
-if test "$fdt" = "git" ; then
-    symlink "$source_path/dtc/Makefile" "dtc/Makefile"
-fi
 
 config_host_mak="config-host.mak"
 
@@ -6213,7 +6162,6 @@ if test "$guest_agent" = "yes" ; then
   echo "CONFIG_GUEST_AGENT=y" >> $config_host_mak
 fi
 echo "CONFIG_SMBD_COMMAND=\"$smbd\"" >> $config_host_mak
-subdirs=
 if test "$vde" = "yes" ; then
   echo "CONFIG_VDE=y" >> $config_host_mak
   echo "VDE_LIBS=$vde_libs" >> $config_host_mak
@@ -6539,11 +6487,6 @@ fi
 if test "$preadv" = "yes" ; then
   echo "CONFIG_PREADV=y" >> $config_host_mak
 fi
-if test "$fdt" != "no" ; then
-  echo "CONFIG_FDT=y" >> $config_host_mak
-  echo "FDT_CFLAGS=$fdt_cflags" >> $config_host_mak
-  echo "FDT_LIBS=$fdt_ldflags $fdt_libs" >> $config_host_mak
-fi
 if test "$membarrier" = "yes" ; then
   echo "CONFIG_MEMBARRIER=y" >> $config_host_mak
 fi
@@ -7083,14 +7026,10 @@ for target in $target_list; do
     esac
 done
 
-if [ "$fdt" = "git" ]; then
-  subdirs="$subdirs dtc"
-fi
 echo "CONFIG_QEMU_INTERP_PREFIX=$interp_prefix" | sed 's/%M/@0@/' >> $config_host_mak
 if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
-echo "SUBDIRS=$subdirs" >> $config_host_mak
 
 if test "$numa" = "yes"; then
   echo "CONFIG_NUMA=y" >> $config_host_mak
@@ -7269,7 +7208,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
 	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
-	-Dcapstone=$capstone -Dslirp=$slirp \
+	-Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/default-configs/targets/aarch64-softmmu.mak b/default-configs/targets/aarch64-softmmu.mak
index a8c0174fc3..7703127674 100644
--- a/default-configs/targets/aarch64-softmmu.mak
+++ b/default-configs/targets/aarch64-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
+TARGET_NEED_FDT=y
diff --git a/default-configs/targets/arm-softmmu.mak b/default-configs/targets/arm-softmmu.mak
index 9b1a7f37c6..84a98f4818 100644
--- a/default-configs/targets/arm-softmmu.mak
+++ b/default-configs/targets/arm-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
+TARGET_NEED_FDT=y
diff --git a/default-configs/targets/microblaze-softmmu.mak b/default-configs/targets/microblaze-softmmu.mak
index 0b5c78ef00..33f2a00402 100644
--- a/default-configs/targets/microblaze-softmmu.mak
+++ b/default-configs/targets/microblaze-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=microblaze
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_NEED_FDT=y
diff --git a/default-configs/targets/microblazeel-softmmu.mak b/default-configs/targets/microblazeel-softmmu.mak
index dc822219d8..af40391f2f 100644
--- a/default-configs/targets/microblazeel-softmmu.mak
+++ b/default-configs/targets/microblazeel-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=microblaze
 TARGET_SUPPORTS_MTTCG=y
+TARGET_NEED_FDT=y
diff --git a/default-configs/targets/mips64el-softmmu.mak b/default-configs/targets/mips64el-softmmu.mak
index b751ae1bcf..5a52aa4b64 100644
--- a/default-configs/targets/mips64el-softmmu.mak
+++ b/default-configs/targets/mips64el-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_ALIGNED_ONLY=y
+TARGET_NEED_FDT=y
diff --git a/default-configs/targets/ppc-softmmu.mak b/default-configs/targets/ppc-softmmu.mak
index ef69037a2c..f4eef1819a 100644
--- a/default-configs/targets/ppc-softmmu.mak
+++ b/default-configs/targets/ppc-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=ppc
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
+TARGET_NEED_FDT=y
diff --git a/default-configs/targets/ppc64-softmmu.mak b/default-configs/targets/ppc64-softmmu.mak
index 0fde2d02b9..84fbf46be9 100644
--- a/default-configs/targets/ppc64-softmmu.mak
+++ b/default-configs/targets/ppc64-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=ppc
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
+TARGET_NEED_FDT=y
diff --git a/default-configs/targets/riscv32-softmmu.mak b/default-configs/targets/riscv32-softmmu.mak
index 4544e1ae9a..9446d96d13 100644
--- a/default-configs/targets/riscv32-softmmu.mak
+++ b/default-configs/targets/riscv32-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=riscv32
 TARGET_BASE_ARCH=riscv
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-csr.xml gdb-xml/riscv-32bit-virtual.xml
+TARGET_NEED_FDT=y
diff --git a/default-configs/targets/riscv64-softmmu.mak b/default-configs/targets/riscv64-softmmu.mak
index 6ce0b283cf..d809bd666a 100644
--- a/default-configs/targets/riscv64-softmmu.mak
+++ b/default-configs/targets/riscv64-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-csr.xml gdb-xml/riscv-64bit-virtual.xml
+TARGET_NEED_FDT=y
diff --git a/default-configs/targets/rx-softmmu.mak b/default-configs/targets/rx-softmmu.mak
index 2d410e0b0c..0c458b2d07 100644
--- a/default-configs/targets/rx-softmmu.mak
+++ b/default-configs/targets/rx-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=rx
 TARGET_XML_FILES= gdb-xml/rx-core.xml
+TARGET_NEED_FDT=y
diff --git a/meson.build b/meson.build
index 6ee8c3265c..426b73d31f 100644
--- a/meson.build
+++ b/meson.build
@@ -531,11 +531,6 @@ if get_option('vnc').enabled()
                               compile_args: '-DSTRUCT_IOVEC_DEFINED')
   endif
 endif
-fdt = not_found
-if 'CONFIG_FDT' in config_host
-  fdt = declare_dependency(compile_args: config_host['FDT_CFLAGS'].split(),
-                           link_args: config_host['FDT_LIBS'].split())
-endif
 snappy = not_found
 if 'CONFIG_SNAPPY' in config_host
   snappy = declare_dependency(link_args: config_host['SNAPPY_LIBS'].split())
@@ -723,6 +718,7 @@ ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
+fdt_required = []
 foreach target : target_dirs
   config_target = { 'TARGET_NAME': target.split('-')[0] }
   if target.endswith('linux-user')
@@ -774,6 +770,10 @@ foreach target : target_dirs
   config_target += keyval.load('default-configs/targets' / target + '.mak')
   config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
 
+  if 'TARGET_NEED_FDT' in config_target
+    fdt_required += target
+  endif
+
   # Add default keys
   if 'TARGET_BASE_ARCH' not in config_target
     config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
@@ -1041,7 +1041,54 @@ if have_system
   endif
 endif
 
+fdt = not_found
+fdt_opt = get_option('fdt')
+if have_system
+  if fdt_opt in ['enabled', 'auto', 'system']
+    have_internal = fs.exists(meson.current_source_dir() / 'dtc/libfdt/Makefile.libfdt')
+    fdt = cc.find_library('fdt', static: enable_static,
+                          required: fdt_opt == 'system' or
+                                    fdt_opt == 'enabled' and not have_internal)
+    if fdt.found() and cc.links('''
+       #include <libfdt.h>
+       #include <libfdt_env.h>
+       int main(void) { fdt_check_full(NULL, 0); return 0; }''',
+         dependencies: fdt)
+      fdt_opt = 'system'
+    elif have_internal
+      fdt_opt = 'internal'
+    else
+      fdt_opt = 'disabled'
+    endif
+  endif
+  if fdt_opt == 'internal'
+    fdt_files = files(
+      'dtc/libfdt/fdt.c',
+      'dtc/libfdt/fdt_ro.c',
+      'dtc/libfdt/fdt_wip.c',
+      'dtc/libfdt/fdt_sw.c',
+      'dtc/libfdt/fdt_rw.c',
+      'dtc/libfdt/fdt_strerror.c',
+      'dtc/libfdt/fdt_empty_tree.c',
+      'dtc/libfdt/fdt_addresses.c',
+      'dtc/libfdt/fdt_overlay.c',
+      'dtc/libfdt/fdt_check.c',
+    )
+
+    fdt_inc = include_directories('dtc/libfdt')
+    libfdt = static_library('fdt',
+                            sources: fdt_files,
+                            include_directories: fdt_inc)
+    fdt = declare_dependency(link_with: libfdt,
+                             include_directories: fdt_inc)
+  endif
+endif
+if not fdt.found() and fdt_required.length() > 0
+  error('fdt not available but required by targets ' + ', '.join(fdt_required))
+endif
+
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
+config_host_data.set('CONFIG_FDT', fdt.found())
 config_host_data.set('CONFIG_SLIRP', slirp.found())
 
 genh += configure_file(output: 'config-host.h', configuration: config_host_data)
@@ -1311,7 +1358,7 @@ softmmu_ss.add(files(
 
 softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
 softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), seccomp])
-softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
+softmmu_ss.add(when: fdt, if_true: files('device_tree.c'))
 
 common_ss.add(files('cpus-common.c'))
 
@@ -1804,7 +1851,7 @@ endif
 summary_info += {'malloc trim support': has_malloc_trim}
 summary_info += {'RDMA support':      config_host.has_key('CONFIG_RDMA')}
 summary_info += {'PVRDMA support':    config_host.has_key('CONFIG_PVRDMA')}
-summary_info += {'fdt support':       config_host.has_key('CONFIG_FDT')}
+summary_info += {'fdt support':       fdt_opt == 'disabled' ? false : fdt_opt}
 summary_info += {'membarrier':        config_host.has_key('CONFIG_MEMBARRIER')}
 summary_info += {'preadv support':    config_host.has_key('CONFIG_PREADV')}
 summary_info += {'fdatasync':         config_host.has_key('CONFIG_FDATASYNC')}
diff --git a/meson_options.txt b/meson_options.txt
index 8a362fb08d..1d3c94840a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -55,3 +55,6 @@ option('capstone', type: 'combo', value: 'auto',
 option('slirp', type: 'combo', value: 'auto',
        choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
        description: 'Whether and how to find the slirp library')
+option('fdt', type: 'combo', value: 'auto',
+       choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
+       description: 'Whether and how to find the libfdt library')
-- 
2.26.2



