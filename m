Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFF7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6796320724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TiwGiwcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6796320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhK4-00087x-JQ
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGj-0002Hp-AZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGh-00035u-M7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id g18so11113462wrm.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=t1bCYdeRbvwavbyNWTI7wfZT9Q1x2S0UP6cctTswOsE=;
 b=TiwGiwcQMCbhDKWzguYEFWCyGX/XSPwxvNhab1W824OzRD5UR7cu7VeH0ERYXEb617
 bNAcPeRhVMDlUPygA92oRX4FuEeAXl2sieUV9FJNApNnPLJibhTUgOJbrknmitYVIhIB
 srIeCQEgL3zMwzl6/1jlctp2K5/Aj3kSzzOzofZ7NScaZ7NHChtVQPurajKb41xKWuTZ
 ctvkJZ4i1hSwPMseb1aYiqObfloAbxDoEf7K53ugime7K5HUUj8ASgB3XfXSZaUbx5W4
 jAREqsTHqhhOYnla0c2QAK9Vj+BfUA/Ji+B7i0aXLmanClriCNZM4TD31giy3NQjaaQm
 nVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t1bCYdeRbvwavbyNWTI7wfZT9Q1x2S0UP6cctTswOsE=;
 b=Ai7r/hHK4FSAOb9vMr5N7G2sZR8h4A2D9t7GBB+bm66pmwDdSHuiJ8C1JIe27gU0Uu
 vo8a3XmRrD7XjjJ5NRVl7CwYLPz7Ek4Pb4M+Lrt5ZlCHmvt7ZbZq3zrmwGt28Pke0AWu
 KiOy3io89A/+5o0BlWva5FzokJbP2Ygsn6cbQEk3QOASmC5mhrGlvcd67+HEpN6AQ6QL
 yV0M5ezdMSiQXMqWN+x/GCoWcMkcled7dVh1eFvs+hFqcNhfbD+9rNT59bfZ9wAWaWfQ
 LE/QB34nd8A8X7NLux0asnyyjKHygtb0+JhLKW4UHwLMXPBPPEFjMrsEr1KANItfnD/V
 lCNg==
X-Gm-Message-State: AOAM533zd+hNVvesLmO9NoAoQo+KENgMD051UUY21HpM6TJzzT5sktKg
 JoxI07iJerDCYjkySc3pDRCdfsG55IxedQ==
X-Google-Smtp-Source: ABdhPJzqm1DK9hmGLCyK++Z/fkah/8+GrwEzGW7oYX+a00SPU1ENqjM6jSLQ+xdEKyxcjslF6zF0kw==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr24871322wrr.264.1592912349843; 
 Tue, 23 Jun 2020 04:39:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/42] target/arm: Convert Neon 2-reg-misc VREV64 to decodetree
Date: Tue, 23 Jun 2020 12:38:25 +0100
Message-Id: <20200623113904.28805-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Convert the Neon VREV64 insn from the 2-reg-misc grouping to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-2-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       | 12 ++++++++
 target/arm/translate-neon.inc.c | 50 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 24 ++--------------
 3 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 6d890b2161f..e12fdf30957 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -429,6 +429,18 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
                  vm=%vm_dp vd=%vd_dp size=1
     VDUP_scalar  1111 001 1 1 . 11 index:1 100 .... 11 000 q:1 . 0 .... \
                  vm=%vm_dp vd=%vd_dp size=2
+
+    ##################################################################
+    # 2-reg-misc grouping:
+    # 1111 001 11 D 11 size:2 opc1:2 Vd:4 0 opc2:4 q:1 M 0 Vm:4
+    ##################################################################
+
+    &2misc vd vm q size
+
+    @2misc       .... ... .. . .. size:2 .. .... . .... q:1 . . .... \
+                 &2misc vm=%vm_dp vd=%vd_dp
+
+    VREV64       1111 001 11 . 11 .. 00 .... 0 0000 . . 0 .... @2misc
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index a5aa56bbdeb..90431a5383f 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2970,3 +2970,53 @@ static bool trans_VDUP_scalar(DisasContext *s, arg_VDUP_scalar *a)
                          a->q ? 16 : 8, a->q ? 16 : 8);
     return true;
 }
+
+static bool trans_VREV64(DisasContext *s, arg_VREV64 *a)
+{
+    int pass, half;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (a->size == 3) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
+        TCGv_i32 tmp[2];
+
+        for (half = 0; half < 2; half++) {
+            tmp[half] = neon_load_reg(a->vm, pass * 2 + half);
+            switch (a->size) {
+            case 0:
+                tcg_gen_bswap32_i32(tmp[half], tmp[half]);
+                break;
+            case 1:
+                gen_swap_half(tmp[half]);
+                break;
+            case 2:
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        neon_store_reg(a->vd, pass * 2, tmp[1]);
+        neon_store_reg(a->vd, pass * 2 + 1, tmp[0]);
+    }
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6d18892adee..5fca38b5fae 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5092,28 +5092,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
                 switch (op) {
                 case NEON_2RM_VREV64:
-                    for (pass = 0; pass < (q ? 2 : 1); pass++) {
-                        tmp = neon_load_reg(rm, pass * 2);
-                        tmp2 = neon_load_reg(rm, pass * 2 + 1);
-                        switch (size) {
-                        case 0: tcg_gen_bswap32_i32(tmp, tmp); break;
-                        case 1: gen_swap_half(tmp); break;
-                        case 2: /* no-op */ break;
-                        default: abort();
-                        }
-                        neon_store_reg(rd, pass * 2 + 1, tmp);
-                        if (size == 2) {
-                            neon_store_reg(rd, pass * 2, tmp2);
-                        } else {
-                            switch (size) {
-                            case 0: tcg_gen_bswap32_i32(tmp2, tmp2); break;
-                            case 1: gen_swap_half(tmp2); break;
-                            default: abort();
-                            }
-                            neon_store_reg(rd, pass * 2, tmp2);
-                        }
-                    }
-                    break;
+                    /* handled by decodetree */
+                    return 1;
                 case NEON_2RM_VPADDL: case NEON_2RM_VPADDL_U:
                 case NEON_2RM_VPADAL: case NEON_2RM_VPADAL_U:
                     for (pass = 0; pass < q + 1; pass++) {
-- 
2.20.1


