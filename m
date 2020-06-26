Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FF7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B612206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrCwEwPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B612206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofK0-0001gK-S3
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6B-0000Gw-3P
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:19 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:50738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof69-0001vH-Fm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:18 -0400
Received: by mail-pj1-x102e.google.com with SMTP id k71so912490pje.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2lKr79btPsGcUrr83LCqC7k88F7L5S0PZjZ4KnKs9Y0=;
 b=FrCwEwPmwwG+/wZygVrz3LX7DebcHjLkrigO1ZKPk0mxTcVfJErG5KfPL32MDIyhKU
 uIm2kdN3Olbe0zUkoudsr4aZw6oCqHFis7TXHgsxeOsn1IP2J8cusrJFdmWZzbDll0ms
 qxRYDBQZJG1AC6/QGIdniaGqd+lsDMubpLEJeuV2mn81e0Wz4+GbUsoU4j1UR4H0EV7U
 C17eVJFoNU8k71vETS0P4k6xepwzOvW76W34S657V+8gCtmTS/sfkJxHF8TPvNJrPQD1
 FEXEEgR4AAtb+ZwCBacRqNPS0ZD8jvyxNyawba+rxdXqjieOMcgFWFtMV2duxO0w2g8F
 Uw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2lKr79btPsGcUrr83LCqC7k88F7L5S0PZjZ4KnKs9Y0=;
 b=DLmNXLwB3iBHTgXmn98U3UOp0km9x3Ct9jdlXk83P71nC6YYUeUP8n8T/fAzCGTdwb
 gjqDJXhJ4sFdTNOV7IaUEEg89bTO0FuxAYjyWgttga0mXqUaGMca6jd9FjgdHq/3mHj2
 oBSuQsvfIW89sxQmVg5paKXtbzmFMGeWMsa3LnKsh/l6+D1HhcIAXLvclj2Ac9amPlrb
 mNJP+XqWzjGpV5mReQje9816iELHZmqm/F5t56EmT2UzGk/PLPtjL7W0P3g3TTnsQ4Oi
 YlhvNeng4M3LFwHfhbgCkYK8ReOSIcxkKFChrvtC3EAosE3S4//G0+R+pOo4RnyPnW3y
 F1dw==
X-Gm-Message-State: AOAM5325vhqPT7s2QpipZVn8+OsTxhTzmoTUjUK8T0luZ8UKeAdP/dgL
 OHfgViR/bZEF3fVO6SNAmj1djQT1h4M=
X-Google-Smtp-Source: ABdhPJzx5FxvNpx7intqydcIKohXQubMK7nfedOnYmSKfpGAfMZU2FP4vDkmKl32YDkjIk6ZoZSa7A==
X-Received: by 2002:a17:90b:30c4:: with SMTP id
 hi4mr1141249pjb.166.1593142335724; 
 Thu, 25 Jun 2020 20:32:15 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 22/46] target/arm: Move regime_tcr to internals.h
Date: Thu, 25 Jun 2020 20:31:20 -0700
Message-Id: <20200626033144.790098-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will shortly need this in mte_helper.c as well.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 9 +++++++++
 target/arm/helper.c    | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c36fcb151b..7c9abbabc9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -949,6 +949,15 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+/* Return the TCR controlling this translation regime */
+static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    if (mmu_idx == ARMMMUIdx_Stage2) {
+        return &env->cp15.vtcr_el2;
+    }
+    return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
+}
+
 /* Return the FSR value for a debug exception (watchpoint, hardware
  * breakpoint or BKPT insn) targeting the specified exception level.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d14313de66..33f902387b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9875,15 +9875,6 @@ static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
 
 #endif /* !CONFIG_USER_ONLY */
 
-/* Return the TCR controlling this translation regime */
-static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
-{
-    if (mmu_idx == ARMMMUIdx_Stage2) {
-        return &env->cp15.vtcr_el2;
-    }
-    return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
-}
-
 /* Convert a possible stage1+2 MMU index into the appropriate
  * stage 1 MMU index
  */
-- 
2.25.1


