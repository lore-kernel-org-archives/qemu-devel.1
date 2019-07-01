Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6EC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D41720652
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLA9/CUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D41720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi6Xs-0002Ug-6a
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 20:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47733)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3zt-00020G-Pr
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3zr-0003Ai-Pq
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:38:01 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3zn-00033o-1I
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:37:55 -0400
Received: by mail-wr1-f54.google.com with SMTP id n9so15432818wru.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QjlnPd48sl1+3JCPnbga36CM99PsIZY1yldEsKZ9V/s=;
 b=qLA9/CUUaOTb1wH5mfGLt9H6r4N3oWvUJBOMCPBv4cSMAZgMfdDFI246E1lj3bg4qi
 LzzuUmQbZ9VUPsTh/EHPwJ6lCaZhYVkPEK3amu0WlUQ8JykxCY8ZMfuvWF4JgCX6D7GD
 ZPAv+CmVPTD37JkyL/JT6AWrME1jsqVvAY7m4J3i4MWdKvIHVntXoY19wek2aWQizdtE
 2H2tev56MSTtIY/GENqvSzO/2iCTqw9Ofovp1blwDTqJN4Q132OXwu+wZAWPfA17v9UA
 tLQZ9QZLEXZjxhriyD5b8gj/Ael0+0/nOz3TOjUhFl8QdyOHRxubuEYPIdr+ydLChoJ/
 +yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QjlnPd48sl1+3JCPnbga36CM99PsIZY1yldEsKZ9V/s=;
 b=JFRDtIWoUK8W6uP559lNSttWzkSIAwAaEGFsHDS4P9p4l8DjoinVDN7MEPUWityV+W
 CUnrLOE3JF3ho034LTbEDjHtBVfULBoKLhH0LD6zSYJpR9jjNSbf5BEMKeOvClzdnMMk
 WZWamjTb873HjTYieQPBhZVq9LDeg3f542bCfjmuEp+HA5QntwGg6j/rJkWS5SfO2UiB
 qy9E0yBMszJxf9XZCGSpSVlBadtT765N39+dC/pz/N64WeiDQGqeJGX1u4fniKjmKkbz
 qCeY3LgPbf1ja73z1qVqwNRF1Hc3hUfTDaTvuJGg+QCE+24QrJHIfXNtZkbqkz+nQ6AT
 RTBg==
X-Gm-Message-State: APjAAAXlsOAmNfq1L0Xi6nLawxpCd/mFtJpxQNyAYBfkUUcw70yXayOV
 79iyJjvoseVUJ6qOUNpsSGdItz4W1+z9Xw==
X-Google-Smtp-Source: APXvYqwAUmliO3baf1R6T0bwSsv2gAr7+JATUvA/ATX1o6zQlf6EYSV/BOZE4k1Lcx1tptbO35A4hQ==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr19881462wrl.212.1561999227148; 
 Mon, 01 Jul 2019 09:40:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:34 +0100
Message-Id: <20190701163943.22313-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.54
Subject: [Qemu-devel] [PULL 37/46] target/arm: Move CPU state dumping
 routines to cpu.c
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-11-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |   2 -
 target/arm/translate.h     |   5 -
 target/arm/cpu.c           | 226 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 128 ---------------------
 target/arm/translate.c     |  88 ---------------
 5 files changed, 226 insertions(+), 223 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f9da672be57..a9be18660fd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -929,8 +929,6 @@ void arm_cpu_do_interrupt(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
-void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags);
-
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 
diff --git a/target/arm/translate.h b/target/arm/translate.h
index bc1617809da..a20f6e20568 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -169,7 +169,6 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
 void gen_a64_set_pc_im(uint64_t val);
-void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 extern const TranslatorOps aarch64_translator_ops;
 #else
 static inline void a64_translate_init(void)
@@ -179,10 +178,6 @@ static inline void a64_translate_init(void)
 static inline void gen_a64_set_pc_im(uint64_t val)
 {
 }
-
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-}
 #endif
 
 void arm_test_cc(DisasCompare *cmp, int cc);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 376db154f00..1f73631bac0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/qemu-print.h"
 #include "qemu-common.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
