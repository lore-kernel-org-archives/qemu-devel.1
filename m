Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02A5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568D22077B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4q7/8BP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568D22077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3KB-0005GT-DN
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if3Gf-00021r-Go
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if3Gd-0005OW-CZ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:47:09 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:33915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if3Gb-0005JX-CG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:47:06 -0500
Received: by mail-wm1-x336.google.com with SMTP id f4so1370422wmj.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 06:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FtXOjnrklkvgY+YgghuBWxOUjW2j0duT4sqo5ka/V5k=;
 b=g4q7/8BPFVqIlCY9xgotqUb82YdXZoudAfj7+I2LvvwUckVYOyo2HXcZPrjV+qyiNU
 ze9VWYM1hI8zogbINXRWDXhtzfxLUDYHcTwu2DpGTSlYayiPFp/WFV/dNmbjX4k7tRGi
 Zd3jL0AcQy6ugWEfFjgjhnzG84J2EHw7xdNRR1yzm8bqA+I15I/TvAdiYxsgMAy5v5kV
 BvTmEk8sFAhIioP8zWbC/9QPp0DM57WVDgAPA9O29aTpjMsUOUxyrt/HpK8WcWO5X8n2
 tF5Ldy8QKqRv9Lm2pmVEg7cHK+onJKi+BTfowcMbpXcMxdXMK/9dmwWFVV3QqGG8A+Um
 EGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=FtXOjnrklkvgY+YgghuBWxOUjW2j0duT4sqo5ka/V5k=;
 b=QkywdiJn10JB8w05ycrzIXA2lFq7aP/qEL53YJjdpKe5YCx/Mks/gDy4XU6vNbXiYL
 XNvUOBf9RqyePazh8vlI+Sfi0vzp2hq+DOCQpmqgcnOTHFadRcvI+T/9srOV476fidtR
 feyG3k0PNgW1LKgKCVdIyZmI1p29FqnrU5algdFOhK88Yf6hRpFh7mukQKojK5Rkho+q
 eWu0kl5GF9oD0B0BJX+3OkI5tPi9m+Q9SEWdHTC613+NitMCyOyVNU4MUZpOVmN0R9bU
 UwYysEUarhts5rJzITceFiABsLljm5y7zFJDyReVe133x9Zv5uP7p5zy1Oy2xhBowrfE
 UMDA==
X-Gm-Message-State: APjAAAWDEjXXDK2gWvM1JCqEg/1jwkGJqn9lebeaxU5Y8Y7VT2ox3i0+
 AAPB4u/Lgnr1E/bsrEK1LQbHq+E/
X-Google-Smtp-Source: APXvYqzate1zezsOIxboc2y7Xp9O4PXpIenWhE2CoegtGgt4wwohZeQ3qGkRvurgwmA5zgxYgBuJLg==
X-Received: by 2002:a1c:99d4:: with SMTP id b203mr120009wme.169.1576075620705; 
 Wed, 11 Dec 2019 06:47:00 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c9sm2439809wmc.47.2019.12.11.06.46.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:47:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] build-sys: clean up flags included in the linker command line
Date: Wed, 11 Dec 2019 15:46:59 +0100
Message-Id: <1576075619-53005-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the CFLAGS that are discovered during configure, for example
compiler warnings, are being included on the linker command line because
QEMU_CFLAGS is added to it.  Other flags, such as the -m32, appear twice
because they are included in both QEMU_CFLAGS and LDFLAGS.  All this
leads to confusion with respect to what goes in which Makefile variables
(and we have plenty).

So, introduce QEMU_LDFLAGS for flags discovered by configure, following
the lead of QEMU_CFLAGS, and stop adding to it:

1) options that are already in CFLAGS, for example "-g"

2) duplicate options

At the same time, options that _are_ needed by both compiler and linker
must now be added to both QEMU_CFLAGS and QEMU_LDFLAGS, which is clearer.
This is mostly -fsanitize options.

Meson will not include CFLAGS on the linker command line, do the same in our
build system as well.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml                 |  4 +--
 Makefile                    |  4 +--
 configure                   | 60 ++++++++++++++++++++++-----------------------
 qga/vss-win32/Makefile.objs |  4 +--
 rules.mak                   |  4 +--
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index d3a12ae..186738d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -193,7 +193,7 @@ matrix:
       compiler: clang
       before_script:
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" --extra-ldflags="-fsanitize=undefined" || { cat config.log && exit 1; }
 
 
     - env:
@@ -325,7 +325,7 @@ matrix:
         - TEST_CMD=""
       before_script:
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-g3 -O0 -Wno-error=stringop-truncation -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-g3 -O0 -Wno-error=stringop-truncation -fsanitize=thread" --extra-ldflags="-fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
 
 
     # Run check-tcg against linux-user
