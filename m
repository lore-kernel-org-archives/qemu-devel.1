Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4631C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3002224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4rXxpIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3002224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuKo-0006pA-TU
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu18-0005Oy-Ka
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:56280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu16-0003wc-Gt
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id a72so2330734wme.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=G63/MCjBMVEHxKf61b0I8Aw8yQgPaMtYsABsXjS/00w=;
 b=Y4rXxpIrLb9TjL8NBixZlUIo6oS+sTWJbYwpiBwoFhHhwF4uTvKqVdbF43qQU+J6DL
 P//GUf98J2WMZikjRHCzIzi4H2D4HtBF7YG8fN+L7YBBHeOEnWzlDzOdA0lKykIVDIyD
 7yZMx0phrx2/UUaQiiXwWxJKn8X+fF1MDlDBFECWtkLPODhPA64R9dFnGtU1/BXfBllO
 MGUkz2QlLK8Vx2F73baI/X9bxXyTO5nQlNutK1P+OTFQrj6iZke4wt3zb0OJ0VZBnsXT
 FZUw0wbESvigghvB73iowj7QFVX3JgGlK3phJYxiGsH3e9awiArRIcG6e24nN08K7LM4
 5mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G63/MCjBMVEHxKf61b0I8Aw8yQgPaMtYsABsXjS/00w=;
 b=uBe5EcI6f68zOawfILZlSrxCDF6m0l28XbYgeHJylOoi6PT8wNHkqDuTPx5nYpCRpI
 5LO1PprJWEPkqKTiG5wbIU/dCv3UTBNe3ySRorZTE2q8mW/RvGxNJxTS4fS8ufxc7684
 XUiNaxbt4yWQaa4oLFePpEFsTRtTqnK+2MPlS/uMo5Tsa5vpnf1Crp1soLk0hiHqK1ny
 aDZiLJ2DdoUGLzMYONDKJl98QnjStB7jcufsanbFfL0B53tvSALbPIHS9HtJojy+M1mW
 bOUig4rDaf6Op7JLSt/39QiP3BzLcGBRvHOixkUesEchglM7mT2aITUOQs8NTcgLqP5g
 af7Q==
X-Gm-Message-State: AOAM531nE5ImJGzT82k3MlXGZ++yZQi0MR/HrYfMcvTGD8id0Dr4A86w
 CfcTb0OSmD+7Zx47Tbmnp19BjQsb/0EUWg==
X-Google-Smtp-Source: ABdhPJwU3W1gGgG/JdwiDIdcL9gkcdEgeBoyqnkHxclJFG4AGGZZumAsNERx2JBxJKJ1wJflS1FcFA==
X-Received: by 2002:a1c:cc07:: with SMTP id h7mr3802986wmb.55.1603209458707;
 Tue, 20 Oct 2020 08:57:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/41] target/arm: Implement v8.1M low-overhead-loop
 instructions
Date: Tue, 20 Oct 2020 16:56:41 +0100
Message-Id: <20201020155656.8045-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

v8.1M's "low-overhead-loop" extension has three instructions
for looping:
 * DLS (start of a do-loop)
 * WLS (start of a while-loop)
 * LE (end of a loop)

The loop-start instructions are both simple operations to start a
loop whose iteration count (if any) is in LR.  The loop-end
instruction handles "decrement iteration count and jump back to loop
start"; it also caches the information about the branch back to the
start of the loop to improve performance of the branch on subsequent
iterations.

As with the branch-future instructions, the architecture permits an
implementation to discard the LO_BRANCH_INFO cache at any time, and
QEMU takes the IMPDEF option to never set it in the first place
(equivalent to discarding it immediately), because for us a "real"
implementation would be unnecessary complexity.

(This implementation only provides the simple looping constructs; the
vector extension MVE (Helium) adds some extra variants to handle
looping across vectors.  We'll add those later when we implement
MVE.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201019151301.2046-8-peter.maydell@linaro.org
---
 target/arm/t32.decode  |  8 ++++
 target/arm/translate.c | 93 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 3015731a8d0..8152739b52b 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -659,4 +659,12 @@ BL               1111 0. .......... 11.1 ............         @branch24
     BF           1111 0 boff:4 10 ----- 1110 - ---------- 1    # BF
     BF           1111 0 boff:4 11 ----- 1110 0 0000000000 1    # BFX, BFLX
   ]
