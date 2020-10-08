Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022ABC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7962021789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2+35uVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7962021789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWyy-0004Hl-Ca
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWs2-0004Mp-Q5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWs0-000607-QS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so6831670wrp.10
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fh60qRB84VIWqP7kSGXYTzN89LDnF2hd21jrv979hxw=;
 b=G2+35uVMZ80Fa0HIA18JxWvgc11idcrouWa5XllisIL/QwxTceDvpEN7a6NbErOiYW
 5RBj0x+NtOvlnm/RAP0iP+Xs0VSR91S0QruOwneyvYRq4FQewq+SQIhoS+zVmcx76zjE
 Rl824uP6xDp2SQkdd2VDmIWU8OGBLMz2QQId12gxeF3lV6MBZaItyIyiZVH+52wPWRlz
 UG7zI/dDdlrJPZjKOiAaqjxpjcNjPd6nrpSlNkCL3cYbWM+KGYEYRzdU1BhLZZcz7tOG
 A/j+X8y5u84YTvcwoaXXRooGOLdHlYdZy6XgJJdorTtEBCNoplvtEfc9YDGyPQP8PN8j
 9TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fh60qRB84VIWqP7kSGXYTzN89LDnF2hd21jrv979hxw=;
 b=qFQelJVxzqwu9vY4V1tza//r920f2R1svwJmRwOItdM8amu7cNtlOrVJcVVvlHC7nL
 ap6D6Z1mWS7QcrPUNPYXK1SB/WkNmzYZgd/4g/C7ahc3TYt42RSUrqCtrHK1yEDS0QGz
 rMje7StG3jUNMye0X9hs1D62P+roCAClyAgBqu4NbTA54+vgbybIUa8vDSwRbsLtVJ3h
 bNAj3Btk7Rj5RzOeJfLKv/m/9YRHXUR1whNQja14oOz0oAn5Idz8XJ2m1J4TPdW2aDww
 tFF03pNPDBZVg839HyAnen2ryJg8yMuA3KbVWAw/2nLg55DzR5+A7j/yC68Hlu4i+qBJ
 mFmw==
X-Gm-Message-State: AOAM530CHG0uJLVnOA6Vn31Cjfu57yeinarQkyd2hHPYpzL8CSTUsDIw
 7NBKDJRwHBzSQWZl/r7zEblA+s74ENNjMGMS
X-Google-Smtp-Source: ABdhPJw1+7pe7unFc1Up5Vbk8ujn2WdXRJEz7k35/1W4aASOCxGhY6hieH2JMTezzy5ZOUxV4SMf4g==
X-Received: by 2002:adf:91a4:: with SMTP id 33mr10229860wri.170.1602167170351; 
 Thu, 08 Oct 2020 07:26:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] hw/arm/virt: Move kvm pmu setup to virt_cpu_post_init
Date: Thu,  8 Oct 2020 15:25:54 +0100
Message-Id: <20201008142557.9845-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrew Jones <drjones@redhat.com>

Move the KVM PMU setup part of fdt_add_pmu_nodes() to
virt_cpu_post_init(), which is a more appropriate location. Now
fdt_add_pmu_nodes() is also named more appropriately, because it
no longer does anything but fdt node creation.

No functional change intended.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20201001061718.101915-5-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 524eafe22df..92ab0fd094d 100644
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
@@ -1678,11 +1668,23 @@ static void finalize_gic_version(VirtMachineState *vms)
  */
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
2.20.1


