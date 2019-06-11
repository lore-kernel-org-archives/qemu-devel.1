Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5629C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B2020673
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B2020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haftl-0004mW-99
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hafAf-0007N4-S8
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1haf6H-000068-Dp
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1haf6H-0008Hy-2S
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:38:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EAF51307D871;
 Tue, 11 Jun 2019 11:37:51 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D64C360BF1;
 Tue, 11 Jun 2019 11:37:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>
Date: Tue, 11 Jun 2019 13:37:13 +0200
Message-Id: <20190611113731.16940-4-philmd@redhat.com>
In-Reply-To: <20190611113731.16940-1-philmd@redhat.com>
References: <20190611113731.16940-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 11 Jun 2019 11:37:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v19 03/21] target/rx: CPU definition
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190607091116.49044-4-ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMD: Use newer QOM style, split cpu-qom.h, restrict access to
 extable array, use rx_cpu_tlb_fill() extracted from patch of
 Yoshinori Sato 'Convert to CPUClass::tlb_fill']
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/rx/cpu-qom.h |  42 ++++++++
 target/rx/cpu.c     | 252 ++++++++++++++++++++++++++++++++++++++++++++
 target/rx/cpu.h     | 201 +++++++++++++++++++++++++++++++++++
 target/rx/gdbstub.c | 112 ++++++++++++++++++++
 target/rx/monitor.c |  38 +++++++
 5 files changed, 645 insertions(+)
 create mode 100644 target/rx/cpu-qom.h
 create mode 100644 target/rx/cpu.c
 create mode 100644 target/rx/cpu.h
 create mode 100644 target/rx/gdbstub.c
 create mode 100644 target/rx/monitor.c

diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
new file mode 100644
index 0000000000..4ae3b38b3e
--- /dev/null
+++ b/target/rx/cpu-qom.h
@@ -0,0 +1,42 @@
+#ifndef QEMU_SUPERH_CPU_QOM_H
+#define QEMU_SUPERH_CPU_QOM_H
+
+#include "qom/cpu.h"
+/*
+ * RX CPU
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ * SPDX-License-Identifier: LGPL-2.0+
+ */
+
+#define TYPE_RX_CPU "rx-cpu"
+
+#define TYPE_RX62N_CPU RX_CPU_TYPE_NAME("rx62n")
+
+#define RXCPU_CLASS(klass) \
+    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)
+#define RXCPU(obj) \
+    OBJECT_CHECK(RXCPU, (obj), TYPE_RX_CPU)
+#define RXCPU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RX_CPU)
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
+#define CPUArchState struct CPURXState
+
+#endif
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
new file mode 100644
index 0000000000..4147c5c939
--- /dev/null
+++ b/target/rx/cpu.c
@@ -0,0 +1,252 @@
+/*
+ * QEMU RX CPU
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/qemu-print.h"
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
+    RXCPU *cpu =3D RXCPU(cs);
+
+    cpu->env.pc =3D value;
+}
+
+static void rx_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *t=
b)
+{
+    RXCPU *cpu =3D RXCPU(cs);
+
+    cpu->env.pc =3D tb->pc;
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
+    RXCPU *cpu =3D RXCPU(s);
+    RXCPUClass *rcc =3D RXCPU_GET_CLASS(cpu);
+    CPURXState *env =3D &cpu->env;
+    uint32_t *resetvec;
+
+    rcc->parent_reset(s);
+
+    memset(env, 0, offsetof(CPURXState, end_reset_fields));
+
+    resetvec =3D rom_ptr(0xfffffffc, 4);
+    if (resetvec) {
+        /* In the case of kernel, it is ignored because it is not set. *=
/
+        env->pc =3D ldl_p(resetvec);
+    }
+    rx_cpu_unpack_psw(env, 0, 1);
+    env->regs[0] =3D env->isp =3D env->usp =3D 0;
+    env->fpsw =3D 0;
+    set_flush_to_zero(1, &env->fp_status);
+    set_flush_inputs_to_zero(1, &env->fp_status);
+}
+
+static void rx_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    const char *typename =3D object_class_get_name(OBJECT_CLASS(data));
+    int len =3D strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
+
+    qemu_printf("%.*s\n", len, typename);
+}
+
+void rx_cpu_list(void)
+{
+    GSList *list;
+    list =3D object_class_get_list_sorted(TYPE_RX_CPU, false);
+    g_slist_foreach(list, rx_cpu_list_entry, NULL);
+    g_slist_free(list);
+}
+
+static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
+{
+    ObjectClass *oc;
+    char *typename;
+
+    oc =3D object_class_by_name(cpu_model);
+    if (oc !=3D NULL && object_class_dynamic_cast(oc, TYPE_RX_CPU) !=3D =
NULL &&
+        !object_class_is_abstract(oc)) {
+        return oc;
+    }
+
+    typename =3D g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
+    oc =3D object_class_by_name(typename);
+    if (oc !=3D NULL && object_class_is_abstract(oc)) {
+        oc =3D NULL;
+    }
+    g_free(typename);
+
+    if (!oc) {
+        /* default to rx62n */
+        oc =3D object_class_by_name(TYPE_RX62N_CPU);
+    }
+
+    return oc;
+}
+
+static void rx_cpu_realize(DeviceState *dev, Error **errp)
+{
+    CPUState *cs =3D CPU(dev);
+    RXCPUClass *rcc =3D RXCPU_GET_CLASS(dev);
+    Error *local_err =3D NULL;
+
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err !=3D NULL) {
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
+    RXCPU *cpu =3D opaque;
+    CPUState *cs =3D CPU(cpu);
+    int irq =3D request & 0xff;
+
+    static const int mask[] =3D {
+        [RX_CPU_IRQ] =3D CPU_INTERRUPT_HARD,
+        [RX_CPU_FIR] =3D CPU_INTERRUPT_FIR,
+    };
+    if (irq) {
+        cpu->env.req_irq =3D irq;
+        cpu->env.req_ipl =3D (request >> 8) & 0x0f;
+        cpu_interrupt(cs, mask[no]);
+    } else {
+        cpu_reset_interrupt(cs, mask[no]);
+    }
+}
+
+static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+{
+    info->mach =3D bfd_mach_rx;
+    info->print_insn =3D print_insn_rx;
+}
+
+static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                            MMUAccessType access_type, int mmu_idx,
+                            bool probe, uintptr_t retaddr)
+{
+    uint32_t address, physical, prot;
+
+    /* Linear mapping */
+    address =3D physical =3D addr & TARGET_PAGE_MASK;
+    prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE)=
;
+    return true;
+}
+
+static void rx_cpu_init(Object *obj)
+{
+    CPUState *cs =3D CPU(obj);
+    RXCPU *cpu =3D RXCPU(obj);
+    CPURXState *env =3D &cpu->env;
+
+    cs->env_ptr =3D env;
+    qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
+}
+
+static void rx_cpu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    CPUClass *cc =3D CPU_CLASS(klass);
+    RXCPUClass *rcc =3D RXCPU_CLASS(klass);
+
+    device_class_set_parent_realize(dc, rx_cpu_realize,
+                                    &rcc->parent_realize);
+
+    rcc->parent_reset =3D cc->reset;
+    cc->reset =3D rx_cpu_reset;
+
+    cc->class_by_name =3D rx_cpu_class_by_name;
+    cc->has_work =3D rx_cpu_has_work;
+    cc->do_interrupt =3D rx_cpu_do_interrupt;
+    cc->cpu_exec_interrupt =3D rx_cpu_exec_interrupt;
+    cc->dump_state =3D rx_cpu_dump_state;
+    cc->set_pc =3D rx_cpu_set_pc;
+    cc->synchronize_from_tb =3D rx_cpu_synchronize_from_tb;
+    cc->gdb_read_register =3D rx_cpu_gdb_read_register;
+    cc->gdb_write_register =3D rx_cpu_gdb_write_register;
+    cc->get_phys_page_debug =3D rx_cpu_get_phys_page_debug;
+    cc->disas_set_info =3D rx_cpu_disas_set_info;
+    cc->tcg_initialize =3D rx_translate_init;
+    cc->tlb_fill =3D rx_cpu_tlb_fill;
+
+    cc->gdb_num_core_regs =3D 26;
+}
+
+static const TypeInfo rx_cpu_info =3D {
+    .name =3D TYPE_RX_CPU,
+    .parent =3D TYPE_CPU,
+    .instance_size =3D sizeof(RXCPU),
+    .instance_init =3D rx_cpu_init,
+    .abstract =3D true,
+    .class_size =3D sizeof(RXCPUClass),
+    .class_init =3D rx_cpu_class_init,
+};
+
+static const TypeInfo rx62n_rx_cpu_info =3D {
+    .name =3D TYPE_RX62N_CPU,
+    .parent =3D TYPE_RX_CPU,
+};
+
+static void rx_cpu_register_types(void)
+{
+    type_register_static(&rx_cpu_info);
+    type_register_static(&rx62n_rx_cpu_info);
+}
+
+type_init(rx_cpu_register_types)
+
+void rx_load_image(RXCPU *cpu, const char *filename,
+                   uint32_t start, uint32_t size)
+{
+    static uint32_t extable[32];
+    long kernel_size;
+    int i;
+
+    kernel_size =3D load_image_targphys(filename, start, size);
+    if (kernel_size < 0) {
+        fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
+        exit(1);
+    }
+    cpu->env.pc =3D start;
+
+    /* setup exception trap trampoline */
+    /* linux kernel only works little-endian mode */
+    for (i =3D 0; i < ARRAY_SIZE(extable); i++) {
+        extable[i] =3D cpu_to_le32(0x10 + i * 4);
+    }
+    rom_add_blob_fixed("extable", extable, sizeof(extable), 0xffffff80);
+}
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
new file mode 100644
index 0000000000..3e5f371f51
--- /dev/null
+++ b/target/rx/cpu.h
@@ -0,0 +1,201 @@
+/*
+ *  RX emulation definition
+ *
+ *  Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
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
+#include "qom/cpu.h"
+
+#define TARGET_LONG_BITS 32
+#define TARGET_PAGE_BITS 12
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
+enum {
+    NUM_REGS =3D 16,
+};
+
+typedef struct CPURXState {
+    /* CPU registers */
+    uint32_t regs[NUM_REGS];    /* general registers */
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
+    /* Fields up to this point are cleared by a CPU reset */
+    struct {} end_reset_fields;
+
+    /* Internal use */
+    uint32_t in_sleep;
+    uint32_t req_irq;           /* Requested interrupt no (hard) */
+    uint32_t req_ipl;           /* Requested interrupt level */
+    uint32_t ack_irq;           /* execute irq */
+    uint32_t ack_ipl;           /* execute ipl */
+    float_status fp_status;
+    qemu_irq ack;               /* Interrupt acknowledge */
+
+    CPU_COMMON
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
+typedef struct RXCPU RXCPU;
+typedef RXCPU ArchCPU;
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
+#define RX_CPU_TYPE_SUFFIX "-" TYPE_RX_CPU
+#define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_RX_CPU
+
+extern const char rx_crname[][6];
+
+void rx_cpu_do_interrupt(CPUState *cpu);
+bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
+void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+int rx_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+
+void rx_translate_init(void);
+int cpu_rx_signal_handler(int host_signum, void *pinfo,
+                           void *puc);
+
+void rx_cpu_list(void);
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
+static inline void cpu_get_tb_cpu_state(CPURXState *env, target_ulong *p=
c,
+                                        target_ulong *cs_base, uint32_t =
*flags)
+{
+    *pc =3D env->pc;
+    *cs_base =3D 0;
+    *flags =3D FIELD_DP32(0, PSW, PM, env->psw_pm);
+}
+
+static inline int cpu_mmu_index(CPURXState *env, bool ifetch)
+{
+    return 0;
+}
+
+static inline uint32_t rx_cpu_pack_psw(CPURXState *env)
+{
+    uint32_t psw =3D 0;
+    psw =3D FIELD_DP32(psw, PSW, IPL, env->psw_ipl);
+    psw =3D FIELD_DP32(psw, PSW, PM,  env->psw_pm);
+    psw =3D FIELD_DP32(psw, PSW, U,   env->psw_u);
+    psw =3D FIELD_DP32(psw, PSW, I,   env->psw_i);
+    psw =3D FIELD_DP32(psw, PSW, O,   env->psw_o >> 31);
+    psw =3D FIELD_DP32(psw, PSW, S,   env->psw_s >> 31);
+    psw =3D FIELD_DP32(psw, PSW, Z,   env->psw_z =3D=3D 0);
+    psw =3D FIELD_DP32(psw, PSW, C,   env->psw_c);
+    return psw;
+}
+
+#endif /* RX_CPU_H */
diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
new file mode 100644
index 0000000000..d76ca52e82
--- /dev/null
+++ b/target/rx/gdbstub.c
@@ -0,0 +1,112 @@
+/*
+ * RX gdb server stub
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "exec/gdbstub.h"
+
+int rx_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    RXCPU *cpu =3D RXCPU(cs);
+    CPURXState *env =3D &cpu->env;
+
+    switch (n) {
+    case 0 ... 15:
+        return gdb_get_regl(mem_buf, env->regs[n]);
+    case 16:
+        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->=
usp);
+    case 17:
+        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env-=
>isp);
+    case 18:
+        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
+    case 19:
+        return gdb_get_regl(mem_buf, env->pc);
+    case 20:
+        return gdb_get_regl(mem_buf, env->intb);
+    case 21:
+        return gdb_get_regl(mem_buf, env->bpsw);
+    case 22:
+        return gdb_get_regl(mem_buf, env->bpc);
+    case 23:
+        return gdb_get_regl(mem_buf, env->fintv);
+    case 24:
+        return gdb_get_regl(mem_buf, env->fpsw);
+    case 25:
+        return 0;
+    }
+    return 0;
+}
+
+int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    RXCPU *cpu =3D RXCPU(cs);
+    CPURXState *env =3D &cpu->env;
+    uint32_t psw;
+    switch (n) {
+    case 0 ... 15:
+        env->regs[n] =3D ldl_p(mem_buf);
+        if (n =3D=3D 0) {
+            if (env->psw_u) {
+                env->usp =3D env->regs[0];
+            } else {
+                env->isp =3D env->regs[0];
+            }
+        }
+        break;
+    case 16:
+        env->usp =3D ldl_p(mem_buf);
+        if (env->psw_u) {
+            env->regs[0] =3D ldl_p(mem_buf);
+        }
+        break;
+    case 17:
+        env->isp =3D ldl_p(mem_buf);
+        if (!env->psw_u) {
+            env->regs[0] =3D ldl_p(mem_buf);
+        }
+        break;
+    case 18:
+        psw =3D ldl_p(mem_buf);
+        rx_cpu_unpack_psw(env, psw, 1);
+        break;
+    case 19:
+        env->pc =3D ldl_p(mem_buf);
+        break;
+    case 20:
+        env->intb =3D ldl_p(mem_buf);
+        break;
+    case 21:
+        env->bpsw =3D ldl_p(mem_buf);
+        break;
+    case 22:
+        env->bpc =3D ldl_p(mem_buf);
+        break;
+    case 23:
+        env->fintv =3D ldl_p(mem_buf);
+        break;
+    case 24:
+        env->fpsw =3D ldl_p(mem_buf);
+        break;
+    case 25:
+        return 8;
+    default:
+        return 0;
+    }
+
+    return 4;
+}
diff --git a/target/rx/monitor.c b/target/rx/monitor.c
new file mode 100644
index 0000000000..5d7a1e58b5
--- /dev/null
+++ b/target/rx/monitor.c
@@ -0,0 +1,38 @@
+/*
+ * QEMU monitor
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp-target.h"
+#include "hmp.h"
+
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+{
+    CPUArchState *env =3D mon_get_cpu_env();
+
+    if (!env) {
+        monitor_printf(mon, "No CPU available\n");
+        return;
+    }
+}
--=20
2.20.1


