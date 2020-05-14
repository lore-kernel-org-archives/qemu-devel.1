Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA36C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C4E20727
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xz5tRWcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C4E20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF7D-0003ns-Oz
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkp-0003vr-VE
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEko-00060o-V9
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id n5so18018053wmd.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9E2a6m7F5ZssSmao8aF1y6xe2lQzquAMmYI0Hdbp6MU=;
 b=Xz5tRWcnGP9v9GvkpGCE9h9LOQ4ztMHcfR6irBAcG2bZpmMepRgnFLFqrDcu9rQsKl
 RaFrkm/geOcJyosxK/0PWwbiGcXZrrZuws0uUy7KmKW3aQ2Y8YvYcq147woXxsZ14TIE
 W2ZTHyj/vVuCpevM8u9X02XAoQaCfbDJrBIiKPc4HCJT+LRlndrKcSLSp97cKKHiHwuc
 lHR0WPu67RKQcYJF+R5SATJtV4v6CMMYuEr390laWhGD0lZLjU7hWt/b173v/HnHxk26
 UpC/l2OoVAGKUbPpk5namRtUy06TMfET3bwBv3oDbMsk0EMCevP9EmTdKjABJSbZ3CsE
 l6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9E2a6m7F5ZssSmao8aF1y6xe2lQzquAMmYI0Hdbp6MU=;
 b=qwzw1+xezVc6TqnI40k+Cvm6Pn9ns+DQHgFCGatuobm9wm4w0a23skU3BIi0Y4Jnw3
 qo5IrRhr4SS4ySkXPUFSuQcwqTL3bM3/ORNuZVG6H0LUSVbwggpMh9Dy8CtlozJwIn1d
 OJiiodvu9xiRvfPdSJHmUncrkstYuYnXUjFufRlN55IyaRHvhkOf1hNY/bO0iYOOXKsR
 d/6ruB25ZQkm9FeQKqfBQwgRPY+BChli27w0hJB6ypQTwg0YzX4+x1sLGj2B9FYyunYx
 L7ohBJSyYUmjNvazXchUoTHA13sz9kN4NPbz7rELY7A+6IU0v4gpNksaKpmEwuB/1WEZ
 K78Q==
X-Gm-Message-State: AGi0PuYcJAa7HHNdp+ll8kyhMl1AjD/l0NGc9uN7Bwi0o1/Q0tkT7Txd
 SXaBZp5YGA6qefNbF/EgPpqsV1rX3Sb/qA==
X-Google-Smtp-Source: APiQypIvEJWWykeMB8jzf1d7gbcrf2McrS0t0oB+bZAbdLERcCR0Y0ZpD07PMRAh1O1mu8fWiKT3Aw==
X-Received: by 2002:a1c:f615:: with SMTP id w21mr46753481wmc.183.1589466149199; 
 Thu, 14 May 2020 07:22:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/45] target/arm: Convert Neon VQDMULH/VQRDMULH 3-reg-same to
 decodetree
Date: Thu, 14 May 2020 15:21:31 +0100
Message-Id: <20200514142138.20875-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon VQDMULH and VQRDMULH 3-reg-same insns to
decodetree. These are the last integer operations in the
3-reg-same group.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-11-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  3 +++
 target/arm/translate-neon.inc.c | 24 ++++++++++++++++++++++++
 target/arm/translate.c          | 24 +-----------------------
 3 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 3659fb036c7..fd32837fb17 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -152,6 +152,9 @@ VPMAX_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 0 .... @3same_q0
 VPMIN_S_3s       1111 001 0 0 . .. .... .... 1010 . . . 1 .... @3same_q0
 VPMIN_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 1 .... @3same_q0
 
+VQDMULH_3s       1111 001 0 0 . .. .... .... 1011 . . . 0 .... @3same
+VQRDMULH_3s      1111 001 1 0 . .. .... .... 1011 . . . 0 .... @3same
+
 VPADD_3s         1111 001 0 0 . .. .... .... 1011 . . . 1 .... @3same_q0
 
 VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index e0137364075..f52302f42b1 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -997,3 +997,27 @@ DO_3SAME_PAIR(VPMIN_S, pmin_s)
 DO_3SAME_PAIR(VPMAX_U, pmax_u)
 DO_3SAME_PAIR(VPMIN_U, pmin_u)
 DO_3SAME_PAIR(VPADD, padd_u)
+
+#define DO_3SAME_VQDMULH(INSN, FUNC)                                    \
+    WRAP_ENV_FN(gen_##INSN##_tramp16, gen_helper_neon_##FUNC##_s16);    \
+    WRAP_ENV_FN(gen_##INSN##_tramp32, gen_helper_neon_##FUNC##_s32);    \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        static const GVecGen3 ops[2] = {                                \
+            { .fni4 = gen_##INSN##_tramp16 },                           \
+            { .fni4 = gen_##INSN##_tramp32 },                           \
+        };                                                              \
+        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops[vece - 1]); \
+    }                                                                   \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        if (a->size != 1 && a->size != 2) {                             \
+            return false;                                               \
+        }                                                               \
+        return do_3same(s, a, gen_##INSN##_3s);                         \
+    }
+
+DO_3SAME_VQDMULH(VQDMULH, qdmulh)
+DO_3SAME_VQDMULH(VQRDMULH, qrdmulh)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ce30417014d..561cb67286d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5432,6 +5432,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VPMAX:
         case NEON_3R_VPMIN:
         case NEON_3R_VPADD_VQRDMLAH:
+        case NEON_3R_VQDMULH_VQRDMULH:
             /* Already handled by decodetree */
             return 1;
         }
@@ -5496,29 +5497,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rm, pass);
         }
         switch (op) {
-        case NEON_3R_VQDMULH_VQRDMULH: /* Multiply high.  */
-            if (!u) { /* VQDMULH */
-                switch (size) {
-                case 1:
-                    gen_helper_neon_qdmulh_s16(tmp, cpu_env, tmp, tmp2);
-                    break;
-                case 2:
-                    gen_helper_neon_qdmulh_s32(tmp, cpu_env, tmp, tmp2);
-                    break;
-                default: abort();
-                }
-            } else { /* VQRDMULH */
-                switch (size) {
-                case 1:
-                    gen_helper_neon_qrdmulh_s16(tmp, cpu_env, tmp, tmp2);
-                    break;
-                case 2:
-                    gen_helper_neon_qrdmulh_s32(tmp, cpu_env, tmp, tmp2);
-                    break;
-                default: abort();
-                }
-            }
-            break;
         case NEON_3R_FLOAT_ARITH: /* Floating point arithmetic. */
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.20.1


