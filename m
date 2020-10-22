Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC3C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E5124248
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E5124248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVhGK-0002Ui-8q
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 16:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kVhDu-00011N-Nj
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 16:30:10 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kVhDq-0001rg-Vg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 16:30:10 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MWBGG-1kuLcf2qug-00XYiZ; Thu, 22 Oct 2020 22:30:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/m68k: Add vmstate definition for M68kCPU
Date: Thu, 22 Oct 2020 22:30:00 +0200
Message-Id: <20201022203000.1922749-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201022203000.1922749-1-laurent@vivier.eu>
References: <20201022203000.1922749-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oO8lQXKEglUfLshXq+2a+KAMqISHzLxsblj20IZNdwYp6bjPAJZ
 Ky3H2Vnm47fYUkBZjmJMiBlEucovTNHhIXyjEe2rt5jZbXMhT7Z2agBzeE9Rzi2IG/GqUfL
 RL5G7NFrrjuIGITfxlER0p/WvlfxaMR8f4/tQskwiQ2zNKHtrLXotpYqrezYye/WtC5TU8k
 JJKsWMUo2J9reaZ5KA3qQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L34txPek1/o=:ZGnAUT5ry10zfAzxrVo8o2
 /UuiswtK7ZveXB6vbnb0gBy8lkXLekTg1CdYCrGlbNsAdsnqFXPtDexLHeNKF5cIZh+lSnB/F
 l+DullxOvREmTTMLItq+n3Ja0XeEaQ3fUV2IzCT68du7LMR2sdBUsR6R0JxjweO9vB0MQMyLi
 gVqn3tUFfigwoC6ae5fzXkulLvLRCnC/P7eJnjTCUrmj8tIQdCS8Lma3WWwgXR7D6DCeXSils
 RWEHXACNlV3f1LLRfs/idJUpT8IfQoJ49dsfqmOp68B0j3JYml5/amOKIyrHh5nxgM9BZoPNc
 j15ewwM+yAIorcSmndUwWs9Gr8X9ap+uPKfemCzhk1KQtO42hbesGGKKv021xzVdisjTiSn50
 pznkrp9AAfzAVBJJ9C6W0X8VkPc4Av4X1fiWfP3cmfCGDbDi7CQzfkbPuSxA/i/Xn3sf96HHA
 ITGot6HyuQ==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 16:30:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h        |   1 +
 target/m68k/cpu.c        | 193 ++++++++++++++++++++++++++++++++++++++-
 target/m68k/fpu_helper.c |  10 +-
 3 files changed, 198 insertions(+), 6 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 9a6f0400fcfe..de5b9875fea3 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -179,6 +179,7 @@ int cpu_m68k_signal_handler(int host_signum, void *pinfo,
 uint32_t cpu_m68k_get_ccr(CPUM68KState *env);
 void cpu_m68k_set_ccr(CPUM68KState *env, uint32_t);
 void cpu_m68k_set_sr(CPUM68KState *env, uint32_t);
+void cpu_m68k_restore_fp_status(CPUM68KState *env);
 void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
 
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 72c545149e9b..b811a0bdde2d 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -260,10 +260,198 @@ static void m68k_cpu_initfn(Object *obj)
     cpu_set_cpustate_pointers(cpu);
 }
 
