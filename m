Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8146DC3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264F821775
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264F821775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytDg-0007Hf-Bn
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iytAI-0002ri-Jg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iytA8-0001Dw-Fm
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:02:34 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42631 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iytA4-00014n-GK
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:02:24 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 30FDD1A152E;
 Tue,  4 Feb 2020 09:02:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id A73AC1A0F0A;
 Tue,  4 Feb 2020 09:02:17 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 3/3] target/mips: Separate FPU-related helpers into their
 own file
Date: Tue,  4 Feb 2020 09:01:57 +0100
Message-Id: <1580803317-4422-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580803317-4422-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580803317-4422-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

For clarity and easier maintenence, create target/mips/fpu_helper.c, and
move all FPU-related content form target/mips/op_helper.c to that file.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Message-Id: <1580745443-24650-3-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/Makefile.objs |    2 +-
 target/mips/fpu_helper.c  | 1911 +++++++++++++++++++++++++++++++++++++++++++++
 target/mips/op_helper.c   | 1877 --------------------------------------------
 3 files changed, 1912 insertions(+), 1878 deletions(-)
 create mode 100644 target/mips/fpu_helper.c

diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
index 3ca2bde..91eb691 100644
--- a/target/mips/Makefile.objs
+++ b/target/mips/Makefile.objs
@@ -1,5 +1,5 @@
 obj-y += translate.o cpu.o gdbstub.o helper.o
-obj-y += op_helper.o cp0_helper.o
+obj-y += op_helper.o cp0_helper.o fpu_helper.o
 obj-y += dsp_helper.o lmi_helper.o msa_helper.o
 obj-$(CONFIG_SOFTMMU) += mips-semi.o
 obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
