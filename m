Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2320DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7E02067C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqLRNhOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7E02067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQa5-00005h-SN
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGQXN-0003uT-1T
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:39:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGQXJ-0002nX-Mf
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:39:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id b79so997516wmb.4
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2T22hnWTeC2DUA3syxYlTqgfpNOouUNFsu2vYh7GjxQ=;
 b=kqLRNhOm6qFvWXYbHP6w2hJGJuBwpcT1ly2UeJh2QxRj9o9FKpxE42YV4NqwFlViK0
 U0QX6kv5Nj5WO3ktM+rRa12wxKkTMuJsNusl/KWB/puxU3QSlkHLpVoNglJpRqLzbPaH
 fF48+mUC8AnY13G72QoROJ9jqcD/SgzmJC2OyOZ+QAZPV+0A6avddNJi2gW9lrRaF4y9
 kfTXS9KBZ/8I5Zc1bE03j4shZS0AWbQsUH3tBgL3u/qPtc4HofvbvZNff8R9JumSdzGT
 8VC4mw4BKE8/mImTGB9CqNPLL2sohFtYr2tN97fmiMiqCDktCG3MtywfAm+0JQUah2qY
 vVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2T22hnWTeC2DUA3syxYlTqgfpNOouUNFsu2vYh7GjxQ=;
 b=roPWFVmMjqm7/joJaguPq3HWLMj7JJlUaH498smmYR0rhk0SDJy3dc/ruBVnftWjpc
 fjyYAaTb8KtycxYg7szfjIw514p/nMA3mb5lF1v+YbA7y1ngHKV4EojAEP75lcridQLA
 ii8gd+C1Tcw63eEdQaolHfVm3TdYNGHSZxburt0/FyUu0FqbDGINb4U4pPiZ00W4v7Z1
 09iZMnbDFrmBZRoyVOM4qF7Cr06LJoaqoUfgApbkvscF88Auu5eupjHsaCPVe0DjXiA0
 8C3pDYjVaLKIgVh69/nntKpl0Zq6PhPHviB2F2yoJH/cEB+9J/GpjQk0zRgS2smQjz41
 lUnQ==
X-Gm-Message-State: AOAM532NiOJ2w07o552uSETBB9uhW0bSwkAux/G9OQWbJWmdj45lsh8x
 U6DYzQNipS0Wbt+G9dN5/LGXuQ==
X-Google-Smtp-Source: ABdhPJyJGfXgYb8X3TQKSq7KlSu5AiGkFPwJJO7cjkdHiH7P0uBuR9YuhyC1GHlSisEo8D1mPPSozw==
X-Received: by 2002:a1c:a789:: with SMTP id q131mr1067339wme.141.1599759543367; 
 Thu, 10 Sep 2020 10:39:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q186sm4603128wma.45.2020.09.10.10.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 10:39:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/5] target/arm: Move id_pfr0, id_pfr1 into ARMISARegisters
Date: Thu, 10 Sep 2020 18:38:52 +0100
Message-Id: <20200910173855.4068-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910173855.4068-1-peter.maydell@linaro.org>
References: <20200910173855.4068-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move the id_pfr0 and id_pfr1 fields into the ARMISARegisters
sub-struct. We're going to want id_pfr1 for an isar_features
check, and moving both at the same time avoids an odd
inconsistency.