diff --git a/Makefile b/Makefile
index 96e69dd..df92220 100644
--- a/Makefile
+++ b/Makefile
@@ -487,7 +487,7 @@ DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
 
 .PHONY: dtc/all
 dtc/all: .git-submodule-status dtc/libfdt dtc/tests
-	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
+	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
 
 dtc/%: .git-submodule-status
 	@mkdir -p $@
@@ -514,7 +514,7 @@ slirp/all: .git-submodule-status
 		BUILD_DIR="$(BUILD_DIR)/slirp" 			\
 		PKG_CONFIG="$(PKG_CONFIG)" 				\
 		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
-		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
+		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
 
 # Compatibility gunk to keep make working across the rename of targets
 # for recursion, to be removed some time after 4.1.
diff --git a/configure b/configure
index 19b209a..7f96279 100755
--- a/configure
+++ b/configure
@@ -126,7 +126,7 @@ compile_object() {
 compile_prog() {
   local_cflags="$1"
   local_ldflags="$2"
-  do_cc $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $LDFLAGS $local_ldflags
+  do_cc $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $QEMU_LDFLAGS $local_ldflags
 }
 
 # symbolically link $1 to $2.  Portable version of "ln -sf".
@@ -526,7 +526,7 @@ for opt do
   ;;
   --extra-cxxflags=*) QEMU_CXXFLAGS="$QEMU_CXXFLAGS $optarg"
   ;;
-  --extra-ldflags=*) LDFLAGS="$LDFLAGS $optarg"
+  --extra-ldflags=*) QEMU_LDFLAGS="$QEMU_LDFLAGS $optarg"
                      EXTRA_LDFLAGS="$optarg"
   ;;
   --enable-debug-info) debug_info="yes"
@@ -599,7 +599,6 @@ QEMU_INCLUDES="-iquote . -iquote \$(SRC_PATH) -iquote \$(SRC_PATH)/accel/tcg -iq
 QEMU_INCLUDES="$QEMU_INCLUDES -iquote \$(SRC_PATH)/disas/libvixl"
 if test "$debug_info" = "yes"; then
     CFLAGS="-g $CFLAGS"
-    LDFLAGS="-g $LDFLAGS"
 fi
 
 # running configure in the source tree?
@@ -845,12 +844,12 @@ Darwin)
   LDFLAGS_SHARED="-bundle -undefined dynamic_lookup"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
-    LDFLAGS="-arch x86_64 $LDFLAGS"
+    QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
   fi
   cocoa="yes"
   audio_drv_list="coreaudio try-sdl"
   audio_possible_drivers="coreaudio sdl"
-  LDFLAGS="-framework CoreFoundation -framework IOKit $LDFLAGS"
+  QEMU_LDFLAGS="-framework CoreFoundation -framework IOKit $QEMU_LDFLAGS"
   libs_softmmu="-F/System/Library/Frameworks -framework Cocoa -framework IOKit $libs_softmmu"
   # Disable attempts to use ObjectiveC features in os/object.h since they
   # won't work when we're compiling with gcc as a C compiler.
@@ -1025,7 +1024,7 @@ for opt do
   ;;
   --static)
     static="yes"
-    LDFLAGS="-static $LDFLAGS"
+    QEMU_LDFLAGS="-static $QEMU_LDFLAGS"
     QEMU_PKG_CONFIG_FLAGS="--static $QEMU_PKG_CONFIG_FLAGS"
   ;;
   --mandir=*) mandir="$optarg"
@@ -1551,42 +1550,42 @@ done
 case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
-           LDFLAGS="-m32 $LDFLAGS"
+           QEMU_LDFLAGS="-m32 $QEMU_LDFLAGS"
            ;;
     ppc64)
            CPU_CFLAGS="-m64"
-           LDFLAGS="-m64 $LDFLAGS"
+           QEMU_LDFLAGS="-m64 $QEMU_LDFLAGS"
            ;;
     sparc)
            CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
-           LDFLAGS="-m32 -mv8plus $LDFLAGS"
+           QEMU_LDFLAGS="-m32 -mv8plus $QEMU_LDFLAGS"
            ;;
     sparc64)
            CPU_CFLAGS="-m64 -mcpu=ultrasparc"
-           LDFLAGS="-m64 $LDFLAGS"
+           QEMU_LDFLAGS="-m64 $QEMU_LDFLAGS"
            ;;
     s390)
            CPU_CFLAGS="-m31"
-           LDFLAGS="-m31 $LDFLAGS"
+           QEMU_LDFLAGS="-m31 $QEMU_LDFLAGS"
            ;;
     s390x)
            CPU_CFLAGS="-m64"
-           LDFLAGS="-m64 $LDFLAGS"
+           QEMU_LDFLAGS="-m64 $QEMU_LDFLAGS"
            ;;
     i386)
            CPU_CFLAGS="-m32"
