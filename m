Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827D520734
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svnfqhtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827D520734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIDB-0007zX-Mu
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyZ-0004DE-Pk
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:51 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:36268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyX-0003bV-7H
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:51 -0400
Received: by mail-pl1-x629.google.com with SMTP id bg4so205322plb.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xQv4B3bb36rbPBYcVwiFiacx7H8VsL7xVtsrr5uJK6w=;
 b=svnfqhttMHOAuUdKTBputqZVA2XoWk84Evd6xO2uOpVuJb39CqHBhz5AGXYlqySWu4
 qnP7DQSRNJA7OLbN32jGJMMXUAYuxGBLyXo8S3sJZI1m29I1uAAuzznQHGj4CrOfJzcJ
 liO22Tw/1WJJhzv3rflsFZaMxSuz2zmGWjcmMdD3Iveq+WywzDAS+m9FblI7CTqtVEIg
 Qt9oelXng+hVcdEntO1RP1VWHxjJ+9ICLYXjAIk0q/IZCSFI38RaOM+5FoxO53pZh1Al
 8cmYKUXldeAXV61oefZN46Ddwf2vmm1d3Oh4sW6ghSft3mBZ1Wygp06lEWyqxKpZZy7+
 9uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xQv4B3bb36rbPBYcVwiFiacx7H8VsL7xVtsrr5uJK6w=;
 b=HmCdsmw/DVXrRQSbTrLt4y5nLsZ/T2gFoqyUvdrLzEfpJccR/4vXXrMerAP9RfPhYH
 937eHzn3ppmGXMGtuAg0qXIYOhYPbquAQPaLaDLmH3N0xAiFeq1HLWzxkY33FapIMej0
 nyJ//zhlf2MnN60xeTVlqR+pB5pX6WtCB8Rs3Qy+fNu+0hWSs7AAJ75PD5LMLAhdz45x
 0iPrERMzzXnA9X2tcnCdNc3RW2DHU5U6SyHyGlbJXK8g2H6XgErUitdT6XXoKsrxYam0
 xKq895HbVVBtwbg26242m/FPGzFA7aF3AFCVyHIrTRdqh0RgwABZRia5TGExjPOVnB/g
 h2Sg==
X-Gm-Message-State: AOAM532HSW+LzZZBcin5U7jwk2prUmlBXLi4sIGkHV0BBX+6jllJ2DB9
 Yh3F5o+SvpqnRgpwbwEve0Koo7kjlW0=
X-Google-Smtp-Source: ABdhPJwBZHbd1vd6VwCsbeX92n2P/hR/VZBCdkskQuLQ9DYiIaRkmYFF+sSySZQitL/wKsOU+ezE/Q==
X-Received: by 2002:a17:902:ee93:: with SMTP id
 a19mr16191657pld.144.1591146827390; 
 Tue, 02 Jun 2020 18:13:47 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 22/42] target/arm: Move regime_tcr to internals.h
Date: Tue,  2 Jun 2020 18:12:57 -0700
Message-Id: <20200603011317.473934-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index bad639e2a7..c56e8e500b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9873,15 +9873,6 @@ static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
 
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


