Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6548BC3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E0A2468E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/XLUxWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E0A2468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWFT-0004s2-EK
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8T-00053H-15
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8R-0001Oq-MP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:48 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8R-0001M3-EA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:47 -0500
Received: by mail-wr1-x42e.google.com with SMTP id y17so17117330wrh.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p1Zihj/GqyEcMAsZS8ZsodZ02ptkYWUxedNuRcGDcM8=;
 b=A/XLUxWNA2oRXGV8vvn8CjNcdZ3odFrhrvniXPj3S6O4bsAjSB7MASdeHaOvOsaZXP
 dUnrW/wCiO65qvAv3RbCvd64qGe6bS+43vgnWtLNZteuibJZ9MftpmiY4O32Zm9BH4bd
 PAq4fGU3K529b+6eKy0LlvrtoMg5mkbVP6bhpynHzudY8xBt3d9DEHaz9MzrUIuNXf94
 QhhfqffCSa5H7atgH0zBvd78SG8OcE79fjhYcq8R+w4Xh0UzWsm+C2zQ/A5umxFJt00R
 oiuN5D4CM2rMDk5F1BFlOzEd1a3goUMcfrsm9NFE+hWJVgDVJSQAPNP5suHgSbUbICmx
 MjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=p1Zihj/GqyEcMAsZS8ZsodZ02ptkYWUxedNuRcGDcM8=;
 b=JxiCvzipLef3pGzLbgBHmCmsK2CBHNR9AKI9+5laKDG+kpbH+Yg6MGq9WkxOOGfUgH
 +p2O4241Ajlrzqhf7HcdMPTabbQmiz8OOm9gFXQFr4/SyvKZ+pbroqNDbI/p6P+RqSOw
 s/xvabj5VLpwwQ1ae4prB0cDcxCFF8CpLherYo2X3BhokLuV/7hFVBjoM5xwxvC7rZ9e
 09f41mg6hgYYT4QkWm6Zeko+vzyTcasB1EgzjH3u3do9zaM4EJBl0qAKUbMTnVZodMxK
 6ee9vix2UldTg42zihKvzULRNO57SFRhII7GZHbI6Qb5Efsp1wCq4R6Q0cD93BpHUjJT
 L/3g==
X-Gm-Message-State: APjAAAUGzlPWqeERGgLCBuD2zue2aiOHQdZIDOQzhAWr6k019cA/Kvps
 DloLOI9S/O7CqicMdLL+v51Dwo8C
X-Google-Smtp-Source: APXvYqwK/HxSrMzaCXy70OWOusX0G7LaO25YIpoBovJxh3wHWX05rnPSpEq8an0icxkfWsUv5qrWbg==
X-Received: by 2002:adf:b193:: with SMTP id q19mr29578702wra.78.1580234326266; 
 Tue, 28 Jan 2020 09:58:46 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 126/142] meson: add NSIS building
Date: Tue, 28 Jan 2020 18:53:26 +0100
Message-Id: <20200128175342.9066-127-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile        | 57 ------------------------------------------------
 meson.build     | 23 ++++++++++++++++++++
 scripts/nsis.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 57 deletions(-)
 create mode 100755 scripts/nsis.sh

diff --git a/Makefile b/Makefile
index e99d09c5ee..7c1e6d9e9c 100644
--- a/Makefile
+++ b/Makefile
@@ -310,62 +310,6 @@ endif
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
 
