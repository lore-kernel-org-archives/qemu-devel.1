Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C940DC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7884E20693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAVdojKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7884E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsRQU-0008J5-Qt
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 08:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37291)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hsROM-00052G-FR
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hsROI-0006hX-SW
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:38:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hsROI-0006gw-Hr
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:38:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id p74so56974072wme.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vISeher4eST5pQ8x9FfJ2JLtq30j4leNOmnkMaZNfmA=;
 b=iAVdojKyRwV1qMKw0RA0fWkIHYHjkqjMrGMSZs/X5Ohf9I+F1ppU8UUzWzbGOpl9u7
 +jzK15QMIs7E2/50P89x86ESbjMpSq7VcgirNrGQ9qyqNHvbbipYFp9wdfVyPX4PnFlO
 PlRi6GfljkHLWF3D2Ih/QxtCPpzvKITC/f0Nz16/Zf3JFYLvfYhhMeybBtFxAXSgujRz
 KlllwV4MzN4to+lfveyghBrsEpMKbFiXYDg0AFmGOR9ZM830+ulKQwsRCNxaINOZCcd7
 fiQUMtrYNR44QXq0tut1/eBSLea8nTrSjEreZ5gK91LyWHnMP98/3DQ1+mQ+JlqWDFTX
 10nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vISeher4eST5pQ8x9FfJ2JLtq30j4leNOmnkMaZNfmA=;
 b=aJi1Kl94GvHQZnpqyAiKa+qWAZz4YxGtixvdLMMtZd7FhtNkXeYv39i1lciviOM5n4
 uRUz+4NzM2R8XhCfke8iVsHsmgn+5I26hALw9jecFwHKgmcb1VGT8h2fH+oGjInSlZ1J
 5qDb0MccAMZZjdtpD+/PalEqLxWqweZJefUBxrlSyE1FtRP6TK14X33Lw+02iXsCjvIf
 nVTu+ES3aQRgGGGWWjPRGiZscNmxqFUuH3OsiLsW9R5h+FuTkAkk505ADP87fA+JdYAv
 4339qLE7/Br5wXlDOtkn95PH+rg/2XYxrQqcRI424WostWss/C9+3QRsWQSdhQE3+bNR
 vkMQ==
X-Gm-Message-State: APjAAAUP9YB7lrWGfMIlFgdS01+MwT++DPllhVr5uN83xr3ouhkAr5hd
 3aCKMw8OjvyRwKSq4OhQdU+JafbWugA=
X-Google-Smtp-Source: APXvYqxDRvAbaDmHxZdhtBYC8V5r8M3ppe91VXS+b5pROaPQpA19OD1rLrzEDGXoR+CXR7UPIqtYIg==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr102374216wme.12.1564490284664; 
 Tue, 30 Jul 2019 05:38:04 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id
 j6sm90847995wrx.46.2019.07.30.05.38.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 05:38:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 14:37:59 +0200
Message-Id: <20190730123759.21723-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730123759.21723-1-pbonzini@redhat.com>
References: <20190730123759.21723-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 3/3] tests/tcg: move configuration to a
 sub-shell script
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid the repeated inclusions of config-target.mak, which have
risks of namespace pollution, and instead build minimal configuration
files in a configuration script.  The same configuration files can
also be included in Makefile and Makefile.qemu

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                           |   1 +
 configure                          | 155 +++----------------------
 tests/Makefile.include             |   8 +-
 tests/tcg/Makefile.prereqs         |  18 +--
 tests/tcg/Makefile.qemu            |  51 ++++-----
 tests/tcg/Makefile.target          |   8 +-
 tests/tcg/aarch64/Makefile.include |   8 --
 tests/tcg/alpha/Makefile.include   |   2 -
 tests/tcg/arm/Makefile.include     |   8 --
 tests/tcg/configure.sh             | 228 +++++++++++++++++++++++++++++++++++++
 tests/tcg/cris/Makefile.include    |   6 -
 tests/tcg/hppa/Makefile.include    |   2 -
 tests/tcg/i386/Makefile.include    |   9 --
 tests/tcg/m68k/Makefile.include    |   2 -
 tests/tcg/mips/Makefile.include    |  20 ----
 tests/tcg/ppc/Makefile.include     |  10 --
 tests/tcg/riscv/Makefile.include   |  10 --
 tests/tcg/s390x/Makefile.include   |   2 -
 tests/tcg/sh4/Makefile.include     |   4 -
 tests/tcg/sparc64/Makefile.include |   2 -
 tests/tcg/xtensa/Makefile.include  |  11 --
 21 files changed, 276 insertions(+), 289 deletions(-)
 delete mode 100644 tests/tcg/aarch64/Makefile.include
 delete mode 100644 tests/tcg/alpha/Makefile.include
 delete mode 100644 tests/tcg/arm/Makefile.include
 create mode 100644 tests/tcg/configure.sh
 delete mode 100644 tests/tcg/cris/Makefile.include
 delete mode 100644 tests/tcg/hppa/Makefile.include
 delete mode 100644 tests/tcg/i386/Makefile.include
 delete mode 100644 tests/tcg/m68k/Makefile.include
 delete mode 100644 tests/tcg/mips/Makefile.include
 delete mode 100644 tests/tcg/ppc/Makefile.include
 delete mode 100644 tests/tcg/riscv/Makefile.include
 delete mode 100644 tests/tcg/s390x/Makefile.include
 delete mode 100644 tests/tcg/sh4/Makefile.include
 delete mode 100644 tests/tcg/sparc64/Makefile.include
 delete mode 100644 tests/tcg/xtensa/Makefile.include

