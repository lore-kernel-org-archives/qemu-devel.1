Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F23BC55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E0A2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBDKNXVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E0A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaiuA-00074H-Dv
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kainQ-0008Ur-SW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:11:38 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:46004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kainO-00086h-KP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:11:36 -0500
Received: by mail-pl1-x635.google.com with SMTP id z1so1069365plo.12
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kNbjBkupF0zVjgUXfsX0pswQ6D+6HK9IRUb0+XAw64M=;
 b=bBDKNXVA2RSk/S/ZU9iptMBa2CDUYQ3WYvZGtdfIgnN4x5BsSWtE968o0weK7s+n8k
 62UF5kiwNYJf4v/3J7nhgs5/usCgnU1O5ezaqu87SXTjabfWd8YhUbxQKJA5v5moU7TL
 G0IEgGAJjMPL0Maf3Q3HOwxMwj1p/zHmhuxlwXCgU0Z9mTQdXWLGOYglPP/nz+/+hDo8
 4eB7uBRXR1UYXIavJ4KRNXCvtX+2lYnXWPlqVJi3mH3McQ/jH3Y0velOUpWFTiC49t/o
 ZH17BX3OgJLuLr7VSZA07PZLgHXOPUghb/ubAKhFoHexiRE2htJsMKEG8YdLa1Y9bDsm
 uY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kNbjBkupF0zVjgUXfsX0pswQ6D+6HK9IRUb0+XAw64M=;
 b=AD60of7o2hMzJBUQ3o8Uzp74D2yaanKbfgp5Bqk/YNNRj0dVe/E7326u7D2OQQKano
 z/6/FJlofR/WQ0VsoTkCGmhFgy47i+RddyNahGbweeNtkH4VWTw0+Ig1hMlBVkzuj/s5
 KhGjyOxWvmCDq3Ac99JF8zAk1CL8GxXCPUFsXU7nScwRlTG/zqpR90d+raQGMPxIT1f3
 gqnfXNim5GsDbQ/4QPoFO8pphmhN3xK9L0IG0Kq1x5sbmqHNsLXYiKoPvrcZh6Yl22xg
 4C8/fBw7ktiyabLAOm2TJ9ViL3dcSjPzOoFZkgrGegpv4zgj38sIVlUIyEEqPNNBf1AI
 Ugow==
X-Gm-Message-State: AOAM530HUMMKTI3UV0Q0VrAUDLPNoDlb3GWEbEJe8m31MwGnZ0nd734v
 rGoKLx2z2erEZk4diGGZGxCjVg0y+D7NvQ==
X-Google-Smtp-Source: ABdhPJzuk84QWs1JcAWwplfZ+wEpT1+a/Jn9jkOuDfgtJdq7sWQKTZmTVAo4jA+X9/TnMtjbfi4m4g==
X-Received: by 2002:a17:902:d917:b029:d6:d1b8:5d9a with SMTP id
 c23-20020a170902d917b02900d6d1b85d9amr3115914plz.72.1604596291680; 
 Thu, 05 Nov 2020 09:11:31 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id 5sm3526175pfx.63.2020.11.05.09.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:11:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2] target/arm: Fix neon VTBL/VTBX for len > 1
Date: Thu,  5 Nov 2020 09:11:26 -0800
Message-Id: <20201105171126.88014-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 Ard Biesheuvel <ardb@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The helper function did not get updated when we reorganized
the vector register file for SVE.  Since then, the neon dregs
are non-sequential and cannot be simply indexed.

At the same time, make the helper function operate on 64-bit
quantities so that we do not have to call it twice.

Fixes: c39c2b9043e
Reported-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |  2 +-
 target/arm/op_helper.c          | 23 +++++++++--------
 target/arm/translate-neon.c.inc | 44 +++++++++++----------------------
 3 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 774d2cddb5..ff8148ddc6 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -245,7 +245,7 @@ DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_1(recpe_u32, TCG_CALL_NO_RWG, i32, i32)
 DEF_HELPER_FLAGS_1(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32)
-DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i32, i32, i32, ptr, i32)
+DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i64, env, i32, i64, i64)
 
 DEF_HELPER_3(shl_cc, i32, env, i32, i32)
 DEF_HELPER_3(shr_cc, i32, env, i32, i32)
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index b1065216b2..9bfd6760a0 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -68,21 +68,24 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
     cpu_loop_exit_restore(cs, ra);
 }
 
