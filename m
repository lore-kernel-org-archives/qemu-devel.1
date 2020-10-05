Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A10C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E002085B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K886jNcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E002085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPR4i-0004gN-HQ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQyR-00078D-Hp
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:56:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQyP-0000NV-JE
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:56:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id g12so4256663wrp.10
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BrtOVW9V3D/LBY3s2wsbDM0UEoZEQflzxibiFznmWyI=;
 b=K886jNcbzUyJrsJhdh7hCBkTgscOWeqDZHysSjnmRsCmb7HdY8ZRE1CTs4qG48/Ul+
 z2LIGjvLZnR3+n98XhJYVXcjxqTPqDZuTY3ZIZnt5O6nJNBpjdNIBMsseSumF580NFkn
 7OaMchJJpNAWtb29XnC/ZNTT+mQ6t8u96RtBTNQoGVLbnDAzmt6BLQwjE/zec7EJn0lf
 0MNWTrdKJTwxay9Tm7HZYQrrjY6wxZVaUqIRRbe4TShb6PWigeIlpLaA4rkjxZlxAQc9
 x183doyOUTcdbShd1H345/ht7lM6zFR4CZusUsPjv0nEUP2xrI97L4l8Omx5l8s7tOaY
 dX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BrtOVW9V3D/LBY3s2wsbDM0UEoZEQflzxibiFznmWyI=;
 b=dAIs4r2/YDHDP2D5zKkjqeVx6B1mcNufVpWrU0gKMididTyImrGt0B7GM3nc0yMm94
 mgQgdFsrrwh5ymtWrz079z3LHs8UvyxYL11kRtG+NYHkgVw6ZIAwgMtlEKNRtg/yaOvD
 cIXxQ2Qjeix2HCj+ZxcWmB4ilFKNaZ/l9Xj3qtZaBRu9Go+toJT83F4jQDQgL9NJjLFC
 8lQcasWHbe19RVlieHnXvPf2Mtnc/Cpaxdmnj6GuD64oSQ/GN74CQDE4H84Kye5SdXD1
 6kL7PBSDkb5Mhuq3qxTU7hRhSXprR+eeieurCASTVuvOpWX6Aumc8TNs6a0rieL5BBG4
 OH6w==
X-Gm-Message-State: AOAM533fY6XKG4VehUvBYNJBB1Rgo8KiKBbQ/j+2iT6gy5WS8UZrYHs0
 DgX3WW4w86l94oNW0wshpdMj3WqHY1U=
X-Google-Smtp-Source: ABdhPJw72CPkbrSJFqy4fgbEFKxM4xGHhsfkP0CuQgBMfvzhSqTHtw4exPqrgkqYESKsu3JVM1DgaA==
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr12608881wrn.358.1601906175685; 
 Mon, 05 Oct 2020 06:56:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id c8sm13406559wmd.18.2020.10.05.06.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 06:56:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] configure: do not clobber environment
 CFLAGS/CXXFLAGS/LDFLAGS
Date: Mon,  5 Oct 2020 15:56:12 +0200
Message-Id: <20201005135613.435932-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005135613.435932-1-pbonzini@redhat.com>
References: <20201005135613.435932-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x442.google.com
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

If the CFLAGS, CXXFLAGS or LDFLAGS variables are present in the environment,
any modification made within the configure script is passed down to Meson.
This is particularly undesirable for the "-pie" option, since it overrides
"-shared" and thus messes up the linker flags for shared modules.

Using a separate variable therefore fixes the bug, while clarifying that
the scope of these CFLAGS is just the configure script.

We also do not need to pass those variables in config-host.mak; they
were only used for printing the summary now that all submodules are
built with handwritten Meson rules).  For now synthesize CFLAGS in the
configuration summary, the next patch will also pass them in a cleaner
way using the cross file.

