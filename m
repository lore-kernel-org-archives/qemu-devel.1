Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51092C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200572082F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPUH2VKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200572082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpD5-0007QZ-DW
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnoju-0004lh-MJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:50 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojr-0005rX-Ax
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:50 -0400
Received: by mail-pl1-x642.google.com with SMTP id k6so9533219pll.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NYe9wQzTvXU1gjsTjXV8P2ixn5lgpDK0SgGpjLrcDR0=;
 b=WPUH2VKLEEYBsG5KUb4kK9nNqBasrgtb3aqkNwu4mkG/WDy+P47OCm0428D3zglfVj
 1GxBCWKjEJTIT6GgTPIkmGzR94Wr6/1pCfneD3OgYGqIB/9TS7EecdSF5DB1dE9X7/oH
 kQhmdJR0km2UqY5o5/9xV0X7mFvaR/NKf9sXEfXHAe/3zhWTHUJXSO4MDW/pxa7lrR4h
 /oEjc1ElT4KYmWCuJgtftbk9B9thA7sqC9IEkn2J7jbZxvX1xNEdGY+tix4whtuPs48w
 +xQsj10ZW+E6h8WRRsYRXWmJfcaApFJypW6MdOdHvMLqdyZqnevvNzzEr5D0o2iEXAdC
 +H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NYe9wQzTvXU1gjsTjXV8P2ixn5lgpDK0SgGpjLrcDR0=;
 b=b6LEth1B8Zhh8uOep2/0ZbbUuaLLpx226TECqLQ6LrIifOpP2CstZMnpBb+0bN7UXa
 2vS9rt/dFIpZ0yy6QgIjgbgv6v20AGuFa/k6nWRhtarndF9Itj39aQTxQKptL4F5Ox30
 hxD7Ptj+4iB1atqY3OVTY+SzRkTO9ecm2BidCotPhVsoTWtF/8f9FNK1HMbcuysNctpX
 U7HgKVa/3tRefg0W0n4AFeA5JQ4aGPtCkmXtTLEcIhvCtB2NpppVz92iOhtBmPXVs42g
 D4wf/aTDtFNJEAF2e6TQJU1lLQt4T/l2ri1dsvF+U/mt4qTCMI1sEOzJ5GLhVyy5//bt
 aBzw==
X-Gm-Message-State: AOAM5330K8yNFTc+pHpPRN3y9iPIIX79onGEq9c6u/tWuZL1SMlFCaRB
 3cVkCHCTOXw+iztg4ODJ/Si+S1EHHKo=
X-Google-Smtp-Source: ABdhPJzQCDrIt4AmHE7pC6RKy87LhqtBo2hrmZ066XPUzMC8GtICCRsusIon2A6benO+BjbUjY68Dw==
X-Received: by 2002:a17:902:7785:: with SMTP id
 o5mr25538572pll.288.1592941064799; 
 Tue, 23 Jun 2020 12:37:44 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 32/45] target/arm: Add arm_tlb_bti_gp
Date: Tue, 23 Jun 2020 12:36:45 -0700
Message-Id: <20200623193658.623279-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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

Introduce an lvalue macro to wrap target_tlb_bit0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 13 +++++++++++++
 target/arm/helper.c        |  2 +-
 target/arm/translate-a64.c |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a5d3b6c9ee..3121836bdc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3393,6 +3393,19 @@ static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
 /* Shared between translate-sve.c and sve_helper.c.  */
 extern const uint64_t pred_esz_masks[4];
 
+/* Helper for the macros below, validating the argument type. */
+static inline MemTxAttrs *typecheck_memtxattrs(MemTxAttrs *x)
+{
+    return x;
+}
+
+/*
+ * Lvalue macros for ARM TLB bits that we must cache in the TCG TLB.
+ * Using these should be a bit more self-documenting than using the
+ * generic target bits directly.
+ */
+#define arm_tlb_bti_gp(x) (typecheck_memtxattrs(x)->target_tlb_bit0)
+
 /*
  * Naming convention for isar_feature functions:
  * Functions which test 32-bit ID registers should have _aa32_ in
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 33f902387b..44a3f9fb48 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11079,7 +11079,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     }
     /* When in aarch64 mode, and BTI is enabled, remember GP in the IOTLB.  */
     if (aarch64 && guarded && cpu_isar_feature(aa64_bti, cpu)) {
-        txattrs->target_tlb_bit0 = true;
+        arm_tlb_bti_gp(txattrs) = true;
     }
 
     if (cacheattrs != NULL) {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7e8263e86f..ec2295393d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14446,7 +14446,7 @@ static bool is_guarded_page(CPUARMState *env, DisasContext *s)
      * table entry even for that case.
      */
     return (tlb_hit(entry->addr_code, addr) &&
-            env_tlb(env)->d[mmu_idx].iotlb[index].attrs.target_tlb_bit0);
+            arm_tlb_bti_gp(&env_tlb(env)->d[mmu_idx].iotlb[index].attrs));
 #endif
 }
 
-- 
2.25.1


