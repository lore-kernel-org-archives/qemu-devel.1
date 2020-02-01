Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AFCC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4136A205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVAmQsVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4136A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixygo-0005pz-CR
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySx-0007wU-Ah
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySv-000761-Mr
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:03 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySv-00075W-GV
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:01 -0500
Received: by mail-pf1-x443.google.com with SMTP id y5so5250590pfb.11
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QA2XZyURdKBjhvISLZOjMU10Ll/7MveouJBYw/dCIfo=;
 b=sVAmQsVVJpZuqi6JkBXMYOew9YMQDjZ3qU3aQSdW8+3KDB4BC7HJMur7unJKPoRNmA
 xhvab/kC0W/BsAVC3L/NfocflVx7pF6hQbmK5Dwp9Yw7Kw1zXbFRJhSXzl1zHRrZd6cb
 Re/z5D4iWPmfN3W8tVatVCESYT7p9FLd81Bi/8mE/ZD6v1k/Ba12AXMcBG2Coazobr3k
 Fv640PDjQivpmAdy42DUAaAgrgiPJjDUv6xckQR70PkRImJtdf78EivvM8z0ojmy05aS
 CRIBvt647G5vemTWHN5waCHPjXhRipHemGkabCdRHOtDhOfGDfQUz4cTk+3qOSuygXM1
 npIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QA2XZyURdKBjhvISLZOjMU10Ll/7MveouJBYw/dCIfo=;
 b=AI+0CVoWbaUv0w0CuHxwYj3lwqDoMjifD3Z/45LvsxNcer/e287HfE+0XtUQ/8yLtB
 +mDrnK/1c+LC3LYjpiu7obw2iSLJrCyyRY/s3p1U1GyjXJ45qH04gxOpyKY1w/nzOXu8
 GgeH+8ECLbxCFleX/7iIGvnWzzJYIBWtgQ7+gjlOMlsNcCO9v5vLDPzzkvSyI4CiCSXB
 0HZqyeqK8eoZwaCrG5nfNESdBTsMJYA+VHb5cSj2vOZBr5opxpjYVhsrfo/IW1BnUQuI
 A2n+Ita4qyOn1vaIQVRErWA9DY8pGbFXya09ecZnJx11FwYdHbvFJtgditV4B2/puEM/
 LeOw==
X-Gm-Message-State: APjAAAV7+OZG1u2gFkTGq38bOIkvzmlzK+vnkhqMYp5NroS7y0LcUEpG
 mFjnfb8Pj1BLSdqk57YZdcA8yyaSqSE=
X-Google-Smtp-Source: APXvYqy6BC2meU+8gvRpQen7l8TWwxfBoRKeRBWNXqXw2ykjqTjhx2RJ0uLa0tJFIc2F8whqQmweTw==
X-Received: by 2002:aa7:9edd:: with SMTP id r29mr16532029pfq.14.1580585399283; 
 Sat, 01 Feb 2020 11:29:59 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 35/41] target/arm: Update get_a64_user_mem_index for VHE
Date: Sat,  1 Feb 2020 11:29:10 -0800
Message-Id: <20200201192916.31796-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

The EL2&0 translation regime is affected by Load Register (unpriv).

The code structure used here will facilitate later changes in this
area for implementing UAO and NV.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  9 ++++----
 target/arm/translate.h     |  2 ++
 target/arm/helper.c        | 22 +++++++++++++++++++
 target/arm/translate-a64.c | 44 ++++++++++++++++++++++++--------------
 4 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d091a7e2e8..2ed2667a17 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3214,10 +3214,10 @@ typedef ARMCPU ArchCPU;
  * |              |     |   TBFLAG_A32   |              |
  * |              |     +-----+----------+  TBFLAG_AM32 |
  * |  TBFLAG_ANY  |           |TBFLAG_M32|              |
- * |              |           +-------------------------|
- * |              |           |       TBFLAG_A64        |
- * +--------------+-----------+-------------------------+
- *  31          20          14                         0
+ * |              |         +-+----------+--------------|
+ * |              |         |         TBFLAG_A64        |
+ * +--------------+---------+---------------------------+
+ *  31          20        15                           0
  *
  * Unless otherwise noted, these bits are cached in env->hflags.
  */
