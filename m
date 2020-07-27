Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D742C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE36A2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uL8MCJQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE36A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04xA-0005ae-1v
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uh-0001o5-M8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:34067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uf-0001NP-T8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id g10so13606087wmc.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Df26pyr1FoUci06b9bgZLyVGVD2YeeZNhUfL4mWRueY=;
 b=uL8MCJQlncq3jVP207n1hpGBN56b9iLP6py9pa1w75Ls1qKB1pJeUKfe243G3y+wjU
 RoODpdIT7pRaPSBz1lBLQwFmTJqjvqEZu3JZfloyGnCPuAYS5VbFgD0mvLeI8fYU4NVK
 /R6DByaYkt18gl/JMzms/M/YOc98hlJDr8JxklxfcQhxjk1ovkQhMTwEchCwJz77EKkE
 SIKp72GrCuZacC2vi/gGWLdKFO95UdDn+w1Bdy2WFajKhM2U/GDRlZFeufTyv+xz4sOu
 CJZOOuhmZIwZ4cPog3qZzNidSBgReATUPWqVqrFrqzqqsMMngktOBQVkLXsEshEQNNzy
 evaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Df26pyr1FoUci06b9bgZLyVGVD2YeeZNhUfL4mWRueY=;
 b=gCo43rTb2/WeYiKHUPCUojDA0+YcsrLdZp/FQlPGBjRZ/X4gEE0/ueL16binQH4sn8
 GJDHtCu5vukNx0yboH5gcEhKspj1fHNJIAtBXZTLhQBj6TqWf1cEqHxY9rZp83Jxjx5b
 I2fzzTkkytJb7nWLlIEMiD3EOsJSZKgUBOBTvZKGoOsi6MvtV4t5HPnLpNdfmKPgJiUV
 evkiOIACKrxbi33EisQdA+SDeM7JheeaFXEQ/heApZEz2ObIG7Nk+VioJ/dQUkbYr/WL
 gR9Q290Os3yLG0oO4kYnHN8l37LdtSm4e2Gtp3kOJQ2KaiBZaEOUWCQdSTkJATfKZCIg
 caiw==
X-Gm-Message-State: AOAM531wDlBNm10QbNnGO/m2SoOJg6Dku/+A7YToZKu6Tpd4WIgJ1VMO
 xZXDL+KFOsgNx61l1juD0aIlqYVsWcfwBA==
X-Google-Smtp-Source: ABdhPJxHk89Hl257Ymn12N4VBpYOUxyBIKG0pVwVy2GnXlL08sIiU/1AVE6Ntwvn17ddASWQmiD4lA==
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr8175969wmc.138.1595863173102; 
 Mon, 27 Jul 2020 08:19:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h199sm18744996wme.42.2020.07.27.08.19.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 08:19:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] target/arm: Improve IMPDEF algorithm for IRG
Date: Mon, 27 Jul 2020 16:19:20 +0100
Message-Id: <20200727151920.19150-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727151920.19150-1-peter.maydell@linaro.org>
References: <20200727151920.19150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When GCR_EL1.RRND==1, the choosing of the random value is IMPDEF,
and the kernel is not expected to have set RGSR_EL1.  Force a
non-zero value into SEED, so that we do not continually return
the same tag.

Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200724163853.504655-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/mte_helper.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 5ea57d487a4..104752041f7 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -24,6 +24,8 @@
 #include "exec/ram_addr.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "qapi/error.h"
+#include "qemu/guest-random.h"
 
 
 static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
@@ -211,16 +213,37 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
 
 uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
 {
-    int rtag;
-
-    /*
-     * Our IMPDEF choice for GCR_EL1.RRND==1 is to behave as if
-     * GCR_EL1.RRND==0, always producing deterministic results.
-     */
     uint16_t exclude = extract32(rm | env->cp15.gcr_el1, 0, 16);
+    int rrnd = extract32(env->cp15.gcr_el1, 16, 1);
     int start = extract32(env->cp15.rgsr_el1, 0, 4);
     int seed = extract32(env->cp15.rgsr_el1, 8, 16);
-    int offset, i;
+    int offset, i, rtag;
+
+    /*
+     * Our IMPDEF choice for GCR_EL1.RRND==1 is to continue to use the
+     * deterministic algorithm.  Except that with RRND==1 the kernel is
+     * not required to have set RGSR_EL1.SEED != 0, which is required for
+     * the deterministic algorithm to function.  So we force a non-zero
+     * SEED for that case.
+     */
+    if (unlikely(seed == 0) && rrnd) {
+        do {
+            Error *err = NULL;
+            uint16_t two;
+
+            if (qemu_guest_getrandom(&two, sizeof(two), &err) < 0) {
+                /*
+                 * Failed, for unknown reasons in the crypto subsystem.
+                 * Best we can do is log the reason and use a constant seed.
+                 */
+                qemu_log_mask(LOG_UNIMP, "IRG: Crypto failure: %s\n",
+                              error_get_pretty(err));
+                error_free(err);
+                two = 1;
+            }
+            seed = two;
+        } while (seed == 0);
+    }
 
     /* RandomTag */
     for (i = offset = 0; i < 4; ++i) {
-- 
2.20.1


