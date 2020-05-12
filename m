Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5465CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D662205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gm2WNXkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D662205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYY0b-0003rf-JH
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw1-0006E5-HQ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw0-00062v-DM
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id e1so2364812wrt.5
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NRx9HxkT7GwADPC7+Ge+K4Hy5E9A9Z7xxkBA/YQUIh8=;
 b=Gm2WNXkArhuo0Vmrq9nTihLB4e6i4PkKuI3XcQPj3xwsL4dT7Y3wyMB+GnF0BJsuEq
 0DAU6NPdP0IrmajDxc+trJA+dJDrrv/rPvBvoCexQDTHEDhbezHaf4zzCZPZC9W4gYn4
 IZAfLrfVrim+78o6FUkyBxQ7QcDVAHes5J1HqqnFw+MfXavLbjs0zzwQy4ltYg1RSx1a
 IjENSpa7QX+VDiyRv8wlUQYkjAPZ6rwxYjInevf9VCgWBQY9UXqyCUFMHmW0HBKPo3YN
 UE5L+2TLFa7j/lbkGM/b2NiF2mXQrDwN3KejH7SMuB72Qhmi+mjw19sGiE0l8TUOJJQW
 XqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NRx9HxkT7GwADPC7+Ge+K4Hy5E9A9Z7xxkBA/YQUIh8=;
 b=I/fm51He/A67bE+bJfKHyDETj1c8rFuWaSY/M74kIHokV9/ej5XnvhN0fVUt2VmtiF
 aCfSoYTmhyyA9plhpTEc2gEH6NhBfOvyrzCIPPU1JfyCBiBG7CwRZbEJ9GDYFTQHTH5v
 +2kllh+PT0ACsmNiljtNeqUSH9lwU18u/qxUc0qHIYxmCS49O9EEQr1Iq9AYK/gI/jwj
 2rA9/UUvJB64Y6Bm1A2hk3LlePbDqzL3138v6yJFDwVJz2psCe1Wn0ojcMgm1Lx+1Th5
 hTgYGZIAiCizdOEclxtbkNm/5oB2F7zTC7pLaPKFVWYSq4E1G2nNww15MhtGtPTnHbZy
 AdTA==
X-Gm-Message-State: AGi0PuZSG6EYlat1FPqG55DGE2TC+Z6zMBmE9RvjUczro3Stb/qzo/yA
 AL61ikv8/FEC/lgxhA3rmeR6k8h9aF2kKw==
X-Google-Smtp-Source: APiQypIJCkDM45ZCUnSF/H9zCtMm29HHyMB7AvDfb0C1fW49/0yECqXnGzWceNPFp9x0O3YfizwJVw==
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr25924554wrm.294.1589301550972; 
 Tue, 12 May 2020 09:39:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 03/17] target/arm: Convert Neon 64-bit element 3-reg-same
 insns
Date: Tue, 12 May 2020 17:38:50 +0100
Message-Id: <20200512163904.10918-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the 64-bit element insns in the 3-reg-same group
to decodetree. This covers VQSHL, VRSHL and VQRSHL where
size==0b11.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 21 ++++++++++++++++++
 target/arm/translate-neon.inc.c | 24 +++++++++++++++++++++
 target/arm/translate.c          | 38 ++-------------------------------
 3 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 68b0a44793f..fe649038547 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -73,6 +73,27 @@ VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
 VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same_rev
 VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
 
