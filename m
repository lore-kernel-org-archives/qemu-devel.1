Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7412145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZ/A8Nd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7412145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnpe-0004Qd-0d
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnH-0007f9-NN
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:59 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnF-0002A4-Qe
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:59 -0400
Received: by mail-pf1-x443.google.com with SMTP id d9so568335pfd.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=71Q465nC1T+L79svLwzYh0YmBPONC9zJSTGU30GzRog=;
 b=nZ/A8Nd15pNpdaFpvET3461Cu2QwFiKGWw6CzDEmU9Ykd7Fs5DsHKwO3VRTjYbswxi
 6mPloN1JdFaLb19tQ2TspbcMVAYlUtb3cBQleIsdylmCsJStVtK71Dtr/73y50WlWf56
 PjzHSgrrYqdk1+5hk8ubaV2V/+jIxr4o8x+3T1n7ciPWMljHx64PyQYlh6RW41qQUt4E
 RWEXVfrx77kU5Eseq0cvkDaYHCqcJNltLL4N3jekztCX9fnYwTrRET66lymEluS0Hv6/
 2Rpex61BqoUiUO4nY75iqTp5hn8CMDWG6QhoNu84Zr0TOXOHXvL0JglTml+SJoGmG8t1
 z2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=71Q465nC1T+L79svLwzYh0YmBPONC9zJSTGU30GzRog=;
 b=QuYbi7CoiChiDjonm//d5oHfobM1tY92V3X+7CnqJfoCDqiYU7yRjm4WoF1O58AGJD
 VuyNxWbTCDTFpapGa2Fab4mLxgtcaRVXoP8XZ6xWMIFXztthNO+KIKftR3a9+jY3KnTS
 uaDUDElxtH6JtEu7mWKYGmd6SVMPLDBozzFgb/+WQR/kk+VmfhBDjvHFEWM2s8UuVMaV
 EpAVQtwprQzftP2G63dM0JRn7fXkDw5k0Vaq6ygNszfb3JbwSc2rRR5dc7Zn8HY+DAgi
 mcWw1b38jHPzKymg0p6Yf7hB539Pr5v9ojj7U2d4SkM4G9aE0+01zdE7xvR/Vzr0QFhh
 gZGQ==
X-Gm-Message-State: AOAM530MjkbYmSIIzLuKJupcW3zCGVOyOi1RmKJVSuERTLIb6FHeRrwy
 EGu5aXvi3kuO8z/TEb43n0SCmkBh5QMTZg==
X-Google-Smtp-Source: ABdhPJyTW/ZIo2lK9SKd1L1f9Ll8L99nDcAmqQDhU0L37xjWZMz9UwbmScM1Zt8FRS2ihyrGEnl5nA==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr1183336pfb.85.1599610615987;
 Tue, 08 Sep 2020 17:16:55 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.16.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:16:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/43] tcg: Move some TCG_CT_* bits to TCGArgConstraint
 bitfields
Date: Tue,  8 Sep 2020 17:16:09 -0700
Message-Id: <20200909001647.532249-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are easier to set and test when they have their own fields.
Reduce the size of alias_index and sort_index to 4 bits, which is
sufficient for TCG_MAX_OP_ARGS.  This leaves only the bits indicating
constants within the ct field.

Move all initialization to allocation time, rather than init
individual fields in process_op_defs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 14 +++++++-------
 tcg/tcg.c         | 28 ++++++++++++----------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 3168315bb8..e8629b58c8 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -976,15 +976,15 @@ int64_t tcg_cpu_exec_time(void);
 void tcg_dump_info(void);
 void tcg_dump_op_count(void);
 
-#define TCG_CT_ALIAS  0x80
-#define TCG_CT_IALIAS 0x40
-#define TCG_CT_NEWREG 0x20 /* output requires a new register */
-#define TCG_CT_CONST  0x02 /* any constant of register size */
+#define TCG_CT_CONST  1 /* any constant of register size */
 
 typedef struct TCGArgConstraint {
-    uint16_t ct;
-    uint8_t alias_index;
-    uint8_t sort_index;
+    unsigned ct : 16;
+    unsigned alias_index : 4;
+    unsigned sort_index : 4;
+    bool oalias : 1;
+    bool ialias : 1;
+    bool newreg : 1;
     TCGRegSet regs;
 } TCGArgConstraint;
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a618497c94..ad4b7fb90f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -958,7 +958,7 @@ void tcg_context_init(TCGContext *s)
         total_args += n;
     }
 
