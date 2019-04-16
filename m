Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB34C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1452077C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0wRlz97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1452077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36557 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNup-00011q-C9
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:14:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfW-00053W-Lx
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfU-0001Tb-I1
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfS-0001P2-LE
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:30 -0400
Received: by mail-wm1-x341.google.com with SMTP id q16so25248636wmj.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=qUOb6S/RgXvQ6vDGgTslHclSF/T9I1n8yCzB97vIhKM=;
	b=q0wRlz97jWA6BRXVWBXn0RNQCwmQNMNXnmt6VfkA7h5a+rmzXCTCK98UM5rQOX408M
	GbcTHX80n3AVs1ybVXg5i1h6a0DuCIcTfDmnNEOzPb+8ynXyW05g0weFCA/AYzLXsYSF
	WK2gfJhshqVxjSS3iLRJ92tTabws8Q8mNDwSwtntR5KO65sj26UeXise783lKchmooDo
	TpXjqfyb5TPlhDhncTKCoIY9caokvlobJ9jCH5hnG5UUmaZjSGDm1Z6CludCUedGxRUg
	qVgGijTXRdvLWXgWoqplQ3IgYaPBTGWC+hOXqQdbQ76OUuyGE2wZkEP9v7NiwAi1I9Qs
	/bLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=qUOb6S/RgXvQ6vDGgTslHclSF/T9I1n8yCzB97vIhKM=;
	b=Xvi0F1HPMekhIRtyZbVC3NHEcLK5scOALnIqlZyF9PEapmo4c0wzMnPi08UtNKKAF5
	C41c5GCMmmCC1QVW2CafCOF+9t4CYcf7ojKQo7wIqDcJk5KfmlV/Ackg6HkU55iBzKyL
	zHtk1dBbpRTbNDFmXb+erLWEIu7yvjczy90VredpqTsIbH7L0IhDUKMY6lOEIMAvNZTQ
	BT1sop83X4UwQ/E2b07icN94Tgm6ywNnJOTkzjCvva4+aAUJlX7zfueq68OhtD5LOX08
	Ne+F1SjQZSEIvPxp9mjBNT3h+gBmlr8DtYvfbuDoRXxa7wvYiU54JfXD/10zFnrSo5pn
	hiMw==
X-Gm-Message-State: APjAAAV+h8DGgoZxZTnQKHdHillzeu8rjIu47UTo5VN4bZIcDd74mNL4
	CascONMpC5uraG8LK7hl929aNA==
X-Google-Smtp-Source: APXvYqyDvycWohBQGjX7DojDg2vclF+iM7R9WAF2BFBjHs7P6SVGhyDT+k9p3DSY8U0tIyx7Oy3lcA==
X-Received: by 2002:a1c:1d97:: with SMTP id
	d145mr25767145wmd.136.1555419504688; 
	Tue, 16 Apr 2019 05:58:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:36 +0100
Message-Id: <20190416125744.27770-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 18/26] target/arm: Set FPCCR.S when executing
 M-profile floating point insns
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
Message-ID: <20190416125736.8RkpgaZzbkwWL_3E6-n29k2gIrXTvmCKasbWf-UiN1M@z>

The M-profile FPCCR.S bit indicates the security status of
the floating point context. In the pseudocode ExecuteFPCheck()
function it is unconditionally set to match the current
security state whenever a floating point instruction is
executed.

Implement this by adding a new TB flag which tracks whether
FPCCR.S is different from the current security state, so
that we only need to emit the code to update it in the
less-common case when it is not already set correctly.

Note that we will add the handling for the other work done
by ExecuteFPCheck() in later commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  2 ++
 target/arm/translate.h |  1 +
 target/arm/helper.c    |  5 +++++
 target/arm/translate.c | 20 ++++++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a4e4d17e787..95924303dd5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3154,6 +3154,8 @@ FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
+/* For M profile only, set if FPCCR.S does not match current security state */
+FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1)
 /* For M profile only, Handler (ie not Thread) mode */
 FIELD(TBFLAG_A32, HANDLER, 21, 1)
 /* For M profile only, whether we should generate stack-limit checks */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 912cc2a4a52..26b2c29bb57 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -40,6 +40,7 @@ typedef struct DisasContext {
     bool v7m_handler_mode;
     bool v8m_secure; /* true if v8M and we're in Secure mode */
     bool v8m_stackcheck; /* true if we need to perform v8M stack limit checks */
+    bool v8m_fpccr_s_wrong; /* true if v8M FPCCR.S != v8m_secure */
     /* Immediate value in AArch32 SVC insn; must be set if is_jmp == DISAS_SWI
      * so that top level loop can generate correct syndrome information.
      */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d8a9620b870..539da192e4e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13422,6 +13422,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
     }
 
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
+        FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S) != env->v7m.secure) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
+    }
+
     *pflags = flags;
     *cs_base = 0;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9172a382c4d..a4fb811d6f2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3420,6 +3420,25 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
         }
     }
 
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        /* Handle M-profile lazy FP state mechanics */
+
+        /* Update ownership of FP context: set FPCCR.S to match current state */
+        if (s->v8m_fpccr_s_wrong) {
+            TCGv_i32 tmp;
+
+            tmp = load_cpu_field(v7m.fpccr[M_REG_S]);
+            if (s->v8m_secure) {
+                tcg_gen_ori_i32(tmp, tmp, R_V7M_FPCCR_S_MASK);
+            } else {
+                tcg_gen_andi_i32(tmp, tmp, ~R_V7M_FPCCR_S_MASK);
+            }
+            store_cpu_field(tmp, v7m.fpccr[M_REG_S]);
+            /* Don't need to do this for any further FP insns in this TB */
+            s->v8m_fpccr_s_wrong = false;
+        }
+    }
+
     if (extract32(insn, 28, 4) == 0xf) {
         /*
          * Encodings with T=1 (Thumb) or unconditional (ARM):
@@ -13340,6 +13359,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->v8m_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
         regime_is_secure(env, dc->mmu_idx);
     dc->v8m_stackcheck = FIELD_EX32(tb_flags, TBFLAG_A32, STACKCHECK);
+    dc->v8m_fpccr_s_wrong = FIELD_EX32(tb_flags, TBFLAG_A32, FPCCR_S_WRONG);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.20.1


