Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50093C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3792076E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFwYzU8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3792076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gNL-0007O8-BR
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGb-0003HI-AX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGZ-00062Z-Pc
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id r4so15222529wrx.9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pyogagIogekxmBEBJdMiIgfbzL4q1hqCl4ySl4yEPBY=;
 b=nFwYzU8pw35+LOD7sRVbNUWZ/Ll+FdoHmfZoUf3e/xzgJ3gY/8SKJ4UMHKlfphG9OH
 Bg9WOcOwPu9iPf9ZXNQx1DtYHAk56jFjvwHXNTIN3A+HfKxIq/HGogcvrJhIwW09WpDJ
 YJ6O+8T6kh8N0FzHdK+onRSDV629LoqKqi9508qKKzYCF4pqX2+T+LwAeU7Zqz0V2gwz
 tliwI7IhjYnbnah0TPeK2+TXW8XR8ZxKhU113doyrHHiDZaaPfPaaffMgwebWqw0FVH5
 kR/b6IS0z5j7eqD9Q9qITBqA70q9ZoBOwQySWOXHWiO+dRizW5XG3yJDwNpypvCDGZZ7
 CZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pyogagIogekxmBEBJdMiIgfbzL4q1hqCl4ySl4yEPBY=;
 b=SKYiHl1EfY5BIRRKJiwGu9bfyBmUFQ6EuXYyupP+lig6IbwypbLCYa/XQu3d4g+RaR
 JjswSddv/5Zp6eeG4x+hWVvm63WSAwOB7lj1XITJdbulRkVCGAzFZPl6rRlRVhtnhz5L
 enCDj6TiYRpIErDFy0NNeMWwbESGuDguvgwbuBof91K9j0ZTALFhEcdeOiQrLsgAdQvU
 tGoyKWlmKngviQNZzTTTZJN4fMCVT6+CgKsF+cPHz+cpUjq2k6clrieKlhjKAFPZy6J3
 zkiR9iAGdJ1ircdgBKPdOGg+OdV5k/lzUYFgwiEIdaOF3Ai2mKt/z/vl4Y//RzUBIHY9
 0vOw==
X-Gm-Message-State: AOAM531fpjHNPMw6+aK4NvHQ5HVqpZVOaP7mRS7SDzOoQSTJMqBpG2kG
 2KX1jdUb0azRk2ta/UN3P2kcR47iNwc=
X-Google-Smtp-Source: ABdhPJwXnWTOIB1ifU2gcR/t08c16QNwWSqgxhNYmhy9auCxEr4N5UZrtfcDDSVRan+8CKhh4gDFiQ==
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr17183139wrn.60.1597675057950; 
 Mon, 17 Aug 2020 07:37:37 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 011/150] configure: do not include $(...) variables in
 config-host.mak
Date: Mon, 17 Aug 2020 16:35:04 +0200
Message-Id: <20200817143723.343284-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This ensures that Meson will be able to reuse the results of
the tests that are performed in the configure script.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/configure b/configure
index 625c14c500..606c327cca 100755
--- a/configure
+++ b/configure
@@ -610,8 +610,8 @@ QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv -std=gnu99 $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
-QEMU_INCLUDES="-iquote . -iquote \$(SRC_PATH) -iquote \$(SRC_PATH)/accel/tcg -iquote \$(SRC_PATH)/include"
-QEMU_INCLUDES="$QEMU_INCLUDES -iquote \$(SRC_PATH)/disas/libvixl"
+QEMU_INCLUDES="-iquote . -iquote ${source_path} -iquote ${source_path}/accel/tcg -iquote ${source_path}/include"
+QEMU_INCLUDES="$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"
 if test "$debug_info" = "yes"; then
     CFLAGS="-g $CFLAGS"
 fi
@@ -911,7 +911,7 @@ Linux)
   linux="yes"
   linux_user="yes"
   kvm="yes"
-  QEMU_INCLUDES="-isystem \$(SRC_PATH)/linux-headers -isystem $PWD/linux-headers $QEMU_INCLUDES"
+  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
   libudev="yes"
 ;;
@@ -4397,8 +4397,8 @@ EOF
           if [ "$pwd_is_source_path" != "y" ] ; then
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
           fi
-          fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
-          fdt_ldflags="-L\$(BUILD_DIR)/dtc/libfdt"
+          fdt_cflags="-I${source_path}/dtc/libfdt"
+          fdt_ldflags="-L$PWD/dtc/libfdt"
           fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
@@ -5385,13 +5385,13 @@ case "$capstone" in
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
-    libs_cpu="-L\$(BUILD_DIR)/capstone -lcapstone $libs_cpu"
+    libs_cpu="-L$PWD/capstone -lcapstone $libs_cpu"
     ;;
 
   system)
@@ -6414,8 +6414,8 @@ case "$slirp" in
       git_submodules="${git_submodules} slirp"
     fi
     mkdir -p slirp
-    slirp_cflags="-I\$(SRC_PATH)/slirp/src -I\$(BUILD_DIR)/slirp/src"
-    slirp_libs="-L\$(BUILD_DIR)/slirp -lslirp"
+    slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
+    slirp_libs="-L$PWD/slirp -lslirp"
     if test "$mingw32" = "yes" ; then
       slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
     fi
@@ -7909,19 +7909,19 @@ if test "$secret_keyring" = "yes" ; then
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
+  QEMU_INCLUDES="-iquote ${source_path}/tcg/${ARCH} $QEMU_INCLUDES"
 fi
 
 echo "HELPERS=$helpers" >> $config_host_mak
-- 
2.26.2



