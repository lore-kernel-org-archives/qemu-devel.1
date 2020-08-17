Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0313C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECB02072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FSMNQc8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECB02072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bI9-0003sA-Vv
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7at3-0002kA-Nb
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:53:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:38197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7at1-0005Kx-O0
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:53:01 -0400
Received: by mail-pl1-x62f.google.com with SMTP id t11so7173726plr.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XCP+3ppn5aAqD22KrZFun5u2gdcyvp6w5yDJwaePmVA=;
 b=FSMNQc8xRZeDGQ0Ax+Ungl2mZhdRkVc5RoMp/lwYi9b0ZFY0aNCZCc0w4Bs1HpmqER
 Mq74X8ivO8xIUAZ0oF8M4dvWgqqlXy0IeV8FqjkePF9MOxTxvvjU4proRim3zLJyp7Qh
 AroolFRY5mQgEGI2Vfgad/UfQwJQ6mbyXbPkdZhLBK/8GQeFCwML3fEUD4Zeft2YrqzC
 HfSprMu6Ydmqp0Oh5H5/xsOfO5Cd8LDiwYlbDWSehr9fg89ZJ0UsHxdDU+zdFbpu/qp0
 lN9DtTUp57vEXumvpg3l8/ZgYuAgKMUsu78Z/sRAtfYtAxmeycUauP98ievq6qWawx93
 liZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XCP+3ppn5aAqD22KrZFun5u2gdcyvp6w5yDJwaePmVA=;
 b=WVMArmK3q17rA3+fvDcjbTjE2G2dffT9SzXUQuecjuPtQhGFY62tOIqC/dZDKZPL6g
 S/Qid3lG7kFqKfhELoenVBIXFWjv/ncDa/8PhdIas4npUEqVkYzLqH9oG5fAzAzxFS5F
 FLDIT/rtFjMtXy2+NuYF7lFkT3uFLJA1Wbvd0dMzAzt8wQr+s0m+jhK3U1XQ0Cx+vfiw
 JeVAAHLlnzV4VerOQYUmSf6h/1jx9In794BKDdhpKEZa3cHhS0PB7A21nMLCHnjJ3ZJj
 Ci+678Sexa3Nn/JJ7MDPAw0X1NP8ehzb4a7sAe7lBNdN34uLOWJMLhJfRVNCaALrMWyU
 tEoQ==
X-Gm-Message-State: AOAM532H0h9zr66pwQHQiX5Ft5LracjiNiBEOMaou1T8iysR5YdMpyBI
 xhIxFPIEkvQ5adpsIVB5xydmCSduXPCtxw==
X-Google-Smtp-Source: ABdhPJyJ9KyMowJaeFFkEUCpT/lsP/HKMDbKE/s98Zs9f5usTRD0HS3kInaQPSeMSA7dFMkhBJ1EMw==
X-Received: by 2002:a17:90a:4fe2:: with SMTP id
 q89mr12436241pjh.70.1597654378255; 
 Mon, 17 Aug 2020 01:52:58 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:57 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 62/70] target/riscv: introduce floating-point rounding mode
 enum
Date: Mon, 17 Aug 2020 16:49:47 +0800
Message-Id: <20200817084955.28793-63-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/fpu_helper.c               | 12 ++++++------
 target/riscv/insn_trans/trans_rvv.inc.c | 18 +++++++++---------
 target/riscv/internals.h                |  9 +++++++++
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index bb346a82499..92e076c6ed8 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -55,23 +55,23 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
 {
     int softrm;
 
-    if (rm == 7) {
+    if (rm == FRM_DYN) {
         rm = env->frm;
     }
     switch (rm) {
-    case 0:
+    case FRM_RNE:
         softrm = float_round_nearest_even;
         break;
-    case 1:
+    case FRM_RTZ:
         softrm = float_round_to_zero;
         break;
-    case 2:
+    case FRM_RDN:
         softrm = float_round_down;
         break;
-    case 3:
+    case FRM_RUP:
         softrm = float_round_up;
         break;
-    case 4:
+    case FRM_RMM:
         softrm = float_round_ties_away;
         break;
     default:
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 4f33c42990e..c148ed40c9f 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2430,7 +2430,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_d,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, 7);                                          \
+        gen_set_rm(s, FRM_DYN);                                    \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2510,7 +2510,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
             gen_helper_##NAME##_w,                                \
             gen_helper_##NAME##_d,                                \
         };                                                        \
-        gen_set_rm(s, 7);                                         \
+        gen_set_rm(s, FRM_DYN);                                   \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);            \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,           \
@@ -2542,7 +2542,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
         TCGLabel *over = gen_new_label();                        \
-        gen_set_rm(s, 7);                                        \
+        gen_set_rm(s, FRM_DYN);                                  \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);        \
                                                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
@@ -2578,7 +2578,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         static gen_helper_opfvf *const fns[2] = {                \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
-        gen_set_rm(s, 7);                                        \
+        gen_set_rm(s, FRM_DYN);                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
@@ -2608,7 +2608,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, 7);                                          \
+        gen_set_rm(s, FRM_DYN);                                    \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2644,7 +2644,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         static gen_helper_opfvf *const fns[2] = {                \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
-        gen_set_rm(s, 7);                                        \
+        gen_set_rm(s, FRM_DYN);                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
@@ -2721,7 +2721,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_d,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, 7);                                          \
+        gen_set_rm(s, FRM_DYN);                                        \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2862,7 +2862,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, 7);                                          \
+        gen_set_rm(s, FRM_DYN);                                        \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2908,7 +2908,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, 7);                                          \
+        gen_set_rm(s, FRM_DYN);                                    \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index bca48297dab..d9ea6a32188 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -37,6 +37,15 @@ target_ulong fclass_d(uint64_t frs1);
 #define SEW32 2
 #define SEW64 3
 
+enum {
+    FRM_RNE = 0,    /* Round to Nearest, ties to Even */
+    FRM_RTZ = 1,    /* Round towards Zero */
+    FRM_RDN = 2,    /* Round Down */
+    FRM_RUP = 3,    /* Round Up */
+    FRM_RMM = 4,    /* Round to Nearest, ties to Max Magnitude */
+    FRM_DYN = 7,    /* Dynamic rounding mode */
+};
+
 static inline uint64_t nanbox_s(float32 f)
 {
     return f | MAKE_64BIT_MASK(32, 32);
-- 
2.17.1


