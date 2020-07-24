Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4B7C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A833206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3G1OrLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A833206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0jj-0002ID-Q8
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz0it-0000c2-BU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:39:03 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz0ir-0001UI-IV
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:39:03 -0400
Received: by mail-pf1-x442.google.com with SMTP id 1so5462319pfn.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GFpd1WzRdKHPdu50aGofJzb2YYZBrwx+q9wbcazemUg=;
 b=O3G1OrLbrwLrIWePvOU2kpOAGF9r2a0c9LcWLH1ACJ0irlTLltKiyua/QusVZovhGV
 O1zWjY+DWvFZDzJs6/5iv9ZZ5w7w2AxL+p2zY2GO5/SDitfCZSDxi1MzJSrSeGadC83x
 ndem/2OVIeUA/QzvGX0RdD/yUGV3ibFyrcNB/4g/ZwMg5TSZMYPMJnvHRPG5Raj75V2f
 b0CEFhQfVZqfC6MB1QZIU4Qf5nIfPrYxdnmJXFF5bWa6r4vn2aNfi2e/TDiTSomp7xi1
 kZHR9GGwYH6UX7JmZ6rmb3AzsCv3PLWsbGPv9tyYZ6Ux6dqnLrSiRa49C+sv1PP+ZXdL
 6X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GFpd1WzRdKHPdu50aGofJzb2YYZBrwx+q9wbcazemUg=;
 b=GcjsGDtNygYLvEGVYR8Gcoqg6ftTvlulN23BRHLeJIEpPBPl/5z8VB9Y4E+VAadzaU
 2CP+bd+s6DuC4L5M1nbaKSG71VCgj+3CWp+v0nw4LPLgmzkgvQy7SgPUx8W70ydNUtKE
 C/zdsXzjydL9BN+tbYDEGPAxogNgsTvPy608vyVdKuKF4KqanK3KuSquSnaMeQLxBQAu
 +3lXmpruY30cirkPz2BZiLiCMiQS9ZYnwad1jfwH33FCycvVbUT39VFBXHPMxg6sPXAa
 6RtfCmFVz/VHmdP8Xs8LQJ4cinfujTbU5s4cIa8p+Ekz5hcCqr49//8vLFHsWnvx5eVx
 f19g==
X-Gm-Message-State: AOAM532meWS7oB6LwK2DbM9s1zGQRZD4ecWAZXjEw5364gTf3hgZmVSe
 c8M859Eo+HTr9tHSF3nSrzKYs9YBMoc=
X-Google-Smtp-Source: ABdhPJxA+PvF2ZfbD0Upm1HIXxpoyILYwd6GnvCqIwXbYOikU+NdgWCFPHhgMrOdjiWlYsb7/3umIw==
X-Received: by 2002:a65:620f:: with SMTP id d15mr9034163pgv.270.1595608739240; 
 Fri, 24 Jul 2020 09:38:59 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id r191sm7261663pfr.181.2020.07.24.09.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 09:38:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/arm: Improve IMPDEF algorithm for IRG
Date: Fri, 24 Jul 2020 09:38:53 -0700
Message-Id: <20200724163853.504655-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724163853.504655-1-richard.henderson@linaro.org>
References: <20200724163853.504655-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org, vincenzo.frascino@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When GCR_EL1.RRND==1, the choosing of the random value is IMPDEF,
and the kernel is not expected to have set RGSR_EL1.  Force a
non-zero value into SEED, so that we do not continually return
the same tag.

Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 5ea57d487a..104752041f 100644
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
2.25.1


