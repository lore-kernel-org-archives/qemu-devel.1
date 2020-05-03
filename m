Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4FFC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7608020721
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNmrnmY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7608020721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVBet-0006qb-E7
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBdh-0005PJ-L1
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:14:25 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBdg-0003iw-Gf
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:14:25 -0400
Received: by mail-pg1-x543.google.com with SMTP id 207so1467298pgc.6
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=C2hqhk4vQkAiLC82v9fKuhyaac08UGTCEkI3lHZmGpg=;
 b=rNmrnmY+h0bm9j9Nx9jwI4/XrLNF1TRsPGiGeNNI7+ebtkgI2PIWu10U8vOqJtxIYR
 ++GGOe4/jKSY4sc92goNSZrg1flMigBtTW/CBoG6w9NgAXwRDPecee+3FY7IwPmyqx7u
 DvKgjDnevxwGHvkqK362N3uQ0I4AM2Tq5KPN99m7i82DsPra0nVzSpMOgW4Fqw3XbDCx
 uXpv++A5TFQvVTE3/tWyhGC56qr1k2RIJygzH4YAkwWH+3G+mlWZTnYj7E/2ZeykKaX6
 8L8jTBobZLFp0bXwtOmfxbZnPFf/65BPJIfRQbp3MuOZTGdnk5ORoQQ3SpaVXcVOKviN
 Pabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=C2hqhk4vQkAiLC82v9fKuhyaac08UGTCEkI3lHZmGpg=;
 b=P4bLpgJ7zyE3bWmRr91MMWB0u1ACjDT81yqB02NH9Gn0o7vQ4UHvTmWteTxkCopxx1
 71lRzV9u9bxCsg1UbVjrR92RwVnNlvQ0wV26NRpXUDfN8Vb8OMrQFguf0coHRApx7Bbf
 G5CsgGeNfl6qirZ+kbPRiJP+cETBmB51IEdCOJNzIvvxw4awdBhxsyDMiaxfX7yAqzf4
 aQVpLLN6ED6hcV//QG1WsPyoBOU+MphubJJaICl7dez+/GLZzLgO3xA+e3QhqMXNTYe4
 xa6PrlzUVg2Y+SlSTIftWMvdp0SXvJ9QI35Rbp3U3WeQAEtPQ+ZhOVH4fb0MJhZBXuJP
 /x8g==
X-Gm-Message-State: AGi0PuZWku/Nz0wKokd02919OeWI7pL/OL83DF0jPR4iktJ27dcWEaID
 d7i452k0ra6DS/BdY1GQh0U=
X-Google-Smtp-Source: APiQypLa0BkkkRXxkuVnGYi5xPAADKxjYTXcVZWg5M79Q9cL5oo7HieJP84u4oP3h7f6QLUvEMpiqg==
X-Received: by 2002:a63:d90c:: with SMTP id r12mr12072346pgg.158.1588500863154; 
 Sun, 03 May 2020 03:14:23 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id r26sm6329902pfq.75.2020.05.03.03.14.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 03:14:22 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH V3 10/14] KVM: MIPS: Add Loongson-3 Virtual IPI interrupt
 support
Date: Sun,  3 May 2020 18:06:03 +0800
Message-Id: <1588500367-1056-11-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=chenhuacai@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: kvm@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch add Loongson-3 Virtual IPI interrupt support in the kernel,
because emulate it in QEMU is too expensive for performance.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/kvm_host.h |  32 ++++++
 arch/mips/kvm/Makefile           |   3 +
 arch/mips/kvm/emulate.c          |  23 ++++-
 arch/mips/kvm/loongson_ipi.c     | 214 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/mips.c             |   6 ++
 5 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/kvm/loongson_ipi.c

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index a7758c0..f165902 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -23,6 +23,8 @@
 #include <asm/inst.h>
 #include <asm/mipsregs.h>
 
+#include <kvm/iodev.h>
+
 /* MIPS KVM register ids */
 #define MIPS_CP0_32(_R, _S)					\
 	(KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U32 | (8 * (_R) + (_S)))
