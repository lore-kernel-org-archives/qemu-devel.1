Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82634C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9DD206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoOqi4Za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9DD206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyNk-0003LX-GW
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxM-0003Qr-Em
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxK-0000Dc-5N
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:28 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxJ-0000Am-OT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:25 -0500
Received: by mail-pf1-x444.google.com with SMTP id l22so974617pff.9
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qXyjILkTo9G8IoURRqIlskTheKQH1snr+t1caGFMi3I=;
 b=hoOqi4ZaAjuWQP2rbKe+71R8dgSWBpktQM3yYMO818Wb78GuUmpKygWnh/eoiO6WH2
 CfYBqXVuVzWBfe8w8N8RM6b1oYnYPa8SPwqBuD9puwcMX4z40doILpIkw/CGHBFMhk5P
 dPV0mvLgI4qwPX4/JH9OPEjUUQQzS8wGUq8LiCNMszHPGMiIygNTWrMda7pou/5HVOY6
 5CObsZWZcXyaf7osWlivP/jWL1SWVjKZQu+1DnMoK4tWyplTG/KOFGsB1FJMRchnzMNL
 +rsRS+NdmyOGNuh/nJ5icFfEkle2iH/AsJ58CrKIH0sW/eHH/DyWdok8CMI2MQNVUqzg
 BhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qXyjILkTo9G8IoURRqIlskTheKQH1snr+t1caGFMi3I=;
 b=iCwBaHCZ9hAoa2fxM4POKktNxzABjh8hh14fokRmyULRc6vjDkDIdBNy2sib2ZD9ZV
 Gtjwoasssadhl2zM/kVRRKW3lLVKnAEFWzycdrOP7ZVQ/lXNZ0vJBLN81mQrWYmkiRoy
 cV3xJjD/k0+NDauVCHdApaq9MGR5SUUTRzQlHC/b1LA9aszCpnhm5ZQIqUpKLtAOf1lp
 1xbD4mG0K6AFMz4iFjE1ndv9zouxyQvk9f2yMO98M+vksWeupwhnCxc58Qp8Vua+yIWg
 oTrcG4X23MI8+lh8sgvQC4fQwO5UBgVuaTzlkhzd4qvArC/i9R22IsgvYUGggzIDGncb
 mdvA==
X-Gm-Message-State: APjAAAV/P224ZkFep7u2SoFS9hXq3wprWaGppCiCD7u0CIalOd0S8tZi
 Ir1WzeoXZCSBWLVeVOqpdWXvviGk+Ro=
X-Google-Smtp-Source: APXvYqwok99+pBXVmYe+kGXg18FuZ5pfHNjcwsv33NcMlgKxdkIVeq83qmjf3OUtr7unf/g5RJfnww==
X-Received: by 2002:aa7:8155:: with SMTP id d21mr2267926pfn.26.1575340222938; 
 Mon, 02 Dec 2019 18:30:22 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 34/40] target/arm: Update get_a64_user_mem_index for VHE
Date: Mon,  2 Dec 2019 18:29:31 -0800
Message-Id: <20191203022937.1474-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  1 +
 target/arm/translate.h     |  2 ++
 target/arm/helper.c        | 22 +++++++++++++++++++
 target/arm/translate-a64.c | 44 ++++++++++++++++++++++++--------------
 4 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bb5a72520e..8e5aaaf415 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3239,6 +3239,7 @@ FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 FIELD(TBFLAG_A64, BT, 9, 1)
 FIELD(TBFLAG_A64, BTYPE, 10, 2)         /* Not cached. */
 FIELD(TBFLAG_A64, TBID, 12, 2)
+FIELD(TBFLAG_A64, UNPRIV, 14, 1)
 
 static inline bool bswap_code(bool sctlr_b)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 3760159661..d31d9ad858 100644
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
index 3e025eb22e..f2d18bd51a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11879,6 +11879,28 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    /* Compute the condition for using AccType_UNPRIV for LDTR et al. */
+    /* TODO: ARMv8.2-UAO */
+    switch (mmu_idx) {
+    case ARMMMUIdx_EL10_1:
+    case ARMMMUIdx_SE1:
+        /* TODO: ARMv8.3-NV */
+        flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
+        break;
+    case ARMMMUIdx_EL20_2:
+        /* TODO: ARMv8.4-SecEL2 */
+        /*
+         * Note that EL20_2 is gated by HCR_EL2.E2H == 1, but EL20_0 is
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
index d0b65c49e2..fe492bea90 100644
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
-    case ARMMMUIdx_EL10_1:
-        useridx = ARMMMUIdx_EL10_0;
-        break;
-    case ARMMMUIdx_SE1:
-        useridx = ARMMMUIdx_SE0;
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
+        case ARMMMUIdx_EL10_1:
+            useridx = ARMMMUIdx_EL10_0;
+            break;
+        case ARMMMUIdx_EL20_2:
+            useridx = ARMMMUIdx_EL20_0;
+            break;
+        case ARMMMUIdx_SE1:
+            useridx = ARMMMUIdx_SE0;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
     return arm_to_core_mmu_idx(useridx);
 }
@@ -14169,6 +14180,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pauth_active = FIELD_EX32(tb_flags, TBFLAG_A64, PAUTH_ACTIVE);
     dc->bt = FIELD_EX32(tb_flags, TBFLAG_A64, BT);
     dc->btype = FIELD_EX32(tb_flags, TBFLAG_A64, BTYPE);
+    dc->unpriv = FIELD_EX32(tb_flags, TBFLAG_A64, UNPRIV);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.17.1


