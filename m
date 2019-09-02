Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900EFC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2962173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1dsnpsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2962173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4mzH-00084N-DV
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 10:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1i4mtv-0003Gl-KT
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1i4mts-0007xU-UF
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:01:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1i4mts-0007wC-MY
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:01:44 -0400
Received: by mail-pf1-x443.google.com with SMTP id s12so2047915pfe.6
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8SLfw0/2Ku5X6IRqAPpVCtV652oy7jl6MOg915Zxv4E=;
 b=R1dsnpsSsSwIoD61ydf0yRNTjYBcqapusHTdszGZNkpjLgcgH+Potn8q72FfZ7IPXu
 rQZfnOPLnqAESR8guC2XnWiW6wKCh3oyPDGbaWlsVeksn28zfbck9gsKpaunl7jIcuPC
 u1Um7cuSSkbttXh9cKHNtdlC2m3O2hmrmHQz/kBOcb6hLetvX+ewRSbvRu4FzFl5I2j+
 4qSPND0M/GLsB921tRNbepUrynC3Usal8lLlAEjwMtIjClB4jNwZ6x0ODa6u37417Efl
 eAT9Mubc71HSqbYc6POXYrBLq2f8Euo4er6oV6mkYCNmhI0cc66O+Edrq1LprLK/JEO3
 llnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8SLfw0/2Ku5X6IRqAPpVCtV652oy7jl6MOg915Zxv4E=;
 b=c4Q8CDP3RmqIm50BQkseQlrofPUsr2/6/ZBz3pA2sNaBDcgZ5Dqc+n6hTThspBV8vx
 KXBe0KFcNK2Em38oyHAYbYzq/GcbITzvhCUeZAooqaL4rmJcDYMNu/mVvq0wSo8Y1JI7
 UCe5d4qQlRw3goLCItBouxtNR89Hm4mEvjvPS1g33c5oBP0DMPMWQ+OmuV+CWCdcMRTC
 BI0XQ4F/ObUi3lZ83+lQO6nFB2XJaPHj9ansuJG7F1z4C3inmc1Voqqp+sSSbwC1LD3B
 kRiGEW5ZuTRuVKWZpkAYws7mC78hHNWGNjoHqO5NvYhzFw5MyTr7b9G96p9CdXCOM9Qo
 p8yw==
X-Gm-Message-State: APjAAAWPalI+DN/ME3qpdZm1lmau9w19glBhBH8PFqZDFS1/XLHyauZi
 6ZDx37DsOgTqR8CKhs8hW2hyWz2ITmWA9WLX
X-Google-Smtp-Source: APXvYqx23uSf8rVV3IbR5rNpnfXkYFYziN5aXNDPfmFamnClO/B/+kYzXEbSVKuie8cEDUOtOQ3OmQ==
X-Received: by 2002:a17:90a:983:: with SMTP id 3mr3835750pjo.57.1567432903375; 
 Mon, 02 Sep 2019 07:01:43 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com ([206.81.201.98])
 by smtp.gmail.com with ESMTPSA id v18sm4562020pfn.24.2019.09.02.07.01.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 02 Sep 2019 07:01:42 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  2 Sep 2019 17:01:33 +0300
