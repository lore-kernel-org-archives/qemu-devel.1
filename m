Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927482177B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ap1msIb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927482177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYp9-0005Lq-JT
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlK-00060P-7G
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:58 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlF-0000Se-MB
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:57 -0400
Received: by mail-pj1-x1042.google.com with SMTP id gf14so7629647pjb.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VVgURpjuArAMDrEKjpU9KwbLTs4HVxWM7QaG/94weX8=;
 b=ap1msIb8TT2AJK0n67LMP9CkJ7Zh9jrn8OzxQoi5+AiPMPuPFTpEPp8vw0o+zZ6fOo
 c9pp2gy4B4HBO0o9+/rSFx0gqKjFFVPCKZZPQ9ElNy+p3xGtYAR82dVJV2N+GLPoiKAI
 sSio2R1rAAjQbaEtg0Rp5NNL9fs6DZin2UR9Jwe5Xo0jUmfmAnlDUoGoiHSI8aYGe5YX
 vHUOybrqLMCVCbTX1SkyY70YpWtyWdHogAtVUovjepeP4c6GTBLGLzZscs/FiaZuMisF
 E+2wFWR20cp2fZqt07vDp8q7D1ibeb+Hm0HA4Tg7wsF2Fmcw3hnKuQ5fxXfrej7NN35J
 Me6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VVgURpjuArAMDrEKjpU9KwbLTs4HVxWM7QaG/94weX8=;
 b=rj++G4VWeiMBN14feIyjbvlQm1JWIH9HFROSX63nrLMA27flzSwd/AEPUTnIWmQ8p5
 RhKjzzIgADCIeb3C9jJOS9X75hJSAQBsYgo4rUZ01cv1lbAKK0hYJwZQqnJ4ROmFclj/
 j3ypcMrVcBMvpdtDKirKp+g9WHCEvfN12dwSvy8pEW/8dnVge0hClIPDKErEJqc/fcRg
 4NlZkws+vGKLK4vla2kvghmrYdJmHdLwXowqfaIU6dOdZ0Ka0NL87WF7dZPwaivRsA/j
 b80Lspngd9O4Q4kTGONoLX0LRo1bkY7tGbkWEplqWZgn5+MQ/gn6k5ArajABSFsEX7oP
 8z8Q==
X-Gm-Message-State: AOAM531UrET9hELArRiJuFm7avY0sUB7zDV1cHMtWfaU7wc2q/PYoW3+
 ueP1WC2pBBqtXSe9z7CP23dw
X-Google-Smtp-Source: ABdhPJwmdzKaizukC5GULCv5mYoAJxk/GSr/XtcZD3W/bMDqx6+S5/4A/5yx747umDvAmKxDaiEVjg==
X-Received: by 2002:a17:90a:634c:: with SMTP id
 v12mr2904904pjs.57.1599552832108; 
 Tue, 08 Sep 2020 01:13:52 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:51 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 08/12] hw/arm/virt: Move kvm pmu setup to virt_cpu_post_init
Date: Tue,  8 Sep 2020 08:13:26 +0000
Message-Id: <7982854bb6cdb90390ea3f3c39c2801ef84fd2e5.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=haibo.xu@linaro.org; helo=mail-pj1-x1042.google.com
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

From: Andrew Jones <drjones@redhat.com>

Move the KVM PMU setup part of fdt_add_pmu_nodes() to
virt_cpu_post_init(), which is a more appropriate location. Now
fdt_add_pmu_nodes() is also named more appropriately, because it
no longer does anything but fdt node creation.

No functional change intended.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2ffcb073af..6bacfb668d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -521,21 +521,12 @@ static void fdt_add_gic_node(VirtMachineState *vms)
 
 static void fdt_add_pmu_nodes(const VirtMachineState *vms)
 {
-    CPUState *cpu;
-    ARMCPU *armcpu;
+    ARMCPU *armcpu = ARM_CPU(first_cpu);
     uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
 
-    CPU_FOREACH(cpu) {
-        armcpu = ARM_CPU(cpu);
-        if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
-            return;
-        }
-        if (kvm_enabled()) {
-            if (kvm_irqchip_in_kernel()) {
-                kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
-            }
-            kvm_arm_pmu_init(cpu);
-        }
+    if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
+        assert(!object_property_get_bool(OBJECT(armcpu), "pmu", NULL));
+        return;
     }
 
     if (vms->gic_version == VIRT_GIC_VERSION_2) {
@@ -544,7 +535,6 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
                              (1 << vms->smp_cpus) - 1);
     }
 
-    armcpu = ARM_CPU(qemu_get_cpu(0));
     qemu_fdt_add_subnode(vms->fdt, "/pmu");
     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
         const char compat[] = "arm,armv8-pmuv3";
@@ -1674,11 +1664,23 @@ static void finalize_gic_version(VirtMachineState *vms)
 
 static void virt_cpu_post_init(VirtMachineState *vms)
 {
-    bool aarch64;
+    bool aarch64, pmu;
+    CPUState *cpu;
 
     aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
+    pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
 
-    if (!kvm_enabled()) {
+    if (kvm_enabled()) {
+        CPU_FOREACH(cpu) {
+            if (pmu) {
+                assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
+                if (kvm_irqchip_in_kernel()) {
+                    kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
+                }
+                kvm_arm_pmu_init(cpu);
+            }
+        }
+    } else {
         if (aarch64 && vms->highmem) {
             int requested_pa_size = 64 - clz64(vms->highest_gpa);
             int pamax = arm_pamax(ARM_CPU(first_cpu));
-- 
2.17.1


