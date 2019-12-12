Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2710522527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk7jx8bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2710522527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTB4-000647-JE
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHH-0005PO-JE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHF-00047s-CU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:27 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifSHF-00046L-3m
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:25 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so3272573wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XZyx9IFo+SVuB7CJJCU4PRrLmaZiUFG16v3dHoMQqKc=;
 b=Gk7jx8bgsRQg2LpMcPkhMMjU6HXsCWlD4PRCtaKgpHofUdrfloRNcJHbB7a5W18WDv
 Z2S7IMu5feJib8nS1yzGC6EsIh8MIX4G3n6xitG+/UPlpcRs2tXpvfYoaKEbXmCjIiC6
 rBZHJ16ygA4IXzCPwbY807AJ761dZxcQgCHGfh1CuBKi/dPudz/HP5lZTsr59lDdC0nP
 G98n1Dx+uMyqMN8IcGoCzI9TK5CpJPrvW2Vm+n0B7MFc1Q03JEOzeK9JVX3UkVzM86bX
 53eHre568SLqElgOoxEttdFifxB/MxGxP+Amlkj+tymuKxZo3uSHGx2dhA14/Z28lu2Y
 hxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=XZyx9IFo+SVuB7CJJCU4PRrLmaZiUFG16v3dHoMQqKc=;
 b=kMmlMxKNOUl1xnw1UzCVSvy2oA/M2T/SSRhXRKxmXgwxyjOvKcs/h0ExfFdd2CpP+I
 qhSdA8zo+0MxpjW5KOy8PL1mzPr+LIjruVVfaVN3/vB0X3C/8YHfCQtY19p+dDRgYiOP
 oTLxtkKLkhKhWsmBXnBj06KBbeXDFjTdsKoIi4GT/v3WCtNYL6sf6KC2YUW4gyJhXr7g
 jxNQBRkwriOnqu+h0eD0Dp+Zqc+wQRAL91OmTy1MnFqo9IoBuNBXjHm4MaF5iFYPnn4M
 E10cApmOrC36eHPI58TEfCwYPmiFIFW3gdrJTROocJ/YesRZ72GcQE5yb265SNOJrvm9
 tMbA==
X-Gm-Message-State: APjAAAXdV7vpqypnPn04oCBfF+ndGbKiUblOheF4DkJoMM7AurHzFaNv
 Cwyfc565fNmJ60N3RDFpmHlPt4jD
X-Google-Smtp-Source: APXvYqxRaMblsWrX08tTad4OQJibIdo2Q+zf+bPwHKHmCJBnMfaXNfoLGi2mTrmEz084i/Vqbj8Ejg==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr7557037wma.12.1576171763480;
 Thu, 12 Dec 2019 09:29:23 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 2sm6810130wrq.31.2019.12.12.09.29.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 09:29:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] x86: move more x86-generic functions out of PC files
Date: Thu, 12 Dec 2019 18:29:12 +0100
Message-Id: <1576171754-45138-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: philmd@redhat.com, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are needed by microvm too, so move them outside of PC-specific files.
With this patch, microvm.c need not include pc.h anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/acpi-build.c  |   1 +
 hw/i386/fw_cfg.c      |   1 -
 hw/i386/fw_cfg.h      |   2 +
 hw/i386/kvm/ioapic.c  |   2 +-
 hw/i386/microvm.c     |   3 +-
 hw/i386/pc.c          | 101 +-------------------------------------------------
 hw/i386/x86.c         | 100 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h  |  20 ----------
 include/hw/i386/x86.h |  18 +++++++++
 target/i386/kvm.c     |   2 +-
 target/i386/machine.c |   2 +-
 11 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 12ff55f..7b8da62 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -53,6 +53,7 @@
 /* Supported chipsets: */
 #include "hw/southbridge/piix.h"
 #include "hw/acpi/pcihp.h"