@@ -676,6 +677,231 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
+#ifdef TARGET_AARCH64
+
+static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    uint32_t psr = pstate_read(env);
+    int i;
+    int el = arm_current_el(env);
+    const char *ns_status;
+
+    qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
+    for (i = 0; i < 32; i++) {
+        if (i == 31) {
+            qemu_fprintf(f, " SP=%016" PRIx64 "\n", env->xregs[i]);
+        } else {
+            qemu_fprintf(f, "X%02d=%016" PRIx64 "%s", i, env->xregs[i],
+                         (i + 2) % 3 ? " " : "\n");
+        }
+    }
+
+    if (arm_feature(env, ARM_FEATURE_EL3) && el != 3) {
+        ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+    } else {
+        ns_status = "";
+    }
+    qemu_fprintf(f, "PSTATE=%08x %c%c%c%c %sEL%d%c",
+                 psr,
+                 psr & PSTATE_N ? 'N' : '-',
+                 psr & PSTATE_Z ? 'Z' : '-',
+                 psr & PSTATE_C ? 'C' : '-',
+                 psr & PSTATE_V ? 'V' : '-',
+                 ns_status,
+                 el,
+                 psr & PSTATE_SP ? 'h' : 't');
+
+    if (cpu_isar_feature(aa64_bti, cpu)) {
+        qemu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
+    }
+    if (!(flags & CPU_DUMP_FPU)) {
+        qemu_fprintf(f, "\n");
+        return;
+    }
+    if (fp_exception_el(env, el) != 0) {
+        qemu_fprintf(f, "    FPU disabled\n");
+        return;
+    }
+    qemu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
+                 vfp_get_fpcr(env), vfp_get_fpsr(env));
+
+    if (cpu_isar_feature(aa64_sve, cpu) && sve_exception_el(env, el) == 0) {
+        int j, zcr_len = sve_zcr_len_for_el(env, el);
+
+        for (i = 0; i <= FFR_PRED_NUM; i++) {
+            bool eol;
+            if (i == FFR_PRED_NUM) {
+                qemu_fprintf(f, "FFR=");
+                /* It's last, so end the line.  */
+                eol = true;
+            } else {
+                qemu_fprintf(f, "P%02d=", i);
+                switch (zcr_len) {
+                case 0:
+                    eol = i % 8 == 7;
+                    break;
+                case 1:
+                    eol = i % 6 == 5;
+                    break;
+                case 2:
+                case 3:
+                    eol = i % 3 == 2;
+                    break;
+                default:
+                    /* More than one quadword per predicate.  */
+                    eol = true;
+                    break;
+                }
+            }
+            for (j = zcr_len / 4; j >= 0; j--) {
+                int digits;
+                if (j * 4 + 4 <= zcr_len + 1) {
+                    digits = 16;
+                } else {
+                    digits = (zcr_len % 4 + 1) * 4;
+                }
+                qemu_fprintf(f, "%0*" PRIx64 "%s", digits,
+                             env->vfp.pregs[i].p[j],
+                             j ? ":" : eol ? "\n" : " ");
+            }
+        }
+
+        for (i = 0; i < 32; i++) {
+            if (zcr_len == 0) {
+                qemu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64 "%s",
+                             i, env->vfp.zregs[i].d[1],
+                             env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ");
+            } else if (zcr_len == 1) {
+                qemu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64
+                             ":%016" PRIx64 ":%016" PRIx64 "\n",
+                             i, env->vfp.zregs[i].d[3], env->vfp.zregs[i].d[2],
+                             env->vfp.zregs[i].d[1], env->vfp.zregs[i].d[0]);
+            } else {
+                for (j = zcr_len; j >= 0; j--) {
+                    bool odd = (zcr_len - j) % 2 != 0;
+                    if (j == zcr_len) {
+                        qemu_fprintf(f, "Z%02d[%x-%x]=", i, j, j - 1);
+                    } else if (!odd) {
+                        if (j > 0) {
+                            qemu_fprintf(f, "   [%x-%x]=", j, j - 1);
+                        } else {
+                            qemu_fprintf(f, "     [%x]=", j);
+                        }
+                    }
+                    qemu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
+                                 env->vfp.zregs[i].d[j * 2 + 1],
+                                 env->vfp.zregs[i].d[j * 2],
+                                 odd || j == 0 ? "\n" : ":");
+                }
+            }
+        }
+    } else {
+        for (i = 0; i < 32; i++) {
+            uint64_t *q = aa64_vfp_qreg(env, i);
+            qemu_fprintf(f, "Q%02d=%016" PRIx64 ":%016" PRIx64 "%s",
+                         i, q[1], q[0], (i & 1 ? "\n" : " "));
+        }
+    }
+}
+
+#else
+
+static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+{
+    g_assert_not_reached();
+}
+
+#endif
+
+static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    int i;
+
+    if (is_a64(env)) {
+        aarch64_cpu_dump_state(cs, f, flags);
+        return;
+    }
+
+    for (i = 0; i < 16; i++) {
+        qemu_fprintf(f, "R%02d=%08x", i, env->regs[i]);
+        if ((i % 4) == 3) {
+            qemu_fprintf(f, "\n");
+        } else {
+            qemu_fprintf(f, " ");
+        }
+    }
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        uint32_t xpsr = xpsr_read(env);
+        const char *mode;
+        const char *ns_status = "";
+
+        if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+            ns_status = env->v7m.secure ? "S " : "NS ";
+        }
+
+        if (xpsr & XPSR_EXCP) {
+            mode = "handler";
+        } else {
+            if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_NPRIV_MASK) {
+                mode = "unpriv-thread";
+            } else {
+                mode = "priv-thread";
+            }
+        }
+
+        qemu_fprintf(f, "XPSR=%08x %c%c%c%c %c %s%s\n",
+                     xpsr,
+                     xpsr & XPSR_N ? 'N' : '-',
+                     xpsr & XPSR_Z ? 'Z' : '-',
+                     xpsr & XPSR_C ? 'C' : '-',
+                     xpsr & XPSR_V ? 'V' : '-',
+                     xpsr & XPSR_T ? 'T' : 'A',
+                     ns_status,
+                     mode);
+    } else {
+        uint32_t psr = cpsr_read(env);
+        const char *ns_status = "";
+
+        if (arm_feature(env, ARM_FEATURE_EL3) &&
+            (psr & CPSR_M) != ARM_CPU_MODE_MON) {
+            ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+        }
+
+        qemu_fprintf(f, "PSR=%08x %c%c%c%c %c %s%s%d\n",
+                     psr,
+                     psr & CPSR_N ? 'N' : '-',
+                     psr & CPSR_Z ? 'Z' : '-',
+                     psr & CPSR_C ? 'C' : '-',
+                     psr & CPSR_V ? 'V' : '-',
+                     psr & CPSR_T ? 'T' : 'A',
+                     ns_status,
+                     aarch32_mode_name(psr), (psr & 0x10) ? 32 : 26);
+    }
+
+    if (flags & CPU_DUMP_FPU) {
+        int numvfpregs = 0;
+        if (arm_feature(env, ARM_FEATURE_VFP)) {
+            numvfpregs += 16;
+        }
+        if (arm_feature(env, ARM_FEATURE_VFP3)) {
+            numvfpregs += 16;
+        }
+        for (i = 0; i < numvfpregs; i++) {
+            uint64_t v = *aa32_vfp_dreg(env, i);
+            qemu_fprintf(f, "s%02d=%08x s%02d=%08x d%02d=%016" PRIx64 "\n",
+                         i * 2, (uint32_t)v,
+                         i * 2 + 1, (uint32_t)(v >> 32),
+                         i, v);
+        }
+        qemu_fprintf(f, "FPSCR: %08x\n", vfp_get_fpscr(env));
+    }
+}
+
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
 {
     uint32_t Aff1 = idx / clustersz;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 97f4164fbbc..d3231477a27 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -27,7 +27,6 @@
 #include "translate.h"
 #include "internals.h"
 #include "qemu/host-utils.h"
-#include "qemu/qemu-print.h"
 
 #include "hw/semihosting/semihost.h"
 #include "exec/gen-icount.h"
@@ -152,133 +151,6 @@ static void set_btype(DisasContext *s, int val)
     s->btype = -1;
 }
 
