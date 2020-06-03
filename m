Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB384C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AD22072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGfxWPg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AD22072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIBZ-0004Ep-OG
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyZ-0004Ao-1v
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:51 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:45652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyV-0003az-TE
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id y11so187214plt.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AEdNLYFCyfyMqsP9U02w6IsvCKyLZbP9JA6vNA4o+yc=;
 b=PGfxWPg8A1ZHVs+Pwb/SugE/9/Q8U0LxulnXFVjawH4hRZaDumiiZn3ZUdyua63jpg
 n57CX7aHu0LX4mzYqCACULh4KfDwfF7kKGZgiISeaviByx2mjRpvsMUTuUnk0IDV1oF1
 A/Hjays5tdQMQ4ZN8GS8CVbC88fRc84tgaUxHzRlj/mJlKeudMATl3TKQMxe5QX7TDJd
 zIPh55y5e0ttT7MrLE+sJUpvu+J3p3sOlwx0UUKad21fZ68OwOLvq+n61ndyMrDttBSE
 uQPC37xd9nR1ZzBGraq3Nd3CDbYR31hqdOnkgSJdq0ciY/x3MwVxEsjPXMpkcReGIOFu
 c8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AEdNLYFCyfyMqsP9U02w6IsvCKyLZbP9JA6vNA4o+yc=;
 b=CBrIZBl213Yl57zIcRwxRlYFD7JckJceMjQKx8oyjfIpL/zJHm7X9dJAXydkQJYDI4
 3Bxnr5JKL47EuNu919WKh57h/iGjuyXuMP2lltDBwesj1DhzfPFU5MbOzWLIUREYenLe
 dDnqQs7tB73FC/KyQpHCn8b1TGX1QmhL3ebiEYTUdedbpH19tit+nCOjA/QEVm0eaxhA
 UHL4hY9ahpTvBx8nwHwJfy/Zio4SDu56tbe8za4hc4K9Hv4bFUrGtw9O56zOqvnshkl6
 +lxROpW0iJbrWxkdwwASqrcQkzfjPUvvzYLqt2ZlQqvLMb9h/h1nkA4HOe/2Hl1E0L1y
 RuOg==
X-Gm-Message-State: AOAM533MrtBVD038eWkwg+AbzLUiYzeUBFrJj6z9RVCi4lI0foeFCxe8
 hs0QYp1qmXVsTgLMG89VrztdHby+ZMk=
X-Google-Smtp-Source: ABdhPJzR6KTxYmf21JAZWQpHajbPCb+eNDuvApwIabNYvVoYpEhssBUnSt2j/VVpTeRPbVmJVa51vA==
X-Received: by 2002:a17:902:694b:: with SMTP id
 k11mr25067287plt.77.1591146825964; 
 Tue, 02 Jun 2020 18:13:45 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 21/42] target/arm: Move regime_el to internals.h
Date: Tue,  2 Jun 2020 18:12:56 -0700
Message-Id: <20200603011317.473934-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will shortly need this in mte_helper.c as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/helper.c    | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5c69d4e5a5..c36fcb151b 100644
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
index 20d7bf4ee1..bad639e2a7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9791,42 +9791,6 @@ void arm_cpu_do_interrupt(CPUState *cs)
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
2.25.1


