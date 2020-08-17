Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F694C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67BC3204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIuPiY0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BC3204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gi2-0000zo-Iw
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHK-0004zm-H6
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:26 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHI-0006CD-OE
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id a14so15274608wra.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=INcTxbyIHqyKHSSMZcT5ew08N5/uJ0P11rmSyo5Fvb8=;
 b=lIuPiY0lRw5wHMYn69wHzsHFJ3XIuBY9KWZfJcwbPlLSgmAMSc9cgM60IQByEwFaj1
 RmIH1iCvsNBGaKclXyPgdiu60KYZ68iSRIPD3q1JGBIth6SXAGVis/gd+Mp/8wzIyY2Q
 TM0WtlwTqCBUvLzpC6O8F7htAgtVulwr3hGnjWA8801DqssYFvvxYQx7oR+a73E6eukD
 nxjGq7fs9ar77BrIyl/2xJXmRwWNDDRYj/LpB4Pg3RqwUE/VselPnsudf32rtWbquQIc
 9pUhIZyIrfEa0cE20lx2a3U4qVbM5g2QFyIwv+TpI9JigtDp51Q2EV3mezB0mFajdTd5
 YoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=INcTxbyIHqyKHSSMZcT5ew08N5/uJ0P11rmSyo5Fvb8=;
 b=MSmahqmgPkThjM3Ieg4tBTo7oqla9srYH2qy+2CbhouUVVI5RhXisOYXYtvcHN81Rx
 kzhLYO2JmQZJ8vq2rBo4nWbupiWJG+dOOw5NEjlq2pWSyoND1zOqZjw21kAYTZePyppT
 y3U33tXvoVU+8C2vEfPGJkiuod7jog0mzzXcFLJR16QFLndLj74tEcb/wqfLRosNQR0C
 Gg946nOu/R5iKtFsj2fvZ2NNYQiwkUiN3dF0HR7IHFDS+F/VbFs7tit2tFLEX6IJiIGZ
 4hmit+g5fKO4sHwkhOJy0iMXKbCs3EyaFkuSjsBn1q30bsXAR8A6w6vNAk9tikaB3nU7
 twWg==
X-Gm-Message-State: AOAM531erT9KAfYP+d0+JaovhbX9AYX7yl8w+snJXFuV/WAKfHLIkm56
 oPRZEugiPs1fTOBd0i3tQyCQQlkSDWQ=
X-Google-Smtp-Source: ABdhPJzgFcYqgoKsiCAo3s3y/+UeZP/+wWlCWnr/p+INjUfT4HWT8GRYAssfCmjsgnsSXxWrLct8jw==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr17073021wrp.198.1597675103124; 
 Mon, 17 Aug 2020 07:38:23 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 059/150] meson: convert target/s390x/gen-features.h
Date: Mon, 17 Aug 2020 16:35:52 +0200
Message-Id: <20200817143723.343284-60-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42f.google.com
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

Needed by linux-user/s390x/cpu_loop.c; this removes the only use of HOST_CC.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                    |  2 ++
 configure                   |  1 -
 meson.build                 |  1 +
 target/meson.build          |  1 +
 target/s390x/Makefile.objs  | 20 --------------------
 target/s390x/cpu_features.h |  2 +-
 target/s390x/cpu_models.h   |  2 +-
 target/s390x/meson.build    |  9 +++++++++
 8 files changed, 15 insertions(+), 23 deletions(-)
 create mode 100644 target/meson.build
 create mode 100644 target/s390x/meson.build

diff --git a/Makefile b/Makefile
index 25eca25d63..2c6ced6cd5 100644
--- a/Makefile
+++ b/Makefile
@@ -113,6 +113,8 @@ CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 generated-files-y = config-host.h
 
 generated-files-y += module_block.h
+generated-files-y += target/s390x/gen-features.h
+target/s390x/gen-features.h: Makefile.ninja
 
 generated-files-y += .git-submodule-status
 
diff --git a/configure b/configure
index 2123a79039..606bc7378d 100755
--- a/configure
+++ b/configure
@@ -7785,7 +7785,6 @@ echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=$iasl" >> $config_host_mak
 fi
-echo "HOST_CC=$host_cc" >> $config_host_mak
 echo "CXX=$cxx" >> $config_host_mak
 echo "OBJCC=$objcc" >> $config_host_mak
 echo "AR=$ar" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 3e7d3e6b0e..baecc86a1d 100644
--- a/meson.build
+++ b/meson.build
@@ -344,6 +344,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 
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
index 0000000000..ddf8d20a36
--- /dev/null
+++ b/target/s390x/meson.build
@@ -0,0 +1,9 @@
+gen_features = executable('gen-features', 'gen-features.c', native: true,
+                          build_by_default: false)
+
+gen_features_h = custom_target('gen-features.h',
+                               output: 'gen-features.h',
+                               capture: true,
+                               command: gen_features)
+
+specific_ss.add(gen_features_h)
-- 
2.26.2