Changes other than the ones to cpu.h and kvm64.c made
automatically with:
  perl -p -i -e 's/cpu->id_pfr/cpu->isar.id_pfr/' target/arm/*.c hw/intc/armv7m_nvic.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I haven't changed the kvm32.c code to read the ID_PFR* from
the kernel as the comment above ARMISARegisters suggests,
because I expect the patchset deleting that file to go in
before this one.
---
 target/arm/cpu.h      |  4 ++--
 hw/intc/armv7m_nvic.c |  4 ++--
 target/arm/cpu.c      | 20 ++++++++++----------
 target/arm/cpu64.c    | 12 ++++++------
 target/arm/cpu_tcg.c  | 36 ++++++++++++++++++------------------
 target/arm/helper.c   |  4 ++--
 target/arm/kvm64.c    |  4 ++++
 7 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b7c2615b2fe..de2ab41e2a0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -909,6 +909,8 @@ struct ARMCPU {
         uint32_t id_mmfr2;
         uint32_t id_mmfr3;
         uint32_t id_mmfr4;
+        uint32_t id_pfr0;
+        uint32_t id_pfr1;
         uint32_t mvfr0;
         uint32_t mvfr1;
         uint32_t mvfr2;
@@ -929,8 +931,6 @@ struct ARMCPU {
     uint32_t reset_fpsid;
     uint32_t ctr;
     uint32_t reset_sctlr;
-    uint32_t id_pfr0;
-    uint32_t id_pfr1;
     uint64_t pmceid0;
     uint64_t pmceid1;
     uint32_t id_afr0;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 7876c1ba07e..a28be49c1e9 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1238,9 +1238,9 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
                       "Aux Fault status registers unimplemented\n");
         return 0;
     case 0xd40: /* PFR0.  */
-        return cpu->id_pfr0;
+        return cpu->isar.id_pfr0;
     case 0xd44: /* PFR1.  */
-        return cpu->id_pfr1;
+        return cpu->isar.id_pfr1;
     case 0xd48: /* DFR0.  */
         return cpu->isar.id_dfr0;
     case 0xd4c: /* AFR0.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c5e86ce50af..a4ea71811e5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1660,7 +1660,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         /* Disable the security extension feature bits in the processor feature
          * registers as well. These are id_pfr1[7:4] and id_aa64pfr0[15:12].
          */
-        cpu->id_pfr1 &= ~0xf0;
+        cpu->isar.id_pfr1 &= ~0xf0;
         cpu->isar.id_aa64pfr0 &= ~0xf000;
     }
 
@@ -1697,7 +1697,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * id_aa64pfr0_el1[11:8].
          */
         cpu->isar.id_aa64pfr0 &= ~0xf00;
-        cpu->id_pfr1 &= ~0xf000;
+        cpu->isar.id_pfr1 &= ~0xf000;
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -1895,8 +1895,8 @@ static void cortex_a8_initfn(Object *obj)
     cpu->isar.mvfr1 = 0x00011111;
     cpu->ctr = 0x82048004;
     cpu->reset_sctlr = 0x00c50078;
-    cpu->id_pfr0 = 0x1031;
-    cpu->id_pfr1 = 0x11;
+    cpu->isar.id_pfr0 = 0x1031;
+    cpu->isar.id_pfr1 = 0x11;
     cpu->isar.id_dfr0 = 0x400;
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x31100003;
@@ -1967,8 +1967,8 @@ static void cortex_a9_initfn(Object *obj)
     cpu->isar.mvfr1 = 0x01111111;
     cpu->ctr = 0x80038003;
     cpu->reset_sctlr = 0x00c50078;
-    cpu->id_pfr0 = 0x1031;
-    cpu->id_pfr1 = 0x11;
+    cpu->isar.id_pfr0 = 0x1031;
+    cpu->isar.id_pfr1 = 0x11;
     cpu->isar.id_dfr0 = 0x000;
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x00100103;
@@ -2031,8 +2031,8 @@ static void cortex_a7_initfn(Object *obj)
     cpu->isar.mvfr1 = 0x11111111;
     cpu->ctr = 0x84448003;
     cpu->reset_sctlr = 0x00c50078;
-    cpu->id_pfr0 = 0x00001131;
-    cpu->id_pfr1 = 0x00011011;
+    cpu->isar.id_pfr0 = 0x00001131;
+    cpu->isar.id_pfr1 = 0x00011011;
     cpu->isar.id_dfr0 = 0x02010555;
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
@@ -2076,8 +2076,8 @@ static void cortex_a15_initfn(Object *obj)
     cpu->isar.mvfr1 = 0x11111111;
     cpu->ctr = 0x8444c004;
     cpu->reset_sctlr = 0x00c50078;
