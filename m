Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0921C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA189205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osbN612X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA189205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAUm-0003kr-0f
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:31:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7K-0007nV-T8
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7J-0007XO-07
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:26 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA7G-0007O9-UK
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:24 -0400
Received: by mail-pl1-x641.google.com with SMTP id ck18so8976349plb.1
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=JNmOMQF2C4v65cP3ursRDIjPJJzVV+t7CMRiefYsRnw=;
	b=osbN612Xe0brBxCXp4yJvp5L6gWqSdOH3Z8a/1ZAj6/RDpoO7JNPfwYhE48o724IBf
	y5PEbW+l+OyymgjJxt2TFR3QHK7Z0mM1GhlF3whswM49/jazo7TiZk0sIZ/3awA/V1lq
	gFX3Y3c+dYfRzFIyzd6frvh6jcf7aixXtrJ58h61k7n44e6WkmYaQQMOZcI3/DVSh5f1
	S5rIVFuVt3xUDQ4vHe1HY4rx7HDd2UlHYIWroFt6Kv1nTUIYOQR0C6NM6Uesuc7nBXrf
	3ilbxpJT4kwjAoAwqR9s2In5VyXw58SYeQCpMCPJhIdB1BFzhWz2JYJ2QlP/jGtTzs4q
	PyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=JNmOMQF2C4v65cP3ursRDIjPJJzVV+t7CMRiefYsRnw=;
	b=s+poWoXOV4Gbhps+EX4EjfkVCSV/yjOG+44JxAmD5tXz+oOc3j0NX16DxbTwUyrOEB
	66ceYhoLIqaGpEuKDZpsolLfTdYHh3ILzUusiE8dxcGxX/JtrSSn7SxarE+wAp29lHmX
	XBjOD5TCIo+tTw8LfZgr+A2m6DEjRUz8YzIFC9xfx27yPitFSzK8E2n7BWXB7ZNBzLwn
	NnIktFDyRULcJKHmqTsDdDSFFc2zJVcXaR4Nx7ayRBiFBaFzdoFZnkKj0rbj+gjCfc8B
	TIAWNKLCCe6JWOs6dcJ/TNf0mebVQynf9H3okyjyAda1QoZRxb3VVerdDbUiqQXouANa
	wM3A==
X-Gm-Message-State: APjAAAUNp7HnnK8lG85fe/ug7wN1SJMoshLJzfyAXyT90Izp0GF3/hZ/
	poSAHH7yzgctMePHzC3ii3OhI6qtJIE=
X-Google-Smtp-Source: APXvYqxJkY912v7GF5WPkk4aSkBTfKB7H9BXlhB2LVSoukegpWhAG9A+tWzcb1OKZW2FSjIAyjYzOQ==
X-Received: by 2002:a17:902:5ac9:: with SMTP id
	g9mr8345941plm.134.1557274040790; 
	Tue, 07 May 2019 17:07:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:31 -0700
Message-Id: <20190508000641.19090-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 29/39] target/unicore32: Use env_cpu,
 env_archcpu
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/unicore32/cpu.h          |  5 -----
 hw/unicore32/puv3.c             |  2 +-
 target/unicore32/helper.c       |  8 ++------
 target/unicore32/op_helper.c    |  2 +-
 target/unicore32/softmmu.c      | 11 ++++-------
 target/unicore32/translate.c    | 26 ++------------------------
 target/unicore32/ucf64_helper.c |  2 +-
 7 files changed, 11 insertions(+), 45 deletions(-)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 22e22345dc..2dd1b34765 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -76,11 +76,6 @@ struct UniCore32CPU {
     CPUUniCore32State env;
 };
 
-static inline UniCore32CPU *uc32_env_get_cpu(CPUUniCore32State *env)
-{
-    return container_of(env, UniCore32CPU, env);
-}
-
 #define ENV_OFFSET offsetof(UniCore32CPU, env)
 
 void uc32_cpu_do_interrupt(CPUState *cpu);
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index b42e600f74..132e6086ee 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -56,7 +56,7 @@ static void puv3_soc_init(CPUUniCore32State *env)
 
     /* Initialize interrupt controller */
     cpu_intc = qemu_allocate_irq(puv3_intc_cpu_handler,
-                                 uc32_env_get_cpu(env), 0);
+                                 env_archcpu(env), 0);
     dev = sysbus_create_simple("puv3_intc", PUV3_INTC_BASE, cpu_intc);
     for (i = 0; i < PUV3_IRQS_NR; i++) {
         irqs[i] = qdev_get_gpio_in(dev, i);
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index a5ff2ddb74..19ba865482 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -31,8 +31,6 @@
 void helper_cp0_set(CPUUniCore32State *env, uint32_t val, uint32_t creg,
         uint32_t cop)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-
     /*
      * movc pp.nn, rn, #imm9
      *      rn: UCOP_REG_D
@@ -101,7 +99,7 @@ void helper_cp0_set(CPUUniCore32State *env, uint32_t val, uint32_t creg,
     case 6:
         if ((cop <= 6) && (cop >= 2)) {
             /* invalid all tlb */
-            tlb_flush(CPU(cpu));
+            tlb_flush(env_cpu(env));
             return;
         }
         break;