new file mode 100644
index 0000000..5287c86
--- /dev/null
+++ b/target/mips/fpu_helper.c
@@ -0,0 +1,1911 @@
+/*
+ *  Helpers for emulation of FPU-related MIPS instructions.
+ *
+ *  Copyright (C) 2004-2005  Jocelyn Mayer
+ *  Copyright (C) 2020  Wave Computing, Inc.
+ *  Copyright (C) 2020  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "cpu.h"
+#include "internal.h"
+#include "qemu/host-utils.h"
+#include "exec/helper-proto.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "exec/memop.h"
+#include "sysemu/kvm.h"
+#include "fpu/softfloat.h"
+
+
+/* Complex FPU operations which may need stack space. */
+
+#define FLOAT_TWO32 make_float32(1 << 30)
+#define FLOAT_TWO64 make_float64(1ULL << 62)
+
+#define FP_TO_INT32_OVERFLOW 0x7fffffff
+#define FP_TO_INT64_OVERFLOW 0x7fffffffffffffffULL
+
+/* convert MIPS rounding mode in FCR31 to IEEE library */
+unsigned int ieee_rm[] = {
+    float_round_nearest_even,
+    float_round_to_zero,
+    float_round_up,
+    float_round_down
+};
+
+target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
+{
+    target_ulong arg1 = 0;
+
+    switch (reg) {
+    case 0:
+        arg1 = (int32_t)env->active_fpu.fcr0;
+        break;
+    case 1:
+        /* UFR Support - Read Status FR */
+        if (env->active_fpu.fcr0 & (1 << FCR0_UFRP)) {
+            if (env->CP0_Config5 & (1 << CP0C5_UFR)) {
+                arg1 = (int32_t)
+                       ((env->CP0_Status & (1  << CP0St_FR)) >> CP0St_FR);
+            } else {
+                do_raise_exception(env, EXCP_RI, GETPC());
+            }
+        }
+        break;
+    case 5:
+        /* FRE Support - read Config5.FRE bit */
+        if (env->active_fpu.fcr0 & (1 << FCR0_FREP)) {
+            if (env->CP0_Config5 & (1 << CP0C5_UFE)) {
+                arg1 = (env->CP0_Config5 >> CP0C5_FRE) & 1;
+            } else {
+                helper_raise_exception(env, EXCP_RI);
+            }
+        }
+        break;
+    case 25:
+        arg1 = ((env->active_fpu.fcr31 >> 24) & 0xfe) |
+               ((env->active_fpu.fcr31 >> 23) & 0x1);
+        break;
+    case 26:
+        arg1 = env->active_fpu.fcr31 & 0x0003f07c;
+        break;
+    case 28:
+        arg1 = (env->active_fpu.fcr31 & 0x00000f83) |
+               ((env->active_fpu.fcr31 >> 22) & 0x4);
+        break;
+    default:
+        arg1 = (int32_t)env->active_fpu.fcr31;
+        break;
+    }
+
+    return arg1;
+}
+
+void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
+{
+    switch (fs) {
+    case 1:
+        /* UFR Alias - Reset Status FR */
+        if (!((env->active_fpu.fcr0 & (1 << FCR0_UFRP)) && (rt == 0))) {
+            return;
+        }
+        if (env->CP0_Config5 & (1 << CP0C5_UFR)) {
+            env->CP0_Status &= ~(1 << CP0St_FR);
+            compute_hflags(env);
+        } else {
+            do_raise_exception(env, EXCP_RI, GETPC());
+        }
+        break;
+    case 4:
+        /* UNFR Alias - Set Status FR */
+        if (!((env->active_fpu.fcr0 & (1 << FCR0_UFRP)) && (rt == 0))) {
+            return;
+        }
+        if (env->CP0_Config5 & (1 << CP0C5_UFR)) {
+            env->CP0_Status |= (1 << CP0St_FR);
+            compute_hflags(env);
+        } else {
+            do_raise_exception(env, EXCP_RI, GETPC());
+        }
+        break;
+    case 5:
+        /* FRE Support - clear Config5.FRE bit */
+        if (!((env->active_fpu.fcr0 & (1 << FCR0_FREP)) && (rt == 0))) {
+            return;
+        }
+        if (env->CP0_Config5 & (1 << CP0C5_UFE)) {
+            env->CP0_Config5 &= ~(1 << CP0C5_FRE);
+            compute_hflags(env);
+        } else {
+            helper_raise_exception(env, EXCP_RI);
+        }
+        break;
+    case 6:
+        /* FRE Support - set Config5.FRE bit */
+        if (!((env->active_fpu.fcr0 & (1 << FCR0_FREP)) && (rt == 0))) {
+            return;
+        }
+        if (env->CP0_Config5 & (1 << CP0C5_UFE)) {
+            env->CP0_Config5 |= (1 << CP0C5_FRE);
+            compute_hflags(env);
+        } else {
+            helper_raise_exception(env, EXCP_RI);
+        }
+        break;
+    case 25:
+        if ((env->insn_flags & ISA_MIPS32R6) || (arg1 & 0xffffff00)) {
+            return;
+        }
+        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0x017fffff) |
+                                ((arg1 & 0xfe) << 24) |
+                                ((arg1 & 0x1) << 23);
+        break;
+    case 26:
+        if (arg1 & 0x007c0000) {
+            return;
+        }
+        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0xfffc0f83) |
+                                (arg1 & 0x0003f07c);
+        break;
+    case 28:
+        if (arg1 & 0x007c0000) {
+            return;
+        }
+        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0xfefff07c) |
+                                (arg1 & 0x00000f83) |
+                                ((arg1 & 0x4) << 22);
+        break;
+    case 31:
+        env->active_fpu.fcr31 = (arg1 & env->active_fpu.fcr31_rw_bitmask) |
+               (env->active_fpu.fcr31 & ~(env->active_fpu.fcr31_rw_bitmask));
+        break;
+    default:
+        if (env->insn_flags & ISA_MIPS32R6) {
+            do_raise_exception(env, EXCP_RI, GETPC());
+        }
+        return;
+    }
+    restore_fp_status(env);
+    set_float_exception_flags(0, &env->active_fpu.fp_status);
+    if ((GET_FP_ENABLE(env->active_fpu.fcr31) | 0x20) &
+        GET_FP_CAUSE(env->active_fpu.fcr31)) {
+        do_raise_exception(env, EXCP_FPE, GETPC());
+    }
+}
+
+int ieee_ex_to_mips(int xcpt)
+{
+    int ret = 0;
+    if (xcpt) {
+        if (xcpt & float_flag_invalid) {
+            ret |= FP_INVALID;
+        }
+        if (xcpt & float_flag_overflow) {
+            ret |= FP_OVERFLOW;
+        }
+        if (xcpt & float_flag_underflow) {
+            ret |= FP_UNDERFLOW;
+        }
+        if (xcpt & float_flag_divbyzero) {
+            ret |= FP_DIV0;
+        }
+        if (xcpt & float_flag_inexact) {
+            ret |= FP_INEXACT;
+        }
+    }
+    return ret;
+}
+
+static inline void update_fcr31(CPUMIPSState *env, uintptr_t pc)
+{
+    int tmp = ieee_ex_to_mips(get_float_exception_flags(
+                                  &env->active_fpu.fp_status));
+
+    SET_FP_CAUSE(env->active_fpu.fcr31, tmp);
+
+    if (tmp) {
+        set_float_exception_flags(0, &env->active_fpu.fp_status);
+
+        if (GET_FP_ENABLE(env->active_fpu.fcr31) & tmp) {
+            do_raise_exception(env, EXCP_FPE, pc);
+        } else {
+            UPDATE_FP_FLAGS(env->active_fpu.fcr31, tmp);
+        }
+    }
+}
+
+/*
+ * Float support.
+ * Single precition routines have a "s" suffix, double precision a
+ * "d" suffix, 32bit integer "w", 64bit integer "l", paired single "ps",
+ * paired single lower "pl", paired single upper "pu".
+ */
+
+/* unary operations, modifying fp status  */
+uint64_t helper_float_sqrt_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    fdt0 = float64_sqrt(fdt0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdt0;
+}
+
+uint32_t helper_float_sqrt_s(CPUMIPSState *env, uint32_t fst0)
+{
+    fst0 = float32_sqrt(fst0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fst0;
+}
+
+uint64_t helper_float_cvtd_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t fdt2;
+
+    fdt2 = float32_to_float64(fst0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdt2;
+}
+
+uint64_t helper_float_cvtd_w(CPUMIPSState *env, uint32_t wt0)
+{
+    uint64_t fdt2;
+
+    fdt2 = int32_to_float64(wt0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdt2;
+}
+
+uint64_t helper_float_cvtd_l(CPUMIPSState *env, uint64_t dt0)
+{
+    uint64_t fdt2;
+
+    fdt2 = int64_to_float64(dt0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdt2;
+}
+
+uint64_t helper_float_cvt_l_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t dt2;
+
+    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        dt2 = FP_TO_INT64_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_cvt_l_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t dt2;
+
+    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        dt2 = FP_TO_INT64_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_cvtps_pw(CPUMIPSState *env, uint64_t dt0)
+{
+    uint32_t fst2;
+    uint32_t fsth2;
+
+    fst2 = int32_to_float32(dt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
+    fsth2 = int32_to_float32(dt0 >> 32, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth2 << 32) | fst2;
+}
+
+uint64_t helper_float_cvtpw_ps(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+    uint32_t wth2;
+    int excp, excph;
+
+    wt2 = float32_to_int32(fdt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
+    excp = get_float_exception_flags(&env->active_fpu.fp_status);
+    if (excp & (float_flag_overflow | float_flag_invalid)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+
+    set_float_exception_flags(0, &env->active_fpu.fp_status);
+    wth2 = float32_to_int32(fdt0 >> 32, &env->active_fpu.fp_status);
+    excph = get_float_exception_flags(&env->active_fpu.fp_status);
+    if (excph & (float_flag_overflow | float_flag_invalid)) {
+        wth2 = FP_TO_INT32_OVERFLOW;
+    }
+
+    set_float_exception_flags(excp | excph, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+
+    return ((uint64_t)wth2 << 32) | wt2;
+}
+
+uint32_t helper_float_cvts_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t fst2;
+
+    fst2 = float64_to_float32(fdt0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fst2;
+}
+
+uint32_t helper_float_cvts_w(CPUMIPSState *env, uint32_t wt0)
+{
+    uint32_t fst2;
+
+    fst2 = int32_to_float32(wt0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fst2;
+}
+
+uint32_t helper_float_cvts_l(CPUMIPSState *env, uint64_t dt0)
+{
+    uint32_t fst2;
+
+    fst2 = int64_to_float32(dt0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fst2;
+}
+
+uint32_t helper_float_cvts_pl(CPUMIPSState *env, uint32_t wt0)
+{
+    uint32_t wt2;
+
+    wt2 = wt0;
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_cvts_pu(CPUMIPSState *env, uint32_t wth0)
+{
+    uint32_t wt2;
+
+    wt2 = wth0;
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_cvt_w_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t wt2;
+
+    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_cvt_w_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+
+    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_round_l_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_nearest_even,
+                            &env->active_fpu.fp_status);
+    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        dt2 = FP_TO_INT64_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_round_l_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_nearest_even,
+                            &env->active_fpu.fp_status);
+    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        dt2 = FP_TO_INT64_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_round_w_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_nearest_even,
+                            &env->active_fpu.fp_status);
+    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_round_w_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_nearest_even,
+                            &env->active_fpu.fp_status);
+    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_trunc_l_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t dt2;
+
+    dt2 = float64_to_int64_round_to_zero(fdt0,
+                                         &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        dt2 = FP_TO_INT64_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_trunc_l_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t dt2;
+
+    dt2 = float32_to_int64_round_to_zero(fst0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        dt2 = FP_TO_INT64_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_trunc_w_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+
+    wt2 = float64_to_int32_round_to_zero(fdt0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_trunc_w_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t wt2;
+
+    wt2 = float32_to_int32_round_to_zero(fst0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_ceil_l_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
+    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        dt2 = FP_TO_INT64_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_ceil_l_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
+    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        dt2 = FP_TO_INT64_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_ceil_w_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
+    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_ceil_w_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
+    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_floor_l_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
+    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        dt2 = FP_TO_INT64_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_floor_l_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
+    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        dt2 = FP_TO_INT64_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_floor_w_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
+    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_floor_w_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
+    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+        & (float_flag_invalid | float_flag_overflow)) {
+        wt2 = FP_TO_INT32_OVERFLOW;
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_cvt_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t dt2;
+
+    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float64_is_any_nan(fdt0)) {
+            dt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_cvt_2008_l_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t dt2;
+
+    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float32_is_any_nan(fst0)) {
+            dt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_cvt_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+
+    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float64_is_any_nan(fdt0)) {
+            wt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_cvt_2008_w_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t wt2;
+
+    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float32_is_any_nan(fst0)) {
+            wt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_round_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_nearest_even,
+            &env->active_fpu.fp_status);
+    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float64_is_any_nan(fdt0)) {
+            dt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_round_2008_l_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_nearest_even,
+            &env->active_fpu.fp_status);
+    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float32_is_any_nan(fst0)) {
+            dt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_round_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_nearest_even,
+            &env->active_fpu.fp_status);
+    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float64_is_any_nan(fdt0)) {
+            wt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_round_2008_w_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_nearest_even,
+            &env->active_fpu.fp_status);
+    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float32_is_any_nan(fst0)) {
+            wt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_trunc_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t dt2;
+
+    dt2 = float64_to_int64_round_to_zero(fdt0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float64_is_any_nan(fdt0)) {
+            dt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_trunc_2008_l_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t dt2;
+
+    dt2 = float32_to_int64_round_to_zero(fst0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float32_is_any_nan(fst0)) {
+            dt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_trunc_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+
+    wt2 = float64_to_int32_round_to_zero(fdt0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float64_is_any_nan(fdt0)) {
+            wt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_trunc_2008_w_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t wt2;
+
+    wt2 = float32_to_int32_round_to_zero(fst0, &env->active_fpu.fp_status);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float32_is_any_nan(fst0)) {
+            wt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_ceil_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
+    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float64_is_any_nan(fdt0)) {
+            dt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_ceil_2008_l_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
+    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float32_is_any_nan(fst0)) {
+            dt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_ceil_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
+    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float64_is_any_nan(fdt0)) {
+            wt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_ceil_2008_w_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
+    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float32_is_any_nan(fst0)) {
+            wt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_floor_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
+    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float64_is_any_nan(fdt0)) {
+            dt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint64_t helper_float_floor_2008_l_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint64_t dt2;
+
+    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
+    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float32_is_any_nan(fst0)) {
+            dt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_floor_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
+    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float64_is_any_nan(fdt0)) {
+            wt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint32_t helper_float_floor_2008_w_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t wt2;
+
+    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
+    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
+    restore_rounding_mode(env);
+    if (get_float_exception_flags(&env->active_fpu.fp_status)
+            & float_flag_invalid) {
+        if (float32_is_any_nan(fst0)) {
+            wt2 = 0;
+        }
+    }
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+/* unary operations, not modifying fp status  */
+#define FLOAT_UNOP(name)                                       \
+uint64_t helper_float_ ## name ## _d(uint64_t fdt0)                \
+{                                                              \
+    return float64_ ## name(fdt0);                             \
+}                                                              \
+uint32_t helper_float_ ## name ## _s(uint32_t fst0)                \
+{                                                              \
+    return float32_ ## name(fst0);                             \
+}                                                              \
+uint64_t helper_float_ ## name ## _ps(uint64_t fdt0)               \
+{                                                              \
+    uint32_t wt0;                                              \
+    uint32_t wth0;                                             \
+                                                               \
+    wt0 = float32_ ## name(fdt0 & 0XFFFFFFFF);                 \
+    wth0 = float32_ ## name(fdt0 >> 32);                       \
+    return ((uint64_t)wth0 << 32) | wt0;                       \
+}
+FLOAT_UNOP(abs)
+FLOAT_UNOP(chs)
+#undef FLOAT_UNOP
+
+/* MIPS specific unary operations */
+uint64_t helper_float_recip_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t fdt2;
+
+    fdt2 = float64_div(float64_one, fdt0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdt2;
+}
+
+uint32_t helper_float_recip_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t fst2;
+
+    fst2 = float32_div(float32_one, fst0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fst2;
+}
+
+uint64_t helper_float_rsqrt_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t fdt2;
+
+    fdt2 = float64_sqrt(fdt0, &env->active_fpu.fp_status);
+    fdt2 = float64_div(float64_one, fdt2, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdt2;
+}
+
+uint32_t helper_float_rsqrt_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t fst2;
+
+    fst2 = float32_sqrt(fst0, &env->active_fpu.fp_status);
+    fst2 = float32_div(float32_one, fst2, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fst2;
+}
+
+uint64_t helper_float_recip1_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t fdt2;
+
+    fdt2 = float64_div(float64_one, fdt0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdt2;
+}
+
+uint32_t helper_float_recip1_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t fst2;
+
+    fst2 = float32_div(float32_one, fst0, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fst2;
+}
+
+uint64_t helper_float_recip1_ps(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t fst2;
+    uint32_t fsth2;
+
+    fst2 = float32_div(float32_one, fdt0 & 0XFFFFFFFF,
+                       &env->active_fpu.fp_status);
+    fsth2 = float32_div(float32_one, fdt0 >> 32, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth2 << 32) | fst2;
+}
+
+uint64_t helper_float_rsqrt1_d(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint64_t fdt2;
+
+    fdt2 = float64_sqrt(fdt0, &env->active_fpu.fp_status);
+    fdt2 = float64_div(float64_one, fdt2, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdt2;
+}
+
+uint32_t helper_float_rsqrt1_s(CPUMIPSState *env, uint32_t fst0)
+{
+    uint32_t fst2;
+
+    fst2 = float32_sqrt(fst0, &env->active_fpu.fp_status);
+    fst2 = float32_div(float32_one, fst2, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fst2;
+}
+
+uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
+{
+    uint32_t fst2;
+    uint32_t fsth2;
+
+    fst2 = float32_sqrt(fdt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
+    fsth2 = float32_sqrt(fdt0 >> 32, &env->active_fpu.fp_status);
+    fst2 = float32_div(float32_one, fst2, &env->active_fpu.fp_status);
+    fsth2 = float32_div(float32_one, fsth2, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth2 << 32) | fst2;
+}
+
+#define FLOAT_RINT(name, bits)                                              \
+uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
+                                         uint ## bits ## _t fs)             \
+{                                                                           \
+    uint ## bits ## _t fdret;                                               \
+                                                                            \
+    fdret = float ## bits ## _round_to_int(fs, &env->active_fpu.fp_status); \
+    update_fcr31(env, GETPC());                                             \
+    return fdret;                                                           \
+}
+
+FLOAT_RINT(rint_s, 32)
+FLOAT_RINT(rint_d, 64)
+#undef FLOAT_RINT
+
+#define FLOAT_CLASS_SIGNALING_NAN      0x001
+#define FLOAT_CLASS_QUIET_NAN          0x002
+#define FLOAT_CLASS_NEGATIVE_INFINITY  0x004
+#define FLOAT_CLASS_NEGATIVE_NORMAL    0x008
+#define FLOAT_CLASS_NEGATIVE_SUBNORMAL 0x010
+#define FLOAT_CLASS_NEGATIVE_ZERO      0x020
+#define FLOAT_CLASS_POSITIVE_INFINITY  0x040
+#define FLOAT_CLASS_POSITIVE_NORMAL    0x080
+#define FLOAT_CLASS_POSITIVE_SUBNORMAL 0x100
+#define FLOAT_CLASS_POSITIVE_ZERO      0x200
+
+#define FLOAT_CLASS(name, bits)                                      \
+uint ## bits ## _t float_ ## name(uint ## bits ## _t arg,            \
+                                  float_status *status)              \
+{                                                                    \
+    if (float ## bits ## _is_signaling_nan(arg, status)) {           \
+        return FLOAT_CLASS_SIGNALING_NAN;                            \
+    } else if (float ## bits ## _is_quiet_nan(arg, status)) {        \
+        return FLOAT_CLASS_QUIET_NAN;                                \
+    } else if (float ## bits ## _is_neg(arg)) {                      \
+        if (float ## bits ## _is_infinity(arg)) {                    \
+            return FLOAT_CLASS_NEGATIVE_INFINITY;                    \
+        } else if (float ## bits ## _is_zero(arg)) {                 \
+            return FLOAT_CLASS_NEGATIVE_ZERO;                        \
+        } else if (float ## bits ## _is_zero_or_denormal(arg)) {     \
+            return FLOAT_CLASS_NEGATIVE_SUBNORMAL;                   \
+        } else {                                                     \
+            return FLOAT_CLASS_NEGATIVE_NORMAL;                      \
+        }                                                            \
+    } else {                                                         \
+        if (float ## bits ## _is_infinity(arg)) {                    \
+            return FLOAT_CLASS_POSITIVE_INFINITY;                    \
+        } else if (float ## bits ## _is_zero(arg)) {                 \
+            return FLOAT_CLASS_POSITIVE_ZERO;                        \
+        } else if (float ## bits ## _is_zero_or_denormal(arg)) {     \
+            return FLOAT_CLASS_POSITIVE_SUBNORMAL;                   \
+        } else {                                                     \
+            return FLOAT_CLASS_POSITIVE_NORMAL;                      \
+        }                                                            \
+    }                                                                \
+}                                                                    \
+                                                                     \
+uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,          \
+                                         uint ## bits ## _t arg)     \
+{                                                                    \
+    return float_ ## name(arg, &env->active_fpu.fp_status);          \
+}
+
+FLOAT_CLASS(class_s, 32)
+FLOAT_CLASS(class_d, 64)
+#undef FLOAT_CLASS
+
+/* binary operations */
+#define FLOAT_BINOP(name)                                          \
+uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,            \
+                                     uint64_t fdt0, uint64_t fdt1) \
+{                                                                  \
+    uint64_t dt2;                                                  \
+                                                                   \
+    dt2 = float64_ ## name(fdt0, fdt1, &env->active_fpu.fp_status);\
+    update_fcr31(env, GETPC());                                    \
+    return dt2;                                                    \
+}                                                                  \
+                                                                   \
+uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,            \
+                                     uint32_t fst0, uint32_t fst1) \
+{                                                                  \
+    uint32_t wt2;                                                  \
+                                                                   \
+    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);\
+    update_fcr31(env, GETPC());                                    \
+    return wt2;                                                    \
+}                                                                  \
+                                                                   \
+uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
+                                      uint64_t fdt0,               \
+                                      uint64_t fdt1)               \
+{                                                                  \
+    uint32_t fst0 = fdt0 & 0XFFFFFFFF;                             \
+    uint32_t fsth0 = fdt0 >> 32;                                   \
+    uint32_t fst1 = fdt1 & 0XFFFFFFFF;                             \
+    uint32_t fsth1 = fdt1 >> 32;                                   \
+    uint32_t wt2;                                                  \
+    uint32_t wth2;                                                 \
+                                                                   \
+    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);     \
+    wth2 = float32_ ## name(fsth0, fsth1, &env->active_fpu.fp_status);  \
+    update_fcr31(env, GETPC());                                    \
+    return ((uint64_t)wth2 << 32) | wt2;                           \
+}
+
+FLOAT_BINOP(add)
+FLOAT_BINOP(sub)
+FLOAT_BINOP(mul)
+FLOAT_BINOP(div)
+#undef FLOAT_BINOP
+
+/* MIPS specific binary operations */
+uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
+{
+    fdt2 = float64_mul(fdt0, fdt2, &env->active_fpu.fp_status);
+    fdt2 = float64_chs(float64_sub(fdt2, float64_one,
+                                   &env->active_fpu.fp_status));
+    update_fcr31(env, GETPC());
+    return fdt2;
+}
+
+uint32_t helper_float_recip2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
+{
+    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
+    fst2 = float32_chs(float32_sub(fst2, float32_one,
+                                       &env->active_fpu.fp_status));
+    update_fcr31(env, GETPC());
+    return fst2;
+}
+
+uint64_t helper_float_recip2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
+{
+    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fst2 = fdt2 & 0XFFFFFFFF;
+    uint32_t fsth2 = fdt2 >> 32;
+
+    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
+    fsth2 = float32_mul(fsth0, fsth2, &env->active_fpu.fp_status);
+    fst2 = float32_chs(float32_sub(fst2, float32_one,
+                                       &env->active_fpu.fp_status));
+    fsth2 = float32_chs(float32_sub(fsth2, float32_one,
+                                       &env->active_fpu.fp_status));
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth2 << 32) | fst2;
+}
+
+uint64_t helper_float_rsqrt2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
+{
+    fdt2 = float64_mul(fdt0, fdt2, &env->active_fpu.fp_status);
+    fdt2 = float64_sub(fdt2, float64_one, &env->active_fpu.fp_status);
+    fdt2 = float64_chs(float64_div(fdt2, FLOAT_TWO64,
+                                       &env->active_fpu.fp_status));
+    update_fcr31(env, GETPC());
+    return fdt2;
+}
+
+uint32_t helper_float_rsqrt2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
+{
+    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
+    fst2 = float32_sub(fst2, float32_one, &env->active_fpu.fp_status);
+    fst2 = float32_chs(float32_div(fst2, FLOAT_TWO32,
+                                       &env->active_fpu.fp_status));
+    update_fcr31(env, GETPC());
+    return fst2;
+}
+
+uint64_t helper_float_rsqrt2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
+{
+    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fst2 = fdt2 & 0XFFFFFFFF;
+    uint32_t fsth2 = fdt2 >> 32;
+
+    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
+    fsth2 = float32_mul(fsth0, fsth2, &env->active_fpu.fp_status);
+    fst2 = float32_sub(fst2, float32_one, &env->active_fpu.fp_status);
+    fsth2 = float32_sub(fsth2, float32_one, &env->active_fpu.fp_status);
+    fst2 = float32_chs(float32_div(fst2, FLOAT_TWO32,
+                                       &env->active_fpu.fp_status));
+    fsth2 = float32_chs(float32_div(fsth2, FLOAT_TWO32,
+                                       &env->active_fpu.fp_status));
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth2 << 32) | fst2;
+}
+
+uint64_t helper_float_addr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fst1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t fst2;
+    uint32_t fsth2;
+
+    fst2 = float32_add(fst0, fsth0, &env->active_fpu.fp_status);
+    fsth2 = float32_add(fst1, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth2 << 32) | fst2;
+}
+
+uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fst1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t fst2;
+    uint32_t fsth2;
+
+    fst2 = float32_mul(fst0, fsth0, &env->active_fpu.fp_status);
+    fsth2 = float32_mul(fst1, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth2 << 32) | fst2;
+}
+
+#define FLOAT_MINMAX(name, bits, minmaxfunc)                            \
+uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
+                                         uint ## bits ## _t fs,         \
+                                         uint ## bits ## _t ft)         \
+{                                                                       \
+    uint ## bits ## _t fdret;                                           \
+                                                                        \
+    fdret = float ## bits ## _ ## minmaxfunc(fs, ft,                    \
+                                           &env->active_fpu.fp_status); \
+    update_fcr31(env, GETPC());                                         \
+    return fdret;                                                       \
+}
+
+FLOAT_MINMAX(max_s, 32, maxnum)
+FLOAT_MINMAX(max_d, 64, maxnum)
+FLOAT_MINMAX(maxa_s, 32, maxnummag)
+FLOAT_MINMAX(maxa_d, 64, maxnummag)
+
+FLOAT_MINMAX(min_s, 32, minnum)
+FLOAT_MINMAX(min_d, 64, minnum)
+FLOAT_MINMAX(mina_s, 32, minnummag)
+FLOAT_MINMAX(mina_d, 64, minnummag)
+#undef FLOAT_MINMAX
+
+/* ternary operations */
+#define UNFUSED_FMA(prefix, a, b, c, flags)                          \
+{                                                                    \
+    a = prefix##_mul(a, b, &env->active_fpu.fp_status);              \
+    if ((flags) & float_muladd_negate_c) {                           \
+        a = prefix##_sub(a, c, &env->active_fpu.fp_status);          \
+    } else {                                                         \
+        a = prefix##_add(a, c, &env->active_fpu.fp_status);          \
+    }                                                                \
+    if ((flags) & float_muladd_negate_result) {                      \
+        a = prefix##_chs(a);                                         \
+    }                                                                \
+}
+
+/* FMA based operations */
+#define FLOAT_FMA(name, type)                                        \
+uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,              \
+                                     uint64_t fdt0, uint64_t fdt1,   \
+                                     uint64_t fdt2)                  \
+{                                                                    \
+    UNFUSED_FMA(float64, fdt0, fdt1, fdt2, type);                    \
+    update_fcr31(env, GETPC());                                      \
+    return fdt0;                                                     \
+}                                                                    \
+                                                                     \
+uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,              \
+                                     uint32_t fst0, uint32_t fst1,   \
+                                     uint32_t fst2)                  \
+{                                                                    \
+    UNFUSED_FMA(float32, fst0, fst1, fst2, type);                    \
+    update_fcr31(env, GETPC());                                      \
+    return fst0;                                                     \
+}                                                                    \
+                                                                     \
+uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,             \
+                                      uint64_t fdt0, uint64_t fdt1,  \
+                                      uint64_t fdt2)                 \
+{                                                                    \
+    uint32_t fst0 = fdt0 & 0XFFFFFFFF;                               \
+    uint32_t fsth0 = fdt0 >> 32;                                     \
+    uint32_t fst1 = fdt1 & 0XFFFFFFFF;                               \
+    uint32_t fsth1 = fdt1 >> 32;                                     \
+    uint32_t fst2 = fdt2 & 0XFFFFFFFF;                               \
+    uint32_t fsth2 = fdt2 >> 32;                                     \
+                                                                     \
+    UNFUSED_FMA(float32, fst0, fst1, fst2, type);                    \
+    UNFUSED_FMA(float32, fsth0, fsth1, fsth2, type);                 \
+    update_fcr31(env, GETPC());                                      \
+    return ((uint64_t)fsth0 << 32) | fst0;                           \
+}
+FLOAT_FMA(madd, 0)
+FLOAT_FMA(msub, float_muladd_negate_c)
+FLOAT_FMA(nmadd, float_muladd_negate_result)
+FLOAT_FMA(nmsub, float_muladd_negate_result | float_muladd_negate_c)
+#undef FLOAT_FMA
+
+#define FLOAT_FMADDSUB(name, bits, muladd_arg)                          \
+uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
+                                         uint ## bits ## _t fs,         \
+                                         uint ## bits ## _t ft,         \
+                                         uint ## bits ## _t fd)         \
+{                                                                       \
+    uint ## bits ## _t fdret;                                           \
+                                                                        \
+    fdret = float ## bits ## _muladd(fs, ft, fd, muladd_arg,            \
+                                     &env->active_fpu.fp_status);       \
+    update_fcr31(env, GETPC());                                         \
+    return fdret;                                                       \
+}
+
+FLOAT_FMADDSUB(maddf_s, 32, 0)
+FLOAT_FMADDSUB(maddf_d, 64, 0)
+FLOAT_FMADDSUB(msubf_s, 32, float_muladd_negate_product)
+FLOAT_FMADDSUB(msubf_d, 64, float_muladd_negate_product)
+#undef FLOAT_FMADDSUB
+
+/* compare operations */
+#define FOP_COND_D(op, cond)                                   \
+void helper_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
+                         uint64_t fdt1, int cc)                \
+{                                                              \
+    int c;                                                     \
+    c = cond;                                                  \
+    update_fcr31(env, GETPC());                                \
+    if (c)                                                     \
+        SET_FP_COND(cc, env->active_fpu);                      \
+    else                                                       \
+        CLEAR_FP_COND(cc, env->active_fpu);                    \
+}                                                              \
+void helper_cmpabs_d_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
+                            uint64_t fdt1, int cc)             \
+{                                                              \
+    int c;                                                     \
+    fdt0 = float64_abs(fdt0);                                  \
+    fdt1 = float64_abs(fdt1);                                  \
+    c = cond;                                                  \
+    update_fcr31(env, GETPC());                                \
+    if (c)                                                     \
+        SET_FP_COND(cc, env->active_fpu);                      \
+    else                                                       \
+        CLEAR_FP_COND(cc, env->active_fpu);                    \
+}
+
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float64_unordered_quiet() is still called.
+ */
+FOP_COND_D(f,    (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_D(un,   float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(eq,   float64_eq_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ueq,  float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_eq_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(olt,  float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ult,  float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ole,  float64_le_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ule,  float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_le_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float64_unordered() is still called.
+ */
+FOP_COND_D(sf,   (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_D(ngle, float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(seq,  float64_eq(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ngl,  float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_eq(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(lt,   float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(nge,  float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(le,   float64_le(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ngt,  float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_le(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+
+#define FOP_COND_S(op, cond)                                   \
+void helper_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,     \
+                         uint32_t fst1, int cc)                \
+{                                                              \
+    int c;                                                     \
+    c = cond;                                                  \
+    update_fcr31(env, GETPC());                                \
+    if (c)                                                     \
+        SET_FP_COND(cc, env->active_fpu);                      \
+    else                                                       \
+        CLEAR_FP_COND(cc, env->active_fpu);                    \
+}                                                              \
+void helper_cmpabs_s_ ## op(CPUMIPSState *env, uint32_t fst0,  \
+                            uint32_t fst1, int cc)             \
+{                                                              \
+    int c;                                                     \
+    fst0 = float32_abs(fst0);                                  \
+    fst1 = float32_abs(fst1);                                  \
+    c = cond;                                                  \
+    update_fcr31(env, GETPC());                                \
+    if (c)                                                     \
+        SET_FP_COND(cc, env->active_fpu);                      \
+    else                                                       \
+        CLEAR_FP_COND(cc, env->active_fpu);                    \
+}
+
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered_quiet() is still called.
+ */
+FOP_COND_S(f,    (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_S(un,   float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(eq,   float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ueq,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(olt,  float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ult,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ole,  float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ule,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered() is still called.
+ */
+FOP_COND_S(sf,   (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_S(ngle, float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(seq,  float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ngl,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(lt,   float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(nge,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(le,   float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ngt,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+
+#define FOP_COND_PS(op, condl, condh)                           \
+void helper_cmp_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
+                          uint64_t fdt1, int cc)                \
+{                                                               \
+    uint32_t fst0, fsth0, fst1, fsth1;                          \
+    int ch, cl;                                                 \
+    fst0 = fdt0 & 0XFFFFFFFF;                                   \
+    fsth0 = fdt0 >> 32;                                         \
+    fst1 = fdt1 & 0XFFFFFFFF;                                   \
+    fsth1 = fdt1 >> 32;                                         \
+    cl = condl;                                                 \
+    ch = condh;                                                 \
+    update_fcr31(env, GETPC());                                 \
+    if (cl)                                                     \
+        SET_FP_COND(cc, env->active_fpu);                       \
+    else                                                        \
+        CLEAR_FP_COND(cc, env->active_fpu);                     \
+    if (ch)                                                     \
+        SET_FP_COND(cc + 1, env->active_fpu);                   \
+    else                                                        \
+        CLEAR_FP_COND(cc + 1, env->active_fpu);                 \
+}                                                               \
+void helper_cmpabs_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
+                             uint64_t fdt1, int cc)             \
+{                                                               \
+    uint32_t fst0, fsth0, fst1, fsth1;                          \
+    int ch, cl;                                                 \
+    fst0 = float32_abs(fdt0 & 0XFFFFFFFF);                      \
+    fsth0 = float32_abs(fdt0 >> 32);                            \
+    fst1 = float32_abs(fdt1 & 0XFFFFFFFF);                      \
+    fsth1 = float32_abs(fdt1 >> 32);                            \
+    cl = condl;                                                 \
+    ch = condh;                                                 \
+    update_fcr31(env, GETPC());                                 \
+    if (cl)                                                     \
+        SET_FP_COND(cc, env->active_fpu);                       \
+    else                                                        \
+        CLEAR_FP_COND(cc, env->active_fpu);                     \
+    if (ch)                                                     \
+        SET_FP_COND(cc + 1, env->active_fpu);                   \
+    else                                                        \
+        CLEAR_FP_COND(cc + 1, env->active_fpu);                 \
+}
+
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered_quiet() is still called.
+ */
+FOP_COND_PS(f,    (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0),
+                  (float32_unordered_quiet(fsth1, fsth0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_PS(un,   float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered_quiet(fsth1, fsth0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(eq,   float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_eq_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ueq,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered_quiet(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_eq_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(olt,  float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_lt_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ult,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered_quiet(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_lt_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ole,  float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_le_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ule,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered_quiet(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_le_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered() is still called.
+ */
+FOP_COND_PS(sf,   (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0),
+                  (float32_unordered(fsth1, fsth0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_PS(ngle, float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered(fsth1, fsth0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(seq,  float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_eq(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ngl,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_eq(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(lt,   float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_lt(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(nge,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_lt(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(le,   float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_le(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ngt,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_le(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+
+/* R6 compare operations */
+#define FOP_CONDN_D(op, cond)                                       \
+uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,   \
+                                uint64_t fdt1)                      \
+{                                                                   \
+    uint64_t c;                                                     \
+    c = cond;                                                       \
+    update_fcr31(env, GETPC());                                     \
+    if (c) {                                                        \
+        return -1;                                                  \
+    } else {                                                        \
+        return 0;                                                   \
+    }                                                               \
+}
+
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float64_unordered_quiet() is still called.
+ */
+FOP_CONDN_D(af,  (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_CONDN_D(un,  (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(eq,  (float64_eq_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(ueq, (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_eq_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(lt,  (float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(ult, (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(le,  (float64_le_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(ule, (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_le_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float64_unordered() is still called.\
+ */
+FOP_CONDN_D(saf,  (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_CONDN_D(sun,  (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(seq,  (float64_eq(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sueq, (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_eq(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(slt,  (float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sult, (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sle,  (float64_le(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sule, (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_le(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(or,   (float64_le_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_le_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(une,  (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(ne,   (float64_lt_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sor,  (float64_le(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_le(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sune, (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sne,  (float64_lt(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+
+#define FOP_CONDN_S(op, cond)                                       \
+uint32_t helper_r6_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,   \
+                                uint32_t fst1)                      \
+{                                                                   \
+    uint64_t c;                                                     \
+    c = cond;                                                       \
+    update_fcr31(env, GETPC());                                     \
+    if (c) {                                                        \
+        return -1;                                                  \
+    } else {                                                        \
+        return 0;                                                   \
+    }                                                               \
+}
+
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered_quiet() is still called.
+ */
+FOP_CONDN_S(af,   (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_CONDN_S(un,   (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(eq,   (float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(ueq,  (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(lt,   (float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(ult,  (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(le,   (float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(ule,  (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered() is still called.
+ */
+FOP_CONDN_S(saf,  (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_CONDN_S(sun,  (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(seq,  (float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sueq, (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(slt,  (float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sult, (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sle,  (float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sule, (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(or,   (float32_le_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(une,  (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(ne,   (float32_lt_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sor,  (float32_le(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sune, (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sne,  (float32_lt(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 27c3963..9552b28 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -28,7 +28,6 @@
 #include "exec/cpu_ldst.h"
 #include "exec/memop.h"
 #include "sysemu/kvm.h"
-#include "fpu/softfloat.h"
 
 
 /*****************************************************************************/
@@ -1178,1882 +1177,6 @@ void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 }
 #endif /* !CONFIG_USER_ONLY */
 
-/* Complex FPU operations which may need stack space. */
-
-#define FLOAT_TWO32 make_float32(1 << 30)
-#define FLOAT_TWO64 make_float64(1ULL << 62)
-
-#define FP_TO_INT32_OVERFLOW 0x7fffffff
-#define FP_TO_INT64_OVERFLOW 0x7fffffffffffffffULL
-
-/* convert MIPS rounding mode in FCR31 to IEEE library */
-unsigned int ieee_rm[] = {
-    float_round_nearest_even,
-    float_round_to_zero,
-    float_round_up,
-    float_round_down
-};
-
-target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
-{
-    target_ulong arg1 = 0;
-
-    switch (reg) {
-    case 0:
-        arg1 = (int32_t)env->active_fpu.fcr0;
-        break;
-    case 1:
-        /* UFR Support - Read Status FR */
-        if (env->active_fpu.fcr0 & (1 << FCR0_UFRP)) {
-            if (env->CP0_Config5 & (1 << CP0C5_UFR)) {
-                arg1 = (int32_t)
-                       ((env->CP0_Status & (1  << CP0St_FR)) >> CP0St_FR);
-            } else {
-                do_raise_exception(env, EXCP_RI, GETPC());
-            }
-        }
-        break;
-    case 5:
-        /* FRE Support - read Config5.FRE bit */
-        if (env->active_fpu.fcr0 & (1 << FCR0_FREP)) {
-            if (env->CP0_Config5 & (1 << CP0C5_UFE)) {
-                arg1 = (env->CP0_Config5 >> CP0C5_FRE) & 1;
-            } else {
-                helper_raise_exception(env, EXCP_RI);
-            }
-        }
-        break;
-    case 25:
-        arg1 = ((env->active_fpu.fcr31 >> 24) & 0xfe) |
-               ((env->active_fpu.fcr31 >> 23) & 0x1);
-        break;
-    case 26:
-        arg1 = env->active_fpu.fcr31 & 0x0003f07c;
-        break;
-    case 28:
-        arg1 = (env->active_fpu.fcr31 & 0x00000f83) |
-               ((env->active_fpu.fcr31 >> 22) & 0x4);
-        break;
-    default:
-        arg1 = (int32_t)env->active_fpu.fcr31;
-        break;
-    }
-
-    return arg1;
-}
-
-void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
-{
-    switch (fs) {
-    case 1:
-        /* UFR Alias - Reset Status FR */
-        if (!((env->active_fpu.fcr0 & (1 << FCR0_UFRP)) && (rt == 0))) {
-            return;
-        }
-        if (env->CP0_Config5 & (1 << CP0C5_UFR)) {
-            env->CP0_Status &= ~(1 << CP0St_FR);
-            compute_hflags(env);
-        } else {
-            do_raise_exception(env, EXCP_RI, GETPC());
-        }
-        break;
-    case 4:
-        /* UNFR Alias - Set Status FR */
-        if (!((env->active_fpu.fcr0 & (1 << FCR0_UFRP)) && (rt == 0))) {
-            return;
-        }
-        if (env->CP0_Config5 & (1 << CP0C5_UFR)) {
-            env->CP0_Status |= (1 << CP0St_FR);
-            compute_hflags(env);
-        } else {
-            do_raise_exception(env, EXCP_RI, GETPC());
-        }
-        break;
-    case 5:
-        /* FRE Support - clear Config5.FRE bit */
-        if (!((env->active_fpu.fcr0 & (1 << FCR0_FREP)) && (rt == 0))) {
-            return;
-        }
-        if (env->CP0_Config5 & (1 << CP0C5_UFE)) {
-            env->CP0_Config5 &= ~(1 << CP0C5_FRE);
-            compute_hflags(env);
-        } else {
-            helper_raise_exception(env, EXCP_RI);
-        }
-        break;
-    case 6:
-        /* FRE Support - set Config5.FRE bit */
-        if (!((env->active_fpu.fcr0 & (1 << FCR0_FREP)) && (rt == 0))) {
-            return;
-        }
-        if (env->CP0_Config5 & (1 << CP0C5_UFE)) {
-            env->CP0_Config5 |= (1 << CP0C5_FRE);
-            compute_hflags(env);
-        } else {
-            helper_raise_exception(env, EXCP_RI);
-        }
-        break;
-    case 25:
-        if ((env->insn_flags & ISA_MIPS32R6) || (arg1 & 0xffffff00)) {
-            return;
-        }
-        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0x017fffff) |
-                                ((arg1 & 0xfe) << 24) |
-                                ((arg1 & 0x1) << 23);
-        break;
-    case 26:
-        if (arg1 & 0x007c0000) {
-            return;
-        }
-        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0xfffc0f83) |
-                                (arg1 & 0x0003f07c);
-        break;
-    case 28:
-        if (arg1 & 0x007c0000) {
-            return;
-        }
-        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0xfefff07c) |
-                                (arg1 & 0x00000f83) |
-                                ((arg1 & 0x4) << 22);
-        break;
-    case 31:
-        env->active_fpu.fcr31 = (arg1 & env->active_fpu.fcr31_rw_bitmask) |
-               (env->active_fpu.fcr31 & ~(env->active_fpu.fcr31_rw_bitmask));
-        break;
-    default:
-        if (env->insn_flags & ISA_MIPS32R6) {
-            do_raise_exception(env, EXCP_RI, GETPC());
-        }
-        return;
-    }
-    restore_fp_status(env);
-    set_float_exception_flags(0, &env->active_fpu.fp_status);
-    if ((GET_FP_ENABLE(env->active_fpu.fcr31) | 0x20) &
-        GET_FP_CAUSE(env->active_fpu.fcr31)) {
-        do_raise_exception(env, EXCP_FPE, GETPC());
-    }
-}
-
-int ieee_ex_to_mips(int xcpt)
-{
-    int ret = 0;
-    if (xcpt) {
-        if (xcpt & float_flag_invalid) {
-            ret |= FP_INVALID;
-        }
-        if (xcpt & float_flag_overflow) {
-            ret |= FP_OVERFLOW;
-        }
-        if (xcpt & float_flag_underflow) {
-            ret |= FP_UNDERFLOW;
-        }
-        if (xcpt & float_flag_divbyzero) {
-            ret |= FP_DIV0;
-        }
-        if (xcpt & float_flag_inexact) {
-            ret |= FP_INEXACT;
-        }
-    }
-    return ret;
-}
-
-static inline void update_fcr31(CPUMIPSState *env, uintptr_t pc)
-{
-    int tmp = ieee_ex_to_mips(get_float_exception_flags(
-                                  &env->active_fpu.fp_status));
-
-    SET_FP_CAUSE(env->active_fpu.fcr31, tmp);
-
-    if (tmp) {
-        set_float_exception_flags(0, &env->active_fpu.fp_status);
-
-        if (GET_FP_ENABLE(env->active_fpu.fcr31) & tmp) {
-            do_raise_exception(env, EXCP_FPE, pc);
-        } else {
-            UPDATE_FP_FLAGS(env->active_fpu.fcr31, tmp);
-        }
-    }
-}
-
-/*
- * Float support.
- * Single precition routines have a "s" suffix, double precision a
- * "d" suffix, 32bit integer "w", 64bit integer "l", paired single "ps",
- * paired single lower "pl", paired single upper "pu".
- */
-
-/* unary operations, modifying fp status  */
-uint64_t helper_float_sqrt_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    fdt0 = float64_sqrt(fdt0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fdt0;
-}
-
-uint32_t helper_float_sqrt_s(CPUMIPSState *env, uint32_t fst0)
-{
-    fst0 = float32_sqrt(fst0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fst0;
-}
-
-uint64_t helper_float_cvtd_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t fdt2;
-
-    fdt2 = float32_to_float64(fst0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fdt2;
-}
-
-uint64_t helper_float_cvtd_w(CPUMIPSState *env, uint32_t wt0)
-{
-    uint64_t fdt2;
-
-    fdt2 = int32_to_float64(wt0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fdt2;
-}
-
-uint64_t helper_float_cvtd_l(CPUMIPSState *env, uint64_t dt0)
-{
-    uint64_t fdt2;
-
-    fdt2 = int64_to_float64(dt0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fdt2;
-}
-
-uint64_t helper_float_cvt_l_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t dt2;
-
-    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        dt2 = FP_TO_INT64_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_cvt_l_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t dt2;
-
-    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        dt2 = FP_TO_INT64_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_cvtps_pw(CPUMIPSState *env, uint64_t dt0)
-{
-    uint32_t fst2;
-    uint32_t fsth2;
-
-    fst2 = int32_to_float32(dt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
-    fsth2 = int32_to_float32(dt0 >> 32, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
-}
-
-uint64_t helper_float_cvtpw_ps(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-    uint32_t wth2;
-    int excp, excph;
-
-    wt2 = float32_to_int32(fdt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
-    excp = get_float_exception_flags(&env->active_fpu.fp_status);
-    if (excp & (float_flag_overflow | float_flag_invalid)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-
-    set_float_exception_flags(0, &env->active_fpu.fp_status);
-    wth2 = float32_to_int32(fdt0 >> 32, &env->active_fpu.fp_status);
-    excph = get_float_exception_flags(&env->active_fpu.fp_status);
-    if (excph & (float_flag_overflow | float_flag_invalid)) {
-        wth2 = FP_TO_INT32_OVERFLOW;
-    }
-
-    set_float_exception_flags(excp | excph, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-
-    return ((uint64_t)wth2 << 32) | wt2;
-}
-
-uint32_t helper_float_cvts_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t fst2;
-
-    fst2 = float64_to_float32(fdt0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fst2;
-}
-
-uint32_t helper_float_cvts_w(CPUMIPSState *env, uint32_t wt0)
-{
-    uint32_t fst2;
-
-    fst2 = int32_to_float32(wt0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fst2;
-}
-
-uint32_t helper_float_cvts_l(CPUMIPSState *env, uint64_t dt0)
-{
-    uint32_t fst2;
-
-    fst2 = int64_to_float32(dt0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fst2;
-}
-
-uint32_t helper_float_cvts_pl(CPUMIPSState *env, uint32_t wt0)
-{
-    uint32_t wt2;
-
-    wt2 = wt0;
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_cvts_pu(CPUMIPSState *env, uint32_t wth0)
-{
-    uint32_t wt2;
-
-    wt2 = wth0;
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_cvt_w_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t wt2;
-
-    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_cvt_w_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-
-    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint64_t helper_float_round_l_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_nearest_even,
-                            &env->active_fpu.fp_status);
-    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        dt2 = FP_TO_INT64_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_round_l_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_nearest_even,
-                            &env->active_fpu.fp_status);
-    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        dt2 = FP_TO_INT64_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint32_t helper_float_round_w_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_nearest_even,
-                            &env->active_fpu.fp_status);
-    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_round_w_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_nearest_even,
-                            &env->active_fpu.fp_status);
-    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint64_t helper_float_trunc_l_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t dt2;
-
-    dt2 = float64_to_int64_round_to_zero(fdt0,
-                                         &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        dt2 = FP_TO_INT64_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_trunc_l_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t dt2;
-
-    dt2 = float32_to_int64_round_to_zero(fst0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        dt2 = FP_TO_INT64_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint32_t helper_float_trunc_w_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-
-    wt2 = float64_to_int32_round_to_zero(fdt0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_trunc_w_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t wt2;
-
-    wt2 = float32_to_int32_round_to_zero(fst0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint64_t helper_float_ceil_l_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
-    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        dt2 = FP_TO_INT64_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_ceil_l_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
-    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        dt2 = FP_TO_INT64_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint32_t helper_float_ceil_w_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
-    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_ceil_w_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
-    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint64_t helper_float_floor_l_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
-    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        dt2 = FP_TO_INT64_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_floor_l_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
-    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        dt2 = FP_TO_INT64_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint32_t helper_float_floor_w_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
-    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_floor_w_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
-    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-        & (float_flag_invalid | float_flag_overflow)) {
-        wt2 = FP_TO_INT32_OVERFLOW;
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint64_t helper_float_cvt_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t dt2;
-
-    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float64_is_any_nan(fdt0)) {
-            dt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_cvt_2008_l_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t dt2;
-
-    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float32_is_any_nan(fst0)) {
-            dt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint32_t helper_float_cvt_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-
-    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float64_is_any_nan(fdt0)) {
-            wt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_cvt_2008_w_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t wt2;
-
-    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float32_is_any_nan(fst0)) {
-            wt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint64_t helper_float_round_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_nearest_even,
-            &env->active_fpu.fp_status);
-    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float64_is_any_nan(fdt0)) {
-            dt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_round_2008_l_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_nearest_even,
-            &env->active_fpu.fp_status);
-    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float32_is_any_nan(fst0)) {
-            dt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint32_t helper_float_round_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_nearest_even,
-            &env->active_fpu.fp_status);
-    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float64_is_any_nan(fdt0)) {
-            wt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_round_2008_w_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_nearest_even,
-            &env->active_fpu.fp_status);
-    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float32_is_any_nan(fst0)) {
-            wt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint64_t helper_float_trunc_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t dt2;
-
-    dt2 = float64_to_int64_round_to_zero(fdt0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float64_is_any_nan(fdt0)) {
-            dt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_trunc_2008_l_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t dt2;
-
-    dt2 = float32_to_int64_round_to_zero(fst0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float32_is_any_nan(fst0)) {
-            dt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint32_t helper_float_trunc_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-
-    wt2 = float64_to_int32_round_to_zero(fdt0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float64_is_any_nan(fdt0)) {
-            wt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_trunc_2008_w_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t wt2;
-
-    wt2 = float32_to_int32_round_to_zero(fst0, &env->active_fpu.fp_status);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float32_is_any_nan(fst0)) {
-            wt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint64_t helper_float_ceil_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
-    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float64_is_any_nan(fdt0)) {
-            dt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_ceil_2008_l_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
-    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float32_is_any_nan(fst0)) {
-            dt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint32_t helper_float_ceil_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
-    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float64_is_any_nan(fdt0)) {
-            wt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_ceil_2008_w_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_up, &env->active_fpu.fp_status);
-    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float32_is_any_nan(fst0)) {
-            wt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint64_t helper_float_floor_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
-    dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float64_is_any_nan(fdt0)) {
-            dt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint64_t helper_float_floor_2008_l_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint64_t dt2;
-
-    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
-    dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float32_is_any_nan(fst0)) {
-            dt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return dt2;
-}
-
-uint32_t helper_float_floor_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
-    wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float64_is_any_nan(fdt0)) {
-            wt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-uint32_t helper_float_floor_2008_w_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t wt2;
-
-    set_float_rounding_mode(float_round_down, &env->active_fpu.fp_status);
-    wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
-    restore_rounding_mode(env);
-    if (get_float_exception_flags(&env->active_fpu.fp_status)
-            & float_flag_invalid) {
-        if (float32_is_any_nan(fst0)) {
-            wt2 = 0;
-        }
-    }
-    update_fcr31(env, GETPC());
-    return wt2;
-}
-
-/* unary operations, not modifying fp status  */
-#define FLOAT_UNOP(name)                                       \
-uint64_t helper_float_ ## name ## _d(uint64_t fdt0)                \
-{                                                              \
-    return float64_ ## name(fdt0);                             \
-}                                                              \
-uint32_t helper_float_ ## name ## _s(uint32_t fst0)                \
-{                                                              \
-    return float32_ ## name(fst0);                             \
-}                                                              \
-uint64_t helper_float_ ## name ## _ps(uint64_t fdt0)               \
-{                                                              \
-    uint32_t wt0;                                              \
-    uint32_t wth0;                                             \
-                                                               \
-    wt0 = float32_ ## name(fdt0 & 0XFFFFFFFF);                 \
-    wth0 = float32_ ## name(fdt0 >> 32);                       \
-    return ((uint64_t)wth0 << 32) | wt0;                       \
-}
-FLOAT_UNOP(abs)
-FLOAT_UNOP(chs)
-#undef FLOAT_UNOP
-
-/* MIPS specific unary operations */
-uint64_t helper_float_recip_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t fdt2;
-
-    fdt2 = float64_div(float64_one, fdt0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fdt2;
-}
-
-uint32_t helper_float_recip_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t fst2;
-
-    fst2 = float32_div(float32_one, fst0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fst2;
-}
-
-uint64_t helper_float_rsqrt_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t fdt2;
-
-    fdt2 = float64_sqrt(fdt0, &env->active_fpu.fp_status);
-    fdt2 = float64_div(float64_one, fdt2, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fdt2;
-}
-
-uint32_t helper_float_rsqrt_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t fst2;
-
-    fst2 = float32_sqrt(fst0, &env->active_fpu.fp_status);
-    fst2 = float32_div(float32_one, fst2, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fst2;
-}
-
-uint64_t helper_float_recip1_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t fdt2;
-
-    fdt2 = float64_div(float64_one, fdt0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fdt2;
-}
-
-uint32_t helper_float_recip1_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t fst2;
-
-    fst2 = float32_div(float32_one, fst0, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fst2;
-}
-
-uint64_t helper_float_recip1_ps(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t fst2;
-    uint32_t fsth2;
-
-    fst2 = float32_div(float32_one, fdt0 & 0XFFFFFFFF,
-                       &env->active_fpu.fp_status);
-    fsth2 = float32_div(float32_one, fdt0 >> 32, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
-}
-
-uint64_t helper_float_rsqrt1_d(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint64_t fdt2;
-
-    fdt2 = float64_sqrt(fdt0, &env->active_fpu.fp_status);
-    fdt2 = float64_div(float64_one, fdt2, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fdt2;
-}
-
-uint32_t helper_float_rsqrt1_s(CPUMIPSState *env, uint32_t fst0)
-{
-    uint32_t fst2;
-
-    fst2 = float32_sqrt(fst0, &env->active_fpu.fp_status);
-    fst2 = float32_div(float32_one, fst2, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return fst2;
-}
-
-uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
-{
-    uint32_t fst2;
-    uint32_t fsth2;
-
-    fst2 = float32_sqrt(fdt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
-    fsth2 = float32_sqrt(fdt0 >> 32, &env->active_fpu.fp_status);
-    fst2 = float32_div(float32_one, fst2, &env->active_fpu.fp_status);
-    fsth2 = float32_div(float32_one, fsth2, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
-}
-
-#define FLOAT_RINT(name, bits)                                              \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
-                                         uint ## bits ## _t fs)             \
-{                                                                           \
-    uint ## bits ## _t fdret;                                               \
-                                                                            \
-    fdret = float ## bits ## _round_to_int(fs, &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                             \
-    return fdret;                                                           \
-}
-
-FLOAT_RINT(rint_s, 32)
-FLOAT_RINT(rint_d, 64)
-#undef FLOAT_RINT
-
-#define FLOAT_CLASS_SIGNALING_NAN      0x001
-#define FLOAT_CLASS_QUIET_NAN          0x002
-#define FLOAT_CLASS_NEGATIVE_INFINITY  0x004
-#define FLOAT_CLASS_NEGATIVE_NORMAL    0x008
-#define FLOAT_CLASS_NEGATIVE_SUBNORMAL 0x010
-#define FLOAT_CLASS_NEGATIVE_ZERO      0x020
-#define FLOAT_CLASS_POSITIVE_INFINITY  0x040
-#define FLOAT_CLASS_POSITIVE_NORMAL    0x080
-#define FLOAT_CLASS_POSITIVE_SUBNORMAL 0x100
-#define FLOAT_CLASS_POSITIVE_ZERO      0x200
-
-#define FLOAT_CLASS(name, bits)                                      \
-uint ## bits ## _t float_ ## name(uint ## bits ## _t arg,            \
-                                  float_status *status)              \
-{                                                                    \
-    if (float ## bits ## _is_signaling_nan(arg, status)) {           \
-        return FLOAT_CLASS_SIGNALING_NAN;                            \
-    } else if (float ## bits ## _is_quiet_nan(arg, status)) {        \
-        return FLOAT_CLASS_QUIET_NAN;                                \
-    } else if (float ## bits ## _is_neg(arg)) {                      \
-        if (float ## bits ## _is_infinity(arg)) {                    \
-            return FLOAT_CLASS_NEGATIVE_INFINITY;                    \
-        } else if (float ## bits ## _is_zero(arg)) {                 \
-            return FLOAT_CLASS_NEGATIVE_ZERO;                        \
-        } else if (float ## bits ## _is_zero_or_denormal(arg)) {     \
-            return FLOAT_CLASS_NEGATIVE_SUBNORMAL;                   \
-        } else {                                                     \
-            return FLOAT_CLASS_NEGATIVE_NORMAL;                      \
-        }                                                            \
-    } else {                                                         \
-        if (float ## bits ## _is_infinity(arg)) {                    \
-            return FLOAT_CLASS_POSITIVE_INFINITY;                    \
-        } else if (float ## bits ## _is_zero(arg)) {                 \
-            return FLOAT_CLASS_POSITIVE_ZERO;                        \
-        } else if (float ## bits ## _is_zero_or_denormal(arg)) {     \
-            return FLOAT_CLASS_POSITIVE_SUBNORMAL;                   \
-        } else {                                                     \
-            return FLOAT_CLASS_POSITIVE_NORMAL;                      \
-        }                                                            \
-    }                                                                \
-}                                                                    \
-                                                                     \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,          \
-                                         uint ## bits ## _t arg)     \
-{                                                                    \
-    return float_ ## name(arg, &env->active_fpu.fp_status);          \
-}
-
-FLOAT_CLASS(class_s, 32)
-FLOAT_CLASS(class_d, 64)
-#undef FLOAT_CLASS
-
-/* binary operations */
-#define FLOAT_BINOP(name)                                          \
-uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,            \
-                                     uint64_t fdt0, uint64_t fdt1) \
-{                                                                  \
-    uint64_t dt2;                                                  \
-                                                                   \
-    dt2 = float64_ ## name(fdt0, fdt1, &env->active_fpu.fp_status);\
-    update_fcr31(env, GETPC());                                    \
-    return dt2;                                                    \
-}                                                                  \
-                                                                   \
-uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,            \
-                                     uint32_t fst0, uint32_t fst1) \
-{                                                                  \
-    uint32_t wt2;                                                  \
-                                                                   \
-    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);\
-    update_fcr31(env, GETPC());                                    \
-    return wt2;                                                    \
-}                                                                  \
-                                                                   \
-uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
-                                      uint64_t fdt0,               \
-                                      uint64_t fdt1)               \
-{                                                                  \
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;                             \
-    uint32_t fsth0 = fdt0 >> 32;                                   \
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;                             \
-    uint32_t fsth1 = fdt1 >> 32;                                   \
-    uint32_t wt2;                                                  \
-    uint32_t wth2;                                                 \
-                                                                   \
-    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);     \
-    wth2 = float32_ ## name(fsth0, fsth1, &env->active_fpu.fp_status);  \
-    update_fcr31(env, GETPC());                                    \
-    return ((uint64_t)wth2 << 32) | wt2;                           \
-}
-
-FLOAT_BINOP(add)
-FLOAT_BINOP(sub)
-FLOAT_BINOP(mul)
-FLOAT_BINOP(div)
-#undef FLOAT_BINOP
-
-/* MIPS specific binary operations */
-uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-{
-    fdt2 = float64_mul(fdt0, fdt2, &env->active_fpu.fp_status);
-    fdt2 = float64_chs(float64_sub(fdt2, float64_one,
-                                   &env->active_fpu.fp_status));
-    update_fcr31(env, GETPC());
-    return fdt2;
-}
-
-uint32_t helper_float_recip2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
-{
-    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_sub(fst2, float32_one,
-                                       &env->active_fpu.fp_status));
-    update_fcr31(env, GETPC());
-    return fst2;
-}
-
-uint64_t helper_float_recip2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-{
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
-    uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst2 = fdt2 & 0XFFFFFFFF;
-    uint32_t fsth2 = fdt2 >> 32;
-
-    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
-    fsth2 = float32_mul(fsth0, fsth2, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_sub(fst2, float32_one,
-                                       &env->active_fpu.fp_status));
-    fsth2 = float32_chs(float32_sub(fsth2, float32_one,
-                                       &env->active_fpu.fp_status));
-    update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
-}
-
-uint64_t helper_float_rsqrt2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-{
-    fdt2 = float64_mul(fdt0, fdt2, &env->active_fpu.fp_status);
-    fdt2 = float64_sub(fdt2, float64_one, &env->active_fpu.fp_status);
-    fdt2 = float64_chs(float64_div(fdt2, FLOAT_TWO64,
-                                       &env->active_fpu.fp_status));
-    update_fcr31(env, GETPC());
-    return fdt2;
-}
-
-uint32_t helper_float_rsqrt2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
-{
-    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
-    fst2 = float32_sub(fst2, float32_one, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_div(fst2, FLOAT_TWO32,
-                                       &env->active_fpu.fp_status));
-    update_fcr31(env, GETPC());
-    return fst2;
-}
-
-uint64_t helper_float_rsqrt2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-{
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
-    uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst2 = fdt2 & 0XFFFFFFFF;
-    uint32_t fsth2 = fdt2 >> 32;
-
-    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
-    fsth2 = float32_mul(fsth0, fsth2, &env->active_fpu.fp_status);
-    fst2 = float32_sub(fst2, float32_one, &env->active_fpu.fp_status);
-    fsth2 = float32_sub(fsth2, float32_one, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_div(fst2, FLOAT_TWO32,
-                                       &env->active_fpu.fp_status));
-    fsth2 = float32_chs(float32_div(fsth2, FLOAT_TWO32,
-                                       &env->active_fpu.fp_status));
-    update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
-}
-
-uint64_t helper_float_addr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
-{
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
-    uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;
-    uint32_t fsth1 = fdt1 >> 32;
-    uint32_t fst2;
-    uint32_t fsth2;
-
-    fst2 = float32_add(fst0, fsth0, &env->active_fpu.fp_status);
-    fsth2 = float32_add(fst1, fsth1, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
-}
-
-uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
-{
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
-    uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;
-    uint32_t fsth1 = fdt1 >> 32;
-    uint32_t fst2;
-    uint32_t fsth2;
-
-    fst2 = float32_mul(fst0, fsth0, &env->active_fpu.fp_status);
-    fsth2 = float32_mul(fst1, fsth1, &env->active_fpu.fp_status);
-    update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
-}
-
-#define FLOAT_MINMAX(name, bits, minmaxfunc)                            \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
-                                         uint ## bits ## _t fs,         \
-                                         uint ## bits ## _t ft)         \
-{                                                                       \
-    uint ## bits ## _t fdret;                                           \
-                                                                        \
-    fdret = float ## bits ## _ ## minmaxfunc(fs, ft,                    \
-                                           &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                         \
-    return fdret;                                                       \
-}
-
-FLOAT_MINMAX(max_s, 32, maxnum)
-FLOAT_MINMAX(max_d, 64, maxnum)
-FLOAT_MINMAX(maxa_s, 32, maxnummag)
-FLOAT_MINMAX(maxa_d, 64, maxnummag)
-
-FLOAT_MINMAX(min_s, 32, minnum)
-FLOAT_MINMAX(min_d, 64, minnum)
-FLOAT_MINMAX(mina_s, 32, minnummag)
-FLOAT_MINMAX(mina_d, 64, minnummag)
-#undef FLOAT_MINMAX
-
-/* ternary operations */
-#define UNFUSED_FMA(prefix, a, b, c, flags)                          \
-{                                                                    \
-    a = prefix##_mul(a, b, &env->active_fpu.fp_status);              \
-    if ((flags) & float_muladd_negate_c) {                           \
-        a = prefix##_sub(a, c, &env->active_fpu.fp_status);          \
-    } else {                                                         \
-        a = prefix##_add(a, c, &env->active_fpu.fp_status);          \
-    }                                                                \
-    if ((flags) & float_muladd_negate_result) {                      \
-        a = prefix##_chs(a);                                         \
-    }                                                                \
-}
-
-/* FMA based operations */
-#define FLOAT_FMA(name, type)                                        \
-uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,              \
-                                     uint64_t fdt0, uint64_t fdt1,   \
-                                     uint64_t fdt2)                  \
-{                                                                    \
-    UNFUSED_FMA(float64, fdt0, fdt1, fdt2, type);                    \
-    update_fcr31(env, GETPC());                                      \
-    return fdt0;                                                     \
-}                                                                    \
-                                                                     \
-uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,              \
-                                     uint32_t fst0, uint32_t fst1,   \
-                                     uint32_t fst2)                  \
-{                                                                    \
-    UNFUSED_FMA(float32, fst0, fst1, fst2, type);                    \
-    update_fcr31(env, GETPC());                                      \
-    return fst0;                                                     \
-}                                                                    \
-                                                                     \
-uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,             \
-                                      uint64_t fdt0, uint64_t fdt1,  \
-                                      uint64_t fdt2)                 \
-{                                                                    \
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;                               \
-    uint32_t fsth0 = fdt0 >> 32;                                     \
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;                               \
-    uint32_t fsth1 = fdt1 >> 32;                                     \
-    uint32_t fst2 = fdt2 & 0XFFFFFFFF;                               \
-    uint32_t fsth2 = fdt2 >> 32;                                     \
-                                                                     \
-    UNFUSED_FMA(float32, fst0, fst1, fst2, type);                    \
-    UNFUSED_FMA(float32, fsth0, fsth1, fsth2, type);                 \
-    update_fcr31(env, GETPC());                                      \
-    return ((uint64_t)fsth0 << 32) | fst0;                           \
-}
-FLOAT_FMA(madd, 0)
-FLOAT_FMA(msub, float_muladd_negate_c)
-FLOAT_FMA(nmadd, float_muladd_negate_result)
-FLOAT_FMA(nmsub, float_muladd_negate_result | float_muladd_negate_c)
-#undef FLOAT_FMA
-
-#define FLOAT_FMADDSUB(name, bits, muladd_arg)                          \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
-                                         uint ## bits ## _t fs,         \
-                                         uint ## bits ## _t ft,         \
-                                         uint ## bits ## _t fd)         \
-{                                                                       \
-    uint ## bits ## _t fdret;                                           \
-                                                                        \
-    fdret = float ## bits ## _muladd(fs, ft, fd, muladd_arg,            \
-                                     &env->active_fpu.fp_status);       \
-    update_fcr31(env, GETPC());                                         \
-    return fdret;                                                       \
-}
-
-FLOAT_FMADDSUB(maddf_s, 32, 0)
-FLOAT_FMADDSUB(maddf_d, 64, 0)
-FLOAT_FMADDSUB(msubf_s, 32, float_muladd_negate_product)
-FLOAT_FMADDSUB(msubf_d, 64, float_muladd_negate_product)
-#undef FLOAT_FMADDSUB
-
-/* compare operations */
-#define FOP_COND_D(op, cond)                                   \
-void helper_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
-                         uint64_t fdt1, int cc)                \
-{                                                              \
-    int c;                                                     \
-    c = cond;                                                  \
-    update_fcr31(env, GETPC());                                \
-    if (c)                                                     \
-        SET_FP_COND(cc, env->active_fpu);                      \
-    else                                                       \
-        CLEAR_FP_COND(cc, env->active_fpu);                    \
-}                                                              \
-void helper_cmpabs_d_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
-                            uint64_t fdt1, int cc)             \
-{                                                              \
-    int c;                                                     \
-    fdt0 = float64_abs(fdt0);                                  \
-    fdt1 = float64_abs(fdt1);                                  \
-    c = cond;                                                  \
-    update_fcr31(env, GETPC());                                \
-    if (c)                                                     \
-        SET_FP_COND(cc, env->active_fpu);                      \
-    else                                                       \
-        CLEAR_FP_COND(cc, env->active_fpu);                    \
-}
-
-/*
- * NOTE: the comma operator will make "cond" to eval to false,
- * but float64_unordered_quiet() is still called.
- */
-FOP_COND_D(f,    (float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status), 0))
-FOP_COND_D(un,   float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(eq,   float64_eq_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(ueq,  float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                 || float64_eq_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(olt,  float64_lt_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(ult,  float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                 || float64_lt_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(ole,  float64_le_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(ule,  float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                 || float64_le_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-/*
- * NOTE: the comma operator will make "cond" to eval to false,
- * but float64_unordered() is still called.
- */
-FOP_COND_D(sf,   (float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status), 0))
-FOP_COND_D(ngle, float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(seq,  float64_eq(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(ngl,  float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                 || float64_eq(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(lt,   float64_lt(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(nge,  float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                 || float64_lt(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(le,   float64_le(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_D(ngt,  float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                 || float64_le(fdt0, fdt1,
-                                       &env->active_fpu.fp_status))
-
-#define FOP_COND_S(op, cond)                                   \
-void helper_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,     \
-                         uint32_t fst1, int cc)                \
-{                                                              \
-    int c;                                                     \
-    c = cond;                                                  \
-    update_fcr31(env, GETPC());                                \
-    if (c)                                                     \
-        SET_FP_COND(cc, env->active_fpu);                      \
-    else                                                       \
-        CLEAR_FP_COND(cc, env->active_fpu);                    \
-}                                                              \
-void helper_cmpabs_s_ ## op(CPUMIPSState *env, uint32_t fst0,  \
-                            uint32_t fst1, int cc)             \
-{                                                              \
-    int c;                                                     \
-    fst0 = float32_abs(fst0);                                  \
-    fst1 = float32_abs(fst1);                                  \
-    c = cond;                                                  \
-    update_fcr31(env, GETPC());                                \
-    if (c)                                                     \
-        SET_FP_COND(cc, env->active_fpu);                      \
-    else                                                       \
-        CLEAR_FP_COND(cc, env->active_fpu);                    \
-}
-
-/*
- * NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered_quiet() is still called.
- */
-FOP_COND_S(f,    (float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status), 0))
-FOP_COND_S(un,   float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(eq,   float32_eq_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(ueq,  float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                 || float32_eq_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(olt,  float32_lt_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(ult,  float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                 || float32_lt_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(ole,  float32_le_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(ule,  float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                 || float32_le_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-/*
- * NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered() is still called.
- */
-FOP_COND_S(sf,   (float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status), 0))
-FOP_COND_S(ngle, float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(seq,  float32_eq(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(ngl,  float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                 || float32_eq(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(lt,   float32_lt(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(nge,  float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                 || float32_lt(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(le,   float32_le(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_S(ngt,  float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                 || float32_le(fst0, fst1,
-                                       &env->active_fpu.fp_status))
-
-#define FOP_COND_PS(op, condl, condh)                           \
-void helper_cmp_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
-                          uint64_t fdt1, int cc)                \
-{                                                               \
-    uint32_t fst0, fsth0, fst1, fsth1;                          \
-    int ch, cl;                                                 \
-    fst0 = fdt0 & 0XFFFFFFFF;                                   \
-    fsth0 = fdt0 >> 32;                                         \
-    fst1 = fdt1 & 0XFFFFFFFF;                                   \
-    fsth1 = fdt1 >> 32;                                         \
-    cl = condl;                                                 \
-    ch = condh;                                                 \
-    update_fcr31(env, GETPC());                                 \
-    if (cl)                                                     \
-        SET_FP_COND(cc, env->active_fpu);                       \
-    else                                                        \
-        CLEAR_FP_COND(cc, env->active_fpu);                     \
-    if (ch)                                                     \
-        SET_FP_COND(cc + 1, env->active_fpu);                   \
-    else                                                        \
-        CLEAR_FP_COND(cc + 1, env->active_fpu);                 \
-}                                                               \
-void helper_cmpabs_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
-                             uint64_t fdt1, int cc)             \
-{                                                               \
-    uint32_t fst0, fsth0, fst1, fsth1;                          \
-    int ch, cl;                                                 \
-    fst0 = float32_abs(fdt0 & 0XFFFFFFFF);                      \
-    fsth0 = float32_abs(fdt0 >> 32);                            \
-    fst1 = float32_abs(fdt1 & 0XFFFFFFFF);                      \
-    fsth1 = float32_abs(fdt1 >> 32);                            \
-    cl = condl;                                                 \
-    ch = condh;                                                 \
-    update_fcr31(env, GETPC());                                 \
-    if (cl)                                                     \
-        SET_FP_COND(cc, env->active_fpu);                       \
-    else                                                        \
-        CLEAR_FP_COND(cc, env->active_fpu);                     \
-    if (ch)                                                     \
-        SET_FP_COND(cc + 1, env->active_fpu);                   \
-    else                                                        \
-        CLEAR_FP_COND(cc + 1, env->active_fpu);                 \
-}
-
-/*
- * NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered_quiet() is still called.
- */
-FOP_COND_PS(f,    (float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status), 0),
-                  (float32_unordered_quiet(fsth1, fsth0,
-                                       &env->active_fpu.fp_status), 0))
-FOP_COND_PS(un,   float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status),
-                  float32_unordered_quiet(fsth1, fsth0,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(eq,   float32_eq_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_eq_quiet(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(ueq,  float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                  || float32_eq_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_unordered_quiet(fsth1, fsth0,
-                                       &env->active_fpu.fp_status)
-                  || float32_eq_quiet(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(olt,  float32_lt_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_lt_quiet(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(ult,  float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                  || float32_lt_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_unordered_quiet(fsth1, fsth0,
-                                       &env->active_fpu.fp_status)
-                  || float32_lt_quiet(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(ole,  float32_le_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_le_quiet(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(ule,  float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                  || float32_le_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_unordered_quiet(fsth1, fsth0,
-                                       &env->active_fpu.fp_status)
-                  || float32_le_quiet(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-/*
- * NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered() is still called.
- */
-FOP_COND_PS(sf,   (float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status), 0),
-                  (float32_unordered(fsth1, fsth0,
-                                       &env->active_fpu.fp_status), 0))
-FOP_COND_PS(ngle, float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status),
-                  float32_unordered(fsth1, fsth0,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(seq,  float32_eq(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_eq(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(ngl,  float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                  || float32_eq(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_unordered(fsth1, fsth0,
-                                       &env->active_fpu.fp_status)
-                  || float32_eq(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(lt,   float32_lt(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_lt(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(nge,  float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                  || float32_lt(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_unordered(fsth1, fsth0,
-                                       &env->active_fpu.fp_status)
-                  || float32_lt(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(le,   float32_le(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_le(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-FOP_COND_PS(ngt,  float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                  || float32_le(fst0, fst1,
-                                       &env->active_fpu.fp_status),
-                  float32_unordered(fsth1, fsth0,
-                                       &env->active_fpu.fp_status)
-                  || float32_le(fsth0, fsth1,
-                                       &env->active_fpu.fp_status))
-
-/* R6 compare operations */
-#define FOP_CONDN_D(op, cond)                                       \
-uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,   \
-                                uint64_t fdt1)                      \
-{                                                                   \
-    uint64_t c;                                                     \
-    c = cond;                                                       \
-    update_fcr31(env, GETPC());                                     \
-    if (c) {                                                        \
-        return -1;                                                  \
-    } else {                                                        \
-        return 0;                                                   \
-    }                                                               \
-}
-
-/*
- * NOTE: the comma operator will make "cond" to eval to false,
- * but float64_unordered_quiet() is still called.
- */
-FOP_CONDN_D(af,  (float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status), 0))
-FOP_CONDN_D(un,  (float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(eq,  (float64_eq_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(ueq, (float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                 || float64_eq_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(lt,  (float64_lt_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(ult, (float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                 || float64_lt_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(le,  (float64_le_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(ule, (float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                 || float64_le_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-/*
- * NOTE: the comma operator will make "cond" to eval to false,
- * but float64_unordered() is still called.\
- */
-FOP_CONDN_D(saf,  (float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status), 0))
-FOP_CONDN_D(sun,  (float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(seq,  (float64_eq(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(sueq, (float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_eq(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(slt,  (float64_lt(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(sult, (float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_lt(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(sle,  (float64_le(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(sule, (float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_le(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(or,   (float64_le_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_le_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(une,  (float64_unordered_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_lt_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_lt_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(ne,   (float64_lt_quiet(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_lt_quiet(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(sor,  (float64_le(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_le(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(sune, (float64_unordered(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_lt(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_lt(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_D(sne,  (float64_lt(fdt1, fdt0,
-                                       &env->active_fpu.fp_status)
-                   || float64_lt(fdt0, fdt1,
-                                       &env->active_fpu.fp_status)))
-
-#define FOP_CONDN_S(op, cond)                                       \
-uint32_t helper_r6_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,   \
-                                uint32_t fst1)                      \
-{                                                                   \
-    uint64_t c;                                                     \
-    c = cond;                                                       \
-    update_fcr31(env, GETPC());                                     \
-    if (c) {                                                        \
-        return -1;                                                  \
-    } else {                                                        \
-        return 0;                                                   \
-    }                                                               \
-}
-
-/*
- * NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered_quiet() is still called.
- */
-FOP_CONDN_S(af,   (float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status), 0))
-FOP_CONDN_S(un,   (float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(eq,   (float32_eq_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(ueq,  (float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_eq_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(lt,   (float32_lt_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(ult,  (float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_lt_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(le,   (float32_le_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(ule,  (float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_le_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-/*
- * NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered() is still called.
- */
-FOP_CONDN_S(saf,  (float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status), 0))
-FOP_CONDN_S(sun,  (float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(seq,  (float32_eq(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(sueq, (float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_eq(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(slt,  (float32_lt(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(sult, (float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_lt(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(sle,  (float32_le(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(sule, (float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_le(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(or,   (float32_le_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_le_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(une,  (float32_unordered_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_lt_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_lt_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(ne,   (float32_lt_quiet(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_lt_quiet(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(sor,  (float32_le(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_le(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(sune, (float32_unordered(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_lt(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_lt(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
-FOP_CONDN_S(sne,  (float32_lt(fst1, fst0,
-                                       &env->active_fpu.fp_status)
-                   || float32_lt(fst0, fst1,
-                                       &env->active_fpu.fp_status)))
 
 /* MSA */
 /* Data format min and max values */
-- 
2.7.4