diff --git a/Makefile b/Makefile
index ecb788b..e76288a 100644
--- a/Makefile
+++ b/Makefile
@@ -718,6 +718,7 @@ endef
 
 distclean: clean
 	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
+	rm -f tests/tcg/config-*.mak
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f $(SUBDIR_DEVICES_MAK)
 	rm -f po/*.mo tests/qemu-iotests/common.env
diff --git a/configure b/configure
index 714e7fb..b0bd308 100755
--- a/configure
+++ b/configure
@@ -500,22 +500,6 @@ debug_mutex="no"
 libpmem=""
 default_devices="yes"
 
-# cross compilers defaults, can be overridden with --cross-cc-ARCH
-cross_cc_aarch64="aarch64-linux-gnu-gcc"
-cross_cc_aarch64_be="$cross_cc_aarch64"
-cross_cc_cflags_aarch64_be="-mbig-endian"
-cross_cc_arm="arm-linux-gnueabihf-gcc"
-cross_cc_cflags_armeb="-mbig-endian"
-cross_cc_i386="i386-pc-linux-gnu-gcc"
-cross_cc_cflags_i386=""
-cross_cc_ppc="powerpc-linux-gnu-gcc"
-cross_cc_cflags_ppc="-m32"
-cross_cc_ppc64="powerpc-linux-gnu-gcc"
-cross_cc_cflags_ppc64="-m64"
-cross_cc_ppc64le="powerpc64le-linux-gnu-gcc"
-
-enabled_cross_compilers=""
-
 supported_cpu="no"
 supported_os="no"
 bogus_os="no"
@@ -548,9 +532,12 @@ for opt do
   ;;
   --cross-cc-cflags-*) cc_arch=${opt#--cross-cc-flags-}; cc_arch=${cc_arch%%=*}
                       eval "cross_cc_cflags_${cc_arch}=\$optarg"
+                      cross_cc_vars="$cross_cc_vars cross_cc_cflags_${cc_arch}"
   ;;
   --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
+                cc_archs="$cc_archs $cc_arch"
                 eval "cross_cc_${cc_arch}=\$optarg"
+                cross_cc_vars="$cross_cc_vars cross_cc_${cc_arch}"
   ;;
   esac
 done
@@ -745,42 +732,34 @@ ARCH=
 case "$cpu" in
   ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
     supported_cpu="yes"
-    eval "cross_cc_${cpu}=\$host_cc"
   ;;
   ppc64le)
     ARCH="ppc64"
     supported_cpu="yes"
-    cross_cc_ppc64le=$host_cc
   ;;
   i386|i486|i586|i686|i86pc|BePC)
     cpu="i386"
     supported_cpu="yes"
-    cross_cc_i386=$host_cc
   ;;
   x86_64|amd64)
     cpu="x86_64"
     supported_cpu="yes"
-    cross_cc_x86_64=$host_cc
   ;;
   armv*b|armv*l|arm)
     cpu="arm"
     supported_cpu="yes"
-    cross_cc_arm=$host_cc
   ;;
   aarch64)
     cpu="aarch64"
     supported_cpu="yes"
-    cross_cc_aarch64=$host_cc
   ;;
   mips*)
     cpu="mips"
     supported_cpu="yes"
-    cross_cc_mips=$host_cc
   ;;
   sparc|sun4[cdmuv])
     cpu="sparc"
     supported_cpu="yes"
-    cross_cc_sparc=$host_cc
   ;;
   *)
     # This will result in either an error or falling back to TCI later
@@ -1555,44 +1534,30 @@ case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
            LDFLAGS="-m32 $LDFLAGS"
-           cross_cc_ppc=$cc
-           cross_cc_cflags_ppc="$CPU_CFLAGS"
            ;;
     ppc64)
            CPU_CFLAGS="-m64"
            LDFLAGS="-m64 $LDFLAGS"
-           cross_cc_ppc64=$cc
-           cross_cc_cflags_ppc64="$CPU_CFLAGS"
            ;;
     sparc)
            CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
            LDFLAGS="-m32 -mv8plus $LDFLAGS"
-           cross_cc_sparc=$cc
-           cross_cc_cflags_sparc="$CPU_CFLAGS"
            ;;
     sparc64)
            CPU_CFLAGS="-m64 -mcpu=ultrasparc"
            LDFLAGS="-m64 $LDFLAGS"
-           cross_cc_sparc64=$cc
-           cross_cc_cflags_sparc64="$CPU_CFLAGS"
            ;;
     s390)
            CPU_CFLAGS="-m31"
            LDFLAGS="-m31 $LDFLAGS"
-           cross_cc_s390=$cc
-           cross_cc_cflags_s390="$CPU_CFLAGS"
            ;;
     s390x)
            CPU_CFLAGS="-m64"
            LDFLAGS="-m64 $LDFLAGS"
-           cross_cc_s390x=$cc
-           cross_cc_cflags_s390x="$CPU_CFLAGS"
            ;;
     i386)
            CPU_CFLAGS="-m32"
            LDFLAGS="-m32 $LDFLAGS"
-           cross_cc_i386=$cc
-           cross_cc_cflags_i386="$CPU_CFLAGS"
            ;;
     x86_64)
            # ??? Only extremely old AMD cpus do not have cmpxchg16b.
@@ -1600,18 +1565,16 @@ case "$cpu" in
            # runtime and generate the fallback to serial emulation.
            CPU_CFLAGS="-m64 -mcx16"
            LDFLAGS="-m64 $LDFLAGS"
-           cross_cc_x86_64=$cc
-           cross_cc_cflags_x86_64="$CPU_CFLAGS"
            ;;
     x32)
            CPU_CFLAGS="-mx32"
            LDFLAGS="-mx32 $LDFLAGS"
-           cross_cc_i386=$cc
-           cross_cc_cflags_i386="$CPU_CFLAGS"
            ;;
     # No special flags required for other host CPUs
 esac
 
+eval "cross_cc_${cpu}=\$host_cc"
+cross_cc_vars="$cross_cc_vars cross_cc_${cpu}"
 QEMU_CFLAGS="$CPU_CFLAGS $QEMU_CFLAGS"
 
 # For user-mode emulation the host arch has to be one we explicitly
@@ -5894,17 +5857,6 @@ EOF
 fi
 
 ##########################################
-# Docker and cross-compiler support
-#
-# This is specifically for building test
-# cases for foreign architectures, not
-# cross-compiling QEMU itself.
-
-if has "docker"; then
-    docker=$($python $source_path/tests/docker/docker.py probe)
-fi
-
-##########################################
 # check for libpmem
 
 if test "$libpmem" != "no"; then
@@ -6516,6 +6468,12 @@ if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
   echo "warning: Python 3 will be required for building future versions of QEMU" >&2
 fi
 
+(for i in $cross_cc_vars; do
+  export $i
+done
+export target_list source_path
+${SHELL-/bin/sh} $source_path/tests/tcg/configure.sh)
+
 config_host_mak="config-host.mak"
 
 echo "# Automatically generated by configure - do not modify" >config-all-disas.mak
@@ -7388,10 +7346,6 @@ if test "$gcov" = "yes" ; then
   echo "GCOV=$gcov_tool" >> $config_host_mak
 fi
 
-if test "$docker" != "no"; then
-    echo "HAVE_USER_DOCKER=y" >> $config_host_mak
-fi
-
 if test "$libudev" != "no"; then
     echo "CONFIG_LIBUDEV=y" >> $config_host_mak
     echo "LIBUDEV_LIBS=$libudev_libs" >> $config_host_mak
@@ -7460,10 +7414,6 @@ case "$target" in
     ;;
 esac
 
-target_compiler=""
-target_compiler_static=""
-target_compiler_cflags=""
-
 mkdir -p $target_dir
 echo "# Automatically generated by configure - do not modify" > $config_target_mak
 
@@ -7480,26 +7430,20 @@ case "$target_name" in
   i386)
     mttcg="yes"
 	gdb_xml_files="i386-32bit.xml"
-    target_compiler=$cross_cc_i386
-    target_compiler_cflags=$cross_cc_ccflags_i386
   ;;
   x86_64)
     TARGET_BASE_ARCH=i386
     mttcg="yes"
 	gdb_xml_files="i386-64bit.xml"
-    target_compiler=$cross_cc_x86_64
   ;;
   alpha)
     mttcg="yes"
-    target_compiler=$cross_cc_alpha
   ;;
   arm|armeb)
     TARGET_ARCH=arm
     bflt="yes"
     mttcg="yes"
     gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
-    target_compiler=$cross_cc_arm
-    eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
   aarch64|aarch64_be)
     TARGET_ARCH=aarch64
@@ -7507,41 +7451,32 @@ case "$target_name" in
     bflt="yes"
     mttcg="yes"
     gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
-    target_compiler=$cross_cc_aarch64
-    eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
   cris)
-    target_compiler=$cross_cc_cris
   ;;
   hppa)
     mttcg="yes"
-    target_compiler=$cross_cc_hppa
   ;;
   lm32)
-    target_compiler=$cross_cc_lm32
   ;;
   m68k)
     bflt="yes"
     gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
-    target_compiler=$cross_cc_m68k
   ;;
   microblaze|microblazeel)
     TARGET_ARCH=microblaze
     bflt="yes"
     echo "TARGET_ABI32=y" >> $config_target_mak
-    target_compiler=$cross_cc_microblaze
   ;;
   mips|mipsel)
     mttcg="yes"
     TARGET_ARCH=mips
-    target_compiler=$cross_cc_mips
     echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
   ;;
   mipsn32|mipsn32el)
     mttcg="yes"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
-    target_compiler=$cross_cc_mipsn32
     echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
@@ -7549,32 +7484,24 @@ case "$target_name" in
     mttcg="yes"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
-    target_compiler=$cross_cc_mips64
     echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
   ;;
   moxie)
-    target_compiler=$cross_cc_moxie
   ;;
   nios2)
-    target_compiler=$cross_cc_nios2
   ;;
   or1k)
-    target_compiler=$cross_cc_or1k
     TARGET_ARCH=openrisc
     TARGET_BASE_ARCH=openrisc
   ;;
   ppc)
     gdb_xml_files="power-core.xml power-fpu.xml power-altivec.xml power-spe.xml"
-    target_compiler=$cross_cc_ppc
-    target_compiler_cflags="$cross_cc_cflags_ppc"
   ;;
   ppc64)
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
     mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-    target_compiler=$cross_cc_ppc64
-    target_compiler_cflags="$cross_cc_cflags_ppc64"
   ;;
   ppc64le)
     TARGET_ARCH=ppc64
@@ -7582,7 +7509,6 @@ case "$target_name" in
     TARGET_ABI_DIR=ppc
     mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-    target_compiler=$cross_cc_ppc64le
   ;;
   ppc64abi32)
     TARGET_ARCH=ppc64
@@ -7590,60 +7516,48 @@ case "$target_name" in
     TARGET_ABI_DIR=ppc
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-    target_compiler=$cross_cc_ppc64abi32
   ;;
   riscv32)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
     gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml"
-    target_compiler=$cross_cc_riscv32
   ;;
   riscv64)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
     gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
-    target_compiler=$cross_cc_riscv64
   ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
     bflt="yes"
-    target_compiler=$cross_cc_sh4
   ;;
   sparc)
-    target_compiler=$cross_cc_sparc
   ;;
   sparc64)
     TARGET_BASE_ARCH=sparc
-    target_compiler=$cross_cc_sparc64
   ;;
   sparc32plus)
     TARGET_ARCH=sparc64
     TARGET_BASE_ARCH=sparc
     TARGET_ABI_DIR=sparc
-    target_compiler=$cross_cc_sparc32plus
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   s390x)
     mttcg=yes
     gdb_xml_files="s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.xml"
-    target_compiler=$cross_cc_s390x
   ;;
   tilegx)
-    target_compiler=$cross_cc_tilegx
   ;;
   tricore)
-    target_compiler=$cross_cc_tricore
   ;;
   unicore32)
-    target_compiler=$cross_cc_unicore32
   ;;
   xtensa|xtensaeb)
     TARGET_ARCH=xtensa
     bflt="yes"
     mttcg="yes"
-    target_compiler=$cross_cc_xtensa
   ;;
   *)
     error_exit "Unsupported target CPU"
@@ -7654,27 +7568,6 @@ if [ "$TARGET_BASE_ARCH" = "" ]; then
   TARGET_BASE_ARCH=$TARGET_ARCH
 fi
 
-# Do we have a cross compiler for this target?
-if has $target_compiler; then
-
-    write_c_skeleton
-
-    if ! do_compiler "$target_compiler" $target_compiler_cflags -o $TMPE $TMPC -static ; then
-        # For host systems we might get away with building without -static
-        if ! do_compiler "$target_compiler" $target_compiler_cflags -o $TMPE $TMPC ; then
-            target_compiler=""
-        else
-            enabled_cross_compilers="${enabled_cross_compilers} '${target_compiler}'"
-            target_compiler_static="n"
-        fi
-    else
-        enabled_cross_compilers="${enabled_cross_compilers} '${target_compiler}'"
-        target_compiler_static="y"
-    fi
-else
-    target_compiler=""
-fi
-
 symlink "$source_path/Makefile.target" "$target_dir/Makefile"
 
 upper() {
@@ -7748,18 +7641,6 @@ if test "$target_bsd_user" = "yes" ; then
   echo "CONFIG_BSD_USER=y" >> $config_target_mak
 fi
 
-if test -n "$target_compiler"; then
-  echo "CROSS_CC_GUEST=\"$target_compiler\"" >> $config_target_mak
-
-  if test -n "$target_compiler_static"; then
-      echo "CROSS_CC_GUEST_STATIC=$target_compiler_static" >> $config_target_mak
-  fi
-
-  if test -n "$target_compiler_cflags"; then
-      echo "CROSS_CC_GUEST_CFLAGS=$target_compiler_cflags" >> $config_target_mak
-  fi
-fi
-
 
 # generate QEMU_CFLAGS/LDFLAGS for targets
 
@@ -7890,11 +7771,6 @@ done # for target in $targets
 echo "PIXMAN_CFLAGS=$pixman_cflags" >> $config_host_mak
 echo "PIXMAN_LIBS=$pixman_libs" >> $config_host_mak
 
-if test -n "$enabled_cross_compilers"; then
-    echo
-    echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
-fi
-
 if [ "$fdt" = "git" ]; then
   echo "config-host.h: dtc/all" >> $config_host_mak
 fi
@@ -7923,15 +7799,14 @@ fi
 # so the build tree will be missing the link back to the new file, and
 # tests might fail. Prefer to keep the relevant files in their own
 # directory and symlink the directory instead.
-DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
+DIRS="tests tests/tcg tests/tcg/lm32 tests/libqos tests/qapi-schema tests/qemu-iotests tests/vm"
 DIRS="$DIRS tests/fp tests/qgraph"
 DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
-LINKS="Makefile tests/tcg/Makefile"
-LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
-LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
-LINKS="$LINKS tests/fp/Makefile"
+LINKS="Makefile"
+LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
+LINKS="$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/spapr-rtas/Makefile"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8bb5c97..a3ee649 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1058,30 +1058,28 @@ BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
 CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(TARGET_DIRS))
 RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
 
-ifeq ($(HAVE_USER_DOCKER),y)
 # Probe for the Docker Builds needed for each build
 $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
 	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
-endif
 
 build-tcg-tests-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) \
-	       	V="$(V)" TARGET_DIR="$*/" guest-tests, \
+	       	V="$(V)" TARGET="$*" guest-tests, \
 		"BUILD", "TCG tests for $*")
 
 run-tcg-tests-%: build-tcg-tests-% %/all
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) SPEED="$(SPEED)" \
-		V="$(V)" TARGET_DIR="$*/" run-guest-tests, \
+		V="$(V)" TARGET="$*" run-guest-tests, \
 		"RUN", "TCG tests for $*")
 
 clean-tcg-tests-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
