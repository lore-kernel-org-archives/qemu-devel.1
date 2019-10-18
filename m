Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67173CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB3920640
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gH4ePKI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB3920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWlZ-0004Zq-BZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJA-0006u4-FT
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJ9-0005ey-8T
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:45:00 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:40691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLWJ9-0005eF-37
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:59 -0400
Received: by mail-pf1-x432.google.com with SMTP id x127so4316405pfb.7
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HGoDHAyFTg02BbCDc0SzUOS11VgHC5xQyCe+OvrFqFc=;
 b=gH4ePKI0ZYmF3BKEWSo9PNClpVHrBkapR2R7ZkhfqrjHkMHJS0HX4sdTlt21lXFwtc
 2tKmh+xORcUbroASKsXq+0bA1pUBHlDJndVV1+Wuh2WRFy5pCmXxAaB3cH87LD9FyKXb
 IXQZH9TBrb4pIXteiwfFCvBGPW1Tzaoo8oyue8TYz0MouKhMLXpwpwEIz/3TmgsQh0SU
 rCTNdMyVME5zlZXAigmt3XoGOgmV6t40LujfLvl/DO78he81jF+v7I7vuI6cFTTDCAkZ
 VeC8eSH+ufI37bf33sNcpqxpTpY6vLGvUMUpMuxRtnhE/twy081+Txs9R2p5D860HpVB
 khuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HGoDHAyFTg02BbCDc0SzUOS11VgHC5xQyCe+OvrFqFc=;
 b=phxqSPjd5LuDlfEx2aeKlAcMlv3gCHDyQQLjDSZjz0hR5lfaSXg56cSnMhjJvmef6t
 bKttAhMW1hzffemOIYVrS1R3pxmWRoWd/m6+0S59TRhGSjRqi+rtJSSQ+Jj8cPEB4iDG
 TSsZkCc0AL61G5Do1sPPxOvI3bMVOR7gP4qoxKfzZYEECjSnVt6nY3SD1yZw6CfVxXjP
 g/6L8PBi/fH9kvCNslTmyETNUJVNJPhq5pQFr2BE71gstf35pwrRav/3zA3inlGQ80KE
 IjEFmgQj/b3hksjgKluVnn8CpNCWpw6Tc2h7PE62Cwd7LttGypUrV4Z4FwJPR4DVopXH
 7jFg==
X-Gm-Message-State: APjAAAXx6F4tDoFr/DHnN+J7i17fMy+7/cGnk9yxbv4fm5vTf2hPmuCt
 bOEwxLMk+mahne1wl8YACeLioNsUeSM=
X-Google-Smtp-Source: APXvYqz/KFTKYBmeodxvJ4P9FIz9BFgjMqOd1Kk6fWEJ/ZKOvUUWq3TqvZHYNZXviyd5iFb4LDKbGQ==
X-Received: by 2002:a17:90a:376d:: with SMTP id
 u100mr12408557pjb.23.1571420697691; 
 Fri, 18 Oct 2019 10:44:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d20sm7857534pfq.88.2019.10.18.10.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:44:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 20/22] target/arm: Rebuild hflags for M-profile
Date: Fri, 18 Oct 2019 10:44:29 -0700
Message-Id: <20191018174431.1784-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::432
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v7: Add rebuilds for v7m_msr and nvic_writel to v7m.ccr.
v8: Split nvic update to a new patch and generalize location.
---
 target/arm/m_helper.c  | 6 ++++++
 target/arm/translate.c | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 27cd2f3f96..f2512e448e 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -494,6 +494,7 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
     switch_v7m_security_state(env, dest & 1);
     env->thumb = 1;
     env->regs[15] = dest & ~1;
+    arm_rebuild_hflags(env);
 }
 
 void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
@@ -555,6 +556,7 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
     switch_v7m_security_state(env, 0);
     env->thumb = 1;
     env->regs[15] = dest;
+    arm_rebuild_hflags(env);
 }
 
 static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
@@ -895,6 +897,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     env->regs[14] = lr;
     env->regs[15] = addr & 0xfffffffe;
     env->thumb = addr & 1;
+    arm_rebuild_hflags(env);
 }
 
 static void v7m_update_fpccr(CPUARMState *env, uint32_t frameptr,
@@ -1765,6 +1768,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
 
     /* Otherwise, we have a successful exception exit. */
     arm_clear_exclusive(env);
+    arm_rebuild_hflags(env);
     qemu_log_mask(CPU_LOG_INT, "...successful exception return\n");
 }
 
@@ -1837,6 +1841,7 @@ static bool do_v7m_function_return(ARMCPU *cpu)
     xpsr_write(env, 0, XPSR_IT);
     env->thumb = newpc & 1;
     env->regs[15] = newpc & ~1;
+    arm_rebuild_hflags(env);
 
     qemu_log_mask(CPU_LOG_INT, "...function return successful\n");
     return true;
@@ -1959,6 +1964,7 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     switch_v7m_security_state(env, true);
     xpsr_write(env, 0, XPSR_IT);
     env->regs[15] += 4;
+    arm_rebuild_hflags(env);
     return true;
 
 gen_invep:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index cb47cd9744..b3720cd59b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8325,7 +8325,7 @@ static bool trans_MRS_v7m(DisasContext *s, arg_MRS_v7m *a)
 
 static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
 {
-    TCGv_i32 addr, reg;
+    TCGv_i32 addr, reg, el;
 
     if (!arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
@@ -8335,6 +8335,9 @@ static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
     gen_helper_v7m_msr(cpu_env, addr, reg);
     tcg_temp_free_i32(addr);
     tcg_temp_free_i32(reg);
+    el = tcg_const_i32(s->current_el);
+    gen_helper_rebuild_hflags_m32(cpu_env, el);
+    tcg_temp_free_i32(el);
     gen_lookup_tb(s);
     return true;
 }
-- 
2.17.1


