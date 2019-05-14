Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ABDC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F085720879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlkZZMZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F085720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54188 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQed4-000582-8Y
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:06:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeV2-0007lu-NN
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeIl-0007cB-2f
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:32 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hQeIk-0007Vb-Nq
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:31 -0400
Received: by mail-lf1-x144.google.com with SMTP id n22so220195lfe.12
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=FXb6aboJp5Icq+FwNf9gA5rmibu3GFrNef50fwTDTPg=;
	b=KlkZZMZa+q+uA6Pkttf8tc6v+XK1gPv9hxxzCQCNeS1wq2HX5Nd/ARG6xPsy/jvSOs
	JMShqZxtLwB9cAuAaCbc/9426yH768oYn+5s/WVQzH3EoD9nq+f+L7zIGrxrN3TVPF+5
	bs1tpm9lOfWGVQqP3z4rFOIJANKR1azDd2314Ys67WbWk5cedP9br/+sW9cdELEoSv35
	jTfsTa/D312obWzPqzQ+mNBVPOZy3mOFpnS/JI+iXX92uGowYyzRfm/QJFuGzZaQjhQz
	pBYgeJJDps6Gk9ySId5pDNLwp+XFyMYkGIhRWu7/gqvi8meKoVyTv9em/17SDh2DqC6m
	pfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=FXb6aboJp5Icq+FwNf9gA5rmibu3GFrNef50fwTDTPg=;
	b=Vb4shJVnK6VqAUFxkMDFQ4KFn4/T7iQa8wmtN5zuKUY9AEYrdasXiv9BEPCxgO7Uwh
	AUNgxL8AmsAvDtmRGyUpFwToX1YQrSl7Ob0i3feiC6+rLUsFvX+7YqVwxdZrpZfcFncJ
	Qc5AKm5PKNJqXI98OqaQiuT7Y4mcJrPwd/OAlvgf35os2miMVg6ifEUIFuKm3/VyrPjI
	hvkut9BIVQTte5gflqkRn5Pa2CjNOLkAQFcSFuW02/rxo+eHYSPo44A8bv58CZiFLfoj
	YkarOo9ysI9ZS9Bif3YQgBZdqtv3i/LCnA3lOeth+BXNse5KiSeE8y2g4fKWQDaZtjo4
	2oiw==
X-Gm-Message-State: APjAAAXHuN4Gr9Q8a2SvVSSkGVI2YScSslCMvjK5Y0gzCB2CTriqtAC6
	m/Ah7AxryFs5X/4fxJ/K8HNM55nNb5A=
X-Google-Smtp-Source: APXvYqxSvg/4cQ1JhSl+358rAsvj4erFdhsGrsS/ACvQ3q0JhGTh2O9PNsETmwmcU+u4kqHGtWI6/g==
X-Received: by 2002:a19:9c8f:: with SMTP id f137mr18065772lfe.94.1557866726555;
	Tue, 14 May 2019 13:45:26 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id 78sm4011lje.81.2019.05.14.13.45.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:45:26 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 13:44:47 -0700
Message-Id: <20190514204447.17486-10-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514204447.17486-1-jcmvbkbc@gmail.com>
References: <20190514204447.17486-1-jcmvbkbc@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: [Qemu-devel] [PATCH 9/9] target/xtensa: implement exclusive access
 option
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Exclusive Instructions provide a general-purpose mechanism for
atomic updates of memory-based synchronization variables that can be
used for exclusion algorithms.

Use cmpxchg-based implementation that is sufficient for the typical use
of exclusive access in atomic operations.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.c               |   1 +
 target/xtensa/cpu.h               |   2 +
 target/xtensa/helper.h            |   1 +
 target/xtensa/op_helper.c         |  42 ++++++++++++++++
 target/xtensa/overlay_tool.h      |   8 ++-
 target/xtensa/translate.c         | 100 ++++++++++++++++++++++++++++++++++++++
 tests/tcg/xtensa/test_exclusive.S |  48 ++++++++++++++++++
 7 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/xtensa/test_exclusive.S

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 4215a1881ec7..54c834228a91 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -82,6 +82,7 @@ static void xtensa_cpu_reset(CPUState *s)
             XTENSA_OPTION_ATOMCTL) ? 0x28 : 0x15;
     env->sregs[CONFIGID0] = env->config->configid[0];
     env->sregs[CONFIGID1] = env->config->configid[1];
