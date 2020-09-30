Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B050C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488CA20759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dybGWJJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488CA20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNj79-0000YK-D4
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNizx-0003MR-QY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:50 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:42235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNizq-0006T7-Ba
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:48 -0400
Received: by mail-wr1-x42e.google.com with SMTP id c18so3238667wrm.9
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8YGgngscO3PjFSZdhet6MLQNOVQSYNDSmxEDgfyo58Y=;
 b=dybGWJJGgqV/C1rN6ufqzTFd2YND198bq+W2bAlS42c5MIvYV6Bq4B92pHRsRE55Mt
 +JngAcLqvxGXdQzRP5/YZuzXCwIsR9EVx1GWPadJnZQrcb4F6uJRojJBoEieoiADurl1
 7uDJydfbx8brZNi57XoenT25MdTi7R21C0mquOxKOTJwi6foCpw/Onn2udT8xQNFV75d
 K7IEdYrV2ahR2XBCUKWqdFYOkWbhdEi/TOANV64wA0hVMH72UHOvsnU/KFIV0tdayOPn
 kmT7w+BSCGXuqygVxJnHSocX7Etj5mW71dZDCLsjbC3L3jR7XmwaVdOrgvJATBAEMicw
 rmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8YGgngscO3PjFSZdhet6MLQNOVQSYNDSmxEDgfyo58Y=;
 b=k9003cXPaCyRH0A/OrVg+rucAs9K7EiLLIaZvdnLMO9nuZ04VxeZ6BnIGd5S+m12DC
 pVhCsqUISIGU8ZFZAPuPPyyyyQY2iZsNdu/WZx6rfqh7NNku7FZ6ink2RaprnN5ufFyI
 FS1d3lZTia8G1pxhNdWvSr74Sin/P/jOJeBeiaG2tiHEJrK06p7TfXchWxOVlvJi7sbD
 EX1gGQs56qod/vvDoh6JGA9tO/QG9NJs4xP/Tio1DDm5c+wzTc410xIHDy+tiN19Z5Fo
 pyt+CbNCEZUiVU2Bqpj+7yI3XcaRq8mQQlUrR3GpqL+Ea4uIMnyiWG/yRYFLjO7xIraQ
 DYhg==
X-Gm-Message-State: AOAM531Et4+qdx9Ln5Q5OdbAs0XfZWlcOFZ68/XIJ/uXjfry/5a9UGdA
 Q5cnES+Tvoir2H75po8hvu+7WfzGq7UJWg==
X-Google-Smtp-Source: ABdhPJyTudadwvWVNPLLiiaHU4ayORlBv+vHBIQELXGU8d552WVbxrWRPtE9EIw6VhlhoFX1cJHhpw==
X-Received: by 2002:adf:cf01:: with SMTP id o1mr5052651wrj.421.1601498798690; 
 Wed, 30 Sep 2020 13:46:38 -0700 (PDT)
Received: from cmiranda-laptop.localdomain ([188.251.240.167])
 by smtp.gmail.com with ESMTPSA id v204sm5310764wmg.20.2020.09.30.13.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 13:46:38 -0700 (PDT)
From: cupertinomiranda@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 04/14] arc: TCG and decoder glue code and helpers
Date: Wed, 30 Sep 2020 21:45:54 +0100
Message-Id: <20200930204604.20663-5-cupertinomiranda@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930204604.20663-1-cupertinomiranda@gmail.com>
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Cupertino Miranda <cupertinomiranda@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cupertino Miranda <cmiranda@synopsys.com>

Signed-off-by: Cupertino Miranda <cmiranda@synopsys.com>
---
 target/arc/extra_mapping.def   |  40 ++
 target/arc/helper.c            | 293 +++++++++++++
 target/arc/helper.h            |  46 ++
 target/arc/op_helper.c         | 749 +++++++++++++++++++++++++++++++++
 target/arc/semfunc_mapping.def | 329 +++++++++++++++
 5 files changed, 1457 insertions(+)
 create mode 100644 target/arc/extra_mapping.def
 create mode 100644 target/arc/helper.c
 create mode 100644 target/arc/helper.h
 create mode 100644 target/arc/op_helper.c
 create mode 100644 target/arc/semfunc_mapping.def

