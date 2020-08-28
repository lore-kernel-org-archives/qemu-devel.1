Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FCFC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9000B2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIZjFCmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9000B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBf1N-0000Co-S7
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBf0Y-0007TW-IC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:05:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBf0U-0002zF-36
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:05:34 -0400
Received: by mail-pf1-x441.google.com with SMTP id c142so644950pfb.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mGqH1Rc0jC5tJUVtmCnrL19uSxesVPAxucvnV2DGZBY=;
 b=EIZjFCmzkPUk8nGt9FH7p4Vs94NDX9wiZ/W/v1X1bJqacPvT96yEbMko00bQU3U+rY
 tGVtZHaLbTwz+iaHUwMG9A2O8VurCIPYVnp8BfFjVjDM+SmhxDjWw1T/Pe89fOLh+I9F
 1o6LkaQ/sBFvNlf/q0SVCxzw+TH72SPuhxXQmuzvfbjspKWyTRRBQJ3xwWBxVr12TBxy
 HSaOL1NrjaPwOZYX2y03G+NUmYR60azuhJwiNV3EhEmOQsIyO3w4NbtSuDCk6gVtp8/G
 BxZyX4199OTF+sNyNM/Ph+DD03KswPX3G9kfX/iMhAeKNykfMsld/Yhz0sI5Qpyqpe3v
 0Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mGqH1Rc0jC5tJUVtmCnrL19uSxesVPAxucvnV2DGZBY=;
 b=d1HwIS9Eblki7/BMti4MMq5n9Fh0KHCbJgIETUGnvx4pzDSWwOWFDOpsbtLWxY7A+y
 p/27m5r2Vh5k7Llgte6D0gWddTNetcEJh3vi2USi+lmF1gO16KY4QOSqPAYsrl+RK413
 4k3AGZ+CCZBx7cMfheS5hn1P4w5K410vY/v4/Q46n0EIp5vSEmm9QlFOLEjAADnhiH37
 vkeVhCEsmNzLxV/9vaHKntpoBhxCHLP75DHJf7LQ5tNnlS3gfBxRi+QKANN4iaxCf/g8
 xVMbkD5YK2PvoMnu/Yx4AdDfBYmOuQ8/tGPLcyjTQG2XicNhhc5zyFkKwZJN6H1Gh4nQ
 bjbQ==
X-Gm-Message-State: AOAM532nj0KNxrjlMFnnNay31shOMebfdXsiHfShZHlFFA/l8MwtbYk8
 fug+eI+4y3fOs1Tb6wHWYRzNTqPg/fb3nQ==
X-Google-Smtp-Source: ABdhPJzsGYJ8NrhwVB8xrn08lyCyLfN3mzWU86QmwwLYl2V6dY0fggqZFli3JnAUvw9KQc/Zw36PwA==
X-Received: by 2002:a05:6a00:1589:: with SMTP id
 u9mr90812pfk.201.1598623527614; 
 Fri, 28 Aug 2020 07:05:27 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t24sm1801637pgo.51.2020.08.28.07.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:05:26 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Fix include and linkage issue on msys2
Date: Fri, 28 Aug 2020 22:05:07 +0800
Message-Id: <20200828140507.535-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

On msys2, the -I/e/path/to/qemu -L/e/path/to/qemu are not recognized by the compiler
Cause $PWD are result posix style path such as /e/path/to/qemu that can not be recognized
by mingw gcc, and `pwd -W` are result Windows style path such as E:/path/to/qemu that can
be recognized by the mingw gcc. So we replace all $PWD with $build_path that can
building qemu under msys2/mingw environment.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index 6ecaff429b..00780795be 100755
--- a/configure
+++ b/configure
@@ -13,8 +13,13 @@ export CCACHE_RECACHE=yes
 
 # make source path absolute
 source_path=$(cd "$(dirname -- "$0")"; pwd)
+build_path=$PWD
+if [ "$MSYSTEM" = "MINGW64" -o  "$MSYSTEM" = "MINGW32" ]; then
+source_path=$(cd "$(dirname -- "$0")"; pwd -W)
+build_path=`pwd -W`
+fi
 
-if test "$PWD" = "$source_path"
+if test "$build_path" = "$source_path"
 then
     echo "Using './build' as the directory for build output"
 
@@ -346,7 +351,12 @@ ld_has() {
     $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
 }
 
-if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
+check_valid_build_path="[[:space:]:]"
+if [ "$MSYSTEM" = "MINGW64" -o  "$MSYSTEM" = "MINGW32" ]; then
+check_valid_build_path="[[:space:]]"
+fi
+
+if printf %s\\n "$source_path" "$build_path" | grep -q "$check_valid_build_path";
 then
   error_exit "main directory cannot contain spaces nor colons"
 fi
@@ -944,7 +954,7 @@ Linux)
   linux="yes"
   linux_user="yes"
   kvm="yes"
-  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
+  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I${build_path}/linux-headers $QEMU_INCLUDES"
   libudev="yes"
 ;;
 esac
@@ -4284,7 +4294,7 @@ EOF
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
           fi
           fdt_cflags="-I${source_path}/dtc/libfdt"
-          fdt_ldflags="-L$PWD/dtc/libfdt"
+          fdt_ldflags="-L${build_path}/dtc/libfdt"
           fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
@@ -5269,7 +5279,7 @@ case "$capstone" in
     else
       LIBCAPSTONE=libcapstone.a
     fi
-    capstone_libs="-L$PWD/capstone -lcapstone"
+    capstone_libs="-L${build_path}/capstone -lcapstone"
     capstone_cflags="-I${source_path}/capstone/include"
     ;;
 
@@ -6269,8 +6279,8 @@ case "$slirp" in
       git_submodules="${git_submodules} slirp"
     fi
     mkdir -p slirp
-    slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
-    slirp_libs="-L$PWD/slirp -lslirp"
+    slirp_cflags="-I${source_path}/slirp/src -I${build_path}/slirp/src"
+    slirp_libs="-L${build_path}/slirp -lslirp"
     if test "$mingw32" = "yes" ; then
       slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
     fi
@@ -8211,7 +8221,7 @@ fi
 mv $cross config-meson.cross
 
 rm -rf meson-private meson-info meson-logs
-NINJA=${ninja:-$PWD/ninjatool} $meson setup \
+NINJA="${ninja:-$build_path}/ninjatool" $meson setup \
         --prefix "${pre_prefix}$prefix" \
         --libdir "${pre_prefix}$libdir" \
         --libexecdir "${pre_prefix}$libexecdir" \
@@ -8231,7 +8241,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon \
         $cross_arg \
-        "$PWD" "$source_path"
+        "$build_path" "$source_path"
 
 if test "$?" -ne 0 ; then
     error_exit "meson setup failed"
-- 
2.27.0.windows.1


