Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD2D205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCdahtif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD2D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF0A-0001CO-Pg
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkh-0003dF-JO
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:23 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkg-0005zf-JH
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:23 -0400
Received: by mail-wr1-x42b.google.com with SMTP id s8so4340107wrt.9
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rOocNAVFm8fxOf1lEb5dM4+1aqo/08SHs9Bs29VwNzc=;
 b=wCdahtifU1DcLJIsvJXMZShizFMgAlg9utWM/RB0ZYOWfyVeedDNWF0a3RpsTi3moM
 gXZE/TEbQYKw1uZQO10WzX8EY4MTwltMQLh+lQPrUyuajpqriPc47Dzs+/Q06trPqoZE
 2p48yQMPVy4DnEaJkEaMSuB7bpaCYiBUG1LgJ+diuOa1Kr8xDrIVzweHBdYoqL7PXcMa
 Z4+36k042Q1EAaUPgS1fG5wf7R7GVpp3NczKsTpvcFL9uOqBc0sxjoWglt7BSdhUpVXE
 yU7KY+x9V0ox1i50h5rYSHr8D8+FpeaZrfDNbLO/mwFzR60Z7z8e0g5YUo9Sa8hDL1Hu
 elUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rOocNAVFm8fxOf1lEb5dM4+1aqo/08SHs9Bs29VwNzc=;
 b=kjM85kusFS4SJ6Bvtsfyzy428H6DP6qBr2TG5BW57APFM9MNVImAWAoOEoB09vwPBM
 4hvQrSI5siemfY0c2+UVCBS/odeq8UjCbttmCwCAGqAAKvZwkQMfDmoN/XgO4Oisf1+8
 FZLWWkOfD/en9Z/Eamy+7j+n0hhLaLbO4ZoCep7gPVZRmi4zGLzMCCjvNxex12RFCxcR
 nEISPjumMl72QZjGZRTRV+6oH5JBMZL5OTqaBCH1IRJGNfg2CSfWMPvOkMkTNKO7BaC3
 571OkpppjuYuSCG0HNIg94I6MMNCkgeR61rmW6eQSnFOQkBUWVlZAqAcqyvSj1/IbLbm
 t87Q==
X-Gm-Message-State: AOAM531uH5DBVnUJxVVGRI3eaIpa3TkZkTnJRqXaMYXViD5MRrUyZno7
 RnSodcG314w5Ym32lM6B2oaSPBDcC4z+IA==
X-Google-Smtp-Source: ABdhPJzLZnN/H5RgCix9N7IQiUQ/WG/+dNLM2oRDs8srI86YMhahwVa4TgbFu8k7c74hULP6XaXY6Q==
X-Received: by 2002:adf:8483:: with SMTP id 3mr5825302wrg.206.1589466140974;
 Thu, 14 May 2020 07:22:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/45] target/arm: Convert Neon 64-bit element 3-reg-same insns
Date: Thu, 14 May 2020 15:21:24 +0100
Message-Id: <20200514142138.20875-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Convert the 64-bit element insns in the 3-reg-same group
to decodetree. This covers VQSHL, VRSHL and VQRSHL where
size==0b11.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-4-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       | 13 +++++++++++
 target/arm/translate-neon.inc.c | 24 +++++++++++++++++++++
 target/arm/translate.c          | 38 ++-------------------------------
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 72eae12b265..fa52b998e87 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -81,6 +81,19 @@ VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
 VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same_rev
 VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
 
+# Insns operating on 64-bit elements (size!=0b11 handled elsewhere)
+# The _rev suffix indicates that Vn and Vm are reversed (as explained
+# by the comment for the @3same_rev format).
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


