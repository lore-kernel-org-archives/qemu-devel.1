Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51DCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71982173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtJ7CqyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71982173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lgz-0003V3-Ri
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOu-0005tR-W5
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29157
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOt-0006Xw-0A
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2dPMwKaBtepL5+Kyam0PcxLp6Q7tOaG8q3dyTUI9ck=;
 b=FtJ7CqyYm3vYUH83xlggSO+95yA1YDL1QZkHYRWuUoK2srsPbl6GlvpMirmb4GgaAwqx78
 /4O6xOGrShgEVweeeRZX73eT3xHdzgBzXB5IumrR5fhIWFR8vYEkKVzfe9N7wF8QbaT9IJ
 6OGeNnBdmI+lD64ey6+El1j5nBz4PJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-H0xtAe9uM4SQ0uJ5KoDLhA-1; Thu, 06 Aug 2020 15:17:59 -0400
X-MC-Unique: H0xtAe9uM4SQ0uJ5KoDLhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C909C107BEF5
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:17:58 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 013EF1D3;
 Thu,  6 Aug 2020 19:17:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 053/143] meson: convert target/s390x/gen-features.h
Date: Thu,  6 Aug 2020 21:14:49 +0200
Message-Id: <1596741379-12902-54-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
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

Needed by linux-user/s390x/cpu_loop.c.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                    |  2 ++
 meson.build                 |  1 +
 target/meson.build          |  1 +
 target/s390x/Makefile.objs  | 20 --------------------
 target/s390x/cpu_features.h |  2 +-
 target/s390x/cpu_models.h   |  2 +-
 target/s390x/meson.build    |  8 ++++++++
 7 files changed, 14 insertions(+), 22 deletions(-)
 create mode 100644 target/meson.build
 create mode 100644 target/s390x/meson.build

diff --git a/Makefile b/Makefile
index d775df4..1d4dfe8 100644
--- a/Makefile
+++ b/Makefile
@@ -108,6 +108,8 @@ CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 generated-files-y = config-host.h
 
 generated-files-y += module_block.h
+generated-files-y += target/s390x/gen-features.h
+target/s390x/gen-features.h: Makefile.ninja
 
 generated-files-y += .git-submodule-status
 
diff --git a/meson.build b/meson.build
index 7dbfc0b..2c617ef 100644
--- a/meson.build
+++ b/meson.build
@@ -320,6 +320,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 
 subdir('io')
 subdir('fsdev')
+subdir('target')
 
 # Other build targets
 if 'CONFIG_GUEST_AGENT' in config_host
diff --git a/target/meson.build b/target/meson.build
new file mode 100644
index 0000000..e29dd3e
--- /dev/null
+++ b/target/meson.build
@@ -0,0 +1 @@
+subdir('s390x')
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 3e27455..9b9accc 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -8,23 +8,3 @@ obj-$(CONFIG_SOFTMMU) += sigp.o
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
-
-# build and run feature list generator
-feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
-feat-dst = $(BUILD_DIR)/$(TARGET_DIR)
-ifneq ($(MAKECMDGOALS),clean)
-generated-files-y += $(feat-dst)gen-features.h
-endif
-
-$(feat-dst)gen-features.h: $(feat-dst)gen-features.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(feat-dst)gen-features.h-timestamp: $(feat-dst)gen-features
-	$(call quiet-command,$< >$@,"GEN","$(TARGET_DIR)gen-features.h")
-
-$(feat-dst)gen-features: $(feat-src)gen-features.c
-	$(call quiet-command,$(HOST_CC) $(QEMU_INCLUDES) -o $@ $<,"CC","$(TARGET_DIR)gen-features")
-
-clean-target:
-	rm -f gen-features.h-timestamp
-	rm -f gen-features.h
-	rm -f gen-features
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index da695a8..2a29475 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -16,7 +16,7 @@
 
 #include "qemu/bitmap.h"
 #include "cpu_features_def.h"
-#include "gen-features.h"
+#include "target/s390x/gen-features.h"
 
 /* CPU features are announced via different ways */
 typedef enum {
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 88bd01a6..74d1f87 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -14,7 +14,7 @@
 #define TARGET_S390X_CPU_MODELS_H
 
 #include "cpu_features.h"
-#include "gen-features.h"
+#include "target/s390x/gen-features.h"
 #include "hw/core/cpu.h"
 
 /* static CPU definition */
diff --git a/target/s390x/meson.build b/target/s390x/meson.build
new file mode 100644
index 0000000..980f67c
--- /dev/null
+++ b/target/s390x/meson.build
@@ -0,0 +1,8 @@
+gen_features = executable('gen-features', 'gen-features.c', native: true)
+
+gen_features_h = custom_target('gen-features.h',
+                               output: 'gen-features.h',
+                               capture: true,
+                               command: gen_features)
+
+specific_ss.add(gen_features_h)
-- 
1.8.3.1



