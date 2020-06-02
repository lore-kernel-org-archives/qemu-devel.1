Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B238EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5D3206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwrxtY8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5D3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgANq-0007km-P0
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAId-0005hp-QG
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:03 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:39071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIb-0007QG-T8
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:03 -0400
Received: by mail-pg1-x530.google.com with SMTP id w20so5335826pga.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cgOiitbO0iyDYlrduQDieXmGBR9obHXryBYv28yQQP4=;
 b=GwrxtY8D69fd/WfrprrqTtQgyRhnoAGiXVsFBqGcK3OcjUYbddEEHeakRG/Ekuxq8T
 dGCK8SzeoeMwEb/Ysw2ywGPXZYag/ZvGKO8pycGDBXU4fXJIowsRKADkFsx3PA0NFMnw
 cGgu9bbuOe+kcUqDpDYF2SUU/SQRPe6sYrG8A6bFG7k1M3pMrBEPpmbwAnaXhYYTFYEw
 TiPBbuE9qsrOpHhrmo9JWjPffsqKF3z+LhQmni1WYMAU/S4NsNUgQb8gQX6LLSp9yFUX
 7rY5b5Toryy41bm+tBkTRqLxmdeQAuQePPNwyrcV3Vz5DGE5GCt3Z9fhL7kNc4l8324m
 g9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cgOiitbO0iyDYlrduQDieXmGBR9obHXryBYv28yQQP4=;
 b=UQgIfyKHaWFbiP+OPfjZSeMtPlSLMBqd8WeKfH1FyjvrWTLvwb2JxEc/lMpIVuX+eu
 cX9VFBElHsRTJ6++BIAHEB9/6gihQGlCwSSPTzDFVVldEdJHJe4yd8J85O2z1oIDg0o/
 l9Ep+P6fVL1Bsz2xjI/mwID9JGVhU7q7gnLcKS35LRNdg7NR0ee+5s0M8+jQY4ZUOHeW
 i9mnTFP4WlQSEe2bYNEAv6aQuJr5eYXjWunW4C0Je7Ebjf9L9SpDosoG5Hwgz2FwtPrl
 n9fioeEdzfAih9sePcytCmX4DvGrPhuP/kOJ/mgRiVJoTw5ZBmbWoHiWHhyKlzXXmg2r
 3SBw==
X-Gm-Message-State: AOAM531IfnRw+nlWh9m97CTbxF1fZNordHGDdIGUAgZ94g6Ma0OhTmC6
 NuyCqAJ0TJH13eKfoezK47dfH9O9Kr8=
X-Google-Smtp-Source: ABdhPJytLqLNKFnRdjTpOfASm3JObVN4Prjhm2PLUTbV7J51viS9H3Lyw+8Nm9OtNBd8XkJ4ho5HgQ==
X-Received: by 2002:a62:e219:: with SMTP id a25mr26505426pfi.303.1591117319866; 
 Tue, 02 Jun 2020 10:01:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h11sm2723630pjk.20.2020.06.02.10.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 10:01:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] tcg/i386: Implement INDEX_op_rotl{i,s,v}_vec
Date: Tue,  2 Jun 2020 10:01:44 -0700
Message-Id: <20200602170151.321389-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602170151.321389-1-richard.henderson@linaro.org>
References: <20200602170151.321389-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For immediates, we must continue the special casing of 8-bit
elements.  The other element sizes and shift types are trivially
implemented with shifts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 116 ++++++++++++++++++++++++++++++++------
 1 file changed, 100 insertions(+), 16 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index ec083bddcf..ae0228238b 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3233,6 +3233,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shls_vec:
     case INDEX_op_shrs_vec:
     case INDEX_op_sars_vec:
+    case INDEX_op_rotls_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3271,6 +3272,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_xor_vec:
     case INDEX_op_andc_vec:
         return 1;
+    case INDEX_op_rotli_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_cmpsel_vec:
         return -1;
@@ -3297,12 +3299,17 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
         return vece >= MO_16;
     case INDEX_op_sars_vec:
         return vece >= MO_16 && vece <= MO_32;
