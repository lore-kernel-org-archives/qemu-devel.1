Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1847FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AFD2076E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOVXyLfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AFD2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gNI-0007DW-1B
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGe-0003Pq-3d
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:44 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGc-00062z-8B
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id c19so13336431wmd.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/9cnuSUY7R8bNQaayK9fc2xPxyOR/SLBtuCwfgtQfHE=;
 b=QOVXyLfKuib9NWz2UcsaljMUxvne7kMB3ZlBVD1YN4vMXhhHOMWmElV39n+iLdUCUl
 VyQlt4Kmtz80cC36M3AdnTyLPAfMoz5Py2SxiJgjYEwtt2bkaRzuZ949dBGQZvMFBmPF
 UNILR5ElOWPCbffAE6/XGi4XLvcPya5KoW2vL8W1Q/1RixO2pmKqt2NHnrtuZ8B29xj6
 QSJb9eYTcpzKoF999PeSroDPFQHatyNiVbk9SteXVICkYxRxGVHGctb00p3ye+Kry0qx
 c2WU67TJ/Tq8tliJU0ubrB/nQhlw5QEiBhpGZ67KqANFQifB3xNd3bl1WgeAEKOEI/mZ
 +bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/9cnuSUY7R8bNQaayK9fc2xPxyOR/SLBtuCwfgtQfHE=;
 b=HZQU3AtPDfDoPqX2JyMHOhTivX0YdmJCib/Y8rREQ4/GJ5evEadTAKM26ewXo/DeRS
 IGVbEVAeODulDojWo/vy9L3H1eO7vZuq4isasuKA1dP1URgrc3fKPTP8RFKP5hhcPMbG
 EKRB3aT7Va3muUEPS1l1aQue63vk0tFr+40EAGCTCE5v8K8rj54vBJ2etzHnPnmGPAiY
 RatVKYX18FbHZGw7yYnAAnRK6G56OKD/HwCpYqRtibNmnjzRf7rKHgPeNnzCnnqlXMFL
 JLLqvu4FaRD+21KTBNATBNBIQhA1+sBXnfFezEekMIFAFKVgpzFQRBJLeA6lpVemDXc0
 HsFA==
X-Gm-Message-State: AOAM532HnAOKxP38+OsWpbegfrBLB7Oob0BFTwuZ/eN+fL1KgbRK7ASS
 OIIf9Bayz0GS9zdZ01COWzpPEULoLCM=
X-Google-Smtp-Source: ABdhPJzJ0/KHh28M51v0YGElJLKRlje9x1XcMoyPl6aBBIwr4CRLGF7zplGXtC5nLaAOyO7xOW3Uxw==
X-Received: by 2002:a1c:1d91:: with SMTP id
 d139mr15365508wmd.144.1597675060345; 
 Mon, 17 Aug 2020 07:37:40 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.39 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 013/150] configure: prepare CFLAGS/CXXFLAGS/LDFLAGS for Meson
Date: Mon, 17 Aug 2020 16:35:06 +0200
Message-Id: <20200817143723.343284-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Split between CFLAGS/QEMU_CFLAGS and CXXFLAGS/QEMU_CXXFLAGS so that
we will use CFLAGS and CXXFLAGS for flags that we do not want to
pass to add_project_arguments.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure             | 78 ++++++++++++++++++++-----------------------
 rules.mak             |  4 +--
 softmmu/Makefile.objs |  2 +-
 3 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/configure b/configure
index 373bb22287..42f0c1c20b 100755
--- a/configure
+++ b/configure
@@ -107,15 +107,12 @@ update_cxxflags() {
     # options which some versions of GCC's C++ compiler complain about
     # because they only make sense for C programs.
     QEMU_CXXFLAGS="$QEMU_CXXFLAGS -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS"
-
+    CXXFLAGS=$(echo "$CFLAGS" | sed s/-std=gnu99/-std=gnu++11/)
     for arg in $QEMU_CFLAGS; do
         case $arg in
             -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
             -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls)
                 ;;
-            -std=gnu99)
-                QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }"-std=gnu++98"
-                ;;
             *)
                 QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
                 ;;
