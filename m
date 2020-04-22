Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29661C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E631E20724
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtgDWTWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E631E20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4KF-0000Jc-4t
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41b-00025d-Ey
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41X-0002ai-Gv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:03 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:38856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41X-0002VM-1U
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:59 -0400
Received: by mail-pg1-x531.google.com with SMTP id p8so256976pgi.5
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NursXVv/HRRUgUycsc5QQiTW037ba/6j60CDRbihF7Q=;
 b=gtgDWTWJlOgzElJupIxbf9un4Z+mXaj1ZGxWE5Sh1VwraFzKz+/kvncsm879RVoXh3
 owJ+FqlQba97vwLcWQhMuBW8BeJAcYDlwzW2RBdSdzlfd9CmbC6MVsnMnTp4ZiAwsDVY
 oDGNlR2hhIECCEXh9/DycwPc5MvgNABSHTU8LSPfBacoF6Jfk6BS93C+9BHFAQJGNAVJ
 8D8kPfnFnTKAvF3K+7457fookMjJalZ5zxc9PtCVvtdpzXCy94fICXkP/l/F9SmJ4E1H
 9UFclPVoegLy8ipx00tRA/AznOHE1oXJBT4+WJz03iBUnFPNlBj32JiEdyvdtcNQeS8u
 yMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NursXVv/HRRUgUycsc5QQiTW037ba/6j60CDRbihF7Q=;
 b=rmfDfnjNDNCWkWZFk8868U4hZSOs7wF/jhs+YZKn8TQbU7L1G9oaeyfdJbvpRfLa1D
 9SWJF3dDm1cpfO3dG2J+uFLOtGKcUSxr2WwLJdMHNdSXxUVfqQ8cwFdd+CBxzekfOGou
 bppBCxyDlUB7ohQzB2WipA7m+EzBeTGf2Y3MSGugDWG/B8LVy3ZwrXt0qPVoiHYUQOKH
 J1kZhg6uN/dUoQTT/cR97M2T4ih6rhTd1aEA8F6nS7Mr404ID8kxuHyDoD36GMSaRQA6
 HIuOfchlaoIBRJwRrz/pah2+NIwilGq+yA9/YAFaVHfC6/p8NKoQKfZZIFtc50wJ8sfn
 Cd4Q==
X-Gm-Message-State: AGi0PubgvHpxbcHnQPgEmE2T1h32diU3/VBItYgJqxLwQRn8cdPOldH7
 SQKytUZifJAV4vWp+px+qJapCnjEdxU=
X-Google-Smtp-Source: APiQypLCeTTBgP7atXof4ANiFkzxPEOny1IlDmrz4pEH3xuSe7QkE2BeTlVMRN7PTgSlHH/k8+V7dw==
X-Received: by 2002:a63:2b42:: with SMTP id r63mr13265329pgr.227.1587518276981; 
 Tue, 21 Apr 2020 18:17:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 26/36] tcg: Add load_dest parameter to GVecGen2
Date: Tue, 21 Apr 2020 18:17:12 -0700
Message-Id: <20200422011722.13287-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::531
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

We have this same parameter for GVecGen2i, GVecGen3,
and GVecGen3i.  This will make some SVE2 insns easier
to parameterize.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h |  2 ++
 tcg/tcg-op-gvec.c         | 45 ++++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index d89f91f40e..cea6497341 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -109,6 +109,8 @@ typedef struct {
     uint8_t vece;
     /* Prefer i64 to v64.  */
     bool prefer_i64;
+    /* Load dest as a 2nd source operand.  */
+    bool load_dest;
 } GVecGen2;
 
 typedef struct {
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 43cac1a0bf..049a55e700 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -663,17 +663,22 @@ static void expand_clr(uint32_t dofs, uint32_t maxsz)
 
 /* Expand OPSZ bytes worth of two-operand operations using i32 elements.  */
 static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                         void (*fni)(TCGv_i32, TCGv_i32))
+                         bool load_dest, void (*fni)(TCGv_i32, TCGv_i32))
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 4) {
         tcg_gen_ld_i32(t0, cpu_env, aofs + i);
-        fni(t0, t0);
-        tcg_gen_st_i32(t0, cpu_env, dofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i32(t1, cpu_env, dofs + i);
+        }
+        fni(t1, t0);
+        tcg_gen_st_i32(t1, cpu_env, dofs + i);
     }
     tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
 }
 
 static void expand_2i_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
@@ -793,17 +798,22 @@ static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 
 /* Expand OPSZ bytes worth of two-operand operations using i64 elements.  */
 static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                         void (*fni)(TCGv_i64, TCGv_i64))
+                         bool load_dest, void (*fni)(TCGv_i64, TCGv_i64))
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 8) {
         tcg_gen_ld_i64(t0, cpu_env, aofs + i);
-        fni(t0, t0);
-        tcg_gen_st_i64(t0, cpu_env, dofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i64(t1, cpu_env, dofs + i);
+        }
+        fni(t1, t0);
+        tcg_gen_st_i64(t1, cpu_env, dofs + i);
     }
     tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
 }
 
 static void expand_2i_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
@@ -924,17 +934,23 @@ static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 /* Expand OPSZ bytes worth of two-operand operations using host vectors.  */
 static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t oprsz, uint32_t tysz, TCGType type,
+                         bool load_dest,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec))
 {
     TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
     uint32_t i;
 
     for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        fni(vece, t0, t0);
-        tcg_gen_st_vec(t0, cpu_env, dofs + i);
+        if (load_dest) {
+            tcg_gen_ld_vec(t1, cpu_env, dofs + i);
+        }
+        fni(vece, t1, t0);
+        tcg_gen_st_vec(t1, cpu_env, dofs + i);
     }
     tcg_temp_free_vec(t0);
+    tcg_temp_free_vec(t1);
 }
 
 /* Expand OPSZ bytes worth of two-vector operands and an immediate operand
@@ -1088,7 +1104,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
          * that e.g. size == 80 would be expanded with 2x32 + 1x16.
          */
         some = QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256, g->fniv);
+        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
+                     g->load_dest, g->fniv);
         if (some == oprsz) {
             break;
         }
@@ -1098,17 +1115,19 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
         maxsz -= some;
         /* fallthru */
     case TCG_TYPE_V128:
-        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128, g->fniv);
+        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
+                     g->load_dest, g->fniv);
         break;
     case TCG_TYPE_V64:
-        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64, g->fniv);
+        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
+                     g->load_dest, g->fniv);
         break;
 
     case 0:
         if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_2_i64(dofs, aofs, oprsz, g->fni8);
+            expand_2_i64(dofs, aofs, oprsz, g->load_dest, g->fni8);
         } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_2_i32(dofs, aofs, oprsz, g->fni4);
+            expand_2_i32(dofs, aofs, oprsz, g->load_dest, g->fni4);
         } else {
             assert(g->fno != NULL);
             tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
-- 
2.20.1