-uint32_t HELPER(neon_tbl)(uint32_t ireg, uint32_t def, void *vn,
-                          uint32_t maxindex)
+uint64_t HELPER(neon_tbl)(CPUARMState *env, uint32_t desc,
+                          uint64_t ireg, uint64_t def)
 {
-    uint32_t val, shift;
-    uint64_t *table = vn;
+    uint64_t tmp, val = 0;
+    uint32_t maxindex = ((desc & 3) + 1) * 8;
+    uint32_t base_reg = desc >> 2;
+    uint32_t shift, index, reg;
 
-    val = 0;
-    for (shift = 0; shift < 32; shift += 8) {
-        uint32_t index = (ireg >> shift) & 0xff;
+    for (shift = 0; shift < 64; shift += 8) {
+        index = (ireg >> shift) & 0xff;
         if (index < maxindex) {
-            uint32_t tmp = (table[index >> 3] >> ((index & 7) << 3)) & 0xff;
-            val |= tmp << shift;
+            reg = base_reg + (index >> 3);
+            tmp = env->vfp.zregs[reg >> 1].d[reg & 1];
+            tmp = ((tmp >> ((index & 7) << 3)) & 0xff) << shift;
         } else {
-            val |= def & (0xff << shift);
+            tmp = def & (0xffull << shift);
         }
+        val |= tmp;
     }
     return val;
 }
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 59368cb243..0ae95cb8df 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -2861,9 +2861,8 @@ static bool trans_VEXT(DisasContext *s, arg_VEXT *a)
 
 static bool trans_VTBL(DisasContext *s, arg_VTBL *a)
 {
-    int n;
-    TCGv_i32 tmp, tmp2, tmp3, tmp4;
-    TCGv_ptr ptr1;
+    TCGv_i64 val, def;
+    TCGv_i32 desc;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -2879,43 +2878,30 @@ static bool trans_VTBL(DisasContext *s, arg_VTBL *a)
         return true;
     }
 
-    n = a->len + 1;
-    if ((a->vn + n) > 32) {
+    if ((a->vn + a->len + 1) > 32) {
         /*
          * This is UNPREDICTABLE; we choose to UNDEF to avoid the
          * helper function running off the end of the register file.
          */
         return false;
     }
-    n <<= 3;
-    tmp = tcg_temp_new_i32();
-    if (a->op) {
-        read_neon_element32(tmp, a->vd, 0, MO_32);
-    } else {
-        tcg_gen_movi_i32(tmp, 0);
-    }
-    tmp2 = tcg_temp_new_i32();
-    read_neon_element32(tmp2, a->vm, 0, MO_32);
-    ptr1 = vfp_reg_ptr(true, a->vn);
-    tmp4 = tcg_const_i32(n);
-    gen_helper_neon_tbl(tmp2, tmp2, tmp, ptr1, tmp4);
 
+    desc = tcg_const_i32((a->vn << 2) | a->len);
+    def = tcg_temp_new_i64();
     if (a->op) {
-        read_neon_element32(tmp, a->vd, 1, MO_32);
+        read_neon_element64(def, a->vd, 0, MO_64);
     } else {
-        tcg_gen_movi_i32(tmp, 0);
+        tcg_gen_movi_i64(def, 0);
     }
-    tmp3 = tcg_temp_new_i32();
-    read_neon_element32(tmp3, a->vm, 1, MO_32);
-    gen_helper_neon_tbl(tmp3, tmp3, tmp, ptr1, tmp4);
-    tcg_temp_free_i32(tmp);
-    tcg_temp_free_i32(tmp4);
-    tcg_temp_free_ptr(ptr1);
+    val = tcg_temp_new_i64();
+    read_neon_element64(val, a->vm, 0, MO_64);
 
-    write_neon_element32(tmp2, a->vd, 0, MO_32);
-    write_neon_element32(tmp3, a->vd, 1, MO_32);
-    tcg_temp_free_i32(tmp2);
-    tcg_temp_free_i32(tmp3);
+    gen_helper_neon_tbl(val, cpu_env, desc, val, def);
+    write_neon_element64(val, a->vd, 0, MO_64);
+
+    tcg_temp_free_i64(def);
+    tcg_temp_free_i64(val);
+    tcg_temp_free_i32(desc);
     return true;
 }
 
-- 
2.25.1


