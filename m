Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35441C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF7B20709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0wloF29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF7B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWDT-0001T5-VI
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDW8X-0000Th-3W
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:01:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDW8U-0000Ip-Vj
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:01:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id 67so2830529pgd.12
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iVIr1leFc3liAehHnInLxU7v1tQQv57KF6dosXo9DWU=;
 b=e0wloF29eJMTj3wTueKCAESHD4nyDOm/YMY6FtpSl1xIwHFNTzqJ0X/hZysx9OKSEz
 19YkfMWoJMO2Hesn4Jp+mYpZxYO09nqM+FoOjh5hFWWBIujZwx0JvkseQceEBOoHZepk
 AWPOFGqgVHnY9g8NHm9R+IXUpcvk5jhB5DDzeboQHYH0MDWdCP8XGEnzsE0PSROMj7e+
 0pU4uoGtGBHMaDOHTFOhFg/xGUWYvE2odwLKCAaRgaJCyS2+MHUZ+AWnmNkA4L01LeJC
 7Ktk4pBbmIb9l3d/ICkUP3PE4aOWGqVio71QuuMPpGc8oir7It2voWsek1W1VfVYvWc4
 +xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iVIr1leFc3liAehHnInLxU7v1tQQv57KF6dosXo9DWU=;
 b=UwnqWeYFafoWR+h3J/um32q/rxGmBF1XU6121P6GwExQOIX066DStbDJFiLzTC+n2/
 3B2vybYybXxwEmOXxEbgWWJ8LcGxPIwQVVlzuT+7QbiK+bFoII8gse0xSSQxLo1VfT8K
 JBQVzPEazxApm4Lrcgeyqb5Q76WqtNfTZfMkyB7gb8ictDeKC69fZrY7xo2bmSgVD3DB
 Pqk/rwQu4YhVEw2mVYp6Q8Ae0j5tJSg/uOBAYMV9OSTe8UgLZg76WTRWddBESFVS2gR4
 oSb0HD++a05+R2eg0/qmVw/iujA1wrlGpk6EWstA7ccB6anvS03gcVqpQy6HnBd24nI+
 wweg==
X-Gm-Message-State: AOAM533JR3sEPtdXN96f6uOQlWuZlgBJgIRFo2aHSO056FVpW6BjGwTW
 cZLag2esZZpBmZB9Y+7xEyWUJiQ0ft8=
X-Google-Smtp-Source: ABdhPJwN5f03lmx6uJjRtRqfTuaSqQI02+hKhCoz1pUPpnIXzm6IQG20poKABb3CfPZk49GDOAuSMw==
X-Received: by 2002:a63:fa45:: with SMTP id g5mr2546012pgk.448.1599066085048; 
 Wed, 02 Sep 2020 10:01:25 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x4sm40527pfm.86.2020.09.02.10.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 10:01:24 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] configure: Fix include and linkage issue on msys2
Date: Thu,  3 Sep 2020 01:00:54 +0800
Message-Id: <20200902170054.810-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200902170054.810-1-luoyonggang@gmail.com>
References: <20200902170054.810-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x541.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index 30f8c4db29..5f2bcc4b57 100755
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
@@ -943,7 +953,7 @@ Linux)
   linux="yes"
   linux_user="yes"
   kvm="yes"
-  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
+  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I${build_path}/linux-headers $QEMU_INCLUDES"
   libudev="yes"
 ;;
 esac
@@ -4259,7 +4269,7 @@ EOF
           fdt=git
           mkdir -p dtc
           fdt_cflags="-I${source_path}/dtc/libfdt"
-          fdt_ldflags="-L$PWD/dtc/libfdt"
+          fdt_ldflags="-L${build_path}/dtc/libfdt"
           fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
@@ -5244,7 +5254,7 @@ case "$capstone" in
     else
       LIBCAPSTONE=libcapstone.a
     fi
-    capstone_libs="-L$PWD/capstone -lcapstone"
+    capstone_libs="-L${build_path}/capstone -lcapstone"
     capstone_cflags="-I${source_path}/capstone/include"
     ;;
 
@@ -6244,8 +6254,8 @@ case "$slirp" in
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
@@ -8190,7 +8200,7 @@ fi
 mv $cross config-meson.cross
 
 rm -rf meson-private meson-info meson-logs
-NINJA=${ninja:-$PWD/ninjatool} $meson setup \
+NINJA=${ninja:-${build_path}/ninjatool} $meson setup \
         --prefix "${pre_prefix}$prefix" \
         --libdir "${pre_prefix}$libdir" \
         --libexecdir "${pre_prefix}$libexecdir" \
@@ -8212,7 +8222,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
         $cross_arg \
-        "$PWD" "$source_path"
+        "$build_path" "$source_path"
 
 if test "$?" -ne 0 ; then
     error_exit "meson setup failed"
-- 
2.27.0.windows.1