-		SRC_PATH=$(SRC_PATH) TARGET_DIR="$*/" clean-guest-tests, \
+		SRC_PATH=$(SRC_PATH) TARGET="$*" clean-guest-tests, \
 		"RUN", "TCG tests for $*")
 
 .PHONY: build-tcg
diff --git a/tests/tcg/Makefile.prereqs b/tests/tcg/Makefile.prereqs
index 53b0196..7494b31 100644
--- a/tests/tcg/Makefile.prereqs
+++ b/tests/tcg/Makefile.prereqs
@@ -7,24 +7,12 @@
 # selection of required docker targets before we invoke a sub-make for
 # each target.
 
-# First we need the target makefile which tells us the target architecture
-CROSS_CC_GUEST:=
--include $(BUILD_DIR)/$(PROBE_TARGET)/config-target.mak
-
-# Then we load up the target architecture makefiles which tell us
-# about the compilers
 DOCKER_IMAGE:=
 
--include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
--include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
+-include $(BUILD_DIR)/tests/tcg/config-$(PROBE_TARGET).mak
 
-ifndef CROSS_CC_GUEST
 ifneq ($(DOCKER_IMAGE),)
 build-tcg-tests-$(PROBE_TARGET): docker-image-$(DOCKER_IMAGE)
+$(BUILD_DIR)/tests/tcg/config_$(PROBE_TARGET).mak: config-host.mak
+config-host.mak: $(SRC_PATH)/tests/tcg/configure.sh
 endif