@@ -218,10 +216,8 @@ void helper_cp1_putc(target_ulong x)
 #ifdef CONFIG_USER_ONLY
 void switch_mode(CPUUniCore32State *env, int mode)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-
     if (mode != ASR_MODE_USER) {
-        cpu_abort(CPU(cpu), "Tried to switch out of user mode\n");
+        cpu_abort(env_cpu(env), "Tried to switch out of user mode\n");
     }
 }
 
diff --git a/target/unicore32/op_helper.c b/target/unicore32/op_helper.c
index e0a15882d3..44ff84420e 100644
--- a/target/unicore32/op_helper.c
+++ b/target/unicore32/op_helper.c
@@ -19,7 +19,7 @@
 
 void HELPER(exception)(CPUUniCore32State *env, uint32_t excp)
 {
-    CPUState *cs = CPU(uc32_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     cpu_loop_exit(cs);
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index 00c7e0d028..2f31592faf 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -36,8 +36,6 @@
 /* Map CPU modes onto saved register banks.  */
 static inline int bank_number(CPUUniCore32State *env, int mode)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-
     switch (mode) {
     case ASR_MODE_USER:
     case ASR_MODE_SUSR:
@@ -51,7 +49,7 @@ static inline int bank_number(CPUUniCore32State *env, int mode)
     case ASR_MODE_INTR:
         return 4;
     }
-    cpu_abort(CPU(cpu), "Bad mode %x\n", mode);
+    cpu_abort(env_cpu(env), "Bad mode %x\n", mode);
     return -1;
 }
 
@@ -126,8 +124,7 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
         int access_type, int is_user, uint32_t *phys_ptr, int *prot,
         target_ulong *page_size)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
     int code;
     uint32_t table;
     uint32_t desc;
@@ -174,11 +171,11 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
             *page_size = TARGET_PAGE_SIZE;
             break;
         default:
-            cpu_abort(CPU(cpu), "wrong page type!");
+            cpu_abort(cs, "wrong page type!");
         }
         break;
     default:
-        cpu_abort(CPU(cpu), "wrong page type!");
+        cpu_abort(cs, "wrong page type!");
     }
 
     *phys_ptr = phys_addr;
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 89b02d1c3c..d27451eed3 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -180,7 +180,7 @@ static void store_reg(DisasContext *s, int reg, TCGv var)
 #define UCOP_SET_L              UCOP_SET(24)
 #define UCOP_SET_S              UCOP_SET(24)
 
-#define ILLEGAL         cpu_abort(CPU(cpu),                             \
+#define ILLEGAL         cpu_abort(env_cpu(env),                         \
                         "Illegal UniCore32 instruction %x at line %d!", \
                         insn, __LINE__)
 
