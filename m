Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68B2C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 05:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774292075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 05:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774292075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45095 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFuNK-0005tD-KY
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 01:41:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHT-0001LK-QA
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHR-0003Un-23
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:47 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:37743)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHQ-0003Ts-FT
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:44 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.vps.ablenet.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail03.asahi-net.or.jp (Postfix) with ESMTPA id A3FE63EBE6;
	Mon, 15 Apr 2019 14:35:42 +0900 (JST)
Received: from ysato.dip.jp (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 419F3240086; 
	Mon, 15 Apr 2019 14:35:42 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 14:35:21 +0900
Message-Id: <20190415053531.77264-4-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190415053531.77264-1-ysato@users.sourceforge.jp>
References: <20190415053531.77264-1-ysato@users.sourceforge.jp>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.15
Subject: [Qemu-devel] [PATCH RFC v7 03/12] target/rx: CPU definition
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415053521.Uucp9wRqGx1nGfcDb_vmr3jo04Vq6K_7wUJfUO8STzg@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 target/rx/cpu-qom.h |  52 ++++++++++++
 target/rx/cpu.h     | 197 ++++++++++++++++++++++++++++++++++++++++++++
 target/rx/cpu.c     | 232 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 481 insertions(+)
 create mode 100644 target/rx/cpu-qom.h
 create mode 100644 target/rx/cpu.h
 create mode 100644 target/rx/cpu.c

diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
new file mode 100644
index 0000000000..bad6d2c75d
--- /dev/null
+++ b/target/rx/cpu-qom.h
@@ -0,0 +1,52 @@
+/*
+ * QEMU RX CPU
+ *
+ * Copyright (c) 2019 Yoshinori Sato
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
+#ifndef QEMU_RX_CPU_QOM_H
+#define QEMU_RX_CPU_QOM_H
+
+#include "qom/cpu.h"
+
+#define TYPE_RXCPU "rxcpu"
+
+#define RXCPU_CLASS(klass)                                     \
+    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RXCPU)
+#define RXCPU(obj) \
+    OBJECT_CHECK(RXCPU, (obj), TYPE_RXCPU)
+#define RXCPU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RXCPU)
+
+/*
+ * RXCPUClass:
+ * @parent_realize: The parent class' realize handler.
+ * @parent_reset: The parent class' reset handler.
+ *
+ * A RX CPU model.
+ */
+typedef struct RXCPUClass {
+    /*< private >*/
+    CPUClass parent_class;
+    /*< public >*/
+
+    DeviceRealize parent_realize;
+    void (*parent_reset)(CPUState *cpu);
+
+} RXCPUClass;
+
+typedef struct RXCPU RXCPU;
+
+#endif
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
new file mode 100644
index 0000000000..2140cd4936
--- /dev/null
+++ b/target/rx/cpu.h
@@ -0,0 +1,197 @@
+/*
+ *  RX emulation definition
+ *
+ *  Copyright (c) 2019 Yoshinori Sato
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
+#ifndef RX_CPU_H
+#define RX_CPU_H
+
+#include "qemu/bitops.h"
+#include "qemu-common.h"
+#include "hw/registerfields.h"
+#include "cpu-qom.h"
+
+#define TARGET_LONG_BITS 32
+#define TARGET_PAGE_BITS 12
+
+#define CPUArchState struct CPURXState
+
+#include "exec/cpu-defs.h"
+
+#define TARGET_PHYS_ADDR_SPACE_BITS 32
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
+
+/* PSW define */
+REG32(PSW, 0)
+FIELD(PSW, C, 0, 1)
+FIELD(PSW, Z, 1, 1)
+FIELD(PSW, S, 2, 1)
+FIELD(PSW, O, 3, 1)
+FIELD(PSW, I, 16, 1)
+FIELD(PSW, U, 17, 1)
+FIELD(PSW, PM, 20, 1)
+FIELD(PSW, IPL, 24, 4)
+
+/* FPSW define */
+REG32(FPSW, 0)
+FIELD(FPSW, RM, 0, 2)
+FIELD(FPSW, CV, 2, 1)
+FIELD(FPSW, CO, 3, 1)
+FIELD(FPSW, CZ, 4, 1)
+FIELD(FPSW, CU, 5, 1)
+FIELD(FPSW, CX, 6, 1)
+FIELD(FPSW, CE, 7, 1)
+FIELD(FPSW, CAUSE, 2, 6)
+FIELD(FPSW, DN, 8, 1)
+FIELD(FPSW, EV, 10, 1)
+FIELD(FPSW, EO, 11, 1)
+FIELD(FPSW, EZ, 12, 1)
+FIELD(FPSW, EU, 13, 1)
+FIELD(FPSW, EX, 14, 1)
+FIELD(FPSW, ENABLE, 10, 5)
+FIELD(FPSW, FV, 26, 1)
+FIELD(FPSW, FO, 27, 1)
+FIELD(FPSW, FZ, 28, 1)
+FIELD(FPSW, FU, 29, 1)
+FIELD(FPSW, FX, 30, 1)
+FIELD(FPSW, FLAGS, 26, 4)
+FIELD(FPSW, FS, 31, 1)
+
+#define NB_MMU_MODES 1
+#define MMU_MODE0_SUFFIX _all
+
+typedef struct CPURXState {
+    /* CPU registers */
+    uint32_t regs[16];          /* general registers */
+    uint32_t psw_o;             /* O bit of status register */
+    uint32_t psw_s;             /* S bit of status register */
+    uint32_t psw_z;             /* Z bit of status register */
+    uint32_t psw_c;             /* C bit of status register */
+    uint32_t psw_u;
+    uint32_t psw_i;
+    uint32_t psw_pm;
+    uint32_t psw_ipl;
+    uint32_t bpsw;              /* backup status */
+    uint32_t bpc;               /* backup pc */
+    uint32_t isp;               /* global base register */
+    uint32_t usp;               /* vector base register */
+    uint32_t pc;                /* program counter */
+    uint32_t intb;              /* interrupt vector */
+    uint32_t fintv;
+    uint32_t fpsw;
+    uint64_t acc;
+
+    /* Internal use */
+    uint32_t in_sleep;
+    uint32_t req_irq;           /* Requested interrupt no (hard) */
+    uint32_t req_ipl;           /* Requested interrupt level */
+    uint32_t ack_irq;           /* execute irq */
+    uint32_t ack_ipl;           /* execute ipl */
+    float_status fp_status;
+
+    /* Fields up to this point are cleared by a CPU reset */
+    struct {} end_reset_fields;
+
+    CPU_COMMON
+
+    void *ack;
+} CPURXState;
+
+/*
+ * RXCPU:
+ * @env: #CPURXState
+ *
+ * A RX CPU
+ */
+struct RXCPU {
+    /*< private >*/
+    CPUState parent_obj;
+    /*< public >*/
+
+    CPURXState env;
+};
+
+static inline RXCPU *rx_env_get_cpu(CPURXState *env)
+{
+    return container_of(env, RXCPU, env);
+}
+
+#define ENV_GET_CPU(e) CPU(rx_env_get_cpu(e))
+
+#define ENV_OFFSET offsetof(RXCPU, env)
+
+#define RX_CPU_TYPE_SUFFIX "-" TYPE_RXCPU
+#define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_RXCPU
+
+extern const char rx_crname[][6];
+
+void rx_cpu_do_interrupt(CPUState *cpu);
+bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
+void rx_cpu_dump_state(CPUState *cpu, FILE *f,
+                           fprintf_function cpu_fprintf, int flags);
+int rx_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+
+void rx_translate_init(void);
+int cpu_rx_signal_handler(int host_signum, void *pinfo,
+                           void *puc);
+
+void rx_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void rx_load_image(RXCPU *cpu, const char *filename,
+                   uint32_t start, uint32_t size);
+void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
+
+#define cpu_signal_handler cpu_rx_signal_handler
+#define cpu_list rx_cpu_list
+
+#include "exec/cpu-all.h"
+
+#define CPU_INTERRUPT_SOFT CPU_INTERRUPT_TGT_INT_0
+#define CPU_INTERRUPT_FIR  CPU_INTERRUPT_TGT_INT_1
+
+#define RX_CPU_IRQ 0
+#define RX_CPU_FIR 1
+
+static inline void cpu_get_tb_cpu_state(CPURXState *env, target_ulong *pc,
+                                        target_ulong *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = FIELD_DP32(*flags, PSW, PM, env->psw_pm);
+}
+
+static inline int cpu_mmu_index(CPURXState *env, bool ifetch)
+{
+    return 0;
+}
+
+static inline uint32_t rx_cpu_pack_psw(CPURXState *env)
+{
+    uint32_t psw = 0;
+    psw = FIELD_DP32(psw, PSW, IPL, env->psw_ipl);
+    psw = FIELD_DP32(psw, PSW, PM,  env->psw_pm);
+    psw = FIELD_DP32(psw, PSW, U,   env->psw_u);
+    psw = FIELD_DP32(psw, PSW, I,   env->psw_i);
+    psw = FIELD_DP32(psw, PSW, O,   env->psw_o >> 31);
+    psw = FIELD_DP32(psw, PSW, S,   env->psw_s >> 31);
+    psw = FIELD_DP32(psw, PSW, Z,   env->psw_z == 0);
+    psw = FIELD_DP32(psw, PSW, C,   env->psw_c);
+    return psw;
+}
+
+#endif /* RX_CPU_H */
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
new file mode 100644
index 0000000000..66b28322fb
--- /dev/null
+++ b/target/rx/cpu.c
@@ -0,0 +1,232 @@
+/*
+ * QEMU RX CPU
+ *
+ * Copyright (c) 2019 Yoshinori Sato
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
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu-common.h"
+#include "migration/vmstate.h"
+#include "exec/exec-all.h"
+#include "hw/loader.h"
+#include "fpu/softfloat.h"
+
+static void rx_cpu_set_pc(CPUState *cs, vaddr value)
+{
+    RXCPU *cpu = RXCPU(cs);
+
+    cpu->env.pc = value;
+}
+
+static void rx_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    RXCPU *cpu = RXCPU(cs);
+
+    cpu->env.pc = tb->pc;
+}
+
+static bool rx_cpu_has_work(CPUState *cs)
+{
+    return cs->interrupt_request &
+        (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
+}
+
+static void rx_cpu_reset(CPUState *s)
+{
+    RXCPU *cpu = RXCPU(s);
+    RXCPUClass *rcc = RXCPU_GET_CLASS(cpu);
+    CPURXState *env = &cpu->env;
+    uint32_t *resetvec;
+
+    rcc->parent_reset(s);
+
+    memset(env, 0, offsetof(CPURXState, end_reset_fields));
+
+    resetvec = rom_ptr(0xfffffffc, 4);
+    if (resetvec) {
+        /* In the case of kernel, it is ignored because it is not set. */
+        env->pc = ldl_p(resetvec);
+    }
+    rx_cpu_unpack_psw(env, 0, 1);
+    env->regs[0] = env->isp = env->usp = 0;
+    env->fpsw = 0;
+    set_flush_to_zero(1, &env->fp_status);
+    set_flush_inputs_to_zero(1, &env->fp_status);
+}
+
+typedef struct RXCPUListState {
+    fprintf_function cpu_fprintf;
+    FILE *file;
+} RXCPUListState;
+
+static void rx_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    RXCPUListState *s = user_data;
+    const char *typename = object_class_get_name(OBJECT_CLASS(data));
+    int len = strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
+
+    (*s->cpu_fprintf)(s->file, "%.*s\n", len, typename);
+}
+
+void rx_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+{
+    RXCPUListState s = {
+        .cpu_fprintf = cpu_fprintf,
+        .file = f,
+    };
+    GSList *list;
+
+    list = object_class_get_list_sorted(TYPE_RXCPU, false);
+    g_slist_foreach(list, rx_cpu_list_entry, &s);
+    g_slist_free(list);
+}
+
+static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
+{
+    ObjectClass *oc;
+    char *typename = NULL;
+
+    typename = g_strdup_printf(RX_CPU_TYPE_NAME(""));
+    oc = object_class_by_name(typename);
+    if (oc != NULL && object_class_is_abstract(oc)) {
+        oc = NULL;
+    }
+
+    g_free(typename);
+    return oc;
+}
+
+static void rx_cpu_realize(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    RXCPUClass *rcc = RXCPU_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    cpu_reset(cs);
+    qemu_init_vcpu(cs);
+
+    rcc->parent_realize(dev, errp);
+}
+
+static void rx_cpu_set_irq(void *opaque, int no, int request)
+{
+    RXCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    int irq = request & 0xff;
+
+    static const int mask[] = {
+        [RX_CPU_IRQ] = CPU_INTERRUPT_HARD,
+        [RX_CPU_FIR] = CPU_INTERRUPT_FIR,
+    };
+    if (irq) {
+        cpu->env.req_irq = irq;
+        cpu->env.req_ipl = (request >> 8) & 0x0f;
+        cpu_interrupt(cs, mask[no]);
+    } else {
+        cpu_reset_interrupt(cs, mask[no]);
+    }
+}
+
+static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+{
+    info->mach = bfd_mach_rx;
+    info->print_insn = print_insn_rx;
+}
+
+static void rx_cpu_init(Object *obj)
+{
+    CPUState *cs = CPU(obj);
+    RXCPU *cpu = RXCPU(obj);
+    CPURXState *env = &cpu->env;
+
+    cs->env_ptr = env;
+    qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
+}
+
+static void rxcpu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    CPUClass *cc = CPU_CLASS(klass);
+    RXCPUClass *rcc = RXCPU_CLASS(klass);
+
+    device_class_set_parent_realize(dc, rx_cpu_realize,
+                                    &rcc->parent_realize);
+
+    rcc->parent_reset = cc->reset;
+    cc->reset = rx_cpu_reset;
+
+    cc->class_by_name = rx_cpu_class_by_name;
+    cc->has_work = rx_cpu_has_work;
+    cc->do_interrupt = rx_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = rx_cpu_exec_interrupt;
+    cc->dump_state = rx_cpu_dump_state;
+    cc->set_pc = rx_cpu_set_pc;
+    cc->synchronize_from_tb = rx_cpu_synchronize_from_tb;
+    cc->gdb_read_register = rx_cpu_gdb_read_register;
+    cc->gdb_write_register = rx_cpu_gdb_write_register;
+    cc->get_phys_page_debug = rx_cpu_get_phys_page_debug;
+    cc->disas_set_info = rx_cpu_disas_set_info;
+    cc->tcg_initialize = rx_translate_init;
+
+    cc->gdb_num_core_regs = 26;
+}
+
+static const TypeInfo rxcpu_info = {
+    .name = TYPE_RXCPU,
+    .parent = TYPE_CPU,
+    .instance_size = sizeof(RXCPU),
+    .instance_init = rx_cpu_init,
+    .abstract = false,
+    .class_size = sizeof(RXCPUClass),
+    .class_init = rxcpu_class_init,
+};
+
+static void rxcpu_register_types(void)
+{
+    type_register_static(&rxcpu_info);
+}
+
+type_init(rxcpu_register_types)
+
+static uint32_t extable[32];
+
+void rx_load_image(RXCPU *cpu, const char *filename,
+                   uint32_t start, uint32_t size)
+{
+    long kernel_size;
+    int i;
+
+    kernel_size = load_image_targphys(filename, start, size);
+    if (kernel_size < 0) {
+        fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
+        exit(1);
+    }
+    cpu->env.pc = start;
+
+    /* setup exception trap trampoline */
+    /* linux kernel only works little-endian mode */
+    for (i = 0; i < 32; i++) {
+        extable[i] = cpu_to_le32(0x10 + i * 4);
+    }
+    rom_add_blob_fixed("extable", extable, sizeof(extable), 0xffffff80);
+}
-- 
2.11.0


