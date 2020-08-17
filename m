Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FA9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5E7204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEE57Xoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5E7204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gUC-0004ip-1Q
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGs-00044X-KW
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:37365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGo-000652-KL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id y3so15279735wrl.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A8PInox6g02sR2/AHxDKx9ShlBZlMXO4KPJmCFCaHig=;
 b=dEE57XoyLx0WUQ8BtzmaeWIaRJaozbuQkHBjUyssNv63HB1LMbDsaZSeIPaw+AIc7E
 AwktK06bje9rbOSoiFEammPRCpzxaHS1DODpkFvRjA8x83Aav4eqPYeLmji1gyMpqFSc
 Zx6ZR7fkwxPKJCLy6iWWQh5cN1pXN9PzUieykZZWAG/r3ZHVko1U6C8b+nfSzWSUk1pl
 z2LN7v1WDdEmoblpChOE+vRD10f7Vv75yejAai1RL92ppTsN2MeZKhOw5imdpFWa/s8S
 zLbsvCjJ1GXuiqjFaTzGCftee3pOIehgQKAS5t8PtU8M5fxKVEbFJ5uQpG/NABkFSrbj
 6pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=A8PInox6g02sR2/AHxDKx9ShlBZlMXO4KPJmCFCaHig=;
 b=sHTzmCmUfbuihLjteSwpzaO+AW/QBFj63ofpPOkwaZGxEb8hg8BCRU8pp6LOe0p4AW
 v0o5fNRuDxkCeW3tZRN78zSfRFUBGWIRiajYalXFEOAIcebi/ZDRkKbHAykbiy4m2xxc
 b5dvZ6UA/fKJgeFAAbZLsR3XVe0itaP68ZjhwH7sJsFFF4yWVNihy9GJKSK48HgVRLl/
 ZO8b6JklriG916hgnIfPhX3yxfrgNAb2Y2FKHFu1JTYncjzOhmNU9teXtsRvOJCAyctE
 L1nIQ7jGeq0/rZIi7n6/XWZnozDNHXNjYk55iujkmw+lV+DCEJdyrdHbCSFz/Qb3/AoA
 Rv3Q==
X-Gm-Message-State: AOAM532cPGunqJgBEzrbqXYowNFZfC2x5wevEDnpwL4G3KeKb5Ac0Sx/
 EoDOYsoal8H3HkzevFCo/17hHa6VO5I=
X-Google-Smtp-Source: ABdhPJxRiHSQbeN3E+YW7exBQMEwGvK0bP0KGVMmqzPohUKH7Q3G6td2mYE3Hra7GmPEerOJ7bHJCw==
X-Received: by 2002:adf:b353:: with SMTP id k19mr15503879wrd.159.1597675071473; 
 Mon, 17 Aug 2020 07:37:51 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.50 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 024/150] libqemuutil, qapi, trace: convert to meson
Date: Mon, 17 Aug 2020 16:35:17 +0200
Message-Id: <20200817143723.343284-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42e.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This shows how to do some "computations" in meson.build using its array
and dictionary data structures, and also a basic usage of the sourceset
module for conditional compilation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                            | 228 +++++-----------------------
 Makefile.objs                       |  95 ------------
 Makefile.target                     |   8 +-
 configure                           |   8 +
 crypto/Makefile.objs                |   6 -
 crypto/meson.build                  |  11 ++
 docs/devel/tracing.txt              |   2 +-
 meson.build                         | 194 +++++++++++++++++++++++
 qapi/Makefile.objs                  |  23 ---
 qapi/meson.build                    | 121 +++++++++++++++
 qobject/Makefile.objs               |   3 -
 qobject/meson.build                 |   3 +
 rules.mak                           |   2 +-
 scripts/qapi-gen.py                 |   0
 scripts/tracetool.py                |   0
 scripts/tracetool/backend/dtrace.py |   2 +-
 scripts/tracetool/backend/ust.py    |   6 +-
 storage-daemon/Makefile.objs        |   4 +-
 storage-daemon/meson.build          |   1 +
 storage-daemon/qapi/Makefile.objs   |   1 -
 storage-daemon/qapi/meson.build     |  10 ++
 stubs/Makefile.objs                 |  56 -------
 stubs/meson.build                   |  50 ++++++
 trace/Makefile.objs                 |  51 -------
 trace/meson.build                   |  76 ++++++++++
 util/Makefile.objs                  |  83 ----------
 util/meson.build                    |  69 +++++++++
 27 files changed, 588 insertions(+), 525 deletions(-)
 create mode 100644 crypto/meson.build
 create mode 100644 qapi/meson.build
 delete mode 100644 qobject/Makefile.objs
 create mode 100644 qobject/meson.build
 mode change 100755 => 100644 scripts/qapi-gen.py
 mode change 100755 => 100644 scripts/tracetool.py
 create mode 100644 storage-daemon/meson.build
 delete mode 100644 storage-daemon/qapi/Makefile.objs
 create mode 100644 storage-daemon/qapi/meson.build
 delete mode 100644 stubs/Makefile.objs
 create mode 100644 stubs/meson.build
 create mode 100644 trace/meson.build
 delete mode 100644 util/Makefile.objs
 create mode 100644 util/meson.build

diff --git a/Makefile b/Makefile
index b4dff89204..777d9f8e13 100644
--- a/Makefile
+++ b/Makefile
@@ -126,184 +126,60 @@ FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSIO
 
 generated-files-y = qemu-version.h config-host.h qemu-options.def
 
-GENERATED_QAPI_FILES = qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
-GENERATED_QAPI_FILES += qapi/qapi-types.h qapi/qapi-types.c
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-types-%.h)
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-types-%.c)
-GENERATED_QAPI_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
-GENERATED_QAPI_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-visit-%.h)
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-visit-%.c)
-GENERATED_QAPI_FILES += qapi/qapi-init-commands.h qapi/qapi-init-commands.c
-GENERATED_QAPI_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.h)
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.c)
-GENERATED_QAPI_FILES += qapi/qapi-emit-events.h qapi/qapi-emit-events.c
-GENERATED_QAPI_FILES += qapi/qapi-events.h qapi/qapi-events.c
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.h)
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.c)
-GENERATED_QAPI_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
-GENERATED_QAPI_FILES += qapi/qapi-doc.texi
-
-# The following list considers only the storage daemon main module. All other
-# modules are currently shared with the main schema, so we don't actually
-# generate additional files.
-
-GENERATED_STORAGE_DAEMON_QAPI_FILES = storage-daemon/qapi/qapi-commands.h
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-commands.c
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-emit-events.h
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-emit-events.c
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-events.h
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-events.c
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-init-commands.h
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-init-commands.c
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-introspect.h
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-introspect.c
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-types.h
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-types.c
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-visit.h
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-visit.c
-GENERATED_STORAGE_DAEMON_QAPI_FILES += storage-daemon/qapi/qapi-doc.texi
-
-generated-files-y += $(GENERATED_QAPI_FILES)
-generated-files-y += $(GENERATED_STORAGE_DAEMON_QAPI_FILES)
-
 generated-files-y += trace/generated-tcg-tracers.h
 
 generated-files-y += trace/generated-helpers-wrappers.h
 generated-files-y += trace/generated-helpers.h
 generated-files-y += trace/generated-helpers.c
 
-generated-files-$(CONFIG_TRACE_UST) += trace-ust-all.h
-generated-files-$(CONFIG_TRACE_UST) += trace-ust-all.c
-
 generated-files-y += module_block.h
 