@@ -188,7 +188,6 @@ static void store_reg(DisasContext *s, int reg, TCGv var)
 static void disas_cp0_insn(CPUUniCore32State *env, DisasContext *s,
         uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     TCGv tmp, tmp2, tmp3;
     if ((insn & 0xfe000000) == 0xe0000000) {
         tmp2 = new_tmp();
@@ -214,7 +213,6 @@ static void disas_cp0_insn(CPUUniCore32State *env, DisasContext *s,
 static void disas_ocd_insn(CPUUniCore32State *env, DisasContext *s,
         uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     TCGv tmp;
 
     if ((insn & 0xff003fff) == 0xe1000400) {
@@ -682,7 +680,6 @@ static inline long ucf64_reg_offset(int reg)
 /* UniCore-F64 single load/store I_offset */
 static void do_ucf64_ldst_i(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     int offset;
     TCGv tmp;
     TCGv addr;
@@ -729,7 +726,6 @@ static void do_ucf64_ldst_i(CPUUniCore32State *env, DisasContext *s, uint32_t in
 /* UniCore-F64 load/store multiple words */
 static void do_ucf64_ldst_m(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     unsigned int i;
     int j, n, freg;
     TCGv tmp;
@@ -815,7 +811,6 @@ static void do_ucf64_ldst_m(CPUUniCore32State *env, DisasContext *s, uint32_t in
 /* UniCore-F64 mrc/mcr */
 static void do_ucf64_trans(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     TCGv tmp;
 
     if ((insn & 0xfe0003ff) == 0xe2000000) {
@@ -880,8 +875,6 @@ static void do_ucf64_trans(CPUUniCore32State *env, DisasContext *s, uint32_t ins
 /* UniCore-F64 convert instructions */
 static void do_ucf64_fcvt(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-
     if (UCOP_UCF64_FMT == 3) {
         ILLEGAL;
     }
@@ -948,8 +941,6 @@ static void do_ucf64_fcvt(CPUUniCore32State *env, DisasContext *s, uint32_t insn
 /* UniCore-F64 compare instructions */
 static void do_ucf64_fcmp(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-
     if (UCOP_SET(25)) {
         ILLEGAL;
     }
@@ -1028,8 +1019,6 @@ static void do_ucf64_fcmp(CPUUniCore32State *env, DisasContext *s, uint32_t insn
 /* UniCore-F64 data processing */
 static void do_ucf64_datap(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-
     if (UCOP_UCF64_FMT == 3) {
         ILLEGAL;
     }
@@ -1063,8 +1052,6 @@ static void do_ucf64_datap(CPUUniCore32State *env, DisasContext *s, uint32_t ins
 /* Disassemble an F64 instruction */
 static void disas_ucf64_insn(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-
     if (!UCOP_SET(29)) {
         if (UCOP_SET(26)) {
             do_ucf64_ldst_m(env, s, insn);
@@ -1162,8 +1149,6 @@ static void gen_exception_return(DisasContext *s, TCGv pc)
 static void disas_coproc_insn(CPUUniCore32State *env, DisasContext *s,
         uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-
     switch (UCOP_CPNUM) {
 #ifndef CONFIG_USER_ONLY
     case 0:
@@ -1178,14 +1163,13 @@ static void disas_coproc_insn(CPUUniCore32State *env, DisasContext *s,
         break;
     default:
         /* Unknown coprocessor. */
-        cpu_abort(CPU(cpu), "Unknown coprocessor!");
+        cpu_abort(env_cpu(env), "Unknown coprocessor!");
     }
 }
 
 /* data processing instructions */
 static void do_datap(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     TCGv tmp;
     TCGv tmp2;
     int logic_cc;
@@ -1419,7 +1403,6 @@ static void do_mult(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 /* miscellaneous instructions */
 static void do_misc(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     unsigned int val;
     TCGv tmp;
 
@@ -1545,7 +1528,6 @@ static void do_ldst_ir(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 /* SWP instruction */
 static void do_swap(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     TCGv addr;
     TCGv tmp;
     TCGv tmp2;
@@ -1573,7 +1555,6 @@ static void do_swap(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 /* load/store hw/sb */
 static void do_ldst_hwsb(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     TCGv addr;
     TCGv tmp;
 
@@ -1626,7 +1607,6 @@ static void do_ldst_hwsb(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 /* load/store multiple words */
 static void do_ldst_m(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     unsigned int val, i, mmu_idx;
     int j, n, reg, user, loaded_base;
     TCGv tmp;
@@ -1768,7 +1748,6 @@ static void do_ldst_m(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 /* branch (and link) */
 static void do_branch(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     unsigned int val;
     int32_t offset;
     TCGv tmp;
@@ -1798,7 +1777,6 @@ static void do_branch(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 
 static void disas_uc32_insn(CPUUniCore32State *env, DisasContext *s)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
     unsigned int insn;
 
     insn = cpu_ldl_code(env, s->pc);
diff --git a/target/unicore32/ucf64_helper.c b/target/unicore32/ucf64_helper.c
index fad3fa6618..e078e84437 100644
--- a/target/unicore32/ucf64_helper.c
+++ b/target/unicore32/ucf64_helper.c
@@ -78,7 +78,7 @@ static inline int ucf64_exceptbits_to_host(int target_bits)
 
 void HELPER(ucf64_set_fpscr)(CPUUniCore32State *env, uint32_t val)
 {
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
+    UniCore32CPU *cpu = env_archcpu(env);
     int i;
     uint32_t changed;
 
-- 
2.17.1