@@ -3283,6 +3283,7 @@ FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 FIELD(TBFLAG_A64, BT, 9, 1)
 FIELD(TBFLAG_A64, BTYPE, 10, 2)         /* Not cached. */
 FIELD(TBFLAG_A64, TBID, 12, 2)
+FIELD(TBFLAG_A64, UNPRIV, 14, 1)
 
 static inline bool bswap_code(bool sctlr_b)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index a32b6b1b3a..5b167c416a 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -73,6 +73,8 @@ typedef struct DisasContext {
      * ie A64 LDX*, LDAX*, A32/T32 LDREX*, LDAEX*.
      */
     bool is_ldex;
+    /* True if AccType_UNPRIV should be used for LDTR et al */
+    bool unpriv;
     /* True if v8.3-PAuth is active.  */
     bool pauth_active;
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5b4e83adfd..576afd9c9e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12020,6 +12020,28 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    /* Compute the condition for using AccType_UNPRIV for LDTR et al. */
+    /* TODO: ARMv8.2-UAO */
+    switch (mmu_idx) {
+    case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_SE10_1:
+        /* TODO: ARMv8.3-NV */
+        flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
+        break;
+    case ARMMMUIdx_E20_2:
+        /* TODO: ARMv8.4-SecEL2 */
+        /*
+         * Note that E20_2 is gated by HCR_EL2.E2H == 1, but E20_0 is
+         * gated by HCR_EL2.<E2H,TGE> == '11', and so is LDTR.
+         */
+        if (env->cp15.hcr_el2 & HCR_TGE) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
+        }
+        break;
+    default:
+        break;
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3982e1988d..6e82486884 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -105,25 +105,36 @@ void a64_translate_init(void)
         offsetof(CPUARMState, exclusive_high), "exclusive_high");
 }
 
-static inline int get_a64_user_mem_index(DisasContext *s)
+/*
+ * Return the core mmu_idx to use for A64 "unprivileged load/store" insns
+ */
+static int get_a64_user_mem_index(DisasContext *s)
 {
-    /* Return the core mmu_idx to use for A64 "unprivileged load/store" insns:
-     *  if EL1, access as if EL0; otherwise access at current EL
+    /*
+     * If AccType_UNPRIV is not used, the insn uses AccType_NORMAL,
+     * which is the usual mmu_idx for this cpu state.
      */
-    ARMMMUIdx useridx;
+    ARMMMUIdx useridx = s->mmu_idx;
 
-    switch (s->mmu_idx) {
-    case ARMMMUIdx_E10_1:
-        useridx = ARMMMUIdx_E10_0;
-        break;
-    case ARMMMUIdx_SE10_1:
-        useridx = ARMMMUIdx_SE10_0;
-        break;
-    case ARMMMUIdx_Stage2:
-        g_assert_not_reached();
-    default:
-        useridx = s->mmu_idx;
-        break;
+    if (s->unpriv) {
+        /*
+         * We have pre-computed the condition for AccType_UNPRIV.
+         * Therefore we should never get here with a mmu_idx for
+         * which we do not know the corresponding user mmu_idx.
+         */
+        switch (useridx) {
+        case ARMMMUIdx_E10_1:
+            useridx = ARMMMUIdx_E10_0;
+            break;
+        case ARMMMUIdx_E20_2:
+            useridx = ARMMMUIdx_E20_0;
+            break;
+        case ARMMMUIdx_SE10_1:
+            useridx = ARMMMUIdx_SE10_0;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
     return arm_to_core_mmu_idx(useridx);
 }
@@ -14171,6 +14182,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pauth_active = FIELD_EX32(tb_flags, TBFLAG_A64, PAUTH_ACTIVE);
     dc->bt = FIELD_EX32(tb_flags, TBFLAG_A64, BT);
     dc->btype = FIELD_EX32(tb_flags, TBFLAG_A64, BTYPE);
+    dc->unpriv = FIELD_EX32(tb_flags, TBFLAG_A64, UNPRIV);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.20.1


