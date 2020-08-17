Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08DCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B549205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5BTO75Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B549205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gbq-0005wN-N7
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHB-0004aR-3h
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:17 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH9-0006Ah-Bk
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id f1so15275362wro.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VUHc+xjVtZxJS5B48mMrJNu7pQ1NfcyUU8XDWVv4fn8=;
 b=I5BTO75QKBB4hjD/HPx0ZOsbRoMbbhbCjbasy2Mx4ghI8fQE53c1OCCnGwEUI1RDUs
 VymBGdwoChgro6TBGKgnF03++0neBMwlEzpjvNA6YeET05p3TOqPVN5zdE4wy4HJGvWe
 dltalqcD8U7+JLLpJGQ/Tk+/dVHc37DuGo3Hcgyw+SxZiAlH2YEHfNKX+CpGyJXqu/nZ
 SPe41zdzLbBTFnjD4vEfgkLL3R21MylnhJHT1PI+8ohS+oQwc6t+vk4wFH1Enf7lguPw
 poQEq+8iUCWUjh8iijhqwJnf1kS2MFv7rZ2+S4Cp3ND8MlZP90haXKaLr3kc2kx2/6K5
 kk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VUHc+xjVtZxJS5B48mMrJNu7pQ1NfcyUU8XDWVv4fn8=;
 b=K2V6cifn+YG7Uil4xYV2TVgLkSFthmm9FKKRqzOWVm87UyJLXElSpaMdskZP8dj5IA
 vwGZTqm5i+Y/buw2ImqrHexkyVJm3KBohjINrRuA7sEfh9lOPdUxFBydvK+L6YmYOfqB
 JXAKd0a6IejDRE69UmSip5ERjrl9KD893pxksIvkS1ws44wsuklYqY1oOOEMH5Gc2nDs
 SyO96IC1mVMaZ3SIMHqGdiOnlWBLKMtflCS2L9hILaaX4WFyy8Es/HGxOndc2gUrEiiw
 uMT88dhf+mi4BgdgWgkjKGDPhl0LbGE84/5MjgvdCKI2X9tMJQlaKyjRj6MIKrNSi/OM
 zfwA==
X-Gm-Message-State: AOAM5305vs45U7zghityZ3oJPjuM3Z6kWtksgoOobqlggSrKbr+mauWJ
 l+ALpB5RBRUxBJopWCLZt69QEAke9fg=
X-Google-Smtp-Source: ABdhPJxxnn1imXqYFtmhjSwhY5YGHdY+QxWkOaDj2EX4WOXrnwNpA19TJtW3CmF0f1PjezLkMPSVVw==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr17072298wrp.198.1597675092864; 
 Mon, 17 Aug 2020 07:38:12 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 048/150] meson: generate qemu-version.h
Date: Mon, 17 Aug 2020 16:35:41 +0200
Message-Id: <20200817143723.343284-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                | 27 +--------------------------
 meson.build             | 14 ++++++++++++--
 scripts/qemu-version.sh | 25 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 28 deletions(-)
 create mode 100755 scripts/qemu-version.sh

diff --git a/Makefile b/Makefile
index f36ff09fd3..64255b9d32 100644
--- a/Makefile
+++ b/Makefile
@@ -110,21 +110,7 @@ include $(SRC_PATH)/rules.mak
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
 
@@ -264,17 +250,6 @@ include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
 
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
index ded5dba360..c6b13e1999 100644
--- a/meson.build
+++ b/meson.build
@@ -154,6 +154,7 @@ have_block = have_system or have_tools
 
 # Generators
 
+genh = []
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/commands.py',
@@ -179,6 +180,17 @@ tracetool = [
    '--backend=' + config_host['TRACE_BACKENDS']
 ]
 
+qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
+                    meson.current_source_dir(),
+                    config_host['PKGVERSION'], config_host['VERSION']]
+qemu_version = custom_target('qemu-version.h',
+                             output: 'qemu-version.h',
+                             command: qemu_version_cmd,
+                             capture: true,
+                             build_by_default: true,
+                             build_always_stale: true)
+genh += qemu_version
+
 # Collect sourcesets.
 
 util_ss = ss.source_set()
@@ -279,8 +291,6 @@ trace_events_subdirs += [
   'util',
 ]
 
-genh = []
-
 subdir('qapi')
 subdir('qobject')
 subdir('stubs')
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
2.26.2



