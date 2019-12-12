Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4733BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEF7206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzBJGAnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEF7206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOSS-0008Qr-R8
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyQ-0003bO-1O
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyN-0006pi-QF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyN-0006o3-Ht
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:39 -0500
Received: by mail-wm1-x335.google.com with SMTP id b11so2236289wmj.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4HAQ8wWS3VYmUYf9FPMsr6xrEJyr4/7OCIkvd9SDiw4=;
 b=qzBJGAnbksEuJi2L9k503S5RuesS2h6MMvBaqg+ssV+PrSfOSTlI13tsirpT1UKI7a
 s8/caukV1lfE8tkRg2JHkgSGLvB206rqpL7yKSlxJX8TjsgzDsvxQXPRfm8wI2HfBNY/
 0uf6gNzlIj2G5AhjJOjQgQb3KX2Xc/AB9+wXBqMdFs5FpFpJUmNVk21QcyRi6R4vIbn1
 2cdrXfjgcxN1+5inLlKhsKHtdzKeZWo8y60lqoXgjEgbjQxsptHxCP/8dC8WX9uY2Rl9
 hwMpOcKGVlMaJIDHlxk8DNfJ7tOqwgBCXeMgIjK+6xaD1zvvOGXquvngdJ9APSaedQcv
 jjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4HAQ8wWS3VYmUYf9FPMsr6xrEJyr4/7OCIkvd9SDiw4=;
 b=IIDIhA+GQhEm17LoKxoZLIsbT7Hg7gDdeBPA37TfUX1cpk+wTiUe7XV8+zqxs7DUw8
 w7VVGj6PcDgVLIEX5Bq9rCN50OwEoYSk57OCCTsKv7wWaU79FY4c1dy8y4ojG/FRBRGC
 RNDrgpzQAMHyAxTHcVy0UnF2srODXnOuvvOHbFRaHCIiiEdwqfsMZzTDsS/2bXiWsgRp
 JS/iIR9I5nQTryEDiWOT/Did+JdriRfcfrtvSH06yB4Koe8ZJAXUts0Gdhhzs3r5FKNk
 k0rCPEw8Qe4FKI7s1M+hZuKPkKqcT6qTJMLCHkRqnNDs6hbbuGcaDRsy/DnhWrQrRi9M
 VGGQ==
X-Gm-Message-State: APjAAAVB55D1uQ700TNC2HabyAm3ZJ0GQM4iHirzENce8ZxzvrJzk6M+
 rRXlws6Q4pOCxuqyuWajZ9usC/dU
X-Google-Smtp-Source: APXvYqyTfnmYs6qD70TI1YSWxnoMHJzmrrgReLBoZ343IDfUxR0t7tDZ9+D4cZvYQfr5cpl05RxbAA==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr6275648wml.173.1576155218044; 
 Thu, 12 Dec 2019 04:53:38 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 040/132] meson: add modules infrastructure
Date: Thu, 12 Dec 2019 13:51:24 +0100
Message-Id: <1576155176-2464-41-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
---
 Makefile            | 10 +---------
 Makefile.target     |  6 ++++++
 meson.build         | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 rules.mak           | 10 +++++-----
 scripts/undefsym.sh | 20 ++++++++++++++++++++
 5 files changed, 85 insertions(+), 14 deletions(-)
 create mode 100755 scripts/undefsym.sh

diff --git a/Makefile b/Makefile
index bae96ec..c8c402a 100644
--- a/Makefile
+++ b/Makefile
@@ -212,7 +212,7 @@ subdir-capstone: capstone/all
 subdir-slirp: slirp/all
 
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
-	$(qom-obj-y)
+	$(qom-obj-y) block.syms qemu.syms
 
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
@@ -431,14 +431,6 @@ install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstated
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
index 74e8295..a0eb332 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -161,6 +161,12 @@ obj-y += memory_mapping.o
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
index 8d5b28b..3c292c6 100644
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
@@ -264,6 +266,7 @@ endforeach
 util_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
+block_ss = ss.source_set()
 common_ss = ss.source_set()
 softmmu_ss = ss.source_set()
 user_ss = ss.source_set()
@@ -271,6 +274,7 @@ bsd_user_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 specific_ss = ss.source_set()
 
+modules = {}
 hw_arch = {}
 target_arch = {}
 target_softmmu_arch = {}
@@ -372,6 +376,12 @@ subdir('authz')
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
@@ -387,6 +397,49 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 subdir('io')
 subdir('fsdev')
 
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
index 9dd3b7e..8571aec 100644
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
index 0000000..d4871f0
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
1.8.3.1



