Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE5C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA922083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fgi3twoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA922083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVZe-0000Sm-RH
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTu-0003ds-U2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:14 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:35632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTs-0001yW-VQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:14 -0400
Received: by mail-oi1-x229.google.com with SMTP id w141so6192465oia.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g67AaWSNMDVXjRU+vP3LKCD0hiHwTorrb1XmdieL2IE=;
 b=Fgi3twoc1HVrcIetOSBYpE9HtjSkihuYNxLQBYm2S3UohpajeIH7AeYnxVFWGfB4yi
 9gqqri2qdUPe43YJpNAnZsK7QCtDfUeJ1yL9nG4JkYgxq0RqW1JjNh1/lHdmOXK9Q7K3
 dmvzSuv3t8T4perpgIY72PZ7ofn4aNWDmxu2JNRKmVEUPjfnY4QCigJNnVIgIivLI3Zk
 ICaZv2/K4Ub4NVSzzjMCflKhXJ2lWRmdDqVPWmXuM4sX8v/vBxKk1t/yEZbGi9YEw+IX
 EEBiU4YRZX/7QVczwmBo/+5oUNg2+Zg/rQuXQyWxRvgEDJUhDmrAd39XbXzpZSBJP330
 olIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g67AaWSNMDVXjRU+vP3LKCD0hiHwTorrb1XmdieL2IE=;
 b=IaZD7wulDmHjqDHSyuxuJRuezzqhiDAlvgiEydLIXNMf438ik5ueZDqHzYgHE6Z768
 kMn51Q8iylRAGJdkMvjI/teLsc8lEc/aUUU507l6Eq8mcy5vkiNXJVQZd+xwtdjtjAQU
 /R15+JiBhFv1kfDPcn9xr/JSB0YuNjuXN9BNJhCWSujnIbL5i5pkopNLbSilRheO/LzV
 Ym2vhjNMQPYz5TIQcq881TGvx52Mvr7bBWmojm4Expgdi1IfyJCC+V+y/jtKQBnbVstK
 5G8nO3uEvmDVvoC/PQsoqnqkxhb39JogooeFXIlWeiKT2vAWCsTv+JHnYyuk7RtUu6vL
 eU6A==
X-Gm-Message-State: AOAM5337vWg2ksbeArhk4eFYfStVeebm4wjSFPK9QaKk4gKxt2Sx2Ity
 h88bBc8Y+Ie+ep6ZT1jDQl7xCuD/DWa3DrSm
X-Google-Smtp-Source: ABdhPJznlJPgeg2iY0nVtR6jAy+QTGL8s0O7OWojMrwRKGAyDcCjtrU9n3QlEe12wHgebNuqu5pSTg==
X-Received: by 2002:aca:3607:: with SMTP id d7mr5000347oia.168.1602161831449; 
 Thu, 08 Oct 2020 05:57:11 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] tcg: Move some TCG_CT_* bits to TCGArgConstraint
 bitfields
Date: Thu,  8 Oct 2020 07:56:53 -0500
Message-Id: <20201008125659.49857-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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
Cc: peter.maydell@linaro.org
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
index 55b2fc3ae3..a8c28440e2 100644
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


