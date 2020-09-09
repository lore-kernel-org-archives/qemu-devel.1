Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57514C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34E52145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/P7kCuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34E52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnxf-0007VL-5q
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnV-0008Hq-Ty
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:13 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnU-0002Er-67
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:13 -0400
Received: by mail-pj1-x1041.google.com with SMTP id s2so425989pjr.4
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KysIP4SxxPHUzbaJQ7kkTPCy9I7LKQnOtelCJefhblY=;
 b=b/P7kCuSh9/H8RhlUz9a78L1IC69pDlYZWiEE+l0xBf1cH9SaWTney3lVRJvu9Ryjk
 TwKwFqj2v31+NsdwLW6iviAY1TwybGJenVfYNWASVK9mwlh5p64EgtPAMW/H4+iHAD9E
 DTUQnPFMECMxevhIy7ulftsDPebrPTinJlCD7p1Mjnp4i0Z1WdOpZ0uDNWKajp7ua868
 2p9S1a2n8lRh1HsCPtrUpH06d4Bg5X+nRkRQWMcwDHpKCCt1kk20DF7rMpN7iF1dz8MB
 Lfx6iMLBXV4CwjmZdOKuX16IdvDSi99H0IcbFYKYoyvEGBYLTNepmBtI+EuB+tTPOalV
 Vbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KysIP4SxxPHUzbaJQ7kkTPCy9I7LKQnOtelCJefhblY=;
 b=rstfZ1/GIdMYS4v8vugWWPQHqvoJ1e+J65jsLsQp16gN24JAzckEl5KZuDpsb8vot4
 tJ+U15/pHdraUcfRByETBYA5IY4/DZEgSnA0fZAbVucvQFP193Bf8imlDKIki/1SHkHg
 IR0s99wsoi9j+f2k+pUm6OsboukO8L5Lg3BHYxNb4L+2bLBKs2Z32h3PFUekcxVaBEuG
 1qU0tRvQ2kzR9oNc3Vyp4EgMc48DGp6A3A12sRV+scl5Q2F6JnTHUx4UfD5+dN46luPN
 f7x6Fyu8ehnRSbTBqQgi038z5gUoLn8U+uqy1XYOwiepkgLOpz1Ocqv1dgjc6Q6u17Oq
 mubg==
X-Gm-Message-State: AOAM531NPSVvE+klQRnq3Q9EUflxujMwrcFk4+n1iZG+xGqvSW19qOXP
 8WltSWdXSpq00Jp7fKnKyIW4UDSnEP8AdQ==
X-Google-Smtp-Source: ABdhPJzyhQsOVo3R2NrY/kCJf5zAdys40V/E84RuO4OYbV4e/Bw6NCzJ+LEZD84K14/SFUcgAO9jPg==
X-Received: by 2002:a17:90a:c907:: with SMTP id
 v7mr1192959pjt.204.1599610630489; 
 Tue, 08 Sep 2020 17:17:10 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/43] tcg: Expand TempOptInfo to 64-bits
Date: Tue,  8 Sep 2020 17:16:21 -0700
Message-Id: <20200909001647.532249-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

This propagates the extended value of TCGTemp.val that we did before.
In addition, it will be required for vector constants.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 81faf7cf10..33d1fc8f87 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -39,8 +39,8 @@ typedef struct TempOptInfo {
     bool is_const;
     TCGTemp *prev_copy;
     TCGTemp *next_copy;
-    tcg_target_ulong val;
-    tcg_target_ulong mask;
+    uint64_t val;
+    uint64_t mask;
 } TempOptInfo;
 
 static inline TempOptInfo *ts_info(TCGTemp *ts)
@@ -166,11 +166,11 @@ static bool args_are_copies(TCGArg arg1, TCGArg arg2)
     return ts_are_copies(arg_temp(arg1), arg_temp(arg2));
 }
 
