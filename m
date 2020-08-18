Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9905C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBD020786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfoXpTSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBD020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82b9-0001dA-N6
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82KH-0003OD-Jx
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82KF-0007LO-GL
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhGsWNj5TEWB6tCh8wZiVrOKr9TpnCnjun1Tc4OdcCE=;
 b=BfoXpTSY4ga7++0J4laTNwjgkhnBcaQuz8rDwRQqgNhKAR4JOdgVUUlWtX0BbuGhZ/VluK
 Kus53C49qOmX88gz1InsSJJ8X7oI4fT9hQLWP8DFbS9NzDLD45rnufux3NSYjjeOVso6z8
 hYU36srCdtZljSs8lPvyahz91RKVhAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-AMCF1OAAOOa9fpq1qNbKdA-1; Tue, 18 Aug 2020 10:10:52 -0400
X-MC-Unique: AMCF1OAAOOa9fpq1qNbKdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B73F801ADD
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:10:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C2C95D9E2;
 Tue, 18 Aug 2020 14:10:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 026/150] meson: add remaining generated tcg trace helpers
Date: Tue, 18 Aug 2020 10:08:21 -0400
Message-Id: <20200818141025.21608-27-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 06:40:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Makefile          | 51 -----------------------------------------------
 trace/meson.build | 14 +++++++++++++
 2 files changed, 14 insertions(+), 51 deletions(-)

diff --git a/Makefile b/Makefile
index 4a03af2daa..f89687785f 100644
--- a/Makefile
+++ b/Makefile
@@ -128,61 +128,10 @@ FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSIO
 
 generated-files-y = qemu-version.h config-host.h qemu-options.def
 
-generated-files-y += trace/generated-tcg-tracers.h
-
-generated-files-y += trace/generated-helpers-wrappers.h
-generated-files-y += trace/generated-helpers.h
-generated-files-y += trace/generated-helpers.c
-
 generated-files-y += module_block.h
 
 generated-files-y += .git-submodule-status
 
-tracetool-y = $(SRC_PATH)/scripts/tracetool.py
-tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
-
-trace/generated-helpers-wrappers.h: trace/generated-helpers-wrappers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-wrapper-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-trace/generated-helpers.h: trace/generated-helpers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-trace/generated-helpers.c: trace/generated-helpers.c-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-c \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-trace/generated-helpers.o: trace/generated-helpers.c
-
-trace/generated-tcg-tracers.h: trace/generated-tcg-tracers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
 KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
 KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
diff --git a/trace/meson.build b/trace/meson.build
index f0a8d1c2e2..cab36a248b 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -55,6 +55,20 @@ custom_target('trace-events-all',
               install: true,
               install_dir: config_host['qemu_datadir'])
 
+foreach d : [
+  ['generated-tcg-tracers.h', 'tcg-h'],
+  ['generated-helpers.c', 'tcg-helper-c'],
+  ['generated-helpers.h', 'tcg-helper-h'],
+  ['generated-helpers-wrappers.h', 'tcg-helper-wrapper-h'],
+]
+  custom_target(d[0],
+                output: d[0],
+                input: meson.source_root() / 'trace-events',
+                command: [ tracetool, '--group=root', '--format=@0@'.format(d[1]), '@INPUT@' ],
+                build_by_default: true, # to be removed when added to a target
+                capture: true)
+endforeach
+
 if 'CONFIG_TRACE_UST' in config_host
   trace_ust_all_h = custom_target('trace-ust-all.h',
                                   output: 'trace-ust-all.h',
-- 
2.26.2



