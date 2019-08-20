Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C59C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE81206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="seU9CvbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE81206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0BhW-00046Q-OJ
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BM3-0000OP-U8
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BM2-0000F8-LV
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:47 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BM2-0000EZ-Fl
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:46 -0400
Received: by mail-pf1-x444.google.com with SMTP id i30so4112262pfk.9
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uEuMTFJPriSi6tDBht/B2C/M+eVLAfQCMhLFMcHsiGA=;
 b=seU9CvbPFWQC6HXFlU4qGeJJOEoKi3ivDF7hxy/kTPUlSwz+PanrBNm6RCvT2te+He
 wa1zY3vZI5hIVXtpr6XAieAWB9ejmxhi0ayDvZUBPOEtkJmHwikSRoYmoWc5OIl5hE/Q
 ROJJcZMaeAA8itUVPGVM1WCJMVPDTZO7iV75WtgXXH1crLSa3jjYdDwnKZfDrqzcxMly
 enPgJj8H+6XE4Gg2E/GpJfVbeXi4pz+dlWG/cQes34VEXWyKEla5nwEuh4soR9H20m5M
 JAvs0kHCIzAFCOUyXoVdvF/e8lCbnl6ZTnYo6sp/H3SK39N8jIhjT2PgGfSO/IumBJ43
 U0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uEuMTFJPriSi6tDBht/B2C/M+eVLAfQCMhLFMcHsiGA=;
 b=iW9vEkIrym/vOs42ZFJ1sdoxcWEUDWJME4DMI4Px2/jB5aiuZo05Jc56gW3qFqP+v8
 zktbnWygKej5S4oTo/65SEtU5dOuey1sgs7XGCodyGwg+IJtdu6py/uibqHYw4zN0Rxz
 K5QatHNh1hJYDsGRk/1ATp61aY3jXS99w1nyp+dhQ5hkFAcPwkI2sdoyraQpGsZnpmpE
 E0vtO8s4GIA8emmDW2ckjMyZv8QSjgQ/mOnzZN3Xqg0SedR1KHrPLDnu30/TomHPCoEi
 hYCvCSgyVPCiXY3uIResKqb754wfXn//1ASnpgjgqehVhQKwifcriAqxPhDfD6auKHVQ
 Zkbw==
X-Gm-Message-State: APjAAAU/Y8zNvPWswuGJET0Rlw7m23C19DRoaDnk6uEFGoRSYLiaa9Dq
 Ud9niCDLth0U6FjDnOcZ65BLQsuLujs=
X-Google-Smtp-Source: APXvYqzIhG7Y1bTtqOlIk7VV/mI3HBbDZ8gD8eDdYRt9suT8e6N4jThnf8CXWtQ64qeTnx/Wwddb7g==
X-Received: by 2002:aa7:95b8:: with SMTP id a24mr31913578pfk.103.1566335265240; 
 Tue, 20 Aug 2019 14:07:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:20 -0700
Message-Id: <20190820210720.18976-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v5 17/17] target/arm: Rely on hflags correct in
 cpu_get_tb_cpu_state
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

This is the payoff.

From perf record -g data of ubuntu 18 boot and shutdown:

BEFORE:

-   23.02%     2.82%  qemu-system-aar  [.] helper_lookup_tb_ptr
   - 20.22% helper_lookup_tb_ptr
      + 10.05% tb_htable_lookup
      - 9.13% cpu_get_tb_cpu_state
           3.20% aa64_va_parameters_both
           0.55% fp_exception_el

-   11.66%     4.74%  qemu-system-aar  [.] cpu_get_tb_cpu_state
   - 6.96% cpu_get_tb_cpu_state
        3.63% aa64_va_parameters_both
        0.60% fp_exception_el
        0.53% sve_exception_el

AFTER:

-   16.40%     3.40%  qemu-system-aar  [.] helper_lookup_tb_ptr
   - 13.03% helper_lookup_tb_ptr
      + 11.19% tb_htable_lookup
        0.55% cpu_get_tb_cpu_state

     0.98%     0.71%  qemu-system-aar  [.] cpu_get_tb_cpu_state

     0.87%     0.24%  qemu-system-aar  [.] rebuild_hflags_a64

Before, helper_lookup_tb_ptr is the second hottest function in the
application, consuming almost a quarter of the runtime.  Within the
entire execution, cpu_get_tb_cpu_state consumes about 12%.

After, helper_lookup_tb_ptr has dropped to the fourth hottest function,
with consumption dropping to a sixth of the runtime.  Within the
entire execution, cpu_get_tb_cpu_state has dropped below 1%, and the
supporting function to rebuild hflags also consumes about 1%.

Assertions are retained for --enable-debug-tcg.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Retain asserts for future debugging.
---
 target/arm/helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1bf71a260..5e4f996882 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11211,12 +11211,15 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    uint32_t flags, pstate_for_ss;
+    uint32_t flags = env->hflags;
+    uint32_t pstate_for_ss;
 
     *cs_base = 0;
-    flags = rebuild_hflags_internal(env);
+#ifdef CONFIG_TCG_DEBUG
+    assert(flags == rebuild_hflags_internal(env));
+#endif
 
-    if (is_a64(env)) {
+    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
         *pc = env->pc;
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
-- 
2.17.1