Message-Id: <20190902140134.74081-8-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190902140134.74081-1-mrolnik@gmail.com>
References: <20190902140134.74081-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v30 7/8] target/avr: Register AVR support with
 the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: thuth@redhat.com, dovgaluk@ispras.ru, richard.henderson@linaro.org,
 Michael Rolnik <mrolnik@gmail.com>, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 MAINTAINERS                     |  6 +++
 arch_init.c                     |  2 +
 configure                       | 93 ++++++++++++++++++---------------
 default-configs/avr-softmmu.mak |  5 ++
 include/disas/dis-asm.h         |  6 +++
 include/sysemu/arch_init.h      |  1 +
 qapi/machine.json               |  3 +-
 target/avr/Makefile.objs        | 33 ++++++++++++
 tests/machine-none-test.c       |  1 +
 9 files changed, 106 insertions(+), 44 deletions(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 target/avr/Makefile.objs

diff --git a/MAINTAINERS b/MAINTAINERS
index ef6c01084b..763370e6ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -163,6 +163,12 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR TCG CPUs
+M: Michael Rolnik <mrolnik@gmail.com>
+S: Maintained
+F: target/avr/
+F: hw/avr/
+
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
diff --git a/arch_init.c b/arch_init.c
index 0a1531124c..fb308aa802 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -85,6 +85,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_UNICORE32
 #elif defined(TARGET_XTENSA)
 #define QEMU_ARCH QEMU_ARCH_XTENSA
+#elif defined(TARGET_AVR)
+#define QEMU_ARCH QEMU_ARCH_AVR
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
diff --git a/configure b/configure
index e44e454c43..b35a7cf214 100755
--- a/configure
+++ b/configure
@@ -2032,7 +2032,7 @@ EOF
 
 if ! compile_prog "-Werror" "" ; then
     error_exit "Your compiler does not support the __thread specifier for " \
-	"Thread-Local Storage (TLS). Please upgrade to a version that does."
+    "Thread-Local Storage (TLS). Please upgrade to a version that does."
 fi
 
 if test "$pie" = ""; then
@@ -2820,7 +2820,7 @@ if test "$gnutls" != "no"; then
         fi
     fi
     if test "$pass" = "no" && test "$gnutls" = "yes"; then
-	feature_not_found "gnutls" "Install gnutls devel >= 3.1.18"
+    feature_not_found "gnutls" "Install gnutls devel >= 3.1.18"
     else
         gnutls="$pass"
     fi
@@ -2852,16 +2852,16 @@ fi
 has_libgcrypt() {
     if ! has "libgcrypt-config"
     then
-	return 1
+    return 1
     fi
 
     if test -n "$cross_prefix"
     then
-	host=$(libgcrypt-config --host)
-	if test "$host-" != $cross_prefix
-	then
-	    return 1
-	fi
+    host=$(libgcrypt-config --host)
+    if test "$host-" != $cross_prefix
+    then
+        return 1
+    fi
     fi
 
     maj=`libgcrypt-config --version | awk -F . '{print $1}'`
@@ -3071,7 +3071,7 @@ EOF
          sdl_cflags="$sdl_cflags $(aalib-config --cflags 2>/dev/null)"
       fi
       if compile_prog "$sdl_cflags" "$sdl_libs" ; then
-	:
+    :
       else
         sdl=no
       fi
@@ -3689,8 +3689,8 @@ EOF
 if ! compile_prog "$CFLAGS" "$LIBS" ; then
     error_exit "sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T."\
                "You probably need to set PKG_CONFIG_LIBDIR"\
-	       "to point to the right pkg-config files for your"\
-	       "build target"
+           "to point to the right pkg-config files for your"\
+           "build target"
 fi
 
 # Silence clang 3.5.0 warnings about glib attribute __alloc_size__ usage
@@ -4200,8 +4200,8 @@ if test "$glusterfs" != "no" ; then
 int
 main(void)
 {
-	/* new glfs_ftruncate() passes two additional args */
-	return glfs_ftruncate(NULL, 0, NULL, NULL);
+    /* new glfs_ftruncate() passes two additional args */
+    return glfs_ftruncate(NULL, 0, NULL, NULL);
 }
 EOF
     if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
@@ -4218,9 +4218,9 @@ glusterfs_iocb(glfs_fd_t *fd, ssize_t ret, struct glfs_stat *prestat, struct glf
 int
 main(void)
 {
-	glfs_io_cbk iocb = &glusterfs_iocb;
-	iocb(NULL, 0 , NULL, NULL, NULL);
-	return 0;
+    glfs_io_cbk iocb = &glusterfs_iocb;
+    iocb(NULL, 0 , NULL, NULL, NULL);
+    return 0;
 }
 EOF
     if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
@@ -4247,8 +4247,8 @@ cat > $TMPC << EOF
 int
 main(void)
 {
-	/* try to start inotify */
-	return inotify_init();
+    /* try to start inotify */
+    return inotify_init();
 }
 EOF
 if compile_prog "" "" ; then
@@ -4921,8 +4921,8 @@ if test "$mingw32" = "yes" && test "$guest_agent" != "no" && \
     *\ *) # The SDK is installed in "Program Files" by default, but we cannot
           # handle path with spaces. So we symlink the headers into ".sdk/vss".
           vss_win32_include="-isystem $source_path/.sdk/vss"
-	  symlink "$vss_win32_sdk/inc" "$source_path/.sdk/vss/inc"
-	  ;;
+      symlink "$vss_win32_sdk/inc" "$source_path/.sdk/vss/inc"
+      ;;
     *)    vss_win32_include="-isystem $vss_win32_sdk"
   esac
   cat > $TMPC << EOF
@@ -5643,7 +5643,7 @@ if test "$membarrier" = "yes"; then
     int main(void) {
         syscall(__NR_membarrier, MEMBARRIER_CMD_QUERY, 0);
         syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0);
-	exit(0);
+    exit(0);
     }
 EOF
         if compile_prog "" "" ; then
