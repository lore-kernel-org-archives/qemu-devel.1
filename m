Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDCEC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9CD207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mDb35vGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9CD207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uQk-0005A3-EX
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uPq-0003ps-1o
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:19:54 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uPo-00018E-Ix
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:19:53 -0400
Received: by mail-pg1-x542.google.com with SMTP id o5so1392667pgb.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gkaf80e+VCqbV0BxEoX+BcAOlQwRYSyZFcs+VT/z7+o=;
 b=mDb35vGim9EgH3JJb/PyRIlq5ub8+kRd1Ba0zOmajcbNBeNz3KB1gUWxikbLT7OryE
 fuX4bWy5zKdUZAUM1TCSHJBi2+EAC+LMTHLHv9oqTf0M+szq6dU/o5CpZWMvQgy8RNJz
 TBzctLq6pZ413C4UYfWy6uSMM14uHOxuvKOJKTvUGmwJPoNYHu7KtuDeVZFLmsVWXH7N
 RDiUVH/vIq7tU/XKK1auJ0oPAwsA8LLEp8QzJl4RDNZFhTxpGihhQkSdAemfFkhGACrk
 vPV9xlkJkbD1yN6vQ5afLK9Cg0lz+QFvDQUNMsWbHBZacSp7oKEiyGNYcx3mDbCCep9O
 OELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gkaf80e+VCqbV0BxEoX+BcAOlQwRYSyZFcs+VT/z7+o=;
 b=TbgwgEIB/9e7By8/fw07PkYfyrMeQCtcIyp2OhEAqRUrV51HJFxp6eVrtC7Bjtt39Z
 gCOEoG+q65561uVw1w39mO3lHUpXj72/yFGCNq8s1OSn0py9g+DNv6ubHIxN2K1hwiAs
 9h8MY9QOelCOzs+X05SfCBPht/dTM1jZmYjBUS7ldNIRZrZ/mn71pSs3EiJzpqDZRoMx
 AfzcubZ5+zo6/l8gIESfjfCjSnFOKMaxFNcF6ui/1G+ngVsofk5f2ZMvrm6/QOIoh+I1
 cdsTbTzz/juIjwohom0HuHfyibIdo3vS1K2pEFJbz+jZr4gKMc8NzMeHHHh4gJsm71AF
 oLow==
X-Gm-Message-State: AOAM53149iv6w4JZdHEQ+9JGeGqjrhCH++DG3Ra3XqQSK0fJPJS+dcP8
 9ujEL+Raj7EUWwgLXHMcu2/h5hKAQDc=
X-Google-Smtp-Source: ABdhPJwIlLn1MeGlZiok90nU9kHBKS9tPRG7llizWcQBujC64VpAi20HMuZNxByMaGx6+Y4JBnTzcg==
X-Received: by 2002:a63:5022:: with SMTP id e34mr158542pgb.384.1597252790887; 
 Wed, 12 Aug 2020 10:19:50 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y79sm3097206pfb.65.2020.08.12.10.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 10:19:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/arm: Pass the entire mte descriptor to
 mte_check_fail
Date: Wed, 12 Aug 2020 10:19:45 -0700
Message-Id: <20200812171946.2044791-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812171946.2044791-1-richard.henderson@linaro.org>
References: <20200812171946.2044791-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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

We need more information than just the mmu_idx in order
to create the proper exception syndrome.  Only change the
function signature so far.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 104752041f..a40454588d 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -514,9 +514,10 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
 }
 
 /* Record a tag check failure.  */
-static void mte_check_fail(CPUARMState *env, int mmu_idx,
+static void mte_check_fail(CPUARMState *env, uint32_t desc,
                            uint64_t dirty_ptr, uintptr_t ra)
 {
+    int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     ARMMMUIdx arm_mmu_idx = core_to_aa64_mmu_idx(mmu_idx);
     int el, reg_el, tcf, select;
     uint64_t sctlr;
@@ -639,8 +640,7 @@ uint64_t mte_check1(CPUARMState *env, uint32_t desc,
     }
 
     if (unlikely(!mte_probe1_int(env, desc, ptr, ra, bit55))) {
-        int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
-        mte_check_fail(env, mmu_idx, ptr, ra);
+        mte_check_fail(env, desc, ptr, ra);
     }
 
     return useronly_clean_ptr(ptr);
@@ -810,7 +810,7 @@ uint64_t mte_checkN(CPUARMState *env, uint32_t desc,
 
         fail_ofs = tag_first + n * TAG_GRANULE - ptr;
         fail_ofs = ROUND_UP(fail_ofs, esize);
-        mte_check_fail(env, mmu_idx, ptr + fail_ofs, ra);
+        mte_check_fail(env, desc, ptr + fail_ofs, ra);
     }
 
  done:
@@ -922,7 +922,7 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
  fail:
     /* Locate the first nibble that differs. */
     i = ctz64(mem_tag ^ ptr_tag) >> 4;
-    mte_check_fail(env, mmu_idx, align_ptr + i * TAG_GRANULE, ra);
+    mte_check_fail(env, desc, align_ptr + i * TAG_GRANULE, ra);
 
  done:
     return useronly_clean_ptr(ptr);
-- 
2.25.1


