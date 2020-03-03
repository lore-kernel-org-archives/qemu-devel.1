Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A88CC3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16F0206E6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VH9HZj4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16F0206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9BhE-0000zS-5Q
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9Bg5-0007VH-Ud
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9Bg4-0006Ke-R7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:57 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9Bg4-0006KE-Ks
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:56 -0500
Received: by mail-wm1-x344.google.com with SMTP id a25so2898124wmm.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YrErCxdPD0FB72C1AvkhsFUhJwKacmb/G8K5xzzB0Es=;
 b=VH9HZj4kdw+98MsTFuffbD0riDElu6ZAEL7Z1/aF/roWyIv3rj1tpjftPAqTrXCfTq
 DxK0YlbpYLBfFkHFpYbklmxMiRVZJ3jpO5krV4iLqOIIWBryyG1wGP3xonegd41lxjCa
 oRsci3/RemWGFmUFb8HHDqVgk10br8axwsQWgommwmrObGWaIivqrB1Ti3JqJKIJjP7T
 fWIAR1bl9MAyte+VGoZY7LJqA/jfq3VjQSoNRjGiVnqcOKSxWYkxlwzLsdMrsuxUs8m1
 DREmdgGH3I7fwFnwslPaPx0w4it+1B3CcFlZB0P0kBho0V1dHyDra3X5tswy5BBVmFX0
 zvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YrErCxdPD0FB72C1AvkhsFUhJwKacmb/G8K5xzzB0Es=;
 b=DKSzlJQVT+8CcNa0V9v/4YN3h8lrou8Cq35XGJ7/3nVD2inSaGKyQTCI7oBBf9dzHH
 wpXj5kdzyjEu/gFBrpbXQ5MAVqlamQ12tQ0FNOlGv5pkWydAN+K5PN2TfBwr4svYocal
 /ZCJ1O2GqfLaE+jGMpobes48wftqk9KlymPJ21Ogj8glBUVhU2UlgY/7gRUxzoI8Q3Dy
 vvkQSwaYRL+HTOTtM3EXTiRwtoEQiepG1oOliYxXd4K5zaGht7FzTqmyv2PjndbSF9IM
 SlyWQwvhd7vcBX8V5anjDiOKDBjs4gywm4aVsRKIgnvVK+6/rzl+N4UEkDk/65/5yC1W
 eVKA==
X-Gm-Message-State: ANhLgQ3T8TlIh9gwg4KetmAvDVjOAiELFvVKh3Cmz9HvZ9FHmUzckOSJ
 b3H1h2i1E4RA8OetqMXFk04Ikst/y9mppA==
X-Google-Smtp-Source: ADFU+vscjtQjsVWZFCrRJ5DUhLjyQhn1uhDTZlxVGenumY2Ltc9aZ7uanQvxC2muyO/FVMMNcQiA2A==
X-Received: by 2002:a05:600c:552:: with SMTP id
 k18mr5507694wmc.171.1583257795766; 
 Tue, 03 Mar 2020 09:49:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm4867576wmd.44.2020.03.03.09.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 09:49:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] target/arm: Recalculate hflags correctly after writes to
 CONTROL
Date: Tue,  3 Mar 2020 17:49:49 +0000
Message-Id: <20200303174950.3298-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303174950.3298-1-peter.maydell@linaro.org>
References: <20200303174950.3298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A write to the CONTROL register can change our current EL (by
writing to the nPRIV bit). That means that we can't assume
that s->current_el is still valid in trans_MSR_v7m() when
we try to rebuild the hflags.

Add a new helper rebuild_hflags_m32_newel() which, like the
existing rebuild_hflags_a32_newel(), recalculates the current
EL from scratch, and use it in trans_MSR_v7m().

This fixes an assertion about an hflags mismatch when the
guest changes privilege by writing to CONTROL.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h    |  1 +
 target/arm/helper.c    | 12 ++++++++++++
 target/arm/translate.c |  7 +++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index fcbf5041213..a63fd5dfb73 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -90,6 +90,7 @@ DEF_HELPER_4(msr_banked, void, env, i32, i32, i32)
 DEF_HELPER_2(get_user_reg, i32, env, i32)
 DEF_HELPER_3(set_user_reg, void, env, i32, i32)
 
+DEF_HELPER_FLAGS_1(rebuild_hflags_m32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_m32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6be9ffa09ef..2eec812b80b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12325,6 +12325,18 @@ void arm_rebuild_hflags(CPUARMState *env)
     env->hflags = rebuild_hflags_internal(env);
 }
 
+/*
+ * If we have triggered a EL state change we can't rely on the
+ * translator having passed it to us, we need to recompute.
+ */
+void HELPER(rebuild_hflags_m32_newel)(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
+    env->hflags = rebuild_hflags_m32(env, fp_el, mmu_idx);
+}
+
 void HELPER(rebuild_hflags_m32)(CPUARMState *env, int el)
 {
     int fp_el = fp_exception_el(env, el);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7f0154194cf..4715ca0d2ad 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8551,7 +8551,7 @@ static bool trans_MRS_v7m(DisasContext *s, arg_MRS_v7m *a)
 
 static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
 {
-    TCGv_i32 addr, reg, el;
+    TCGv_i32 addr, reg;
 
     if (!arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
@@ -8561,9 +8561,8 @@ static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
     gen_helper_v7m_msr(cpu_env, addr, reg);
     tcg_temp_free_i32(addr);
     tcg_temp_free_i32(reg);
-    el = tcg_const_i32(s->current_el);
-    gen_helper_rebuild_hflags_m32(cpu_env, el);
-    tcg_temp_free_i32(el);
+    /* If we wrote to CONTROL, the EL might have changed */
+    gen_helper_rebuild_hflags_m32_newel(cpu_env);
     gen_lookup_tb(s);
     return true;
 }
-- 
2.20.1