@@ -125,13 +122,13 @@ update_cxxflags() {
 
 compile_object() {
   local_cflags="$1"
-  do_cc $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC
+  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC
 }
 
 compile_prog() {
   local_cflags="$1"
   local_ldflags="$2"
-  do_cc $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $QEMU_LDFLAGS $local_ldflags
+  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $LDFLAGS $QEMU_LDFLAGS $local_ldflags
 }
 
 # symbolically link $1 to $2.  Portable version of "ln -sf".
@@ -597,15 +594,14 @@ ARFLAGS="${ARFLAGS-rv}"
 # left shift of signed integers is well defined and has the expected
 # 2s-complement style results. (Both clang and gcc agree that it
 # provides these semantics.)
-QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv -std=gnu99 $QEMU_CFLAGS"
-QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
+QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
+QEMU_CFLAGS="-Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
 QEMU_INCLUDES="-iquote . -iquote ${source_path} -iquote ${source_path}/accel/tcg -iquote ${source_path}/include"
 QEMU_INCLUDES="$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"
-if test "$debug_info" = "yes"; then
-    CFLAGS="-g $CFLAGS"
-fi
+CFLAGS="-std=gnu99 -Wall"
+
 
 # running configure in the source tree?
 # we know that's the case if configure is there.
@@ -886,7 +882,6 @@ SunOS)
   QEMU_CFLAGS="-D_XOPEN_SOURCE=600 $QEMU_CFLAGS"
 # needed for TIOCWIN* defines in termios.h
   QEMU_CFLAGS="-D__EXTENSIONS__ $QEMU_CFLAGS"
-  QEMU_CFLAGS="-std=gnu99 $QEMU_CFLAGS"
   solarisnetlibs="-lsocket -lnsl -lresolv"
   LIBS="$solarisnetlibs $LIBS"
   libs_qga="$solarisnetlibs $libs_qga"
@@ -2109,7 +2104,7 @@ EOF
   for flag in $gcc_flags; do
     # We need to check both a compile and a link, since some compiler
     # setups fail only on a .c->.o compile and some only at link time
-    if do_cc $QEMU_CFLAGS -Werror $flag -c -o $TMPO $TMPC &&
+    if compile_object "-Werror $flag" &&
        compile_prog "-Werror $flag" ""; then
       QEMU_CFLAGS="$QEMU_CFLAGS $flag"
       QEMU_LDFLAGS="$QEMU_LDFLAGS $flag"
@@ -2184,7 +2179,7 @@ fi
 
 if test "$static" = "yes"; then
   if test "$pie" != "no" && compile_prog "-Werror -fPIE -DPIE" "-static-pie"; then
-    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+    CFLAGS="-fPIE -DPIE $CFLAGS"
     QEMU_LDFLAGS="-static-pie $QEMU_LDFLAGS"
     pie="yes"
   elif test "$pie" = "yes"; then
@@ -2194,11 +2189,11 @@ if test "$static" = "yes"; then
     pie="no"
   fi
 elif test "$pie" = "no"; then
-  QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
-  QEMU_LDFLAGS="$LDFLAGS_NOPIE $QEMU_LDFLAGS"
+  CFLAGS="$CFLAGS_NOPIE $CFLAGS"
+  LDFLAGS="$LDFLAGS_NOPIE $LDFLAGS"
 elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
-  QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
-  QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
+  CFLAGS="-fPIE -DPIE $CFLAGS"
+  LDFLAGS="-pie $LDFLAGS"
   pie="yes"
 elif test "$pie" = "yes"; then
   error_exit "PIE not available due to missing toolchain support"
@@ -3981,7 +3976,7 @@ EOF
 if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
     if cc_has_warning_flag "-Wno-unknown-attributes"; then
         glib_cflags="-Wno-unknown-attributes $glib_cflags"
-        CFLAGS="-Wno-unknown-attributes $CFLAGS"
+        QEMU_CFLAGS="-Wno-unknown-attributes $CFLAGS"
     fi
 fi
 
