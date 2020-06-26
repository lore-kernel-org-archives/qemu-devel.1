Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D91C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D51620709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Av9D5SVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D51620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jof94-00060k-Tu
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5p-0007th-0N
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:31:57 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:42925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5n-0001kL-46
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:31:56 -0400
Received: by mail-pg1-x529.google.com with SMTP id e9so4345972pgo.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ylDk8PkvrYo5RCWHHinf/7TvINaMJjZipC+Ie2QRVo=;
 b=Av9D5SVXBUcZ4gKVk1sJ6jZ3kqKdR+oq0o3j5rUn95/Y5bzTN8P3CbDDaezEl7gHGL
 c8s12z9D6zLM/xIqoMHyNrhUaYg2RzYwgiSirkdY0psGsf3VHvN15DVZZteiWN380mZt
 YBoqNPqYAlgm7dX0mITlzzfmp2XQ/mzRJ5MFKLS8raltAbnWHxa0jqirC3kwyeBPUcbN
 uFw30/U267gj4cZYhZt632ZE3nDdzm60lEI+bTE+5PykyGZcQi5vREhmKNcK6tJt/+4j
 wbGK+rAlTUacnY20ih0G+VOE06qi8DvSQUWo9kjAe35A0c35TOkdF4kdKnLbmupE5VLI
 IRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ylDk8PkvrYo5RCWHHinf/7TvINaMJjZipC+Ie2QRVo=;
 b=MtqoNO9HzBJHgLIR2qQGwcmrYE6J67O6LobulFXPjsKev0iGSztpy0LVnGqF+SrssZ
 ++wiqcQFMAIfoNl/CW2Rxx8SWsIRs0rGxsK+ixK1JjuCU6Jqy4Wy5O3rop7BGN61Mgoj
 vgrtMUx8GjqWNoDViJEER4CaoKcCCTlpOI8KXSGhzewpIT98FbFB5reaMKFlvGgP2eAU
 53T630cVYvgPEOfTmZ0RFXT5S6wJqUY8jpJD039krxRmVuEwKwT/yXpvizuZZ0Ca7K2s
 aH7EMefM353U5waH8eC23Kbibqq5/MrHVKShmZJFIEk+S1BlYnDcyLfpYUW3mw6hMKmf
 9YEA==
X-Gm-Message-State: AOAM530QEA28gbxJgeQioQDtsM/Z1vnD5z8SeWAK9Swed41mVyeCiGrM
 sFGZA0rMMRsI9pnvPPJ+sVAd5mGPP5c=
X-Google-Smtp-Source: ABdhPJzhcgM+PaR2MheApHsxeM1Za6CxSctbm76tTXhQNqe90RDIIy1P19oNTrV4iUoplw/W9Oej8Q==
X-Received: by 2002:a63:7c51:: with SMTP id l17mr899185pgn.303.1593142313248; 
 Thu, 25 Jun 2020 20:31:53 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 05/46] target/arm: Rename DISAS_UPDATE to DISAS_UPDATE_EXIT
Date: Thu, 25 Jun 2020 20:31:03 -0700
Message-Id: <20200626033144.790098-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Emphasize that the is_jmp option exits to the main loop.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h         | 14 ++++++++------
 target/arm/translate-a64.c     |  8 ++++----
 target/arm/translate-vfp.inc.c |  4 ++--
 target/arm/translate.c         | 12 ++++++------
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 19650a9e2d..d5edef2943 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -148,7 +148,8 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 
 /* is_jmp field values */
 #define DISAS_JUMP      DISAS_TARGET_0 /* only pc was modified dynamically */
-#define DISAS_UPDATE    DISAS_TARGET_1 /* cpu state was modified dynamically */
+/* CPU state was modified dynamically; exit to main loop for interrupts. */
+#define DISAS_UPDATE_EXIT  DISAS_TARGET_1
 /* These instructions trap after executing, so the A32/T32 decoder must
  * defer them until after the conditional execution state has been updated.
  * WFI also needs special handling when single-stepping.
@@ -164,11 +165,12 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
  * custom end-of-TB code)
  */
 #define DISAS_BX_EXCRET DISAS_TARGET_8
