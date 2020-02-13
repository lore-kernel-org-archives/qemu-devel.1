Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95D2C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954152073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EG5xJ7LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954152073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fmd-0002dE-Kp
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgw-0004LP-N7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgs-0001oK-KS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:08 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgo-0001eN-Ue
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:06 -0500
Received: by mail-wr1-x432.google.com with SMTP id y11so6975307wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MuoGNQ1y1csIjVqqiEVAeH53kp1R5V2ytgxq6qNEfRw=;
 b=EG5xJ7LBOxGtm66SVjhh7FUJ7mY6XDSOHwAGMwbn3/NwfEwB+35k28W48VOuLMpHpE
 6fOo16IaYtxOw9p+e9lZxh9uVTJuKbRlrAORwKNXfaFHlTERgVcnOfvbP79adStfOYfb
 gQVKIwwEisA+h40/GBwpi980MbcNAv+oyNmf00mkmcTNsBbrV53sO53i0aWsbUcsPI1W
 aPNMF341VFYfhKoCL11QMswyKadS/Nm7zpxnsg3/DBlrGvaJ88lQ6Yv+9SPYX/gaL6FC
 z40bSUDJGpQFgAJ4ajjRzcVMYLOGfB9XrMt4h5+LrPPKOYZc/EzwXTF5cB2vLTZ/ELCx
 U4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MuoGNQ1y1csIjVqqiEVAeH53kp1R5V2ytgxq6qNEfRw=;
 b=P7BWsIXyvVIld2oCjySLIXIpzMbzvDHFmCYtvsk37QA/aVWjVFzTKoNEGgQVrPNdKX
 e2OfwWkQ8ysNh2/PDDG5EnRgJiQzxPnoYlU1KmiDte5C8tx/5lcOqiPxWjT77Ev0VfZJ
 Cc3ICC233PVITv8Ou0BQQ17Lotc5RcSta2yGtViF09F8FrX9OMzX6sW5nN2GOK58zTYY
 cyv6SRSBOpAb40BhXDF0+3YDAY9puYsCL66sfI/MpPRiadqQSb1qDn9xf8uAILbchHWM
 P0ojGm40ITxL8cCn7HuUaxJKVMOPyQ7yesgU6PmRhIyk96uxekHoU+vhjndGSHGoXbQm
 DAmA==
X-Gm-Message-State: APjAAAVJ1iHIbfXS3kuOi/JGz2SixMCyH9jUHnhYqMeFZKM1EiZvowoI
 6P3utyAAX8TaWCNi+WyMdXEnpwGO7ug=
X-Google-Smtp-Source: APXvYqy1k/T9rHoYidRjjHpCE2Qu20MAXkTnM99YSSDd9N/9j2v6Yprh9ABEG/BCNNIF71MNbmiapQ==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr23005679wro.360.1581604920726; 
 Thu, 13 Feb 2020 06:42:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/46] target/arm: Add arm_mmu_idx_is_stage1_of_2
Date: Thu, 13 Feb 2020 14:41:09 +0000
Message-Id: <20200213144145.818-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

From: Richard Henderson <richard.henderson@linaro.org>

Use a common predicate for querying stage1-ness.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 18 ++++++++++++++++++
 target/arm/helper.c    |  8 +++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6d4a942bde4..1f8ee5f573e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1034,6 +1034,24 @@ static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
 #endif
 
+/**
+ * arm_mmu_idx_is_stage1_of_2:
+ * @mmu_idx: The ARMMMUIdx to test
+ *
+ * Return true if @mmu_idx is a NOTLB mmu_idx that is the
+ * first stage of a two stage regime.
+ */
+static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
+        return true;
+    default:
+        return false;
+    }
+}
+
 /*
  * Parameters of a given virtual address, as extracted from the
  * translation control register (TCR) for a given regime.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7d15d5c933c..57dc7a307c0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3261,8 +3261,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         bool take_exc = false;
 
         if (fi.s1ptw && current_el == 1 && !arm_is_secure(env)
-            && (mmu_idx == ARMMMUIdx_Stage1_E1 ||
-                mmu_idx == ARMMMUIdx_Stage1_E0)) {
+            && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
             /*
              * Synchronous stage 2 fault on an access made as part of the
              * translation table walk for AT S1E0* or AT S1E1* insn
@@ -9285,8 +9284,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
-    if ((env->cp15.hcr_el2 & HCR_DC) &&
-        (mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1)) {
+    if ((env->cp15.hcr_el2 & HCR_DC) && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
         return true;
     }
@@ -9595,7 +9593,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                hwaddr addr, MemTxAttrs txattrs,
                                ARMMMUFaultInfo *fi)
 {
-    if ((mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1) &&
+    if (arm_mmu_idx_is_stage1_of_2(mmu_idx) &&
         !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
         target_ulong s2size;
         hwaddr s2pa;
-- 
2.20.1


