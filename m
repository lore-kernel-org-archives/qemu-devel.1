Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE428C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78826206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4b/t62o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78826206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxO4-00068H-N5
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCl-0004Z5-5Z
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCj-0000Q3-JU
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:07 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCj-0000J5-Cc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:05 -0500
Received: by mail-pl1-x642.google.com with SMTP id y1so588322plp.7
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F3b6cVaxHro/6V3bv0YUWDcSAvk6/AJQY4c2EzGHEcc=;
 b=h4b/t62o/p1YVwiwGiKuAgxtVAS/txoQhJDmc8sNM7lhwoHiXn0SFX28M2dST12aMf
 D/02hR2WnCP/UCHtWElpXpi+VhXWiMKwGA+vLKehtFOd4pvpuDvJtWj1v+PTaTAagpwV
 ZZlGwIQGaMxt7GP7unR0wF+BY5s4TMNvb64l/BaNPi1uUElal1Z1bt4nL6eFCZ8jan++
 AcR2NHjLpZP0QIGIlXIurOekeXjkfEF7BXjN/Xm5T8xBEe7c/ehx7rVFkcPwxveRruuF
 TYgh7Kfzjenn8Tr0gkRU7Udp9ANBAqF55TH2RJhDZ8HUREXfsPmQPAO17Ovpnt6tKf8o
 f41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F3b6cVaxHro/6V3bv0YUWDcSAvk6/AJQY4c2EzGHEcc=;
 b=A31hQ8v8zMEdZlJaq2EifgaKJ5N6dloHiiLMMvqoTNuZuaqPFQJyUaVIs7JNZR0utB
 qInm9xrbjjZJSDXFg9O7Y7URLsQf7wZ97Uijy1Ceq1r4yELK1+7tWTy4MzSGRLuapePG
 obcKR4p7mxvZ2rkwtGNtUvnvqI06G5FZfHcXGNIxoFfVej7XPPGOvA92gnukzSPyURNv
 KtE8Qc4YFLAYegLjIGw3qJKn2KtzefdmknFLU0/Pl8KMl2WxNFQYQT6Hbrvg7YQp0BMV
 fQmmZyd/Xj8wet36p/vZjqkJloVUek07Kg0CaN+jw2HbU1Q/cmLGu7l5HWzboF6ocT+N
 Hvjg==
X-Gm-Message-State: APjAAAX/L462JaQFzSPnZ9m8evebY/broTU+vDm1/7RXV0uJbtCdVvV6
 XC0APb7ZbV6IcGTxhxD1UDtF1YlG7Y4=
X-Google-Smtp-Source: APXvYqxnQ/41tNukIBuhl6RE8LC3928U8WCO1I+pLDbfQnyQ/th7gVadqwQhQny+ZvCyiXVnETjgnQ==
X-Received: by 2002:a17:902:34d:: with SMTP id
 71mr1837796pld.316.1580342220648; 
 Wed, 29 Jan 2020 15:57:00 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:57:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 35/41] target/arm: Update get_a64_user_mem_index for VHE
Date: Wed, 29 Jan 2020 15:56:08 -0800
Message-Id: <20200129235614.29829-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
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
index cc027a2eb2..fe3326aa26 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3207,10 +3207,10 @@ typedef ARMCPU ArchCPU;
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
@@ -3276,6 +3276,7 @@ FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
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
index 6f11b821f7..a2eb01f97c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12030,6 +12030,28 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
index 9cac6c9232..ee907c4e99 100644
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