-static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg val)
+static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg dst, uint64_t val)
 {
     const TCGOpDef *def;
     TCGOpcode new_op;
-    tcg_target_ulong mask;
+    uint64_t mask;
     TempOptInfo *di = arg_info(dst);
 
     def = &tcg_op_defs[op->opc];
@@ -204,7 +204,7 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
     const TCGOpDef *def;
     TempOptInfo *di;
     TempOptInfo *si;
-    tcg_target_ulong mask;
+    uint64_t mask;
     TCGOpcode new_op;
 
     if (ts_are_copies(dst_ts, src_ts)) {
@@ -247,7 +247,7 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
     }
 }
 
-static TCGArg do_constant_folding_2(TCGOpcode op, TCGArg x, TCGArg y)
+static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
 {
     uint64_t l64, h64;
 
@@ -410,10 +410,10 @@ static TCGArg do_constant_folding_2(TCGOpcode op, TCGArg x, TCGArg y)
     }
 }
 
-static TCGArg do_constant_folding(TCGOpcode op, TCGArg x, TCGArg y)
+static uint64_t do_constant_folding(TCGOpcode op, uint64_t x, uint64_t y)
 {
     const TCGOpDef *def = &tcg_op_defs[op];
-    TCGArg res = do_constant_folding_2(op, x, y);
+    uint64_t res = do_constant_folding_2(op, x, y);
     if (!(def->flags & TCG_OPF_64BIT)) {
         res = (int32_t)res;
     }
@@ -501,8 +501,9 @@ static bool do_constant_folding_cond_eq(TCGCond c)
 static TCGArg do_constant_folding_cond(TCGOpcode op, TCGArg x,
                                        TCGArg y, TCGCond c)
 {
-    tcg_target_ulong xv = arg_info(x)->val;
-    tcg_target_ulong yv = arg_info(y)->val;
+    uint64_t xv = arg_info(x)->val;
+    uint64_t yv = arg_info(y)->val;
+
     if (arg_is_const(x) && arg_is_const(y)) {
         const TCGOpDef *def = &tcg_op_defs[op];
         tcg_debug_assert(!(def->flags & TCG_OPF_VECTOR));
@@ -613,9 +614,8 @@ void tcg_optimize(TCGContext *s)
     infos = tcg_malloc(sizeof(TempOptInfo) * nb_temps);
 
     QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
-        tcg_target_ulong mask, partmask, affected;
+        uint64_t mask, partmask, affected, tmp;
         int nb_oargs, nb_iargs, i;
-        TCGArg tmp;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
 
@@ -1221,14 +1221,15 @@ void tcg_optimize(TCGContext *s)
 
         CASE_OP_32_64(extract2):
             if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-                TCGArg v1 = arg_info(op->args[1])->val;
-                TCGArg v2 = arg_info(op->args[2])->val;
+                uint64_t v1 = arg_info(op->args[1])->val;
+                uint64_t v2 = arg_info(op->args[2])->val;
+                int shr = op->args[3];
 
                 if (opc == INDEX_op_extract2_i64) {
-                    tmp = (v1 >> op->args[3]) | (v2 << (64 - op->args[3]));
+                    tmp = (v1 >> shr) | (v2 << (64 - shr));
                 } else {
-                    tmp = (int32_t)(((uint32_t)v1 >> op->args[3]) |
-                                    ((uint32_t)v2 << (32 - op->args[3])));
+                    tmp = (int32_t)(((uint32_t)v1 >> shr) |
+                                    ((uint32_t)v2 << (32 - shr)));
                 }
                 tcg_opt_gen_movi(s, op, op->args[0], tmp);
                 break;
@@ -1267,9 +1268,10 @@ void tcg_optimize(TCGContext *s)
                 break;
             }
             if (arg_is_const(op->args[3]) && arg_is_const(op->args[4])) {
-                tcg_target_ulong tv = arg_info(op->args[3])->val;
-                tcg_target_ulong fv = arg_info(op->args[4])->val;
+                uint64_t tv = arg_info(op->args[3])->val;
+                uint64_t fv = arg_info(op->args[4])->val;
                 TCGCond cond = op->args[5];
+
                 if (fv == 1 && tv == 0) {
                     cond = tcg_invert_cond(cond);
                 } else if (!(tv == 1 && fv == 0)) {
-- 
2.25.1