-    args_ct = g_malloc(sizeof(TCGArgConstraint) * total_args);
+    args_ct = g_new0(TCGArgConstraint, total_args);
 
     for(op = 0; op < NB_OPS; op++) {
         def = &tcg_op_defs[op];
@@ -2197,7 +2197,7 @@ static int get_constraint_priority(const TCGOpDef *def, int k)
     const TCGArgConstraint *arg_ct = &def->args_ct[k];
     int n;
 
-    if (arg_ct->ct & TCG_CT_ALIAS) {
+    if (arg_ct->oalias) {
         /* an alias is equivalent to a single register */
         n = 1;
     } else {
@@ -2260,8 +2260,6 @@ static void process_op_defs(TCGContext *s)
             /* Incomplete TCGTargetOpDef entry. */
             tcg_debug_assert(ct_str != NULL);
 
-            def->args_ct[i].regs = 0;
-            def->args_ct[i].ct = 0;
             while (*ct_str != '\0') {
                 switch(*ct_str) {
                 case '0' ... '9':
@@ -2270,18 +2268,18 @@ static void process_op_defs(TCGContext *s)
                         tcg_debug_assert(ct_str == tdefs->args_ct_str[i]);
                         tcg_debug_assert(oarg < def->nb_oargs);
                         tcg_debug_assert(def->args_ct[oarg].regs != 0);
-                        /* TCG_CT_ALIAS is for the output arguments.
-                           The input is tagged with TCG_CT_IALIAS. */
                         def->args_ct[i] = def->args_ct[oarg];
-                        def->args_ct[oarg].ct |= TCG_CT_ALIAS;
+                        /* The output sets oalias.  */
+                        def->args_ct[oarg].oalias = true;
                         def->args_ct[oarg].alias_index = i;
-                        def->args_ct[i].ct |= TCG_CT_IALIAS;
+                        /* The input sets ialias. */
+                        def->args_ct[i].ialias = true;
                         def->args_ct[i].alias_index = oarg;
                     }
                     ct_str++;
                     break;
                 case '&':
-                    def->args_ct[i].ct |= TCG_CT_NEWREG;
+                    def->args_ct[i].newreg = true;
                     ct_str++;
                     break;
                 case 'i':
@@ -2848,7 +2846,7 @@ static void liveness_pass_1(TCGContext *s)
                     set = *pset;
 
                     set &= ct->regs;
-                    if (ct->ct & TCG_CT_IALIAS) {
+                    if (ct->ialias) {
                         set &= op->output_pref[ct->alias_index];
                     }
                     /* If the combination is not possible, restart.  */
@@ -3665,7 +3663,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
 
         i_preferred_regs = o_preferred_regs = 0;
-        if (arg_ct->ct & TCG_CT_IALIAS) {
+        if (arg_ct->ialias) {
             o_preferred_regs = op->output_pref[arg_ct->alias_index];
             if (ts->fixed_reg) {
                 /* if fixed register, we must allocate a new register
@@ -3688,8 +3686,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                     reg = ts->reg;
                     for (k2 = 0 ; k2 < k ; k2++) {
                         i2 = def->args_ct[nb_oargs + k2].sort_index;
-                        if ((def->args_ct[i2].ct & TCG_CT_IALIAS) &&
-                            reg == new_args[i2]) {
+                        if (def->args_ct[i2].ialias && reg == new_args[i2]) {
                             goto allocate_in_reg;
                         }
                     }
@@ -3760,10 +3757,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             /* ENV should not be modified.  */
             tcg_debug_assert(!ts->fixed_reg);
 
-            if ((arg_ct->ct & TCG_CT_ALIAS)
-                && !const_args[arg_ct->alias_index]) {
+            if (arg_ct->oalias && !const_args[arg_ct->alias_index]) {
                 reg = new_args[arg_ct->alias_index];
-            } else if (arg_ct->ct & TCG_CT_NEWREG) {
+            } else if (arg_ct->newreg) {
                 reg = tcg_reg_alloc(s, arg_ct->regs,
                                     i_allocated_regs | o_allocated_regs,
                                     op->output_pref[k], ts->indirect_base);
-- 
2.25.1


