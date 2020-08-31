Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA7DC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0629D20719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e69b8CsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0629D20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmnl-0000CT-8C
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLW-00072n-Mx
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:50 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLU-0006CK-OU
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:50 -0400
Received: by mail-pg1-x544.google.com with SMTP id i10so846115pgk.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1WdUOJWGCdcV9QIGGOS0y70LT85NGsncqmvGoqTi8AE=;
 b=e69b8CsJeYkWnBKvekJVHEOqMk9y1E4fM/sL+A12hFC5kyXMEE4NYTB9HkSwooL6Z1
 tuIJCTBcW9Fn6CF1UGzNux4+Q/kpIcCjBW0025jOvaepFCcRdpnuDsh8/asu0GrEj+Zx
 CjW6ji916SXGhWbeHNjoQLdICCwiNcSRVrI7WJmtJeOb8/yeKu0V8EeRTlX2fRv/aU3P
 GjC4kfEMqWK/f/reTysvW86vO1n7PJ0sLRUGOdzCppqiLBWZRbYR2lSB7GYvxurAqKQ4
 IYWCWsI2YI+QesbKQkCRdiV4g3u3vPdWJqignyDN9nCS0jYrNiBYoWpzl4882ji7bDkS
 G+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1WdUOJWGCdcV9QIGGOS0y70LT85NGsncqmvGoqTi8AE=;
 b=OoDKvVwxZt5PukGYZMMWA7E0RI16UHW4swXM+VovC2pHcOQNxGIYoIIAXOPjsDPwfq
 fMGerLys+PvZ7Bv3Ao3qcraMvHkV66HzDDQcyW5btw6IYzfRNBIJ8uG57vKh5oHVGG8r
 gxFXAj4rixH/zJ/5ZDduCpnAqDfJ4WeLcSCM/mLaAzc6XMKpZ0NdQdMrE2uIv0Q7NuHN
 sThQ8CG5K8pFj9y+yLvumFr/CvILSDsFyhFht4chUH4jvIEOqnBMsOoxPaNeCsAvMv/n
 t6ssf/DMF/uLTCSUcpYCC8tGLnV/LGYR8AX9iMdKP3kaovJoko77Dy3XX8Gwy1tQtT90
 eMjA==
X-Gm-Message-State: AOAM532lPc5eQgWuXdmCx8reWTLbRaTH54jBY3pK4K43uh/FV3wJL3O4
 pRYYNqHW+lb+//xKc+x7XtWtYzcHWGXGxA==
X-Google-Smtp-Source: ABdhPJzFbcohSmZKJviXBgQG6bENMT3+OcH0MDMKGiZL7tgmnD5bsreHKmqLzefXolvheZu9Ev9WYA==
X-Received: by 2002:a65:6882:: with SMTP id e2mr1803507pgt.290.1598890065867; 
 Mon, 31 Aug 2020 09:07:45 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 76/76] target/microblaze: Reduce linux-user address space to
 32-bit
Date: Mon, 31 Aug 2020 09:06:01 -0700
Message-Id: <20200831160601.833692-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User-space programs cannot use the 64-bit lwea/swea instructions.
We can improve code generation and runtime by restricting the
user-only address space to 32-bit.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu-param.h | 15 +++++++++++++++
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/helper.c    |  4 ++--
 target/microblaze/translate.c | 28 +++++++++++++++++++++++++++-
 4 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index 4abbc62d50..4d8297fa94 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -8,9 +8,24 @@
 #ifndef MICROBLAZE_CPU_PARAM_H
 #define MICROBLAZE_CPU_PARAM_H 1
 
+/*
+ * While system mode can address up to 64 bits of address space,
+ * this is done via the lea/sea instructions, which are system-only
+ * (as they also bypass the mmu).
+ *
+ * We can improve the user-only experience by only exposing 32 bits
+ * of address space.
+ */
+#ifdef CONFIG_USER_ONLY
+#define TARGET_LONG_BITS 32
+#define TARGET_PHYS_ADDR_SPACE_BITS 32
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
+#else
 #define TARGET_LONG_BITS 64
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
+#endif
+
 /* FIXME: MB uses variable pages down to 1K but linux only uses 4k.  */
 #define TARGET_PAGE_BITS 12
 #define NB_MMU_MODES 3
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 4298f242a6..d11b6fa995 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -242,7 +242,7 @@ struct CPUMBState {
     uint32_t pc;
     uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
     uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
-    uint64_t ear;
+    target_ulong ear;
     uint32_t esr;
     uint32_t fsr;
     uint32_t btr;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 1667822fb7..48547385b0 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -303,8 +303,8 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     iflags = cpu->env.iflags;
 
     qemu_log_mask(CPU_LOG_INT,
-                  "Unaligned access addr=" TARGET_FMT_lx
-                  " pc=%x iflags=%x\n", addr, cpu->env.pc, iflags);
+                  "Unaligned access addr=" TARGET_FMT_lx " pc=%x iflags=%x\n",
+                  (target_ulong)addr, cpu->env.pc, iflags);
 
     esr = ESR_EC_UNALIGNED_DATA;
     if (likely(iflags & ESR_ESS_FLAG)) {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8c287457a9..a377818b5e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -687,6 +687,7 @@ static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
     return ret;
 }
 
+#ifndef CONFIG_USER_ONLY
 static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 {
     int addr_size = dc->cpu->cfg.addr_size;
@@ -712,6 +713,7 @@ static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
     }
     return ret;
 }
+#endif
 
 static void record_unaligned_ess(DisasContext *dc, int rd,
                                  MemOp size, bool store)
@@ -776,8 +778,12 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
     if (trap_userspace(dc, true)) {
         return true;
     }
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UB, MMU_NOMMU_IDX, false);
+#endif
 }
 
 static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
@@ -803,8 +809,12 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
     if (trap_userspace(dc, true)) {
         return true;
     }
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_TEUW, MMU_NOMMU_IDX, false);
+#endif
 }
 
 static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
@@ -830,8 +840,12 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
     if (trap_userspace(dc, true)) {
         return true;
     }
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_TEUL, MMU_NOMMU_IDX, false);
+#endif
 }
 
 static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
@@ -910,8 +924,12 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
     if (trap_userspace(dc, true)) {
         return true;
     }
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UB, MMU_NOMMU_IDX, false);
+#endif
 }
 
 static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
@@ -937,8 +955,12 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
     if (trap_userspace(dc, true)) {
         return true;
     }
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_TEUW, MMU_NOMMU_IDX, false);
+#endif
 }
 
 static bool trans_shi(DisasContext *dc, arg_typeb *arg)
@@ -964,8 +986,12 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
     if (trap_userspace(dc, true)) {
         return true;
     }
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_TEUL, MMU_NOMMU_IDX, false);
+#endif
 }
 
 static bool trans_swi(DisasContext *dc, arg_typeb *arg)
@@ -1818,7 +1844,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 
     qemu_fprintf(f, "\nesr=0x%04x fsr=0x%02x btr=0x%08x edr=0x%x\n"
-                 "ear=0x%016" PRIx64 " slr=0x%x shr=0x%x\n",
+                 "ear=0x" TARGET_FMT_lx " slr=0x%x shr=0x%x\n",
                  env->esr, env->fsr, env->btr, env->edr,
                  env->ear, env->slr, env->shr);
 
-- 
2.25.1