-void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    uint32_t psr = pstate_read(env);
-    int i;
-    int el = arm_current_el(env);
-    const char *ns_status;
-
-    qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
-    for (i = 0; i < 32; i++) {
-        if (i == 31) {
-            qemu_fprintf(f, " SP=%016" PRIx64 "\n", env->xregs[i]);
-        } else {
-            qemu_fprintf(f, "X%02d=%016" PRIx64 "%s", i, env->xregs[i],
-                         (i + 2) % 3 ? " " : "\n");
-        }
-    }
-
-    if (arm_feature(env, ARM_FEATURE_EL3) && el != 3) {
-        ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
-    } else {
-        ns_status = "";
-    }
-    qemu_fprintf(f, "PSTATE=%08x %c%c%c%c %sEL%d%c",
-                 psr,
-                 psr & PSTATE_N ? 'N' : '-',
-                 psr & PSTATE_Z ? 'Z' : '-',
-                 psr & PSTATE_C ? 'C' : '-',
-                 psr & PSTATE_V ? 'V' : '-',
-                 ns_status,
-                 el,
-                 psr & PSTATE_SP ? 'h' : 't');
-
-    if (cpu_isar_feature(aa64_bti, cpu)) {
-        qemu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
-    }
-    if (!(flags & CPU_DUMP_FPU)) {
-        qemu_fprintf(f, "\n");
-        return;
-    }
-    if (fp_exception_el(env, el) != 0) {
-        qemu_fprintf(f, "    FPU disabled\n");
-        return;
-    }
-    qemu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
-                 vfp_get_fpcr(env), vfp_get_fpsr(env));
-
-    if (cpu_isar_feature(aa64_sve, cpu) && sve_exception_el(env, el) == 0) {
-        int j, zcr_len = sve_zcr_len_for_el(env, el);
-
-        for (i = 0; i <= FFR_PRED_NUM; i++) {
-            bool eol;
-            if (i == FFR_PRED_NUM) {
-                qemu_fprintf(f, "FFR=");
-                /* It's last, so end the line.  */
-                eol = true;
-            } else {
-                qemu_fprintf(f, "P%02d=", i);
-                switch (zcr_len) {
-                case 0:
-                    eol = i % 8 == 7;
-                    break;
-                case 1:
-                    eol = i % 6 == 5;
-                    break;
-                case 2:
-                case 3:
-                    eol = i % 3 == 2;
-                    break;
-                default:
-                    /* More than one quadword per predicate.  */
-                    eol = true;
-                    break;
-                }
-            }
-            for (j = zcr_len / 4; j >= 0; j--) {
-                int digits;
-                if (j * 4 + 4 <= zcr_len + 1) {
-                    digits = 16;
-                } else {
-                    digits = (zcr_len % 4 + 1) * 4;
-                }
-                qemu_fprintf(f, "%0*" PRIx64 "%s", digits,
-                             env->vfp.pregs[i].p[j],
-                             j ? ":" : eol ? "\n" : " ");
-            }
-        }
-
-        for (i = 0; i < 32; i++) {
-            if (zcr_len == 0) {
-                qemu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64 "%s",
-                             i, env->vfp.zregs[i].d[1],
-                             env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ");
-            } else if (zcr_len == 1) {
-                qemu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64
-                             ":%016" PRIx64 ":%016" PRIx64 "\n",
-                             i, env->vfp.zregs[i].d[3], env->vfp.zregs[i].d[2],
-                             env->vfp.zregs[i].d[1], env->vfp.zregs[i].d[0]);
-            } else {
-                for (j = zcr_len; j >= 0; j--) {
-                    bool odd = (zcr_len - j) % 2 != 0;
-                    if (j == zcr_len) {
-                        qemu_fprintf(f, "Z%02d[%x-%x]=", i, j, j - 1);
-                    } else if (!odd) {
-                        if (j > 0) {
-                            qemu_fprintf(f, "   [%x-%x]=", j, j - 1);
-                        } else {
-                            qemu_fprintf(f, "     [%x]=", j);
-                        }
-                    }
-                    qemu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
-                                 env->vfp.zregs[i].d[j * 2 + 1],
-                                 env->vfp.zregs[i].d[j * 2],
-                                 odd || j == 0 ? "\n" : ":");
-                }
-            }
-        }
-    } else {
-        for (i = 0; i < 32; i++) {
-            uint64_t *q = aa64_vfp_qreg(env, i);
-            qemu_fprintf(f, "Q%02d=%016" PRIx64 ":%016" PRIx64 "%s",
-                         i, q[1], q[0], (i & 1 ? "\n" : " "));
-        }
-    }
-}
-
 void gen_a64_set_pc_im(uint64_t val)
 {
     tcg_gen_movi_i64(cpu_pc, val);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c6bdf026b45..a5d77234232 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -28,7 +28,6 @@
 #include "tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
-#include "qemu/qemu-print.h"
 #include "arm_ldst.h"
 #include "hw/semihosting/semihost.h"
 
@@ -12342,93 +12341,6 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
     translator_loop(ops, &dc.base, cpu, tb, max_insns);
 }
 
