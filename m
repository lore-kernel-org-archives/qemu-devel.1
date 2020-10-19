Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8226C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1EF2231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bo5wfdDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1EF2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWwu-0005es-5V
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqb-0006uU-GA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:17 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqX-0002lI-9z
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id e17so83452wru.12
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ef3HmBS2nRGxZqZRT4CTCAq+5F2Nv/+vesJZx/y5JRY=;
 b=Bo5wfdDBaCnY1mSbHgE0/YE7wRlWGKYdOxu1Mu6Ofc7qdeo6pOXfpytQOjXZ67gcKV
 jx7NyD7eShUCKcv3MGvCJYBDIVqj0wYQ0CIyJ/M5KtF2GFbEyp94f+h+Rwq1ndBEY7tb
 4eIrSuzvTCP70UVKw2NSqhQohvzu0nyS7AY9ujsL7H85Go0t6kiyK8nujvT0tocxSRfy
 5IFl+PTMTN0qn6lAnKUEv6dFMrCXJnc6RqrhF4opjS7IvSHuV+GcSfOmmJ0lUmVhtx5t
 FjcC5GRZV7xWK2gdWEWNI+Jtf9rw9hucVHLlJ8hkfpkUuanKsj8OOFxMEomA0Ua67E/8
 D4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ef3HmBS2nRGxZqZRT4CTCAq+5F2Nv/+vesJZx/y5JRY=;
 b=Ro8wE17EnXE9cz/wxuZpzGzMe2p1Oh7nSL/nfnxu3ZjLfN9WzdfLeMbn61fgGeGdTV
 q+ZjCEPFEZg6OEnnoAtIA9kOqY0S1NtcW0cNzbi0RQISZNFmO/wg4VlztjAekKiCmK+K
 K48nhv6SrBlhCFBoS41oFw98I/DPhWr4Q48DZf2DuLMs/SoJ8iO7MAin1igH2728QFOd
 RxN8kh7rhDq5LL3TEZLQAs3e+5XBPmMJ1kYl6jt0rbB91xiEayU7sVx0u2mRuye1qmJ5
 P9b1c7W5K9Jilwfq7naUVsXLs6ud8XGud7i8DcI/RpGu2666GF2Vv7w20oyeQdtDkAtr
 aiRg==
X-Gm-Message-State: AOAM531du3HzTNoCNqvmnYv2kY5rjOjEIFAfal7QDmmanuh2HGUG8ni/
 0vMq3lZkC7aOjKMFR4izr83cuw==
X-Google-Smtp-Source: ABdhPJwneFPNx1m/moSuf67oqxeXROwPeSrc/FbvYU6Odpp1Qtcm0sXYdW0pcwzxEsnum7N5sndJqA==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr8266wrw.302.1603120392001;
 Mon, 19 Oct 2020 08:13:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y14sm309918wma.48.2020.10.19.08.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:13:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/10] target/arm: Implement v8.1M low-overhead-loop
 instructions
Date: Mon, 19 Oct 2020 16:12:58 +0100
Message-Id: <20201019151301.2046-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019151301.2046-1-peter.maydell@linaro.org>
References: <20201019151301.2046-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
index 01b697083a0..5083f828780 100644
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
@@ -7953,6 +7959,89 @@ static bool trans_BF(DisasContext *s, arg_BF *a)
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


