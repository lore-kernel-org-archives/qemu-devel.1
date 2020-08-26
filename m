Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408CBC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3FB2087C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKNVOLFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3FB2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtfR-0000cf-BS
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAte4-0007Ul-MB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:31:12 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAte2-0006WN-LZ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:31:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id p15so751178pli.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bzrUXWXJ2P4FPb4Z7Y3jIG7wAqzpJKqykSmKTUKfTsk=;
 b=OKNVOLFWkDR5n4LaUX4W+p0VZDvBap2faOy9r9+0mMyEKOLYqB9lR0xlvS4DgPsLyb
 gpJEorjUu0zfhjnEwNY7rnIngwIA+MdQj+2zBphtQwKyGc/tD7Wln2UxGjzUEtM4IkRb
 zHpDzDMyHJuGhrxI9ohzexAc3EsuPR2qk41NzgRaKpBjt1/z7XRNY8U2sQF0ORhUq94O
 4tbNrtW5YPdKq6NnyYa8nGrFy0ARKjIUhKqCADI8lLUvUZCtti77aCdaLpUeo4XkGsNq
 NQTarGxfc+wTptlMIQ5FgIAjF8ivL+zRlzNC25NybsXCT9GimEaa7TYOJt0wKCKUMGSH
 21sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bzrUXWXJ2P4FPb4Z7Y3jIG7wAqzpJKqykSmKTUKfTsk=;
 b=mmxAcyHN7VWuAotAUJKNzxfEIgASVEAlJQPDmJnfti95cX2DGP8JoD3Ieowk7GxiIf
 wA0l5a254N6nx/a5ZI6nep9BlFgOk1UB1arLdSJu2szC7guwIUC+6R2NlKxyfuvt3FG7
 52ldZNkPCT50lK42u/09cQ8AkxvkPY5DmxplIoUOlGPzO0wY1GkSbWpSCiP9R56uOkHx
 bV/TV1jP5DggJsZqu2ZwCe5A2kFkXIFzv6c5Mpv94BHEHPS6tw4lb6fCLit1bNDJPcdH
 TypKdktbl+MaBr8fZDKckKxcsbJTQio/QTi+72E5LV6IzvQEtbVRcwCOlZmAO31vYWaZ
 /gjw==
X-Gm-Message-State: AOAM533L7lQQ7pBiAIggqy0grZ2sGalz8IYPmqSZkOw4YCX16n0aV+jL
 zJR53Ny/cfux6e9/11OZ6QvhdzF0z2NC13Po
X-Google-Smtp-Source: ABdhPJzDQQSZnlj5kw0bmL0g2BMpQtHBbV62dcuxuWqKkZVOOwA+yMbJCcK3CpM98tRbekGdBxT3Tg==
X-Received: by 2002:a17:90b:4acd:: with SMTP id
 mh13mr5867807pjb.147.1598441468800; 
 Wed, 26 Aug 2020 04:31:08 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v8sm2310878pju.1.2020.08.26.04.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 04:31:07 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [[PATCH v3] 4/5] configure: Fix include and linkage issue on msys2
Date: Wed, 26 Aug 2020 19:30:34 +0800
Message-Id: <20200826113035.1564-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200826113035.1564-1-luoyonggang@gmail.com>
References: <20200826113035.1564-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x641.google.com
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
index b1e11397a8..3b9e79923d 100755
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
@@ -942,7 +952,7 @@ Linux)
   linux="yes"
   linux_user="yes"
   kvm="yes"
-  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
+  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I${build_path}/linux-headers $QEMU_INCLUDES"
   libudev="yes"
 ;;
 esac
@@ -4283,7 +4293,7 @@ EOF
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
           fi
           fdt_cflags="-I${source_path}/dtc/libfdt"
-          fdt_ldflags="-L$PWD/dtc/libfdt"
+          fdt_ldflags="-L${build_path}/dtc/libfdt"
           fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
@@ -5268,7 +5278,7 @@ case "$capstone" in
     else
       LIBCAPSTONE=libcapstone.a
     fi
-    capstone_libs="-L$PWD/capstone -lcapstone"
+    capstone_libs="-L${build_path}/capstone -lcapstone"
     capstone_cflags="-I${source_path}/capstone/include"
     ;;
 
@@ -6268,8 +6278,8 @@ case "$slirp" in
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
@@ -8212,7 +8222,7 @@ fi
 mv $cross config-meson.cross
 
 rm -rf meson-private meson-info meson-logs
-NINJA=$PWD/ninjatool $meson setup \
+NINJA="${build_path}/ninjatool" $meson setup \
         --prefix "${pre_prefix}$prefix" \
         --libdir "${pre_prefix}$libdir" \
         --libexecdir "${pre_prefix}$libexecdir" \
@@ -8232,7 +8242,7 @@ NINJA=$PWD/ninjatool $meson setup \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon \
         $cross_arg \
-        "$PWD" "$source_path"
+        "$build_path" "$source_path"
 
 if test "$?" -ne 0 ; then
     error_exit "meson setup failed"
-- 
2.27.0.windows.1