diff --git a/target/arc/extra_mapping.def b/target/arc/extra_mapping.def
new file mode 100644
index 0000000000..6bc36d8d46
--- /dev/null
+++ b/target/arc/extra_mapping.def
@@ -0,0 +1,40 @@
+/*
+ * QEMU ARC EXTRA MAPPING
+ *
+ * Copyright (c) 2020
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+SEMANTIC_FUNCTION(SWI, 1)
+SEMANTIC_FUNCTION(SWI, 1)
+SEMANTIC_FUNCTION(UNIMP, 0)
+SEMANTIC_FUNCTION(RTIE, 0)
+SEMANTIC_FUNCTION(SLEEP, 1)
+
+MAPPING(swi, SWI, 0)
+CONSTANT(SWI, swi_s, 0, 0)
+MAPPING(swi_s, SWI, 1, 0)
+MAPPING(trap_s, TRAP, 1, 0)
+MAPPING(rtie, RTIE, 0)
+MAPPING(sleep, SLEEP, 1, 0)
+MAPPING(vadd2, VADD, 3, 0, 1, 2)
+MAPPING(vadd2h, VADD, 3, 0, 1, 2)
+MAPPING(vadd4h, VADD, 3, 0, 1, 2)
+MAPPING(vsub2, VSUB, 3, 0, 1, 2)
+MAPPING(vsub2h, VSUB, 3, 0, 1, 2)
+MAPPING(vsub4h, VSUB, 3, 0, 1, 2)
+MAPPING(mpyd, MPYD, 3, 0, 1, 2)
+MAPPING(mpydu, MPYD, 3, 0, 1, 2)
diff --git a/target/arc/helper.c b/target/arc/helper.c
new file mode 100644
index 0000000000..cbc072e66b
--- /dev/null
+++ b/target/arc/helper.c
@@ -0,0 +1,293 @@
+/*
+ * QEMU ARC CPU
+ *
+ * Copyright (c) 2019
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "hw/irq.h"
+#include "include/hw/sysbus.h"
+#include "include/sysemu/sysemu.h"
+#include "qemu/qemu-print.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "qemu/host-utils.h"
+#include "exec/helper-proto.h"
+#include "irq.h"
+
+#if defined(CONFIG_USER_ONLY)
+
+void arc_cpu_do_interrupt(CPUState *cs)
+{
+    ARCCPU *cpu = ARC_CPU(cs);
+    CPUARCState *env = &cpu->env;
+
+    cs->exception_index = -1;
+    CPU_ILINK(env) = env->pc;
+}
+
+#else /* !CONFIG_USER_ONLY */
+
+void arc_cpu_do_interrupt(CPUState *cs)
+{
+    ARCCPU      *cpu    = ARC_CPU(cs);
+    CPUARCState *env    = &cpu->env;
+    uint32_t     offset = 0;
+    uint32_t     vectno;
+    const char  *name;
+
+    /*
+     * NOTE: Special LP_END exception. Immediatelly return code execution to
+     * lp_start.
+     * Now also used for delayslot MissI cases.
+     * This special exception should not execute any of the exception
+     * handling code. Instead it returns immediately after setting PC to the
+     * address passed as exception parameter.
+     */
+    if (cs->exception_index == EXCP_LPEND_REACHED
+        || cs->exception_index == EXCP_FAKE) {
+        env->pc = env->param;
+        CPU_PCL(env) = env->pc & 0xfffffffe;
+        return;
+    }
+
+    /* If we take an exception within an exception => fatal Machine Check. */
+    if (env->stat.AEf == 1) {
+        cs->exception_index = EXCP_MACHINE_CHECK;
+        env->causecode = 0;
+        env->param = 0;
+        env->mmu.enabled = false;     /* no more MMU */
+        env->mpu.enabled = false;     /* no more MPU */
+    }
+    vectno = cs->exception_index & 0x0F;
+    offset = vectno << 2;
+
+    /* Generic computation for exceptions. */
+    switch (cs->exception_index) {
+    case EXCP_RESET:
+        name = "Reset";
+        break;
+    case EXCP_MEMORY_ERROR:
+        name = "Memory Error";
+        break;
+    case EXCP_INST_ERROR:
+        name = "Instruction Error";
+        break;
+    case EXCP_MACHINE_CHECK:
+        name = "Machine Check";
+        break;
+    case EXCP_TLB_MISS_I:
+        name = "TLB Miss Instruction";
+        break;
+    case EXCP_TLB_MISS_D:
+        name = "TLB Miss Data";
+        break;
+    case EXCP_PROTV:
+        name = "Protection Violation";
+        break;
+    case EXCP_PRIVILEGEV:
+        name = "Privilege Violation";
+        break;
+    case EXCP_SWI:
+        name = "SWI";
+        break;
+    case EXCP_TRAP:
+        name = "Trap";
+        break;
+    case EXCP_EXTENSION:
+        name = "Extension";
+        break;
+    case EXCP_DIVZERO:
+        name = "DIV by Zero";
+        break;
+    case EXCP_DCERROR:
+        name = "DCError";
+        break;
+    case EXCP_MISALIGNED:
+        name = "Misaligned";
+        break;
+    case EXCP_IRQ:
+    default:
+        cpu_abort(cs, "unhandled exception/irq type=%d\n",
+                  cs->exception_index);
+        break;
+    }
+
+    qemu_log_mask(CPU_LOG_INT, "[EXCP] exception %d (%s) at pc=0x%08x\n",
+                  cs->exception_index, name, env->pc);
+
+    /*
+     * 3. exception status register is loaded with the contents
+     * of STATUS32.
+     */
+    env->stat_er = env->stat;
+
+    /* 4. exception return branch target address register. */
+    env->erbta = env->bta;
+
+    /*
+     * 5. eception cause register is loaded with a code to indicate
+     * the cause of the exception.
+     */
+    env->ecr = (vectno & 0xFF) << 16;
+    env->ecr |= (env->causecode & 0xFF) << 8;
+    env->ecr |= (env->param & 0xFF);
+
+    /* 6. Set the EFA if available. */
+    if (cpu->cfg.has_mmu || cpu->cfg.has_mpu) {
+        switch (cs->exception_index) {
+        case EXCP_DCERROR:
+        case EXCP_DIVZERO:
+        case EXCP_EXTENSION:
+        case EXCP_TRAP:
+        case EXCP_SWI:
+        case EXCP_PRIVILEGEV:
+        case EXCP_MACHINE_CHECK:
+        case EXCP_INST_ERROR:
+        case EXCP_RESET:
+            /* TODO: this should move to the place raising the exception */
+            env->efa  = env->pc;
+            break;
+        default:
+            break;
+        }
+    }
+
+    /* 7. CPU is switched to kernel mode. */
+    env->stat.Uf = 0;
+
+    if (env->stat_er.Uf) {
+        switchSP(env);
+    }
+
+    /* 8. Interrupts are disabled. */
+    env->stat.IEf = 0;
+
+    /* 9. The active exception flag is set. */
+    env->stat.AEf = 1;
+
+    /* 10-14. Other flags sets. */
+    env->stat.Zf  = env->stat_er.Uf;
+    env->stat.Lf  = 1;
+    env->stat.DEf = 0;
+    env->stat.ESf = 0;
+    env->stat.DZf = 0;
+    env->stat.SCf = 0;
+
+    /* 15. The PC is set with the appropriate exception vector. */
+    env->pc = cpu_ldl_code(env, env->intvec + offset);
+    CPU_PCL(env) = env->pc & 0xfffffffe;
+
+    qemu_log_mask(CPU_LOG_INT, "[EXCP] isr=0x%x vec=0x%x ecr=0x%08x\n",
+                  env->pc, offset, env->ecr);
+
+    /* Make sure that exception code decodes corectly */
+    env->stat.is_delay_slot_instruction = 0;
+
+    cs->exception_index = -1;
+}
+
+#endif
+
+
+static gint arc_cpu_list_compare(gconstpointer a, gconstpointer b)
+{
+    ObjectClass *class_a = (ObjectClass *)a;
+    ObjectClass *class_b = (ObjectClass *)b;
+    const char *name_a;
+    const char *name_b;
+
+    name_a = object_class_get_name(class_a);
+    name_b = object_class_get_name(class_b);
+    if (strcmp(name_a, "any-" TYPE_ARC_CPU) == 0) {
+        return 1;
+    } else if (strcmp(name_b, "any-" TYPE_ARC_CPU) == 0) {
+        return -1;
+    } else {
+        return strcmp(name_a, name_b);
+    }
+}
+
+static void arc_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    const char *typename;
+    char *name;
+
+    typename = object_class_get_name(oc);
+    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_ARC_CPU));
+    qemu_printf("  %s\n", name);
+    g_free(name);
+}
+
+void arc_cpu_list(void)
+{
+    GSList *list;
+
+    list = object_class_get_list(TYPE_ARC_CPU, false);
+    list = g_slist_sort(list, arc_cpu_list_compare);
+    qemu_printf("Available CPUs:\n");
+    g_slist_foreach(list, arc_cpu_list_entry, NULL);
+    g_slist_free(list);
+}
+
+int arc_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
+                            int len, bool is_write)
+{
+    return cpu_memory_rw_debug(cs, addr, buf, len, is_write);
+}
+
+hwaddr arc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+   ARCCPU *cpu = ARC_CPU(cs);
+   CPUARCState *env = &cpu->env;
+
+   return arc_mmu_translate(env, addr, MMU_MEM_IRRELEVANT_TYPE,
+                            NULL);
+}
+
+void helper_debug(CPUARCState *env)
+{
+   CPUState *cs = env_cpu(env);
+
+   cs->exception_index = EXCP_DEBUG;
+   cpu_loop_exit(cs);
+}
+
+/*
+ * raises a simple exception with causecode and parameter set to 0.
+ * it also considers "pc" as the exception return address. this is
+ * not true for a software trap.
+ * it is very important that "env->host_pc" holds the recent value,
+ * else the cpu_restore_state() will not be helpful and we end up
+ * with incorrect registers in env.
+ */
+void QEMU_NORETURN arc_raise_exception(CPUARCState *env, int32_t excp_idx)
+{
+    CPUState *cs = env_cpu(env);
+    cpu_restore_state(cs, env->host_pc, true);
+    cs->exception_index = excp_idx;
+    env->causecode = env->param = 0x0;
+    env->eret  = env->pc;
+    env->erbta = env->bta;
+    cpu_loop_exit(cs);
+}
+
+
+/* vim: set ts=4 sw=4 et: */
diff --git a/target/arc/helper.h b/target/arc/helper.h
new file mode 100644
index 0000000000..6277005e2d
--- /dev/null
+++ b/target/arc/helper.h
@@ -0,0 +1,46 @@
+/*
+ * QEMU ARC CPU
+ *
+ * Copyright (c) 2019
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * href="http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+DEF_HELPER_1(debug, void, env)
+DEF_HELPER_2(norm, i32, env, i32)
+DEF_HELPER_2(normh, i32, env, i32)
+DEF_HELPER_2(ffs, i32, env, i32)
+DEF_HELPER_2(fls, i32, env, i32)
+DEF_HELPER_2(lr, tl, env, i32)
+DEF_HELPER_3(sr, void, env, i32, i32)
+DEF_HELPER_2(halt, noreturn, env, i32)
+DEF_HELPER_1(rtie, void, env)
+DEF_HELPER_1(flush, void, env)
+DEF_HELPER_4(raise_exception, noreturn, env, i32, i32, i32)
+DEF_HELPER_2(zol_verify, void, env, i32)
+DEF_HELPER_2(fake_exception, void, env, i32)
+DEF_HELPER_2(set_status32, void, env, i32)
+DEF_HELPER_1(get_status32, i32, env)
+DEF_HELPER_3(carry_add_flag, i32, i32, i32, i32)
+DEF_HELPER_3(overflow_add_flag, i32, i32, i32, i32)
+DEF_HELPER_3(overflow_sub_flag, i32, i32, i32, i32)
+
+DEF_HELPER_2(enter, void, env, i32)
+DEF_HELPER_2(leave, void, env, i32)
+
+DEF_HELPER_3(mpymu, i32, env, i32, i32)
+DEF_HELPER_3(mpym, i32, env, i32, i32)
+
+DEF_HELPER_3(repl_mask, i32, i32, i32, i32)
diff --git a/target/arc/op_helper.c b/target/arc/op_helper.c
new file mode 100644
index 0000000000..5e05f5f5ba
--- /dev/null
+++ b/target/arc/op_helper.c
@@ -0,0 +1,749 @@
+/*
+ * QEMU ARC CPU
+ *
+ * Copyright (c) 2018 Cupertino Miranda
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "cpu.h"
+#include "sysemu/runstate.h"
+#include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
+#include "exec/ioport.h"
+#include "translate-all.h"
+#include "target/arc/regs.h"
+#include "mmu.h"
+#include "hw/arc/cpudevs.h"
+#include "qemu/main-loop.h"
+#include "irq.h"
+#include "sysemu/sysemu.h"
+
+
+static target_ulong get_status32(CPUARCState *env)
+{
+    target_ulong value = pack_status32(&env->stat);
+
+    /* TODO: Implement debug mode */
+    if (env->stat.Uf == 1) {
+        value &= 0x00000f00;
+    }
+
+    if (env->stopped) {
+        value |= BIT(0);
+    }
+
+    return value;
+}
+
+static void set_status32(CPUARCState *env, target_ulong value)
+{
+    /* TODO: Implement debug mode. */
+    bool debug_mode = false;
+    if (env->stat.Uf == 1) {
+        value &= 0x00000f00;
+    } else if (!debug_mode) {
+        value &= 0xffff6f3f;
+    }
+
+    if (((env->stat.Uf >> 7)  & 0x1) != ((value >> 7)  & 0x1)) {
+        tlb_flush(env_cpu(env));
+    }
+
+    unpack_status32(&env->stat, value);
+
+    /* Implement HALT functionality.  */
+    if (value & 0x01) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }
+}
+
+static void do_exception_no_delayslot(CPUARCState *env, uint32_t index,
+                                      uint32_t causecode, uint32_t param)
+{
+    CPUState *cs = env_cpu(env);
+    cpu_restore_state(cs, GETPC(), true);
+    env->eret = env->pc;
+    env->erbta = env->bta;
+
+    helper_raise_exception(env, index, causecode, param);
+}
+
+target_ulong helper_norm(CPUARCState *env, uint32_t src1)
+{
+    int i;
+    int32_t tmp = (int32_t) src1;
+    if (tmp == 0 || tmp == -1) {
+        return 0;
+    }
+    for (i = 0; i <= 31; i++) {
+        if ((tmp >> i) == 0) {
+            break;
+        }
+        if ((tmp >> i) == -1) {
+            break;
+        }
+    }
+    return i;
+}
+
+target_ulong helper_normh(CPUARCState *env, uint32_t src1)
+{
+    int i;
+    for (i = 0; i <= 15; i++) {
+        if (src1 >> i == 0) {
+            break;
+        }
+        if (src1 >> i == -1) {
+            break;
+        }
+    }
+    return i;
+}
+
+target_ulong helper_ffs(CPUARCState *env, uint32_t src)
+{
+    int i;
+    if (src == 0) {
+        return 31;
+    }
+    for (i = 0; i <= 31; i++) {
+        if (((src >> i) & 1) != 0) {
+            break;
+        }
+    }
+    return i;
+}
+
+target_ulong helper_fls(CPUARCState *env, uint32_t src)
+{
+    int i;
+    if (src == 0) {
+        return 0;
+    }
+
+    for (i = 31; i >= 0; i--) {
+        if (((src >> i) & 1) != 0) {
+            break;
+        }
+    }
+    return i;
+}
+
+static void report_aux_reg_error(uint32_t aux)
+{
+    if (((aux >= ARC_BCR1_START) && (aux <= ARC_BCR1_END)) ||
+        ((aux >= ARC_BCR2_START) && (aux <= ARC_BCR2_END))) {
+        qemu_log_mask(LOG_UNIMP, "Undefined BCR 0x%03x\n", aux);
+    }
+
+    error_report("Undefined AUX register 0x%03x, aborting", aux);
+    exit(EXIT_FAILURE);
+}
+
+void helper_sr(CPUARCState *env, uint32_t val, uint32_t aux)
+{
+    struct arc_aux_reg_detail *aux_reg_detail =
+        arc_aux_reg_struct_for_address(aux, ARC_OPCODE_ARCv2HS);
+
+    if (aux_reg_detail == NULL) {
+        report_aux_reg_error(aux);
+    }
+
+    /* saving return address in case an exception must be raised later */
+    env->host_pc = GETPC();
+
+    switch (aux_reg_detail->id) {
+    case AUX_ID_lp_start:
+        env->lps = val;
+        break;
+
+    case AUX_ID_lp_end:
+        env->lpe = val;
+        break;
+
+    case AUX_ID_status32:
+        set_status32(env, val);
+        break;
+
+    case AUX_ID_eret:
+        env->eret = val;
+        break;
+
+    case AUX_ID_erbta:
+        env->erbta = val;
+        break;
+
+    case AUX_ID_bta:
+        env->bta = val;
+        break;
+
+    case AUX_ID_erstatus:
+        unpack_status32(&env->stat_er, val);
+        break;
+
+    case AUX_ID_ecr:
+        env->ecr = val;
+        break;
+
+    case AUX_ID_efa:
+        env->efa = val;
+        break;
+
+    default:
+        if (aux_reg_detail->aux_reg->set_func != NULL) {
+            aux_reg_detail->aux_reg->set_func(aux_reg_detail, val,
+                                              (void *) env);
+        } else {
+            /* setting a register that does not provide one is not allowed */
+            arc_raise_exception(env, EXCP_INST_ERROR);
+            /* TODO: are lr and sr possible delayslot instructions ? */
+            /* TODO: what is this? can it be removed? */
+            do_exception_no_delayslot(env, EXCP_INST_ERROR, 0, 0);
+        }
+        break;
+    }
+    cpu_outl(aux, val);
+}
+
+static target_ulong get_debug(CPUARCState *env)
+{
+    target_ulong res = 0x00000000;
+
+    res |= (env->debug.LD) ? BIT(31) : 0;
+    res |= (env->debug.SH) ? BIT(30) : 0;
+    res |= (env->debug.BH) ? BIT(29) : 0;
+    res |= (env->debug.UB) ? BIT(28) : 0;
+    res |= (env->debug.ZZ) ? BIT(27) : 0;
+    res |= (env->debug.RA) ? BIT(22) : 0;
+    res |= (env->debug.IS) ? BIT(11) : 0;
+    res |= (env->debug.FH) ? BIT(1)  : 0;
+    res |= (env->debug.SS) ? BIT(0)  : 0;
+
+    return res;
+}
+
+static target_ulong get_identity(CPUARCState *env)
+{
+    target_ulong chipid = 0xffff, arcnum = 0, arcver, res;
+
+    switch (env->family) {
+    case ARC_OPCODE_ARC700:
+        arcver = 0x34;
+        break;
+
+    case ARC_OPCODE_ARCv2EM:
+        arcver = 0x44;
+        break;
+
+    case ARC_OPCODE_ARCv2HS:
+        arcver = 0x54;
+        break;
+
+    default:
+        arcver = 0;
+
+    }
+
+    /* TODO: in SMP, arcnum depends on the cpu instance. */
+    res = ((chipid & 0xFFFF) << 16) | ((arcnum & 0xFF) << 8) | (arcver & 0xFF);
+    return res;
+}
+
+target_ulong helper_lr(CPUARCState *env, uint32_t aux)
+{
+    target_ulong result = 0;
+
+    struct arc_aux_reg_detail *aux_reg_detail =
+        arc_aux_reg_struct_for_address(aux, ARC_OPCODE_ARCv2HS);
+
+    if (aux_reg_detail == NULL) {
+        report_aux_reg_error(aux);
+    }
+
+    /* saving return address in case an exception must be raised later */
+    env->host_pc = GETPC();
+
+    switch (aux_reg_detail->id) {
+    case AUX_ID_aux_volatile:
+        result = 0xc0000000;
+        break;
+
+    case AUX_ID_lp_start:
+        result = env->lps;
+        break;
+
+    case AUX_ID_lp_end:
+        result = env->lpe;
+        break;
+
+    case AUX_ID_identity:
+        result = get_identity(env);
+        break;
+
+    case AUX_ID_exec_ctrl:
+        result = 0;
+        break;
+
+    case AUX_ID_debug:
+        result = get_debug(env);
+        break;
+
+    case AUX_ID_pc:
+        result = env->pc & 0xfffffffe;
+        break;
+
+    case AUX_ID_status32:
+        result = get_status32(env);
+        break;
+
+    case AUX_ID_mpy_build:
+            result = env->mpy_build;
+            break;
+
+    case AUX_ID_isa_config:
+        result = env->isa_config;
+        break;
+
+    case AUX_ID_eret:
+        result = env->eret;
+        break;
+
+    case AUX_ID_erbta:
+        result = env->erbta;
+        break;
+
+    case AUX_ID_erstatus:
+        if (is_user_mode(env)) {
+            arc_raise_exception(env, EXCP_PRIVILEGEV);
+        }
+        result = pack_status32(&env->stat_er);
+        break;
+
+    case AUX_ID_ecr:
+        result = env->ecr;
+        break;
+
+    case AUX_ID_efa:
+        result = env->efa;
+        break;
+
+    case AUX_ID_bta:
+        result = env->bta;
+        break;
+
+    case AUX_ID_bta_l1:
+        result = env->bta_l1;
+        break;
+
+    case AUX_ID_bta_l2:
+        result = env->bta_l2;
+        break;
+
+    default:
+        if (aux_reg_detail->aux_reg->get_func != NULL) {
+            result = aux_reg_detail->aux_reg->get_func(aux_reg_detail,
+                                                       (void *) env);
+        } else {
+            /* TODO: is lr and sr possible delayslot instructions ? */
+            assert(0);
+            arc_raise_exception(env, EXCP_INST_ERROR);
+            do_exception_no_delayslot(env, EXCP_INST_ERROR, 0, 0);
+        }
+        break;
+    }
+
+    return result;
+}
+
+void QEMU_NORETURN helper_halt(CPUARCState *env, uint32_t npc)
+{
+    CPUState *cs = env_cpu(env);
+    if (env->stat.Uf) {
+        cs->exception_index = EXCP_PRIVILEGEV;
+        env->causecode = 0;
+        env->param = 0;
+         /* Restore PC such that we point at the faulty instruction.  */
+        env->eret = env->pc;
+    } else {
+        env->pc = npc;
+        cs->halted = 1;
+        cs->exception_index = EXCP_HLT;
+    }
+    cpu_loop_exit(cs);
+}
+
+void helper_rtie(CPUARCState *env)
+{
+    CPUState *cs = env_cpu(env);
+    if (env->stat.Uf) {
+        cs->exception_index = EXCP_PRIVILEGEV;
+        env->causecode = 0;
+        env->param = 0;
+         /* Restore PC such that we point at the faulty instruction.  */
+        env->eret = env->pc;
+        cpu_loop_exit(cs);
+        return;
+    }
+
+    if (env->stat.AEf || (env->aux_irq_act & 0xFFFF) == 0) {
+        assert(env->stat.Uf == 0);
+
+        CPU_PCL(env) = env->eret;
+        env->pc = env->eret;
+
+        env->stat = env->stat_er;
+        env->bta = env->erbta;
+
+        /* If returning to userland, restore SP.  */
+        if (env->stat.Uf) {
+            switchSP(env);
+        }
+
+        qemu_log_mask(CPU_LOG_INT, "[EXCP] RTIE @0x%08x ECR:0x%08x\n",
+                      env->r[63], env->ecr);
+    } else {
+        arc_rtie_interrupts(env);
+        qemu_log_mask(CPU_LOG_INT, "[IRQ] RTIE @0x%08x STATUS32:0x%08x\n",
+                      env->r[63], pack_status32(&env->stat));
+    }
+
+    helper_zol_verify(env, env->pc);
+}
+
+void helper_flush(CPUARCState *env)
+{
+    tb_flush((CPUState *)env_archcpu(env));
+}
+
+/*
+ * This should only be called from translate, via gen_raise_exception.
+ * We expect that ENV->PC has already been updated.
+ */
+
+void QEMU_NORETURN helper_raise_exception(CPUARCState *env,
+                                          uint32_t index,
+                                          uint32_t causecode,
+                                          uint32_t param)
+{
+    CPUState *cs = env_cpu(env);
+    /* Cannot restore state here. */
+    /* cpu_restore_state(cs, GETPC(), true); */
+    cs->exception_index = index;
+    env->causecode = causecode;
+    env->param = param;
+    cpu_loop_exit(cs);
+}
+
+void helper_zol_verify(CPUARCState *env, uint32_t npc)
+{
+    if (npc == env->lpe) {
+        if (env->r[60] > 1) {
+            env->r[60] -= 1;
+            helper_raise_exception(env, (uint32_t) EXCP_LPEND_REACHED, 0,
+                                   env->lps);
+        } else {
+            env->r[60] = 0;
+        }
+    }
+}
+void helper_fake_exception(CPUARCState *env, uint32_t pc)
+{
+    helper_raise_exception(env, (uint32_t) EXCP_FAKE, 0, pc);
+}
+
+uint32_t helper_get_status32(CPUARCState *env)
+{
+    return get_status32(env);
+}
+
+void helper_set_status32(CPUARCState *env, uint32_t value)
+{
+    set_status32(env, value);
+}
+
+uint32_t helper_carry_add_flag(uint32_t dest, uint32_t b, uint32_t c)
+{
+    uint32_t t1, t2, t3;
+
+    t1 = b & c;
+    t2 = b & (~dest);
+    t3 = c & (~dest);
+    t1 = t1 | t2 | t3;
+    return (t1 >> 31) & 1;
+}
+
+uint32_t helper_overflow_add_flag(uint32_t dest, uint32_t b, uint32_t c)
+{
+    dest >>= 31;
+    b >>= 31;
+    c >>= 31;
+    if ((dest == 0 && b == 1 && c == 1)
+        || (dest == 1 && b == 0 && c == 0)) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+uint32_t helper_overflow_sub_flag(uint32_t dest, uint32_t b, uint32_t c)
+{
+    dest >>= 31;
+    b >>= 31;
+    c >>= 31;
+    if ((dest == 1 && b == 0 && c == 1)
+        || (dest == 0 && b == 1 && c == 0)) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+uint32_t helper_repl_mask(uint32_t dest, uint32_t src, uint32_t mask)
+{
+    uint32_t ret = dest & (~mask);
+    ret |= (src & mask);
+
+    return ret;
+}
+
+uint32_t helper_mpymu(CPUARCState *env, uint32_t b, uint32_t c)
+{
+    uint64_t _b = (uint64_t) b;
+    uint64_t _c = (uint64_t) c;
+
+    return (uint32_t) ((_b * _c) >> 32);
+}
+
+uint32_t helper_mpym(CPUARCState *env, uint32_t b, uint32_t c)
+{
+    int64_t _b = (int64_t) ((int32_t) b);
+    int64_t _c = (int64_t) ((int32_t) c);
+
+    /*
+     * fprintf(stderr, "B = 0x%llx, C = 0x%llx, result = 0x%llx\n",
+     *         _b, _c, _b * _c);
+     */
+    return (_b * _c) >> 32;
+}
+
+
+/*
+ * throw "illegal instruction" exception if more than available
+ * registers are asked to be saved/restore.
+ */
+static void check_enter_leave_nr_regs(CPUARCState *env,
+                                      uint8_t      regs,
+                                      uintptr_t    host_pc)
+{
+    const uint8_t rgf_num_regs = env_archcpu(env)->cfg.rgf_num_regs;
+    if ((rgf_num_regs == 32 && regs > 14) ||
+        (rgf_num_regs == 16 && regs >  3)) {
+        CPUState *cs = env_cpu(env);
+        cpu_restore_state(cs, host_pc, true);
+        cs->exception_index = EXCP_INST_ERROR;
+        env->causecode      = 0x00;
+        env->param          = 0x00;
+        env->eret           = env->pc;
+        env->erbta          = env->bta;
+        cpu_loop_exit(cs);
+    }
+}
+
+/*
+ * throw "illegal instruction sequence" exception if we are in a
+ * delay/execution slot.
+ */
+static void check_delay_or_execution_slot(CPUARCState *env,
+                                          uintptr_t    host_pc)
+{
+    if (env->stat.DEf || env->stat.ESf) {
+        CPUState *cs = env_cpu(env);
+        cpu_restore_state(cs, host_pc, true);
+        cs->exception_index = EXCP_INST_ERROR;
+        env->causecode      = 0x01;
+        env->param          = 0x00;
+        env->eret           = env->pc;
+        env->erbta          = env->bta;
+        cpu_loop_exit(cs);
+    }
+}
+
+/*
+ * Throw "misaligned" exception if 'addr' is not 32-bit aligned.
+ * This check is done irrelevant of status32.AD bit.
+ */
+static void check_addr_is_word_aligned(CPUARCState *env,
+                                       target_ulong addr,
+                                       uintptr_t    host_pc)
+{
+    if (addr & 0x3) {
+        CPUState *cs = env_cpu(env);
+        cpu_restore_state(cs, host_pc, true);
+        cs->exception_index = EXCP_MISALIGNED;
+        env->causecode      = 0x00;
+        env->param          = 0x00;
+        env->efa            = addr;
+        env->eret           = env->pc;
+        env->erbta          = env->bta;
+        cpu_loop_exit(cs);
+    }
+}
+
+/*
+ * helper for enter_s instruction.
+ * after we are done, stack layout would be:
+ * ,- top -.
+ * | blink |
+ * | r13   |
+ * | r14   |
+ * | ...   |
+ * | r26   |
+ * | fp    |
+ * `-------'
+ */
+void helper_enter(CPUARCState *env, uint32_t u6)
+{
+    /* nothing to do? then bye-bye! */
+    if (!u6) {
+        return;
+    }
+
+    uint8_t regs       = u6 & 0x0f; /* u[3:0] determines registers to save */
+    bool    save_fp    = u6 & 0x10; /* u[4] indicates if fp must be saved  */
+    bool    save_blink = u6 & 0x20; /* u[5] indicates saving of blink      */
+    uint8_t stack_size = 4 * (regs + save_fp + save_blink);
+
+    /* number of regs to be saved must be sane */
+    check_enter_leave_nr_regs(env, regs, GETPC());
+
+    /* this cannot be executed in a delay/execution slot */
+    check_delay_or_execution_slot(env, GETPC());
+
+    /* stack must be a multiple of 4 (32 bit aligned) */
+    check_addr_is_word_aligned(env, CPU_SP(env) - stack_size, GETPC());
+
+    uint32_t tmp_sp = CPU_SP(env);
+
+    if (save_fp) {
+        tmp_sp -= 4;
+        cpu_stl_data(env, tmp_sp, CPU_FP(env));
+    }
+
+    for (uint8_t gpr = regs; gpr >= 1; --gpr) {
+        tmp_sp -= 4;
+        cpu_stl_data(env, tmp_sp, env->r[13 + gpr - 1]);
+    }
+
+    if (save_blink) {
+        tmp_sp -= 4;
+        cpu_stl_data(env, tmp_sp, CPU_BLINK(env));
+    }
+
+    CPU_SP(env) = tmp_sp;
+
+    /* now that sp has been allocated, shall we write it to fp? */
+    if (save_fp) {
+        CPU_FP(env) = CPU_SP(env);
+    }
+}
+
+/*
+ * helper for leave_s instruction.
+ * a stack layout of below is assumed:
+ * ,- top -.
+ * | blink |
+ * | r13   |
+ * | r14   |
+ * | ...   |
+ * | r26   |
+ * | fp    |
+ * `-------'
+ */
+void helper_leave(CPUARCState *env, uint32_t u7)
+{
+    /* nothing to do? then bye-bye! */
+    if (!u7) {
+        return;
+    }
+
+    uint8_t regs       = u7 & 0x0f; /* u[3:0] determines registers to save */
+    bool restore_fp    = u7 & 0x10; /* u[4] indicates if fp must be saved  */
+    bool restore_blink = u7 & 0x20; /* u[5] indicates saving of blink      */
+    bool jump_to_blink = u7 & 0x40; /* u[6] should we jump to blink?       */
+
+    /* number of regs to be restored must be sane */
+    check_enter_leave_nr_regs(env, regs, GETPC());
+
+    /* this cannot be executed in a delay/execution slot */
+    check_delay_or_execution_slot(env, GETPC());
+
+    /*
+     * stack must be a multiple of 4 (32 bit aligned). we must take into
+     * account if sp is going to use fp's value or not.
+     */
+    const target_ulong addr = restore_fp ? CPU_FP(env) : CPU_SP(env);
+    check_addr_is_word_aligned(env, addr, GETPC());
+
+    /*
+     * if fp is in the picture, then first we have to use the current
+     * fp as the stack pointer for restoring.
+     */
+    if (restore_fp) {
+        CPU_SP(env) = CPU_FP(env);
+    }
+
+    uint32_t tmp_sp = CPU_SP(env);
+
+    if (restore_blink) {
+        CPU_BLINK(env) = cpu_ldl_data(env, tmp_sp);
+        tmp_sp += 4;
+    }
+
+    for (uint8_t gpr = 0; gpr < regs; ++gpr) {
+        env->r[13 + gpr] = cpu_ldl_data(env, tmp_sp);
+        tmp_sp += 4;
+    }
+
+    if (restore_fp) {
+        CPU_FP(env) = cpu_ldl_data(env, tmp_sp);
+        tmp_sp += 4;
+    }
+
+    CPU_SP(env) = tmp_sp;
+
+    /* now that we are done, should we jump to blink? */
+    if (jump_to_blink) {
+        CPU_PCL(env) = CPU_BLINK(env);
+        env->pc      = CPU_BLINK(env);
+    }
+}
+
+/*
+ * uint32_t lf_variable = 0;
+ * uint32_t helper_get_lf(void)
+ * {
+ *   return lf_variable;
+ * }
+ * void helper_set_lf(uint32_t v)
+ * {
+ *   lf_variable = v;
+ * }
+ */
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/target/arc/semfunc_mapping.def b/target/arc/semfunc_mapping.def
new file mode 100644
index 0000000000..b47edb42e5
--- /dev/null
+++ b/target/arc/semfunc_mapping.def
@@ -0,0 +1,329 @@
+/*
+ * QEMU ARC SEMANTIC MAPPING.
+ *
+ * Copyright (c) 2020 Synopsys, Inc.
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
+SEMANTIC_FUNCTION(FLAG, 1)
+SEMANTIC_FUNCTION(KFLAG, 1)
+SEMANTIC_FUNCTION(ADD, 3)
+SEMANTIC_FUNCTION(ADD1, 3)
+SEMANTIC_FUNCTION(ADD2, 3)
+SEMANTIC_FUNCTION(ADD3, 3)
+SEMANTIC_FUNCTION(ADC, 3)
+SEMANTIC_FUNCTION(SBC, 3)
+SEMANTIC_FUNCTION(NEG, 2)
+SEMANTIC_FUNCTION(SUB, 3)
+SEMANTIC_FUNCTION(SUB1, 3)
+SEMANTIC_FUNCTION(SUB2, 3)
+SEMANTIC_FUNCTION(SUB3, 3)
+SEMANTIC_FUNCTION(MAX, 3)
+SEMANTIC_FUNCTION(MIN, 3)
+SEMANTIC_FUNCTION(CMP, 2)
+SEMANTIC_FUNCTION(AND, 3)
+SEMANTIC_FUNCTION(OR, 3)
+SEMANTIC_FUNCTION(XOR, 3)
+SEMANTIC_FUNCTION(MOV, 2)
+SEMANTIC_FUNCTION(ASL, 3)
+SEMANTIC_FUNCTION(ASR, 3)
+SEMANTIC_FUNCTION(ASR8, 2)
+SEMANTIC_FUNCTION(ASR16, 2)
+SEMANTIC_FUNCTION(LSL16, 2)
+SEMANTIC_FUNCTION(LSL8, 2)
+SEMANTIC_FUNCTION(LSR, 3)
+SEMANTIC_FUNCTION(LSR16, 2)
+SEMANTIC_FUNCTION(LSR8, 2)
+SEMANTIC_FUNCTION(BIC, 3)
+SEMANTIC_FUNCTION(BCLR, 3)
+SEMANTIC_FUNCTION(BMSK, 3)
+SEMANTIC_FUNCTION(BMSKN, 3)
+SEMANTIC_FUNCTION(BSET, 3)
+SEMANTIC_FUNCTION(BXOR, 3)
+SEMANTIC_FUNCTION(ROL, 2)
+SEMANTIC_FUNCTION(ROL8, 2)
+SEMANTIC_FUNCTION(ROR, 3)
+SEMANTIC_FUNCTION(ROR8, 2)
+SEMANTIC_FUNCTION(RLC, 2)
+SEMANTIC_FUNCTION(RRC, 2)
+SEMANTIC_FUNCTION(SEXB, 2)
+SEMANTIC_FUNCTION(SEXH, 2)
+SEMANTIC_FUNCTION(EXTB, 2)
+SEMANTIC_FUNCTION(EXTH, 2)
+SEMANTIC_FUNCTION(BTST, 2)
+SEMANTIC_FUNCTION(TST, 2)
+SEMANTIC_FUNCTION(XBFU, 3)
+SEMANTIC_FUNCTION(AEX, 2)
+SEMANTIC_FUNCTION(LR, 2)
+SEMANTIC_FUNCTION(SR, 2)
+SEMANTIC_FUNCTION(SYNC, 0)
+SEMANTIC_FUNCTION(CLRI, 1)
+SEMANTIC_FUNCTION(SETI, 1)
+SEMANTIC_FUNCTION(NOP, 0)
+SEMANTIC_FUNCTION(PREALLOC, 0)
+SEMANTIC_FUNCTION(PREFETCH, 2)
+SEMANTIC_FUNCTION(MPY, 3)
+SEMANTIC_FUNCTION(MPYMU, 3)
+SEMANTIC_FUNCTION(MPYM, 3)
+SEMANTIC_FUNCTION(MPYU, 3)
+SEMANTIC_FUNCTION(MPYUW, 3)
+SEMANTIC_FUNCTION(MPYW, 3)
+SEMANTIC_FUNCTION(DIV, 3)
+SEMANTIC_FUNCTION(DIVU, 3)
+SEMANTIC_FUNCTION(REM, 3)
+SEMANTIC_FUNCTION(REMU, 3)
+SEMANTIC_FUNCTION(MAC, 3)
+SEMANTIC_FUNCTION(MACU, 3)
+SEMANTIC_FUNCTION(MACD, 3)
+SEMANTIC_FUNCTION(MACDU, 3)
+SEMANTIC_FUNCTION(ABS, 2)
+SEMANTIC_FUNCTION(SWAP, 2)
+SEMANTIC_FUNCTION(SWAPE, 2)
+SEMANTIC_FUNCTION(NOT, 2)
+SEMANTIC_FUNCTION(BI, 1)
+SEMANTIC_FUNCTION(BIH, 1)
+SEMANTIC_FUNCTION(B, 1)
+SEMANTIC_FUNCTION(B_S, 1)
+SEMANTIC_FUNCTION(BBIT0, 3)
+SEMANTIC_FUNCTION(BBIT1, 3)
+SEMANTIC_FUNCTION(BL, 1)
+SEMANTIC_FUNCTION(J, 1)
+SEMANTIC_FUNCTION(JL, 1)
+SEMANTIC_FUNCTION(SETEQ, 3)
+SEMANTIC_FUNCTION(BREQ, 3)
+SEMANTIC_FUNCTION(SETNE, 3)
+SEMANTIC_FUNCTION(BRNE, 3)
+SEMANTIC_FUNCTION(SETLT, 3)
+SEMANTIC_FUNCTION(BRLT, 3)
+SEMANTIC_FUNCTION(SETGE, 3)
+SEMANTIC_FUNCTION(BRGE, 3)
+SEMANTIC_FUNCTION(SETLE, 3)
+SEMANTIC_FUNCTION(SETGT, 3)
+SEMANTIC_FUNCTION(BRLO, 3)
+SEMANTIC_FUNCTION(SETLO, 3)
+SEMANTIC_FUNCTION(BRHS, 3)
+SEMANTIC_FUNCTION(SETHS, 3)
+SEMANTIC_FUNCTION(EX, 2)
+SEMANTIC_FUNCTION(LLOCK, 2)
+SEMANTIC_FUNCTION(LLOCKD, 2)
+SEMANTIC_FUNCTION(SCOND, 2)
+SEMANTIC_FUNCTION(SCONDD, 2)
+SEMANTIC_FUNCTION(DMB, 1)
+SEMANTIC_FUNCTION(LD, 3)
+SEMANTIC_FUNCTION(LDD, 3)
+SEMANTIC_FUNCTION(ST, 3)
+SEMANTIC_FUNCTION(STD, 3)
+SEMANTIC_FUNCTION(ENTER_S, 1)
+SEMANTIC_FUNCTION(LEAVE_S, 1)
+SEMANTIC_FUNCTION(POP, 1)
+SEMANTIC_FUNCTION(PUSH, 1)
+SEMANTIC_FUNCTION(LP, 1)
+SEMANTIC_FUNCTION(NORM, 2)
+SEMANTIC_FUNCTION(NORMH, 2)
+SEMANTIC_FUNCTION(FLS, 2)
+SEMANTIC_FUNCTION(FFS, 2)
+
+
+MAPPING(flag, FLAG, 1, 0)
+MAPPING(kflag, KFLAG, 1, 0)
+MAPPING(add, ADD, 3, 1, 2, 0)
+MAPPING(add_s, ADD, 3, 1, 2, 0)
+MAPPING(add1, ADD1, 3, 1, 2, 0)
+MAPPING(add1_s, ADD1, 3, 1, 2, 0)
+MAPPING(add2, ADD2, 3, 1, 2, 0)
+MAPPING(add2_s, ADD2, 3, 1, 2, 0)
+MAPPING(add3, ADD3, 3, 1, 2, 0)
+MAPPING(add3_s, ADD3, 3, 1, 2, 0)
+MAPPING(adc, ADC, 3, 1, 2, 0)
+MAPPING(sbc, SBC, 3, 1, 2, 0)
+MAPPING(neg, NEG, 2, 1, 0)
+MAPPING(neg_s, NEG, 2, 1, 0)
+MAPPING(sub, SUB, 3, 1, 2, 0)
+MAPPING(sub_s, SUB, 3, 1, 2, 0)
+MAPPING(rsub, SUB, 3, 2, 1, 0)
+MAPPING(sub1, SUB1, 3, 1, 2, 0)
+MAPPING(sub2, SUB2, 3, 1, 2, 0)
+MAPPING(sub3, SUB3, 3, 1, 2, 0)
+MAPPING(max, MAX, 3, 1, 2, 0)
+MAPPING(min, MIN, 3, 1, 2, 0)
+MAPPING(cmp, CMP, 2, 0, 1)
+MAPPING(cmp_s, CMP, 2, 0, 1)
+MAPPING(rcmp, CMP, 2, 1, 0)
+MAPPING(and, AND, 3, 1, 2, 0)
+MAPPING(and_s, AND, 3, 1, 2, 0)
+MAPPING(or, OR, 3, 1, 2, 0)
+MAPPING(or_s, OR, 3, 1, 2, 0)
+MAPPING(xor, XOR, 3, 1, 2, 0)
+MAPPING(xor_s, XOR, 3, 1, 2, 0)
+MAPPING(mov, MOV, 2, 1, 0)
+MAPPING(mov_s, MOV, 2, 1, 0)
+CONSTANT(ASL, asl, 2, 268435457) /* For variable @c */
+MAPPING(asl, ASL, 3, 1, 2, 0)
+CONSTANT(ASL, asl_s, 2, 268435457) /* For variable @c */
+MAPPING(asl_s, ASL, 3, 1, 2, 0)
+CONSTANT(ASR, asr, 2, 1) /* For variable @c */
+MAPPING(asr, ASR, 3, 1, 2, 0)
+CONSTANT(ASR, asr_s, 2, 1) /* For variable @c */
+MAPPING(asr_s, ASR, 3, 1, 2, 0)
+MAPPING(asr8, ASR8, 2, 1, 0)
+MAPPING(asr16, ASR16, 2, 1, 0)
+MAPPING(lsl16, LSL16, 2, 1, 0)
+MAPPING(lsl8, LSL8, 2, 1, 0)
+CONSTANT(LSR, lsr, 2, 1) /* For variable @c */
+MAPPING(lsr, LSR, 3, 1, 2, 0)
+CONSTANT(LSR, lsr_s, 2, 1) /* For variable @c */
+MAPPING(lsr_s, LSR, 3, 1, 2, 0)
+MAPPING(lsr16, LSR16, 2, 1, 0)
+MAPPING(lsr8, LSR8, 2, 1, 0)
+MAPPING(bic, BIC, 3, 1, 2, 0)
+MAPPING(bic_s, BIC, 3, 1, 2, 0)
+MAPPING(bclr, BCLR, 3, 2, 1, 0)
+MAPPING(bclr_s, BCLR, 3, 2, 1, 0)
+MAPPING(bmsk, BMSK, 3, 2, 1, 0)
+MAPPING(bmsk_s, BMSK, 3, 2, 1, 0)
+MAPPING(bmskn, BMSKN, 3, 2, 1, 0)
+MAPPING(bset, BSET, 3, 2, 1, 0)
+MAPPING(bset_s, BSET, 3, 2, 1, 0)
+MAPPING(bxor, BXOR, 3, 2, 1, 0)
+MAPPING(rol, ROL, 2, 1, 0)
+MAPPING(rol8, ROL8, 2, 1, 0)
+CONSTANT(ROR, ror, 2, 1) /* For variable @n */
+MAPPING(ror, ROR, 3, 1, 2, 0)
+MAPPING(ror8, ROR8, 2, 1, 0)
+MAPPING(rlc, RLC, 2, 1, 0)
+MAPPING(rrc, RRC, 2, 1, 0)
+MAPPING(sexb, SEXB, 2, 0, 1)
+MAPPING(sexb_s, SEXB, 2, 0, 1)
+MAPPING(sexh, SEXH, 2, 0, 1)
+MAPPING(sexh_s, SEXH, 2, 0, 1)
+MAPPING(extb, EXTB, 2, 0, 1)
+MAPPING(extb_s, EXTB, 2, 0, 1)
+MAPPING(exth, EXTH, 2, 0, 1)
+MAPPING(exth_s, EXTH, 2, 0, 1)
+MAPPING(btst, BTST, 2, 1, 0)
+MAPPING(btst_s, BTST, 2, 1, 0)
+MAPPING(tst, TST, 2, 0, 1)
+MAPPING(tst_s, TST, 2, 0, 1)
+MAPPING(xbfu, XBFU, 3, 2, 1, 0)
+MAPPING(aex, AEX, 2, 1, 0)
+MAPPING(lr, LR, 2, 0, 1)
+MAPPING(sr, SR, 2, 1, 0)
+MAPPING(sync, SYNC, 0)
+MAPPING(clri, CLRI, 1, 0)
+MAPPING(seti, SETI, 1, 0)
+MAPPING(nop, NOP, 0)
+MAPPING(nop_s, NOP, 0)
+MAPPING(prealloc, PREALLOC, 0)
+CONSTANT(PREFETCH, prefetch, 1, 0) /* For variable @src2 */
+MAPPING(prefetch, PREFETCH, 2, 0, 1)
+CONSTANT(PREFETCH, prefetchw, 1, 0) /* For variable @src2 */
+MAPPING(prefetchw, PREFETCH, 2, 0, 1)
+MAPPING(mpy, MPY, 3, 1, 2, 0)
+MAPPING(mpy_s, MPY, 3, 1, 2, 0)
+MAPPING(mpymu, MPYMU, 3, 0, 1, 2)
+MAPPING(mpym, MPYM, 3, 0, 1, 2)
+MAPPING(mpyu, MPYU, 3, 1, 2, 0)
+MAPPING(mpyuw, MPYUW, 3, 0, 1, 2)
+MAPPING(mpyuw_s, MPYUW, 3, 0, 1, 2)
+MAPPING(mpyw, MPYW, 3, 0, 1, 2)
+MAPPING(mpyw_s, MPYW, 3, 0, 1, 2)
+MAPPING(div, DIV, 3, 2, 1, 0)
+MAPPING(divu, DIVU, 3, 2, 0, 1)
+MAPPING(rem, REM, 3, 2, 1, 0)
+MAPPING(remu, REMU, 3, 2, 0, 1)
+MAPPING(mac, MAC, 3, 1, 2, 0)
+MAPPING(macu, MACU, 3, 1, 2, 0)
+MAPPING(macd, MACD, 3, 1, 2, 0)
+MAPPING(macdu, MACDU, 3, 1, 2, 0)
+MAPPING(abs, ABS, 2, 1, 0)
+MAPPING(abs_s, ABS, 2, 1, 0)
+MAPPING(swap, SWAP, 2, 1, 0)
+MAPPING(swape, SWAPE, 2, 1, 0)
+MAPPING(not, NOT, 2, 0, 1)
+MAPPING(not_s, NOT, 2, 0, 1)
+MAPPING(bi, BI, 1, 0)
+MAPPING(bih, BIH, 1, 0)
+MAPPING(b, B, 1, 0)
+MAPPING(beq_s, B_S, 1, 0)
+MAPPING(bne_s, B_S, 1, 0)
+MAPPING(bgt_s, B_S, 1, 0)
+MAPPING(bge_s, B_S, 1, 0)
+MAPPING(blt_s, B_S, 1, 0)
+MAPPING(ble_s, B_S, 1, 0)
+MAPPING(bhi_s, B_S, 1, 0)
+MAPPING(bhs_s, B_S, 1, 0)
+MAPPING(blo_s, B_S, 1, 0)
+MAPPING(bls_s, B_S, 1, 0)
+MAPPING(b_s, B_S, 1, 0)
+MAPPING(bbit0, BBIT0, 3, 0, 1, 2)
+MAPPING(bbit1, BBIT1, 3, 0, 1, 2)
+MAPPING(bl, BL, 1, 0)
+MAPPING(bl_s, BL, 1, 0)
+MAPPING(j, J, 1, 0)
+MAPPING(j_s, J, 1, 0)
+MAPPING(jeq_s, J, 1, 0)
+MAPPING(jne_s, J, 1, 0)
+MAPPING(jl, JL, 1, 0)
+MAPPING(jl_s, JL, 1, 0)
+MAPPING(seteq, SETEQ, 3, 1, 2, 0)
+MAPPING(breq, BREQ, 3, 0, 1, 2)
+MAPPING(breq_s, BREQ, 3, 0, 1, 2)
+MAPPING(setne, SETNE, 3, 1, 2, 0)
+MAPPING(brne, BRNE, 3, 0, 1, 2)
+MAPPING(brne_s, BRNE, 3, 0, 1, 2)
+MAPPING(setlt, SETLT, 3, 1, 2, 0)
+MAPPING(brlt, BRLT, 3, 0, 1, 2)
+MAPPING(setge, SETGE, 3, 1, 2, 0)
+MAPPING(brge, BRGE, 3, 0, 1, 2)
+MAPPING(setle, SETLE, 3, 1, 2, 0)
+MAPPING(setgt, SETGT, 3, 1, 2, 0)
+MAPPING(brlo, BRLO, 3, 0, 1, 2)
+MAPPING(setlo, SETLO, 3, 1, 2, 0)
+MAPPING(brhs, BRHS, 3, 0, 1, 2)
+MAPPING(seths, SETHS, 3, 1, 2, 0)
+MAPPING(ex, EX, 2, 0, 1)
+MAPPING(llock, LLOCK, 2, 0, 1)
+MAPPING(llockd, LLOCKD, 2, 0, 1)
+MAPPING(scond, SCOND, 2, 1, 0)
+MAPPING(scondd, SCONDD, 2, 1, 0)
+MAPPING(dmb, DMB, 1, 0)
+CONSTANT(LD, ld, 2, 0) /* For variable @src2 */
+MAPPING(ld, LD, 3, 1, 2, 0)
+MAPPING(ld_s, LD, 3, 1, 2, 0)
+MAPPING(ldb_s, LD, 3, 1, 2, 0)
+MAPPING(ldh_s, LD, 3, 1, 2, 0)
+MAPPING(ldw_s, LD, 3, 1, 2, 0)
+CONSTANT(LD, ldi, 2, 0) /* For variable @src2 */
+MAPPING(ldi, LD, 3, 1, 2, 0)
+CONSTANT(LD, ldi_s, 2, 0) /* For variable @src2 */
+MAPPING(ldi_s, LD, 3, 1, 2, 0)
+CONSTANT(LDD, ldd, 2, 0) /* For variable @src2 */
+MAPPING(ldd, LDD, 3, 1, 2, 0)
+CONSTANT(ST, st, 2, 0) /* For variable @src2 */
+MAPPING(st, ST, 3, 1, 2, 0)
+MAPPING(st_s, ST, 3, 1, 2, 0)
+MAPPING(stb_s, ST, 3, 1, 2, 0)
+MAPPING(sth_s, ST, 3, 1, 2, 0)
+MAPPING(stw_s, ST, 3, 1, 2, 0)
+CONSTANT(STD, std, 2, 0) /* For variable @src2 */
+MAPPING(std, STD, 3, 1, 2, 0)
+MAPPING(enter_s, ENTER_S, 1, 0)
+MAPPING(leave_s, LEAVE_S, 1, 0)
+MAPPING(pop_s, POP, 1, 0)
+MAPPING(push_s, PUSH, 1, 0)
+MAPPING(lp, LP, 1, 0)
+MAPPING(norm, NORM, 2, 1, 0)
+MAPPING(normh, NORMH, 2, 1, 0)
+MAPPING(fls, FLS, 2, 1, 0)
+MAPPING(ffs, FFS, 2, 1, 0)
-- 
2.20.1


