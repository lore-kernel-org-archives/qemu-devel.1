Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B135C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 12:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA62221841
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 12:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwSfakmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA62221841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpAMP-0005U2-Ux
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 08:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jpALK-0004eH-JP
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 08:54:02 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jpALH-0001RQ-5x
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 08:54:02 -0400
Received: by mail-pj1-x1042.google.com with SMTP id cm23so6077737pjb.5
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NTqa7wnFFrr7STagypV2WaRwj4VObi4yM8H6wipHSgE=;
 b=WwSfakmuLcNDRA7f1P0kZKCUi2fXgqszhZZDCcaexw5Z6SAWCyJlyWr2TTGS95MEkd
 Nj3ClHH+z2AADx6YdViZm+lwF7i0OYIFw06QEsdYOrvT+jkp8KxO20lR6nYVXUILBUDN
 jgS1vt8E2rb4+VhUaWU+0bhL3aqMVoy+0TPq5rnzZ3GBT5rutam1Qxf+3Hv5sOVYVgmF
 HwuFEjy1RDKNmTaiomURk93kSK4kkZsH247vWBu13sLcS6VHWyjeplsTyBwA8mw/JA2Y
 qxBif9Vqp8QyuTBPjDxiysnjefmgiCKMgE1k2IcJpyV9ECnE6Ro33XhuYUiIp0VznB96
 KWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NTqa7wnFFrr7STagypV2WaRwj4VObi4yM8H6wipHSgE=;
 b=IseH1bpRd8/+3YArYLqk0wwFi1+52DXaeKksvu0eY24fQnFmQiEcx4z6Ks92IbAykz
 p48O1bIC3RANZLHdcg9tCjbFA/SFKQoeodbWgUf+5ZAXtox3ropVAK9YVKxxoRJccvjc
 8kngjrsSAR0kUMtnxj/UT4TzF6tkWx+yBILGYE0V86BNRbpjHiHu6LyNSbsESrcSZp/K
 7MLM0gXCA/5rnKPygBZ/KMcoey3RhLVGZODlZP44o4bVjpo5tqipZGQuuCcsp0BBrItv
 B1PA6614H2HfyH6dcDfpayLF/KtjrePDcDfSmgspIv4XSh+0O0VjBlP4LOxwZ7dB0lq1
 B5vg==
X-Gm-Message-State: AOAM531T1rOKQdUEbSrj/6sqgkT9rieWgQS7XLyZOaNJw3VFSwn462sr
 5IMtwBtHa2ghzt9Dqg5GlwphX6OE
X-Google-Smtp-Source: ABdhPJwP33vFMwZx8PkMfV4ejIwInVAu5hG943Ug/vHZBqJx8M0XpCOHIrFNTWB9zPcrBh9Ftmfrgw==
X-Received: by 2002:a17:90a:ee95:: with SMTP id
 i21mr8608148pjz.77.1593262435882; 
 Sat, 27 Jun 2020 05:53:55 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:dc59:7b7e:f4cf:4ab8])
 by smtp.gmail.com with ESMTPSA id j2sm10761986pjy.1.2020.06.27.05.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2020 05:53:55 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/xtensa: make opcode properties more dynamic
