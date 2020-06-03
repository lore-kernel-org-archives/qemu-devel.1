Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA676C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69CE2072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a15OZsXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69CE2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI5T-0000z1-RU
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyX-00045i-7k
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:49 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyN-0003Z8-GV
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:48 -0400
Received: by mail-pl1-x644.google.com with SMTP id g12so191223pll.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=61m39+FMAykppXrhX2BpqO13HC/u4DFx0okzBeTOBpE=;
 b=a15OZsXw7InJ70zYYPo+xB1xlJaZFhubTGye7fFD7myJv5BmMISyjlOfz6soUBYY5k
 wmB9hwcYGkcLmjuVBxf7HkRemEWKYQw0Y/o0dvcXPQ8dfsFUnQgPgZJC3NuRqFGD3TOj
 4hHsIOAkIoTxVrtxeHzwG9Y+iQLgWc9nQGzP3jux7L2/a9CUazwXmAVBs7VxZdbdu5+Q
 iiGY5vkKM9vy7xkoeMg0E27VKEIomKfhy69I1k3HrO6WXBBdCx1uPYbzxXNSQgHEVYBX
 UtgfL/+fMecWXnYtmndJYeeEeuPLlNMCsmxN9BT5IxWGZ/enWJAhHN8oFDWr6WDsN7cF
 2sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=61m39+FMAykppXrhX2BpqO13HC/u4DFx0okzBeTOBpE=;
 b=g4rj2GW4rYlXjX/eESkucmKPZuHnbMRoCNeG0o1zitcw8haTXKhjeHPDbzqUGv3ko+
 LevSZIZHRu+MBCnQA+KhRSMX4pPPP4JQzeFfd4xY3dR/ipChT9lNrWhLL552O60ykmBW
 Rb4jEJeQWmoyalVlaiJxCcMVxEYElCSH1LhvPQyvR/DkF5khgCaoTmXJuJu+FRDekY6E
 ekDQIzmUQDUEUS+jvGRpLcxx3i8BrTeFWt+pKFcNgCzPbhNBI5XZ5e3HrwqUqxmfMiNI
 PfzmAt3ZDfeuAif2AeFZsMOeQJO5Zaj4+iwHwSc2iy6y3+bAuDpQ4ojmJoo3D4XyxDK3
 NI+A==
X-Gm-Message-State: AOAM530K9ljhIXiI8na7qbOe1MHuBu/O1gP2Q4j6Zd9DQj7Y1StbknhR
 ANI5fDfaL709UJOlO9TkgbrlSejeB0U=
X-Google-Smtp-Source: ABdhPJyBStZMn2GgRpZxLIgTdxL+MXJ78r6aODInEa9MovVa0U+cPjVWm4U25Zx1/87MmE4CKMpj6w==
X-Received: by 2002:a17:902:b110:: with SMTP id
 q16mr26887701plr.221.1591146816819; 
 Tue, 02 Jun 2020 18:13:36 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 14/42] target/arm: Add helper_probe_access
Date: Tue,  2 Jun 2020 18:12:49 -0700
Message-Id: <20200603011317.473934-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

Raise an exception if the given virtual memory is not accessible.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  2 ++
 target/arm/op_helper.c     | 16 ++++++++++++++++
 target/arm/translate-a64.c | 13 +++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 49336dc432..4b64d1ebd3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -96,6 +96,8 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index eb0de080f1..b1065216b2 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -935,3 +935,19 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
         return ((uint32_t)x >> shift) | (x << (32 - shift));
     }
 }
+
+void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+                          uint32_t access_type, uint32_t mmu_idx,
+                          uint32_t size)
+{
+    uint32_t in_page = -((uint32_t)ptr | TARGET_PAGE_SIZE);
+    uintptr_t ra = GETPC();
+
+    if (likely(size <= in_page)) {
+        probe_access(env, ptr, size, access_type, mmu_idx, ra);
+    } else {
+        probe_access(env, ptr, in_page, access_type, mmu_idx, ra);
+        probe_access(env, ptr + in_page, size - in_page,
+                     access_type, mmu_idx, ra);
+    }
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0ee2ef403e..b032829194 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -232,6 +232,19 @@ static void gen_address_with_allocation_tag0(TCGv_i64 dst, TCGv_i64 src)
     tcg_gen_andi_i64(dst, src, ~MAKE_64BIT_MASK(56, 4));
 }
 
+static void gen_probe_access(DisasContext *s, TCGv_i64 ptr,
+                             MMUAccessType acc, int log2_size)
+{
+    TCGv_i32 t_acc = tcg_const_i32(acc);
+    TCGv_i32 t_idx = tcg_const_i32(get_mem_index(s));
+    TCGv_i32 t_size = tcg_const_i32(1 << log2_size);
+
+    gen_helper_probe_access(cpu_env, ptr, t_acc, t_idx, t_size);
+    tcg_temp_free_i32(t_acc);
+    tcg_temp_free_i32(t_idx);
+    tcg_temp_free_i32(t_size);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
-- 
2.25.1