+    env->exclusive_addr = -1;
 
 #ifndef CONFIG_USER_ONLY
     reset_mmu(env);
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 8301923e4c4a..28a6fb4d796d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -527,6 +527,8 @@ typedef struct CPUXtensaState {
     } fregs[16];
     float_status fp_status;
     uint32_t windowbase_next;
+    uint32_t exclusive_addr;
+    uint32_t exclusive_val;
 
 #ifndef CONFIG_USER_ONLY
     xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 9216bee57e9a..8532de0b35f5 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -24,6 +24,7 @@ DEF_HELPER_1(check_interrupts, void, env)
 DEF_HELPER_2(intset, void, env, i32)
 DEF_HELPER_2(intclear, void, env, i32)
 DEF_HELPER_3(check_atomctl, void, env, i32, i32)
+DEF_HELPER_4(check_exclusive, void, env, i32, i32, i32)
 DEF_HELPER_2(wsr_memctl, void, env, i32)
 
 DEF_HELPER_2(itlb_hit_test, void, env, i32)
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 04971b044fac..09f4962d008a 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -130,6 +130,48 @@ void HELPER(check_atomctl)(CPUXtensaState *env, uint32_t pc, uint32_t vaddr)
     }
 }
 
+void HELPER(check_exclusive)(CPUXtensaState *env, uint32_t pc, uint32_t vaddr,
+                             uint32_t is_write)
+{
+    uint32_t paddr, page_size, access;
+    uint32_t atomctl = env->sregs[ATOMCTL];
+    int rc = xtensa_get_physical_addr(env, true, vaddr, is_write,
+                                      xtensa_get_cring(env), &paddr,
+                                      &page_size, &access);
+
+    if (rc) {
+        HELPER(exception_cause_vaddr)(env, pc, rc, vaddr);
+    }
+
+    /* When data cache is not configured use ATOMCTL bypass field. */
+    if (!xtensa_option_enabled(env->config, XTENSA_OPTION_DCACHE)) {
+        access = PAGE_CACHE_BYPASS;
+    }
+
+    switch (access & PAGE_CACHE_MASK) {
+    case PAGE_CACHE_WB:
+        atomctl >>= 2;
+        /* fall through */
+    case PAGE_CACHE_WT:
+        atomctl >>= 2;
+        /* fall through */
+    case PAGE_CACHE_BYPASS:
+        if ((atomctl & 0x3) == 0) {
+            HELPER(exception_cause_vaddr)(env, pc,
+                                          EXCLUSIVE_ERROR_CAUSE, vaddr);
+        }
+        break;
+
+    case PAGE_CACHE_ISOLATE:
+        HELPER(exception_cause_vaddr)(env, pc,
+                LOAD_STORE_ERROR_CAUSE, vaddr);
+        break;
+
+    default:
+        break;
+    }
+}
+
 void HELPER(wsr_memctl)(CPUXtensaState *env, uint32_t v)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_ICACHE)) {
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 4925b21f0edf..f0cc33adfe05 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -76,6 +76,10 @@
 #define XCHAL_HAVE_MPU 0
 #endif
 
+#ifndef XCHAL_HAVE_EXCLUSIVE
+#define XCHAL_HAVE_EXCLUSIVE 0
+#endif
+
 #define XCHAL_OPTION(xchal, qemu) ((xchal) ? XTENSA_OPTION_BIT(qemu) : 0)
 
 #define XTENSA_OPTIONS ( \
@@ -96,8 +100,8 @@
     XCHAL_OPTION(XCHAL_HAVE_FP, XTENSA_OPTION_FP_COPROCESSOR) | \
     XCHAL_OPTION(XCHAL_HAVE_RELEASE_SYNC, XTENSA_OPTION_MP_SYNCHRO) | \
     XCHAL_OPTION(XCHAL_HAVE_S32C1I, XTENSA_OPTION_CONDITIONAL_STORE) | \
-    XCHAL_OPTION(XCHAL_HAVE_S32C1I && XCHAL_HW_MIN_VERSION >= 230000, \
-        XTENSA_OPTION_ATOMCTL) | \
+    XCHAL_OPTION(((XCHAL_HAVE_S32C1I && XCHAL_HW_MIN_VERSION >= 230000) || \
+                  XCHAL_HAVE_EXCLUSIVE), XTENSA_OPTION_ATOMCTL) | \
     XCHAL_OPTION(XCHAL_HAVE_DEPBITS, XTENSA_OPTION_DEPBITS) | \
     /* Interrupts and exceptions */ \
     XCHAL_OPTION(XCHAL_HAVE_EXCEPTIONS, XTENSA_OPTION_EXCEPTION) | \
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 356eb9948701..158a600b4293 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -87,6 +87,8 @@ static TCGv_i32 cpu_BR8[2];
 static TCGv_i32 cpu_SR[256];
 static TCGv_i32 cpu_UR[256];
 static TCGv_i32 cpu_windowbase_next;
+static TCGv_i32 cpu_exclusive_addr;
+static TCGv_i32 cpu_exclusive_val;
 
 static GHashTable *xtensa_regfile_table;
 
@@ -216,6 +218,14 @@ void xtensa_translate_init(void)
         tcg_global_mem_new_i32(cpu_env,
                                offsetof(CPUXtensaState, windowbase_next),
                                "windowbase_next");
+    cpu_exclusive_addr =
+        tcg_global_mem_new_i32(cpu_env,
+                               offsetof(CPUXtensaState, exclusive_addr),
+                               "exclusive_addr");
+    cpu_exclusive_val =
+        tcg_global_mem_new_i32(cpu_env,
+                               offsetof(CPUXtensaState, exclusive_val),
+                               "exclusive_val");
 }
 
 void **xtensa_get_regfile_by_name(const char *name)
