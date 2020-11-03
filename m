Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D0CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA1F216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxVuJI8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA1F216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZun3-0000nw-U5
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZumE-0000HV-Mb
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:47:02 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZumC-0005Me-Sz
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:47:02 -0500
Received: by mail-wm1-x344.google.com with SMTP id h62so7651233wme.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vLwQzK3euyp1V0xxDaf9XmLFVlrucKWOw3sirbQ2sVw=;
 b=UxVuJI8A8x0DNhPGfoFHjGaF0RPjMSPT1a2KjqhHApl9pPhW6P1yYCboeUzLFIxLRe
 xUBNZPbrLVWt2nvGmAj/hyOMA0CEitbaGrzuw7O9guAJ/6nKQSmQaPoZUkH3OiaN2QVq
 ZoZmiUfT65QM5Haq2JM7hh/ydckXM3CDd2J3Dha17zCjuGzIQ/kj1OLPHCxx8NpqAgBy
 Lg84dXxuwKw9ilFfiE2/iLwCdAt0xuyDcu1ycVd8358G9Yy8vrAxtNdTc8FkmyFQWcPz
 zkhRD21rLlf2nulblvgpesCOueN7+XHOcfxjSA11mu5uWvTm4aPus+TvI3nGqLBp6vTo
 tRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vLwQzK3euyp1V0xxDaf9XmLFVlrucKWOw3sirbQ2sVw=;
 b=gthHItQGj9+YztAgVLMYtlBxQcm4Gf/K3KPAS8vKNPU5PH/Vb9yY15KJyUcaosxh8y
 vme9l5cEiSwQiuJ7MKcV4qZLKj5cLhzhMfHe1yYUw3ktyjws5BDmHh5WfVK7nj7w13d5
 fctyLvHdbBivwykuJVWEL23Oj/Cq5Zs4qBZ3DezSaxUC9gBlkso5Bb3pGiwPLjc64GXL
 fylQxC4GYwsqg82I6b3Lpff/fzT9xjh1FdXy3mKodbhviq7pW7SEpyXCtjVC955JGrpW
 kCY5uBmHshb4EJ8/yrMkb3hEeRprAI6XBkYNf9X8P1ryRFFsCorXTr9rRwNKZpyi/H2Z
 yCuQ==
X-Gm-Message-State: AOAM530OVjMn2y7tS/JhUF+TGOEI0tcTVHjEbrH9byMZ1cZuYnGW7vHQ
 mow0IWfV4WwtLQUR/ieBecZlKIur/qNKMg==
X-Google-Smtp-Source: ABdhPJxKkN5vfMmG7reLTaFY2VXo1ZZFu5NVV6N32cPwcyzLgoXZP8ahJ6UqMg7XclGgzgimaxmRnA==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr3129945wmf.121.1604404018287; 
 Tue, 03 Nov 2020 03:46:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 130sm2908224wmd.18.2020.11.03.03.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 03:46:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/openrisc: Remove dead code attempting to check "is
 timer disabled"
Date: Tue,  3 Nov 2020 11:46:54 +0000
Message-Id: <20201103114654.18540-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Stafford Horne <shorne@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the mtspr helper we attempt to check for "is the timer disabled"
with "if (env->ttmr & TIMER_NONE)".  This is wrong because TIMER_NONE
is zero and the condition is always false (Coverity complains about
the dead code.)

The correct check would be to test whether the TTMR_M field in the
register is equal to TIMER_NONE instead.  However, the
cpu_openrisc_timer_update() function checks whether the timer is
enabled (it looks at cpu->env.is_counting, which is set to 0 via
cpu_openrisc_count_stop() when the TTMR_M field is set to
TIMER_NONE), so there's no need to check for "timer disabled" in the
target/openrisc code.  Instead, simply remove the dead code.

Fixes: Coverity CID 1005812
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/openrisc/sys_helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index d9fe6c59489..41390d046f6 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -176,9 +176,6 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
 
     case TO_SPR(10, 1): /* TTCR */
         cpu_openrisc_count_set(cpu, rb);
-        if (env->ttmr & TIMER_NONE) {
-            return;
-        }
         cpu_openrisc_timer_update(cpu);
         break;
 #endif
-- 
2.20.1


