Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9765C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D7E206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qzvmb+yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D7E206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3vY-0003Rl-Re
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3no-0004m7-JY
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:56 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nn-0000mc-Ug
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:56 -0400
Received: by mail-pf1-x444.google.com with SMTP id s23so2989729pfh.7
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CDahIOixg8N2JHR7Ek8lGA826Cs5BmS4mXRyzAL5jqQ=;
 b=Qzvmb+yr6V0rS9fXM7NM1NdR+u0oIf5AZbDsKcxKqGQtlvVdnkS9tfGiwMCoyvdY99
 taQ9wK2VfVc1+0Rk8wy0eTrK/oS6pizdvQbgLvTwL0WVP80PL8OlRNKC0aKpUnhaQIEy
 l1cTfvDQNbYGDLvEJfZcF1QdS7F0TwfffRpcBgHyAsY0PNLL5BP+pTJ2riG+3ygitnFq
 0NdYGj5hMpO+ktUHAu4R+on5nL5fxaqlHHSQuI0CNMEHG3kRuPYldQwhpI6HOPFh8jYM
 4fDyq3sD9eLNW/zmHR4pjAbw1ut+j5vVYgDaynY3J12HBNOAM7U2jZGvUq+eQuHgGNkJ
 IdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CDahIOixg8N2JHR7Ek8lGA826Cs5BmS4mXRyzAL5jqQ=;
 b=ZbiTMrnhJTryCbkIdd6udFJwRD1KPi/hIU34/Y8r5Em0IGYm37eJ9dOUBdZJ22R5Ie
 9+smtdjudBQqiJhd5Gu5shgvJ1XnQBcMIjRqjdk6tgtzgbM1bezddauCwXbGf1AuXCPS
 CN/lXhZ2PrPRC2e2lAeDlL/i0PZB8mzX8OpvYXoOAcCegPmgRRyFkhOVFgIZ6rVK8zKM
 iofRQyTrc7km2AeQxvuuxgSWMZuy56HZnDKLW9x+vXc1ZQymEd5H4AUX2cClq/Gx0GFu
 kVx2pxYZSZ82NaW2sKQNxVWzygJQQjAVX2SNYORwrrGuGTUUVYavFOQJi7fjfAhNQvuv
 7giA==
X-Gm-Message-State: AOAM533CmVbplumLdFXSPVGF8IFfpm7Byr3cSvJkNJiAhy8gDq3u9tN4
 Yt6OUXBdo46sjxXy/SmRV4l3m9h3n5E=
X-Google-Smtp-Source: ABdhPJx6IdCj2qX9lo7rozUN//LYEpX56q5biPL0Wjk/budDyzjIV/0Oop+UeQ4N6RSEWJQYlWpHPQ==
X-Received: by 2002:aa7:84cc:: with SMTP id x12mr7437645pfn.235.1591330674397; 
 Thu, 04 Jun 2020 21:17:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/17] target/arm: Add allocation tag storage for user mode
Date: Thu,  4 Jun 2020 21:17:31 -0700
Message-Id: <20200605041733.415188-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

Use the now-saved PAGE_ANON and PAGE_TARGET_2 bits,
and the per-page saved data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 835b6d1ded..0911cebd36 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -76,8 +76,33 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    int tag_size, uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
-    /* Tag storage not implemented.  */
-    return NULL;
+    uint64_t clean_ptr = useronly_clean_ptr(ptr);
+    int flags = page_get_flags(clean_ptr);
+    uint8_t *tags;
+    uintptr_t index;
+
+    if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE : PAGE_READ))) {
+        /* SIGSEGV */
+        arm_cpu_tlb_fill(env_cpu(env), ptr, ptr_size, ptr_access,
+                         ptr_mmu_idx, false, ra);
+        g_assert_not_reached();
+    }
+
+    /* Require both MAP_ANON and PROT_MTE for the page. */
+    if (!(flags & PAGE_ANON) || !(flags & PAGE_TARGET_2)) {
+        return NULL;
+    }
+
+    tags = page_get_target_data(clean_ptr);
+    if (tags == NULL) {
+        size_t alloc_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
+        tags = page_alloc_target_data(clean_ptr, alloc_size);
+        assert(tags != NULL);
+    }
+
+    index = extract32(ptr, LOG2_TAG_GRANULE + 1,
+                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
+    return tags + index;
 #else
     uintptr_t index;
     CPUIOTLBEntry *iotlbentry;
-- 
2.25.1