-TRACE_HEADERS = trace/trace-root.h
-TRACE_SOURCES = trace/trace-root.c
-TRACE_DTRACE =
-ifdef CONFIG_TRACE_DTRACE
-TRACE_HEADERS += trace-dtrace-root.h $(trace-events-subdirs:%=%/trace-dtrace.h)
-TRACE_DTRACE += trace-dtrace-root.dtrace $(trace-events-subdirs:%=%/trace-dtrace.dtrace)
-endif
-ifdef CONFIG_TRACE_UST
-TRACE_HEADERS += trace-ust-root.h $(trace-events-subdirs:%=%/trace-ust.h)
-endif
-
-generated-files-y += $(BUILD_DIR)/trace-events-all
 generated-files-y += .git-submodule-status
 
-trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
-trace-group-suffix = $(shell echo $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
-
 tracetool-y = $(SRC_PATH)/scripts/tracetool.py
 tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 
-define __trace_rules
-TRACE_HEADERS += trace/trace-$2.h
-TRACE_SOURCES += trace/trace-$2.c
-trace-obj-y += trace/trace-$2.o
-trace/trace-$2.h: trace/trace-$2.h-timestamp
-	@cmp $$< $$@ >/dev/null 2>&1 || cp $$< $$@
-trace/trace-$2.h-timestamp: $(SRC_PATH)/$1/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=$2 \
-		--format=h \
-		--backends=$(TRACE_BACKENDS) \
-		$$< > $$@,"GEN","$$(@:%-timestamp=%)")
-
-trace/trace-$2.c: trace/trace-$2.c-timestamp
-	@cmp $$< $$@ >/dev/null 2>&1 || cp $$< $$@
-trace/trace-$2.c-timestamp: $(SRC_PATH)/$1/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=$2 \
-		--format=c \
-		--backends=$(TRACE_BACKENDS) \
-		$$< > $$@,"GEN","$$(@:%-timestamp=%)")
-endef
-
-%/trace-ust.h: %/trace-ust.h-timestamp
+trace/generated-helpers-wrappers.h: trace/generated-helpers-wrappers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace-ust.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=$(call trace-group-name,$@) \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
-
-%/trace-dtrace.dtrace: %/trace-dtrace.dtrace-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace-dtrace.dtrace-timestamp: $(SRC_PATH)/%/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=$(call trace-group-name,$@) \
-		--format=d \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
-
-%/trace-dtrace.h: %/trace-dtrace.dtrace $(tracetool-y)
-	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
-
-%/trace-dtrace.o: %/trace-dtrace.dtrace $(tracetool-y)
-
-
-trace/trace-root.h: trace/trace-root.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/trace-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
+trace/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	@mkdir -p $(dir $@)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
-		--format=h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
+		--format=tcg-helper-wrapper-h \
+		--backend=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
-trace/trace-root.c: trace/trace-root.c-timestamp
+trace/generated-helpers.h: trace/generated-helpers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/trace-root.c-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
+trace/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	@mkdir -p $(dir $@)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
-		--format=c \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
+		--format=tcg-helper-h \
+		--backend=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
-trace-ust-root.h: trace-ust-root.h-timestamp
+trace/generated-helpers.c: trace/generated-helpers.c-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-ust-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
+trace/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	@mkdir -p $(dir $@)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
-
-trace-ust-all.h: trace-ust-all.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-ust-all.h-timestamp: $(trace-events-files) $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$(trace-events-files) > $@,"GEN","$(@:%-timestamp=%)")
+		--format=tcg-helper-c \
+		--backend=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
-trace-ust-all.c: trace-ust-all.c-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-ust-all.c-timestamp: $(trace-events-files) $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=ust-events-c \
-		--backends=$(TRACE_BACKENDS) \
-		$(trace-events-files) > $@,"GEN","$(@:%-timestamp=%)")
+trace/generated-helpers.o: trace/generated-helpers.c
 
-trace-dtrace-root.dtrace: trace-dtrace-root.dtrace-timestamp
+trace/generated-tcg-tracers.h: trace/generated-tcg-tracers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-dtrace-root.dtrace-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+trace/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	@mkdir -p $(dir $@)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
-		--format=d \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
-
-trace-dtrace-root.h: trace-dtrace-root.dtrace
-	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
-
-trace-dtrace-root.o: trace-dtrace-root.dtrace
+		--format=tcg-h \
+		--backend=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
 KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
 KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
@@ -474,10 +350,8 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                stub-obj-y \
                 authz-obj-y \
                 chardev-obj-y \
-                util-obj-y \
                 qga-obj-y \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
@@ -498,14 +372,7 @@ dummy := $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
-                common-obj-m \
-                trace-obj-y)
-
-dummy := $(foreach DIR,$(trace-events-subdirs),$(eval $(call __trace_rules,$(DIR),$(call trace-group-suffix,$(DIR)))))
-
-generated-files-y += $(TRACE_HEADERS)
-generated-files-y += $(TRACE_SOURCES)
-
+                common-obj-m)
 
 include $(SRC_PATH)/tests/Makefile.include
 
@@ -619,8 +486,7 @@ Makefile: $(version-obj-y)
 ######################################################################
 # Build libraries
 
-libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
-libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
+libvhost-user.a: $(libvhost-user-obj-y)
 
 ######################################################################
 
@@ -683,27 +549,6 @@ qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-p
 		"GEN","$(@:%-timestamp=%)")
 	@>$@
 
-qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json \
-               $(QAPI_MODULES:%=$(SRC_PATH)/qapi/%.json)
-
-$(GENERATED_QAPI_FILES): qapi-gen-timestamp ;
-qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o "qapi" -b $<, \
-		"GEN","$(@:%-timestamp=%)")
-	@>$@
-
-qapi-modules-storage-daemon = \
-	$(SRC_PATH)/storage-daemon/qapi/qapi-schema.json \
-    $(QAPI_MODULES_STORAGE_DAEMON:%=$(SRC_PATH)/qapi/%.json)
-
-$(GENERATED_STORAGE_DAEMON_QAPI_FILES): storage-daemon/qapi/qapi-gen-timestamp ;
-storage-daemon/qapi/qapi-gen-timestamp: $(qapi-modules-storage-daemon) $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o "storage-daemon/qapi" $<, \
-		"GEN","$(@:%-timestamp=%)")
-	@>$@
-
 QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qapi-commands.h qga-qapi-init-commands.h)
 $(qga-obj-y): $(QGALIB_GEN)
 
@@ -741,9 +586,9 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
-vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
+vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
-vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
+vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
@@ -756,12 +601,12 @@ virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) libqemuutil.a
+vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 ifdef CONFIG_VHOST_USER_INPUT
 ifdef CONFIG_LINUX
-vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a libqemuutil.a
+vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 # build by default, do not install
@@ -790,9 +635,6 @@ clean: recurse-clean ninja-clean clean-ctlist
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
-	@# May not be present in generated-files-y
-	rm -f trace/generated-tracers-dtrace.dtrace*
-	rm -f trace/generated-tracers-dtrace.h*
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f qapi-gen-timestamp
 	rm -f storage-daemon/qapi/qapi-gen-timestamp
@@ -1022,7 +864,9 @@ endif
 	set -e; for x in $(KEYMAPS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
-	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadir)/trace-events-all"
+	for d in $(TARGET_DIRS); do \
+	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
+        done
 
 # opengl shader programs
 ui/shader/%-vert.h: $(SRC_PATH)/ui/shader/%.vert $(SRC_PATH)/scripts/shaderinclude.pl