+# Insns operating on 64-bit elements (size!=0b11 handled elsewhere)
+# The _rev suffix indicates that Vn and Vm are reversed. This is
+# the case for shifts. In the Arm ARM these insns are documented
+# with the Vm and Vn fields in their usual places, but in the
+# assembly the operands are listed "backwards", ie in the order
+# Dd, Dm, Dn where other insns use Dd, Dn, Dm. For QEMU we choose
+# to consider Vm and Vm as being in different fields in the insn,
+# which allows us to avoid special-casing shifts in the trans_
+# function code (where we would otherwise need to manually swap
+# the operands over to call Neon helper functions that are shared
+# with AArch64 which does not have this odd reversed-operand situation).
+@3same_64_rev    .... ... . . . 11 .... .... .... . q:1 . . .... \
+                 &3same vm=%vn_dp vn=%vm_dp vd=%vd_dp size=3
+
+VQSHL_S64_3s     1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_64_rev
+VQSHL_U64_3s     1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_64_rev
+VRSHL_S64_3s     1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_64_rev
+VRSHL_U64_3s     1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_64_rev
+VQRSHL_S64_3s    1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_64_rev
+VQRSHL_U64_3s    1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same_64_rev
+
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
 VMIN_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 1 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 03b3337e460..05c6dcdc9b9 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -825,3 +825,27 @@ static bool trans_SHA256SU1_3s(DisasContext *s, arg_SHA256SU1_3s *a)
 
     return true;
 }
+
+#define DO_3SAME_64(INSN, FUNC)                                         \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        static const GVecGen3 op = { .fni8 = FUNC };                    \
+        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &op);      \
+    }                                                                   \
+    DO_3SAME(INSN, gen_##INSN##_3s)
+
+#define DO_3SAME_64_ENV(INSN, FUNC)                                     \
+    static void gen_##INSN##_elt(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)    \
+    {                                                                   \
+        FUNC(d, cpu_env, n, m);                                         \
+    }                                                                   \
+    DO_3SAME_64(INSN, gen_##INSN##_elt)
+
+DO_3SAME_64(VRSHL_S64, gen_helper_neon_rshl_s64)
+DO_3SAME_64(VRSHL_U64, gen_helper_neon_rshl_u64)
+DO_3SAME_64_ENV(VQSHL_S64, gen_helper_neon_qshl_s64)
+DO_3SAME_64_ENV(VQSHL_U64, gen_helper_neon_qshl_u64)
+DO_3SAME_64_ENV(VQRSHL_S64, gen_helper_neon_qrshl_s64)
+DO_3SAME_64_ENV(VQRSHL_U64, gen_helper_neon_qrshl_u64)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ee2b8d6f6e3..1ce3e182867 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5459,42 +5459,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
 
         if (size == 3) {
-            /* 64-bit element instructions. */
-            for (pass = 0; pass < (q ? 2 : 1); pass++) {
-                neon_load_reg64(cpu_V0, rn + pass);
-                neon_load_reg64(cpu_V1, rm + pass);
-                switch (op) {
-                case NEON_3R_VQSHL:
-                    if (u) {
-                        gen_helper_neon_qshl_u64(cpu_V0, cpu_env,
-                                                 cpu_V1, cpu_V0);
-                    } else {
-                        gen_helper_neon_qshl_s64(cpu_V0, cpu_env,
-                                                 cpu_V1, cpu_V0);
-                    }
-                    break;
-                case NEON_3R_VRSHL:
-                    if (u) {
-                        gen_helper_neon_rshl_u64(cpu_V0, cpu_V1, cpu_V0);
-                    } else {
-                        gen_helper_neon_rshl_s64(cpu_V0, cpu_V1, cpu_V0);
-                    }
-                    break;
-                case NEON_3R_VQRSHL:
-                    if (u) {
-                        gen_helper_neon_qrshl_u64(cpu_V0, cpu_env,
-                                                  cpu_V1, cpu_V0);
-                    } else {
-                        gen_helper_neon_qrshl_s64(cpu_V0, cpu_env,
-                                                  cpu_V1, cpu_V0);
-                    }
-                    break;
-                default:
-                    abort();
-                }
-                neon_store_reg64(cpu_V0, rd + pass);
-            }
-            return 0;
+            /* 64-bit element instructions: handled by decodetree */
+            return 1;
         }
         pairwise = 0;
         switch (op) {
-- 
2.20.1