@@ -5720,7 +5720,7 @@ if test "$crypto_afalg" = "yes"
 then
     if test "$have_afalg" != "yes"
     then
-	error_exit "AF_ALG requested but could not be detected"
+    error_exit "AF_ALG requested but could not be detected"
     fi
 fi
 
@@ -5908,18 +5908,18 @@ fi
 # check for libpmem
 
 if test "$libpmem" != "no"; then
-	if $pkg_config --exists "libpmem"; then
-		libpmem="yes"
-		libpmem_libs=$($pkg_config --libs libpmem)
-		libpmem_cflags=$($pkg_config --cflags libpmem)
-		libs_softmmu="$libs_softmmu $libpmem_libs"
-		QEMU_CFLAGS="$QEMU_CFLAGS $libpmem_cflags"
-	else
-		if test "$libpmem" = "yes" ; then
-			feature_not_found "libpmem" "Install nvml or pmdk"
-		fi
-		libpmem="no"
-	fi
+    if $pkg_config --exists "libpmem"; then
+        libpmem="yes"
+        libpmem_libs=$($pkg_config --libs libpmem)
+        libpmem_cflags=$($pkg_config --cflags libpmem)
+        libs_softmmu="$libs_softmmu $libpmem_libs"
+        QEMU_CFLAGS="$QEMU_CFLAGS $libpmem_cflags"
+    else
+        if test "$libpmem" = "yes" ; then
+            feature_not_found "libpmem" "Install nvml or pmdk"
+        fi
+        libpmem="no"
+    fi
 fi
 
 ##########################################
@@ -6643,10 +6643,10 @@ echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
     def=CONFIG_AUDIO_$(echo $drv | LC_ALL=C tr '[a-z]' '[A-Z]')
     case "$drv" in
-	alsa | oss | pa | sdl)
-	    echo "$def=m" >> $config_host_mak ;;
-	*)
-	    echo "$def=y" >> $config_host_mak ;;
+    alsa | oss | pa | sdl)
+        echo "$def=m" >> $config_host_mak ;;
+    *)
+        echo "$def=y" >> $config_host_mak ;;
     esac
 done
 echo "ALSA_LIBS=$alsa_libs" >> $config_host_mak
@@ -7479,14 +7479,14 @@ TARGET_ABI_DIR=""
 case "$target_name" in
   i386)
     mttcg="yes"
-	gdb_xml_files="i386-32bit.xml"
+    gdb_xml_files="i386-32bit.xml"
     target_compiler=$cross_cc_i386
     target_compiler_cflags=$cross_cc_ccflags_i386
   ;;
   x86_64)
     TARGET_BASE_ARCH=i386
     mttcg="yes"
