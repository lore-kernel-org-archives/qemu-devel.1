Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B263C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB95521D43
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REY5uAR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB95521D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYsU-0002AL-3b
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlG-0005rD-Qh
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:54 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlC-0000Rv-Uj
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:54 -0400
Received: by mail-pg1-x543.google.com with SMTP id u13so9527138pgh.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=98oDa/Uw9z4PZMJfsm+7ai4FPAo11Fc74PaW20mvgsM=;
 b=REY5uAR9QcojLRSeaMMTjQAq3wWkP1nzt2xYQ9OoeId8mhgsu9+1uWqC38A1ukXotf
 LPY6pBz8BTALYF6Ne+w2Ul5APsrEgvbJtoAqdsngoUXcJD69AqZAuPh6vUoRbQdA2SZ0
 dmSpnjKr2VUMYnIWuocrnKZ4wTBFcKRmwxUmLUVpWGBmK7viCpy6+8GxzkIiniN55jgX
 3reISj+UIOjZY2a7Sfmqil6VEC4Q0nFuYnT9o6IV4APvCwS1JyoejxavKRpMYpMolJsC
 WAWTr4S6+b2u0lcsGXI+qyPAgQBrdUIVHmevzg+XpmQQbwwkexxpRq4SVvFLk9TbnEZt
 lfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=98oDa/Uw9z4PZMJfsm+7ai4FPAo11Fc74PaW20mvgsM=;
 b=g2BZLcRNl+VCTFNnwCWDoGNE7Khd7i2pyZ2OriDsVFm+hOAPlvZumbhpZSDMn3utOs
 ZEt7+dUR4F7i04KanX2vmzf5ook3GIKsS7BH8+QPf1DHy1vdecAH3sXMaP3hwPAHQijQ
 yMVa1LUs8F4W2H/QnJUVO7A1VMDmMo83pcvCEP+N0z68cK1GcQdc0017jkjxd1EJCzLb
 Xk4Zx5XZodSnfxugIQtoxTPBN4dVMhpFI/rMRZf71t4532HrJLZ9XwN/1yGagLDazgWt
 dMfwXJwbDa2edEcIgBYsJsMMBBrVUjeVpNB9kHT7rpLdQLRA+vTYwR5IneyJ/qnquxMk
 le0g==
X-Gm-Message-State: AOAM530C3/ZQSaRep7XSo97CiNrsYaInDC+rbQyL74xvT6JDL/vUX71P
 Fxui2/yilPBTuXw4pKOyUPGO
X-Google-Smtp-Source: ABdhPJwFUcM00TFMgzKF9XFRr0/TEL8rNhelWlrT6nu0GjzJjuP/7r8AhM0kZG6g4qBI+Wjz3Yy+NA==
X-Received: by 2002:a62:6dc3:0:b029:13c:1611:658d with SMTP id
 i186-20020a626dc30000b029013c1611658dmr21590723pfc.10.1599552829633; 
 Tue, 08 Sep 2020 01:13:49 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:49 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 06/12] target/arm/kvm: spe: Add device init and set_irq
 operations
Date: Tue,  8 Sep 2020 08:13:24 +0000
Message-Id: <7bc684ec37de06827c68c409d5f02da7381734e5.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=haibo.xu@linaro.org; helo=mail-pg1-x543.google.com
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

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/kvm64.c   | 33 +++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 8ffd31ffdf..5a2032fc9e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -450,6 +450,39 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     }
 }
 
+void kvm_arm_spe_init(CPUState *cs)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VCPU_SPE_V1_CTRL,
+        .attr = KVM_ARM_VCPU_SPE_V1_INIT,
+    };
+
+    if (!ARM_CPU(cs)->has_spe) {
+        return;
+    }
+    if (!kvm_arm_set_device_attr(cs, &attr, "SPE")) {
+        error_report("failed to init SPE");
+        abort();
+    }
+}
+
+void kvm_arm_spe_set_irq(CPUState *cs, int irq)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VCPU_SPE_V1_CTRL,
+        .addr = (intptr_t)&irq,
+        .attr = KVM_ARM_VCPU_SPE_V1_IRQ,
+    };
+
+    if (!ARM_CPU(cs)->has_spe) {
+        return;
+    }
+    if (!kvm_arm_set_device_attr(cs, &attr, "SPE")) {
+        error_report("failed to set irq for SPE");
+        abort();
+    }
+}
+
 static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
 {
     uint64_t ret;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index f79655674e..bb155322eb 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -348,6 +348,8 @@ int kvm_arm_vgic_probe(void);
 
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
 void kvm_arm_pmu_init(CPUState *cs);
+void kvm_arm_spe_set_irq(CPUState *cs, int irq);
+void kvm_arm_spe_init(CPUState *cs);
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 #else
@@ -397,6 +399,9 @@ static inline int kvm_arm_vgic_probe(void)
 static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
 static inline void kvm_arm_pmu_init(CPUState *cs) {}
 
+static inline void kvm_arm_spe_set_irq(CPUState *cs, int irq) {}
+static inline void kvm_arm_spe_init(CPUState *cs) {}
+
 static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map) {}
 
 static inline void kvm_arm_get_virtual_time(CPUState *cs) {}
-- 
2.17.1


