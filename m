Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2149BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56122467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMfOO7BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56122467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVq5-0000Ku-3H
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5R-000097-2S
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5O-0002Ub-GJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:39 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5O-0002SN-9E
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:38 -0500
Received: by mail-wr1-x434.google.com with SMTP id b6so17135176wrq.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4FrtgOEgXUNdCIxcJwPPgUbqVBramadjIg8sg/wlU/w=;
 b=JMfOO7BRH2CQRxl7c66XmYqpy9f2tBsxn1aHxCON0L0Q5lgs4WyD2m3sPdlczN4fvN
 2SWpxXa9t9+0vkWlwUPzNo1v9HL5F2Govm8tjQid/P1u7aXzoycI6VjYzmTDPXvteVCs
 VKU2P9wGhe29C4C5b4SgLhlXOIe4siTJ4ct1IE+ey9fHCPzHM346nexKvsh6SN/3Ipr3
 xCvKXgD3qrkzELcO9faxNZ/EV8CjF3lL6f65MyQSLW9GXiy+dfiU3A1xLNxp314Ks3/5
 NPdKzaBpa4lsaWmN5K+UCwDA3t4iIw2a1CEcI0MUMA1ZQO4ikH/R4PJoq28Qv5iiaGdZ
 9s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4FrtgOEgXUNdCIxcJwPPgUbqVBramadjIg8sg/wlU/w=;
 b=Rc3d50M0UEMCqrh9VmsXzU0Vgs8oqeZtaRBrwRV/nZD1/NVw1rsXQSU+9jmuxrPlZL
 ak84Geniwdpe0KxeqARYvZo9tuMUk6Qr+2W6kARzxUMqwVF4PO2ybhLkGG+yQWkgh/uB
 7OFBy+d3cKOYYxp5G0FCExKiPb2Wzfdh2WDRF9+jXupEElAAAFCcUUSOv64Y3rzWSMPT
 msjPBvxVOcfz+bc00GFAw6oWEfWFBF9ayOPLiO2tAnafvfuiCM2BlTahiOAmIYZuaHLz
 xED+hgmv7x8UAcN/57o0b1nWGuMC65Jrvmt/lpdzlRb8VoOZv7kpSMHfrslg8XKgb2s8
 ugqA==
X-Gm-Message-State: APjAAAWehLIwvzknGQEQQDnVj7CkyIDeIZYNBuFstrMJDpCcnXYZp5cG
 bjIpb5WOLJOp8RqzJxFp/ZExN3Pn
X-Google-Smtp-Source: APXvYqxT81owh67o8473189upClJq5oNaBWgKsvFjFyC6JzQrigA3+367al4udd53zWM0DBdyHiwNA==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr28435450wrt.136.1580234137022; 
 Tue, 28 Jan 2020 09:55:37 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 046/142] meson: add modules infrastructure
Date: Tue, 28 Jan 2020 18:52:06 +0100
Message-Id: <20200128175342.9066-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 Makefile            | 10 +--------
 Makefile.target     |  6 +++++
 meson.build         | 53 +++++++++++++++++++++++++++++++++++++++++++++
 rules.mak           | 10 ++++-----
 scripts/undefsym.sh | 20 +++++++++++++++++
 5 files changed, 85 insertions(+), 14 deletions(-)
 create mode 100755 scripts/undefsym.sh

diff --git a/Makefile b/Makefile
index af62f4ed9d..0152a2b397 100644
--- a/Makefile
+++ b/Makefile
@@ -237,7 +237,7 @@ subdir-capstone: capstone/all
 subdir-slirp: slirp/all
 
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
-	$(qom-obj-y)
+	$(qom-obj-y) block.syms qemu.syms
 
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
@@ -438,14 +438,6 @@ install: all $(if $(BUILD_DOCS),install-doc) \
 ifneq ($(TOOLS),)
 	$(call install-prog,$(TOOLS),$(DESTDIR)$(bindir))
 endif
-ifneq ($(CONFIG_MODULES),)
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_moddir)"
-	for s in $(modules-m:.mo=$(DSOSUF)); do \
-		t="$(DESTDIR)$(qemu_moddir)/$$(echo $$s | tr / -)"; \
-		$(INSTALL_LIB) $$s "$$t"; \
-		test -z "$(STRIP)" || $(STRIP) "$$t"; \
-	done
-endif
 ifneq ($(HELPERS-y),)
 	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
 endif
diff --git a/Makefile.target b/Makefile.target
index 13e21b0c44..acde7778f0 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -163,6 +163,12 @@ obj-y += memory_mapping.o
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
+# Temporary until emulators are linked by Meson
+LIBS := $(LIBS) @../block.syms @../qemu.syms
+ifneq ($(CONFIG_MODULES),y)
+LIBS := $(LIBS)
+endif
+
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
 obj-y += hw/sparc64/
diff --git a/meson.build b/meson.build
index 3c398d1bf5..1702133989 100644
--- a/meson.build
+++ b/meson.build
@@ -6,6 +6,8 @@ ss = import('sourceset')
 config_host = kconfig.load(meson.current_build_dir() / 'config-host.mak')
 config_all_disas = kconfig.load(meson.current_build_dir() / 'config-all-disas.mak')
 
