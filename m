Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEBFC3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A662467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk/nuWjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A662467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVZf-0008F1-N6
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV50-0007mY-Lu
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4x-0001Su-Bf
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:13 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4w-0001Pf-U2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:11 -0500
Received: by mail-wr1-x42e.google.com with SMTP id j104so1194978wrj.7
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+PRwhO35mAAi2GwkKyXhmnr9zSDCkYdOi56nsRT+0tI=;
 b=nk/nuWjMpMnKXBWo4fMsQOMIs8msHBuy4OVTPuHK8aBhDziJzV+EIzQfE5twBRuoUQ
 acokM9YWrWJYI5IoS1Bc0vfExIgdEjPCZNz89BNz3aYe54JnXvKSf9a5K9X7M2eRgXBG
 w6kI7w12kJ+GsxctqRuWevx9P4GfhNndmsEJetoO0yvY10rbyDcUGHVC8c8v6i0GeSKy
 XtLRPxn+7Gdi5ytdZ6bOCLxz5yYNyYDPwOsxEiFOXI8M+wVnGVsqIK0pUihCkF0DW2zX
 wEJ6X2kmacwQs4MeUWilGgMlZb4txB8GBtGMoaMUN2kFnQRmuM4mlUhnR9fQ6ublIn/J
 Bk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+PRwhO35mAAi2GwkKyXhmnr9zSDCkYdOi56nsRT+0tI=;
 b=C/eZ1r6RqkhBIY2vJgcajU5Jr30ZlUdOHEGy9Q2NvJYv5xdNoLVanZeauKu41D+1BQ
 MHVE2s3NokCxKslpDaJ3Ja3hSlogCL3P3IzhtJiyYXJhlwIMYwmzwmi+67IBxEg4vEDk
 tv9FKpxXemTsducjZUGTl+XsTFCpKY2U1NKUvWPzmW9tohj9muzSlZ3/Hvw/jF3ZyHFK
 WQXq5NOD4UWw3iIpELbuPDsrxwmzfQMvd3N9BM35vYv82MYp5Zdhvw4WLrC+lMk9/LkS
 aJW/CgdWg2oO0jJU80d4FeHPAume+RGlPx35PQ5Ykn17Xa1C01KderPz+ZEbC4sl/QqA
 VQ4Q==
X-Gm-Message-State: APjAAAUXYv+OzUMjVYscu7OTiu191wKqajS+/PYxkxQIdfCh3Ev1v3uR
 5758uiXynlR9UTdc6FnLrvDuzC0Z
X-Google-Smtp-Source: APXvYqyfAjpfZcam8weYzst7OWwnfpOB9MKDDpP8fJ/JHdORsvfLVig3IRW6ySrUKq2kujJWAKcvhg==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr31543100wrp.12.1580234108712; 
 Tue, 28 Jan 2020 09:55:08 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 033/142] meson: generate qemu-version.h
Date: Tue, 28 Jan 2020 18:51:53 +0100
Message-Id: <20200128175342.9066-34-pbonzini@redhat.com>
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                | 27 +--------------------------
 meson.build             | 10 ++++++++++
 scripts/qemu-version.sh | 25 +++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 26 deletions(-)
 create mode 100755 scripts/qemu-version.sh

diff --git a/Makefile b/Makefile
index 54249c6fc2..b77014faa4 100644
--- a/Makefile
+++ b/Makefile
@@ -106,21 +106,7 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-# Create QEMU_PKGVERSION and FULL_VERSION strings
-# If PKGVERSION is set, use that; otherwise get version and -dirty status from git
-QEMU_PKGVERSION := $(if $(PKGVERSION),$(PKGVERSION),$(shell \
-  cd $(SRC_PATH); \
-  if test -e .git; then \
-    git describe --match 'v*' 2>/dev/null | tr -d '\n'; \
-    if ! git diff-index --quiet HEAD &>/dev/null; then \
-      echo "-dirty"; \
-    fi; \
-  fi))
-
-# Either "version (pkgversion)", or just "version" if pkgversion not set
-FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSION))
-
-generated-files-y = qemu-version.h config-host.h qemu-options.def
+generated-files-y = config-host.h qemu-options.def
 
 generated-files-y += module_block.h
 
@@ -256,17 +242,6 @@ include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules $(vhost-user-json-y)
 
-qemu-version.h: FORCE
-	$(call quiet-command, \
-                (printf '#define QEMU_PKGVERSION "$(QEMU_PKGVERSION)"\n'; \
-		printf '#define QEMU_FULL_VERSION "$(FULL_VERSION)"\n'; \
-		) > $@.tmp)
-	$(call quiet-command, if ! cmp -s $@ $@.tmp; then \
-	  mv $@.tmp $@; \
-	 else \
-	  rm $@.tmp; \
-	 fi)
-
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
diff --git a/meson.build b/meson.build
index 5cde258529..afa53bee00 100644
--- a/meson.build
+++ b/meson.build
@@ -18,6 +18,16 @@ add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
                       language: ['c', 'cpp'])
 
+qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
+                    meson.current_source_dir(),
+                    config_host['PKGVERSION'], config_host['VERSION']]
+qemu_version = custom_target('QEMU version',
+                             output: 'qemu-version.h',
+                             command: qemu_version_cmd,
+                             capture: true,
+                             build_by_default: true,
+                             build_always_stale: true)
+
 configure_file(input: files('scripts/ninjatool.py'),
                output: 'ninjatool',
                configuration: config_host)
diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
new file mode 100755
index 0000000000..4847385e42
--- /dev/null
+++ b/scripts/qemu-version.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+set -eu
+
+dir="$1"
+pkgversion="$2"
+version="$3"
+
+if [ -z "$pkgversion"]; then
+    cd "$dir"
+    if [ -e .git ]; then
+        pkgversion=$(git describe --match 'v*' --dirty | echo "")
+    fi
+fi
+
+if [ -n "$pkgversion" ]; then
+    fullversion="$version ($pkgversion)"
+else
+    fullversion="$version"
+fi
+
+cat <<EOF
+#define QEMU_PKGVERSION "$pkgversion"
+#define QEMU_FULL_VERSION "$fullversion"
+EOF
-- 
2.21.0