+    case INDEX_op_rotls_vec:
+        return vece >= MO_16 ? -1 : 0;
 
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
         return have_avx2 && vece >= MO_32;
     case INDEX_op_sarv_vec:
         return have_avx2 && vece == MO_32;
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
+        return have_avx2 && vece >= MO_32 ? -1 : 0;
 
     case INDEX_op_mul_vec:
         if (vece == MO_8) {
@@ -3331,7 +3338,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
-static void expand_vec_shi(TCGType type, unsigned vece, bool shr,
+static void expand_vec_shi(TCGType type, unsigned vece, TCGOpcode opc,
                            TCGv_vec v0, TCGv_vec v1, TCGArg imm)
 {
     TCGv_vec t1, t2;
@@ -3341,26 +3348,31 @@ static void expand_vec_shi(TCGType type, unsigned vece, bool shr,
     t1 = tcg_temp_new_vec(type);
     t2 = tcg_temp_new_vec(type);
 
-    /* Unpack to W, shift, and repack.  Tricky bits:
-       (1) Use punpck*bw x,x to produce DDCCBBAA,
-           i.e. duplicate in other half of the 16-bit lane.
-       (2) For right-shift, add 8 so that the high half of
-           the lane becomes zero.  For left-shift, we must
-           shift up and down again.
-       (3) Step 2 leaves high half zero such that PACKUSWB
-           (pack with unsigned saturation) does not modify
-           the quantity.  */
+    /*
+     * Unpack to W, shift, and repack.  Tricky bits:
+     * (1) Use punpck*bw x,x to produce DDCCBBAA,
+     *     i.e. duplicate in other half of the 16-bit lane.
+     * (2) For right-shift, add 8 so that the high half of the lane
+     *     becomes zero.  For left-shift, and left-rotate, we must
+     *     shift up and down again.
+     * (3) Step 2 leaves high half zero such that PACKUSWB
+     *     (pack with unsigned saturation) does not modify
+     *     the quantity.
+     */
     vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
               tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
     vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
               tcgv_vec_arg(t2), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
 
-    if (shr) {
-        tcg_gen_shri_vec(MO_16, t1, t1, imm + 8);
-        tcg_gen_shri_vec(MO_16, t2, t2, imm + 8);
+    if (opc != INDEX_op_rotli_vec) {
+        imm += 8;
+    }
+    if (opc == INDEX_op_shri_vec) {
+        tcg_gen_shri_vec(MO_16, t1, t1, imm);
+        tcg_gen_shri_vec(MO_16, t2, t2, imm);
     } else {
-        tcg_gen_shli_vec(MO_16, t1, t1, imm + 8);
-        tcg_gen_shli_vec(MO_16, t2, t2, imm + 8);
+        tcg_gen_shli_vec(MO_16, t1, t1, imm);
+        tcg_gen_shli_vec(MO_16, t2, t2, imm);
         tcg_gen_shri_vec(MO_16, t1, t1, 8);
         tcg_gen_shri_vec(MO_16, t2, t2, 8);
     }
@@ -3427,6 +3439,61 @@ static void expand_vec_sari(TCGType type, unsigned vece,
     }
 }
 
+static void expand_vec_rotli(TCGType type, unsigned vece,
+                             TCGv_vec v0, TCGv_vec v1, TCGArg imm)
+{
+    TCGv_vec t;
+
+    if (vece == MO_8) {
+        expand_vec_shi(type, vece, INDEX_op_rotli_vec, v0, v1, imm);
+        return;
+    }
+
+    t = tcg_temp_new_vec(type);
+    tcg_gen_shli_vec(vece, t, v1, imm);
+    tcg_gen_shri_vec(vece, v0, v1, (8 << vece) - imm);
+    tcg_gen_or_vec(vece, v0, v0, t);
+    tcg_temp_free_vec(t);
+}
+
+static void expand_vec_rotls(TCGType type, unsigned vece,
+                             TCGv_vec v0, TCGv_vec v1, TCGv_i32 lsh)
+{
+    TCGv_i32 rsh;
+    TCGv_vec t;
+
+    tcg_debug_assert(vece != MO_8);
+
+    t = tcg_temp_new_vec(type);
+    rsh = tcg_temp_new_i32();
+
+    tcg_gen_neg_i32(rsh, lsh);
+    tcg_gen_andi_i32(rsh, rsh, (8 << vece) - 1);
+    tcg_gen_shls_vec(vece, t, v1, lsh);
+    tcg_gen_shrs_vec(vece, v0, v1, rsh);
+    tcg_gen_or_vec(vece, v0, v0, t);
+    tcg_temp_free_vec(t);
+    tcg_temp_free_i32(rsh);
+}
+
+static void expand_vec_rotv(TCGType type, unsigned vece, TCGv_vec v0,
+                            TCGv_vec v1, TCGv_vec sh, bool right)
+{
+    TCGv_vec t = tcg_temp_new_vec(type);
+
+    tcg_gen_dupi_vec(vece, t, 8 << vece);
+    tcg_gen_sub_vec(vece, t, t, sh);
+    if (right) {
+        tcg_gen_shlv_vec(vece, t, v1, t);
+        tcg_gen_shrv_vec(vece, v0, v1, sh);
+    } else {
+        tcg_gen_shrv_vec(vece, t, v1, t);
+        tcg_gen_shlv_vec(vece, v0, v1, sh);
+    }
+    tcg_gen_or_vec(vece, v0, v0, t);
+    tcg_temp_free_vec(t);
+}
+
 static void expand_vec_mul(TCGType type, unsigned vece,
                            TCGv_vec v0, TCGv_vec v1, TCGv_vec v2)
 {
@@ -3636,13 +3703,30 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     switch (opc) {
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
-        expand_vec_shi(type, vece, opc == INDEX_op_shri_vec, v0, v1, a2);
+        expand_vec_shi(type, vece, opc, v0, v1, a2);
         break;
 
     case INDEX_op_sari_vec:
         expand_vec_sari(type, vece, v0, v1, a2);
         break;
 
+    case INDEX_op_rotli_vec:
+        expand_vec_rotli(type, vece, v0, v1, a2);
+        break;
+
+    case INDEX_op_rotls_vec:
+        expand_vec_rotls(type, vece, v0, v1, temp_tcgv_i32(arg_temp(a2)));
+        break;
+
+    case INDEX_op_rotlv_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        expand_vec_rotv(type, vece, v0, v1, v2, false);
+        break;
+    case INDEX_op_rotrv_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        expand_vec_rotv(type, vece, v0, v1, v2, true);
+        break;
+
     case INDEX_op_mul_vec:
         v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_mul(type, vece, v0, v1, v2);
-- 
2.25.1