-/* For instructions which want an immediate exit to the main loop,
- * as opposed to attempting to use lookup_and_goto_ptr. Unlike
- * DISAS_UPDATE this doesn't write the PC on exiting the translation
- * loop so you need to ensure something (gen_a64_set_pc_im or runtime
- * helper) has done so before we reach return from cpu_tb_exec.
+/*
+ * For instructions which want an immediate exit to the main loop, as opposed
+ * to attempting to use lookup_and_goto_ptr.  Unlike DISAS_UPDATE_EXIT, this
+ * doesn't write the PC on exiting the translation loop so you need to ensure
+ * something (gen_a64_set_pc_im or runtime helper) has done so before we reach
+ * return from cpu_tb_exec.
  */
 #define DISAS_EXIT      DISAS_TARGET_9
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4cef862c41..e4795ae100 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1616,7 +1616,7 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         gen_helper_msr_i_daifclear(cpu_env, t1);
         tcg_temp_free_i32(t1);
         /* For DAIFClear, exit the cpu loop to re-evaluate pending IRQs.  */
-        s->base.is_jmp = DISAS_UPDATE;
+        s->base.is_jmp = DISAS_UPDATE_EXIT;
         break;
 
     default:
@@ -1795,7 +1795,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
 
     if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
-        s->base.is_jmp = DISAS_UPDATE;
+        s->base.is_jmp = DISAS_UPDATE_EXIT;
     }
     if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /*
@@ -1810,7 +1810,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
-        s->base.is_jmp = DISAS_UPDATE;
+        s->base.is_jmp = DISAS_UPDATE_EXIT;
     }
 }
 
@@ -14292,7 +14292,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_goto_tb(dc, 1, dc->base.pc_next);
             break;
         default:
-        case DISAS_UPDATE:
+        case DISAS_UPDATE_EXIT:
             gen_a64_set_pc_im(dc->base.pc_next);
             /* fall through */
         case DISAS_EXIT:
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index bf31b18657..afa8a5f888 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -123,7 +123,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
              * this to be the last insn in the TB).
              */
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                s->base.is_jmp = DISAS_UPDATE;
+                s->base.is_jmp = DISAS_UPDATE_EXIT;
                 gen_io_start();
             }
             gen_helper_v7m_preserve_fp_state(cpu_env);
@@ -2860,6 +2860,6 @@ static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
     tcg_temp_free_i32(fptr);
 
     /* End the TB, because we have updated FP control bits */
-    s->base.is_jmp = DISAS_UPDATE;
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
     return true;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 795964da1f..146ff5ddc2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2775,7 +2775,7 @@ static void gen_msr_banked(DisasContext *s, int r, int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     tcg_temp_free_i32(tcg_reg);
-    s->base.is_jmp = DISAS_UPDATE;
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
 }
 
 static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
@@ -2797,7 +2797,7 @@ static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     store_reg(s, rn, tcg_reg);
-    s->base.is_jmp = DISAS_UPDATE;
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
 }
 
 /* Store value to PC as for an exception return (ie don't
@@ -5114,7 +5114,7 @@ static void gen_srs(DisasContext *s,
         tcg_temp_free_i32(tmp);
     }
     tcg_temp_free_i32(addr);
-    s->base.is_jmp = DISAS_UPDATE;
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
 }
 
 /* Generate a label used for skipping this instruction */
@@ -8160,7 +8160,7 @@ static bool trans_SETEND(DisasContext *s, arg_SETEND *a)
     }
     if (a->E != (s->be_data == MO_BE)) {
         gen_helper_setend(cpu_env);
-        s->base.is_jmp = DISAS_UPDATE;
+        s->base.is_jmp = DISAS_UPDATE_EXIT;
     }
     return true;
 }
@@ -8873,7 +8873,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
-        case DISAS_UPDATE:
+        case DISAS_UPDATE_EXIT:
             gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
@@ -8900,7 +8900,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_JUMP:
             gen_goto_ptr();
             break;
-        case DISAS_UPDATE:
+        case DISAS_UPDATE_EXIT:
             gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
-- 
2.25.1


