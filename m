Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE749C74A2B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FD82086D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6ye2E6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FD82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFOz-0006VD-1w
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFEr-00067C-IW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFEo-0007Qb-Fo
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hlFEo-0007Oe-8h
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id l2so2894378wmg.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UJ4snQpyLIajOpVuepAKxpe0AF5m5e4v2GGBflH9o3k=;
 b=E6ye2E6Ar5gTiTv87VxWno2Rs3+6gvOD32Yxj0C2S7a+yXlMCqI8V9laOP7RQlB2LU
 /ohJuAAuIhx8TsLbVCR67vpVnksseVbfkDnoZLymwLP96DY1FNqdIhsyEaBEvACO9edW
 dq9BfUMVqazmjgP5+17X/2TPva3tYZvFbpp6QJwfp3IpMJtYyP0jstF0a34ePGDawwed
 eN8JH8e3yygVmVjUrTvs26Hpt2awRf2XVASAgZVzL9UvFSO4r8KLwgIe4VXgEIsecfv2
 DSXLE+J/tzCFJLfjNkl83GxshK25Kuk4h4SD/D6L99Z4IGl8mDgFfg0/HzVgNnGTpltP
 NkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=UJ4snQpyLIajOpVuepAKxpe0AF5m5e4v2GGBflH9o3k=;
 b=bVV3nyN/o+WB4o6SllOgHlX616aQ+JYZqQ71CM0SdvfVLtN0wSdGrDDdWcwNSkTtj5
 nmLvIOCeRAnOtzYN3XMpx6yT3rZLDix0vGdat9Q2K+QGsnd6P4UUD5ufaT5jh9UT/Pun
 ZbnjTGJ8xVedBIXFwNIXXOieiSDZMAe6KGaIwzMHYBN4ukE6+pMu9pUZTuPCGkuCGkZW
 CSC+oKKp3cmKnbfYkO7eDjPUE834Rg4WXsP4phwfbuLCUM/GBTip2B9YTLcV9Dsb28mx
 zVRbs/cQFzzx6wAXJntXhQuMlsGfmCX4n52e8fF/gbdQ72VI+TMp1pG+a67om76hrQlU
 usxA==
X-Gm-Message-State: APjAAAXB0bjebqI+DHPKRuK8w+dvN+eUWd1j6VgFRpQV3JqVT1XNEVG2
 MfCdAJPTodBcy51WnoF69v/Dj/dJxlQ=
X-Google-Smtp-Source: APXvYqx3qapk+wOirxHT0V3YiEno928Dahkc9Zh8nxmDqSeK/tYT2mFnh8uj0ukMl3Qc/RiHfbneRQ==
X-Received: by 2002:a1c:c542:: with SMTP id v63mr5881155wmf.97.1562775271522; 
 Wed, 10 Jul 2019 09:14:31 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w14sm2573747wrk.44.2019.07.10.09.14.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 09:14:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 18:14:20 +0200
Message-Id: <1562775267-1222-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 1/8] configure: do not include $(...) variables
 in config-host.mak
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This ensures that Meson will be able to reuse the results of
the tests that are performed in the configure script.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/configure b/configure
index 5c79145..b0b8bdd 100755
--- a/configure
+++ b/configure
@@ -597,7 +597,7 @@ QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv -std=gnu99 $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
-QEMU_INCLUDES="-iquote . -iquote \$(SRC_PATH) -iquote \$(SRC_PATH)/accel/tcg -iquote \$(SRC_PATH)/include"
+QEMU_INCLUDES="-iquote . -iquote ${source_path} -iquote ${source_path}/accel/tcg -iquote ${source_path}/include"
 if test "$debug_info" = "yes"; then
     CFLAGS="-g $CFLAGS"
     LDFLAGS="-g $LDFLAGS"
@@ -896,7 +896,7 @@ Linux)
   linux="yes"
   linux_user="yes"
   kvm="yes"
-  QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
+  QEMU_INCLUDES="-I${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
   libudev="yes"
 ;;
@@ -4081,8 +4081,8 @@ EOF
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
               symlink "$source_path/dtc/scripts" "dtc/scripts"
           fi
-          fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
-          fdt_ldflags="-L\$(BUILD_DIR)/dtc/libfdt"
+          fdt_cflags="-I${source_path}/dtc/libfdt"
+          fdt_ldflags="-L$PWD/dtc/libfdt"
           fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
@@ -5031,13 +5031,13 @@ case "$capstone" in
       git_submodules="${git_submodules} capstone"
     fi
     mkdir -p capstone
-    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include"
+    QEMU_CFLAGS="$QEMU_CFLAGS -I${source_path}/capstone/include"
     if test "$mingw32" = "yes"; then
       LIBCAPSTONE=capstone.lib
     else
       LIBCAPSTONE=libcapstone.a
     fi
-    LIBS="-L\$(BUILD_DIR)/capstone -lcapstone $LIBS"
+    LIBS="-L$PWD/capstone -lcapstone $LIBS"
     ;;
 
   system)
@@ -5942,8 +5942,8 @@ case "$slirp" in
       git_submodules="${git_submodules} slirp"
     fi
     mkdir -p slirp
-    slirp_cflags="-I\$(SRC_PATH)/slirp/src -I\$(BUILD_DIR)/slirp/src"
-    slirp_libs="-L\$(BUILD_DIR)/slirp -lslirp"
+    slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
+    slirp_libs="-L$PWD/slirp -lslirp"
     ;;
 
   system)
@@ -7288,21 +7288,21 @@ if test "$sheepdog" = "yes" ; then
 fi
 
 if test "$tcg_interpreter" = "yes"; then
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/sparc $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/sparc $QEMU_INCLUDES"
 elif test "$ARCH" = "s390x" ; then
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/s390 $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/s390 $QEMU_INCLUDES"
 elif test "$ARCH" = "x86_64" || test "$ARCH" = "x32" ; then
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/i386 $QEMU_INCLUDES"
 elif test "$ARCH" = "ppc64" ; then
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/ppc $QEMU_INCLUDES"
 elif test "$ARCH" = "riscv32" || test "$ARCH" = "riscv64" ; then
-  QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/riscv $QEMU_INCLUDES"
+  QEMU_INCLUDES="-I${source_path}/tcg/riscv $QEMU_INCLUDES"
 else
-  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/\$(ARCH) $QEMU_INCLUDES"
 fi
-QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg $QEMU_INCLUDES"
+QEMU_INCLUDES="-iquote ${source_path}/tcg $QEMU_INCLUDES"
 
 echo "TOOLS=$tools" >> $config_host_mak
 echo "ROMS=$roms" >> $config_host_mak
-- 
1.8.3.1