+#include "hw/i386/fw_cfg.h"
 #include "hw/i386/ich9.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/q35.h"
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 326e33e..da60ada 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -16,7 +16,6 @@
 #include "sysemu/numa.h"
 #include "hw/acpi/acpi.h"
 #include "hw/firmware/smbios.h"
-#include "hw/i386/pc.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/timer/hpet.h"
 #include "hw/nvram/fw_cfg.h"
diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index e0856a3..9e74278 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -12,6 +12,8 @@
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 
+#define FW_CFG_IO_BASE     0x510
+
 #define FW_CFG_ACPI_TABLES      (FW_CFG_ARCH_LOCAL + 0)
 #define FW_CFG_SMBIOS_ENTRIES   (FW_CFG_ARCH_LOCAL + 1)
 #define FW_CFG_IRQ0_OVERRIDE    (FW_CFG_ARCH_LOCAL + 2)
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index f94729c..8703f19 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
-#include "hw/i386/pc.h"
+#include "hw/i386/x86.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/ioapic_internal.h"
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 2068319..827ce29 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -32,7 +32,6 @@
 #include "hw/kvm/clock.h"
 #include "hw/i386/microvm.h"
 #include "hw/i386/x86.h"
-#include "hw/i386/pc.h"
 #include "target/i386/cpu.h"
 #include "hw/intc/i8259.h"
 #include "hw/timer/i8254.h"
@@ -133,7 +132,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
         qemu_irq *i8259;
 
-        i8259 = i8259_init(isa_bus, pc_allocate_cpu_irq());
+        i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             gsi_state->i8259_irq[i] = i8259[i];
         }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6a3212e..545b855 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -343,17 +343,6 @@ GlobalProperty pc_compat_1_4[] = {
 };
 const size_t pc_compat_1_4_len = G_N_ELEMENTS(pc_compat_1_4);
 
-void gsi_handler(void *opaque, int n, int level)
-{
-    GSIState *s = opaque;
-
-    DPRINTF("pc: %s GSI %d\n", level ? "raising" : "lowering", n);
-    if (n < ISA_NUM_IRQS) {
-        qemu_set_irq(s->i8259_irq[n], level);
-    }
-    qemu_set_irq(s->ioapic_irq[n], level);
-}
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
@@ -393,55 +382,6 @@ static uint64_t ioportF0_read(void *opaque, hwaddr addr, unsigned size)
     return 0xffffffffffffffffULL;
 }
 
-/* TSC handling */
-uint64_t cpu_get_tsc(CPUX86State *env)
-{
-    return cpu_get_ticks();
-}
-
-/* IRQ handling */
-int cpu_get_pic_interrupt(CPUX86State *env)
-{
-    X86CPU *cpu = env_archcpu(env);
-    int intno;
-
-    if (!kvm_irqchip_in_kernel()) {
-        intno = apic_get_interrupt(cpu->apic_state);
-        if (intno >= 0) {
-            return intno;
-        }
-        /* read the irq from the PIC */
-        if (!apic_accept_pic_intr(cpu->apic_state)) {
-            return -1;
-        }
-    }
-
-    intno = pic_read_irq(isa_pic);
-    return intno;
-}
-
-static void pic_irq_request(void *opaque, int irq, int level)
-{
-    CPUState *cs = first_cpu;
-    X86CPU *cpu = X86_CPU(cs);
-
-    DPRINTF("pic_irqs: %s irq %d\n", level? "raise" : "lower", irq);
-    if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
-        CPU_FOREACH(cs) {
-            cpu = X86_CPU(cs);
-            if (apic_accept_pic_intr(cpu->apic_state)) {
-                apic_deliver_pic_intr(cpu->apic_state, level);
-            }
-        }
-    } else {
-        if (level) {
-            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
-    }
-}
-
 /* PC cmos mappings */
 
 #define REG_EQUIPMENT_BYTE          0x14
@@ -885,16 +825,6 @@ void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd)
     nb_ne2k++;
 }
 
