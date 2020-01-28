Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3ABC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621E3207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKnfZYib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621E3207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVjD-0005Yf-It
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5J-0008MI-UH
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5I-0002I8-II
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:33 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5I-0002CK-Ag
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:32 -0500
Received: by mail-wr1-x42b.google.com with SMTP id k11so2419565wrd.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kMZCQiC6tujYibg1X8UDUgd1EzvuLqCNSKqnyiHR4Fc=;
 b=uKnfZYibJn6/pAi8j7UlWdHrhe2gixdzZSE0bQ2l5lQ/1crB1Gab5AZgv/5K5oWLb1
 8GDSXRyrlQ6S8qVHmMBTjFEHd2xWBedTmfhFtkEfGcO9Qb8AAcoe/SicbSQMsznWbrgT
 TQgOxEPvq9eLZoa4Pi5mQ1TllF7my92apou9Hfk5qKZ5telv55jk1577ETBdE9fVzKVf
 JD7BqxqjGblkfGazdUylc7q/Gqrspd1pOoajzCVEU/2INVRTwxyeai/PKhj2YrzyqFy6
 QotMar76X1vPk95pjz/+tqb2+ZW6quFmN4+4GLnj/hqp85xkPzbXh7cpuB40IUkR5A6I
 UT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kMZCQiC6tujYibg1X8UDUgd1EzvuLqCNSKqnyiHR4Fc=;
 b=mwnCYQ0Gn93xsl+KPld5kuMWVlkDDZl0iEx9T++F8KB/UYKMkUX3DMTApzH9uhPr/F
 Lr5/aqdYH1iZIfaBFFVKDs+QKth6do01PYHMDie7UXu6V9eKDcU4F6N5cWnhTxl/xEn1
 sqQVzfU7wsFfbWlG5f8G3Orz6E+D10uCLJb9le2zYzLX9Xz5aTanikeB+OzBiJxTIDhz
 IRQS4+UgC8rAHFNpe3WcahKeE+SoTwXpNhE4MWFT9wfjv6lX+vkdel4X3heKyWsMjf4Q
 6YU1Jl047jSgQT4a8v+LbXhetApt9092KxY73nmndr4NaTzcPwgfgRe7PceLL3jQ96Es
 40sA==
X-Gm-Message-State: APjAAAUydaE2b13U6TSoaEZ8iPu5Qpb1gbGku1YX2wjyDsXDVcvYESXc
 pwvMUrcHB4ni0ahTgyK+9IJ5p+Ll
X-Google-Smtp-Source: APXvYqz4No8dEaIL8aLPD1+nh2r1bROqfW6n20M6cKmJHehoaRw+EYumlKwiBOcrDexxoNSoGstdJQ==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr32297271wrr.158.1580234129994; 
 Tue, 28 Jan 2020 09:55:29 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 043/142] meson: convert target/s390x/gen-features.h
Date: Tue, 28 Jan 2020 18:52:03 +0100
Message-Id: <20200128175342.9066-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
index 73d70fcef9..f238cb5461 100644
--- a/Makefile
+++ b/Makefile
@@ -109,6 +109,8 @@ CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 generated-files-y = config-host.h
 
 generated-files-y += module_block.h
+generated-files-y += target/s390x/gen-features.h
+target/s390x/gen-features.h: Makefile.ninja
 
 generated-files-y += .git-submodule-status
 
diff --git a/meson.build b/meson.build
index 23d39363cf..a81e0c4128 100644
--- a/meson.build
+++ b/meson.build
@@ -295,6 +295,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 
 subdir('io')
 subdir('fsdev')
+subdir('target')
 
 # Other build targets
 if 'CONFIG_GUEST_AGENT' in config_host
diff --git a/target/meson.build b/target/meson.build
new file mode 100644
index 0000000000..e29dd3e01f
--- /dev/null
+++ b/target/meson.build
@@ -0,0 +1 @@
+subdir('s390x')
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 3e2745594a..9b9accc5fd 100644
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
index da695a8346..2a29475493 100644
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
index 88bd01a616..74d1f87e4f 100644
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
index 0000000000..980f67cc85
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
2.21.0