+enable_modules = 'CONFIG_MODULES' in config_host
+
 add_project_arguments(config_host['CFLAGS'].split(),
                       language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
@@ -278,6 +280,7 @@ endforeach
 util_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
+block_ss = ss.source_set()
 common_ss = ss.source_set()
 softmmu_ss = ss.source_set()
 user_ss = ss.source_set()
@@ -285,6 +288,7 @@ bsd_user_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 specific_ss = ss.source_set()
 
+modules = {}
 hw_arch = {}
 target_arch = {}
 target_softmmu_arch = {}
@@ -388,6 +392,12 @@ subdir('authz')
 subdir('crypto')
 subdir('ui')
 
+
+if enable_modules
+  libmodulecommon = static_library('module-common', files('module-common.c') + genh, pic: true, c_args: '-DBUILD_DSO')
+  modulecommon = declare_dependency(link_whole: libmodulecommon, compile_args: '-DBUILD_DSO')
+endif
+
 # Build targets from sourcesets
 
 stub_ss = stub_ss.apply(config_host, strict: false)
@@ -404,6 +414,49 @@ subdir('io')
 subdir('fsdev')
 subdir('target')
 
+mods = []
+block_mods = []
+softmmu_mods = []
+foreach d, list : modules
+  foreach m : list
+    if enable_modules and host_machine.system() != 'windows'
+      sl = static_library(d + '-' + m[0], m[1], dependencies: [m[2], modulecommon], pic: true)
+      if d == 'block'
+        block_mods += sl
+      else
+        softmmu_mods += sl
+      endif
+      mods += {'dir': d, 'name': m[0], 'lib': sl, 'deps': m[2]}
+    else
+      if d == 'block'
+        block_ss.add(when: m[2], if_true: m[1])
+      else
+        softmmu_ss.add(when: m[2], if_true: m[1])
+      endif
+    endif
+  endforeach
+endforeach
+
+nm = find_program('nm')
+undefsym = find_program('scripts/undefsym.sh')
+block_syms = custom_target('block.syms', output: 'block.syms',
+                             input: [libqemuutil, block_mods],
+                             capture: true,
+                             command: [undefsym, nm, '@INPUT@'])
+qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
+                             input: [libqemuutil, softmmu_mods],
+                             capture: true,
+                             command: [undefsym, nm, '@INPUT@'])
+
+
+foreach m : mods
+  shared_module(m['dir'] + '-' + m['name'],
+                name_prefix: '',
+                link_whole: [m['lib']],
+                install: true,
+                install_dir: config_host['qemu_moddir'])
+endforeach
+
 common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: softmmu_ss)
 common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 
diff --git a/rules.mak b/rules.mak
index 9dd3b7e2ec..8571aec190 100644
--- a/rules.mak
+++ b/rules.mak
@@ -61,17 +61,17 @@ endif
 # This is necessary because the exectuable itself may not use the function, in
 # which case the function would not be linked in. Then the DSO loading will
 # fail because of the missing symbol.
-process-archive-undefs = $(filter-out %.a %.fa %.mo,$1) \
+process-archive-undefs = $(filter-out %.a %.fa %.mo %$(DSOSUF),$1) \
                 $(addprefix $(WL_U), \
                      $(filter $(call defined-symbols,$(filter %.a %.fa, $1)), \
-                              $(call undefined-symbols,$(filter %.mo,$1)))) \
+		$(call undefined-symbols,$(filter %.mo %$(DSOSUF),$1)))) \
 		$(foreach l,$(filter %.fa,$1),$(call whole-archive,$l)) \
 		$(filter %.a,$1)
 
-extract-libs = $(strip $(foreach o,$(filter-out %.mo,$1),$($o-libs)))
+extract-libs = $(strip $(foreach o,$(filter-out %.mo %$(DSOSUF),$1),$($o-libs)))
 expand-objs = $(strip $(sort $(filter %.o,$1)) \
-                  $(foreach o,$(filter %.mo,$1),$($o-objs)) \
-                  $(filter-out %.o %.mo,$1))
+		$(foreach o,$(filter %.mo %$(DSOSUF),$1),$($o-objs)) \
+		$(filter-out %.o %.mo %$(DSOSUF),$1))
 
 %.o: %.c
 	@mkdir -p $(dir $@)
diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh
new file mode 100755
index 0000000000..d4871f0b35
--- /dev/null
+++ b/scripts/undefsym.sh
@@ -0,0 +1,20 @@
+#! /bin/bash
+
+# Before a shared module's DSO is produced, a static library is built for it
+# and passed to this script.  The script generates -Wl,-u options to force
+# the inclusion of symbol from libqemuutil.a if the shared modules need them,
+# This is necessary because the modules may use functions not needed by the
+# executable itself, which would cause the function to not be linked in.
+# Then the DSO loading would fail because of the missing symbol.
+
+if test $# -le 2; then
+  exit 0
+fi
+
+NM=$1
+staticlib=$2
+shift 2
+# Find symbols defined in static libraries and undefined in shared modules
+comm -12 \
+  <( $NM -P -g $staticlib | awk '$2!="U"{print "-Wl,-u," $1}' | sort -u) \
+  <( $NM -P -g "$@" | awk '$2=="U"{print "-Wl,-u," $1}' | sort -u)
-- 
2.21.0