-void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    int i;
-
-    if (is_a64(env)) {
-        aarch64_cpu_dump_state(cs, f, flags);
-        return;
-    }
-
-    for (i = 0; i < 16; i++) {
-        qemu_fprintf(f, "R%02d=%08x", i, env->regs[i]);
-        if ((i % 4) == 3) {
-            qemu_fprintf(f, "\n");
-        } else {
-            qemu_fprintf(f, " ");
-        }
-    }
-
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        uint32_t xpsr = xpsr_read(env);
-        const char *mode;
-        const char *ns_status = "";
-
-        if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-            ns_status = env->v7m.secure ? "S " : "NS ";
-        }
-
-        if (xpsr & XPSR_EXCP) {
-            mode = "handler";
-        } else {
-            if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_NPRIV_MASK) {
-                mode = "unpriv-thread";
-            } else {
-                mode = "priv-thread";
-            }
-        }
-
-        qemu_fprintf(f, "XPSR=%08x %c%c%c%c %c %s%s\n",
-                     xpsr,
-                     xpsr & XPSR_N ? 'N' : '-',
-                     xpsr & XPSR_Z ? 'Z' : '-',
-                     xpsr & XPSR_C ? 'C' : '-',
-                     xpsr & XPSR_V ? 'V' : '-',
-                     xpsr & XPSR_T ? 'T' : 'A',
-                     ns_status,
-                     mode);
-    } else {
-        uint32_t psr = cpsr_read(env);
-        const char *ns_status = "";
-
-        if (arm_feature(env, ARM_FEATURE_EL3) &&
-            (psr & CPSR_M) != ARM_CPU_MODE_MON) {
-            ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
-        }
-
-        qemu_fprintf(f, "PSR=%08x %c%c%c%c %c %s%s%d\n",
-                     psr,
-                     psr & CPSR_N ? 'N' : '-',
-                     psr & CPSR_Z ? 'Z' : '-',
-                     psr & CPSR_C ? 'C' : '-',
-                     psr & CPSR_V ? 'V' : '-',
-                     psr & CPSR_T ? 'T' : 'A',
-                     ns_status,
-                     aarch32_mode_name(psr), (psr & 0x10) ? 32 : 26);
-    }
-
-    if (flags & CPU_DUMP_FPU) {
-        int numvfpregs = 0;
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
-            numvfpregs += 16;
-        }
-        if (arm_feature(env, ARM_FEATURE_VFP3)) {
-            numvfpregs += 16;
-        }
-        for (i = 0; i < numvfpregs; i++) {
-            uint64_t v = *aa32_vfp_dreg(env, i);
-            qemu_fprintf(f, "s%02d=%08x s%02d=%08x d%02d=%016" PRIx64 "\n",
-                         i * 2, (uint32_t)v,
-                         i * 2 + 1, (uint32_t)(v >> 32),
-                         i, v);
-        }
-        qemu_fprintf(f, "FPSCR: %08x\n", vfp_get_fpscr(env));
-    }
-}
-
 void restore_state_to_opc(CPUARMState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
-- 
2.20.1


