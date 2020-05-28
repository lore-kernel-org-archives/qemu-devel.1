Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276B9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30BC208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RHYsUqWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30BC208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeR6Z-0002qe-Tw
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvw-0003Mn-Gk; Thu, 28 May 2020 18:23:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvj-00064j-FA; Thu, 28 May 2020 18:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704595; x=1622240595;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bvwri5Zp6ypKxEBHfELl3xgsE3Zz5p1AOKRot2+qvMI=;
 b=RHYsUqWCIbVyEP6DIJDC3ozQWbWD7KQxIXKsdQIwNbRPf/pROGqNuOv1
 29+oRCWtPS6DpC0dio6NqGL9XOY76wEhVufC3kARrDM4v46O0EcQGLsCi
 y81D/n5EqtOOvSpCbOSsOV0v6bDeD+i5Wnq/IinJxVXyWgOYONPEAlpC0
 arerxKOogJ3HyU6nzfcRX95NDrtK0KfDWVfxT4qS11U6+k8hXVIWlO+X+
 Fg6V4pewiHFdLx+pZV/UXz7c/NlSR9j4OiAAImm4o5EdJy48kmCyuhLcJ
 VWkFD6w2HrEtkudgO4C0POvK3Q85Ew8zYlXyX+Tiom+fKHFysFO+kfPgb w==;
IronPort-SDR: Wns6Oli53qmNWwVuqRUpUX8euEl9/OCmJ2i0gxm068qjHJsmXoVa4jQsCrWJbIY3GRFO4zb+UF
 b/ax/eq9rjbdGiXj49XzTRiT2GQrvM8oLdzQn5VsEL1fOnSPW4fh5j+vmLKlQPMFQFgsrKbRsi
 j0mXc+HB23SCXgCfpE37hAS9pj5QbFuTZPjdruMnn+95avrl19GbcZ/WMrQnhGxnKts+B6bak9
 ajj4ymw65HurOvuLcHgk6LYWjIvccdNDqTRWizzWBdM6K7BSYZ1yw3FxpFTa7EU5hBodycsQeX
 LSY=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="143076000"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:23:05 +0800
IronPort-SDR: 364b1cxoxDmxO/qimifdG/XxMNpE6QBNQd3/Esj3wz8up8TmZ7zDQiNLtCqIq+wtv+j69gxWQJ
 ynIaOtqxn8OR5OzFFKfJIRwh4AMnHnM7M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:12:20 -0700
IronPort-SDR: w1TmiYuA0XDny548qkIocyTfE9pgIByM/fsewdefvm+WJpjptldfjVOWVqH9ODhJ/CxV7uFG4Z
 /uwrZwGsFD/w==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2020 15:23:04 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v5 08/11] hw/intc: Initial commit of lowRISC Ibex PLIC
Date: Thu, 28 May 2020 15:14:28 -0700
Message-Id: <b2a2f70eed173de4ae1d5a66ffff7df90822b216.1590704015.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590704015.git.alistair.francis@wdc.com>
References: <cover.1590704015.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:23:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Ibex core contains a PLIC that although similar to the RISC-V spec
is not RISC-V spec compliant.

This patch implements a Ibex PLIC in a somewhat generic way.

As the current RISC-V PLIC needs tidying up, my hope is that as the Ibex
PLIC move towards spec compliance this PLIC implementation can be
updated until it can replace the current PLIC.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/intc/ibex_plic.h |  63 +++++++++
 hw/intc/ibex_plic.c         | 261 ++++++++++++++++++++++++++++++++++++
 MAINTAINERS                 |   2 +
 hw/intc/Makefile.objs       |   1 +
 4 files changed, 327 insertions(+)
 create mode 100644 include/hw/intc/ibex_plic.h
 create mode 100644 hw/intc/ibex_plic.c

