Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE6BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F562074A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7xvf/ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F562074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBiM0-0002J4-8v
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kBiKj-0001Zk-9O
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:38:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kBiKh-0007Pt-NM
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:38:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id k20so138839wmi.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/VauukO+yWTDNWGaSiD/K8ASNkuBz1lbLcMe1Hzzu2A=;
 b=a7xvf/baTaUc7+Ss5QEGSDnifhtmWinoTQOpgXfVUZipgu6QbMDvCSVPDtQfV99v+0
 /n8jlHV1xcgVOv069vlxi408aAhelFh9ZE+amMmIR3VLJj1MiUmLZ0/08xDKPcUx+veB
 AlY5QFFJ3nR2ogBCszB/EjaIROQDcvEmDWL84qAvz7OOe+d16FqPWM7EfCzvfSP0a/YG
 Pyhl5vzZkF80+j56RUE9SjolWMPQNojcSK8nMF2d/8dgtkPWmxN7h73WIxpsVTGkQAK0
 DDVxu9/Edup3/K0F5IgzbbfAz6SL8iyh7BUJLffTemM5wJ1Xjo2nA+kiBGE2AiAFSjAr
 J1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/VauukO+yWTDNWGaSiD/K8ASNkuBz1lbLcMe1Hzzu2A=;
 b=GI2uY9LQC79zkjYfjs4rYSYPgz/yG8Qn+J3KLvw7ScJlBOXAKW3wNxbGctCsLPINjW
 esv3DXPMN43MC5H/wuQu+X/i397NoIzuo168F3sUnc8Kyv/H72v3GLaZmiTG31ML1beO
 6bMJUc01Xl21zMtcgWRYWbTqwVQrwls9MvGQqYUtvo88i1upq8OIxXQ7yBb7dFUW2VaD
 MzBsOHLfgqn8DbdVzf3iaJAH/ZrZ6+h9cKTJf0bVBAjeP6Prp+W5VJxU9Ks6B9XDAE5G
 TmrLRq6ZZBP8Eu1RpKKBOsgyu9VocbL4VafshpHP0/PtmPkPA5g9v2dxAFn6nhq3QQ2A
 hy9g==
X-Gm-Message-State: AOAM530HeetNXhvPMtRoANYFx92rDAyAcMa5HTmQq8NfAD9cT9I5eZef
 bNQgJjQ6skxJvosacFSED6dHZJxWq1M=
X-Google-Smtp-Source: ABdhPJxbc84IM+s7gMvluhxYQm/OlE/LG1UWyr+9cnJ6TpGgIADYZi/TiGswZd5rdJBb5jTuXJDUig==
X-Received: by 2002:a1c:2003:: with SMTP id g3mr172353wmg.99.1598636313890;
 Fri, 28 Aug 2020 10:38:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:c924:73d2:e509:7a3f])
 by smtp.gmail.com with ESMTPSA id 70sm143136wme.15.2020.08.28.10.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:38:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: move zlib detection to meson
Date: Fri, 28 Aug 2020 19:38:41 +0200
Message-Id: <20200828173841.33505-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Meson includes the same logic that tries to look for -lz if
pkg-config (and cmake) cannot find zlib.  The undocumented
--disable-zlib-test option becomes a no-op.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile    |  2 +-
 configure   | 32 +-------------------------------
 meson.build |  6 +-----
 3 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/Makefile b/Makefile
index 81794d5c34..1520a2eab5 100644
--- a/Makefile
+++ b/Makefile
@@ -132,7 +132,7 @@ configure: ;
 
 $(call set-vpath, $(SRC_PATH))
 
-LIBS+=-lz $(LIBS_TOOLS)
+LIBS+=$(LIBS_TOOLS)
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
 
diff --git a/configure b/configure
index 6ecaff429b..e035eb2868 100755
--- a/configure
+++ b/configure
@@ -501,7 +501,6 @@ opengl=""
 opengl_dmabuf="no"
 cpuid_h="no"
 avx2_opt=""
-zlib="yes"
 capstone=""
 lzo=""
 snappy=""
@@ -1423,7 +1422,7 @@ for opt do
   ;;
   --enable-usb-redir) usb_redir="yes"
   ;;
-  --disable-zlib-test) zlib="no"
+  --disable-zlib-test)
   ;;
   --disable-lzo) lzo="no"
   ;;
@@ -3898,30 +3897,6 @@ if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
     fi
 fi
 
-#########################################
-# zlib check
-
-if test "$zlib" != "no" ; then
-    if $pkg_config --exists zlib; then
-        zlib_cflags=$($pkg_config --cflags zlib)
-        zlib_libs=$($pkg_config --libs zlib)
-        QEMU_CFLAGS="$zlib_cflags $QEMU_CFLAGS"
-        LIBS="$zlib_libs $LIBS"
-    else
-        cat > $TMPC << EOF
-#include <zlib.h>
-int main(void) { zlibVersion(); return 0; }
-EOF
-        if compile_prog "" "-lz" ; then
-            zlib_libs=-lz
-            LIBS="$LIBS $zlib_libs"
-        else
-            error_exit "zlib check failed" \
-                "Make sure to have the zlib libs and headers installed."
-        fi
-    fi
-fi
-
 ##########################################
 # SHA command probe for modules
 if test "$modules" = yes; then
@@ -7129,11 +7104,6 @@ fi
 if test "$posix_memalign" = "yes" ; then
   echo "CONFIG_POSIX_MEMALIGN=y" >> $config_host_mak
 fi
-if test "$zlib" != "no" ; then
-    echo "CONFIG_ZLIB=y" >> $config_host_mak
-    echo "ZLIB_CFLAGS=$zlib_cflags" >> $config_host_mak
-    echo "ZLIB_LIBS=$zlib_libs" >> $config_host_mak
-fi
 if test "$spice" = "yes" ; then
   echo "CONFIG_SPICE=y" >> $config_host_mak
   echo "SPICE_CFLAGS=$spice_cflags" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 74f8ea0c2e..35e6f8688d 100644
--- a/meson.build
+++ b/meson.build
@@ -134,11 +134,7 @@ if 'CONFIG_AUTH_PAM' in config_host
   pam = cc.find_library('pam')
 endif
 libaio = cc.find_library('aio', required: false)
-zlib = not_found
-if 'CONFIG_ZLIB' in config_host
-  zlib = declare_dependency(compile_args: config_host['ZLIB_CFLAGS'].split(),
-                            link_args: config_host['ZLIB_LIBS'].split())
-endif
+zlib = dependency('zlib', required: true)
 linux_io_uring = not_found
 if 'CONFIG_LINUX_IO_URING' in config_host
   linux_io_uring = declare_dependency(compile_args: config_host['LINUX_IO_URING_CFLAGS'].split(),
-- 
2.26.2


