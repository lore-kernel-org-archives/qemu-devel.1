Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA97C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B569C2076C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWlVwKBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B569C2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0LO-0008Om-Q1
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztk-0003jY-0X
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztf-0007mQ-GR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id s9so7600382wro.8
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zEp3FAc4PsK+mUmkw0N3JOzoyYY910pPg+gC5kaj9zw=;
 b=PWlVwKBgxWibaA1JLjO/BiaQ2zurAe6XbJXm5jph0VY9HqSgTw053MLU82nG3tIHY4
 iw6g0NJ/ZVeC9xuOqYGTVFMwGkElDtOHQDS6Wrsl6UZuBDUVgf26DOzK3u4jSG0GGOm7
 luecGGauin/hN6HEMjkGAh3APj/Heekk5G34AyZDR3KTFWMCbIP38hLAB6Vmfo9r7zPH
 CirNtGjwsFlDioD7O4+BujC1d9pb+DqfbO6GpefdJiWQjio5GfijajOLs6SnUQKHs+OK
 l67nBIDUy0ZcFYCjJFN1ub76TbTxdg/LgV5uXwtKNXD8Sg/pR+fzpbQvK1yrxKk+yvL1
 T1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zEp3FAc4PsK+mUmkw0N3JOzoyYY910pPg+gC5kaj9zw=;
 b=qw2IZ01rNfzynmbvB65h3A4IV4XUPpNVj4auqwhmtjyEf1jt5pxsMYPh6fOSMTusFW
 lNR9tOGFmaGu0fXazchLwpSSJ5vLHppxK/NYHJvAQDRAQFgrf1P/qfIj8S5ZDxKcC5Uy
 3lRPiCJAOGyScBdBC6AWPnvmrOcszRoEPBtSHSuQCfVwF9CxGkFPwsS0T1Kct7+rO3pX
 D3uxB6v5WNYjty7LwOhgFSN46U1ojvgSxQm8pVl9Taud81ENsD7vvS4xmG8MolMaCfEb
 Mlo98Hh7inoL2DMiMzn0LsQlT5UJeyJX/8PT6a8aU7Ef+SxdFCIhHJD8M8fT1l439WSk
 qUvA==
X-Gm-Message-State: AOAM531lgZZ10kJ8ZEufQWj8TVS9tJIJ041j9guAHbkHAkizt5pmtr9U
 99jaQkTz83NxTFoZrbY++vnERw==
X-Google-Smtp-Source: ABdhPJyBFwRbXdUiw40SJamSgtU0g09UUsuJShpajEkwJBxno9U1pSA1KvSWElJFSqzEs8Bzgulw6Q==
X-Received: by 2002:adf:912e:: with SMTP id j43mr30369318wrj.325.1602517076189; 
 Mon, 12 Oct 2020 08:37:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/10] target/arm: Implement v8.1M low-overhead-loop
 instructions
Date: Mon, 12 Oct 2020 16:37:43 +0100
Message-Id: <20201012153746.9996-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153746.9996-1-peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
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
---
 target/arm/t32.decode  |  8 +++++
 target/arm/translate.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

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
index 9e72d719c6f..742c219c071 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7953,6 +7953,80 @@ static bool trans_BF(DisasContext *s, arg_BF *a)
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
+
+    nextlabel = gen_new_label();
+    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[a->rn], 0, nextlabel);
+    gen_jmp(s, read_pc(s) + a->imm);
+
+    gen_set_label(nextlabel);
+    tmp = load_reg(s, a->rn);
+    store_reg(s, 14, tmp);
+    gen_jmp(s, s->base.pc_next);
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


