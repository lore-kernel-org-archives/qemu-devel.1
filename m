Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFDEC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EBE2077C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCeWDVg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EBE2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36639 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGO0L-0005Mp-Oj
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:20:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfc-0005BH-Qs
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfa-0001Yo-Qg
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfY-0001UY-OM
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h4so26944892wre.7
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=qLgEBtxDMPEzuBe7c1di3k/rR2yFAimlmfsizuzN9Vs=;
	b=pCeWDVg5cXABpoyA+GQjCY8a5j7WcYkOlSG2rQ3THyez8WUJWQ0B9oF0m7rm5pHc73
	RhUYoJDo4hfE30a+Snh6b8FM5fXwiQMxX2VkBddhuG6ZYcyLqGEvlVLpZZ+ZSJEws+Dk
	7qaf94da/NfAICDDJHEBflfWtthoHU6dRJ1K1bddVoy8aprPHGEQtDLwpymWR5oUheGA
	heoTdV+lH8LjzcL/j7l8LYz6XWjrs7hqkcI05Vktp8zImgnXit+EzntrkHKeIjZ+6O8V
	LZ1NZO3cDPRgPphuVoSWDTs2h4FMARG8IVRiS2dGleZiD/7EbhPqmG74+pgUtmMmYyN8
	oFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=qLgEBtxDMPEzuBe7c1di3k/rR2yFAimlmfsizuzN9Vs=;
	b=Az6waESSeiZiOr0OaLbCsJB+vZ3mFFfkEZ8kvDQ9mpH7zMFkJZOEu0ot4BkV3JiSBA
	/ncWFnwtqOM1GV8pI77+xj451ZtXivIyHAR0ZNXa4LBqobMjuGIKqIANiYiuZf3jd9Ij
	y3kqcK+ATLomRGxXs6xsK4oFO4HB0gRFOZFiTdUoX9unZqXtTUE4RJ4+rE1RF/G8oWJo
	D21tdD+ZZrjvn7OhOVuXBUbMgGS8hkIUoVJu9QqLj5U9OOnBaSkqW+PLSJpiXoiqewMq
	HmoF1khVIH3GNDtHb0v9eZA8RRnqWdTEH39fubeuC74LFPwA9hjqOuFGtMGZnWFY0Yy3
	SyOw==
X-Gm-Message-State: APjAAAVwQ8eQ4/RCesGtGuKqsL9c8N6puB6onJ+NiNNdfwBgIkwQeVdh
	XoqoAqScvrpJJOA2NgvHaxwCcA==
X-Google-Smtp-Source: APXvYqw2Dp4Zkodw3y1ib9jd3buSAi7zSYi2y2MC2/vZm1uq96W5KMpECXzjhNgreQnq9QRA6gXxgQ==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr49993536wrn.90.1555419513913; 
	Tue, 16 Apr 2019 05:58:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:43 +0100
Message-Id: <20190416125744.27770-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PATCH 25/26] target/arm: Implement VLLDM for v7M CPUs
 with an FPU
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125743.bLEkggVsMuCO8PFgsEmo5iecbENwZ5e91bhnuQhaX-0@z>

Implement the VLLDM instruction for v7M for the FPU present cas.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h    |  1 +
 target/arm/helper.c    | 54 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.c |  2 +-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 62051ae6d51..50cb036378b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -72,6 +72,7 @@ DEF_HELPER_3(v7m_tt, i32, env, i32, i32)
 DEF_HELPER_1(v7m_preserve_fp_state, void, env)
 
 DEF_HELPER_2(v7m_vlstm, void, env, i32)
+DEF_HELPER_2(v7m_vlldm, void, env, i32)
 
 DEF_HELPER_2(v8m_stackcheck, void, env, i32)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ad049b2d9bc..4b680c379dc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7395,6 +7395,12 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     g_assert_not_reached();
 }
 
+void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
 uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 {
     /* The TT instructions can be used by unprivileged code, but in
@@ -8479,6 +8485,54 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
 }
 
+void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
+{
+    /* fptr is the value of Rn, the frame pointer we load the FP regs from */
+    assert(env->v7m.secure);
+
+    if (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)) {
+        return;
+    }
+
+    /* Check access to the coprocessor is permitted */
+    if (!v7m_cpacr_pass(env, true, arm_current_el(env) != 0)) {
+        raise_exception_ra(env, EXCP_NOCP, 0, 1, GETPC());
+    }
+
+    if (env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPACT_MASK) {
+        /* State in FP is still valid */
+        env->v7m.fpccr[M_REG_S] &= ~R_V7M_FPCCR_LSPACT_MASK;
+    } else {
+        bool ts = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_TS_MASK;
+        int i;
+        uint32_t fpscr;
+
+        if (fptr & 7) {
+            raise_exception_ra(env, EXCP_UNALIGNED, 0, 1, GETPC());
+        }
+
+        for (i = 0; i < (ts ? 32 : 16); i += 2) {
+            uint32_t slo, shi;
+            uint64_t dn;
+            uint32_t faddr = fptr + 4 * i;
+
+            if (i >= 16) {
+                faddr += 8; /* skip the slot for the FPSCR */
+            }
+
+            slo = cpu_ldl_data(env, faddr);
+            shi = cpu_ldl_data(env, faddr + 4);
+
+            dn = (uint64_t) shi << 32 | slo;
+            *aa32_vfp_dreg(env, i / 2) = dn;
+        }
+        fpscr = cpu_ldl_data(env, fptr + 0x40);
+        vfp_set_fpscr(env, fpscr);
+    }
+
+    env->v7m.control[M_REG_S] |= R_V7M_CONTROL_FPCA_MASK;
+}
+
 static bool v7m_push_stack(ARMCPU *cpu)
 {
     /* Do the "set up stack frame" part of exception entry,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index db478b779a9..5ad9923715e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11822,7 +11822,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     TCGv_i32 fptr = load_reg(s, rn);
 
                     if (extract32(insn, 20, 1)) {
-                        /* VLLDM */
+                        gen_helper_v7m_vlldm(cpu_env, fptr);
                     } else {
                         gen_helper_v7m_vlstm(cpu_env, fptr);
                     }
-- 
2.20.1


