Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4AACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EC020650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2PlupZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EC020650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgV4-0000UP-JW
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxy-0007hP-D6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxw-0000si-P4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxw-0000sC-I7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id n15so16009646wrw.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EcerNk3YeDT5sQSP3taUcz8aA1kUh9D2O9nEmkTp88Q=;
 b=L2PlupZGCsVM1GVSZCQM9wCd35aNupZyY2spI6UcISexUjjl8KPSUKoW5S+jv2iwOt
 bdTpsbx1iZ1eW+ZF0jWCBFmAZt5Yrsu7yYuUu786/mybqOMSMMhz+gmabKwiuR3cUpk+
 eQwNS0K89OtvMPRGx0TYh8J9ddvuxa4SBNdJNgPEPjYD3Hffr4ri0nzociiyKaLSMUZr
 1Ziabd+5F+27gaeczKMC6r/Jg0EpIRuo7m5sWzut06l72yBF3Wd7dcaokbSiSwacknI+
 WLA00aEeRFzAy+wrhLn5UMZKR+oiKBAan21lrqLgXWcMRbc7bVm5VUCtqUWDa+CXZ3bi
 QhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EcerNk3YeDT5sQSP3taUcz8aA1kUh9D2O9nEmkTp88Q=;
 b=f4NofocNo+aGKWL6ytVRVNtVTHDxcF0egA5sqIJLlLX8A8datdDKmz8MUwsH2CwRlS
 21HmRHRflQetdRahshv4GCcacRb7/CdrMZM1MzPaVXlE0uUtcoke0tcZVpUCl0qHzJay
 rebyl2DWUl9LkZp+roxDBzqKcm7uvZ0bUBcv132u1HoDY2+z3phsuDkPQKAs7pmxi+6C
 J8c4tYITeq5NoaW4vXIOL1chV5P/BlpmDD9oEMj93FfLN/YZ9Zkyh5LmxESXgHsSSrlM
 c+U2ZIx+IDKpRs8pKQPJj/2oMIA97G+6cQGRc1hUjNyZ0KZ3Cq12mOcwDwvsjxy3gLpe
 BXGg==
X-Gm-Message-State: APjAAAWWrdADJkQgek15drZxaFSugha+T0opDBPja3Hu7WWmqfVtM1bZ
 BEuQfCe2ZeS1LCohIGQxTl8vunBZSoA=
X-Google-Smtp-Source: APXvYqwJ2ATksEuP6UHrnf1xcQPw18vUI7YHW0iXQM/7he4xlEs9ndiPv7ZR4/wknyzdr1as4sZLTA==
X-Received: by 2002:adf:f5cc:: with SMTP id k12mr4556905wrp.65.1571934479240; 
 Thu, 24 Oct 2019 09:27:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/51] target/arm: Rely on hflags correct in
 cpu_get_tb_cpu_state
Date: Thu, 24 Oct 2019 17:26:59 +0100
Message-Id: <20191024162724.31675-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Message-id: 20191023150057.25731-25-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c55783e5406..63815fc4cfc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11259,12 +11259,15 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    uint32_t flags, pstate_for_ss;
+    uint32_t flags = env->hflags;
+    uint32_t pstate_for_ss;
 
     *cs_base = 0;
-    flags = rebuild_hflags_internal(env);
+#ifdef CONFIG_DEBUG_TCG
+    assert(flags == rebuild_hflags_internal(env));
+#endif
 
-    if (is_a64(env)) {
+    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
         *pc = env->pc;
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
-- 
2.20.1


