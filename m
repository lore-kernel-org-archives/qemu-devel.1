Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C430C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84F72068F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPqLpzhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84F72068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUkl-0001Ep-3Y
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUQs-0008Rz-7k
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:35:54 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:34566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUQq-000139-69
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:35:53 -0400
Received: by mail-pj1-x1031.google.com with SMTP id n3so516284pjq.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8JoKO1thaAqKsTf3f5rAMl9LzUzAtabeXMato26tyMU=;
 b=WPqLpzhAUGWwISLhNeRDdooWOP6rGepR2wI0ilOjDjz6cr2GgPk5oecinY7N1tHqBq
 GHk0MbawMDpSlMOJXXWtZusEL0HKvcM4S6FepdFDvaQGSqf0brlctxxISa4Ei00utmdU
 O+1MRC7GmM+HRlBKVyXRRp3pi0KIWXJV4d1EVV90lubP+ZAOswrC1oZQnq43rkjm2CQD
 0YmrLaksZY714wnU6hdHZeUcEJvIsJEBC8Qa13C/95M30w5fMExRfG0ac50v+xXyA6jU
 S+32l4iFTDymSevm7rUWb57jMxFLslSkrw8wJJNsDdFeIl5Oa/Nk0u7SJNJGA4f+mB+c
 tkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8JoKO1thaAqKsTf3f5rAMl9LzUzAtabeXMato26tyMU=;
 b=mS2IBuV3An1/vk15YuWkbeyEdDS0wGqNqJcw8/pXbQD220+xmjYNwR/0pwb0GoLAxJ
 E98A5nMlvi5rhofjR0L2KLYZ+SXAmGTEYHwGozhJ5ZM7HYQgcbLvLv1C8dZPdEHNrO6W
 ys4Gst99lugudrcpgNiCde57mroXL2QUIsnG2b6WZW9kIp+T0mVxmMpAU3L56eXVtSZ3
 yQJfjuVssV5CDNoVGvoVQowDVo1cjqI8BityWgstbVq4bC3Bl67euYyg5CHYHtW+ssPw
 ovtsZQq9WQcCwZqwvpJI0MjqvIeuo7h61+QpE3irc2Zp2BRenwGeB82QKClGdUTSlok4
 HeIw==
X-Gm-Message-State: AOAM532YFwDD9v+P19jneo2X0fWqLY1XDONsU/9CNmyAQJm1aNByO8W4
 YgY4WliRzpUPBuIRpxmUyEnuEK3ej+d+oafn
X-Google-Smtp-Source: ABdhPJyKVK5ZHJRA6UX4Hc/mbkXky5NWQwmwc00098qtNJuLlPsc3nrcrAwtoSjeKxiPkj2HgJlcgA==
X-Received: by 2002:a17:90a:a590:: with SMTP id
 b16mr716865pjq.131.1598344550285; 
 Tue, 25 Aug 2020 01:35:50 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id bn14sm1146683pjb.0.2020.08.25.01.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 01:35:49 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] configure: replace all $PWD with $build_path that can
 handling msys2 properly
Date: Tue, 25 Aug 2020 16:35:00 +0800
Message-Id: <20200825083500.359-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200825083500.359-1-luoyonggang@gmail.com>
References: <20200825083500.359-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Yonggang Luo <luoyonggang@gmail.com>

---
 configure | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index b8f5b81a67..a0e2b20877 100755
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
@@ -4299,7 +4309,7 @@ EOF
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
           fi
           fdt_cflags="-I${source_path}/dtc/libfdt"
-          fdt_ldflags="-L$PWD/dtc/libfdt"
+          fdt_ldflags="-L${build_path}/dtc/libfdt"
           fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
@@ -5284,7 +5294,7 @@ case "$capstone" in
     else
       LIBCAPSTONE=libcapstone.a
     fi
-    capstone_libs="-L$PWD/capstone -lcapstone"
+    capstone_libs="-L${build_path}/capstone -lcapstone"
     capstone_cflags="-I${source_path}/capstone/include"
     ;;
 
@@ -6284,8 +6294,8 @@ case "$slirp" in
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
@@ -8233,7 +8243,7 @@ fi
 mv $cross config-meson.cross
 
 rm -rf meson-private meson-info meson-logs
-NINJA=$PWD/ninjatool $meson setup \
+NINJA="${build_path}/ninjatool" $meson setup \
         --prefix "${pre_prefix}$prefix" \
         --libdir "${pre_prefix}$libdir" \
         --libexecdir "${pre_prefix}$libexecdir" \
@@ -8249,11 +8259,11 @@ NINJA=$PWD/ninjatool $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dsdl=$sdl -Dsdl_image=$sdl_image \
-	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext \
+        -Dsdl=$sdl -Dsdl_image=$sdl_image \
+        -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
+        -Dgettext=$gettext \
         $cross_arg \
-        "$PWD" "$source_path"
+        "$build_path" "$source_path"
 
 if test "$?" -ne 0 ; then
     error_exit "meson setup failed"
-- 
2.27.0.windows.1