-    cpu->id_pfr0 = 0x00001131;
-    cpu->id_pfr1 = 0x00011011;
+    cpu->isar.id_pfr0 = 0x00001131;
+    cpu->isar.id_pfr1 = 0x00011011;
     cpu->isar.id_dfr0 = 0x02010555;
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10201105;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3c2b3d95993..e00271b932f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -108,8 +108,8 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000043;
     cpu->ctr = 0x8444c004;
     cpu->reset_sctlr = 0x00c50838;
-    cpu->id_pfr0 = 0x00000131;
-    cpu->id_pfr1 = 0x00011011;
+    cpu->isar.id_pfr0 = 0x00000131;
+    cpu->isar.id_pfr1 = 0x00011011;
     cpu->isar.id_dfr0 = 0x03010066;
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
@@ -161,8 +161,8 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000043;
     cpu->ctr = 0x84448004; /* L1Ip = VIPT */
     cpu->reset_sctlr = 0x00c50838;
-    cpu->id_pfr0 = 0x00000131;
-    cpu->id_pfr1 = 0x00011011;
+    cpu->isar.id_pfr0 = 0x00000131;
+    cpu->isar.id_pfr1 = 0x00011011;
     cpu->isar.id_dfr0 = 0x03010066;
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
@@ -213,8 +213,8 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000043;
     cpu->ctr = 0x8444c004;
     cpu->reset_sctlr = 0x00c50838;
-    cpu->id_pfr0 = 0x00000131;
-    cpu->id_pfr1 = 0x00011011;
+    cpu->isar.id_pfr0 = 0x00000131;
+    cpu->isar.id_pfr1 = 0x00011011;
     cpu->isar.id_dfr0 = 0x03010066;
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10201105;
diff --git a/target/arm/cpu_tcg.c b/target/arm/cpu_tcg.c
index 00b0e08f33e..a9b7cf52550 100644
--- a/target/arm/cpu_tcg.c
+++ b/target/arm/cpu_tcg.c
@@ -142,8 +142,8 @@ static void arm1136_r2_initfn(Object *obj)
     cpu->isar.mvfr1 = 0x00000000;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00050078;
-    cpu->id_pfr0 = 0x111;
-    cpu->id_pfr1 = 0x1;
+    cpu->isar.id_pfr0 = 0x111;
+    cpu->isar.id_pfr1 = 0x1;
     cpu->isar.id_dfr0 = 0x2;
     cpu->id_afr0 = 0x3;
     cpu->isar.id_mmfr0 = 0x01130003;
@@ -173,8 +173,8 @@ static void arm1136_initfn(Object *obj)
     cpu->isar.mvfr1 = 0x00000000;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00050078;
-    cpu->id_pfr0 = 0x111;
-    cpu->id_pfr1 = 0x1;
+    cpu->isar.id_pfr0 = 0x111;
+    cpu->isar.id_pfr1 = 0x1;
     cpu->isar.id_dfr0 = 0x2;
     cpu->id_afr0 = 0x3;
     cpu->isar.id_mmfr0 = 0x01130003;
@@ -205,8 +205,8 @@ static void arm1176_initfn(Object *obj)
     cpu->isar.mvfr1 = 0x00000000;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00050078;
-    cpu->id_pfr0 = 0x111;
-    cpu->id_pfr1 = 0x11;
+    cpu->isar.id_pfr0 = 0x111;
+    cpu->isar.id_pfr1 = 0x11;
     cpu->isar.id_dfr0 = 0x33;
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x01130003;
@@ -234,8 +234,8 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->isar.mvfr0 = 0x11111111;
     cpu->isar.mvfr1 = 0x00000000;
     cpu->ctr = 0x1d192992; /* 32K icache 32K dcache */