-	gdb_xml_files="i386-64bit.xml"
+    gdb_xml_files="i386-64bit.xml"
     target_compiler=$cross_cc_x86_64
   ;;
   alpha)
@@ -7510,6 +7510,10 @@ case "$target_name" in
     target_compiler=$cross_cc_aarch64
     eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
+  avr)
+    gdb_xml_files="avr-cpu.xml"
+    target_compiler=$cross_cc_avr
+  ;;
   cris)
     target_compiler=$cross_cc_cris
   ;;
@@ -7790,6 +7794,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
       disas_config "ARM_A64"
     fi
   ;;
+  avr)
+    disas_config "AVR"
+  ;;
   cris)
     disas_config "CRIS"
   ;;
@@ -8003,10 +8010,10 @@ preserve_env() {
 
     if test -n "$envval"
     then
-	echo "$envname='$envval'" >> config.status
-	echo "export $envname" >> config.status
+    echo "$envname='$envval'" >> config.status
+    echo "export $envname" >> config.status
     else
-	echo "unset $envname" >> config.status
+    echo "unset $envname" >> config.status
     fi
 }
 
diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmmu.mak
new file mode 100644
index 0000000000..d1e1c28118
--- /dev/null
+++ b/default-configs/avr-softmmu.mak
@@ -0,0 +1,5 @@
+# Default configuration for avr-softmmu
+
+# Boards:
+#
+CONFIG_AVR_SAMPLE=y
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index e9c7dd8eb4..8bedce17ac 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -211,6 +211,12 @@ enum bfd_architecture
 #define bfd_mach_m32r          0  /* backwards compatibility */
   bfd_arch_mn10200,    /* Matsushita MN10200 */
   bfd_arch_mn10300,    /* Matsushita MN10300 */
+  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
+#define bfd_mach_avr1          1
+#define bfd_mach_avr2          2
+#define bfd_mach_avr3          3
+#define bfd_mach_avr4          4
+#define bfd_mach_avr5          5
   bfd_arch_cris,       /* Axis CRIS */
 #define bfd_mach_cris_v0_v10   255
 #define bfd_mach_cris_v32      32
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 62c6fe4cf1..893df26ce2 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_AVR = (1 << 20),
 };
 
 extern const uint32_t arch_type;
diff --git a/qapi/machine.json b/qapi/machine.json
index de5c742d72..afede0bc50 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -21,11 +21,12 @@
 #        is true even for "qemu-system-x86_64".
 #
 # ppcemb: dropped in 3.1
+# avr: sicne 4.2
 #
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386', 'lm32',
              'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
new file mode 100644
index 0000000000..2976affd95
--- /dev/null
+++ b/target/avr/Makefile.objs
@@ -0,0 +1,33 @@
+#
+#  QEMU AVR CPU
+#
+#  Copyright (c) 2019 Michael Rolnik
+#
+#  This library is free software; you can redistribute it and/or
+#  modify it under the terms of the GNU Lesser General Public
+#  License as published by the Free Software Foundation; either
+#  version 2.1 of the License, or (at your option) any later version.
+#
+#  This library is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  Lesser General Public License for more details.
+#
+#  You should have received a copy of the GNU Lesser General Public
+#  License along with this library; if not, see
+#  <http://www.gnu.org/licenses/lgpl-2.1.html>
+#
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+decode-y = $(SRC_PATH)/target/avr/insn.decode
+
+target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
+	$(call quiet-command, \
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $<, \
+	  "GEN", $(TARGET_DIR)$@)
+
+target/avr/translate.o: target/avr/decode_insn.inc.c
+
+obj-y += translate.o cpu.o helper.o
+obj-y += gdbstub.o
+obj-$(CONFIG_SOFTMMU) += machine.o
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 5953d31755..3e5c74e73e 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.17.2 (Apple Git-113)


