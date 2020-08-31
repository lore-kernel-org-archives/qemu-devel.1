Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A82C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF232073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWjYyzpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF232073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmYO-0008Sd-0x
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKo-0005LS-6h
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:33295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKm-000644-F2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:05 -0400
Received: by mail-pl1-x62a.google.com with SMTP id h2so3257503plr.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MvUJVsNPWoeKhWUV8ldYPjhJGjA7j8IztAPyoO2B77I=;
 b=QWjYyzpkXE546IWmGaBX2ohT/h97DP9toSleezV5UkZsbg1OkyjUL5iERFX0NQCdvA
 Co+rjX9X06vlGv5dLzUiDJqBlfeyKun8zbzo+wzcMAnpj9YKoqlxAPLcrPVfd+sOymeO
 1rl1UtJ5GGjs1vNTn8Ci5LbY9sXY4sBaZbbSjKgQpUgGFwNOzFBMMoPXurTdyjpJ1+9L
 kJ1k4d4kH79sTdp1KzeEISbSPW/NE5mPaeqVCOwDSa7ooXCTWHERR4iGEkog/rh/sMv0
 XfU5bdCgXxpaecAh7w9SZzaaI4dr01mLjTmiQZ5YO42UcqdaFlGij6hfarNPsyiYsSDe
 jWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MvUJVsNPWoeKhWUV8ldYPjhJGjA7j8IztAPyoO2B77I=;
 b=AxFwuLXpZrRIjx6tsoCaScUTNw06P3uP8iIIpV41kafwkQsvshCuIqOrp3NOGO2Yz9
 ehV+UJJ2FmpeEPP4nHHVTXkGD+nthtlwY50RfmyLVRiHOeBPxAxG30k63pi4dYsHenWH
 im9676vrbkb3mZdhQd/eNCXg/JFfVeXsJddIFhYAz07EIYqQkMfNbKox9fty1onKioWR
 sRBjuHrdBQyC2/iNR8VTaIv25sZ87aSCDfLf1u4zFX3B2wWteeU4ZNw9II1i8bVaAtOM
 SjcZ1ZMIt6ta+/F/ssz+qUIfOo5GGDi2rOQ4S5SjrCj8jF9MgNjWZPHS3jcBkzgvc8y3
 QHdQ==
X-Gm-Message-State: AOAM533hDTyOKTPn8SV1UXQXASBuubd1oHqA28i22evX8mNP0hfGo96g
 Vv+yDUeHJZeXotc/tRHCDAblusYNmBqy+w==
X-Google-Smtp-Source: ABdhPJx9nwMaYOhGD4nkqqRF3aWcCln4aLW5ffiKGmhVpFyHh9txnNNLoS7zpLrhNRZ3IyPB1XHghw==
X-Received: by 2002:a17:90a:d496:: with SMTP id
 s22mr61847pju.167.1598890022534; 
 Mon, 31 Aug 2020 09:07:02 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/76] target/microblaze: Unwind properly when raising
 divide-by-zero
Date: Mon, 31 Aug 2020 09:05:28 -0700
Message-Id: <20200831160601.833692-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restore the correct pc when raising divide-by-zero.  Also, the
MSR[DZO] bit is sticky -- it is not cleared with a successful divide.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


