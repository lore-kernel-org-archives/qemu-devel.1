Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782F6C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1946D2177B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYXUrzx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1946D2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnxf-0007V2-8D
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnc-0008UC-Gj
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:20 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnna-0002G9-LX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:20 -0400
Received: by mail-pj1-x1043.google.com with SMTP id u3so430570pjr.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DrWwc7nhYkhyIWgVLuU+D0JRjvYc9QKHe5GHoGABUmU=;
 b=PYXUrzx7PWFJ3hbQvbzUrer9Hz6z3mbOmr0i2q5JUnkupaNxPPkQ1W6Zl2JlPbGbSq
 pg1XdrhmCc4vNMJ1a3kGbnaa4o3E7CSrtQST5mxWBuvgiZtGELVlmoHV7bqvB26/uFcp
 eQASzB6jpGRfMzui7KiO6UZmjs/jXUDZaM0WhEVjD2o+/roN19z3FyHFg2G+xb+uFg8R
 dbvu7yjLkD+nc85hfj9eonOEcYhp8RDjbu14EkPu9mKluh3a05xuOJQEft/utxms+JTM
 M+k02ppsoqnQwcoaY0ch21PcxxfzbNOKLCQ+XEuVUb4bmrLnH3BtBghnTZ24VCLQPKN0
 JXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DrWwc7nhYkhyIWgVLuU+D0JRjvYc9QKHe5GHoGABUmU=;
 b=bAe72CIXY+QYyokA2qUsG9ZY5cGNGDexrpPh2haslX1fubJeQXUOiZel2WeZvNgILt
 7yiwu1KDqNr+dGxmr9niZAChh4VhRsU4dG9AM6DdkJPg7Sa2qv4qNzlSwWNy5uvdiqrL
 vWBYfeLQ6OZYA7Z03j+YWvfPHlLNoTXk8/JxSGlAMgSPENwdewfACNu3FLYdDjBQzlfZ
 3KrpPNW1v3SUMgeFv4cGff9Kl9RQccbvBvemqD9sXJoI6sE039HcscjI4fAgES6AzkYk
 8IcbHqL/jkvk6/s1Ugz10D35kP2Z+bn2QWzd1fCtaqRzw1m9mmR0ajhKhU9w3gcvZMte
 ArsA==
X-Gm-Message-State: AOAM530dBX41ITrYTY6ttMwAqGlvIj8BzQbuauxy5BvscEva9ZThItI9
 +Zrzq1CkU9vgM9pN+IJBv+r0uD/AzT3H5g==
X-Google-Smtp-Source: ABdhPJwaKbXVBRedZbNSph8ZE7b4ZZy2/AuBljg708fY2M08l9BCE0CTFDFsn1t1ULHUhpHNPZQe9A==
X-Received: by 2002:a17:90a:a60e:: with SMTP id
 c14mr1234506pjq.31.1599610637072; 
 Tue, 08 Sep 2020 17:17:17 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/43] tcg: Convert tcg_gen_dupi_vec to TCG_CONST
Date: Tue,  8 Sep 2020 17:16:26 -0700
Message-Id: <20200909001647.532249-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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

Because we now store uint64_t in TCGTemp, we can now always
store the full 64-bit duplicate immediate.  So remove the
difference between 32- and 64-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c   |  9 ++++-----
 tcg/tcg-op-vec.c | 39 ++++++++++-----------------------------
 tcg/tcg.c        |  7 +------
 3 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1eda7dc419..af07c6f628 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1116,11 +1116,10 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_dup2_vec:
             assert(TCG_TARGET_REG_BITS == 32);
             if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-                tmp = arg_info(op->args[1])->val;
-                if (tmp == arg_info(op->args[2])->val) {
-                    tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
-                    break;
-                }
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0],
+                                 deposit64(arg_info(op->args[1])->val, 32, 32,
+                                           arg_info(op->args[2])->val));
+                break;
             } else if (args_are_copies(op->args[1], op->args[2])) {
                 op->opc = INDEX_op_dup_vec;
                 TCGOP_VECE(op) = MO_32;
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index cdbf11c573..9fbed1366c 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -216,25 +216,17 @@ void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
     }
 }
 
-#define MO_REG  (TCG_TARGET_REG_BITS == 64 ? MO_64 : MO_32)
-
-static void do_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
-{
-    TCGTemp *rt = tcgv_vec_temp(r);
-    vec_gen_2(INDEX_op_dupi_vec, rt->base_type, vece, temp_arg(rt), a);
-}
-
 TCGv_vec tcg_const_zeros_vec(TCGType type)
 {
     TCGv_vec ret = tcg_temp_new_vec(type);
-    do_dupi_vec(ret, MO_REG, 0);
+    tcg_gen_dupi_vec(MO_64, ret, 0);
     return ret;
 }
 
 TCGv_vec tcg_const_ones_vec(TCGType type)
 {
     TCGv_vec ret = tcg_temp_new_vec(type);
-    do_dupi_vec(ret, MO_REG, -1);
+    tcg_gen_dupi_vec(MO_64, ret, -1);
     return ret;
 }
 
@@ -252,39 +244,28 @@ TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
 
 void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        do_dupi_vec(r, MO_64, a);
-    } else if (a == dup_const(MO_32, a)) {
-        do_dupi_vec(r, MO_32, a);
-    } else {
-        TCGv_i64 c = tcg_const_i64(a);
-        tcg_gen_dup_i64_vec(MO_64, r, c);
-        tcg_temp_free_i64(c);
-    }
+    tcg_gen_dupi_vec(MO_64, r, a);
 }
 
 void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_32, a));
+    tcg_gen_dupi_vec(MO_32, r, a);
 }
 
 void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_16, a));
+    tcg_gen_dupi_vec(MO_16, r, a);
 }
 
 void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_8, a));
+    tcg_gen_dupi_vec(MO_8, r, a);
 }
 
 void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
 {
-    if (vece == MO_64) {
-        tcg_gen_dup64i_vec(r, a);
-    } else {
-        do_dupi_vec(r, MO_REG, dup_const(vece, a));
-    }
+    TCGTemp *rt = tcgv_vec_temp(r);
+    tcg_gen_mov_vec(r, tcg_constant_vec(rt->base_type, vece, a));
 }
 
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
@@ -489,8 +470,8 @@ void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
             if (tcg_can_emit_vec_op(INDEX_op_sari_vec, type, vece) > 0) {
                 tcg_gen_sari_vec(vece, t, a, (8 << vece) - 1);
             } else {
-                do_dupi_vec(t, MO_REG, 0);
-                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a, t);
+                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a,
+                                tcg_constant_vec(type, vece, 0));
             }
             tcg_gen_xor_vec(vece, r, a, t);
             tcg_gen_sub_vec(vece, r, r, t);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e413bf70d4..0ce45fd123 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3440,16 +3440,11 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
              * The targets will, in general, have to do this search anyway,
              * do this generically.
              */
-            if (TCG_TARGET_REG_BITS == 32) {
-                val = dup_const(MO_32, val);
-                vece = MO_32;
-            }
             if (val == dup_const(MO_8, val)) {
                 vece = MO_8;
             } else if (val == dup_const(MO_16, val)) {
                 vece = MO_16;
-            } else if (TCG_TARGET_REG_BITS == 64 &&
-                       val == dup_const(MO_32, val)) {
+            } else if (val == dup_const(MO_32, val)) {
                 vece = MO_32;
             }
 
-- 
2.25.1