-    cpu->id_pfr0 = 0x111;
-    cpu->id_pfr1 = 0x1;
+    cpu->isar.id_pfr0 = 0x111;
+    cpu->isar.id_pfr1 = 0x1;
     cpu->isar.id_dfr0 = 0;
     cpu->id_afr0 = 0x2;
     cpu->isar.id_mmfr0 = 0x01100103;
@@ -266,8 +266,8 @@ static void cortex_m3_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     cpu->midr = 0x410fc231;
     cpu->pmsav7_dregion = 8;
-    cpu->id_pfr0 = 0x00000030;
-    cpu->id_pfr1 = 0x00000200;
+    cpu->isar.id_pfr0 = 0x00000030;
+    cpu->isar.id_pfr1 = 0x00000200;
     cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00000030;
@@ -296,8 +296,8 @@ static void cortex_m4_initfn(Object *obj)
     cpu->isar.mvfr0 = 0x10110021;
     cpu->isar.mvfr1 = 0x11000011;
     cpu->isar.mvfr2 = 0x00000000;
-    cpu->id_pfr0 = 0x00000030;
-    cpu->id_pfr1 = 0x00000200;
+    cpu->isar.id_pfr0 = 0x00000030;
+    cpu->isar.id_pfr1 = 0x00000200;
     cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00000030;
@@ -326,8 +326,8 @@ static void cortex_m7_initfn(Object *obj)
     cpu->isar.mvfr0 = 0x10110221;
     cpu->isar.mvfr1 = 0x12000011;
     cpu->isar.mvfr2 = 0x00000040;
-    cpu->id_pfr0 = 0x00000030;
-    cpu->id_pfr1 = 0x00000200;
+    cpu->isar.id_pfr0 = 0x00000030;
+    cpu->isar.id_pfr1 = 0x00000200;
     cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00100030;
@@ -358,8 +358,8 @@ static void cortex_m33_initfn(Object *obj)
     cpu->isar.mvfr0 = 0x10110021;
     cpu->isar.mvfr1 = 0x11000011;
     cpu->isar.mvfr2 = 0x00000040;
-    cpu->id_pfr0 = 0x00000030;
-    cpu->id_pfr1 = 0x00000210;
+    cpu->isar.id_pfr0 = 0x00000030;
+    cpu->isar.id_pfr1 = 0x00000210;
     cpu->isar.id_dfr0 = 0x00200000;
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00101F40;
@@ -397,8 +397,8 @@ static void cortex_r5_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->midr = 0x411fc153; /* r1p3 */
-    cpu->id_pfr0 = 0x0131;
-    cpu->id_pfr1 = 0x001;
+    cpu->isar.id_pfr0 = 0x0131;
+    cpu->isar.id_pfr1 = 0x001;
     cpu->isar.id_dfr0 = 0x010400;
     cpu->id_afr0 = 0x0;
     cpu->isar.id_mmfr0 = 0x0210030;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ef6eaf6450f..93c1c01267a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6625,7 +6625,7 @@ static void define_pmu_regs(ARMCPU *cpu)
 static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t pfr1 = cpu->id_pfr1;
+    uint64_t pfr1 = cpu->isar.id_pfr1;
 
     if (env->gicv3state) {
         pfr1 |= 1 << 28;
@@ -7258,7 +7258,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->id_pfr0 },
+              .resetvalue = cpu->isar.id_pfr0 },
             /* ID_PFR1 is not a plain ARM_CP_CONST because we don't know
              * the value of the GIC field until after we define these regs.
              */
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ef1e9602850..736be1f236b 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -555,6 +555,10 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * than skipping the reads and leaving 0, as we must avoid
          * considering the values in every case.
          */
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr0,
+                              ARM64_SYS_REG(3, 0, 0, 1, 0));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr1,
+                              ARM64_SYS_REG(3, 0, 0, 1, 1));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
                               ARM64_SYS_REG(3, 0, 0, 1, 2));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
-- 
2.20.1