@@ -1233,10 +1077,6 @@ Makefile: $(generated-files-y)
 endif
 endif
 
-.SECONDARY: $(TRACE_HEADERS) $(TRACE_HEADERS:%=%-timestamp) \
-	$(TRACE_SOURCES) $(TRACE_SOURCES:%=%-timestamp) \
-	$(TRACE_DTRACE) $(TRACE_DTRACE:%=%-timestamp)
-
 # Include automatically generated dependency files
 # Dependencies in Makefile.objs files come from our recursive subdir rules
 -include $(wildcard *.d tests/*.d)
diff --git a/Makefile.objs b/Makefile.objs
index 3823463c23..e5c9077517 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,7 +1,5 @@
 #######################################################################
 # Common libraries for tools and emulators
-stub-obj-y = stubs/
-util-obj-y = crypto/ util/ qobject/ qapi/
 qom-obj-y = qom/
 
 #######################################################################
@@ -94,10 +92,6 @@ common-obj-y += disas/
 # Resource file for Windows executables
 version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
 
-######################################################################
-# tracing
-util-obj-y +=  trace/
-
 ######################################################################
 # guest agent
 
@@ -123,92 +117,3 @@ vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 virtiofsd-obj-y = tools/virtiofsd/
 
 ######################################################################
-trace-events-subdirs =
-trace-events-subdirs += accel/kvm
-trace-events-subdirs += accel/tcg
-trace-events-subdirs += backends
-trace-events-subdirs += backends/tpm
-trace-events-subdirs += crypto
-trace-events-subdirs += monitor
-ifeq ($(CONFIG_USER_ONLY),y)
-trace-events-subdirs += linux-user
-endif
-ifeq ($(CONFIG_BLOCK),y)
-trace-events-subdirs += authz
-trace-events-subdirs += block
-trace-events-subdirs += io
-trace-events-subdirs += nbd
-trace-events-subdirs += scsi
-endif
-ifeq ($(CONFIG_SOFTMMU),y)
-trace-events-subdirs += audio
-trace-events-subdirs += chardev
-trace-events-subdirs += hw/9pfs
-trace-events-subdirs += hw/acpi
-trace-events-subdirs += hw/alpha
-trace-events-subdirs += hw/arm
-trace-events-subdirs += hw/audio
-trace-events-subdirs += hw/block
-trace-events-subdirs += hw/block/dataplane
-trace-events-subdirs += hw/char
-trace-events-subdirs += hw/dma
-trace-events-subdirs += hw/hppa
-trace-events-subdirs += hw/hyperv
-trace-events-subdirs += hw/i2c
-trace-events-subdirs += hw/i386
-trace-events-subdirs += hw/i386/xen
-trace-events-subdirs += hw/ide
-trace-events-subdirs += hw/input
-trace-events-subdirs += hw/intc
-trace-events-subdirs += hw/isa
-trace-events-subdirs += hw/mem
-trace-events-subdirs += hw/mips
-trace-events-subdirs += hw/misc
-trace-events-subdirs += hw/misc/macio
-trace-events-subdirs += hw/net
-trace-events-subdirs += hw/nvram
-trace-events-subdirs += hw/pci
-trace-events-subdirs += hw/pci-host
-trace-events-subdirs += hw/ppc
-trace-events-subdirs += hw/rdma
-trace-events-subdirs += hw/rdma/vmw
-trace-events-subdirs += hw/rtc
-trace-events-subdirs += hw/s390x
-trace-events-subdirs += hw/scsi
-trace-events-subdirs += hw/sd
-trace-events-subdirs += hw/sparc
-trace-events-subdirs += hw/sparc64
-trace-events-subdirs += hw/ssi
-trace-events-subdirs += hw/timer
-trace-events-subdirs += hw/tpm
-trace-events-subdirs += hw/usb
-trace-events-subdirs += hw/vfio
-trace-events-subdirs += hw/virtio
-trace-events-subdirs += hw/watchdog
-trace-events-subdirs += hw/xen
-trace-events-subdirs += hw/gpio
-trace-events-subdirs += hw/riscv
-trace-events-subdirs += migration
-trace-events-subdirs += net
-trace-events-subdirs += ui
-endif
-trace-events-subdirs += hw/core
-trace-events-subdirs += hw/display
-trace-events-subdirs += qapi
-trace-events-subdirs += qom
-trace-events-subdirs += target/arm
-trace-events-subdirs += target/hppa
-trace-events-subdirs += target/i386
-trace-events-subdirs += target/mips
-trace-events-subdirs += target/ppc
-trace-events-subdirs += target/riscv
-trace-events-subdirs += target/s390x
-trace-events-subdirs += target/sparc
-trace-events-subdirs += util
-
-trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
-
-trace-obj-y = trace-root.o
-trace-obj-$(CONFIG_TRACE_UST) += trace-ust-all.o
-trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace-root.o
-trace-obj-$(CONFIG_TRACE_DTRACE) += $(trace-events-subdirs:%=%/trace-dtrace.o)
diff --git a/Makefile.target b/Makefile.target
index d61a6a978b..0b323641bb 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -57,7 +57,7 @@ endif
 tracetool-y = $(SRC_PATH)/scripts/tracetool.py
 tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 
-$(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+$(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=stap \
@@ -67,7 +67,7 @@ $(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 		--target-type=$(TARGET_TYPE) \
 		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG).stp-installed")
 
-$(QEMU_PROG).stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+$(QEMU_PROG).stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=stap \
@@ -77,7 +77,7 @@ $(QEMU_PROG).stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 		--target-type=$(TARGET_TYPE) \
 		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG).stp")
 
-$(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+$(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=simpletrace-stap \
@@ -85,7 +85,7 @@ $(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 		--probe-prefix=qemu.$(TARGET_TYPE).$(TARGET_NAME) \
 		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG)-simpletrace.stp")
 
-$(QEMU_PROG)-log.stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+$(QEMU_PROG)-log.stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=log-stap \
diff --git a/configure b/configure
index d4172b06a7..ca87955a65 100755
--- a/configure
+++ b/configure
@@ -7198,6 +7198,8 @@ fi
 echo "CONFIG_TLS_PRIORITY=\"$tls_priority\"" >> $config_host_mak
 if test "$gnutls" = "yes" ; then
   echo "CONFIG_GNUTLS=y" >> $config_host_mak
+  echo "GNUTLS_CFLAGS=$gnutls_cflags" >> $config_host_mak
+  echo "GNUTLS_LIBS=$gnutls_libs" >> $config_host_mak
 fi
 if test "$gcrypt" = "yes" ; then
   echo "CONFIG_GCRYPT=y" >> $config_host_mak
@@ -7208,6 +7210,8 @@ fi
 if test "$nettle" = "yes" ; then
   echo "CONFIG_NETTLE=y" >> $config_host_mak
   echo "CONFIG_NETTLE_VERSION_MAJOR=${nettle_version%%.*}" >> $config_host_mak
+  echo "NETTLE_CFLAGS=$nettle_cflags" >> $config_host_mak
+  echo "NETTLE_LIBS=$nettle_libs" >> $config_host_mak
 fi
 if test "$qemu_private_xts" = "yes" ; then
   echo "CONFIG_QEMU_PRIVATE_XTS=y" >> $config_host_mak
@@ -7584,6 +7588,8 @@ if have_backend "log"; then
 fi
 if have_backend "ust"; then
   echo "CONFIG_TRACE_UST=y" >> $config_host_mak
+  echo "LTTNG_UST_LIBS=$lttng_ust_libs" >> $config_host_mak
+  echo "URCU_BP_LIBS=$urcu_bp_libs" >> $config_host_mak
 fi
 if have_backend "dtrace"; then
   echo "CONFIG_TRACE_DTRACE=y" >> $config_host_mak
@@ -7809,6 +7815,8 @@ echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
 echo "QEMU_INCLUDES=$QEMU_INCLUDES" >> $config_host_mak
+echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
+echo "GLIB_LIBS=$glib_libs" >> $config_host_mak
 if test "$sparse" = "yes" ; then
   echo "SPARSE_CFLAGS = -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-non-pointer-null" >> $config_host_mak
 fi
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index f1965b1a68..a9885919f2 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -35,9 +35,3 @@ crypto-obj-$(CONFIG_QEMU_PRIVATE_XTS) += xts.o
 crypto-obj-y += block.o
 crypto-obj-y += block-qcow.o
 crypto-obj-y += block-luks.o
-
-util-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
-util-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
-util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,$(CONFIG_RNG_NONE))) += random-none.o
-util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,$(if $(CONFIG_RNG_NONE),n,y))) += random-platform.o
-util-obj-y += aes.o init.o
diff --git a/crypto/meson.build b/crypto/meson.build
new file mode 100644
index 0000000000..1b244315b9
--- /dev/null
+++ b/crypto/meson.build
@@ -0,0 +1,11 @@
+util_ss.add(files('aes.c'))
+util_ss.add(files('init.c'))
+if 'CONFIG_GCRYPT' in config_host
+  util_ss.add(files('random-gcrypt.c'))
+elif 'CONFIG_GNUTLS' in config_host
+  util_ss.add(files('random-gnutls.c'), gnutls)
+elif 'CONFIG_RNG_NONE' in config_host
+  util_ss.add(files('random-none.c'))
+else
+  util_ss.add(files('random-platform.c'))
+endif
diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index cb5f685de9..6144d9921b 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -60,7 +60,7 @@ general. It is strongly preferred that all events be declared directly in
 the sub-directory that uses them. The only exception is where there are some
 shared trace events defined in the top level directory trace-events file.
 The top level directory generates trace files with a filename prefix of
-"trace-root" instead of just "trace". This is to avoid ambiguity between
+"trace/trace-root" instead of just "trace". This is to avoid ambiguity between
 a trace.h in the current directory, vs the top level directory.
 
 === Using trace events ===
diff --git a/meson.build b/meson.build
index e15e072a8c..16f92c4c60 100644
--- a/meson.build
+++ b/meson.build
@@ -4,6 +4,9 @@ project('qemu', ['c', 'cpp'], meson_version: '>=0.55.0',
 
 not_found = dependency('', required: false)
 keyval = import('unstable-keyval')
+ss = import('sourceset')
+
+cc = meson.get_compiler('c')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
@@ -39,6 +42,197 @@ supported_cpus = ['ppc', 'ppc64', 's390x', 'sparc64', 'riscv32', 'riscv64', 'x86
 cpu = host_machine.cpu_family()
 targetos = host_machine.system()
 
+m = cc.find_library('m', required: false)
+util = cc.find_library('util', required: false)
+socket = []
+if host_machine.system() == 'windows'
+  socket = cc.find_library('ws2_32')
+endif
+glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
+                          link_args: config_host['GLIB_LIBS'].split())
+gio = not_found
+if 'CONFIG_GIO' in config_host
+  gio = declare_dependency(compile_args: config_host['GIO_CFLAGS'].split(),
+                           link_args: config_host['GIO_LIBS'].split())
+endif
+lttng = not_found
+if 'CONFIG_TRACE_UST' in config_host
+  lttng = declare_dependency(link_args: config_host['LTTNG_UST_LIBS'].split())
+endif
+urcubp = not_found
+if 'CONFIG_TRACE_UST' in config_host
+  urcubp = declare_dependency(link_args: config_host['URCU_BP_LIBS'].split())
+endif
+nettle = not_found
+if 'CONFIG_NETTLE' in config_host
+  nettle = declare_dependency(compile_args: config_host['NETTLE_CFLAGS'].split(),
+                              link_args: config_host['NETTLE_LIBS'].split())
+endif
+gnutls = not_found
+if 'CONFIG_GNUTLS' in config_host
+  gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
+                              link_args: config_host['GNUTLS_LIBS'].split())
+endif
+
+target_dirs = config_host['TARGET_DIRS'].split()
+have_user = false
+have_system = false
+foreach target : target_dirs
+  have_user = have_user or target.endswith('-user')
+  have_system = have_system or target.endswith('-softmmu')
+endforeach
+have_tools = 'CONFIG_TOOLS' in config_host
+have_block = have_system or have_tools
+
+# Generators
+
+qapi_gen = find_program('scripts/qapi-gen.py')
+qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
+                     meson.source_root() / 'scripts/qapi/commands.py',
+                     meson.source_root() / 'scripts/qapi/common.py',
+                     meson.source_root() / 'scripts/qapi/doc.py',
+                     meson.source_root() / 'scripts/qapi/error.py',
+                     meson.source_root() / 'scripts/qapi/events.py',
+                     meson.source_root() / 'scripts/qapi/expr.py',
+                     meson.source_root() / 'scripts/qapi/gen.py',
+                     meson.source_root() / 'scripts/qapi/introspect.py',
+                     meson.source_root() / 'scripts/qapi/parser.py',
+                     meson.source_root() / 'scripts/qapi/schema.py',
+                     meson.source_root() / 'scripts/qapi/source.py',
+                     meson.source_root() / 'scripts/qapi/types.py',
+                     meson.source_root() / 'scripts/qapi/visit.py',
+                     meson.source_root() / 'scripts/qapi/common.py',
+                     meson.source_root() / 'scripts/qapi/doc.py',
+                     meson.source_root() / 'scripts/qapi-gen.py'
+]
+
+tracetool = [
+  find_program('scripts/tracetool.py'),
+   '--backend=' + config_host['TRACE_BACKENDS']
+]
+
+# Collect sourcesets.
+
+util_ss = ss.source_set()
+stub_ss = ss.source_set()
+trace_ss = ss.source_set()
+
+###############
+# Trace files #
+###############
+
+trace_events_subdirs = [
+  'accel/kvm',
+  'accel/tcg',
+  'crypto',
+  'monitor',
+]
+if have_user
+  trace_events_subdirs += [ 'linux-user' ]
+endif
+if have_block
+  trace_events_subdirs += [
+    'authz',
+    'block',
+    'io',
+    'nbd',
+    'scsi',
+  ]
+endif
+if have_system
+  trace_events_subdirs += [
+    'audio',
+    'backends',
+    'backends/tpm',
+    'chardev',
+    'hw/9pfs',
+    'hw/acpi',
+    'hw/alpha',
+    'hw/arm',
+    'hw/audio',
+    'hw/block',
+    'hw/block/dataplane',
+    'hw/char',
+    'hw/display',
+    'hw/dma',
+    'hw/hppa',
+    'hw/hyperv',
+    'hw/i2c',
+    'hw/i386',
+    'hw/i386/xen',
+    'hw/ide',
+    'hw/input',
+    'hw/intc',
+    'hw/isa',
+    'hw/mem',
+    'hw/mips',
+    'hw/misc',
+    'hw/misc/macio',
+    'hw/net',
+    'hw/nvram',
+    'hw/pci',
+    'hw/pci-host',
+    'hw/ppc',
+    'hw/rdma',
+    'hw/rdma/vmw',
+    'hw/rtc',
+    'hw/s390x',
+    'hw/scsi',
+    'hw/sd',
+    'hw/sparc',
+    'hw/sparc64',
+    'hw/ssi',
+    'hw/timer',
+    'hw/tpm',
+    'hw/usb',
+    'hw/vfio',
+    'hw/virtio',
+    'hw/watchdog',
+    'hw/xen',
+    'hw/gpio',
+    'hw/riscv',
+    'migration',
+    'net',
+    'ui',
+  ]
+endif
+trace_events_subdirs += [
+  'hw/core',
+  'qapi',
+  'qom',
+  'target/arm',
+  'target/hppa',
+  'target/i386',
+  'target/mips',
+  'target/ppc',
+  'target/riscv',
+  'target/s390x',
+  'target/sparc',
+  'util',
+]
+
+genh = []
+
+subdir('qapi')
+subdir('qobject')
+subdir('stubs')
+subdir('trace')
+subdir('util')
+subdir('crypto')
+subdir('storage-daemon')
+
+# Build targets from sourcesets
+
+stub_ss = stub_ss.apply(config_host, strict: false)
+
+util_ss.add_all(trace_ss)
+util_ss = util_ss.apply(config_host, strict: false)
+libqemuutil = static_library('qemuutil',
+                             sources: util_ss.sources() + stub_ss.sources() + genh,
+                             dependencies: [util_ss.dependencies(), m, glib, socket])
+qemuutil = declare_dependency(link_with: libqemuutil,
+                              sources: genh)
+
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
 summary_info += {'BIOS directory':    config_host['qemu_datadir']}
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 4673ab7490..c0a31be1a1 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -1,25 +1,4 @@
-util-obj-y = qapi-visit-core.o qapi-dealloc-visitor.o qobject-input-visitor.o
-util-obj-y += qobject-output-visitor.o qmp-registry.o qmp-dispatch.o
-util-obj-y += string-input-visitor.o string-output-visitor.o
-util-obj-y += opts-visitor.o qapi-clone-visitor.o
-util-obj-y += qmp-event.o
-util-obj-y += qapi-util.o
-
-QAPI_COMMON_MODULES = audio authz block-core block char common control crypto
-QAPI_COMMON_MODULES += dump error introspect job machine migration misc
-QAPI_COMMON_MODULES += net pragma qdev qom rdma rocker run-state sockets tpm
-QAPI_COMMON_MODULES += trace transaction ui
 QAPI_TARGET_MODULES = machine-target misc-target
-QAPI_MODULES = $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
-
-util-obj-y += qapi-builtin-types.o
-util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-types-%.o)
-util-obj-y += qapi-builtin-visit.o
-util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-visit-%.o)
-util-obj-y += qapi-emit-events.o
-util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-events-%.o)
-
-common-obj-y = $(QAPI_COMMON_MODULES:%=qapi-commands-%.o)
 
 obj-y = qapi-introspect.o
 obj-y += $(QAPI_TARGET_MODULES:%=qapi-types-%.o)
@@ -34,5 +13,3 @@ obj-y += qapi-init-commands.o
 
 QAPI_MODULES_STORAGE_DAEMON = block-core char common control crypto
 QAPI_MODULES_STORAGE_DAEMON += introspect job qom sockets pragma transaction
-
-storage-daemon-obj-y += $(QAPI_MODULES_STORAGE_DAEMON:%=qapi-commands-%.o)
diff --git a/qapi/meson.build b/qapi/meson.build
new file mode 100644
index 0000000000..f45b80bbfa
--- /dev/null
+++ b/qapi/meson.build
@@ -0,0 +1,121 @@
+util_ss.add(files(
+  'opts-visitor.c',
+  'qapi-clone-visitor.c',
+  'qapi-dealloc-visitor.c',
+  'qapi-util.c',
+  'qapi-visit-core.c',
+  'qmp-dispatch.c',
+  'qmp-event.c',
+  'qmp-registry.c',
+  'qobject-input-visitor.c',
+  'qobject-output-visitor.c',
+  'string-input-visitor.c',
+  'string-output-visitor.c',
+))
+
+qapi_all_modules = [
+  'audio',
+  'authz',
+  'block-core',
+  'block',
+  'char',
+  'common',
+  'control',
+  'crypto',
+  'dump',
+  'error',
+  'introspect',
+  'job',
+  'machine',
+  'machine-target',
+  'migration',
+  'misc',
+  'misc-target',
+  'net',
+  'pragma',
+  'qdev',
+  'qom',
+  'rdma',
+  'rocker',
+  'run-state',
+  'sockets',
+  'tpm',
+  'trace',
+  'transaction',
+  'ui',
+]
+
+qapi_storage_daemon_modules = [
+  'block-core',
+  'char',
+  'common',
+  'control',
+  'crypto',
+  'introspect',
+  'job',
+  'qom',
+  'sockets',
+  'pragma',
+  'transaction',
+]
+
+qapi_nonmodule_outputs = [
+  'qapi-introspect.c', 'qapi-introspect.h',
+  'qapi-types.c', 'qapi-types.h',
+  'qapi-visit.h', 'qapi-visit.c',
+  'qapi-commands.h', 'qapi-commands.c',
+  'qapi-init-commands.h', 'qapi-init-commands.c',
+  'qapi-events.h', 'qapi-events.c',
+  'qapi-emit-events.c', 'qapi-emit-events.h',
+]
+
+# First build all sources
+qapi_util_outputs = [
+  'qapi-builtin-types.c', 'qapi-builtin-visit.c',
+  'qapi-builtin-types.h', 'qapi-builtin-visit.h',
+]
+
+qapi_inputs = []
+qapi_specific_outputs = []
+foreach module : qapi_all_modules
+  qapi_inputs += [ files(module + '.json') ]
+  qapi_module_outputs = [
+    'qapi-types-@0@.c'.format(module),
+    'qapi-types-@0@.h'.format(module),
+    'qapi-visit-@0@.c'.format(module),
+    'qapi-visit-@0@.h'.format(module),
+    'qapi-events-@0@.c'.format(module),
+    'qapi-events-@0@.h'.format(module),
+    'qapi-commands-@0@.c'.format(module),
+    'qapi-commands-@0@.h'.format(module),
+  ]
+  if module.endswith('-target')
+    qapi_specific_outputs += qapi_module_outputs
+  else
+    qapi_util_outputs += qapi_module_outputs
+  endif
+endforeach
+
+qapi_files = custom_target('shared QAPI source files',
+  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs + ['qapi-doc.texi'],
+  input: [ files('qapi-schema.json') ],
+  command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
+  depend_files: [ qapi_inputs, qapi_gen_depends ])
+
+# Now go through all the outputs and add them to the right sourceset.
+# These loops must be synchronized with the output of the above custom target.
+
+i = 0
+foreach output : qapi_util_outputs
+  if output.endswith('.h')
+    genh += qapi_files[i]
+  endif
+  util_ss.add(qapi_files[i])
+  i = i + 1
+endforeach
+
+# These are still handled by the Makefile
+i += qapi_nonmodule_outputs.length()
+i += qapi_specific_outputs.length()
+
+qapi_doc_texi = qapi_files[i]
diff --git a/qobject/Makefile.objs b/qobject/Makefile.objs
deleted file mode 100644
index 7b12c9cacf..0000000000
--- a/qobject/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-util-obj-y = qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o qlit.o
-util-obj-y += qjson.o qobject.o json-lexer.o json-streamer.o json-parser.o
-util-obj-y += block-qdict.o
diff --git a/qobject/meson.build b/qobject/meson.build
new file mode 100644
index 0000000000..bb63c06b63
--- /dev/null
+++ b/qobject/meson.build
@@ -0,0 +1,3 @@
+util_ss.add(files('qnull.c', 'qnum.c', 'qstring.c', 'qdict.c', 'qlist.c', 'qbool.c',
+  'qlit.c', 'qjson.c', 'qobject.c', 'json-lexer.c', 'json-streamer.c', 'json-parser.c',
+  'block-qdict.c'))
diff --git a/rules.mak b/rules.mak
index 5ab42def82..7aefd37b5d 100644
--- a/rules.mak
+++ b/rules.mak
@@ -32,7 +32,7 @@ QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 # dir, one absolute and the other relative to the compiler working
 # directory. These are the same for target-independent files, but
 # different for target-dependent ones.
-QEMU_LOCAL_INCLUDES = -iquote $(BUILD_DIR)/$(@D) -iquote $(@D)
+QEMU_LOCAL_INCLUDES = -iquote $(BUILD_DIR) -iquote $(BUILD_DIR)/$(@D) -iquote $(@D)
 
 WL_U := -Wl,-u,
 find-symbols = $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
old mode 100755
new mode 100644
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
old mode 100755
new mode 100644
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index fc0c8fc52f..e17edc9b9d 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -38,7 +38,7 @@ def generate_h_begin(events, group):
     if group == "root":
         header = "trace-dtrace-root.h"
     else:
-        header = "trace-dtrace.h"
+        header = "trace-dtrace-%s.h" % group
 
     # Workaround for ust backend, which also includes <sys/sdt.h> and may
     # require SDT_USE_VARIADIC to be defined. If dtrace includes <sys/sdt.h>
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 6c0a5f8d68..c857516f21 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -19,11 +19,7 @@ PUBLIC = True
 
 
 def generate_h_begin(events, group):
-    if group == "root":
-        header = "trace-ust-root.h"
-    else:
-        header = "trace-ust.h"
-
+    header = 'trace-ust-' + group + '.h'
     out('#include <lttng/tracepoint.h>',
         '#include "%s"' % header,
         '',
diff --git a/storage-daemon/Makefile.objs b/storage-daemon/Makefile.objs
index cfe6beee52..41c0d02178 100644
--- a/storage-daemon/Makefile.objs
+++ b/storage-daemon/Makefile.objs
@@ -1 +1,3 @@
-storage-daemon-obj-y += qapi/
+storage-daemon-obj-y = qapi/libqsd-qapi.fa
+
+qemu-storage-daemon.o: storage-daemon/qapi/qapi-commands.h storage-daemon/qapi/qapi-init-commands.h
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
new file mode 100644
index 0000000000..35f8949924
--- /dev/null
+++ b/storage-daemon/meson.build
@@ -0,0 +1 @@
+subdir('qapi')
diff --git a/storage-daemon/qapi/Makefile.objs b/storage-daemon/qapi/Makefile.objs
deleted file mode 100644
index 8a4b220c96..0000000000
--- a/storage-daemon/qapi/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-storage-daemon-obj-y += qapi-commands.o qapi-init-commands.o qapi-introspect.o
diff --git a/storage-daemon/qapi/meson.build b/storage-daemon/qapi/meson.build
new file mode 100644
index 0000000000..7a2b041247
--- /dev/null
+++ b/storage-daemon/qapi/meson.build
@@ -0,0 +1,10 @@
+qsd_qapi_files = custom_target('QAPI files for qemu-storage-daemon',
+                               output: qapi_nonmodule_outputs + ['qapi-doc.texi'],
+                               input: [ files('qapi-schema.json') ],
+                               command: [ qapi_gen, '-o', 'storage-daemon/qapi', '@INPUT@' ],
+                               depend_files: [ qapi_inputs, qapi_gen_depends ])
+
+static_library('qsd-qapi',
+               qsd_qapi_files.to_list(),
+               name_suffix: 'fa',
+               build_by_default: false)
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
deleted file mode 100644
index d42046afe4..0000000000
--- a/stubs/Makefile.objs
+++ /dev/null
@@ -1,56 +0,0 @@
-stub-obj-y += blk-commit-all.o
-stub-obj-y += cmos.o
-stub-obj-y += cpu-get-clock.o
-stub-obj-y += cpu-get-icount.o
-stub-obj-y += dump.o
-stub-obj-y += error-printf.o
-stub-obj-y += fdset.o
-stub-obj-y += gdbstub.o
-stub-obj-y += iothread-lock.o
-stub-obj-y += is-daemonized.o
-stub-obj-y += isa-bus.o
-stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
-stub-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
-stub-obj-y += monitor-core.o
-stub-obj-y += notify-event.o
-stub-obj-y += pci-bus.o
-stub-obj-y += qmp_memory_device.o
-stub-obj-y += qtest.o
-stub-obj-y += ramfb.o
-stub-obj-y += replay.o
-stub-obj-y += runstate-check.o
-stub-obj-$(CONFIG_SOFTMMU) += semihost.o
-stub-obj-y += set-fd-handler.o
-stub-obj-y += sysbus.o
-stub-obj-y += tpm.o
-stub-obj-y += trace-control.o
-stub-obj-y += vmgenid.o
-stub-obj-y += vmstate.o
-stub-obj-$(CONFIG_SOFTMMU) += win32-kbd-hook.o
-
-#######################################################################
-# code used by both qemu system emulation and qemu-img
-
-ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
-
-stub-obj-y += arch_type.o
-stub-obj-y += bdrv-next-monitor-owned.o
-stub-obj-y += blockdev-close-all-bdrv-states.o
-stub-obj-y += change-state-handler.o
-stub-obj-y += clock-warp.o
-stub-obj-y += fd-register.o
-stub-obj-y += fw_cfg.o
-stub-obj-y += get-vm-name.o
-stub-obj-y += iothread.o
-stub-obj-y += machine-init-done.o
-stub-obj-y += migr-blocker.o
-stub-obj-y += monitor.o
-stub-obj-y += pci-host-piix.o
-stub-obj-y += ram-block.o
-stub-obj-y += replay-user.o
-stub-obj-y += target-get-monitor-def.o
-stub-obj-y += target-monitor-defs.o
-stub-obj-y += uuid.o
-stub-obj-y += vm-stop.o
-
-endif # CONFIG_SOFTMMU || CONFIG_TOOLS
diff --git a/stubs/meson.build b/stubs/meson.build
new file mode 100644
index 0000000000..019bd79c7a
--- /dev/null
+++ b/stubs/meson.build
@@ -0,0 +1,50 @@
+stub_ss.add(files('arch_type.c'))
+stub_ss.add(files('bdrv-next-monitor-owned.c'))
+stub_ss.add(files('blk-commit-all.c'))
+stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
+stub_ss.add(files('change-state-handler.c'))
+stub_ss.add(files('clock-warp.c'))
+stub_ss.add(files('cmos.c'))
+stub_ss.add(files('cpu-get-clock.c'))
+stub_ss.add(files('cpu-get-icount.c'))
+stub_ss.add(files('dump.c'))
+stub_ss.add(files('error-printf.c'))
+stub_ss.add(files('fd-register.c'))
+stub_ss.add(files('fdset.c'))
+stub_ss.add(files('fw_cfg.c'))
+stub_ss.add(files('gdbstub.c'))
+stub_ss.add(files('get-vm-name.c'))
+stub_ss.add(when: 'CONFIG_LINUX_IO_URING', if_true: files('io_uring.c'))
+stub_ss.add(files('iothread.c'))
+stub_ss.add(files('iothread-lock.c'))
+stub_ss.add(files('isa-bus.c'))
+stub_ss.add(files('is-daemonized.c'))
+stub_ss.add(when: 'CONFIG_LINUX_AIO', if_true: files('linux-aio.c'))
+stub_ss.add(files('machine-init-done.c'))
+stub_ss.add(files('migr-blocker.c'))
+stub_ss.add(files('monitor.c'))
+stub_ss.add(files('monitor-core.c'))
+stub_ss.add(files('notify-event.c'))
+stub_ss.add(files('pci-bus.c'))
+stub_ss.add(files('pci-host-piix.c'))
+stub_ss.add(files('qmp_memory_device.c'))
+stub_ss.add(files('qtest.c'))
+stub_ss.add(files('ram-block.c'))
+stub_ss.add(files('ramfb.c'))
+stub_ss.add(files('replay.c'))
+stub_ss.add(files('replay-user.c'))
+stub_ss.add(files('runstate-check.c'))
+stub_ss.add(files('set-fd-handler.c'))
+stub_ss.add(files('sysbus.c'))
+stub_ss.add(files('target-get-monitor-def.c'))
+stub_ss.add(files('target-monitor-defs.c'))
+stub_ss.add(files('tpm.c'))
+stub_ss.add(files('trace-control.c'))
+stub_ss.add(files('uuid.c'))
+stub_ss.add(files('vmgenid.c'))
+stub_ss.add(files('vmstate.c'))
+stub_ss.add(files('vm-stop.c'))
+stub_ss.add(files('win32-kbd-hook.c'))
+if have_system
+  stub_ss.add(files('semihost.c'))
+endif
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index c544509adf..a429474618 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -1,59 +1,8 @@
 # -*- mode: makefile -*-
 
-$(BUILD_DIR)/trace-events-all: $(trace-events-files)
-	$(call quiet-command,cat $^ > $@)
-
 
 ##################################################
 # Translation level
 
-$(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-wrapper-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-helpers.h: $(obj)/generated-helpers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-helpers.c: $(obj)/generated-helpers.c-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-c \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-helpers.o: $(obj)/generated-helpers.c
-
 obj-y += generated-helpers.o
-
-
-$(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-
-######################################################################
-# Backend code
-
-util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
-util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
-util-obj-y += control.o
 obj-y += control-target.o
-util-obj-y += qmp.o
diff --git a/trace/meson.build b/trace/meson.build
new file mode 100644
index 0000000000..f0a8d1c2e2
--- /dev/null
+++ b/trace/meson.build
@@ -0,0 +1,76 @@
+trace_events_files = []
+foreach dir : [ '.' ] + trace_events_subdirs
+  trace_events_file = meson.source_root() / dir / 'trace-events'
+  trace_events_files += [ trace_events_file ]
+  group_name = dir == '.' ? 'root' : dir.underscorify()
+  group = '--group=' + group_name
+  fmt = '@0@-' + group_name + '.@1@'
+
+  trace_h = custom_target(fmt.format('trace', 'h'),
+                          output: fmt.format('trace', 'h'),
+                          input: trace_events_file,
+                          command: [ tracetool, group, '--format=h', '@INPUT@' ],
+                          capture: true)
+  genh += trace_h
+  trace_c = custom_target(fmt.format('trace', 'c'),
+                          output: fmt.format('trace', 'c'),
+                          input: trace_events_file,
+                          command: [ tracetool, group, '--format=c', '@INPUT@' ],
+                          capture: true)
+  if 'CONFIG_TRACE_UST' in config_host
+    trace_ust_h = custom_target(fmt.format('trace-ust', 'h'),
+                                output: fmt.format('trace-ust', 'h'),
+                                input: trace_events_file,
+                                command: [ tracetool, group, '--format=ust-events-h', '@INPUT@' ],
+                                capture: true)
+    trace_ss.add(trace_ust_h, lttng, urcubp)
+    genh += trace_ust_h
+  endif
+  trace_ss.add(trace_h, trace_c)
+  if 'CONFIG_TRACE_DTRACE' in config_host
+    trace_dtrace = custom_target(fmt.format('trace-dtrace', 'dtrace'),
+                                 output: fmt.format('trace-dtrace', 'dtrace'),
+                                 input: trace_events_file,
+                                 command: [ tracetool, group, '--format=d', '@INPUT@' ],
+                                 capture: true)
+    trace_dtrace_h = custom_target(fmt.format('trace-dtrace', 'h'),
+                                   output: fmt.format('trace-dtrace', 'h'),
+                                   input: trace_dtrace,
+                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-h', '-s', '@INPUT@' ])
+    trace_dtrace_o = custom_target(fmt.format('trace-dtrace', 'o'),
+                                   output: fmt.format('trace-dtrace', 'o'),
+                                   input: trace_dtrace,
+                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-G', '-s', '@INPUT@' ])
+
+    trace_ss.add(trace_dtrace_h, trace_dtrace_o)
+    genh += trace_dtrace_h
+  endif
+endforeach
+
+custom_target('trace-events-all',
+              output: 'trace-events-all',
+              input: trace_events_files,
+              command: [ 'cat', '@INPUT@' ],
+              capture: true,
+              install: true,
+              install_dir: config_host['qemu_datadir'])
+
+if 'CONFIG_TRACE_UST' in config_host
+  trace_ust_all_h = custom_target('trace-ust-all.h',
+                                  output: 'trace-ust-all.h',
+                                  input: trace_events_files,
+                                  command: [ tracetool, '--group=all', '--format=ust-events-h', '@INPUT@' ],
+                                  capture: true)
+  trace_ust_all_c = custom_target('trace-ust-all.c',
+                                  output: 'trace-ust-all.c',
+                                  input: trace_events_files,
+                                  command: [ tracetool, '--group=all', '--format=ust-events-c', '@INPUT@' ],
+                                  capture: true)
+  trace_ss.add(trace_ust_all_h, trace_ust_all_c)
+  genh += trace_ust_all_h
+endif
+
+trace_ss.add(when: 'CONFIG_TRACE_SIMPLE', if_true: files('simple.c'))
+trace_ss.add(when: 'CONFIG_TRACE_FTRACE', if_true: files('ftrace.c'))
+trace_ss.add(files('control.c'))
+trace_ss.add(files('qmp.c'))
diff --git a/util/Makefile.objs b/util/Makefile.objs
deleted file mode 100644
index cc5e37177a..0000000000
--- a/util/Makefile.objs
+++ /dev/null
@@ -1,83 +0,0 @@
-util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
-util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
-util-obj-$(CONFIG_POSIX) += aio-posix.o
-util-obj-$(CONFIG_POSIX) += fdmon-poll.o
-util-obj-$(CONFIG_EPOLL_CREATE1) += fdmon-epoll.o
-util-obj-$(CONFIG_LINUX_IO_URING) += fdmon-io_uring.o
-util-obj-$(CONFIG_POSIX) += compatfd.o
-util-obj-$(CONFIG_POSIX) += event_notifier-posix.o
-util-obj-$(CONFIG_POSIX) += mmap-alloc.o
-util-obj-$(CONFIG_POSIX) += oslib-posix.o
-util-obj-$(CONFIG_POSIX) += qemu-openpty.o
-util-obj-$(CONFIG_POSIX) += qemu-thread-posix.o
-util-obj-$(CONFIG_POSIX) += memfd.o
-util-obj-$(CONFIG_WIN32) += aio-win32.o
-util-obj-$(CONFIG_WIN32) += event_notifier-win32.o
-util-obj-$(CONFIG_WIN32) += oslib-win32.o
-util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
-util-obj-y += envlist.o path.o module.o
-util-obj-y += host-utils.o
-util-obj-y += bitmap.o bitops.o
-util-obj-y += fifo8.o
-util-obj-y += cacheinfo.o
-util-obj-y += error.o qemu-error.o
-util-obj-y += qemu-print.o
-util-obj-y += id.o
-util-obj-y += qemu-config.o notify.o
-util-obj-y += qemu-option.o qemu-progress.o
-util-obj-y += keyval.o
-util-obj-y += crc32c.o
-util-obj-y += uuid.o
-util-obj-y += getauxval.o
-util-obj-y += rcu.o
-util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
-util-obj-y += log.o
-util-obj-y += pagesize.o
-util-obj-y += qdist.o
-util-obj-y += qht.o
-util-obj-y += qsp.o
-util-obj-y += range.o
-util-obj-y += stats64.o
-util-obj-y += systemd.o
-util-obj-$(CONFIG_POSIX) += drm.o
-util-obj-y += guest-random.o
-util-obj-$(CONFIG_GIO) += dbus.o
-dbus.o-cflags = $(GIO_CFLAGS)
-dbus.o-libs = $(GIO_LIBS)
-util-obj-$(CONFIG_USER_ONLY) += selfmap.o
-
-#######################################################################
-# code used by both qemu system emulation and qemu-img
-
-ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
-
-util-obj-y += aio-wait.o
-util-obj-y += aiocb.o
-util-obj-y += async.o
-util-obj-y += base64.o
-util-obj-y += buffer.o
-util-obj-y += bufferiszero.o
-util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
-util-obj-y += hexdump.o
-util-obj-y += lockcnt.o
-util-obj-y += iov.o
-util-obj-y += iova-tree.o
-util-obj-y += hbitmap.o
-util-obj-y += main-loop.o
-util-obj-y += nvdimm-utils.o
-util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
-util-obj-y += qemu-coroutine-sleep.o
-util-obj-y += qemu-co-shared-resource.o
-util-obj-y += qemu-sockets.o
-util-obj-y += qemu-timer.o
-util-obj-y += thread-pool.o
-util-obj-y += throttle.o
-util-obj-y += timed-average.o
-util-obj-y += uri.o
-
-util-obj-$(CONFIG_LINUX) += vfio-helpers.o
-util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
-util-obj-$(call lnot,$(CONFIG_INOTIFY1)) += filemonitor-stub.o
-util-obj-$(CONFIG_BLOCK) += readline.o
-
-endif # CONFIG_SOFTMMU || CONFIG_TOOLS
diff --git a/util/meson.build b/util/meson.build
new file mode 100644
index 0000000000..5fe1156503
--- /dev/null
+++ b/util/meson.build
@@ -0,0 +1,69 @@
+util_ss.add(dependency('threads'))
+util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
+util_ss.add(files('bufferiszero.c'))
+util_ss.add(files('lockcnt.c'))
+util_ss.add(files('aiocb.c', 'async.c', 'aio-wait.c', 'thread-pool.c', 'qemu-timer.c'))
+util_ss.add(files('main-loop.c'))
+util_ss.add(when: 'CONFIG_ATOMIC64', if_false: files('atomic64.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('aio-posix.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('fdmon-poll.c'))
+util_ss.add(when: 'CONFIG_EPOLL_CREATE1', if_true: files('fdmon-epoll.c'))
+util_ss.add(when: 'CONFIG_LINUX_IO_URING', if_true: files('fdmon-io_uring.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('compatfd.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('event_notifier-posix.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('mmap-alloc.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('oslib-posix.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: [files('qemu-openpty.c'), util])
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('qemu-thread-posix.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('memfd.c'))
+util_ss.add(when: 'CONFIG_WIN32', if_true: files('aio-win32.c'))
+util_ss.add(when: 'CONFIG_WIN32', if_true: files('event_notifier-win32.c'))
+util_ss.add(when: 'CONFIG_WIN32', if_true: files('oslib-win32.c'))
+util_ss.add(when: 'CONFIG_WIN32', if_true: files('qemu-thread-win32.c'))
+util_ss.add(when: 'CONFIG_WIN32', if_true: winmm)
+util_ss.add(files('envlist.c', 'path.c', 'module.c'))
+util_ss.add(files('host-utils.c'))
+util_ss.add(files('bitmap.c', 'bitops.c', 'hbitmap.c'))
+util_ss.add(files('fifo8.c'))
+util_ss.add(files('nvdimm-utils.c'))
+util_ss.add(files('cacheinfo.c'))
+util_ss.add(files('error.c', 'qemu-error.c'))
+util_ss.add(files('qemu-print.c'))
+util_ss.add(files('id.c'))
+util_ss.add(files('iov.c', 'qemu-config.c', 'qemu-sockets.c', 'uri.c', 'notify.c'))
+util_ss.add(files('qemu-option.c', 'qemu-progress.c'))
+util_ss.add(files('keyval.c'))
+util_ss.add(files('hexdump.c'))
+util_ss.add(files('crc32c.c'))
+util_ss.add(files('uuid.c'))
+util_ss.add(files('throttle.c'))
+util_ss.add(files('getauxval.c'))
+util_ss.add(files('readline.c'))
+util_ss.add(files('rcu.c'))
+util_ss.add(when: 'CONFIG_MEMBARRIER', if_true: files('sys_membarrier.c'))
+util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
+util_ss.add(files('qemu-coroutine-sleep.c'))
+util_ss.add(files('qemu-co-shared-resource.c'))
+util_ss.add(files('coroutine-@0@.c'.format(config_host['CONFIG_COROUTINE_BACKEND'])))
+util_ss.add(files('buffer.c'))
+util_ss.add(files('timed-average.c'))
+util_ss.add(files('base64.c'))
+util_ss.add(files('log.c'))
+util_ss.add(files('pagesize.c'))
+util_ss.add(files('qdist.c'))
+util_ss.add(files('qht.c'))
+util_ss.add(files('qsp.c'))
+util_ss.add(files('range.c'))
+util_ss.add(files('stats64.c'))
+util_ss.add(files('systemd.c'))
+util_ss.add(files('iova-tree.c'))
+util_ss.add(when: 'CONFIG_INOTIFY1', if_true: files('filemonitor-inotify.c'),
+                                      if_false: files('filemonitor-stub.c'))
+util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('drm.c'))
+util_ss.add(files('guest-random.c'))
+util_ss.add(when: 'CONFIG_GIO', if_true: [files('dbus.c'), gio])
+
+if have_user then
+  util_ss.add(files('selfmap.c'))
+endif
-- 
2.26.2



