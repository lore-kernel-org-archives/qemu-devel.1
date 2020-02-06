Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363F9C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01035206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHSqrCV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01035206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36145 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf3j-0008H5-4u
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoh-0003V1-Vw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoe-00006x-4K
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:27 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoc-0008O7-9I
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:22 -0500
Received: by mail-wr1-x442.google.com with SMTP id t3so6561434wru.7
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ML0maXrBLSH8KbtOifEerP5KZIwDTYucOdmrOd436wc=;
 b=bHSqrCV4OxtGTTFa4W/iAgpdrrRyDFGJAKvcWXAch0W4ns5zzE+SUV8z0KbBpdo26j
 MkrtlO55SGdfRweFNI9RnmVNuF1ZEEHOHNlNDb7h+DlxjV0LsV6Wv7qGqcYN9jAJ88iL
 zHa08A60jROtYQyJIvQ9RbMLNqUzyfK1sV1JJGSM58+Kr/OrXVEUwbXlV1aSJ8GdWpy/
 MqJc7MXxpBfZJqLxvOxDiVpro+QfSvjVLIwAANsv6+mlpsyioY8uFxlIBvVK+zGFiAOr
 goJQMbtkqbzwGWCAP+yrn33hnCASRGTlRf+RJ03gUSbiihYlOiTHf1AKybnn+f8ltYa+
 69gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ML0maXrBLSH8KbtOifEerP5KZIwDTYucOdmrOd436wc=;
 b=frqipp/5+zN5rW1kMJL1JbPR1e3Zbr1KqmqphvC403e1jr7OFopGhJOColqSS02tjd
 MsAvtCGCmq4q+D2KchtpbnlfCuXu8De1stBo1zuOnftP7CKCHmbHoOLtQGCOzPSit3sd
 h7XmYWDneEspEqhAPh+PJaQaD6KebwFNpTdDxiYFAob8inP3MlSIw6bS/k4YpbNcwYah
 g0jKJHsVrxVVBoL5dsk+v/cu5P4NgL6GqAs2VT/8fSM9YbqiMVjYryCiaDkMQiZ4XzOD
 4F+yTFiw1VRC58xSo7ydUV7FRpbdoovB1BUIVQT3TTixHrFgZzXUblCKg7ZwHUBhSmS7
 nn3g==
X-Gm-Message-State: APjAAAWF6QJNug1lrLDaSWF6PQCxGUnewfcnptdY7NRt/AFi1SIHL2hs
 8xL/uYTcR1L25co2n5vNcOSJkNOfvPqY0Q==
X-Google-Smtp-Source: APXvYqwLqhgOdHCbziIBtGO+KdhlsQ6aHqaU1xz6Hgjo4UWne5ilnAEu2Sp/5khqap202ST8FdnNlg==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr3118881wrh.49.1580986519986;
 Thu, 06 Feb 2020 02:55:19 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 35/41] target/arm: Update get_a64_user_mem_index for VHE
Date: Thu,  6 Feb 2020 10:54:42 +0000
Message-Id: <20200206105448.4726-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The EL2&0 translation regime is affected by Load Register (unpriv).

The code structure used here will facilitate later changes in this
area for implementing UAO and NV.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
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
index 9627b4aab1..ff2d957b7c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12011,6 +12011,28 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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


