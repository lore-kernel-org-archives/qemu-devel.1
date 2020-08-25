Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FABC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9FD920665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlQW0mth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FD920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgHe-0004Vz-22
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3m-0008E5-15
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:50 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3j-0001t7-ST
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:49 -0400
Received: by mail-pf1-x441.google.com with SMTP id k1so1455803pfu.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bQC2NsHcUulzW6D5RhH+hzBIgYR+xbZNPdmPEiO9k08=;
 b=QlQW0mthP7k6mEHQJjzG86WvF/cN8xdKjOgpDqAaksWh52IXrBrHdQtQiQOMbgCMA1
 K20AGnts/TU1sEG0WneWRMxYI8aoJEF2SLU3nCqW4iCkFIZDMdK/kqOVgE5t2jpfhget
 drUViA2h9mtZRymTVVNJfTKVMhaHKw84LJN96OK9D/M10ppcDhnzpCe6lyqffpeScIEq
 BEUgoj5zlGrZLtxUYnTO7iJ4McZmTcfw/9j4a6JYwHDqZmZPrfVHKeEqw1Y22tN1QH+g
 g9oB6tgBZoNOo6lKloI2hAQF+bXO12vzGi07Yh3vA7RK9qqk9TDrxCG6kDQGt+GsJD9z
 VT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bQC2NsHcUulzW6D5RhH+hzBIgYR+xbZNPdmPEiO9k08=;
 b=TIt7Ks7ek0YShkRSEDeltBCB4dIxe5J5eO1wPV9/V1YxmBX9awcBRCQ/WhgeiL0y5t
 EZNinra6c9eAAgUPw31+Dm7/HgacZuWUqfVDONKrHBZn7rIALQtlPxmxSQVNQ7OqJcBH
 EvCXaSb5VBsNP2CmyrJAoD8EHaaHn3QqTHbATpaHg3sXhFP+dTBF5OVGa4ITCy2LdkEC
 kbmKyLklIrhb5tdXwdR9lwCh+IGmREUnDEygs+UJKW/8FaQUUbCFIXgDA8XrD59H9SfV
 KIRunMOY8B7JaPAsVFC/4Ax8EvF8sR5RiArp+Dll4ttHAG4EgtrroqLYFKiWOgShZy4C
 2yOw==
X-Gm-Message-State: AOAM531VQoOd0c22wuTe/adrUI7ZeMzyc3eHT9E+hJiSjCGH07jlmBip
 y4vXHL7CwdTdYlYzz0F9mt4jd3B+e1gNIw==
X-Google-Smtp-Source: ABdhPJzrbf2ZnHpbX7xMUZTBNSQUvqmHijaK/EduBn4nNhOi/m2ANF21pn5zM1OeGiH15MEM3guR8A==
X-Received: by 2002:a62:1d05:: with SMTP id d5mr5505067pfd.63.1598389246141;
 Tue, 25 Aug 2020 14:00:46 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 43/77] target/microblaze: Unwind properly when raising
 divide-by-zero
Date: Tue, 25 Aug 2020 13:59:16 -0700
Message-Id: <20200825205950.730499-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restore the correct pc when raising divide-by-zero.  Also, the
MSR[DZO] bit is sticky -- it is not cleared with a successful divide.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h    |  4 ++--
 target/microblaze/op_helper.c | 23 ++++++++++++-----------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 6f7f96421f..79e1e8ecc7 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,7 +1,7 @@
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 
-DEF_HELPER_3(divs, i32, env, i32, i32)
-DEF_HELPER_3(divu, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_3(fadd, i32, env, i32, i32)
 DEF_HELPER_3(frsub, i32, env, i32, i32)
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index f976d112eb..d99d98051a 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,26 +69,27 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
+static bool check_divz(CPUMBState *env, uint32_t a, uint32_t b, uintptr_t ra)
 {
-    MicroBlazeCPU *cpu = env_archcpu(env);
-
-    if (b == 0) {
+    if (unlikely(b == 0)) {
         env->msr |= MSR_DZ;
 
-        if ((env->msr & MSR_EE) && cpu->cfg.div_zero_exception) {
+        if ((env->msr & MSR_EE) &&
+            env_archcpu(env)->cfg.div_zero_exception) {
+            CPUState *cs = env_cpu(env);
+
             env->esr = ESR_EC_DIVZERO;
-            helper_raise_exception(env, EXCP_HW_EXCP);
+            cs->exception_index = EXCP_HW_EXCP;
+            cpu_loop_exit_restore(cs, ra);
         }
-        return 0;
+        return false;
     }
-    env->msr &= ~MSR_DZ;
-    return 1;
+    return true;
 }
 
 uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
 {
-    if (!div_prepare(env, a, b)) {
+    if (!check_divz(env, a, b, GETPC())) {
         return 0;
     }
     return (int32_t)a / (int32_t)b;
@@ -96,7 +97,7 @@ uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
 
 uint32_t helper_divu(CPUMBState *env, uint32_t a, uint32_t b)
 {
-    if (!div_prepare(env, a, b)) {
+    if (!check_divz(env, a, b, GETPC())) {
         return 0;
     }
     return a / b;
-- 
2.25.1