@@ -1592,6 +1602,12 @@ static void translate_clrb_expstate(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_andi_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], ~(1u << arg[0].imm));
 }
 
+static void translate_clrex(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+    tcg_gen_movi_i32(cpu_exclusive_addr, -1);
+}
+
 static void translate_const16(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
@@ -1667,6 +1683,17 @@ static void translate_extui(DisasContext *dc, const OpcodeArg arg[],
     tcg_temp_free(tmp);
 }
 
+static void translate_getex(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_extract_i32(tmp, cpu_SR[ATOMCTL], 8, 1);
+    tcg_gen_deposit_i32(cpu_SR[ATOMCTL], cpu_SR[ATOMCTL], arg[0].in, 8, 1);
+    tcg_gen_mov_i32(arg[0].out, tmp);
+    tcg_temp_free(tmp);
+}
+
 static void translate_icache(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
@@ -1714,6 +1741,38 @@ static void translate_l32e(DisasContext *dc, const OpcodeArg arg[],
     tcg_temp_free(addr);
 }
 
+#ifdef CONFIG_USER_ONLY
+static void gen_check_exclusive(DisasContext *dc, TCGv_i32 addr, bool is_write)
+{
+}
+#else
+static void gen_check_exclusive(DisasContext *dc, TCGv_i32 addr, bool is_write)
+{
+    if (!option_enabled(dc, XTENSA_OPTION_MPU)) {
+        TCGv_i32 tpc = tcg_const_i32(dc->pc);
+        TCGv_i32 write = tcg_const_i32(is_write);
+
+        gen_helper_check_exclusive(cpu_env, tpc, addr, write);
+        tcg_temp_free(tpc);
+        tcg_temp_free(write);
+    }
+}
+#endif
+
+static void translate_l32ex(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+    TCGv_i32 addr = tcg_temp_new_i32();
+
+    tcg_gen_mov_i32(addr, arg[1].in);
+    gen_load_store_alignment(dc, 2, addr, true);
+    gen_check_exclusive(dc, addr, false);
+    tcg_gen_qemu_ld_i32(arg[0].out, addr, dc->ring, MO_TEUL);
+    tcg_gen_mov_i32(cpu_exclusive_addr, addr);
+    tcg_gen_mov_i32(cpu_exclusive_val, arg[0].out);
+    tcg_temp_free(addr);
+}
+
 static void translate_ldst(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
@@ -2269,6 +2328,33 @@ static void translate_s32e(DisasContext *dc, const OpcodeArg arg[],
     tcg_temp_free(addr);
 }
 
+static void translate_s32ex(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+    TCGv_i32 prev = tcg_temp_new_i32();
+    TCGv_i32 addr = tcg_temp_local_new_i32();
+    TCGv_i32 res = tcg_temp_local_new_i32();
+    TCGLabel *label = gen_new_label();
+
+    tcg_gen_movi_i32(res, 0);
+    tcg_gen_mov_i32(addr, arg[1].in);
+    gen_load_store_alignment(dc, 2, addr, true);
+    tcg_gen_brcond_i32(TCG_COND_NE, addr, cpu_exclusive_addr, label);
+    gen_check_exclusive(dc, addr, true);
+    tcg_gen_atomic_cmpxchg_i32(prev, cpu_exclusive_addr, cpu_exclusive_val,
+                               arg[0].in, dc->cring, MO_TEUL);
+    tcg_gen_setcond_i32(TCG_COND_EQ, res, prev, cpu_exclusive_val);
+    tcg_gen_movcond_i32(TCG_COND_EQ, cpu_exclusive_val,
+                        prev, cpu_exclusive_val, prev, cpu_exclusive_val);
+    tcg_gen_movi_i32(cpu_exclusive_addr, -1);
+    gen_set_label(label);
+    tcg_gen_extract_i32(arg[0].out, cpu_SR[ATOMCTL], 8, 1);
+    tcg_gen_deposit_i32(cpu_SR[ATOMCTL], cpu_SR[ATOMCTL], res, 8, 1);
+    tcg_temp_free(prev);
+    tcg_temp_free(addr);
+    tcg_temp_free(res);
+}
+
 static void translate_salt(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
@@ -3068,6 +3154,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "clrb_expstate",
         .translate = translate_clrb_expstate,
     }, {
+        .name = "clrex",
+        .translate = translate_clrex,
+    }, {
         .name = "const16",
         .translate = translate_const16,
     }, {
@@ -3173,6 +3262,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "extw",
         .translate = translate_memw,
     }, {
+        .name = "getex",
+        .translate = translate_getex,
+    }, {
         .name = "hwwdtlba",
         .op_flags = XTENSA_OP_ILL,
     }, {
@@ -3244,6 +3336,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_l32e,
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_LOAD,
     }, {
+        .name = "l32ex",
+        .translate = translate_l32ex,
+        .op_flags = XTENSA_OP_LOAD,
+    }, {
         .name = (const char * const[]) {
             "l32i", "l32i.n", NULL,
         },
@@ -4557,6 +4653,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_s32e,
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_STORE,
     }, {
+        .name = "s32ex",
+        .translate = translate_s32ex,
+        .op_flags = XTENSA_OP_LOAD | XTENSA_OP_STORE,
+    }, {
         .name = (const char * const[]) {
             "s32i", "s32i.n", "s32nb", NULL,
         },
diff --git a/tests/tcg/xtensa/test_exclusive.S b/tests/tcg/xtensa/test_exclusive.S
new file mode 100644
index 000000000000..7757a552ea00
--- /dev/null
+++ b/tests/tcg/xtensa/test_exclusive.S
@@ -0,0 +1,48 @@
+#include "macros.inc"
+
+test_suite exclusive
+
+#if XCHAL_HAVE_EXCLUSIVE
+
+test exclusive_nowrite
+    movi    a2, 0x29
+    wsr     a2, atomctl
+    clrex
+    movi    a2, 1f
+    movi    a3, 1
+    s32ex   a3, a2
+    getex   a3
+    assert  eqi, a3, 0
+    l32i    a3, a2, 0
+    assert  eqi, a3, 3
+
+.data
+.align 4
+1:
+    .word   3
+.text
+test_end
+
+test exclusive_write
+    movi    a2, 0x29
+    wsr     a2, atomctl
+    movi    a2, 1f
+    l32ex   a3, a2
+    assert  eqi, a3, 3
+    movi    a3, 2
+    s32ex   a3, a2
+    getex   a3
+    assert  eqi, a3, 1
+    l32i    a3, a2, 0
+    assert  eqi, a3, 2
+
+.data
+.align 4
+1:
+    .word   3
+.text
+test_end
+
+#endif
+
+test_suite_end
-- 
2.11.0