-           LDFLAGS="-m32 $LDFLAGS"
+           QEMU_LDFLAGS="-m32 $QEMU_LDFLAGS"
            ;;
     x86_64)
            # ??? Only extremely old AMD cpus do not have cmpxchg16b.
            # If we truly care, we should simply detect this case at
            # runtime and generate the fallback to serial emulation.
            CPU_CFLAGS="-m64 -mcx16"
-           LDFLAGS="-m64 $LDFLAGS"
+           QEMU_LDFLAGS="-m64 $QEMU_LDFLAGS"
            ;;
     x32)
            CPU_CFLAGS="-mx32"
-           LDFLAGS="-mx32 $LDFLAGS"
+           QEMU_LDFLAGS="-mx32 $QEMU_LDFLAGS"
            ;;
     # No special flags required for other host CPUs
 esac
@@ -1967,6 +1966,7 @@ EOF
     if do_cc $QEMU_CFLAGS -Werror $flag -c -o $TMPO $TMPC &&
        compile_prog "-Werror $flag" ""; then
       QEMU_CFLAGS="$QEMU_CFLAGS $flag"
+      QEMU_LDFLAGS="$QEMU_LDFLAGS $flag"
       sp_on=1
       break
     fi
@@ -2051,10 +2051,10 @@ EOF
 
   if compile_prog "-fPIE -DPIE" "-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
-    LDFLAGS="-pie $LDFLAGS"
+    QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
     pie="yes"
     if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
-      LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
+      QEMU_LDFLAGS="-Wl,-z,relro -Wl,-z,now $QEMU_LDFLAGS"
     fi
   else
     if test "$pie" = "yes"; then
@@ -5862,7 +5862,7 @@ EOF
     hvf='no'
   else
     hvf='yes'
-    LDFLAGS="-framework Hypervisor $LDFLAGS"
+    QEMU_LDFLAGS="-framework Hypervisor $QEMU_LDFLAGS"
   fi
 fi
 
@@ -6096,8 +6096,8 @@ esac
 write_c_skeleton
 
 if test "$gcov" = "yes" ; then
-  CFLAGS="-fprofile-arcs -ftest-coverage -g $CFLAGS"
-  LDFLAGS="-fprofile-arcs -ftest-coverage $LDFLAGS"
+  QEMU_CFLAGS="-fprofile-arcs -ftest-coverage -g $QEMU_CFLAGS"
+  QEMU_LDFLAGS="-fprofile-arcs -ftest-coverage $QEMU_LDFLAGS"
 elif test "$fortify_source" = "yes" ; then
   CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
 elif test "$debug" = "no"; then
@@ -6105,7 +6105,8 @@ elif test "$debug" = "no"; then
 fi
 
 if test "$have_asan" = "yes"; then
-  CFLAGS="-fsanitize=address $CFLAGS"
+  QEMU_CFLAGS="-fsanitize=address $QEMU_CFLAGS"
+  QEMU_LDFLAGS="-fsanitize=address $QEMU_LDFLAGS"
   if test "$have_asan_iface_h" = "no" ; then
       echo "ASAN build enabled, but ASAN header missing." \
            "Without code annotation, the report may be inferior."
@@ -6115,7 +6116,8 @@ if test "$have_asan" = "yes"; then
   fi
 fi
 if test "$have_ubsan" = "yes"; then
-  CFLAGS="-fsanitize=undefined $CFLAGS"
+  QEMU_CFLAGS="-fsanitize=undefined $QEMU_CFLAGS"
+  QEMU_LDFLAGS="-fsanitize=undefined $QEMU_LDFLAGS"
 fi
 
 ##########################################
@@ -6150,7 +6152,7 @@ fi
 
 if test "$solaris" = "no" ; then
     if $ld --version 2>/dev/null | grep "GNU ld" >/dev/null 2>/dev/null ; then
-        LDFLAGS="-Wl,--warn-common $LDFLAGS"
+        QEMU_LDFLAGS="-Wl,--warn-common $QEMU_LDFLAGS"
     fi
 fi
 
@@ -6165,7 +6167,7 @@ fi
 if test "$mingw32" = "yes" ; then
     for flag in --dynamicbase --no-seh --nxcompat; do
         if ld_has $flag ; then
-            LDFLAGS="-Wl,$flag $LDFLAGS"
+            QEMU_LDFLAGS="-Wl,$flag $QEMU_LDFLAGS"
         fi
     done
 fi
@@ -6400,7 +6402,7 @@ EOF
 
     update_cxxflags
 
-    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $LDFLAGS; then
+    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAGS; then
         # C++ compiler $cxx works ok with C compiler $cc
         :
     else