-DeviceState *cpu_get_current_apic(void)
-{
-    if (current_cpu) {
-        X86CPU *cpu = X86_CPU(current_cpu);
-        return cpu->apic_state;
-    } else {
-        return NULL;
-    }
-}
-
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
 {
     X86CPU *cpu = opaque;
@@ -1290,11 +1220,6 @@ uint64_t pc_pci_hole64_start(void)
     return ROUND_UP(hole64_start, 1 * GiB);
 }
 
-qemu_irq pc_allocate_cpu_irq(void)
-{
-    return qemu_allocate_irq(pic_irq_request, NULL, 0);
-}
-
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
 {
     DeviceState *dev = NULL;
@@ -1471,7 +1396,7 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
     } else if (xen_enabled()) {
         i8259 = xen_interrupt_controller_init();
     } else {
-        i8259 = i8259_init(isa_bus, pc_allocate_cpu_irq());
+        i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
     }
 
     for (size_t i = 0; i < ISA_NUM_IRQS; i++) {
@@ -1481,30 +1406,6 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
     g_free(i8259);
 }
 
-void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
-{
-    DeviceState *dev;
-    SysBusDevice *d;
-    unsigned int i;
-
-    if (kvm_ioapic_in_kernel()) {
-        dev = qdev_create(NULL, TYPE_KVM_IOAPIC);
-    } else {
-        dev = qdev_create(NULL, TYPE_IOAPIC);
-    }
-    if (parent_name) {
-        object_property_add_child(object_resolve_path(parent_name, NULL),
-                                  "ioapic", OBJECT(dev), NULL);
-    }
-    qdev_init_nofail(dev);
-    d = SYS_BUS_DEVICE(dev);
-    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
-
-    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-        gsi_state->ioapic_irq[i] = qdev_get_gpio_in(dev, i);
-    }
-}
-
 static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 6fb01e4..b14acca 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -42,11 +42,14 @@
 #include "hw/intc/i8259.h"
 
 #include "hw/acpi/cpu_hotplug.h"
+#include "hw/irq.h"
 #include "hw/nmi.h"
 #include "hw/loader.h"
 #include "multiboot.h"
 #include "elf.h"
 #include "standard-headers/asm-x86/bootparam.h"
+#include "config-devices.h"
+#include "kvm_i386.h"
 
 #define BIOS_FILENAME "bios.bin"
 
@@ -221,6 +224,103 @@ static long get_file_size(FILE *f)
     return size;
 }
 
