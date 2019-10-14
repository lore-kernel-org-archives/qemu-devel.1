Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23023ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5CC2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9A+AkOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5CC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK342-0005Ts-1g
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pT-0003Hc-56
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pR-0006mN-NA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pR-0006lK-Eh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id y19so20397884wrd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=opthv//THjiTY86axVJKAgqEwMO2rqSzwEywRLHPL0U=;
 b=i9A+AkOHyo24fZBiVUZtW42FgBvFDU0u3qUs+PbiV1pStqGr2pbEgNYPe/jbjfKbcv
 vtSt6yyOMIq2HxDzlVGXn5ssmMwYHUxmaQnkdbczaJllzLNsI9yucPk5JBLdvqG/su9L
 9gfTJ3/eRf6jElTprl9avJ5E/KawwIVTsEfftItoEmSIzPkFb4T+VS2xujCBgsXp3Ba5
 OLJa//ml7m5jwWXH2xoNUIx4ww+D/QQGWG9A9Pi09c6fRtzcrIvge/CrM315MXr/tVQe
 j3IHM8P7lN1TroGTfiLHlqXH/UlpnZ8YrjqIv1NIfsIjswY0/9OA8GskOOx+GCDII9EF
 oKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=opthv//THjiTY86axVJKAgqEwMO2rqSzwEywRLHPL0U=;
 b=tYJ2u6c2Aw2Ee/XRrJvFam8MJrAc4VChceGknuyVruxG2/HvUtRljXb0ULwMsbxdAH
 qE2Ljl/RLoPdHwex5rsoe7hEOfV63h4fpvQsPMR3uXqXyZx2lM2L9U1YVRHEV8crDPav
 3uAiAlXPiT8B4kS4Lj7HheW4RmcHsN2WYoT/01nwyTG8OSGp4ZmH/vBHXQkb/2vfc0zn
 FpwkxSyFYBRVWW/ZkzhvZoyexv4IcRKBB0HBu+q9XVvk28GVEC5iIKIA5EUjqOSfxp8u
 pZLtC3UQCF/tr8Fqb10AXgUlbN55NgovT0jUhuXYVTdPv5/YTx/+pB5qbMLFNvsTAfSN
 54Cg==
X-Gm-Message-State: APjAAAVeFf0sr2SD/GAKc6/j/+weiQNanfmW4sz5eBMMQDqRPwX4eImc
 fpFQ58D4/D1QkqZny4Lhqa/VDd0D6B5zKw==
X-Google-Smtp-Source: APXvYqyBiefvJVuJ1CCNQThXAI/rjnXtyKU6Ua1PFCe0pMhA3BiSHSZ49w/c81pGkrwvVYMOU69jGw==
X-Received: by 2002:a05:6000:1252:: with SMTP id
 j18mr26641719wrx.160.1571069051957; 
 Mon, 14 Oct 2019 09:04:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/68] intc/arm_gic: Support IRQ injection for more than 256
 vpus
Date: Mon, 14 Oct 2019 17:02:58 +0100
Message-Id: <20191014160404.19553-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Eric Auger <eric.auger@redhat.com>

Host kernels that expose the KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 capability
allow injection of interrupts along with vcpu ids larger than 255.
Let's encode the vpcu id on 12 bits according to the upgraded KVM_IRQ_LINE
ABI when needed.

Given that we have two callsites that need to assemble
the value for kvm_set_irq(), a new helper routine, kvm_arm_set_irq
is introduced.

Without that patch qemu exits with "kvm_set_irq: Invalid argument"
message.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Message-id: 20191003154640.22451-3-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h  |  1 +
 hw/intc/arm_gic_kvm.c |  7 ++-----
 target/arm/cpu.c      | 10 ++++------
 target/arm/kvm.c      | 12 ++++++++++++
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b3106c8600a..b4e19457a09 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -253,6 +253,7 @@ int kvm_arm_vgic_probe(void);
 
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
 void kvm_arm_pmu_init(CPUState *cs);
+int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 #else
 
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index b56fda144f9..9deb15e7e69 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -55,7 +55,7 @@ void kvm_arm_gic_set_irq(uint32_t num_irq, int irq, int level)
      * has separate fields in the irq number for type,
      * CPU number and interrupt number.
      */
-    int kvm_irq, irqtype, cpu;
+    int irqtype, cpu;
 
     if (irq < (num_irq - GIC_INTERNAL)) {
         /* External interrupt. The kernel numbers these like the GIC
@@ -72,10 +72,7 @@ void kvm_arm_gic_set_irq(uint32_t num_irq, int irq, int level)
         cpu = irq / GIC_INTERNAL;
         irq %= GIC_INTERNAL;
     }
-    kvm_irq = (irqtype << KVM_ARM_IRQ_TYPE_SHIFT)
-        | (cpu << KVM_ARM_IRQ_VCPU_SHIFT) | irq;
-
-    kvm_set_irq(kvm_state, kvm_irq, !!level);
+    kvm_arm_set_irq(cpu, irqtype, irq, !!level);
 }
 
 static void kvm_arm_gicv2_set_irq(void *opaque, int irq, int level)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2399c144718..13813fb2135 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -576,16 +576,16 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
-    int kvm_irq = KVM_ARM_IRQ_TYPE_CPU << KVM_ARM_IRQ_TYPE_SHIFT;
     uint32_t linestate_bit;
+    int irq_id;
 
     switch (irq) {
     case ARM_CPU_IRQ:
-        kvm_irq |= KVM_ARM_IRQ_CPU_IRQ;
+        irq_id = KVM_ARM_IRQ_CPU_IRQ;
         linestate_bit = CPU_INTERRUPT_HARD;
         break;
     case ARM_CPU_FIQ:
-        kvm_irq |= KVM_ARM_IRQ_CPU_FIQ;
+        irq_id = KVM_ARM_IRQ_CPU_FIQ;
         linestate_bit = CPU_INTERRUPT_FIQ;
         break;
     default:
@@ -597,9 +597,7 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
     } else {
         env->irq_line_state &= ~linestate_bit;
     }
-
-    kvm_irq |= cs->cpu_index << KVM_ARM_IRQ_VCPU_SHIFT;
-    kvm_set_irq(kvm_state, kvm_irq, level ? 1 : 0);
+    kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, !!level);
 #endif
 }
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b2eaa50b8df..b10581fa066 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -744,6 +744,18 @@ int kvm_arm_vgic_probe(void)
     }
 }
 
+int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level)
+{
+    int kvm_irq = (irqtype << KVM_ARM_IRQ_TYPE_SHIFT) | irq;
+    int cpu_idx1 = cpu % 256;
+    int cpu_idx2 = cpu / 256;
+
+    kvm_irq |= (cpu_idx1 << KVM_ARM_IRQ_VCPU_SHIFT) |
+               (cpu_idx2 << KVM_ARM_IRQ_VCPU2_SHIFT);
+
+    return kvm_set_irq(kvm_state, kvm_irq, !!level);
+}
+
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
-- 
2.20.1