@@ -181,11 +183,39 @@ struct kvm_vcpu_stat {
 struct kvm_arch_memory_slot {
 };
 
+#ifdef CONFIG_CPU_LOONGSON64
+struct ipi_state {
+	uint32_t status;
+	uint32_t en;
+	uint32_t set;
+	uint32_t clear;
+	uint64_t buf[4];
+};
+
+struct loongson_kvm_ipi;
+
+struct ipi_io_device {
+	int node_id;
+	struct loongson_kvm_ipi *ipi;
+	struct kvm_io_device device;
+};
+
+struct loongson_kvm_ipi {
+	spinlock_t lock;
+	struct kvm *kvm;
+	struct ipi_state ipistate[16];
+	struct ipi_io_device dev_ipi[4];
+};
+#endif
+
 struct kvm_arch {
 	/* Guest physical mm */
 	struct mm_struct gpa_mm;
 	/* Mask of CPUs needing GPA ASID flush */
 	cpumask_t asid_flush_mask;
+#ifdef CONFIG_CPU_LOONGSON64
+	struct loongson_kvm_ipi ipi;
+#endif
 };
 
 #define N_MIPS_COPROC_REGS	32
@@ -1133,6 +1163,8 @@ extern int kvm_mips_trans_mtc0(union mips_instruction inst, u32 *opc,
 /* Misc */
 extern void kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
 extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
+extern int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
+			     struct kvm_mips_interrupt *irq);
 
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 0a3cef6..506c4ac 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -13,6 +13,9 @@ kvm-objs := $(common-objs-y) mips.o emulate.o entry.o \
 	    fpu.o
 kvm-objs += hypcall.o
 kvm-objs += mmu.o
+ifdef CONFIG_CPU_LOONGSON64
+kvm-objs += loongson_ipi.o
+endif
 
 ifdef CONFIG_KVM_MIPS_VZ
 kvm-objs		+= vz.o
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 754094b..3946499 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1600,6 +1600,7 @@ enum emulation_result kvm_mips_emulate_store(union mips_instruction inst,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu)
 {
+	int r;
 	enum emulation_result er;
 	u32 rt;
 	void *data = run->mmio.data;
@@ -1666,9 +1667,18 @@ enum emulation_result kvm_mips_emulate_store(union mips_instruction inst,
 		goto out_fail;
 	}
 
-	run->mmio.is_write = 1;
 	vcpu->mmio_needed = 1;
+	run->mmio.is_write = 1;
 	vcpu->mmio_is_write = 1;
+
+	r = kvm_io_bus_write(vcpu, KVM_MMIO_BUS,
+			run->mmio.phys_addr, run->mmio.len, data);
+
+	if (!r) {
+		vcpu->mmio_needed = 0;
+		return EMULATE_DONE;
+	}
+
 	return EMULATE_DO_MMIO;
 
 out_fail:
@@ -1681,6 +1691,7 @@ enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
 					    u32 cause, struct kvm_run *run,
 					    struct kvm_vcpu *vcpu)
 {
+	int r;
 	enum emulation_result er;
 	unsigned long curr_pc;
 	u32 op, rt;
@@ -1745,6 +1756,16 @@ enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
 
 	run->mmio.is_write = 0;
 	vcpu->mmio_is_write = 0;
+
+	r = kvm_io_bus_read(vcpu, KVM_MMIO_BUS,
+			run->mmio.phys_addr, run->mmio.len, run->mmio.data);
+
+	if (!r) {
+		kvm_mips_complete_mmio_load(vcpu, run);
+		vcpu->mmio_needed = 0;
+		return EMULATE_DONE;
+	}
+
 	return EMULATE_DO_MMIO;
 }
 
diff --git a/arch/mips/kvm/loongson_ipi.c b/arch/mips/kvm/loongson_ipi.c
new file mode 100644
index 00000000..3681fc8
--- /dev/null
+++ b/arch/mips/kvm/loongson_ipi.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Loongson-3 Virtual IPI interrupt support.
+ *
+ * Copyright (C) 2019  Loongson Technologies, Inc.  All rights reserved.
+ *
+ * Authors: Chen Zhu <zhuchen@loongson.cn>
+ * Authors: Huacai Chen <chenhc@lemote.com>
+ */
+
+#include <linux/kvm_host.h>
+
+#define IPI_BASE            0x3ff01000ULL
+
+#define CORE0_STATUS_OFF       0x000
+#define CORE0_EN_OFF           0x004
+#define CORE0_SET_OFF          0x008
+#define CORE0_CLEAR_OFF        0x00c
+#define CORE0_BUF_20           0x020
+#define CORE0_BUF_28           0x028
+#define CORE0_BUF_30           0x030
+#define CORE0_BUF_38           0x038
+
+#define CORE1_STATUS_OFF       0x100
+#define CORE1_EN_OFF           0x104
+#define CORE1_SET_OFF          0x108
+#define CORE1_CLEAR_OFF        0x10c
+#define CORE1_BUF_20           0x120
+#define CORE1_BUF_28           0x128
+#define CORE1_BUF_30           0x130
+#define CORE1_BUF_38           0x138
+
+#define CORE2_STATUS_OFF       0x200
+#define CORE2_EN_OFF           0x204
+#define CORE2_SET_OFF          0x208
+#define CORE2_CLEAR_OFF        0x20c
+#define CORE2_BUF_20           0x220
+#define CORE2_BUF_28           0x228
+#define CORE2_BUF_30           0x230
+#define CORE2_BUF_38           0x238
+
+#define CORE3_STATUS_OFF       0x300
+#define CORE3_EN_OFF           0x304
+#define CORE3_SET_OFF          0x308
+#define CORE3_CLEAR_OFF        0x30c
+#define CORE3_BUF_20           0x320
+#define CORE3_BUF_28           0x328
+#define CORE3_BUF_30           0x330
+#define CORE3_BUF_38           0x338
+
+static int loongson_vipi_read(struct loongson_kvm_ipi *ipi,
+				gpa_t addr, int len, void *val)
+{
+	uint32_t core = (addr >> 8) & 3;
+	uint32_t node = (addr >> 44) & 3;
+	uint32_t id = core + node * 4;
+	uint64_t offset = addr & 0xff;
+	void *pbuf;
+	struct ipi_state *s = &(ipi->ipistate[id]);
+
+	BUG_ON(offset & (len - 1));
+
+	switch (offset) {
+	case CORE0_STATUS_OFF:
+		*(uint64_t *)val = s->status;
+		break;
+
+	case CORE0_EN_OFF:
+		*(uint64_t *)val = s->en;
+		break;
+
+	case CORE0_SET_OFF:
+		*(uint64_t *)val = 0;
+		break;
+
+	case CORE0_CLEAR_OFF:
+		*(uint64_t *)val = 0;
+		break;
+
+	case CORE0_BUF_20 ... CORE0_BUF_38:
+		pbuf = (void *)s->buf + (offset - 0x20);
+		if (len == 8)
+			*(uint64_t *)val = *(uint64_t *)pbuf;
+		else /* Assume len == 4 */
+			*(uint32_t *)val = *(uint32_t *)pbuf;
+		break;
+
+	default:
+		pr_notice("%s with unknown addr %llx\n", __func__, addr);
+		break;
+	}
+
+	return 0;
+}
+
+static int loongson_vipi_write(struct loongson_kvm_ipi *ipi,
+				gpa_t addr, int len, const void *val)
+{
+	uint32_t core = (addr >> 8) & 3;
+	uint32_t node = (addr >> 44) & 3;
+	uint32_t id = core + node * 4;
+	uint64_t data, offset = addr & 0xff;
+	void *pbuf;
+	struct kvm *kvm = ipi->kvm;
+	struct kvm_mips_interrupt irq;
+	struct ipi_state *s = &(ipi->ipistate[id]);
+
+	data = *(uint64_t *)val;
+	BUG_ON(offset & (len - 1));
+
+	switch (offset) {
+	case CORE0_STATUS_OFF:
+		break;
+
+	case CORE0_EN_OFF:
+		s->en = data;
+		break;
+
+	case CORE0_SET_OFF:
+		s->status |= data;
+		irq.cpu = id;
+		irq.irq = 6;
+		kvm_vcpu_ioctl_interrupt(kvm->vcpus[id], &irq);
+		break;
+
+	case CORE0_CLEAR_OFF:
+		s->status &= ~data;
+		if (!s->status) {
+			irq.cpu = id;
+			irq.irq = -6;
+			kvm_vcpu_ioctl_interrupt(kvm->vcpus[id], &irq);
+		}
+		break;
+
+	case CORE0_BUF_20 ... CORE0_BUF_38:
+		pbuf = (void *)s->buf + (offset - 0x20);
+		if (len == 8)
+			*(uint64_t *)pbuf = (uint64_t)data;
+		else /* Assume len == 4 */
+			*(uint32_t *)pbuf = (uint32_t)data;
+		break;
+
+	default:
+		pr_notice("%s with unknown addr %llx\n", __func__, addr);
+		break;
+	}
+
+	return 0;
+}
+
+static int kvm_ipi_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
+			gpa_t addr, int len, void *val)
+{
+	unsigned long flags;
+	struct loongson_kvm_ipi *ipi;
+	struct ipi_io_device *ipi_device;
+
+	ipi_device = container_of(dev, struct ipi_io_device, device);
+	ipi = ipi_device->ipi;
+
+	spin_lock_irqsave(&ipi->lock, flags);
+	loongson_vipi_read(ipi, addr, len, val);
+	spin_unlock_irqrestore(&ipi->lock, flags);
+
+	return 0;
+}
+
+static int kvm_ipi_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
+			gpa_t addr, int len, const void *val)
+{
+	unsigned long flags;
+	struct loongson_kvm_ipi *ipi;
+	struct ipi_io_device *ipi_device;
+
+	ipi_device = container_of(dev, struct ipi_io_device, device);
+	ipi = ipi_device->ipi;
+
+	spin_lock_irqsave(&ipi->lock, flags);
+	loongson_vipi_write(ipi, addr, len, val);
+	spin_unlock_irqrestore(&ipi->lock, flags);
+
+	return 0;
+}
+
+static const struct kvm_io_device_ops kvm_ipi_ops = {
+	.read     = kvm_ipi_read,
+	.write    = kvm_ipi_write,
+};
+
+void kvm_init_loongson_ipi(struct kvm *kvm)
+{
+	int i;
+	unsigned long addr;
+	struct loongson_kvm_ipi *s;
+	struct kvm_io_device *device;
+
+	s = &kvm->arch.ipi;
+	s->kvm = kvm;
+	spin_lock_init(&s->lock);
+
+	/*
+	 * Initialize IPI device
+	 */
+	for (i = 0; i < 4; i++) {
+		device = &s->dev_ipi[i].device;
+		kvm_iodevice_init(device, &kvm_ipi_ops);
+		addr = (((unsigned long)i) << 44) + IPI_BASE;
+		mutex_lock(&kvm->slots_lock);
+		kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, 0x400, device);
+		mutex_unlock(&kvm->slots_lock);
+		s->dev_ipi[i].ipi = s;
+		s->dev_ipi[i].node_id = i;
+	}
+}
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 5ca122c..ed989ef 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -128,6 +128,8 @@ int kvm_arch_check_processor_compat(void *opaque)
 	return 0;
 }
 
+extern void kvm_init_loongson_ipi(struct kvm *kvm);
+
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	switch (type) {
@@ -147,6 +149,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (!kvm->arch.gpa_mm.pgd)
 		return -ENOMEM;
 
+#ifdef CONFIG_CPU_LOONGSON64
+	kvm_init_loongson_ipi(kvm);
+#endif
+
 	return 0;
 }
 
-- 
2.7.0