+#if defined(CONFIG_SOFTMMU)
+static bool fpu_needed(void *opaque)
+{
+    M68kCPU *s = opaque;
+
+    return m68k_feature(&s->env, M68K_FEATURE_CF_FPU) ||
+           m68k_feature(&s->env, M68K_FEATURE_FPU);
+}
+
+typedef struct m68k_FPReg_tmp {
+    FPReg *parent;
+    uint64_t tmp_mant;
+    uint16_t tmp_exp;
+} m68k_FPReg_tmp;
+
+static void cpu_get_fp80(uint64_t *pmant, uint16_t *pexp, floatx80 f)
+{
+    CPU_LDoubleU temp;
+
+    temp.d = f;
+    *pmant = temp.l.lower;
+    *pexp = temp.l.upper;
+}
+
+static floatx80 cpu_set_fp80(uint64_t mant, uint16_t upper)
+{
+    CPU_LDoubleU temp;
+
+    temp.l.upper = upper;
+    temp.l.lower = mant;
+    return temp.d;
+}
+
+static int freg_pre_save(void *opaque)
+{
+    m68k_FPReg_tmp *tmp = opaque;
+
+    cpu_get_fp80(&tmp->tmp_mant, &tmp->tmp_exp, tmp->parent->d);
+
+    return 0;
+}
+
+static int freg_post_load(void *opaque, int version)
+{
+    m68k_FPReg_tmp *tmp = opaque;
+
+    tmp->parent->d = cpu_set_fp80(tmp->tmp_mant, tmp->tmp_exp);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_freg_tmp = {
+    .name = "freg_tmp",
+    .post_load = freg_post_load,
+    .pre_save  = freg_pre_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(tmp_mant, m68k_FPReg_tmp),
+        VMSTATE_UINT16(tmp_exp, m68k_FPReg_tmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_freg = {
+    .name = "freg",
+    .fields = (VMStateField[]) {
+        VMSTATE_WITH_TMP(FPReg, m68k_FPReg_tmp, vmstate_freg_tmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static int fpu_post_load(void *opaque, int version)
+{
+    M68kCPU *s = opaque;
+
+    cpu_m68k_restore_fp_status(&s->env);
+
+    return 0;
+}
+
+const VMStateDescription vmmstate_fpu = {
+    .name = "cpu/fpu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = fpu_needed,
+    .post_load = fpu_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.fpcr, M68kCPU),
+        VMSTATE_UINT32(env.fpsr, M68kCPU),
+        VMSTATE_STRUCT_ARRAY(env.fregs, M68kCPU, 8, 0, vmstate_freg, FPReg),
+        VMSTATE_STRUCT(env.fp_result, M68kCPU, 0, vmstate_freg, FPReg),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool cf_spregs_needed(void *opaque)
+{
+    M68kCPU *s = opaque;
+
+    return m68k_feature(&s->env, M68K_FEATURE_CF_ISA_A);
+}
+
+const VMStateDescription vmstate_cf_spregs = {
+    .name = "cpu/cf_spregs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cf_spregs_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.macc, M68kCPU, 4),
+        VMSTATE_UINT32(env.macsr, M68kCPU),
+        VMSTATE_UINT32(env.mac_mask, M68kCPU),
+        VMSTATE_UINT32(env.rambar0, M68kCPU),
+        VMSTATE_UINT32(env.mbar, M68kCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool cpu_68040_mmu_needed(void *opaque)
+{
+    M68kCPU *s = opaque;
+
+    return m68k_feature(&s->env, M68K_FEATURE_M68040);
+}
+
+const VMStateDescription vmstate_68040_mmu = {
+    .name = "cpu/68040_mmu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpu_68040_mmu_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.mmu.ar, M68kCPU),
+        VMSTATE_UINT32(env.mmu.ssw, M68kCPU),
+        VMSTATE_UINT16(env.mmu.tcr, M68kCPU),
+        VMSTATE_UINT32(env.mmu.urp, M68kCPU),
+        VMSTATE_UINT32(env.mmu.srp, M68kCPU),
+        VMSTATE_BOOL(env.mmu.fault, M68kCPU),
+        VMSTATE_UINT32_ARRAY(env.mmu.ttr, M68kCPU, 4),
+        VMSTATE_UINT32(env.mmu.mmusr, M68kCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool cpu_68040_spregs_needed(void *opaque)
+{
+    M68kCPU *s = opaque;
+
+    return m68k_feature(&s->env, M68K_FEATURE_M68040);
+}
+
+const VMStateDescription vmstate_68040_spregs = {
+    .name = "cpu/68040_spregs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpu_68040_spregs_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.vbr, M68kCPU),
+        VMSTATE_UINT32(env.cacr, M68kCPU),
+        VMSTATE_UINT32(env.sfc, M68kCPU),
+        VMSTATE_UINT32(env.dfc, M68kCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_m68k_cpu = {
     .name = "cpu",
-    .unmigratable = 1,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(env.dregs, M68kCPU, 8),
+        VMSTATE_UINT32_ARRAY(env.aregs, M68kCPU, 8),
+        VMSTATE_UINT32(env.pc, M68kCPU),
+        VMSTATE_UINT32(env.sr, M68kCPU),
+        VMSTATE_INT32(env.current_sp, M68kCPU),
+        VMSTATE_UINT32_ARRAY(env.sp, M68kCPU, 3),
+        VMSTATE_UINT32(env.cc_op, M68kCPU),
+        VMSTATE_UINT32(env.cc_x, M68kCPU),
+        VMSTATE_UINT32(env.cc_n, M68kCPU),
+        VMSTATE_UINT32(env.cc_v, M68kCPU),
+        VMSTATE_UINT32(env.cc_c, M68kCPU),
+        VMSTATE_UINT32(env.cc_z, M68kCPU),
+        VMSTATE_INT32(env.pending_vector, M68kCPU),
+        VMSTATE_INT32(env.pending_level, M68kCPU),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmmstate_fpu,
+        &vmstate_cf_spregs,
+        &vmstate_68040_mmu,
+        &vmstate_68040_spregs,
+        NULL
+    },
 };
+#endif
 
 static void m68k_cpu_class_init(ObjectClass *c, void *data)
 {
@@ -287,13 +475,12 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
 #if defined(CONFIG_SOFTMMU)
     cc->do_transaction_failed = m68k_cpu_transaction_failed;
     cc->get_phys_page_debug = m68k_cpu_get_phys_page_debug;
+    dc->vmsd = &vmstate_m68k_cpu;
 #endif
     cc->disas_set_info = m68k_cpu_disas_set_info;
     cc->tcg_initialize = m68k_tcg_init;
 
     cc->gdb_num_core_regs = 18;
-
-    dc->vmsd = &vmstate_m68k_cpu;
 }
 
 static void m68k_cpu_class_init_cf_core(ObjectClass *c, void *data)
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 9acf60dfd443..797000e7482c 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -135,10 +135,8 @@ static void restore_rounding_mode(CPUM68KState *env)
     }
 }
 
-void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val)
+void cpu_m68k_restore_fp_status(CPUM68KState *env)
 {
-    env->fpcr = val & 0xffff;
-
     if (m68k_feature(env, M68K_FEATURE_CF_FPU)) {
         cf_restore_precision_mode(env);
     } else {
@@ -147,6 +145,12 @@ void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val)
     restore_rounding_mode(env);
 }
 
+void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val)
+{
+    env->fpcr = val & 0xffff;
+    cpu_m68k_restore_fp_status(env);
+}
+
 void HELPER(fitrunc)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     FloatRoundMode rounding_mode = get_float_rounding_mode(&env->fp_status);
-- 
2.26.2