-ifdef CONFIG_WIN32
-
-INSTALLER = qemu-setup-$(VERSION)$(EXESUF)
-
-nsisflags = -V2 -NOCD
-
-ifneq ($(wildcard $(SRC_PATH)/dll),)
-ifeq ($(ARCH),x86_64)
-# 64 bit executables
-DLL_PATH = $(SRC_PATH)/dll/w64
-nsisflags += -DW64
-else
-# 32 bit executables
-DLL_PATH = $(SRC_PATH)/dll/w32
-endif
-endif
-
-.PHONY: installer
-installer: $(INSTALLER)
-
-INSTDIR=/tmp/qemu-nsis
-
-$(INSTALLER): $(SRC_PATH)/qemu.nsi
-	$(MAKE) install prefix=${INSTDIR}
-ifdef SIGNCODE
-	(cd ${INSTDIR}; \
-         for i in *.exe; do \
-           $(SIGNCODE) $${i}; \
-         done \
-        )
-endif # SIGNCODE
-	(cd ${INSTDIR}; \
-         for i in qemu-system-*.exe; do \
-           arch=$${i%.exe}; \
-           arch=$${arch#qemu-system-}; \
-           echo Section \"$$arch\" Section_$$arch; \
-           echo SetOutPath \"\$$INSTDIR\"; \
-           echo File \"\$${BINDIR}\\$$i\"; \
-           echo SectionEnd; \
-         done \
-        ) >${INSTDIR}/system-emulations.nsh
-	makensis $(nsisflags) \
-                $(if $(BUILD_DOCS),-DCONFIG_DOCUMENTATION="y") \
-                $(if $(CONFIG_GTK),-DCONFIG_GTK="y") \
-                -DBINDIR="${INSTDIR}" \
-                $(if $(DLL_PATH),-DDLLDIR="$(DLL_PATH)") \
-                -DSRCDIR="$(SRC_PATH)" \
-                -DOUTFILE="$(INSTALLER)" \
-                -DDISPLAYVERSION="$(VERSION)" \
-                $(SRC_PATH)/qemu.nsi
-	rm -r ${INSTDIR}
-ifdef SIGNCODE
-	$(SIGNCODE) $(INSTALLER)
-endif # SIGNCODE
-endif # CONFIG_WIN
-
 # Add a dependency on the generated files, so that they are always
 # rebuilt before other object files
 ifneq ($(wildcard config-host.mak),)
@@ -405,7 +349,6 @@ endif
 	@echo  ''
 ifdef CONFIG_WIN32
 	@echo  'Windows targets:'
-	@echo  '  installer       - Build NSIS-based installer for QEMU'
 ifdef QEMU_GA_MSI_ENABLED
 	@echo  '  msi             - Build MSI-based installer for qemu-ga'
 endif
diff --git a/meson.build b/meson.build
index caf99f5082..6d1fc2fb19 100644
--- a/meson.build
+++ b/meson.build
@@ -1064,3 +1064,26 @@ if pod2man.found() and build_docs
                                   '--release=" "', '@INPUT@'])
   endforeach
 endif
+
+if host_machine.system() == 'windows'
+  nsis_cmd = [
+    find_program('scripts/nsis.sh'),
+    '@OUTPUT@',
+    get_option('prefix'),
+    meson.current_source_dir(),
+    host_machine.cpu_family(),
+    '-DDISPLAYVERSION=@0@'.format(config_host['VERSION']),
+  ]
+  if build_docs
+    nsis_cmd += '-DCONFIG_DOCUMENTATION=y'
+  endif
+  if 'CONFIG_GTK' in config_host
+    nsis_cmd += '-DCONFIG_GTK=y'
+  endif
+
+  custom_target('nsis',
+                output: 'qemu-setup-' + config_host['VERSION'] + '.exe',
+                input: files('qemu.nsi'),
+                build_always_stale: true,
+                command: nsis_cmd + ['@INPUT@'])
+endif
diff --git a/scripts/nsis.sh b/scripts/nsis.sh
new file mode 100755
index 0000000000..ad23708724
--- /dev/null
+++ b/scripts/nsis.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+
+OUTFILE="$1"
+shift
+PREFIX="$1"
+shift
+SRCDIR="$1"
+shift
+CPU="$1"
+shift
+
+DESTDIR=$(mktemp -d)
+trap "rm -rf $DESTDIR" EXIT
+make DESTDIR="$DESTDIR" install
+
+signcode() {
+    if [ -z "$SIGNCODE" ]; then
+        return
+    fi
+    "$SIGNCODE" "$@"
+}
+
+shopt -s nullglob
+
+(
+    cd "$DESTDIR$PREFIX"
+    for i in qemu-system-*.exe; do
+        arch=${i%.exe}
+        arch=${arch#qemu-system-}
+        echo Section \"$arch\" Section_$arch
+        echo SetOutPath \"\$INSTDIR\"
+        echo File \"\${BINDIR}\\$i\"
+        echo SectionEnd
+    done
+) > "$DESTDIR$PREFIX/system-emulations.nsh"
+
+(
+    cd "$DESTDIR$PREFIX"
+    for i in *.exe; do
+        signcode "$i"
+    done
+)
+
+if [ "$CPU" = "x86_64" ]; then
+    CPUARG="-DW64"
+    DLLDIR="w64"
+else
+    DLLDIR="w32"
+fi
+
+if [ -d "$SRCDIR/dll" ]; then
+   DLLARG="-DDLLDIR=$SRCDIR/dll/$DLLDIR"
+fi
+
+makensis -V2 -NOCD -DSRCDIR="$SRCDIR" -DBINDIR="$DESTDIR$PREFIX" \
+         $CPUARG $DLLARG -DOUTFILE="$OUTFILE" "$@"
+
+signcode "$OUTFILE"
-- 
2.21.0



