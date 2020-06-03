Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46027C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166CE20663
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+UtE/59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166CE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgHzW-0005lU-2a
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHy7-0003Hg-EF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:23 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHy6-0003Vb-RJ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:23 -0400
Received: by mail-pf1-x444.google.com with SMTP id f3so400817pfd.11
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LadquP7zcJjQQG0Yfbt1ahthtHYVsuxaqjQXIxyHC+g=;
 b=u+UtE/59Le3pHvHBcznGutnq/Jy4yqyhDnjhwwE2lSJCdgfZbgodRX9j6tPmJ8hYKu
 IdnRKB4rB+wkqH4mUHceRFWxAwA+OTsvl5tx9+IxRUKNtL/4HY+/h+gai/CrpCZUKGFx
 sXxt/WII8p055eMQ/Dm1e5pf5eP6XrWQ4CDJ1VxgJeuheWUqgN5SRZacYXE5ch5p1Foj
 CY0nbaC9gUtZq6E8FIlCYYLpocgWCSsuaEqkJICoVySJnHBjSDAzuGqyN0yd4LJGlfI2
 v6Z6hlFEDsmlcA/6XIIPTglrdWZc0V3ii2qMN1ZSq8V2NknLycAiPVMV89694bIa2l/O
 u4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LadquP7zcJjQQG0Yfbt1ahthtHYVsuxaqjQXIxyHC+g=;
 b=UtAgpIZwRsH/Myv7jW5ITZ9SFs1QHP2K64lknYLGJvDbGQw2K2NE31k8FRdkcK3HR2
 PQRV5Kx1yfwLCokmC8tDBw2Dam8+BkO8NELuafRKa749sE4iuI+Umq7duYAqUhi5o2Vf
 lTl33WAfgY1xpxfXGF/+K4t2ZX7vxdr5SGBF+zZdIIfe2kIqUgdiMKvLKspcyWd5R/eL
 ap8Ju9uMTh/pmsb4S13B8OYrmpAuWJRQ1vEPEGwb9v226VFL3xN43v42rctYrVhpMSIc
 rpaxo0m/wS/FQej96jzCU5+IU0/ctTi9mGXkASuYMWMOE3/ay28p8Xxhc9LB4x8g7MFz
 NNVw==
X-Gm-Message-State: AOAM533uokG329KsTWsvYr0Fgj4iTLjU5Cb0f+cBKyuRRfV0nApa7gde
 2lQZmA5MGUAHrhnPmeZ5fKAqQ1+oFKo=
X-Google-Smtp-Source: ABdhPJyX/l+L+JG4K4imMNobf9ZnhFq3Qt7rSWZ4VIJZVW1+fq427UFslJ6o+XvYZShoHhkwMWtpbw==
X-Received: by 2002:a17:90a:df16:: with SMTP id
 gp22mr2327443pjb.6.1591146801223; 
 Tue, 02 Jun 2020 18:13:21 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/42] target/arm: Improve masking of SCR RES0 bits
Date: Tue,  2 Jun 2020 18:12:37 -0700
Message-Id: <20200603011317.473934-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

Protect reads of aa64 id registers with ARM_CP_STATE_AA64.
Use this as a simpler test than arm_el_is_aa64, since EL3
cannot change mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a92ae55672..2ec49c1a55 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2011,9 +2011,16 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     uint32_t valid_mask = 0x3fff;
     ARMCPU *cpu = env_archcpu(env);
 
-    if (arm_el_is_aa64(env, 3)) {
+    if (ri->state == ARM_CP_STATE_AA64) {
         value |= SCR_FW | SCR_AW;   /* these two bits are RES1.  */
         valid_mask &= ~SCR_NET;
+
+        if (cpu_isar_feature(aa64_lor, cpu)) {
+            valid_mask |= SCR_TLOR;
+        }
+        if (cpu_isar_feature(aa64_pauth, cpu)) {
+            valid_mask |= SCR_API | SCR_APK;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
     }
@@ -2032,12 +2039,6 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             valid_mask &= ~SCR_SMD;
         }
     }
-    if (cpu_isar_feature(aa64_lor, cpu)) {
-        valid_mask |= SCR_TLOR;
-    }
-    if (cpu_isar_feature(aa64_pauth, cpu)) {
-        valid_mask |= SCR_API | SCR_APK;
-    }
 
     /* Clear all-context RES0 bits.  */
     value &= valid_mask;
-- 
2.25.1


