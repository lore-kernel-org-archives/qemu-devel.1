Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB53C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57822074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="XFg1V4fZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57822074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGAa-0001nL-PO
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 07:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jiG8p-00087y-2g
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:40:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jiG8n-0003ch-2E
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:40:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so17042793wro.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V2TSsHVRZv5n6nm4rd17wgB0vrMj5AgJjY7Tq8D4v7E=;
 b=XFg1V4fZYjjfguvr9MNLuyck1yG+0Hb7wzfa14c2/wyF9unIy2e0ghtwAIqhRhXXU2
 43YKuKn+AcYawMqkdofiH/ykZYphdHN6Z4ZuRGdbVvQSIG5Y+Pdl34P0DODLQhn1tUSf
 pGk2hgUsHSmns/0lNL8jQXbbc0j2fUZXpTwZPhkjidrRCwjWZsrMcvuiB2sEGxH3/TQN
 reExKqBEptWPHiAOOcmgFYAnLHPOEU/d4kBDh/pSRoPL0ZTrtByNfzhwm1pxW4Omwc+o
 P6tXdS6v4k7yI8+7t/aRHiKdjamuNrvSaYy2d4o3BzYPwzu5fkAqDqB+kd732h8R4H53
 RRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V2TSsHVRZv5n6nm4rd17wgB0vrMj5AgJjY7Tq8D4v7E=;
 b=TBYxXL0GQ89pX14qhRrUqOFmU7/PbWsTQzkX/rUw1vo9LofaY5kHyTsXDfM/nc1KSm
 fNEAKg08OAMNftgdPpdgoGb6XLFm/QrV3IqV/qxEyG3uLIxeD8P/bL9/UCyTLdfB0uei
 a1sshvwBhA6SaBTNIzgQll70RgqVU8fOwqZ3hAM3zrXP4fG4ZNSjLBoEATQymbhBwwJs
 kRdMM1A873De1AJmqT2hfRcbBzLOroxf/CyCuOmQMW4PnHUE46/G2kFAe1Kf2w8TP0ur
 zaXHU+tHPKsFSB2RGwB2UBbhzarbcpAXrdyBdKHnpANpLu14igcVxAUOo5wweJcpuW+Q
 raFA==
X-Gm-Message-State: AOAM531bIgXmr3KHqJDUa8/0Itlz40t5CyquLgzO5aFmi9M9Optljyer
 ACES4cmJeWLK4Ri64K3pfjrUB1+KGoichuQcUqPc9BolbUOy3cvltf2ihGbQcdSfWUs1Dv9EPaP
 WTDv8RHBDwEVauEhUnsdqJ7aMwHRC8aLex9hYFs7Ee9qvmMiQwF5YlgAaTBqXyOLq
X-Google-Smtp-Source: ABdhPJymsjJm917aEJtm9K5EcUiGiikvasFd5PKmpW40SN+naA031/zpsLD4uQI0LPb82odE+IPXFg==
X-Received: by 2002:adf:de84:: with SMTP id w4mr23496358wrl.54.1591616431157; 
 Mon, 08 Jun 2020 04:40:31 -0700 (PDT)
Received: from vanye.hemma.eciton.net
 (cpc92302-cmbg19-2-0-cust304.5-4.cable.virginm.net. [82.1.209.49])
 by smtp.gmail.com with ESMTPSA id y5sm24225932wrs.63.2020.06.08.04.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 04:40:30 -0700 (PDT)
From: Leif Lindholm <leif@nuviainc.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [RFC PATCH 1/3] target/arm: commonalize aarch64 cpu init
Date: Mon,  8 Jun 2020 12:40:26 +0100
Message-Id: <20200608114028.25345-2-leif@nuviainc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608114028.25345-1-leif@nuviainc.com>
References: <20200608114028.25345-1-leif@nuviainc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some basic options will be set by all aarch64 platforms.
Break those out into a separate aarch64_cpu_common_init function, which
also takes implementer, partnum, variant, and revision as arguments to
set up MIDR.

Invoke this to remove duplication between a57/a53/a72 init.

Signed-off-by: Leif Lindholm <leif@nuviainc.com>
---
 target/arm/cpu-qom.h |  3 +++
 target/arm/cpu64.c   | 46 ++++++++++++++++++++++++--------------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 56395b87f6..48f6303308 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -44,6 +44,9 @@ typedef struct ARMCPUInfo {
 void arm_cpu_register(const ARMCPUInfo *info);
 void aarch64_cpu_register(const ARMCPUInfo *info);
 
+void aarch64_cpu_common_init(Object *obj, uint8_t impl, uint16_t part,
+                             uint8_t var, uint8_t rev);
+
 /**
  * ARMCPUClass:
  * @parent_realize: The parent class' realize handler.
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index cbc5c3868f..79786e034f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -29,6 +29,8 @@
 #include "kvm_arm.h"
 #include "qapi/visitor.h"
 
+#define MIDR_IMPLEMENTER_ARM 0x41
+
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
@@ -86,11 +88,19 @@ static const ARMCPRegInfo cortex_a72_a57_a53_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
-static void aarch64_a57_initfn(Object *obj)
+void aarch64_cpu_common_init(Object *obj, uint8_t impl, uint16_t part,
+                             uint8_t var, uint8_t rev)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t t;
+
+    t = FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, impl);
+    t = FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf);
+    t = FIELD_DP64(t, MIDR_EL1, PARTNUM, part);
+    t = FIELD_DP64(t, MIDR_EL1, VARIANT, var);
+    t = FIELD_DP64(t, MIDR_EL1, REVISION, rev);
+    cpu->midr = t;
 
-    cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
@@ -99,8 +109,16 @@ static void aarch64_a57_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
+}
+
+static void aarch64_a57_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    aarch64_cpu_common_init(obj, MIDR_IMPLEMENTER_ARM, 0xd07, 1, 0);
+
+    cpu->dtb_compatible = "arm,cortex-a57";
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
-    cpu->midr = 0x411fd070;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
     cpu->isar.mvfr0 = 0x10110222;
@@ -143,17 +161,10 @@ static void aarch64_a53_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
+    aarch64_cpu_common_init(obj, MIDR_IMPLEMENTER_ARM, 0xd03, 0, 4);
+
     cpu->dtb_compatible = "arm,cortex-a53";
-    set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
-    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
-    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
-    set_feature(&cpu->env, ARM_FEATURE_EL2);
-    set_feature(&cpu->env, ARM_FEATURE_EL3);
-    set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
-    cpu->midr = 0x410fd034;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
     cpu->isar.mvfr0 = 0x10110222;
@@ -196,16 +207,9 @@ static void aarch64_a72_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
+    aarch64_cpu_common_init(obj, MIDR_IMPLEMENTER_ARM, 0xd08, 0, 3);
+
     cpu->dtb_compatible = "arm,cortex-a72";
-    set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
-    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
-    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
-    set_feature(&cpu->env, ARM_FEATURE_EL2);
-    set_feature(&cpu->env, ARM_FEATURE_EL3);
-    set_feature(&cpu->env, ARM_FEATURE_PMU);
-    cpu->midr = 0x410fd083;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034080;
     cpu->isar.mvfr0 = 0x10110222;
-- 
2.20.1