@@ -6452,7 +6454,6 @@ echo "Objective-C compiler $objcc"
 echo "ARFLAGS           $ARFLAGS"
 echo "CFLAGS            $CFLAGS"
 echo "QEMU_CFLAGS       $QEMU_CFLAGS"
-echo "LDFLAGS           $LDFLAGS"
 echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
 echo "make              $make"
 echo "install           $install"
@@ -7519,9 +7520,8 @@ if test "$sparse" = "yes" ; then
   echo "HOST_CC      := REAL_CC=\"\$(HOST_CC)\" cgcc"  >> $config_host_mak
   echo "QEMU_CFLAGS  += -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-non-pointer-null" >> $config_host_mak
 fi
-echo "LDFLAGS=$LDFLAGS" >> $config_host_mak
-echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
+echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
 echo "LD_REL_FLAGS=$LD_REL_FLAGS" >> $config_host_mak
 echo "LD_I386_EMULATION=$ld_i386_emulation" >> $config_host_mak
 echo "LIBS+=$LIBS" >> $config_host_mak
@@ -7847,7 +7847,7 @@ if test "$target_bsd_user" = "yes" ; then
 fi
 
 
-# generate QEMU_CFLAGS/LDFLAGS for targets
+# generate QEMU_CFLAGS/QEMU_LDFLAGS for targets
 
 cflags=""
 ldflags=""
@@ -7968,7 +7968,7 @@ if test "$TARGET_ARCH" = "s390x" && test "$target_softmmu" = "yes" && \
     fi
 fi
 
-echo "LDFLAGS+=$ldflags" >> $config_target_mak
+echo "QEMU_LDFLAGS+=$ldflags" >> $config_target_mak
 echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
 
 done # for target in $targets
diff --git a/qga/vss-win32/Makefile.objs b/qga/vss-win32/Makefile.objs
index fd3ba18..c82676a 100644
--- a/qga/vss-win32/Makefile.objs
+++ b/qga/vss-win32/Makefile.objs
@@ -5,9 +5,9 @@ qga-vss-dll-obj-y += requester.o provider.o install.o
 obj-qga-vss-dll-obj-y = $(addprefix $(obj)/, $(qga-vss-dll-obj-y))
 $(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS := $(filter-out -fstack-protector-all -fstack-protector-strong, $(QEMU_CXXFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-dtor
 
-$(obj)/qga-vss.dll: LDFLAGS = -shared -Wl,--add-stdcall-alias,--enable-stdcall-fixup -lglib-2.0 -lole32 -loleaut32 -lshlwapi -luuid -lintl -lws2_32 -static
+QGA_VSS_LDFLAGS = -shared -Wl,--add-stdcall-alias,--enable-stdcall-fixup -lglib-2.0 -lole32 -loleaut32 -lshlwapi -luuid -lintl -lws2_32 -static
 $(obj)/qga-vss.dll: $(obj-qga-vss-dll-obj-y) $(SRC_PATH)/$(obj)/qga-vss.def
-	$(call quiet-command,$(CXX) -o $@ $(qga-vss-dll-obj-y) $(SRC_PATH)/qga/vss-win32/qga-vss.def $(CXXFLAGS) $(LDFLAGS),"LINK","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CXX) -o $@ $(qga-vss-dll-obj-y) $(SRC_PATH)/qga/vss-win32/qga-vss.def $(CXXFLAGS) $(QGA_VSS_LDFLAGS),"LINK","$(TARGET_DIR)$@")
 
 
 # rules to build qga-provider.tlb
diff --git a/rules.mak b/rules.mak
index 967295d..c855887 100644
--- a/rules.mak
+++ b/rules.mak
@@ -76,7 +76,7 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
 # must link with the C++ compiler, not the plain C compiler.
 LINKPROG = $(or $(CXX),$(CC))
 
-LINK = $(call quiet-command, $(LINKPROG) $(QEMU_LDFLAGS) $(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ \
+LINK = $(call quiet-command, $(LINKPROG) $(CFLAGS) $(QEMU_LDFLAGS) -o $@ \
        $(call process-archive-undefs, $1) \
        $(version-obj-y) $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_DIR)$@")
 
@@ -105,7 +105,7 @@ LINK = $(call quiet-command, $(LINKPROG) $(QEMU_LDFLAGS) $(QEMU_CFLAGS) $(CFLAGS
 
 DSO_OBJ_CFLAGS := -fPIC -DBUILD_DSO
 module-common.o: CFLAGS += $(DSO_OBJ_CFLAGS)
-%$(DSOSUF): LDFLAGS += $(LDFLAGS_SHARED)
+%$(DSOSUF): QEMU_LDFLAGS += $(LDFLAGS_SHARED)
 %$(DSOSUF): %.mo
 	$(call LINK,$^)
 	@# Copy to build root so modules can be loaded when program started without install
-- 
1.8.3.1


