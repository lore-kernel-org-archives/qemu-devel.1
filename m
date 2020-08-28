Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0670EC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C849F208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHcUfL22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C849F208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBagj-0003tA-Uy
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacU-0003wL-1t
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:40933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacS-0004EL-8Y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id b18so625509wrs.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jp9bb95FmgoCU2/ptjukarM+q7Wux537NT9Ov1W4D4o=;
 b=mHcUfL22yzV8jeBidkNbYPnlduLJ55Fi3mxlissm6nDAGQ8NagsTrnI9vvMyPvIddt
 2nqE4SNWZXdIoRMdqgIliipzW5YGsyxChgFNmCIQqhKrvql+Xpf/gRqc9bofdgpSkexc
 cPL6i4kdxABP8DEvcuRhSH74/UdqS3GidCKViDjgfOwIqiqmkhOqKLbsPGy18eTnHRbc
 K5SHtdJ1TpZtc/jxygKPW3pQKmTm5Intb8pr+J49LgmwxgI1/mYnWLe4NMuNoDqGmSLB
 cYDNNDUlERvASWe1ryFnhM6HIaNmE/3zg6/7HhE3kg3dgvky7uRx0K8HF6JynXdccunb
 fFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jp9bb95FmgoCU2/ptjukarM+q7Wux537NT9Ov1W4D4o=;
 b=XHRGk9mu7wmp1xGilttnz/bgLwAyx+rMw/3+zwj/sFJK4YJougXwlflnUlyUDWhmGS
 W0QY4PyoQ21j/VRcZmIMBLAiad86ErE59Ko0T1zFZGFKiwXGdEQLT09wf5d48FWEJXR7
 GyJSn3e3XS6VmX7YYgSHU670ABnJNveYN5eacdxPmkv9Ynue0CnvBsIiKNhL9sP5X57J
 Zuft4F6e76wSIYWg2vGGTaT2OWv2gJMUHY6tbPZ4NS4XUFfkWcE5ymODp+x2bfe2g4vi
 XcCRonKMQVkLibc3YNW3f1DjkPjj84kRK54j6Rr89Jt31Fp4hr0O2v02NjptLsETKjii
 1u7Q==
X-Gm-Message-State: AOAM532Ymd3RgXlcWmqp2z6bI/u7VTYdgcI7yZkQWhRrml/T2XddxRbE
 P9AQOR8nVPUrwlCWzku1ktRS3EhVfVwkFWWW
X-Google-Smtp-Source: ABdhPJzWhI8rZWHLdEYSSYHhaMHUYvUQb5yIbFNs1jYtrBXtOQSL3j03CpUnpTkWzxDM4oeREBHVSA==
X-Received: by 2002:adf:e6c2:: with SMTP id y2mr661604wrm.117.1598606662693;
 Fri, 28 Aug 2020 02:24:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/35] target/arm: Pass the entire mte descriptor to
 mte_check_fail
Date: Fri, 28 Aug 2020 10:23:45 +0100
Message-Id: <20200828092413.22206-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

We need more information than just the mmu_idx in order
to create the proper exception syndrome.  Only change the
function signature so far.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200813200816.3037186-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/mte_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 104752041f7..a40454588d2 100644
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
2.20.1