Reported-by: Frederic Bezies
Analyzed-by: Toolybird
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200923092617.1593722-4-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 38 +++++++++++++++++---------------------
 meson.build |  3 ++-
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/configure b/configure
index 2fdb4339e8..1b173276ea 100755
--- a/configure
+++ b/configure
@@ -155,7 +155,7 @@ update_cxxflags() {
     # options which some versions of GCC's C++ compiler complain about
     # because they only make sense for C programs.
     QEMU_CXXFLAGS="$QEMU_CXXFLAGS -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS"
-    CXXFLAGS=$(echo "$CFLAGS" | sed s/-std=gnu99/-std=gnu++11/)
+    CONFIGURE_CXXFLAGS=$(echo "$CONFIGURE_CFLAGS" | sed s/-std=gnu99/-std=gnu++11/)
     for arg in $QEMU_CFLAGS; do
         case $arg in
             -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
@@ -170,13 +170,14 @@ update_cxxflags() {
 
 compile_object() {
   local_cflags="$1"
-  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC
+  do_cc $CFLAGS $CONFIGURE_CFLAGS $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC
 }
 
 compile_prog() {
   local_cflags="$1"
   local_ldflags="$2"
-  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $LDFLAGS $QEMU_LDFLAGS $local_ldflags
+  do_cc $CFLAGS $CONFIGURE_CFLAGS $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC \
+      $LDFLAGS $CONFIGURE_LDFLAGS $QEMU_LDFLAGS $local_ldflags
 }
 
 # symbolically link $1 to $2.  Portable version of "ln -sf".
@@ -537,7 +538,10 @@ QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
 QEMU_INCLUDES="-iquote . -iquote ${source_path} -iquote ${source_path}/accel/tcg -iquote ${source_path}/include"
 QEMU_INCLUDES="$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"
-CFLAGS="-std=gnu99 -Wall"
+
+# Flags that are needed during configure but later taken care of by Meson
+CONFIGURE_CFLAGS="-std=gnu99 -Wall"
+CONFIGURE_LDFLAGS=
 
 
 check_define() {
@@ -851,7 +855,7 @@ if test "$mingw32" = "yes" ; then
   EXESUF=".exe"
   HOST_DSOSUF=".dll"
   # MinGW needs -mthreads for TLS and macro _MT.
-  CFLAGS="-mthreads $CFLAGS"
+  CONFIGURE_CFLAGS="-mthreads $CONFIGURE_CFLAGS"
   write_c_skeleton;
   prefix="/qemu"
   qemu_suffix=""
@@ -2109,7 +2113,7 @@ fi
 
 if test "$static" = "yes"; then
   if test "$pie" != "no" && compile_prog "-Werror -fPIE -DPIE" "-static-pie"; then
-    CFLAGS="-fPIE -DPIE $CFLAGS"
+    CONFIGURE_CFLAGS="-fPIE -DPIE $CONFIGURE_CFLAGS"
     QEMU_LDFLAGS="-static-pie $QEMU_LDFLAGS"
     pie="yes"
   elif test "$pie" = "yes"; then
@@ -2119,11 +2123,11 @@ if test "$static" = "yes"; then
     pie="no"
   fi
 elif test "$pie" = "no"; then
-  CFLAGS="$CFLAGS_NOPIE $CFLAGS"
-  LDFLAGS="$LDFLAGS_NOPIE $LDFLAGS"
+  CONFIGURE_CFLAGS="$CFLAGS_NOPIE $CONFIGURE_CFLAGS"
+  CONFIGURE_LDFLAGS="$LDFLAGS_NOPIE $CONFIGURE_LDFLAGS"
 elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
-  CFLAGS="-fPIE -DPIE $CFLAGS"
-  LDFLAGS="-pie $LDFLAGS"
+  CONFIGURE_CFLAGS="-fPIE -DPIE $CONFIGURE_CFLAGS"
+  CONFIGURE_LDFLAGS="-pie $CONFIGURE_LDFLAGS"
   pie="yes"
 elif test "$pie" = "yes"; then
   error_exit "PIE not available due to missing toolchain support"
@@ -3667,7 +3671,7 @@ EOF
 if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
     if cc_has_warning_flag "-Wno-unknown-attributes"; then
         glib_cflags="-Wno-unknown-attributes $glib_cflags"
-        CFLAGS="-Wno-unknown-attributes $CFLAGS"
+        CONFIGURE_CFLAGS="-Wno-unknown-attributes $CONFIGURE_CFLAGS"
     fi
 fi
 
@@ -3687,7 +3691,7 @@ EOF
 if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
     if cc_has_warning_flag "-Wno-unused-function"; then
         glib_cflags="$glib_cflags -Wno-unused-function"
-        CFLAGS="$CFLAGS -Wno-unused-function"
+        CONFIGURE_CFLAGS="$CONFIGURE_CFLAGS -Wno-unused-function"
     fi
 fi
 
@@ -5814,13 +5818,6 @@ elif test "$fortify_source" = "yes" ; then
   QEMU_CFLAGS="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $QEMU_CFLAGS"
   debug=no
 fi
-if test "$debug_info" = "yes"; then
-  CFLAGS="-g $CFLAGS"
-  LDFLAGS="-g $LDFLAGS"
-fi
-if test "$debug" = "no"; then
-  CFLAGS="-O2 $CFLAGS"
-fi
 
 case "$ARCH" in
 alpha)
@@ -6043,7 +6040,7 @@ EOF
 
     update_cxxflags
 
-    if do_cxx $CXXFLAGS $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAGS; then
+    if do_cxx $CXXFLAGS $CONFIGURE_CXXFLAGS $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAGS; then
         # C++ compiler $cxx works ok with C compiler $cc
         :
     else
@@ -6953,7 +6950,6 @@ echo "RANLIB=$ranlib" >> $config_host_mak
 echo "NM=$nm" >> $config_host_mak
 echo "PKG_CONFIG=$pkg_config_exe" >> $config_host_mak
 echo "WINDRES=$windres" >> $config_host_mak
-echo "CFLAGS=$CFLAGS" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 426b73d31f..d9377f371d 100644
--- a/meson.build
+++ b/meson.build
@@ -1758,7 +1758,8 @@ if targetos == 'darwin'
   summary_info += {'Objective-C compiler': meson.get_compiler('objc').cmd_array()[0]}
 endif
 summary_info += {'ARFLAGS':           config_host['ARFLAGS']}
-summary_info += {'CFLAGS':            config_host['CFLAGS']}
+summary_info += {'CFLAGS':            '-O' + get_option('optimization')
+                                           + (get_option('debug') ? ' -g' : '')}
 summary_info += {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
 summary_info += {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
 summary_info += {'make':              config_host['MAKE']}
-- 
2.26.2



