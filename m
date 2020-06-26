Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7E5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2E620709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIb9kVzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2E620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofHD-0004KW-HS
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof60-0008JQ-Ox
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:08 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:41116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5z-0001qb-09
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:08 -0400
Received: by mail-pg1-x52c.google.com with SMTP id g67so3463352pgc.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2NZq7MwSZVbDTTVTgGqliRVuFgoYZu09YHrFiII9iDw=;
 b=RIb9kVzwYaarnoG6gExGMCaFZKMkcfeueM1HUKvdnlUI05Xyn97uZITOyyGBOlybRd
 VUtVeFdM2QMm+q3P3BMaUTgzAtyAS7fmS80KaZSk1wzTv5GgSdiv6fiHYxZuhssSDu0I
 AFFAfvJ/uCjRS6olsmcPpxW3rnFxpdeMm/+qJyWy/XgUUGQUczLt43OpwBm+cmjGE1+u
 y+eXTrqBuguHnmwj8oIznrHWQcFY6BAMUQcTvFjmIg/JcNCQF6IZ6okZcGqJHAzhwfzy
 IQ880rxwED1IJ4Zs5bKq6aBeZRYsSf41sxLLoyQGCLtP1fpp4nzlendCC6nSpFQfvkj2
 pb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2NZq7MwSZVbDTTVTgGqliRVuFgoYZu09YHrFiII9iDw=;
 b=VYkqZh6FeJTjjMM7S61GJcySQlh24eWm3Gvl3bp8pF64NpbiinLu7upR+OHykG/KDC
 N1Yph9yrkvDQ3L8NWN3ZB71U//Cb8cOi6qsWszqnmdZcVfjyEePQOVZhZN9qJ+VtwhpH
 /RkTgZ6Egu450kZD4/ei7jUC+oMwOqMygB/abW1PN623G+KWDHAsTcNJt8xPkffk8lZi
 kXS17aQNgzFdB9zgKGeONcyR3iE2+cH3wObkWNj1BhbpxzLSLeUMJnRZgBPn3ui45r6N
 HyGZWMtNihUj5bIZCNY3QkK4fWpfqbDB+hXXlDtkUvVYorQGnokiRWayaUJgKJAx1uS7
 N0Gg==
X-Gm-Message-State: AOAM533y+4oBIqkFpPqI77AsBGMFBs66nMJpnn53FXj/iMCrMV5QrqFE
 aqytiJko0Yb4inPlTB+fsKMCyCgWF7E=
X-Google-Smtp-Source: ABdhPJyXsYxdwbFWStKVmmgP0q5uIDWqbb9khesvn9QjB8PRjw0jfsbC3n9DD1n+A1VqMxOJXaix+Q==
X-Received: by 2002:a62:7883:: with SMTP id t125mr559197pfc.229.1593142325213; 
 Thu, 25 Jun 2020 20:32:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 14/46] target/arm: Define arm_cpu_do_unaligned_access for
 user-only
Date: Thu, 25 Jun 2020 20:31:12 -0700
Message-Id: <20200626033144.790098-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Use the same code as system mode, so that we generate the same
exception + syndrome for the unaligned access.

For the moment, if MTE is enabled so that this path is reachable,
this would generate a SIGSEGV in the user-only cpu_loop.  Decoding
the syndrome to produce the proper SIGBUS will be done later.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v8: Raise the normal data exception + syndrome.
---
 target/arm/cpu.c        | 2 +-
 target/arm/tlb_helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e44e18062c..d9b8ec791e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2169,8 +2169,8 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->tlb_fill = arm_cpu_tlb_fill;
     cc->debug_excp_handler = arm_debug_excp_handler;
     cc->debug_check_watchpoint = arm_debug_check_watchpoint;
-#if !defined(CONFIG_USER_ONLY)
     cc->do_unaligned_access = arm_cpu_do_unaligned_access;
+#if !defined(CONFIG_USER_ONLY)
     cc->do_transaction_failed = arm_cpu_do_transaction_failed;
     cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 7388494a55..522a6442a4 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -10,8 +10,6 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 
-#if !defined(CONFIG_USER_ONLY)
-
 static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
                                             unsigned int target_el,
                                             bool same_el, bool ea,
@@ -122,6 +120,8 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
+#if !defined(CONFIG_USER_ONLY)
+
 /*
  * arm_cpu_do_transaction_failed: handle a memory system error response
  * (eg "no device/memory present at address") by raising an external abort
-- 
2.25.1


