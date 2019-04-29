Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB10C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131872075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+SwSahC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131872075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60905 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9zp-0006BS-7q
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:23:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004r2-3K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9en-0006jp-Pz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9el-0006ZN-7e
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id h11so154899wmb.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=lJUudDaDiId6vq4HrX2mxmCThhHruq8pKrvlbVUyK2U=;
	b=t+SwSahCawCOpjr0YYmfOwihSyKCmueeHtMqtL0bmeY5I/VbgSQEu9v5G0ajUxseM9
	rgsEJI8W15al+V0naZBb1jYTpy0rkCjGdAV4bppYRzjEqcgiSM1awu30C+K73hj0tymj
	a6PWbMq+W9IGCkrPVEQ5owudlW0iDa2mAebAOWqYdafm0Bmcg7Mf4dQ1Txuz3T9DPSxp
	R4Ql9usadujPXnR3J5w2fKDGiJ4f6ildOq66EIJ4Na0ZFFygf+kXL4GqZQUbuPNufJ6R
	LkhmwKsaA7R/518COfgSU8RpD6+nbcwXy+31iSwwAdkSQnMCrsq8ER3KKKpf8HkujEFI
	hj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lJUudDaDiId6vq4HrX2mxmCThhHruq8pKrvlbVUyK2U=;
	b=rRyb2oypwFeW0F0XagZ/v5H6VanEwvyAofABFv7moDXTtQ7EVDTwVLEO5GVJRz3loi
	4NddGrdtweV1GEppvXMCFmCjS5Sln6TOJ3e2oVkkryCssXTHZDOV07JOJgfI+q7QQBRf
	pYqDqxbAOJyt6aVuDBN3wmDsYajeKiPaKzLBZb1VgigQyjoTo5f8KjD+GuyIYwa9JwY/
	/n049WskcHpGhM+FJq63b9zG3he5Yhd/F+iEGT+26STf6SnJCW65BYKUsrP4crKvZrbG
	kltZmDl/4Mu0MIX1hs2YERWuU2qwJb4FY0LPl1ztc/M1+Rsim6FVuKzvWxQtlqdNv+SO
	Vqhg==
X-Gm-Message-State: APjAAAXWA33MZMLXi7HGMxdrZK0SaJ+XWmcQzFkKTZb+wXhryhWXuO2f
	STAPPQgoNmxE9fVXjP8Vo1pawWT5YFo=
X-Google-Smtp-Source: APXvYqxnjsfsqkN2rCl0yW/fQnrTD2y+uLbbNzXLt8nN00ofQN16BgFab9ZrRdueDDpIGXnWOFFoAg==
X-Received: by 2002:a1c:ef08:: with SMTP id n8mr27597wmh.85.1556557268940;
	Mon, 29 Apr 2019 10:01:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.07
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:16 +0100
Message-Id: <20190429170030.11323-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PULL 28/42] target/arm: Implement VLLDM for v7M CPUs
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
Message-ID: <20190429170016.qBpbY4YqQmXGnMa03vjMkYWHo-aDwvH2QjOChZvSo7Q@z>

Implement the VLLDM instruction for v7M for the FPU present cas.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-26-peter.maydell@linaro.org
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
index b821037c3b6..81a92ab4911 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7390,6 +7390,12 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
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
@@ -8474,6 +8480,54 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
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
index 99b38dd5f2b..10bc53f91c6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11823,7 +11823,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     TCGv_i32 fptr = load_reg(s, rn);
 
                     if (extract32(insn, 20, 1)) {
-                        /* VLLDM */
+                        gen_helper_v7m_vlldm(cpu_env, fptr);
                     } else {
                         gen_helper_v7m_vlstm(cpu_env, fptr);
                     }
-- 
2.20.1


