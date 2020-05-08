Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E46C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8B22173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLGvksMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8B22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4ha-0007hz-C8
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4eY-0002YR-6G
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:06 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4eX-00041c-4F
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:05 -0400
Received: by mail-pl1-x644.google.com with SMTP id b6so827518plz.13
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mb6+03AG81j4l13iRjqThWgHGhR3wys/dJWWzc/5sWs=;
 b=gLGvksMKfz+Z4Hr1vQh6AuLSjfvEtRV2t6ZJzBEtJmg4JKe6XuFV8MN3TcI/Ia0JDI
 CbWgy9Hbhr7n2G7Lt1aXghCA5nqY0crsVpSLo4gEfOYkCiaNorQpqfwusez/yLV2uVfz
 jWgxWwJeD/meh0MgEZQFsYQZchQibb2PO0rW0VtBWpqBEPg2cysX+BykNz6i/yxqu7n6
 Z39xgjxWM86JWr2OOTi/RT7n8P0hV4fNuhOOtqY69cafiRxXbCLEPjACqeKhR7WB72gD
 nHMj2VeFQ2sSTipFqRFHQS+G8FiDlSIK7i/cDmB69rt7gctX0e6VFUrfJqQLKxJ6PTwN
 ajsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mb6+03AG81j4l13iRjqThWgHGhR3wys/dJWWzc/5sWs=;
 b=FzPc2sthVrkvgx/Z+qJziR4XME5HnrDyvSXr1CYRlFfI1VU6V4F8MP1zLBglsfbfRy
 cnkgcK0yi/46m9NsBwbUxJBK+XxxKF8SgsYrAZCFzxd0op3qhib7oEyWzkcSwHtL7Vas
 P/CTvoohCFHU+8/k/pwc7tW2P8NCVNSGxaChMYD8FKNlHxWGmX7jTc59AwSEQBNcfDxv
 NF5CT5J7gbTzzLlEg3s3Iu1OwVbWVjCq/8+KwQV5kfUntx0/iRAizKCU6caiNNKCK9wo
 7oAainuJZQsiD8iYhzL8SyQWkAxG4rDbbHKFol/gFKYkYWzO32q1fNZpFxJ7OE80I8j4
 lbpA==
X-Gm-Message-State: AGi0PuZDHc21B4pU3puZyRPSEs6Fn3d4s8tCWt8AVH3whdYYddhO73Km
 GlJ1LQ26KllF1eXS+exeP3RrIA4gAs0=
X-Google-Smtp-Source: APiQypKi4D3wMyd80MQ7v/yvwU70wtE0r7RV1zFiYMxtmMT8+BAuWu0vnp7PJYG51fxbH569I9kuKA==
X-Received: by 2002:a17:90a:ac0a:: with SMTP id
 o10mr5989396pjq.27.1588950663227; 
 Fri, 08 May 2020 08:11:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d13sm1557562pga.64.2020.05.08.08.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:11:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/10] tcg/i386: Implement INDEX_op_rotl{i,s,v}_vec
Date: Fri,  8 May 2020 08:10:50 -0700
Message-Id: <20200508151055.5832-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151055.5832-1-richard.henderson@linaro.org>
References: <20200508151055.5832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: alex.bennee@linaro.org
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
2.20.1