-endif
-
-# Clean-up
-# undefine TARGET_NAME
-# undefine TARGET_BASE_ARCH
-# undefine TARGET_ABI_DIR
diff --git a/tests/tcg/Makefile.qemu b/tests/tcg/Makefile.qemu
index d3f3437..c8bec7b 100644
--- a/tests/tcg/Makefile.qemu
+++ b/tests/tcg/Makefile.qemu
@@ -8,17 +8,22 @@
 # to do it for us.
 #
 
-# The per ARCH makefile, if it exists, holds extra information about
+include $(SRC_PATH)/rules.mak
+
+# The configure script fills in extra information about
 # useful docker images or alternative compiler flags.
 
-include $(TARGET_DIR)config-target.mak
-include $(SRC_PATH)/rules.mak
-include $(wildcard \
-	$(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include \
-	$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include)
+CROSS_CC_GUEST:=
+DOCKER_IMAGE:=
+-include $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak
 
 GUEST_BUILD=
 TCG_MAKE=../Makefile.target
+
+# We also need the Docker make rules to depend on
+SKIP_DOCKER_BUILD=1
+include $(SRC_PATH)/tests/docker/Makefile.include
+
 # Support installed Cross Compilers
 
 ifdef CROSS_CC_GUEST
@@ -26,11 +31,11 @@ ifdef CROSS_CC_GUEST
 .PHONY: cross-build-guest-tests
 cross-build-guest-tests:
 	$(call quiet-command, \
-	   (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
-	    $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" CC="$(CROSS_CC_GUEST)" \
+	   (mkdir -p tests/tcg/$(TARGET) && cd tests/tcg/$(TARGET) && \
+	    $(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" CC="$(CROSS_CC_GUEST)" \
 			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
-			EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
-	"BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
+			EXTRA_CFLAGS="$(CROSS_CC_GUEST_CFLAGS)"), \
+	"BUILD","$(TARGET) guest-tests with $(CROSS_CC_GUEST)")
 
 GUEST_BUILD=cross-build-guest-tests
 
@@ -38,31 +43,25 @@ endif
 
 # Support building with Docker
 
-ifeq ($(HAVE_USER_DOCKER)$(GUEST_BUILD),y)
 ifneq ($(DOCKER_IMAGE),)
 
-# We also need the Docker make rules to depend on
-SKIP_DOCKER_BUILD=1
-include $(SRC_PATH)/tests/docker/Makefile.include
-
 DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
-		--cc $(DOCKER_CROSS_COMPILER) \
+		--cc $(DOCKER_CROSS_CC_GUEST) \
 		-i qemu:$(DOCKER_IMAGE) \
 		-s $(SRC_PATH) -- "
 
 .PHONY: docker-build-guest-tests
 docker-build-guest-tests: docker-image-$(DOCKER_IMAGE)
 	$(call quiet-command, \
-	  (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
-	   $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" CC=$(DOCKER_COMPILE_CMD) \
+	  (mkdir -p tests/tcg/$(TARGET) && cd tests/tcg/$(TARGET) && \
+	   $(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" CC=$(DOCKER_COMPILE_CMD) \
 			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=y \
-			EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
-	"BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
+			EXTRA_CFLAGS="$(CROSS_CC_GUEST_CFLAGS)"), \
+	"BUILD","$(TARGET) guest-tests with docker qemu:$(DOCKER_IMAGE)")
 
 GUEST_BUILD=docker-build-guest-tests
 
 endif
-endif
 
 # Final targets
 all:
@@ -75,22 +74,22 @@ guest-tests: $(GUEST_BUILD)
 
 run-guest-tests: guest-tests
 	$(call quiet-command, \
-	(cd tests/tcg/$(TARGET_DIR) && \
-	 $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" \
+	(cd tests/tcg/$(TARGET) && \
+	 $(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" \
 	 		SRC_PATH="$(SRC_PATH)" SPEED=$(SPEED) run), \
 	"RUN", "tests for $(TARGET_NAME)")
 
 else
 guest-tests:
 	$(call quiet-command, /bin/true, "BUILD", \
-		"$(TARGET_DIR) guest-tests SKIPPED")
+		"$(TARGET) guest-tests SKIPPED")
 
 run-guest-tests:
 	$(call quiet-command, /bin/true, "RUN", \
-		"tests for $(TARGET_DIR) SKIPPED")
+		"tests for $(TARGET) SKIPPED")
 endif
 
 # It doesn't matter if these don't exits
 .PHONY: clean-guest-tests
 clean-guest-tests:
