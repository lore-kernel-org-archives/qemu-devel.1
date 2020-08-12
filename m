Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5BEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B380F207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUjXCMBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B380F207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uQi-00057Z-Oi
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uPp-0003og-6h
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:19:53 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uPn-000182-Jo
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:19:52 -0400
Received: by mail-pf1-x441.google.com with SMTP id r11so1338019pfl.11
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Vi8D6cToE+83DNLkfNqfMDYxXOTd4xd+RpYBMQnwio=;
 b=LUjXCMBnc3FU5sdaW54XQ44rDWLDksdD10xRyOT+mpzCO+5LTSgsARnJ63kpTV5vXa
 X3kgLvEcnMhgSq8Qg20Aq5S7YBauDtBlhukrqINo76CS/HkNeepcAxUiJ2mQHJhG4lWb
 HzSPUfdbljHyGF3F6SjpMYNTIjFRe2P/GDFZK8mzrCDdb2AB0zBRuQuAXXmxPodE7RDu
 RmzGHQKCkFQzWvEV0er+2qhUc6g8AfIVX+RzFO2/Lbjr/OFIZc/ZGHKQzHnB9dNpf7id
 bwFbDNB1K7ZROWuIY/P+4f/mhvwa3JZeoMB0uJk+LOZXG9zTnZNNO+ISsJdYf559CgSB
 yoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Vi8D6cToE+83DNLkfNqfMDYxXOTd4xd+RpYBMQnwio=;
 b=PIKlYPJzoCmsfxDgFznsY/x0QWBJDFz0yKjK1lpmvyDsPIOFYH+q0ax6PSMl5yTB6s
 /SwkXnXOinZNYglFJCvzN3U3FKNYV0tDC5Tg4xM1EFRQlZCEoIHAbiFJKSvd5l/ZajRu
 tqmmNWYbHU9KK4j905kSk9v7RbkLUG6Dym9AM4xQc7vKT/tEUm5XIBUtF/mGXGQnhgEL
 x34RD85KsYXvUzFf06nez5hlg1Rxz7nOBkbO3Cr7hWdD4CaJwWFGh0gxn+fEBOKnNRtH
 Ru+BNiTl7smUgSVtriWz5kcJDwQF9UfJEwoJLpxgfBGGbVtphSbp21YLbwwIhZYSmos1
 C8tA==
X-Gm-Message-State: AOAM5315brIjrcLbLE3I8WINyKXcey7PH8pZWH0ocVshTMB0qvfXKl1W
 z60cADogNa7pPUqc53VCcDAbg07RxqI=
X-Google-Smtp-Source: ABdhPJxLj5L3XaFypiF5IUk1WgmAREDbIdrnkrA9UjI4UStQcPnrYVJk9m39VwqnjTwAsYjeDM5BgQ==
X-Received: by 2002:a63:5b0f:: with SMTP id p15mr123360pgb.299.1597252789793; 
 Wed, 12 Aug 2020 10:19:49 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y79sm3097206pfb.65.2020.08.12.10.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 10:19:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/arm: Export merge_syn_data_abort from tlb_helper.c
Date: Wed, 12 Aug 2020 10:19:44 -0700
Message-Id: <20200812171946.2044791-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812171946.2044791-1-richard.henderson@linaro.org>
References: <20200812171946.2044791-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: Andrey Konovalov <andreyknvl@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will shortly need this function in mte_helper.c.
It's also a bit too large for inlining, for something
that is on an exceptional path.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h  | 4 ++++
 target/arm/tlb_helper.c | 8 +++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index ae99725d2b..967d1319de 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -500,6 +500,10 @@ static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
            (cv << 24) | (cond << 20) | ti;
 }
 
+uint32_t merge_syn_data_abort(uint32_t template_syn, unsigned int target_el,
+                              bool same_el, bool ea, bool s1ptw,
+                              bool is_write, int fsc);
+
 /* Update a QEMU watchpoint based on the information the guest has set in the
  * DBGWCR<n>_EL1 and DBGWVR<n>_EL1 registers.
  */
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index b35dc8a011..e8cf39f7d9 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -10,11 +10,9 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 
-static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
-                                            unsigned int target_el,
-                                            bool same_el, bool ea,
-                                            bool s1ptw, bool is_write,
-                                            int fsc)
+uint32_t merge_syn_data_abort(uint32_t template_syn, unsigned int target_el,
+                              bool same_el, bool ea, bool s1ptw,
+                              bool is_write, int fsc)
 {
     uint32_t syn;
 
-- 
2.25.1