+  [
+    # LE and WLS immediate
+    %lob_imm 1:10 11:1 !function=times_2
+
+    DLS          1111 0 0000 100     rn:4 1110 0000 0000 0001
+    WLS          1111 0 0000 100     rn:4 1100 . .......... 1 imm=%lob_imm
+    LE           1111 0 0000 0 f:1 0 1111 1100 . .......... 1 imm=%lob_imm
+  ]
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a5ebe568804..38371db5401 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2490,17 +2490,23 @@ static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static inline void gen_jmp (DisasContext *s, uint32_t dest)
+/* Jump, specifying which TB number to use if we gen_goto_tb() */
+static inline void gen_jmp_tb(DisasContext *s, uint32_t dest, int tbno)
 {
     if (unlikely(is_singlestepping(s))) {
         /* An indirect jump so that we still trigger the debug exception.  */
         gen_set_pc_im(s, dest);
         s->base.is_jmp = DISAS_JUMP;
     } else {
-        gen_goto_tb(s, 0, dest);
+        gen_goto_tb(s, tbno, dest);
     }
 }
 
+static inline void gen_jmp(DisasContext *s, uint32_t dest)
+{
+    gen_jmp_tb(s, dest, 0);
+}
+
 static inline void gen_mulxy(TCGv_i32 t0, TCGv_i32 t1, int x, int y)
 {
     if (x)
@@ -7991,6 +7997,89 @@ static bool trans_BF(DisasContext *s, arg_BF *a)
     return true;
 }
 
+static bool trans_DLS(DisasContext *s, arg_DLS *a)
+{
+    /* M-profile low-overhead loop start */
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_lob, s)) {
+        return false;
+    }
+    if (a->rn == 13 || a->rn == 15) {
+        /* CONSTRAINED UNPREDICTABLE: we choose to UNDEF */
+        return false;
+    }
+
+    /* Not a while loop, no tail predication: just set LR to the count */
+    tmp = load_reg(s, a->rn);
+    store_reg(s, 14, tmp);
+    return true;
+}
+
+static bool trans_WLS(DisasContext *s, arg_WLS *a)
+{
+    /* M-profile low-overhead while-loop start */
+    TCGv_i32 tmp;
+    TCGLabel *nextlabel;
+
+    if (!dc_isar_feature(aa32_lob, s)) {
+        return false;
+    }
+    if (a->rn == 13 || a->rn == 15) {
+        /* CONSTRAINED UNPREDICTABLE: we choose to UNDEF */
+        return false;
+    }
+    if (s->condexec_mask) {
+        /*
+         * WLS in an IT block is CONSTRAINED UNPREDICTABLE;
+         * we choose to UNDEF, because otherwise our use of
+         * gen_goto_tb(1) would clash with the use of TB exit 1
+         * in the dc->condjmp condition-failed codepath in
+         * arm_tr_tb_stop() and we'd get an assertion.
+         */
+        return false;
+    }
+    nextlabel = gen_new_label();
+    tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_R[a->rn], 0, nextlabel);
+    tmp = load_reg(s, a->rn);
+    store_reg(s, 14, tmp);
+    gen_jmp_tb(s, s->base.pc_next, 1);
+
+    gen_set_label(nextlabel);
+    gen_jmp(s, read_pc(s) + a->imm);
+    return true;
+}
+
+static bool trans_LE(DisasContext *s, arg_LE *a)
+{
+    /*
+     * M-profile low-overhead loop end. The architecture permits an
+     * implementation to discard the LO_BRANCH_INFO cache at any time,
+     * and we take the IMPDEF option to never set it in the first place
+     * (equivalent to always discarding it immediately), because for QEMU
+     * a "real" implementation would be complicated and wouldn't execute
+     * any faster.
+     */
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_lob, s)) {
+        return false;
+    }
+
+    if (!a->f) {
+        /* Not loop-forever. If LR <= 1 this is the last loop: do nothing. */
+        arm_gen_condlabel(s);
+        tcg_gen_brcondi_i32(TCG_COND_LEU, cpu_R[14], 1, s->condlabel);
+        /* Decrement LR */
+        tmp = load_reg(s, 14);
+        tcg_gen_addi_i32(tmp, tmp, -1);
+        store_reg(s, 14, tmp);
+    }
+    /* Jump back to the loop start */
+    gen_jmp(s, read_pc(s) - a->imm);
+    return true;
+}
+
 static bool op_tbranch(DisasContext *s, arg_tbranch *a, bool half)
 {
     TCGv_i32 addr, tmp;
-- 
2.20.1


