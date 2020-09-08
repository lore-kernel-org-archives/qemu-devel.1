Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49737C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC30921D20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbQZsJ6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC30921D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYni-0002kH-RL
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlD-0005j5-PC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:51 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYl9-0000R2-Cd
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:51 -0400
Received: by mail-pg1-x542.google.com with SMTP id v15so9508291pgh.6
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sSfBFaYDNM91Wy+aR//OSZgCQwJ7nAz+b7+r07t012o=;
 b=qbQZsJ6CF8jpwRRRounCQp5bL88YG0Br0PMNnQ/UvzZgAQEQPAkdgp3MXCVMn7SZOB
 7levT9Y6Qbb5tD2xMCJmr4nv9iNl6QhxxT4w0tWFjdb1Lfo7VxWowR+K9I707xX25TW6
 bZFoN04bcRKuQ4sYFyFPbhc/d2YcnydUmQIdR74hv/nGVVJ7GqDJXkqR4LMBlf8g0R7t
 +jvvIl1ZEjq7W6Rk3MMdmwwKGvZ/nVG4qQkglGWbYmSiydsnBxE+YRnZPBqKjefLmR8e
 5uFxj/esmZKg3XMSiooAZg3GkSXKZ2zdqz5Mu2oj4S9cqqW2UaATx7hWpIWUFLY8cVdD
 Kitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sSfBFaYDNM91Wy+aR//OSZgCQwJ7nAz+b7+r07t012o=;
 b=aT7birlQOxTos1F/SqSckayU88Gpw5yYc7LQa5wJURo3bXr8p/HtPQAijevWJR+PdJ
 cxdaNb8A54xnb5iu0Xi5nkobokbYy8J+M7S15jb/Z9xNGzZNq6DHEEYSC4jY9Kl01n3u
 ZeiXF8s6n3cNdLp9/15nKdSY0+1WGffL/TUSvKbrEEI2wfF8CW9WC0h1J8dtRXbH3o6Z
 5HA3gF/Nm08Hje/qSbTGgFmF6C+VZQIwixIPkFlwsjEz8zTEc6oGUF7fbYF4bNn2Q5tv
 /rVJ91lQPY2tN/KD2t5L30dfotD/DuT3DbMGiV5sA65FFBHi2zhaBb0p1QSZPXNh289I
 ht/g==
X-Gm-Message-State: AOAM5328Y0NzsjaTfKrSSpzTx7VsXe6vGgYh8TSxJsqSsXnhynJyvAG4
 TZbteidj6GMvl9DjTU5huSEql8nI//6gjTY=
X-Google-Smtp-Source: ABdhPJwgBcKHQQjI2ii5UQWMZs6xY7efcdt52sP36Po66LfCEwUTD25oLYWilg0+5nJfmnKCUaq9ow==
X-Received: by 2002:a62:7c82:0:b029:13c:1611:66b9 with SMTP id
 x124-20020a627c820000b029013c161166b9mr22028120pfc.4.1599552826033; 
 Tue, 08 Sep 2020 01:13:46 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:45 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 03/12] target/arm/cpu: spe: Add an option to turn on/off
 vSPE support
Date: Tue,  8 Sep 2020 08:13:21 +0000
Message-Id: <77b57f43d4fa6319cfa666d6c77e39ec76c44d88.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=haibo.xu@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds a spe=[on/off] option to enable/disable vSPE support in
guest vCPU.

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/cpu.c   |  6 ++++++
 target/arm/cpu.h   | 13 ++++++++++++
 target/arm/cpu64.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c179e0752d..f211958eaa 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1310,6 +1310,12 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             error_propagate(errp, local_err);
             return;
         }
+
+        arm_cpu_spe_finalize(cpu, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
 }
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a1c7d8ebae..baf2bbcee8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -24,6 +24,7 @@
 #include "hw/registerfields.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "qapi/qapi-types-common.h"
 
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
@@ -196,9 +197,11 @@ typedef struct {
 #ifdef TARGET_AARCH64
 # define ARM_MAX_VQ    16
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
+void arm_cpu_spe_finalize(ARMCPU *cpu, Error **errp);
 #else
 # define ARM_MAX_VQ    1
 static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
+static inline void arm_cpu_spe_finalize(ARMCPU *cpu, Error **errp) { }
 #endif
 
 typedef struct ARMVectorReg {
@@ -829,6 +832,8 @@ struct ARMCPU {
     bool has_el3;
     /* CPU has PMU (Performance Monitor Unit) */
     bool has_pmu;
+    /* CPU has SPE (Statistical Profiling Extension) */
+    OnOffAuto has_spe;
     /* CPU has VFP */
     bool has_vfp;
     /* CPU has Neon */
@@ -3869,6 +3874,14 @@ static inline bool isar_feature_aa64_pmu_8_4(const ARMISARegisters *id)
         FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
+/*
+ * Currently we don't differentiate between the ARMv8.2-SPE and ARMv8.3-SPE.
+ */
+static inline bool isar_feature_aa64_spe(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMSVER) != 0;
+}
+
 static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3c2b3d9599..4997c4a3c0 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -572,6 +572,55 @@ void aarch64_add_sve_properties(Object *obj)
     }
 }
 
+void arm_cpu_spe_finalize(ARMCPU *cpu, Error **errp)
+{
+    uint64_t t;
+    uint32_t value = 0;
+
+    if (cpu->has_spe == ON_OFF_AUTO_AUTO) {
+        if (kvm_enabled() && kvm_arm_spe_supported()) {
+            cpu->has_spe = ON_OFF_AUTO_ON;
+        } else {
+            cpu->has_spe = ON_OFF_AUTO_OFF;
+        }
+    } else if (cpu->has_spe == ON_OFF_AUTO_ON) {
+        if (!kvm_enabled() || !kvm_arm_spe_supported()) {
+            error_setg(errp, "'spe' cannot be enabled on this host");
+            return;
+        }
+    }
+
+    /*
+     * According to the ARM ARM, the ID_AA64DFR0[PMSVER] currently
+     * support 3 values:
+     *
+     * 0b0000: SPE not implemented
+     * 0b0001: ARMv8.2-SPE implemented
+     * 0b0010: ARMv8.3-SPE implemented
+     *
+     * But the kernel KVM API didn't expose all these 3 values, and
+     * we can only get whether the SPE feature is supported or not.
+     * So here we just set the PMSVER to 1 if this feature was supported.
+     */
+    if (cpu->has_spe == ON_OFF_AUTO_ON) {
+        value = 1;
+    }
+
+    t = cpu->isar.id_aa64dfr0;
+    t = FIELD_DP64(t, ID_AA64DFR0, PMSVER, value);
+    cpu->isar.id_aa64dfr0 = t;
+}
+
+static bool arm_spe_get(Object *obj, Error **errp)
+{
+    return ARM_CPU(obj)->has_spe != ON_OFF_AUTO_OFF;
+}
+
+static void arm_spe_set(Object *obj, bool value, Error **errp)
+{
+    ARM_CPU(obj)->has_spe = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -721,6 +770,9 @@ static void aarch64_max_initfn(Object *obj)
     aarch64_add_sve_properties(obj);
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
                         cpu_max_set_sve_max_vq, NULL, NULL);
+
+    cpu->has_spe = ON_OFF_AUTO_AUTO;
+    object_property_add_bool(obj, "spe", arm_spe_get, arm_spe_set);
 }
 
 static const ARMCPUInfo aarch64_cpus[] = {
-- 
2.17.1


