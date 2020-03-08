Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DE6C10F25
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 01:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E74206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 01:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezfqiMoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E74206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAknC-0000Mp-Um
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 20:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jAklO-0006pO-QU
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 20:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jAklN-0003tR-Pp
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 20:29:54 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jAklN-0003sb-Kd
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 20:29:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id t3so3019136pgn.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 17:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qOuTtio1oLREm+GMX+5O8B+s/d/VI1jp3YJB+8tDvLQ=;
 b=ezfqiMoq1oWBP56mbBUeyMJv4ntiRDAp6qAzRKuNxuiKf9c0H99ONUEE1A/y789m4Y
 27rSM3AqpA0fzqLB4rf7EgvR2Uvsmvk9YEhGCzEzZxUgHjlfrlqyPE3TCc6aw8ri2Wbq
 oiJounwFQ9c5+AmtNnWohRgJWf+/W1waVXlhjB0aR3VHc2vGmJwhymSpBIQLx5pX+4O9
 9C63OdY8gs8NrwZyiGJIF/7eNt+65aUwouxnHIMhnAKWj9Aj+XWcHfli9m2oRbzWpySC
 mhqaci/a2R9LDMoozaTA8jNl99OvgBlfue/2unRBSQQNp5EiCC/e0gm+YwNQYrqQVc0s
 M0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qOuTtio1oLREm+GMX+5O8B+s/d/VI1jp3YJB+8tDvLQ=;
 b=Ph3jJVteYdy0DIf55Z/u4QitqjxNUSfkTrIDBI4lCqvBILtnWTvw46kF80cxRePSuZ
 uE0nXGjRvQ7LRoT3l6pQ63+YjaTACT/H21sUAPeP9cHA+tN9/qrEr+CtcVMSjHlBaZxn
 G00ZbcgBaRBaCNQtvWwKS8w15azKA6tDOiUpSPmM+rPGAAiQmrJz6/7G9ZpF+BHf+B+G
 YmnrxbAGRaA4G5dn5+KUrAtfU9xGwxwkxFLIcMU2A9UvSaUNW0rehey/0tY4w9EsIGeV
 nc00eF92fYiYS3Q0ig37fanq5QJCU101WSq/yH1BjcBMFqitsfYIiJ/Ur5lxxm4gvn8H
 SzTQ==
X-Gm-Message-State: ANhLgQ3JS4GSYRzSw7fNKy4WB4n7sahl6fvvscoW692oNREvqjFYk60z
 ZimygyY+FEw7DmZ7f/7wd6i1AvH+afU=
X-Google-Smtp-Source: ADFU+vsuAYRxNybJ0jV3tmQcGGoWbIM68RJBTcT45ySXlRF7XCVfCNnDu30bg6EN9QT5b8uvNzta2A==
X-Received: by 2002:a63:5f51:: with SMTP id t78mr10105814pgb.362.1583630992082; 
 Sat, 07 Mar 2020 17:29:52 -0800 (PST)
Received: from cloudburst.hsd1.or.comcast.net
 ([2601:1c0:6100:5580:6886:21be:91dd:78be])
 by smtp.gmail.com with ESMTPSA id w19sm32636891pgm.27.2020.03.07.17.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 17:29:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] target/arm: Check addresses for disabled regimes
Date: Sat,  7 Mar 2020 17:29:45 -0800
Message-Id: <20200308012946.16303-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200308012946.16303-1-richard.henderson@linaro.org>
References: <20200308012946.16303-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

We fail to validate the upper bits of a virtual address on a
translation disabled regime, as per AArch64.TranslateAddressS1Off.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f91e5d5345..8f81ca4f54 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11780,7 +11780,40 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx)) {
-        /* MMU disabled. */
+        /*
+         * MMU disabled.  S1 addresses within aa64 translation regimes are
+         * still checked for bounds -- see AArch64.TranslateAddressS1Off.
+         */
+        if (mmu_idx != ARMMMUIdx_Stage2) {
+            int r_el = regime_el(env, mmu_idx);
+            if (arm_el_is_aa64(env, r_el)) {
+                int pamax = arm_pamax(env_archcpu(env));
+                uint64_t tcr = env->cp15.tcr_el[r_el].raw_tcr;
+                int addrtop, tbi;
+
+                tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
+                if (access_type == MMU_INST_FETCH) {
+                    tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
+                }
+                tbi = (tbi >> extract64(address, 55, 1)) & 1;
+                addrtop = (tbi ? 55 : 63);
+
+                if (extract64(address, pamax, addrtop - pamax + 1) != 0) {
+                    fi->type = ARMFault_AddressSize;
+                    fi->level = 0;
+                    fi->stage2 = false;
+                    return 1;
+                }
+
+                /*
+                 * When TBI is disabled, we've just validated that all of the
+                 * bits above PAMax are zero, so logically we only need to
+                 * clear the top byte for TBI.  But it's clearer to follow
+                 * the pseudocode set of addrdesc.paddress.
+                 */
+                address = extract64(address, 0, 52);
+            }
+        }
         *phys_ptr = address;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         *page_size = TARGET_PAGE_SIZE;
-- 
2.20.1


