Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379E3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081D020679
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl8qW9tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081D020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD1q-00081p-86
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQl-0003ep-5k; Tue, 16 Jun 2020 10:19:15 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQh-0006yP-VW; Tue, 16 Jun 2020 10:19:14 -0400
Received: by mail-ot1-x341.google.com with SMTP id g5so16044090otg.6;
 Tue, 16 Jun 2020 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iy2OuoLC+tcFJT1W5sFxWuwcrtbM/mLRHy96HLFDfHY=;
 b=nl8qW9tQijZMB0AmSCgV2leGmJazbrQr68rNh2j34c9dc8eoVLMZ8py990VIfzQPD9
 ZYMm1Cr4yiP6A7ZMtnfkDrK+ZRkgBcUYs5VGRpemjZfhRW258M3dyrgA/E5+KMF6BXTq
 CUgXVumSAdpKXqvfDe6a14ONlNANaKcZQ4kgXtzsMAggGZGGGVwcre6h79Zd0a6Yv6/w
 zy2IrIBqp6C182BQeBtoY07hUZGdPKiFqD0bYOYYieSqUM9u2Kmu1pi0IK+nkBx4yIAn
 /7MdjaYz0ZlFXh3VnxyhZtYc1FP5q/S96JvOFawDGUeuTCs/hyKsE1YbBQCtNUIJljmw
 /Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iy2OuoLC+tcFJT1W5sFxWuwcrtbM/mLRHy96HLFDfHY=;
 b=F5QJCa1xV5fwx+U/mSp3gjYkfVVpBoJ5mjCk9LfG0SxK77uKfrAtvfzhaS9E3ERnL9
 yKXZ8HHvua+6CW+6AegEJhkW3LWtEBltMiWD6wLnnz6GgFVlFp2lX/jPCTyEB9fb4hyA
 am0Dz5InQzz0YMIuwWZmslO48s6TkQ33HncbOroruHsm+KNpFhh4tZyWaBE+muylI+mS
 zDBnJVyDafo3FRdzeSVE9JLGaNhR5lVPnFIvh+bkH9R1qm9+YImfxjMLuLW0hLhkTkQZ
 ibGLoDI+sZocAa0TgSdzuDevhsUYbSHW266W94c//lzd/ESgZUKfLI44mOm55tn5rp4O
 h6rA==
X-Gm-Message-State: AOAM530m0EOprwgj34aDphffbnFDCQBWt0VXGCFnT+hsFfWHmamWAolz
 cwkk9IiUxnwDlNYGAUbhd1K7zKbw
X-Google-Smtp-Source: ABdhPJwi5IsoCDqqu+xr8LHIj9U3DVOIAqAqHyOOVAiRsfBfUSjz2SJyz0hGnaSoz7XOgh+hiKeenw==
X-Received: by 2002:a05:6830:1443:: with SMTP id
 w3mr2512025otp.142.1592317149526; 
 Tue, 16 Jun 2020 07:19:09 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g24sm4098743otl.8.2020.06.16.07.19.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:08 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/78] target/arm: ensure we use current exception state after
 SCR update
Date: Tue, 16 Jun 2020 09:14:34 -0500
Message-Id: <20200616141547.24664-6-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

A write to the SCR can change the effective EL by droppping the system
from secure to non-secure mode. However if we use a cached current_el
from before the change we'll rebuild the flags incorrectly. To fix
this we introduce the ARM_CP_NEWEL CP flag to indicate the new EL
should be used when recomputing the flags.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191212114734.6962-1-alex.bennee@linaro.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191209143723.6368-1-alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit f80741d107673f162e3b097fc76a1590036cc9d1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/cpu.h       |  8 ++++++--
 target/arm/helper.c    | 14 +++++++++++++-
 target/arm/helper.h    |  1 +
 target/arm/translate.c |  6 +++++-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83a809d4ba..c3ab47d896 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2238,6 +2238,9 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
  * RAISES_EXC is for when the read or write hook might raise an exception;
  * the generated code will synchronize the CPU state before calling the hook
  * so that it is safe for the hook to call raise_exception().
+ * NEWEL is for writes to registers that might change the exception
+ * level - typically on older ARM chips. For those cases we need to
+ * re-read the new el when recomputing the translation flags.
  */
 #define ARM_CP_SPECIAL           0x0001
 #define ARM_CP_CONST             0x0002
@@ -2257,10 +2260,11 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_SVE               0x2000
 #define ARM_CP_NO_GDB            0x4000
 #define ARM_CP_RAISES_EXC        0x8000
+#define ARM_CP_NEWEL             0x10000
 /* Used only as a terminator for ARMCPRegInfo lists */
-#define ARM_CP_SENTINEL          0xffff
+#define ARM_CP_SENTINEL          0xfffff
 /* Mask of only the flag bits in a type field */
-#define ARM_CP_FLAG_MASK         0xf0ff
+#define ARM_CP_FLAG_MASK         0x1f0ff
 
 /* Valid values for ARMCPRegInfo state field, indicating which of
  * the AArch32 and AArch64 execution states this register is visible in.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0bf8f53d4b..b92ef9d190 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5096,7 +5096,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.scr_el3),
       .resetvalue = 0, .writefn = scr_write },
-    { .name = "SCR",  .type = ARM_CP_ALIAS,
+    { .name = "SCR",  .type = ARM_CP_ALIAS | ARM_CP_NEWEL,
       .cp = 15, .opc1 = 0, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.scr_el3),
@@ -11332,6 +11332,18 @@ void HELPER(rebuild_hflags_m32)(CPUARMState *env, int el)
     env->hflags = rebuild_hflags_m32(env, fp_el, mmu_idx);
 }
 
+/*
+ * If we have triggered a EL state change we can't rely on the
+ * translator having passed it too us, we need to recompute.
+ */
+void HELPER(rebuild_hflags_a32_newel)(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
+    env->hflags = rebuild_hflags_a32(env, fp_el, mmu_idx);
+}
+
 void HELPER(rebuild_hflags_a32)(CPUARMState *env, int el)
 {
     int fp_el = fp_exception_el(env, el);
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3d4ec267a2..e345bdb726 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -91,6 +91,7 @@ DEF_HELPER_2(get_user_reg, i32, env, i32)
 DEF_HELPER_3(set_user_reg, void, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(rebuild_hflags_m32, TCG_CALL_NO_RWG, void, env, int)
+DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4d5d4bd888..83aa331b1e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7083,7 +7083,11 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             if (arm_dc_feature(s, ARM_FEATURE_M)) {
                 gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
             } else {
-                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+                if (ri->type & ARM_CP_NEWEL) {
+                    gen_helper_rebuild_hflags_a32_newel(cpu_env);
+                } else {
+                    gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+                }
             }
             tcg_temp_free_i32(tcg_el);
             /*
-- 
2.17.1