@@ -6506,10 +6501,28 @@ if test "$gcov" = "yes" ; then
   QEMU_CFLAGS="-fprofile-arcs -ftest-coverage -g $QEMU_CFLAGS"
   QEMU_LDFLAGS="-fprofile-arcs -ftest-coverage $QEMU_LDFLAGS"
 elif test "$fortify_source" = "yes" ; then
-  CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
-elif test "$debug" = "no"; then
+  QEMU_CFLAGS="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $QEMU_CFLAGS"
+  debug=no
+fi
+if test "$debug" = "no"; then
   CFLAGS="-O2 $CFLAGS"
 fi
+if test "$debug_info" = "yes"; then
+  CFLAGS="-g $CFLAGS"
+  LDFLAGS="-g $LDFLAGS"
+fi
+
+case "$ARCH" in
+alpha)
+  # Ensure there's only a single GP
+  QEMU_CFLAGS="-msmall-data $QEMU_CFLAGS"
+;;
+esac
+
+if test "$gprof" = "yes" ; then
+  QEMU_CFLAGS="-p $QEMU_CFLAGS"
+  QEMU_LDFLAGS="-p $QEMU_LDFLAGS"
+fi
 
 if test "$have_asan" = "yes"; then
   QEMU_CFLAGS="-fsanitize=address $QEMU_CFLAGS"
@@ -6782,7 +6795,7 @@ EOF
 
     update_cxxflags
 
-    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAGS; then
+    if do_cxx $CXXFLAGS $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAGS; then
         # C++ compiler $cxx works ok with C compiler $cc
         :
     else
@@ -7874,7 +7887,7 @@ if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
     FUZZ_LDFLAGS=" -fsanitize=fuzzer"
     FUZZ_CFLAGS=" -fsanitize=fuzzer"
-    CFLAGS="$CFLAGS -fsanitize=fuzzer-no-link"
+    QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
   else
     error_exit "Your compiler doesn't support -fsanitize=fuzzer"
     exit 1
@@ -7961,6 +7974,7 @@ echo "NM=$nm" >> $config_host_mak
 echo "PKG_CONFIG=$pkg_config_exe" >> $config_host_mak
 echo "WINDRES=$windres" >> $config_host_mak
 echo "CFLAGS=$CFLAGS" >> $config_host_mak
+echo "CXXFLAGS=$CXXFLAGS" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
@@ -8430,24 +8444,6 @@ if test "$tcg_interpreter" = "yes" ; then
   disas_config "TCI"
 fi
 
-case "$ARCH" in
-alpha)
-  # Ensure there's only a single GP
-  cflags="-msmall-data $cflags"
-;;
-esac
-
-if test "$gprof" = "yes" ; then
-  if test "$target_linux_user" = "yes" ; then
-    cflags="-p $cflags"
-    ldflags="-p $ldflags"
-  fi
-  if test "$target_softmmu" = "yes" ; then
-    ldflags="-p $ldflags"
-    echo "GPROF_CFLAGS=-p" >> $config_target_mak
-  fi
-fi
-
 # Newer kernels on s390 check for an S390_PGSTE program header and
 # enable the pgste page table extensions in that case. This makes
 # the vm.allocate_pgste sysctl unnecessary. We enable this program
diff --git a/rules.mak b/rules.mak
index 56ba540a32..e79a4005a7 100644
--- a/rules.mak
+++ b/rules.mak
@@ -88,12 +88,12 @@ LINK = $(call quiet-command, $(LINKPROG) $(CFLAGS) $(QEMU_LDFLAGS) -o $@ \
 
 %.o: %.cc
 	$(call quiet-command,$(CXX) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
-	       $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
+	       $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CXXFLAGS) $($@-cflags) \
 	       -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
 
 %.o: %.cpp
 	$(call quiet-command,$(CXX) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
-	       $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
+	       $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CXXFLAGS) $($@-cflags) \
 	       -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
 
 %.o: %.m
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index a414a74c50..c036887500 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -11,4 +11,4 @@ obj-y += memory_mapping.o
 obj-y += qtest.o
 
 obj-y += vl.o
-vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
+vl.o-cflags := $(SDL_CFLAGS)
-- 
2.26.2



