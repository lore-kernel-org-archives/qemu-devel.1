Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D74C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A9820888
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fn8IZXpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A9820888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jylcs-00047P-3e
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 20:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZP-0000At-SG
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:15 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZN-0008EZ-I0
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:15 -0400
Received: by mail-pj1-x1044.google.com with SMTP id b92so4130208pjc.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=82BoFk+pEx0CdeF7uaEVVUl7SfuHCvWy8t85i9SZsTQ=;
 b=Fn8IZXpAc7MCaiuiZ25JlQA2LabEcam/2/IMXdJ1O4uKpkwnUqRnzzCDzancnQTF5A
 teIzdq/yAZu1fRlcYa60F7K94ld7EZ2wAkXCBQ8P5aFyQZg3MAEBSKVZoJRo1KUkdfVK
 UqCpis03sVLQgTpoQmDTkqT5URfXQL/E+lHHdNBaJWzeYtXIGUKT63RTZCaUnI83Tjhn
 0L8sOS1LM9sZd1cL3G4wjQq5C1ti5qX4vBIKkYbGZlu640cKpfiltb7l4yJCSspNmgPM
 1RaFlM0Wz0aCUZ9q4OSENlaP4lxCBvfslKKcJ0LbcpQC9QYkMo1J1Z7kVVboWg12+JX2
 gn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=82BoFk+pEx0CdeF7uaEVVUl7SfuHCvWy8t85i9SZsTQ=;
 b=VFFgVgxphbtOYFeu9AE/eAcweygVAt/XikeCAD95WOwTqFsXpmT/CalFideg0IcOVz
 LijupAmLUhrvLu5HaZCQ2x4FOLR96wR+jNl6P7OLT88j87o99DS4ScKNUL+rUaR+XcY5
 yWYNOUbg5cYjSOf9b2CDkq41+Tt7dY2K+/e/CGQgn9KDfEaT6rf6bLFPRSg0rzSV6w5V
 dR3dmzxODZQ0uY/cjW40C/8a3T+h9UwwkXz1kUpznHoKax6AxVxYHDgH49S2qYYp5t0Y
 7C6aswomuETPDrPzmkxWA6J2e2S+9JlLsDsJfYP7FAZIdFfVffDpznW51jbB51eYvz8S
 2RMQ==
X-Gm-Message-State: AOAM531YWgFtozyCL0/iV1qW3uwH91NJFkaLcUY0YgraPVvTYlewBj9t
 XKQVjr4yObtiDEkoQoaz94v9Dqb/Atk=
X-Google-Smtp-Source: ABdhPJxB/kyIx0JQ3A1RWxiiWUx45JeZQ0oeQnQRBpYlj4sr6vwC3gFYkPU4oCiLT9TizJgBvzVB3A==
X-Received: by 2002:a17:90a:2367:: with SMTP id
 f94mr2932434pje.20.1595550491869; 
 Thu, 23 Jul 2020 17:28:11 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id q20sm4224635pfn.111.2020.07.23.17.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 17:28:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] target/riscv: Generalize gen_nanbox_fpr to gen_nanbox_s
Date: Thu, 23 Jul 2020 17:28:02 -0700
Message-Id: <20200724002807.441147-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724002807.441147-1-richard.henderson@linaro.org>
References: <20200724002807.441147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: frank.chang@sifive.com, alistair23@gmail.com, qemu-riscv@nongnu.org,
 zhiwei_liu@c-sky.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not depend on the RVD extension, take input and output via
TCGv_i64 instead of fpu regno.  Move the function to translate.c
so that it can be used in multiple trans_*.inc.c files.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvf.inc.c | 16 +---------------
 target/riscv/translate.c                | 11 +++++++++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 3bfd8881e7..c7057482e8 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -23,20 +23,6 @@
         return false;                       \
 } while (0)
 
-/*
- * RISC-V requires NaN-boxing of narrower width floating
- * point values.  This applies when a 32-bit value is
- * assigned to a 64-bit FP register.  Thus this does not
- * apply when the RVD extension is not present.
- */
-static void gen_nanbox_fpr(DisasContext *ctx, int regno)
-{
-    if (has_ext(ctx, RVD)) {
-        tcg_gen_ori_i64(cpu_fpr[regno], cpu_fpr[regno],
-                        MAKE_64BIT_MASK(32, 32));
-    }
-}
-
 static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
     TCGv t0 = tcg_temp_new();
@@ -46,7 +32,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
-    gen_nanbox_fpr(ctx, a->rd);
+    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
 
     tcg_temp_free(t0);
     mark_fs_dirty(ctx);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9632e79cf3..12a746da97 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -90,6 +90,17 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
     return ctx->misa & ext;
 }
 
+/*
+ * RISC-V requires NaN-boxing of narrower width floating point values.
+ * This applies when a 32-bit value is assigned to a 64-bit FP register.
+ * For consistency and simplicity, we nanbox results even when the RVD
+ * extension is not present.
+ */
+static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
+{
+    tcg_gen_ori_i64(out, in, MAKE_64BIT_MASK(32, 32));
+}
+
 static void generate_exception(DisasContext *ctx, int excp)
 {
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-- 
2.25.1