diff --git a/include/hw/intc/ibex_plic.h b/include/hw/intc/ibex_plic.h
new file mode 100644
index 0000000000..ddc7909903
--- /dev/null
+++ b/include/hw/intc/ibex_plic.h
@@ -0,0 +1,63 @@
+/*
+ * QEMU RISC-V lowRISC Ibex PLIC
+ *
+ * Copyright (c) 2020 Western Digital
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_IBEX_PLIC_H
+#define HW_IBEX_PLIC_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_IBEX_PLIC "ibex-plic"
+#define IBEX_PLIC(obj) \
+    OBJECT_CHECK(IbexPlicState, (obj), TYPE_IBEX_PLIC)
+
+typedef struct IbexPlicState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+
+    uint32_t *pending;
+    uint32_t *source;
+    uint32_t *priority;
+    uint32_t *enable;
+    uint32_t threshold;
+    uint32_t claim;
+
+    /* config */
+    uint32_t num_cpus;
+    uint32_t num_sources;
+
+    uint32_t pending_base;
+    uint32_t pending_num;
+
+    uint32_t source_base;
+    uint32_t source_num;
+
+    uint32_t priority_base;
+    uint32_t priority_num;
+
+    uint32_t enable_base;
+    uint32_t enable_num;
+
+    uint32_t threshold_base;
+
+    uint32_t claim_base;
+} IbexPlicState;
+
+#endif /* HW_IBEX_PLIC_H */
diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
new file mode 100644
index 0000000000..41079518c6
--- /dev/null
+++ b/hw/intc/ibex_plic.c
@@ -0,0 +1,261 @@
+/*
+ * QEMU RISC-V lowRISC Ibex PLIC
+ *
+ * Copyright (c) 2020 Western Digital
+ *
+ * Documentation avaliable: https://docs.opentitan.org/hw/ip/rv_plic/doc/
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/core/cpu.h"
+#include "hw/boards.h"
+#include "hw/pci/msi.h"
+#include "target/riscv/cpu_bits.h"
+#include "target/riscv/cpu.h"
+#include "hw/intc/ibex_plic.h"
+
+static bool addr_between(uint32_t addr, uint32_t base, uint32_t num)
+{
+    uint32_t end = base + (num * 0x04);
+
+    if (addr >= base && addr < end) {
+        return true;
+    }
+
+    return false;
+}
+
+static void ibex_plic_irqs_set_pending(IbexPlicState *s, int irq, bool level)
+{
+    int pending_num = irq / 32;
+
+    s->pending[pending_num] |= level << (irq % 32);
+}
+
+static bool ibex_plic_irqs_pending(IbexPlicState *s, uint32_t context)
+{
+    int i;
+
+    for (i = 0; i < s->pending_num; i++) {
+        uint32_t irq_num = ctz64(s->pending[i]) + (i * 32);
+
+        if (!(s->pending[i] & s->enable[i])) {
+            /* No pending and enabled IRQ */
+            continue;
+        }
+
+        if (s->priority[irq_num] > s->threshold) {
+            if (!s->claim) {
+                s->claim = irq_num;
+            }
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static void ibex_plic_update(IbexPlicState *s)
+{
+    CPUState *cpu;
+    int level, i;
+
+    for (i = 0; i < s->num_cpus; i++) {
+        cpu = qemu_get_cpu(i);
+
+        if (!cpu) {
+            continue;
+        }
+
+        level = ibex_plic_irqs_pending(s, 0);
+
+        riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MEIP, BOOL_TO_MASK(level));
+    }
+}
+
+static void ibex_plic_reset(DeviceState *dev)
+{
+    IbexPlicState *s = IBEX_PLIC(dev);
+
+    s->threshold = 0x00000000;
+    s->claim = 0x00000000;
+}
+
+static uint64_t ibex_plic_read(void *opaque, hwaddr addr,
+                               unsigned int size)
+{
+    IbexPlicState *s = opaque;
+    int offset;
+    uint32_t ret = 0;
+
+    if (addr_between(addr, s->pending_base, s->pending_num)) {
+        offset = (addr - s->pending_base) / 4;
+        ret = s->pending[offset];
+    } else if (addr_between(addr, s->source_base, s->source_num)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Interrupt source mode not supported\n", __func__);
+    } else if (addr_between(addr, s->priority_base, s->priority_num)) {
+        offset = (addr - s->priority_base) / 4;
+        ret = s->priority[offset];
+    } else if (addr_between(addr, s->enable_base, s->enable_num)) {
+        offset = (addr - s->enable_base) / 4;
+        ret = s->enable[offset];
+    } else if (addr_between(addr, s->threshold_base, 1)) {
+        ret = s->threshold;
+    } else if (addr_between(addr, s->claim_base, 1)) {
+        int pending_num = s->claim / 32;
+        s->pending[pending_num] &= ~(1 << (s->claim % 32));
+
+        ret = s->claim;
+    }
+
+    return ret;
+}
+
+static void ibex_plic_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned int size)
+{
+    IbexPlicState *s = opaque;
+
+    if (addr_between(addr, s->pending_base, s->pending_num)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Pending registers are read only\n", __func__);
+    } else if (addr_between(addr, s->source_base, s->source_num)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Interrupt source mode not supported\n", __func__);
+    } else if (addr_between(addr, s->priority_base, s->priority_num)) {
+        uint32_t irq = ((addr - s->priority_base) >> 2) + 1;
+        s->priority[irq] = value & 7;
+    } else if (addr_between(addr, s->enable_base, s->enable_num)) {
+        uint32_t enable_reg = (addr - s->enable_base) / 4;
+
+        s->enable[enable_reg] = value;
+    } else if (addr_between(addr, s->threshold_base, 1)) {
+        s->threshold = value & 3;
+    } else if (addr_between(addr, s->claim_base, 1)) {
+        if (s->claim == value) {
+            /* Interrupt was completed */
+            s->claim = 0;
+        }
+    }
+
+    ibex_plic_update(s);
+}
+
+static const MemoryRegionOps ibex_plic_ops = {
+    .read = ibex_plic_read,
+    .write = ibex_plic_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static void ibex_plic_irq_request(void *opaque, int irq, int level)
+{
+    IbexPlicState *s = opaque;
+
+    ibex_plic_irqs_set_pending(s, irq, level > 0);
+    ibex_plic_update(s);
+}
+
+static Property ibex_plic_properties[] = {
+    DEFINE_PROP_UINT32("num-cpus", IbexPlicState, num_cpus, 1),
+    DEFINE_PROP_UINT32("num-sources", IbexPlicState, num_sources, 80),
+
+    DEFINE_PROP_UINT32("pending-base", IbexPlicState, pending_base, 0),
+    DEFINE_PROP_UINT32("pending-num", IbexPlicState, pending_num, 3),
+
+    DEFINE_PROP_UINT32("source-base", IbexPlicState, source_base, 0x0c),
+    DEFINE_PROP_UINT32("source-num", IbexPlicState, source_num, 3),
+
+    DEFINE_PROP_UINT32("priority-base", IbexPlicState, priority_base, 0x18),
+    DEFINE_PROP_UINT32("priority-num", IbexPlicState, priority_num, 80),
+
+    DEFINE_PROP_UINT32("enable-base", IbexPlicState, enable_base, 0x200),
+    DEFINE_PROP_UINT32("enable-num", IbexPlicState, enable_num, 3),
+
+    DEFINE_PROP_UINT32("threshold-base", IbexPlicState, threshold_base, 0x20c),
+
+    DEFINE_PROP_UINT32("claim-base", IbexPlicState, claim_base, 0x210),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ibex_plic_init(Object *obj)
+{
+    IbexPlicState *s = IBEX_PLIC(obj);
+
+    memory_region_init_io(&s->mmio, obj, &ibex_plic_ops, s,
+                          TYPE_IBEX_PLIC, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void ibex_plic_realize(DeviceState *dev, Error **errp)
+{
+    IbexPlicState *s = IBEX_PLIC(dev);
+    int i;
+
+    s->pending = g_new0(uint32_t, s->pending_num);
+    s->source = g_new0(uint32_t, s->source_num);
+    s->priority = g_new0(uint32_t, s->priority_num);
+    s->enable = g_new0(uint32_t, s->enable_num);
+
+    qdev_init_gpio_in(dev, ibex_plic_irq_request, s->num_sources);
+
+    /*
+     * We can't allow the supervisor to control SEIP as this would allow the
+     * supervisor to clear a pending external interrupt which will result in
+     * a lost interrupt in the case a PLIC is attached. The SEIP bit must be
+     * hardware controlled when a PLIC is attached.
+     */
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int smp_cpus = ms->smp.cpus;
+    for (i = 0; i < smp_cpus; i++) {
+        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(i));
+        if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
+            error_report("SEIP already claimed");
+            exit(1);
+        }
+    }
+
+    msi_nonbroken = true;
+}
+
+static void ibex_plic_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = ibex_plic_reset;
+    device_class_set_props(dc, ibex_plic_properties);
+    dc->realize = ibex_plic_realize;
+}
+
+static const TypeInfo ibex_plic_info = {
+    .name          = TYPE_IBEX_PLIC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IbexPlicState),
+    .instance_init = ibex_plic_init,
+    .class_init    = ibex_plic_class_init,
+};
+
+static void ibex_plic_register_types(void)
+{
+    type_register_static(&ibex_plic_info);
+}
+
+type_init(ibex_plic_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index a1ce186a7e..d6b2819e44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1246,8 +1246,10 @@ L: qemu-riscv@nongnu.org
 S: Supported
 F: hw/riscv/opentitan.c
 F: hw/char/ibex_uart.c
+F: hw/intc/ibex_plic.c
 F: include/hw/riscv/opentitan.h
 F: include/hw/char/ibex_uart.h
+F: include/hw/intc/ibex_plic.h
 
 SH4 Machines
 ------------
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index f726d87532..a61e6728fe 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -49,3 +49,4 @@ obj-$(CONFIG_ARM_GIC) += arm_gicv3_cpuif.o
 obj-$(CONFIG_MIPS_CPS) += mips_gic.o
 obj-$(CONFIG_NIOS2) += nios2_iic.o
 obj-$(CONFIG_OMPIC) += ompic.o
+obj-$(CONFIG_IBEX) += ibex_plic.o
-- 
2.26.2


