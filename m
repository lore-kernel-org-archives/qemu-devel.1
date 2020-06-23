Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D5AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5899820C09
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjeYyAR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5899820C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnopz-0007m9-Lm
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnoje-0004DK-UW
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:35389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojd-0005kt-60
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:34 -0400
Received: by mail-pl1-x632.google.com with SMTP id k1so9547101pls.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2lKr79btPsGcUrr83LCqC7k88F7L5S0PZjZ4KnKs9Y0=;
 b=TjeYyAR2DEJL84rAE96rILlRyL9UNPVxiEFpirLpOUtfE6NS0mcbNOiqbV3uL7Xizs
 ryfsnT3t4+8TGnyhz7fzNDnel7Wxj+wtXtJFp/hE7wj/JH6u5jeHoRug2xNzWJsUz9YD
 1JbJy05JyXsjzvC4OHkYycen319dclV6SF9P8AqKANoKiu+MuupUGI1gtjf4B91ZrzcN
 t3k/TblrDISZ0GzT/lHs5PFsLUm3syHnjkLtDxtXz9d0u1e6goyr8LJS6vyeVvUtMSlY
 AQHH5zRvoOh6e/EJUZj0RS8S0nCWIO8rx/7mgy8OjlOboVNwPUCUtLA2YElhLWniJj8/
 /tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2lKr79btPsGcUrr83LCqC7k88F7L5S0PZjZ4KnKs9Y0=;
 b=RsTzKAII+BQo1EqAbq4voeS58d1WKasej6zgjXTE70q3pf4bHbch5/LSgk+RBsdEBx
 4ROuEDm7MWCwTqkrjW2FvfbXwfaeEi0SWFQ4Z2Rj8wqpN/4+vWWWpbNVM1TesnmsawXv
 I9dGrpLyo/eby9wooNltuuhEMrVcx+KLBbXdG3YiuA2X5OUanu8g3BFp7hlPbBrT8zxQ
 HLA1RLo/X5n7yxahe8cwbw/ceiU49pqE1d/pT0SRUTDFz1PXbfRF76Nkf16L4Fzp0wZm
 zUXmXOnhLltrcclQFsZfiM/zck7kFm/v6y0CwsxVempT0VYcjJADl4mGSORqPzYybyQt
 fqPw==
X-Gm-Message-State: AOAM531ztRNABsdHpliJZ+hbHQ5aIJOcYTcutqYUI8f6xtxcp5mVWk5Y
 MrL0E6HWgYrqDjdOEZreuFMczFZs1J8=
X-Google-Smtp-Source: ABdhPJxPbsa/TIDatCaSa+V5YsHMGGgFexpw7ayDyUQO4fUX1WUCFRn3sIh+T0MRFt98hqompDDLlg==
X-Received: by 2002:a17:902:ee93:: with SMTP id
 a19mr25801905pld.144.1592941051465; 
 Tue, 23 Jun 2020 12:37:31 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 22/45] target/arm: Move regime_tcr to internals.h
Date: Tue, 23 Jun 2020 12:36:35 -0700
Message-Id: <20200623193658.623279-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