+/* TSC handling */
+uint64_t cpu_get_tsc(CPUX86State *env)
+{
+    return cpu_get_ticks();
+}
+
+/* IRQ handling */
+static void pic_irq_request(void *opaque, int irq, int level)
+{
+    CPUState *cs = first_cpu;
+    X86CPU *cpu = X86_CPU(cs);
+
+    if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
+        CPU_FOREACH(cs) {
+            cpu = X86_CPU(cs);
+            if (apic_accept_pic_intr(cpu->apic_state)) {
+                apic_deliver_pic_intr(cpu->apic_state, level);
+            }
+        }
+    } else {
+        if (level) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
+qemu_irq x86_allocate_cpu_irq(void)
+{
+    return qemu_allocate_irq(pic_irq_request, NULL, 0);
+}
+
+int cpu_get_pic_interrupt(CPUX86State *env)
+{
+    X86CPU *cpu = env_archcpu(env);
+    int intno;
+
+    if (!kvm_irqchip_in_kernel()) {
+        intno = apic_get_interrupt(cpu->apic_state);
+        if (intno >= 0) {
+            return intno;
+        }
+        /* read the irq from the PIC */
+        if (!apic_accept_pic_intr(cpu->apic_state)) {
+            return -1;
+        }
+    }
+
+    intno = pic_read_irq(isa_pic);
+    return intno;
+}
+
+DeviceState *cpu_get_current_apic(void)
+{
+    if (current_cpu) {
+        X86CPU *cpu = X86_CPU(current_cpu);
+        return cpu->apic_state;
+    } else {
+        return NULL;
+    }
+}
+
+void gsi_handler(void *opaque, int n, int level)
+{
+    GSIState *s = opaque;
+
+    if (n < ISA_NUM_IRQS) {
+        qemu_set_irq(s->i8259_irq[n], level);
+    }
+    qemu_set_irq(s->ioapic_irq[n], level);
+}
+
+void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
+{
+    DeviceState *dev;
+    SysBusDevice *d;
+    unsigned int i;
+
+    if (kvm_ioapic_in_kernel()) {
+        dev = qdev_create(NULL, TYPE_KVM_IOAPIC);
+    } else {
+        dev = qdev_create(NULL, TYPE_IOAPIC);
+    }
+    if (parent_name) {
+        object_property_add_child(object_resolve_path(parent_name, NULL),
+                                  "ioapic", OBJECT(dev), NULL);
+    }
+    qdev_init_nofail(dev);
+    d = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
+
+    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
+        gsi_state->ioapic_irq[i] = qdev_get_gpio_in(dev, i);
+    }
+}
+
 struct setup_data {
     uint64_t next;
     uint32_t type;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ca641e8..e512838 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -3,11 +3,9 @@
 
 #include "exec/memory.h"
 #include "hw/boards.h"
-#include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
 #include "hw/block/flash.h"
 #include "net/net.h"
-#include "hw/i386/ioapic.h"
 #include "hw/i386/x86.h"
 
 #include "qemu/range.h"
@@ -134,17 +132,6 @@ typedef struct PCMachineClass {
 
 /* ioapic.c */
 
-/* Global System Interrupts */
-
-#define GSI_NUM_PINS IOAPIC_NUM_PINS
-
-typedef struct GSIState {
-    qemu_irq i8259_irq[ISA_NUM_IRQS];
-    qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
-} GSIState;
-
-void gsi_handler(void *opaque, int n, int level);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
 
 /* vmport.c */
@@ -188,7 +175,6 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *rom_memory,
                     MemoryRegion **ram_memory);
 uint64_t pc_pci_hole64_start(void);
-qemu_irq pc_allocate_cpu_irq(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice **rtc_state,
@@ -206,18 +192,12 @@ void pc_pci_device_init(PCIBus *pci_bus);
 typedef void (*cpu_set_smm_t)(int smm, void *arg);
 
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
-void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
 
 ISADevice *pc_find_fdc0(void);
 int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
-#define FW_CFG_IO_BASE     0x510
-
 #define PORT92_A20_LINE "a20"
 
-/* hpet.c */
-extern int no_hpet;
-
 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 97d1575..41fe37b 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -23,6 +23,8 @@
 
 #include "hw/boards.h"
 #include "hw/nmi.h"
+#include "hw/isa/isa.h"
+#include "hw/i386/ioapic.h"
 
 typedef struct {
     /*< private >*/
@@ -100,4 +102,20 @@ void x86_load_linux(X86MachineState *x86ms,
 
 bool x86_machine_is_smm_enabled(X86MachineState *x86ms);
 
+/* Global System Interrupts */
+
+#define GSI_NUM_PINS IOAPIC_NUM_PINS
+
+typedef struct GSIState {
+    qemu_irq i8259_irq[ISA_NUM_IRQS];
+    qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
+} GSIState;
+
+qemu_irq x86_allocate_cpu_irq(void);
+void gsi_handler(void *opaque, int n, int level);
+void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
+
+/* hpet.c */
+extern int no_hpet;
+
 #endif
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index c7ff67a..55e6265 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -35,7 +35,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
-#include "hw/i386/pc.h"
+#include "hw/i386/x86.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/i386/apic-msidef.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 2699eed..b6720d8 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1,10 +1,10 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "migration/cpu.h"
 #include "hyperv.h"
+#include "hw/i386/x86.h"
 #include "kvm_i386.h"
 
 #include "sysemu/kvm.h"
-- 
1.8.3.1



