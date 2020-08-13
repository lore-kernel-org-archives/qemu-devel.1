Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDE5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE74F20675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plIHfCGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE74F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JYM-0004Ym-4j
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 16:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JWR-0002NI-NJ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:08:23 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JWQ-0003dO-3Q
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:08:23 -0400
Received: by mail-pl1-x641.google.com with SMTP id u10so3110004plr.7
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 13:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gkaf80e+VCqbV0BxEoX+BcAOlQwRYSyZFcs+VT/z7+o=;
 b=plIHfCGX62hyS4a3SD1Gkm+v5hXzm1gv01HKXxCHjaZBAI0j2XouGingvd/umKY7Cs
 yHmDPM5+ZdozIoOqcMTLe4h1JH3B09o6RliH9qJ/TkHYKJCNtj7/7xh6VJYQqhoGe5Xt
 hJYEzocYfafx664XbjdRU8Wxs6YCCZPX29U9XNCddW7ZBEplq9zNjw4tYzKyyBmwDhsy
 Yq7R2wLa8vvHKf9YZ9XgUxxfPmzSGiiS3St9nYc+PLG3ZDD37hxIW+y7k5wAhJlJbqTf
 VKL5umQ/CQEuqLATFLQbgJWNy4Zcm7Wmz6H1+QjhJarrXa73xQiEq0NMsDsCRaV5KZdT
 61ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gkaf80e+VCqbV0BxEoX+BcAOlQwRYSyZFcs+VT/z7+o=;
 b=MAfYB69XrUI3dG8H1r2o+P50x9Lae+GjPBtsX+grfH2b0QVdf/pEUkSlwghI4bc7GW
 Wjs/aqEv0BQsXZtf+Nlv/NmRQ08L7r6tNv7QtmJSEQhsX2IRs4e1l9bUQukNIMecnj9Z
 B2p5LTdmdiAFpJtSSFBDiOsJnWnhbe568Nj0EhhkGeIE9p/bbn+o+Vypzg25yAw/lyGf
 eEeAG0Sg1B+QBM0c8KCXWwolAK932Jr69ZEzERFIsTuzcWT5OX6vlTcwF48DCGYLP1yD
 a6HZOOxqlVl2qddkCdeu+vJTRd/c2wouuNBcnN8u4uqpt41lcubZTqpX5V2u9sZkeSth
 HcOQ==
X-Gm-Message-State: AOAM530tekGSEVL2lSW9v44d0DPSA1CiHcgvyxdVsIb/61zxTe0e/yMy
 Mjaopgcbe4kZshczc8WJljD1YR60lEQ=
X-Google-Smtp-Source: ABdhPJyB2FLMgjz2a/6jcpsxynK2bzv+4bPDCGzyTrH97jeueX//dGaHTDEp4oW2a6m/evP4RIBTfA==
X-Received: by 2002:a17:90a:1384:: with SMTP id
 i4mr6960842pja.157.1597349300278; 
 Thu, 13 Aug 2020 13:08:20 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm6811642pfc.202.2020.08.13.13.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 13:08:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] target/arm: Pass the entire mte descriptor to
 mte_check_fail
Date: Thu, 13 Aug 2020 13:08:15 -0700
Message-Id: <20200813200816.3037186-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813200816.3037186-1-richard.henderson@linaro.org>
References: <20200813200816.3037186-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: andreyknvl@google.com, vincenzo.frascino@arm.com, alex.bennee@linaro.org,
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


