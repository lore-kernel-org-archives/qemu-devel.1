Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03B722CF6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ibU8Ahwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03B722CF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dvV-00010D-MP
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dTE-0004h7-Ui
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:50:01 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:38731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dTB-00085k-91
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:50:00 -0400
Received: by mail-pj1-x1032.google.com with SMTP id ep8so6288960pjb.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CfR5gqnbuZvx3agqnFYUiGRSuq+omKLC4snEt+MZPog=;
 b=ibU8Ahwo7QWfC+OLbvUs+iKrTeX3GSM2tvNo6xACasLX9pQqjS+BlyExCtOByXYU8b
 0xwsD5hiqs7u7IqCykqrQu868SNb5v6CY0PBTXepypivGdb34jw+Pm+2xA1donRy8ens
 E8EwXLEum4WOnaGGYw+FqnfnfOrK4SqJWgZDyi7ToGjVKMOaKiOrOPFKUSKWCxmYKrzY
 iGF6QZxK8c6U64muxwo0PfF4gR9t4j8vH03e6lA3AcqqIsWbzuKoIEgYKof3dkPjZ0QW
 l2i1Rmpcpq6GGiUMY04tvqXjB48+SOt2dHS7NBaNuWSQQGO0NioWl1dMOUD2b2L/gwT1
 ItMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CfR5gqnbuZvx3agqnFYUiGRSuq+omKLC4snEt+MZPog=;
 b=dIZk6igy+StL8upWM+oJ+R4zlESzI36tyvDuH6qCKSUNy4ybLZzIKm9fKtct6cz7LT
 +VcRvHuttUQ8AM34BpRhdllX8dBxzbErLdfsrpxeif12xtAJuU34YKsO5ra646m4ccmb
 nbPtNFYVILXErWlcteHSstQHOgTzUARWtwXwqqS6xcSIz7ylS6piukskqsiExf351P+h
 wwWGzKPaYOf3GGVPsDGtS1KyBHCB8qa/waZNIhmSflSiA72oHEbZAysST2tY6Mq5JQcR
 6zQjglzLqRN+I5X5GYa2wht0jw0UBQkmGGOhEBbJr/1voftbBZTx/kXiltxVFuXbLTUh
 I+OA==
X-Gm-Message-State: AOAM533blxH0h5S1mCEKBBbbUI/e1zn/5c4OvUExbHvvgjOc2UN8d6iO
 J+HndrN4bwuC6PnZBVwxcwnNKAVu7yI=
X-Google-Smtp-Source: ABdhPJxEbENLnWwqOTdT89aJrZJe1qC4jEyaIzb8ajHjpHohtWHrdjkN8Xx3aaaYApLkJ2o72AJytA==
X-Received: by 2002:a17:90a:87:: with SMTP id a7mr7255925pja.14.1596710995851; 
 Thu, 06 Aug 2020 03:49:55 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:55 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 64/71] target/riscv: introduce floating-point rounding mode
 enum
Date: Thu,  6 Aug 2020 18:47:01 +0800
Message-Id: <20200806104709.13235-65-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1032.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
index f2bd3972558..6cdb1659b59 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2418,7 +2418,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_d,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, 7);                                          \
+        gen_set_rm(s, FRM_DYN);                                    \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2498,7 +2498,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
             gen_helper_##NAME##_w,                                \
             gen_helper_##NAME##_d,                                \
         };                                                        \
-        gen_set_rm(s, 7);                                         \
+        gen_set_rm(s, FRM_DYN);                                   \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);            \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,           \
@@ -2530,7 +2530,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
         TCGLabel *over = gen_new_label();                        \
-        gen_set_rm(s, 7);                                        \
+        gen_set_rm(s, FRM_DYN);                                  \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);        \
                                                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
@@ -2566,7 +2566,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         static gen_helper_opfvf *const fns[2] = {                \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
-        gen_set_rm(s, 7);                                        \
+        gen_set_rm(s, FRM_DYN);                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
@@ -2596,7 +2596,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, 7);                                          \
+        gen_set_rm(s, FRM_DYN);                                    \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2632,7 +2632,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         static gen_helper_opfvf *const fns[2] = {                \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
-        gen_set_rm(s, 7);                                        \
+        gen_set_rm(s, FRM_DYN);                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
@@ -2709,7 +2709,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_d,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, 7);                                          \
+        gen_set_rm(s, FRM_DYN);                                        \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2850,7 +2850,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, 7);                                          \
+        gen_set_rm(s, FRM_DYN);                                        \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2896,7 +2896,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, 7);                                          \
+        gen_set_rm(s, FRM_DYN);                                    \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 4fb683a7399..97f023361a9 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -38,6 +38,15 @@ target_ulong fclass_d(uint64_t frs1);
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