Date: Sat, 27 Jun 2020 05:53:31 -0700
Message-Id: <20200627125331.27946-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's XtensaOpcodeOps::test_ill that is used to check whether opcode
generates illegal opcode exception or not. The illegal opcode exception
is not special and so this callback can be generalized to provide any
XTENSA_OP_* flags that are not completely static.
Introduce XtensaOpcodeOps::test_exceptions and convert all test_ill
users to test_exceptions.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |   5 +-
 target/xtensa/translate.c | 538 ++++++++++++++++++++------------------
 2 files changed, 278 insertions(+), 265 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 32749378bfc7..65f00028501a 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -364,9 +364,6 @@ typedef struct opcode_arg {
 typedef struct DisasContext DisasContext;
 typedef void (*XtensaOpcodeOp)(DisasContext *dc, const OpcodeArg arg[],
                                const uint32_t par[]);
-typedef bool (*XtensaOpcodeBoolTest)(DisasContext *dc,
-                                     const OpcodeArg arg[],
-                                     const uint32_t par[]);
 typedef uint32_t (*XtensaOpcodeUintTest)(DisasContext *dc,
                                          const OpcodeArg arg[],
                                          const uint32_t par[]);
@@ -408,7 +405,7 @@ enum {
 typedef struct XtensaOpcodeOps {
     const void *name;
     XtensaOpcodeOp translate;
-    XtensaOpcodeBoolTest test_ill;
+    XtensaOpcodeUintTest test_exceptions;
     XtensaOpcodeUintTest test_overflow;
     const uint32_t *par;
     uint32_t op_flags;
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 6346b2eef014..03d796d7a1ed 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -459,22 +459,26 @@ static void gen_brcondi(DisasContext *dc, TCGCond cond,
     tcg_temp_free(tmp);
 }
 
-static bool test_ill_sr(DisasContext *dc, const OpcodeArg arg[],
-                        const uint32_t par[])
+static uint32_t test_exceptions_sr(DisasContext *dc, const OpcodeArg arg[],
+                                   const uint32_t par[])
 {
-    return !xtensa_option_enabled(dc->config, par[1]);
+    return xtensa_option_enabled(dc->config, par[1]) ? 0 : XTENSA_OP_ILL;
 }
 
-static bool test_ill_ccompare(DisasContext *dc, const OpcodeArg arg[],
-                              const uint32_t par[])
+static uint32_t test_exceptions_ccompare(DisasContext *dc,
+                                         const OpcodeArg arg[],
+                                         const uint32_t par[])
 {
     unsigned n = par[0] - CCOMPARE;
 
-    return test_ill_sr(dc, arg, par) || n >= dc->config->nccompare;
+    if (n >= dc->config->nccompare) {
+        return XTENSA_OP_ILL;
+    }
+    return test_exceptions_sr(dc, arg, par);
 }
 
-static bool test_ill_dbreak(DisasContext *dc, const OpcodeArg arg[],
-                            const uint32_t par[])
+static uint32_t test_exceptions_dbreak(DisasContext *dc, const OpcodeArg arg[],
+                                       const uint32_t par[])
 {
     unsigned n = MAX_NDBREAK;
 
@@ -484,19 +488,25 @@ static bool test_ill_dbreak(DisasContext *dc, const OpcodeArg arg[],
     if (par[0] >= DBREAKC && par[0] < DBREAKC + MAX_NDBREAK) {
         n = par[0] - DBREAKC;
     }
-    return test_ill_sr(dc, arg, par) || n >= dc->config->ndbreak;
+    if (n >= dc->config->ndbreak) {
+        return XTENSA_OP_ILL;
+    }
+    return test_exceptions_sr(dc, arg, par);
 }
 
-static bool test_ill_ibreak(DisasContext *dc, const OpcodeArg arg[],
-                            const uint32_t par[])
+static uint32_t test_exceptions_ibreak(DisasContext *dc, const OpcodeArg arg[],
+                                       const uint32_t par[])
 {
     unsigned n = par[0] - IBREAKA;
 
-    return test_ill_sr(dc, arg, par) || n >= dc->config->nibreak;
+    if (n >= dc->config->nibreak) {
+        return XTENSA_OP_ILL;
+    }
+    return test_exceptions_sr(dc, arg, par);
 }
 
-static bool test_ill_hpi(DisasContext *dc, const OpcodeArg arg[],
-                         const uint32_t par[])
+static uint32_t test_exceptions_hpi(DisasContext *dc, const OpcodeArg arg[],
+                                    const uint32_t par[])
 {
     unsigned n = MAX_NLEVEL + 1;
 
@@ -509,7 +519,10 @@ static bool test_ill_hpi(DisasContext *dc, const OpcodeArg arg[],
     if (par[0] >= EPS2 && par[0] < EPS2 + MAX_NLEVEL - 1) {
         n = par[0] - EPS2 + 2;
     }
-    return test_ill_sr(dc, arg, par) || n > dc->config->nlevel;
+    if (n > dc->config->nlevel) {
+        return XTENSA_OP_ILL;
+    }
+    return test_exceptions_sr(dc, arg, par);
 }
 
 static void gen_load_store_alignment(DisasContext *dc, int shift,
@@ -949,18 +962,20 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 
         if (ops) {
             op_flags |= ops->op_flags;
+            if (ops->test_exceptions) {
+                op_flags |= ops->test_exceptions(dc, arg, ops->par);
+            }
         } else {
             qemu_log_mask(LOG_UNIMP,
                           "unimplemented opcode '%s' in slot %d (pc = %08x)\n",
                           xtensa_opcode_name(isa, opc), slot, dc->pc);
             op_flags |= XTENSA_OP_ILL;
         }
-        if ((op_flags & XTENSA_OP_ILL) ||
-            (ops && ops->test_ill && ops->test_ill(dc, arg, ops->par))) {
+        if (op_flags & XTENSA_OP_ILL) {
             gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
             return;
         }
-        if (ops->op_flags & XTENSA_OP_DEBUG_BREAK) {
+        if (op_flags & XTENSA_OP_DEBUG_BREAK) {
             debug_cause |= ops->par[0];
         }
         if (ops->test_overflow) {
@@ -1619,15 +1634,15 @@ static void translate_diwbuip(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_addi_i32(arg[0].out, arg[0].in, dc->config->dcache_line_bytes);
 }
 
-static bool test_ill_entry(DisasContext *dc, const OpcodeArg arg[],
-                           const uint32_t par[])
+static uint32_t test_exceptions_entry(DisasContext *dc, const OpcodeArg arg[],
+                                      const uint32_t par[])
 {
     if (arg[0].imm > 3 || !dc->cwoe) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Illegal entry instruction(pc = %08x)\n", dc->pc);
-        return true;
+        return XTENSA_OP_ILL;
     } else {
-        return false;
+        return 0;
     }
 }
 
@@ -2100,19 +2115,19 @@ static void translate_ret(DisasContext *dc, const OpcodeArg arg[],
     gen_jump(dc, cpu_R[0]);
 }
 
-static bool test_ill_retw(DisasContext *dc, const OpcodeArg arg[],
-                          const uint32_t par[])
+static uint32_t test_exceptions_retw(DisasContext *dc, const OpcodeArg arg[],
+                                     const uint32_t par[])
 {
     if (!dc->cwoe) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Illegal retw instruction(pc = %08x)\n", dc->pc);
-        return true;
+        return XTENSA_OP_ILL;
     } else {
         TCGv_i32 tmp = tcg_const_i32(dc->pc);
 
         gen_helper_test_ill_retw(cpu_env, tmp);
         tcg_temp_free(tmp);
-        return false;
+        return 0;
     }
 }
 
@@ -2358,8 +2373,9 @@ static void translate_sext(DisasContext *dc, const OpcodeArg arg[],
     }
 }
 
-static bool test_ill_simcall(DisasContext *dc, const OpcodeArg arg[],
-                             const uint32_t par[])
+static uint32_t test_exceptions_simcall(DisasContext *dc,
+                                        const OpcodeArg arg[],
+                                        const uint32_t par[])
 {
 #ifdef CONFIG_USER_ONLY
     bool ill = true;
@@ -2370,7 +2386,7 @@ static bool test_ill_simcall(DisasContext *dc, const OpcodeArg arg[],
     if (ill || !semihosting_enabled()) {
         qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
     }
-    return ill;
+    return ill ? XTENSA_OP_ILL : 0;
 }
 
 static void translate_simcall(DisasContext *dc, const OpcodeArg arg[],
@@ -3234,7 +3250,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "entry",
         .translate = translate_entry,
-        .test_ill = test_ill_entry,
+        .test_exceptions = test_exceptions_entry,
         .test_overflow = test_overflow_entry,
         .op_flags = XTENSA_OP_EXIT_TB_M1 |
             XTENSA_OP_SYNC_REGISTER_WINDOW,
@@ -3809,7 +3825,7 @@ static const XtensaOpcodeOps core_ops[] = {
             "retw", "retw.n", NULL,
         },
         .translate = translate_retw,
-        .test_ill = test_ill_retw,
+        .test_exceptions = test_exceptions_retw,
         .op_flags = XTENSA_OP_UNDERFLOW | XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "rfdd",
@@ -3883,7 +3899,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.acchi",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ACCHI,
             XTENSA_OPTION_MAC16,
@@ -3891,7 +3907,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.acclo",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ACCLO,
             XTENSA_OPTION_MAC16,
@@ -3899,7 +3915,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.atomctl",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ATOMCTL,
             XTENSA_OPTION_ATOMCTL,
@@ -3908,7 +3924,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.br",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             BR,
             XTENSA_OPTION_BOOLEAN,
@@ -3916,7 +3932,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.cacheadrdis",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CACHEADRDIS,
             XTENSA_OPTION_MPU,
@@ -3925,7 +3941,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.cacheattr",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CACHEATTR,
             XTENSA_OPTION_CACHEATTR,
@@ -3934,7 +3950,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.ccompare0",
         .translate = translate_rsr,
-        .test_ill = test_ill_ccompare,
+        .test_exceptions = test_exceptions_ccompare,
         .par = (const uint32_t[]){
             CCOMPARE,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -3943,7 +3959,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.ccompare1",
         .translate = translate_rsr,
-        .test_ill = test_ill_ccompare,
+        .test_exceptions = test_exceptions_ccompare,
         .par = (const uint32_t[]){
             CCOMPARE + 1,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -3952,7 +3968,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.ccompare2",
         .translate = translate_rsr,
-        .test_ill = test_ill_ccompare,
+        .test_exceptions = test_exceptions_ccompare,
         .par = (const uint32_t[]){
             CCOMPARE + 2,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -3961,7 +3977,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.ccount",
         .translate = translate_rsr_ccount,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CCOUNT,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -3980,7 +3996,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.cpenable",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CPENABLE,
             XTENSA_OPTION_COPROCESSOR,
@@ -3989,7 +4005,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.dbreaka0",
         .translate = translate_rsr,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKA,
             XTENSA_OPTION_DEBUG,
@@ -3998,7 +4014,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.dbreaka1",
         .translate = translate_rsr,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKA + 1,
             XTENSA_OPTION_DEBUG,
@@ -4007,7 +4023,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.dbreakc0",
         .translate = translate_rsr,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKC,
             XTENSA_OPTION_DEBUG,
@@ -4016,7 +4032,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.dbreakc1",
         .translate = translate_rsr,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKC + 1,
             XTENSA_OPTION_DEBUG,
@@ -4025,7 +4041,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.ddr",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             DDR,
             XTENSA_OPTION_DEBUG,
@@ -4034,7 +4050,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.debugcause",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             DEBUGCAUSE,
             XTENSA_OPTION_DEBUG,
@@ -4043,7 +4059,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.depc",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             DEPC,
             XTENSA_OPTION_EXCEPTION,
@@ -4052,7 +4068,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.dtlbcfg",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             DTLBCFG,
             XTENSA_OPTION_MMU,
@@ -4061,7 +4077,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.epc1",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EPC1,
             XTENSA_OPTION_EXCEPTION,
@@ -4070,7 +4086,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.epc2",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 1,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4079,7 +4095,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.epc3",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4088,7 +4104,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.epc4",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 3,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4097,7 +4113,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.epc5",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 4,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4106,7 +4122,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.epc6",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 5,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4115,7 +4131,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.epc7",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 6,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4124,7 +4140,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.eps2",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4133,7 +4149,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.eps3",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 1,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4142,7 +4158,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.eps4",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4151,7 +4167,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.eps5",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 3,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4160,7 +4176,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.eps6",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 4,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4169,7 +4185,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.eps7",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 5,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4183,7 +4199,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.exccause",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EXCCAUSE,
             XTENSA_OPTION_EXCEPTION,
@@ -4192,7 +4208,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.excsave1",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EXCSAVE1,
             XTENSA_OPTION_EXCEPTION,
@@ -4201,7 +4217,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.excsave2",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 1,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4210,7 +4226,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.excsave3",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4219,7 +4235,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.excsave4",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 3,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4228,7 +4244,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.excsave5",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 4,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4237,7 +4253,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.excsave6",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 5,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4246,7 +4262,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.excsave7",
         .translate = translate_rsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 6,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4255,7 +4271,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.excvaddr",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EXCVADDR,
             XTENSA_OPTION_EXCEPTION,
@@ -4264,7 +4280,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.ibreaka0",
         .translate = translate_rsr,
-        .test_ill = test_ill_ibreak,
+        .test_exceptions = test_exceptions_ibreak,
         .par = (const uint32_t[]){
             IBREAKA,
             XTENSA_OPTION_DEBUG,
@@ -4273,7 +4289,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.ibreaka1",
         .translate = translate_rsr,
-        .test_ill = test_ill_ibreak,
+        .test_exceptions = test_exceptions_ibreak,
         .par = (const uint32_t[]){
             IBREAKA + 1,
             XTENSA_OPTION_DEBUG,
@@ -4282,7 +4298,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.ibreakenable",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             IBREAKENABLE,
             XTENSA_OPTION_DEBUG,
@@ -4291,7 +4307,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.icount",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ICOUNT,
             XTENSA_OPTION_DEBUG,
@@ -4300,7 +4316,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.icountlevel",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ICOUNTLEVEL,
             XTENSA_OPTION_DEBUG,
@@ -4309,7 +4325,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.intclear",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             INTCLEAR,
             XTENSA_OPTION_INTERRUPT,
@@ -4318,7 +4334,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.intenable",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             INTENABLE,
             XTENSA_OPTION_INTERRUPT,
@@ -4327,7 +4343,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.interrupt",
         .translate = translate_rsr_ccount,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             INTSET,
             XTENSA_OPTION_INTERRUPT,
@@ -4336,7 +4352,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.intset",
         .translate = translate_rsr_ccount,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             INTSET,
             XTENSA_OPTION_INTERRUPT,
@@ -4345,7 +4361,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.itlbcfg",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ITLBCFG,
             XTENSA_OPTION_MMU,
@@ -4354,7 +4370,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.lbeg",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LBEG,
             XTENSA_OPTION_LOOP,
@@ -4362,7 +4378,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.lcount",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LCOUNT,
             XTENSA_OPTION_LOOP,
@@ -4370,7 +4386,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.lend",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LEND,
             XTENSA_OPTION_LOOP,
@@ -4378,7 +4394,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.litbase",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LITBASE,
             XTENSA_OPTION_EXTENDED_L32R,
@@ -4386,7 +4402,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.m0",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR,
             XTENSA_OPTION_MAC16,
@@ -4394,7 +4410,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.m1",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR + 1,
             XTENSA_OPTION_MAC16,
@@ -4402,7 +4418,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.m2",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR + 2,
             XTENSA_OPTION_MAC16,
@@ -4410,7 +4426,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.m3",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR + 3,
             XTENSA_OPTION_MAC16,
@@ -4423,7 +4439,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.mecr",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MECR,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -4432,7 +4448,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.mepc",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MEPC,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -4441,7 +4457,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.meps",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MEPS,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -4450,7 +4466,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.mesave",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MESAVE,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -4459,7 +4475,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.mesr",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MESR,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -4468,7 +4484,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.mevaddr",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MESR,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -4477,7 +4493,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.misc0",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC,
             XTENSA_OPTION_MISC_SR,
@@ -4486,7 +4502,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.misc1",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC + 1,
             XTENSA_OPTION_MISC_SR,
@@ -4495,7 +4511,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.misc2",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC + 2,
             XTENSA_OPTION_MISC_SR,
@@ -4504,7 +4520,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.misc3",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC + 3,
             XTENSA_OPTION_MISC_SR,
@@ -4513,7 +4529,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.mpucfg",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MPUCFG,
             XTENSA_OPTION_MPU,
@@ -4522,7 +4538,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.mpuenb",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MPUENB,
             XTENSA_OPTION_MPU,
@@ -4535,7 +4551,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.prid",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             PRID,
             XTENSA_OPTION_PROCESSOR_ID,
@@ -4544,7 +4560,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.ps",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             PS,
             XTENSA_OPTION_EXCEPTION,
@@ -4553,7 +4569,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.ptevaddr",
         .translate = translate_rsr_ptevaddr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             PTEVADDR,
             XTENSA_OPTION_MMU,
@@ -4562,7 +4578,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.rasid",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             RASID,
             XTENSA_OPTION_MMU,
@@ -4575,7 +4591,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.scompare1",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             SCOMPARE1,
             XTENSA_OPTION_CONDITIONAL_STORE,
@@ -4583,7 +4599,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.vecbase",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             VECBASE,
             XTENSA_OPTION_RELOCATABLE_VECTOR,
@@ -4592,7 +4608,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.windowbase",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             WINDOW_BASE,
             XTENSA_OPTION_WINDOWED_REGISTER,
@@ -4601,7 +4617,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.windowstart",
         .translate = translate_rsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             WINDOW_START,
             XTENSA_OPTION_WINDOWED_REGISTER,
@@ -4679,7 +4695,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "simcall",
         .translate = translate_simcall,
-        .test_ill = test_ill_simcall,
+        .test_exceptions = test_exceptions_simcall,
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "sll",
@@ -4785,7 +4801,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.acchi",
         .translate = translate_wsr_acchi,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ACCHI,
             XTENSA_OPTION_MAC16,
@@ -4793,7 +4809,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.acclo",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ACCLO,
             XTENSA_OPTION_MAC16,
@@ -4801,7 +4817,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.atomctl",
         .translate = translate_wsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ATOMCTL,
             XTENSA_OPTION_ATOMCTL,
@@ -4811,7 +4827,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.br",
         .translate = translate_wsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             BR,
             XTENSA_OPTION_BOOLEAN,
@@ -4820,7 +4836,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.cacheadrdis",
         .translate = translate_wsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CACHEADRDIS,
             XTENSA_OPTION_MPU,
@@ -4830,7 +4846,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.cacheattr",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CACHEATTR,
             XTENSA_OPTION_CACHEATTR,
@@ -4839,7 +4855,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.ccompare0",
         .translate = translate_wsr_ccompare,
-        .test_ill = test_ill_ccompare,
+        .test_exceptions = test_exceptions_ccompare,
         .par = (const uint32_t[]){
             CCOMPARE,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -4848,7 +4864,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.ccompare1",
         .translate = translate_wsr_ccompare,
-        .test_ill = test_ill_ccompare,
+        .test_exceptions = test_exceptions_ccompare,
         .par = (const uint32_t[]){
             CCOMPARE + 1,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -4857,7 +4873,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.ccompare2",
         .translate = translate_wsr_ccompare,
-        .test_ill = test_ill_ccompare,
+        .test_exceptions = test_exceptions_ccompare,
         .par = (const uint32_t[]){
             CCOMPARE + 2,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -4866,7 +4882,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.ccount",
         .translate = translate_wsr_ccount,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CCOUNT,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -4881,7 +4897,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.cpenable",
         .translate = translate_wsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CPENABLE,
             XTENSA_OPTION_COPROCESSOR,
@@ -4891,7 +4907,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.dbreaka0",
         .translate = translate_wsr_dbreaka,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKA,
             XTENSA_OPTION_DEBUG,
@@ -4900,7 +4916,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.dbreaka1",
         .translate = translate_wsr_dbreaka,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKA + 1,
             XTENSA_OPTION_DEBUG,
@@ -4909,7 +4925,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.dbreakc0",
         .translate = translate_wsr_dbreakc,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKC,
             XTENSA_OPTION_DEBUG,
@@ -4918,7 +4934,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.dbreakc1",
         .translate = translate_wsr_dbreakc,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKC + 1,
             XTENSA_OPTION_DEBUG,
@@ -4927,7 +4943,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.ddr",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             DDR,
             XTENSA_OPTION_DEBUG,
@@ -4939,7 +4955,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.depc",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             DEPC,
             XTENSA_OPTION_EXCEPTION,
@@ -4948,7 +4964,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.dtlbcfg",
         .translate = translate_wsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             DTLBCFG,
             XTENSA_OPTION_MMU,
@@ -4958,7 +4974,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.epc1",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EPC1,
             XTENSA_OPTION_EXCEPTION,
@@ -4967,7 +4983,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.epc2",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 1,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4976,7 +4992,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.epc3",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4985,7 +5001,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.epc4",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 3,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -4994,7 +5010,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.epc5",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 4,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5003,7 +5019,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.epc6",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 5,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5012,7 +5028,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.epc7",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 6,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5021,7 +5037,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.eps2",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5030,7 +5046,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.eps3",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 1,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5039,7 +5055,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.eps4",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5048,7 +5064,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.eps5",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 3,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5057,7 +5073,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.eps6",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 4,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5066,7 +5082,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.eps7",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 5,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5084,7 +5100,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.exccause",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EXCCAUSE,
             XTENSA_OPTION_EXCEPTION,
@@ -5093,7 +5109,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.excsave1",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EXCSAVE1,
             XTENSA_OPTION_EXCEPTION,
@@ -5102,7 +5118,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.excsave2",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 1,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5111,7 +5127,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.excsave3",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5120,7 +5136,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.excsave4",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 3,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5129,7 +5145,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.excsave5",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 4,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5138,7 +5154,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.excsave6",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 5,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5147,7 +5163,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.excsave7",
         .translate = translate_wsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 6,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5156,7 +5172,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.excvaddr",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EXCVADDR,
             XTENSA_OPTION_EXCEPTION,
@@ -5165,7 +5181,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.ibreaka0",
         .translate = translate_wsr_ibreaka,
-        .test_ill = test_ill_ibreak,
+        .test_exceptions = test_exceptions_ibreak,
         .par = (const uint32_t[]){
             IBREAKA,
             XTENSA_OPTION_DEBUG,
@@ -5174,7 +5190,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.ibreaka1",
         .translate = translate_wsr_ibreaka,
-        .test_ill = test_ill_ibreak,
+        .test_exceptions = test_exceptions_ibreak,
         .par = (const uint32_t[]){
             IBREAKA + 1,
             XTENSA_OPTION_DEBUG,
@@ -5183,7 +5199,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.ibreakenable",
         .translate = translate_wsr_ibreakenable,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             IBREAKENABLE,
             XTENSA_OPTION_DEBUG,
@@ -5192,7 +5208,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.icount",
         .translate = translate_wsr_icount,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ICOUNT,
             XTENSA_OPTION_DEBUG,
@@ -5201,7 +5217,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.icountlevel",
         .translate = translate_wsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ICOUNTLEVEL,
             XTENSA_OPTION_DEBUG,
@@ -5211,7 +5227,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.intclear",
         .translate = translate_wsr_intclear,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             INTCLEAR,
             XTENSA_OPTION_INTERRUPT,
@@ -5223,7 +5239,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.intenable",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             INTENABLE,
             XTENSA_OPTION_INTERRUPT,
@@ -5235,7 +5251,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.interrupt",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             INTSET,
             XTENSA_OPTION_INTERRUPT,
@@ -5247,7 +5263,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.intset",
         .translate = translate_wsr_intset,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             INTSET,
             XTENSA_OPTION_INTERRUPT,
@@ -5259,7 +5275,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.itlbcfg",
         .translate = translate_wsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ITLBCFG,
             XTENSA_OPTION_MMU,
@@ -5269,7 +5285,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.lbeg",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LBEG,
             XTENSA_OPTION_LOOP,
@@ -5278,7 +5294,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.lcount",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LCOUNT,
             XTENSA_OPTION_LOOP,
@@ -5286,7 +5302,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.lend",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LEND,
             XTENSA_OPTION_LOOP,
@@ -5295,7 +5311,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.litbase",
         .translate = translate_wsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LITBASE,
             XTENSA_OPTION_EXTENDED_L32R,
@@ -5305,7 +5321,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.m0",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR,
             XTENSA_OPTION_MAC16,
@@ -5313,7 +5329,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.m1",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR + 1,
             XTENSA_OPTION_MAC16,
@@ -5321,7 +5337,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.m2",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR + 2,
             XTENSA_OPTION_MAC16,
@@ -5329,7 +5345,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.m3",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR + 3,
             XTENSA_OPTION_MAC16,
@@ -5342,7 +5358,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.mecr",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MECR,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -5351,7 +5367,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.mepc",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MEPC,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -5360,7 +5376,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.meps",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MEPS,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -5369,7 +5385,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.mesave",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MESAVE,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -5378,7 +5394,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.mesr",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MESR,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -5387,7 +5403,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.mevaddr",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MESR,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -5396,7 +5412,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.misc0",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC,
             XTENSA_OPTION_MISC_SR,
@@ -5405,7 +5421,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.misc1",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC + 1,
             XTENSA_OPTION_MISC_SR,
@@ -5414,7 +5430,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.misc2",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC + 2,
             XTENSA_OPTION_MISC_SR,
@@ -5423,7 +5439,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.misc3",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC + 3,
             XTENSA_OPTION_MISC_SR,
@@ -5432,7 +5448,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.mmid",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MMID,
             XTENSA_OPTION_TRACE_PORT,
@@ -5441,7 +5457,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.mpuenb",
         .translate = translate_wsr_mpuenb,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MPUENB,
             XTENSA_OPTION_MPU,
@@ -5457,7 +5473,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.ps",
         .translate = translate_wsr_ps,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             PS,
             XTENSA_OPTION_EXCEPTION,
@@ -5469,7 +5485,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.ptevaddr",
         .translate = translate_wsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             PTEVADDR,
             XTENSA_OPTION_MMU,
@@ -5479,7 +5495,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.rasid",
         .translate = translate_wsr_rasid,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             RASID,
             XTENSA_OPTION_MMU,
@@ -5492,7 +5508,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.scompare1",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             SCOMPARE1,
             XTENSA_OPTION_CONDITIONAL_STORE,
@@ -5500,7 +5516,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.vecbase",
         .translate = translate_wsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             VECBASE,
             XTENSA_OPTION_RELOCATABLE_VECTOR,
@@ -5509,7 +5525,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.windowbase",
         .translate = translate_wsr_windowbase,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             WINDOW_BASE,
             XTENSA_OPTION_WINDOWED_REGISTER,
@@ -5520,7 +5536,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.windowstart",
         .translate = translate_wsr_windowstart,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             WINDOW_START,
             XTENSA_OPTION_WINDOWED_REGISTER,
@@ -5560,7 +5576,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.acchi",
         .translate = translate_xsr_acchi,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ACCHI,
             XTENSA_OPTION_MAC16,
@@ -5568,7 +5584,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.acclo",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ACCLO,
             XTENSA_OPTION_MAC16,
@@ -5576,7 +5592,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.atomctl",
         .translate = translate_xsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ATOMCTL,
             XTENSA_OPTION_ATOMCTL,
@@ -5586,7 +5602,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.br",
         .translate = translate_xsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             BR,
             XTENSA_OPTION_BOOLEAN,
@@ -5595,7 +5611,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.cacheadrdis",
         .translate = translate_xsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CACHEADRDIS,
             XTENSA_OPTION_MPU,
@@ -5605,7 +5621,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.cacheattr",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CACHEATTR,
             XTENSA_OPTION_CACHEATTR,
@@ -5614,7 +5630,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.ccompare0",
         .translate = translate_xsr_ccompare,
-        .test_ill = test_ill_ccompare,
+        .test_exceptions = test_exceptions_ccompare,
         .par = (const uint32_t[]){
             CCOMPARE,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -5623,7 +5639,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.ccompare1",
         .translate = translate_xsr_ccompare,
-        .test_ill = test_ill_ccompare,
+        .test_exceptions = test_exceptions_ccompare,
         .par = (const uint32_t[]){
             CCOMPARE + 1,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -5632,7 +5648,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.ccompare2",
         .translate = translate_xsr_ccompare,
-        .test_ill = test_ill_ccompare,
+        .test_exceptions = test_exceptions_ccompare,
         .par = (const uint32_t[]){
             CCOMPARE + 2,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -5641,7 +5657,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.ccount",
         .translate = translate_xsr_ccount,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CCOUNT,
             XTENSA_OPTION_TIMER_INTERRUPT,
@@ -5656,7 +5672,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.cpenable",
         .translate = translate_xsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             CPENABLE,
             XTENSA_OPTION_COPROCESSOR,
@@ -5666,7 +5682,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.dbreaka0",
         .translate = translate_xsr_dbreaka,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKA,
             XTENSA_OPTION_DEBUG,
@@ -5675,7 +5691,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.dbreaka1",
         .translate = translate_xsr_dbreaka,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKA + 1,
             XTENSA_OPTION_DEBUG,
@@ -5684,7 +5700,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.dbreakc0",
         .translate = translate_xsr_dbreakc,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKC,
             XTENSA_OPTION_DEBUG,
@@ -5693,7 +5709,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.dbreakc1",
         .translate = translate_xsr_dbreakc,
-        .test_ill = test_ill_dbreak,
+        .test_exceptions = test_exceptions_dbreak,
         .par = (const uint32_t[]){
             DBREAKC + 1,
             XTENSA_OPTION_DEBUG,
@@ -5702,7 +5718,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.ddr",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             DDR,
             XTENSA_OPTION_DEBUG,
@@ -5714,7 +5730,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.depc",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             DEPC,
             XTENSA_OPTION_EXCEPTION,
@@ -5723,7 +5739,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.dtlbcfg",
         .translate = translate_xsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             DTLBCFG,
             XTENSA_OPTION_MMU,
@@ -5733,7 +5749,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.epc1",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EPC1,
             XTENSA_OPTION_EXCEPTION,
@@ -5742,7 +5758,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.epc2",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 1,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5751,7 +5767,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.epc3",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5760,7 +5776,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.epc4",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 3,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5769,7 +5785,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.epc5",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 4,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5778,7 +5794,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.epc6",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 5,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5787,7 +5803,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.epc7",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPC1 + 6,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5796,7 +5812,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.eps2",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5805,7 +5821,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.eps3",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 1,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5814,7 +5830,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.eps4",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5823,7 +5839,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.eps5",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 3,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5832,7 +5848,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.eps6",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 4,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5841,7 +5857,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.eps7",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EPS2 + 5,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5859,7 +5875,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.exccause",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EXCCAUSE,
             XTENSA_OPTION_EXCEPTION,
@@ -5868,7 +5884,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.excsave1",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EXCSAVE1,
             XTENSA_OPTION_EXCEPTION,
@@ -5877,7 +5893,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.excsave2",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 1,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5886,7 +5902,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.excsave3",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 2,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5895,7 +5911,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.excsave4",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 3,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5904,7 +5920,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.excsave5",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 4,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5913,7 +5929,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.excsave6",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 5,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5922,7 +5938,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.excsave7",
         .translate = translate_xsr,
-        .test_ill = test_ill_hpi,
+        .test_exceptions = test_exceptions_hpi,
         .par = (const uint32_t[]){
             EXCSAVE1 + 6,
             XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
@@ -5931,7 +5947,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.excvaddr",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             EXCVADDR,
             XTENSA_OPTION_EXCEPTION,
@@ -5940,7 +5956,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.ibreaka0",
         .translate = translate_xsr_ibreaka,
-        .test_ill = test_ill_ibreak,
+        .test_exceptions = test_exceptions_ibreak,
         .par = (const uint32_t[]){
             IBREAKA,
             XTENSA_OPTION_DEBUG,
@@ -5949,7 +5965,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.ibreaka1",
         .translate = translate_xsr_ibreaka,
-        .test_ill = test_ill_ibreak,
+        .test_exceptions = test_exceptions_ibreak,
         .par = (const uint32_t[]){
             IBREAKA + 1,
             XTENSA_OPTION_DEBUG,
@@ -5958,7 +5974,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.ibreakenable",
         .translate = translate_xsr_ibreakenable,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             IBREAKENABLE,
             XTENSA_OPTION_DEBUG,
@@ -5967,7 +5983,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.icount",
         .translate = translate_xsr_icount,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ICOUNT,
             XTENSA_OPTION_DEBUG,
@@ -5976,7 +5992,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.icountlevel",
         .translate = translate_xsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ICOUNTLEVEL,
             XTENSA_OPTION_DEBUG,
@@ -5989,7 +6005,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.intenable",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             INTENABLE,
             XTENSA_OPTION_INTERRUPT,
@@ -6007,7 +6023,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.itlbcfg",
         .translate = translate_xsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             ITLBCFG,
             XTENSA_OPTION_MMU,
@@ -6017,7 +6033,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.lbeg",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LBEG,
             XTENSA_OPTION_LOOP,
@@ -6026,7 +6042,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.lcount",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LCOUNT,
             XTENSA_OPTION_LOOP,
@@ -6034,7 +6050,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.lend",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LEND,
             XTENSA_OPTION_LOOP,
@@ -6043,7 +6059,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.litbase",
         .translate = translate_xsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             LITBASE,
             XTENSA_OPTION_EXTENDED_L32R,
@@ -6053,7 +6069,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.m0",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR,
             XTENSA_OPTION_MAC16,
@@ -6061,7 +6077,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.m1",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR + 1,
             XTENSA_OPTION_MAC16,
@@ -6069,7 +6085,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.m2",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR + 2,
             XTENSA_OPTION_MAC16,
@@ -6077,7 +6093,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.m3",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MR + 3,
             XTENSA_OPTION_MAC16,
@@ -6090,7 +6106,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.mecr",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MECR,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -6099,7 +6115,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.mepc",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MEPC,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -6108,7 +6124,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.meps",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MEPS,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -6117,7 +6133,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.mesave",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MESAVE,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -6126,7 +6142,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.mesr",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MESR,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -6135,7 +6151,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.mevaddr",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MESR,
             XTENSA_OPTION_MEMORY_ECC_PARITY,
@@ -6144,7 +6160,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.misc0",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC,
             XTENSA_OPTION_MISC_SR,
@@ -6153,7 +6169,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.misc1",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC + 1,
             XTENSA_OPTION_MISC_SR,
@@ -6162,7 +6178,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.misc2",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC + 2,
             XTENSA_OPTION_MISC_SR,
@@ -6171,7 +6187,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.misc3",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MISC + 3,
             XTENSA_OPTION_MISC_SR,
@@ -6180,7 +6196,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.mpuenb",
         .translate = translate_xsr_mpuenb,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             MPUENB,
             XTENSA_OPTION_MPU,
@@ -6196,7 +6212,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.ps",
         .translate = translate_xsr_ps,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             PS,
             XTENSA_OPTION_EXCEPTION,
@@ -6208,7 +6224,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.ptevaddr",
         .translate = translate_xsr_mask,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             PTEVADDR,
             XTENSA_OPTION_MMU,
@@ -6218,7 +6234,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.rasid",
         .translate = translate_xsr_rasid,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             RASID,
             XTENSA_OPTION_MMU,
@@ -6231,7 +6247,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.scompare1",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             SCOMPARE1,
             XTENSA_OPTION_CONDITIONAL_STORE,
@@ -6239,7 +6255,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.vecbase",
         .translate = translate_xsr,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             VECBASE,
             XTENSA_OPTION_RELOCATABLE_VECTOR,
@@ -6248,7 +6264,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.windowbase",
         .translate = translate_xsr_windowbase,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             WINDOW_BASE,
             XTENSA_OPTION_WINDOWED_REGISTER,
@@ -6259,7 +6275,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "xsr.windowstart",
         .translate = translate_xsr_windowstart,
-        .test_ill = test_ill_sr,
+        .test_exceptions = test_exceptions_sr,
         .par = (const uint32_t[]){
             WINDOW_START,
             XTENSA_OPTION_WINDOWED_REGISTER,
-- 
2.20.1


