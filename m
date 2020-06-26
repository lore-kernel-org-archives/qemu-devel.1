Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613D6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC87207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUtsWH9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC87207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqI8-0002NP-D3
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4K-0002wH-II
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4I-0006bY-KF
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id j18so9159129wmi.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4niuaNLMyHoiI7IBJkW4eFNXSPAaql3UxQ8+CmFrSD4=;
 b=FUtsWH9XeaIaSpYAIGbzeeIhRVzgFR2S5orqMEBXz73Qr3Y4haB+LxAhT/It29SO2i
 HSXZAu3ZGkYQwpD71P6eR41ap+2zGQZrOePSMjo+u1xyoH2rHp4eCkdrvgIohaGB+/kq
 Fys6WZGARiYFfE205/r4lQk1vJoLAI/P8oWqi+cVeK73FZ7Gqwx7eabtKrz3KxfyCEt5
 /ec/56UCj4/twsiyasEEl9+koNrXEkzW7GPSR6lKtx5MblM9I4ODLymSaf7aOhtkdzG9
 3HxoVQyupCY7vjyQpWGrdop01PblJYUEaykobO+M7YK3ERjfUVKCGZKKeUpTIbqnH8gt
 jobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4niuaNLMyHoiI7IBJkW4eFNXSPAaql3UxQ8+CmFrSD4=;
 b=lMQJZhIGNYFK+Zi389LWlA2vWk1RQ6zLGVYaVLSsHtyIVIYiSbUhMDKBLymmDeo72V
 0tDc+Xax261NUABpsa8nOTml52+lkb6eXc7gRueZJxd26S8INlOoRYtY/KRCOoMEi8ip
 FqOkf//SWQjY73f8+wearGE5PVPS6i4K13IHl8+b0frkPqa+MXgpFibajhsoCfKT2OBg
 XYMGIr3INmEFmMAsnkyVoZk9ah+IUIwx8fpfxBkMW+3uJ+QcLwju+4PUYTAKdrmYjd51
 7FffGXa7/UWHWFf2LiGS9kEksq7Fwy+n4VhrFT91rS/RqAXnarhS+j7lwWIhW2O96lPe
 syDQ==
X-Gm-Message-State: AOAM530aEkHV13LSYmcpuHHbC7EzIRk5Xdo4iV3N/ijuxcJEvznrpIg/
 5137a61LrVbSuaiy+vnMSRj2edxsVjY//g==
X-Google-Smtp-Source: ABdhPJx5lJbau7IuhvNtK81XTa0QDkb8Wg7yzYv/QoSugT5Pt5xVKmrORLfMS3vLSQfDkPXAt7rEkg==
X-Received: by 2002:a05:600c:2202:: with SMTP id
 z2mr4157128wml.13.1593184505008; 
 Fri, 26 Jun 2020 08:15:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/57] target/arm: Move regime_el to internals.h
Date: Fri, 26 Jun 2020 16:14:00 +0100
Message-Id: <20200626151424.30117-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We will shortly need this in mte_helper.c as well.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/helper.c    | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5c69d4e5a56..c36fcb151b7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -913,6 +913,42 @@ static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+/* Return the exception level which controls this address translation regime */
+static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
+    case ARMMMUIdx_Stage2:
+    case ARMMMUIdx_E2:
+        return 2;
+    case ARMMMUIdx_SE3:
+        return 3;
+    case ARMMMUIdx_SE10_0:
+        return arm_el_is_aa64(env, 3) ? 1 : 3;
+    case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
+    case ARMMMUIdx_MPrivNegPri:
+    case ARMMMUIdx_MUserNegPri:
+    case ARMMMUIdx_MPriv:
+    case ARMMMUIdx_MUser:
+    case ARMMMUIdx_MSPrivNegPri:
+    case ARMMMUIdx_MSUserNegPri:
+    case ARMMMUIdx_MSPriv:
+    case ARMMMUIdx_MSUser:
+        return 1;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Return the FSR value for a debug exception (watchpoint, hardware
  * breakpoint or BKPT insn) targeting the specified exception level.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d8c31d03dad..d14313de664 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9793,42 +9793,6 @@ void arm_cpu_do_interrupt(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-/* Return the exception level which controls this address translation regime */
-static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_E20_0:
-    case ARMMMUIdx_E20_2:
-    case ARMMMUIdx_E20_2_PAN:
-    case ARMMMUIdx_Stage2:
-    case ARMMMUIdx_E2:
-        return 2;
-    case ARMMMUIdx_SE3:
-        return 3;
-    case ARMMMUIdx_SE10_0:
-        return arm_el_is_aa64(env, 3) ? 1 : 3;
-    case ARMMMUIdx_SE10_1:
-    case ARMMMUIdx_SE10_1_PAN:
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_Stage1_E1_PAN:
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_MPrivNegPri:
-    case ARMMMUIdx_MUserNegPri:
-    case ARMMMUIdx_MPriv:
-    case ARMMMUIdx_MUser:
-    case ARMMMUIdx_MSPrivNegPri:
-    case ARMMMUIdx_MSUserNegPri:
-    case ARMMMUIdx_MSPriv:
-    case ARMMMUIdx_MSUser:
-        return 1;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 uint64_t arm_sctlr(CPUARMState *env, int el)
 {
     /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
-- 
2.20.1


