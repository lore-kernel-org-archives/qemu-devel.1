Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7F2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A87521655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIrysAju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A87521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOP6-00039H-9E
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyC-0003Ec-Sr
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyB-0006Ov-I1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:28 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyB-0006Mj-AT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:27 -0500
Received: by mail-wr1-x430.google.com with SMTP id t2so2644323wrr.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=docWwRVWyAXD0RYJhQjYDMkeooVSkVTl6PNsvmqf6gQ=;
 b=pIrysAjuEh2Vl38wspdZzy7pWHqKdwbkuOlNlxWfWKPAj43DX6A+TkVDuPnkvrpwH8
 eIPzCscbMZo0PoizRrAqCppDECs30wQluKvSTZEbjH4De3WjUrB9+Srz8uIo11c8Rgy/
 hI7mSBX++lBTvVBi8iTZOk88etuKBLMRqUfisMuBMvK89yfohQPuyKtPaR8d5k1BeTaF
 oAOEo3qQyvdI3vdBkR+1Vfl6lH7//ih7ELEbAw1MBA53rW70/9n2v8qeIbvZOoxzpcDK
 mB5BPxsOnWCJpgLtskZ3ZzbxykHvRBQLU0Wy+0efIosJSBUP+Brgr3CFhohKSK0MjdNu
 tjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=docWwRVWyAXD0RYJhQjYDMkeooVSkVTl6PNsvmqf6gQ=;
 b=jhV6ibGARtcg0O3S2DId1S8AqzJwLcvAcpgSaQ06KTLRQ5mO8B9LM+89mTw8zdehBR
 u2ovqt/2EndETnz21233Be/b15Y2BV+2ANF8n3J1UXpQbSXXaUuEZb+9/NtR9TTAfCah
 UmXnk3XEw/Jd3BisD7nT1+BvB+/Ub25FQ0n2nDHvKhrlDiissnnffe7L3q0c8SzCMMjr
 Pq4bVzhtlWOZA1t4o7CWm0HO6nj4Uw+0eav0C+qHoNoMgUUlW0aq6xRrUHWdj6pzH3O8
 2ixLLCm06LzbgrEAd0PLVU2FoQe/7EFc4iMq0eITYcuRt7LjBMc7Uy9GJPRP9w7JHnRz
 uXWA==
X-Gm-Message-State: APjAAAXuLHXZmjb7SkniFXp0akdsoD7WZ5CfEqwWO4hos34YB6FkL987
 hGDhvPivCtcELIeIAnCwz/Q6y5ye
X-Google-Smtp-Source: APXvYqwzyCH9poxfALlN14mXhB2j3etl7QN1xS7lVcYUGtHqSseCF2fzrDKO15nfGf4Wql3EtaI0mQ==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr6017558wrm.324.1576155205914; 
 Thu, 12 Dec 2019 04:53:25 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 028/132] meson: generate qemu-version.h
Date: Thu, 12 Dec 2019 13:51:12 +0100
Message-Id: <1576155176-2464-29-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
index d4ebbbf..5d0be7b 100644
--- a/Makefile
+++ b/Makefile
@@ -96,21 +96,7 @@ include $(SRC_PATH)/rules.mak
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
 
@@ -233,17 +219,6 @@ include $(SRC_PATH)/tests/Makefile.include
 
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
index 8a4a90b..6d4bf27 100644
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
index 0000000..4847385
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
1.8.3.1



