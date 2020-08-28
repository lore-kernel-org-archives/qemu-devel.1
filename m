Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22132C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A3E207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KakpYYKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A3E207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfPA-00052G-Vv
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEg-0000g3-5g
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:10 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEd-00057Q-C1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:09 -0400
Received: by mail-pf1-x444.google.com with SMTP id t185so722716pfd.13
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qXpLGSkTUh0l6cihbLBx2yxjRuaY4I2Cb0zQBnRmSlQ=;
 b=KakpYYKHmGmteDL+lHFlX6zCH1S5uw1naqWSrBkmncYx9YNjZUHkJf0O6F0NaqGtq/
 qpINusx8ffqduxH6T4W5/KPQVrbsDB+k42r7KEIb5zG1sRzVMsegundBYK/NpOacHdru
 aZVQCi1FgAK5iY45pHAIJ8tzQBNt9y1k+DDa02Pwthxj0fwT715/n8wwIJunw/onVk6F
 ChgwfUvNu3ZuNSWd/iIHueCF8rO5Lz3hhwmd1nWRJo7vIf4Gokg4eK7IK1BWpPnW1WeZ
 ZrtXKLBcF1TMKueGv/Tfprg3eWrD4yGaT3S2bhyGcEapITfAr5JeNsLBy3lO9c9urpeA
 Lxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qXpLGSkTUh0l6cihbLBx2yxjRuaY4I2Cb0zQBnRmSlQ=;
 b=d4UAu8LphhwpAVgD8MFJq1uw9B0fVSoFQ8IkIMRhE8Smdw5H/QuRgJUPRnA1jBlZAM
 ImjgDuZvfrNXfrsp36HFUXBL5oxo2gH6CwIVx6Eg7p1Csf0qluHapGruYwH8Q35XNRyA
 /ecTUp0GJctUzeCgnKs5kcP0WPYqlxQlHRhMM/sTB0ekZ57OsCyhHFvU5408FKaaAG02
 oLS9VTmieGh7KKz3jxkK1zEcRwBbNW2uT2Utclp8BauleRMHSYS7NjZTRKr880LdT3hU
 Kw+u3E/PvPm3a3nZJNMREDbWd6CMJ9gbWh2O7LMHq8FbFfck6SjdNrQ27RtBrtmgI8qQ
 lffw==
X-Gm-Message-State: AOAM533bOJL1a0DMZP7Rl1yj6S8Job0ArrZr7IUxSW/yf4IiPEKoxATb
 AdNi76MDqs7BGFF+JxZ3IH1S3XqEwVdMFg==
X-Google-Smtp-Source: ABdhPJxQnnRF3vFGMNQD8f9kgH4uBN0C9i1UwTU64XSIdTRdJHukLjnCznYARN/GhfY2TBK+dbJGMQ==
X-Received: by 2002:a65:524b:: with SMTP id q11mr1455199pgp.372.1598624405567; 
 Fri, 28 Aug 2020 07:20:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 26/76] target/microblaze: Use DISAS_NORETURN
Date: Fri, 28 Aug 2020 07:18:39 -0700
Message-Id: <20200828141929.77854-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both exceptions and gen_goto_tb do not return.  Use the
official DISAS_NORETURN enumerator for this case.
This eliminates all use of DISAS_TB_JUMP.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0c9b4ffa5a..53ca0bfb38 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -51,7 +51,6 @@
 /* is_jmp field values */
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
-#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
@@ -111,7 +110,7 @@ static void gen_raise_exception(DisasContext *dc, uint32_t index)
 
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-    dc->is_jmp = DISAS_UPDATE;
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_raise_exception_sync(DisasContext *dc, uint32_t index)
@@ -149,6 +148,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
         tcg_gen_movi_i32(cpu_pc, dest);
         tcg_gen_exit_tb(NULL, 0);
     }
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 /*
@@ -1675,7 +1675,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                 } else if (dc->jmp == JMP_DIRECT) {
                     t_sync_flags(dc);
                     gen_goto_tb(dc, 0, dc->jmp_pc);
-                    dc->is_jmp = DISAS_TB_JUMP;
                 } else if (dc->jmp == JMP_DIRECT_CC) {
                     TCGLabel *l1 = gen_new_label();
                     t_sync_flags(dc);
@@ -1684,8 +1683,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                     gen_goto_tb(dc, 1, dc->pc);
                     gen_set_label(l1);
                     gen_goto_tb(dc, 0, dc->jmp_pc);
-
-                    dc->is_jmp = DISAS_TB_JUMP;
                 }
                 break;
             }
@@ -1717,7 +1714,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     }
     t_sync_flags(dc);
 
-    if (unlikely(cs->singlestep_enabled)) {
+    if (dc->is_jmp == DISAS_NORETURN) {
+        /* nothing more to generate */
+    } else if (unlikely(cs->singlestep_enabled)) {
         TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
 
         if (dc->is_jmp != DISAS_JUMP) {
@@ -1730,16 +1729,14 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
             case DISAS_NEXT:
                 gen_goto_tb(dc, 1, npc);
                 break;
-            default:
             case DISAS_JUMP:
             case DISAS_UPDATE:
                 /* indicate that the hash table must be used
                    to find the next TB */
                 tcg_gen_exit_tb(NULL, 0);
                 break;
-            case DISAS_TB_JUMP:
-                /* nothing more to generate */
-                break;
+            default:
+                g_assert_not_reached();
         }
     }
     gen_tb_end(tb, num_insns);
-- 
2.25.1