-	rm -rf tests/tcg/$(TARGET_DIR)
+	rm -rf tests/tcg/$(TARGET)
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8dbcba4..8808bea 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -31,7 +31,7 @@
 
 all:
 -include ../../config-host.mak
--include ../../../$(TARGET_DIR)/config-target.mak
+-include ../config-$(TARGET).mak
 
 # for including , in command strings
 COMMA := ,
@@ -63,12 +63,6 @@ CFLAGS=
 QEMU_CFLAGS=
 LDFLAGS=
 
-# The QEMU for this TARGET
-ifdef CONFIG_USER_ONLY
-QEMU=../../../$(TARGET_DIR)/qemu-$(TARGET_NAME)
-else
-QEMU=../../../$(TARGET_DIR)/qemu-system-$(TARGET_NAME)
-endif
 QEMU_OPTS=
 
 
diff --git a/tests/tcg/aarch64/Makefile.include b/tests/tcg/aarch64/Makefile.include
deleted file mode 100644
index 5d4e4c6..0000000
--- a/tests/tcg/aarch64/Makefile.include
+++ /dev/null
@@ -1,8 +0,0 @@
-# Makefile.include for AArch64 targets
-#
-# We don't have any bigendian build tools so we only use this for AArch64
-
-ifeq ($(TARGET_NAME),aarch64)
-DOCKER_IMAGE=debian-buster-arm64-cross
-DOCKER_CROSS_COMPILER=aarch64-linux-gnu-gcc
-endif
diff --git a/tests/tcg/alpha/Makefile.include b/tests/tcg/alpha/Makefile.include
deleted file mode 100644
index c7dc48e..0000000
--- a/tests/tcg/alpha/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-alpha-cross
-DOCKER_CROSS_COMPILER=alpha-linux-gnu-gcc
diff --git a/tests/tcg/arm/Makefile.include b/tests/tcg/arm/Makefile.include
deleted file mode 100644
index 8e7eac0..0000000
--- a/tests/tcg/arm/Makefile.include
+++ /dev/null
@@ -1,8 +0,0 @@
-# Makefile.include for all ARM targets
-#
-# We don't have any bigendian build tools so we only use this for armhf
-
-ifeq ($(TARGET_NAME),arm)
-DOCKER_IMAGE=debian-armhf-cross
-DOCKER_CROSS_COMPILER=arm-linux-gnueabihf-gcc
-endif
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
new file mode 100644
index 0000000..5a8f52e
--- /dev/null
+++ b/tests/tcg/configure.sh
@@ -0,0 +1,228 @@
+#!/bin/sh
+
+if test -z "$source_path"; then
+  echo Do not invoke this script directly.  It is called
+  echo automatically by configure.
+  exit 1
+fi
+
+write_c_skeleton() {
+    cat > $TMPC <<EOF
+int main(void) { return 0; }
+EOF
+}
+
+has() {
+  command -v "$1" >/dev/null 2>&1
+}
+
+do_compiler() {
+  # Run the compiler, capturing its output to the log. First argument
+  # is compiler binary to execute.
+  local compiler="$1"
+  shift
+  if test -n "$BASH_VERSION"; then eval '
+      echo >>config.log "
+funcs: ${FUNCNAME[*]}
+lines: ${BASH_LINENO[*]}"
+  '; fi
+  echo $compiler "$@" >> config.log
+  $compiler "$@" >> config.log 2>&1 || return $?
+}
+
+
+TMPDIR1="config-temp"
+TMPC="${TMPDIR1}/qemu-conf.c"
+TMPE="${TMPDIR1}/qemu-conf.exe"
+
+if has docker; then
+  docker=$($python $source_path/tests/docker/docker.py probe)
+fi
+
+# cross compilers defaults, can be overridden with --cross-cc-ARCH
+: ${cross_cc_aarch64="aarch64-linux-gnu-gcc"}
+: ${cross_cc_aarch64_be="$cross_cc_aarch64"}
+: ${cross_cc_cflags_aarch64_be="-mbig-endian"}
+: ${cross_cc_arm="arm-linux-gnueabihf-gcc"}
+: ${cross_cc_cflags_armeb="-mbig-endian"}
+: ${cross_cc_i386="i386-pc-linux-gnu-gcc"}
+: ${cross_cc_cflags_i386="-m32"}
+: ${cross_cc_x86_64="x86_64-pc-linux-gnu-gcc"}
+: ${cross_cc_cflags_x86_64="-m64"}
+: ${cross_cc_ppc="powerpc-linux-gnu-gcc"}
+: ${cross_cc_cflags_ppc="-m32"}
+: ${cross_cc_ppc64="powerpc-linux-gnu-gcc"}
+: ${cross_cc_cflags_ppc64="-m64"}
+: ${cross_cc_ppc64le="powerpc64le-linux-gnu-gcc"}
+: ${cross_cc_cflags_s390x="-m64"}
+: ${cross_cc_cflags_sparc="-m32 -mv8plus -mcpu=ultrasparc"}
+: ${cross_cc_cflags_sparc64="-m64 -mcpu=ultrasparc"}
+
+for target in $target_list; do
+  arch=${target%%-*}
+  case $arch in
+    arm|armeb)
+      arches=arm
+      ;;
+    aarch64|aarch64_be)
+      arches="aarch64 arm"
+      ;;
+    mips*)
+      arches=mips
+      ;;
+    ppc*)
+      arches=ppc
+      ;;
+    sh4|sh4eb)
+      arches=sh4
+      ;;
+    x86_64)
+      arches="x86_64 i386"
+      ;;
+    xtensa|xtensaeb)
+      arches=xtensa
+      ;;
+    alpha|cris|hppa|i386|lm32|m68k|openrisc|riscv64|s390x|sh4|sparc64)
+      arches=$target
+      ;;
+    *)
+      continue
+      ;;
+  esac
+
+  docker_image=
+  case $target in
+    aarch64-*)
+      # We don't have any bigendian build tools so we only use this for AArch64
+      docker_image=debian-buster-arm64-cross
+      docker_cross_cc=aarch64-linux-gnu-gcc
+      ;;
+    alpha-*)
+      docker_image=debian-alpha-cross
+      docker_cross_cc=alpha-linux-gnu-gcc
+      ;;
+    arm-*)
+      # We don't have any bigendian build tools so we only use this for AArch64
+      docker_image=debian-armhf-cross
+      docker_cross_cc=arm-linux-gnueabihf-gcc
+      ;;
+    cris-*)
+      docker_image=fedora-cris-cross
+      docker_cross_cc=cris-linux-gnu-gcc
+      ;;
+    hppa-*)
+      docker_image=debian-hppa-cross
+      docker_cross_cc=hppa-linux-gnu-gcc
+      ;;
+    i386-*)
+      docker_image=fedora-i386-cross
+      docker_cross_cc=gcc
+      ;;
+    m68k-*)
+      docker_image=debian-m68k-cross
+      docker_cross_cc=m68k-linux-gnu-gcc
+      ;;
+    mips64el-*)
+      docker_image=debian-mips64el-cross
+      docker_cross_cc=mips64el-linux-gnuabi64-gcc
+      ;;
+    mips64-*)
+      docker_image=debian-mips64-cross
+      docker_cross_cc=mips64-linux-gnuabi64-gcc
+      ;;
+    mipsel-*)
+      docker_image=debian-mipsel-cross
+      docker_cross_cc=mipsel-linux-gnu-gcc
+      ;;
+    mips-*)
+      docker_image=debian-mips-cross
+      docker_cross_cc=mips-linux-gnu-gcc
+      ;;
+    ppc-*)
+      docker_image=debian-powerpc-cross
+      docker_cross_cc=powerpc-linux-gnu-gcc
+      ;;
+    ppc64-*)
+      docker_image=debian-ppc64-cross
+      docker_cross_cc=powerpc64-linux-gnu-gcc
+      ;;
+    ppc64le-*)
+      docker_image=debian-ppc64el-cross
+      docker_cross_cc=powerpc64le-linux-gnu-gcc
+      ;;
+    riscv64-*)
+      docker_image=debian-riscv64-cross
+      docker_cross_cc=riscv64-linux-gnu-gcc
+      ;;
+    s390x-*)
+      docker_image=debian-s390x-cross
+      docker_cross_cc=s390x-linux-gnu-gcc
+      ;;
+    sh4-*)
+      docker_image=debian-sh4-cross
+      docker_cross_cc=sh4-linux-gnu-gcc
+      ;;
+    sparc64-*)
+      docker_image=debian-sparc64-cross
+      docker_cross_cc=sparc64-linux-gnu-gcc
+      ;;
+    xtensa*-softmmu)
+      docker_image=debian-xtensa-cross
+
+      # default to the dc232b cpu
+      docker_cross_cc=/opt/2018.02/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-gcc
+      ;;
+  esac
+
+  config_target_mak=tests/tcg/config-$target.mak
+
+  echo "# Automatically generated by configure - do not modify" > $config_target_mak
+  echo "TARGET_NAME=$arch" >> $config_target_mak
+  case $target in
+    *-linux-user | *-bsd-user)
+      echo "CONFIG_USER_ONLY=y" >> $config_target_mak
+      echo "QEMU=\$(BUILD_DIR)/$target/qemu-$arch" >> $config_target_mak
+      ;;
+    *-softmmu)
+      echo "CONFIG_SOFTMMU=y" >> $config_target_mak
+      echo "QEMU=\$(BUILD_DIR)/$target/qemu-system-$arch" >> $config_target_mak
+      ;;
+  esac
+
+  eval "target_compiler_cflags=\${cross_cc_cflags_$arch}"
+  echo "CROSS_CC_GUEST_CFLAGS=$target_compiler_cflags" >> $config_target_mak
+
+  got_cross_cc=no
+  for i in $arch $arches; do
+    if eval test "x\${cross_cc_$i+yes}" != xyes; then
+      continue
+    fi
+
+    eval "target_compiler=\${cross_cc_$i}"
+    if ! has $target_compiler; then
+      continue
+    fi
+    write_c_skeleton
+    if ! do_compiler "$target_compiler" $target_compiler_cflags -o $TMPE $TMPC -static ; then
+      # For host systems we might get away with building without -static
+      if ! do_compiler "$target_compiler" $target_compiler_cflags -o $TMPE $TMPC ; then
+        continue
+      fi
+      echo "CROSS_CC_GUEST_STATIC=y" >> $config_target_mak
+    fi
+    echo "CROSS_CC_GUEST=$target_compiler" >> $config_target_mak
+    enabled_cross_compilers="$enabled_cross_compilers $target_compiler"
+    got_cross_cc=yes
+    break
+  done
+
+  if test $got_cross_cc = no && test "$docker" != no && test -n "$docker_image"; then
+    echo "DOCKER_IMAGE=$docker_image" >> $config_target_mak
+    echo "DOCKER_CROSS_CC_GUEST=$docker_cross_cc" >> $config_target_mak
+  fi
+done
+
+if test -n "$enabled_cross_compilers"; then
+    echo
+    echo "NOTE: guest cross-compilers enabled:$enabled_cross_compilers"
+fi
diff --git a/tests/tcg/cris/Makefile.include b/tests/tcg/cris/Makefile.include
deleted file mode 100644
index 1c03782..0000000
--- a/tests/tcg/cris/Makefile.include
+++ /dev/null
@@ -1,6 +0,0 @@
-#
-# Makefile.include for all CRIS targets
-#
-
-DOCKER_IMAGE=fedora-cris-cross
-DOCKER_CROSS_COMPILER=cris-linux-gnu-gcc
diff --git a/tests/tcg/hppa/Makefile.include b/tests/tcg/hppa/Makefile.include
deleted file mode 100644
index da23534..0000000
--- a/tests/tcg/hppa/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-hppa-cross
-DOCKER_CROSS_COMPILER=hppa-linux-gnu-gcc
diff --git a/tests/tcg/i386/Makefile.include b/tests/tcg/i386/Makefile.include
deleted file mode 100644
index be1c300..0000000
--- a/tests/tcg/i386/Makefile.include
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# Makefile.include for all i386
-#
-# There is enough brokeness in x86_64 compilers that we don't default
-# to using the x86_64 system compiler for i386 binaries.
-#
-
-DOCKER_IMAGE=fedora-i386-cross
-DOCKER_CROSS_COMPILER=gcc
diff --git a/tests/tcg/m68k/Makefile.include b/tests/tcg/m68k/Makefile.include
deleted file mode 100644
index cd7c6bf..0000000
--- a/tests/tcg/m68k/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-m68k-cross
-DOCKER_CROSS_COMPILER=m68k-linux-gnu-gcc
diff --git a/tests/tcg/mips/Makefile.include b/tests/tcg/mips/Makefile.include
deleted file mode 100644
index 4a14fc0..0000000
--- a/tests/tcg/mips/Makefile.include
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# Makefile.include for all MIPs targets
-#
-# As Debian doesn't support mip64 in big endian mode the only way to
-# build BE is to pass a working cross compiler to ./configure
-#
-
-ifeq ($(TARGET_NAME),mips64el)
-DOCKER_IMAGE=debian-mips64el-cross
-DOCKER_CROSS_COMPILER=mips64el-linux-gnuabi64-gcc
-else ifeq ($(TARGET_NAME),mips64)
-DOCKER_IMAGE=debian-mips64-cross
-DOCKER_CROSS_COMPILER=mips64-linux-gnuabi64-gcc
-else ifeq ($(TARGET_NAME),mipsel)
-DOCKER_IMAGE=debian-mipsel-cross
-DOCKER_CROSS_COMPILER=mipsel-linux-gnu-gcc
-else ifeq ($(TARGET_NAME),mips)
-DOCKER_IMAGE=debian-mips-cross
-DOCKER_CROSS_COMPILER=mips-linux-gnu-gcc
-endif
diff --git a/tests/tcg/ppc/Makefile.include b/tests/tcg/ppc/Makefile.include
deleted file mode 100644
index ae01fb8..0000000
--- a/tests/tcg/ppc/Makefile.include
+++ /dev/null
@@ -1,10 +0,0 @@
-ifeq ($(TARGET_NAME),ppc)
-DOCKER_IMAGE=debian-powerpc-cross
-DOCKER_CROSS_COMPILER=powerpc-linux-gnu-gcc
-else ifeq ($(TARGET_NAME),ppc64)
-DOCKER_IMAGE=debian-ppc64-cross
-DOCKER_CROSS_COMPILER=powerpc64-linux-gnu-gcc
-else ifeq ($(TARGET_NAME),ppc64le)
-DOCKER_IMAGE=debian-ppc64el-cross
-DOCKER_CROSS_COMPILER=powerpc64le-linux-gnu-gcc
-endif
diff --git a/tests/tcg/riscv/Makefile.include b/tests/tcg/riscv/Makefile.include
deleted file mode 100644
index d92ac6c..0000000
--- a/tests/tcg/riscv/Makefile.include
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Makefile.include for all RISCV targets
-#
-# Debian only really cares about 64 bit going forward
-#
-
-ifeq ($(TARGET_NAME),riscv64)
-DOCKER_IMAGE=debian-riscv64-cross
-DOCKER_CROSS_COMPILER=riscv64-linux-gnu-gcc
-endif
diff --git a/tests/tcg/s390x/Makefile.include b/tests/tcg/s390x/Makefile.include
deleted file mode 100644
index 1f58115..0000000
--- a/tests/tcg/s390x/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-s390x-cross
-DOCKER_CROSS_COMPILER=s390x-linux-gnu-gcc
diff --git a/tests/tcg/sh4/Makefile.include b/tests/tcg/sh4/Makefile.include
deleted file mode 100644
index ad21594..0000000
--- a/tests/tcg/sh4/Makefile.include
+++ /dev/null
@@ -1,4 +0,0 @@
-ifneq ($(TARGET_NAME), sh4eb)
-DOCKER_IMAGE=debian-sh4-cross
-DOCKER_CROSS_COMPILER=sh4-linux-gnu-gcc
-endif
diff --git a/tests/tcg/sparc64/Makefile.include b/tests/tcg/sparc64/Makefile.include
deleted file mode 100644
index 95fc8de..0000000
--- a/tests/tcg/sparc64/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-sparc64-cross
-DOCKER_CROSS_COMPILER=sparc64-linux-gnu-gcc
diff --git a/tests/tcg/xtensa/Makefile.include b/tests/tcg/xtensa/Makefile.include
deleted file mode 100644
index 423c00a..0000000
--- a/tests/tcg/xtensa/Makefile.include
+++ /dev/null
@@ -1,11 +0,0 @@
-# Makefile.include for xtensa targets
-#
-# The compilers can only be used for building system tests
-
-ifeq ($(CONFIG_SOFTMMU),y)
-DOCKER_IMAGE=debian-xtensa-cross
-
-# default to the dc232b cpu
-DOCKER_CROSS_COMPILER=/opt/2018.02/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-gcc
-DOCKER_CROSS_LINKER=/opt/2018.02/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-ld
-endif
-- 
1.8.3.1


