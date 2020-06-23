Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA10C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDAD207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDZdvVUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDAD207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnokV-0005qs-60
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojD-0003BB-Gm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:07 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojB-0005VE-DV
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:07 -0400
Received: by mail-pj1-x1043.google.com with SMTP id cm23so1954816pjb.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UZWgT5KzsbdnnIQS6h1nh35owoxC0Bf2W5wbwlUKiR4=;
 b=tDZdvVUqKdRWzIX/vgYGSkxInlTaRMTI6223OI3OBbexvJEifp4aaqIifoGCCIXCDi
 jypGBlYrZSuAS4SdACIJSavo5WAcnJY4ipq2OLIynQvl3IDFh5XrvzWLjlwY+0giyC/n
 WaVexWmIEOQOhiZwiOC/szSCsgWpDd/iVYQB0TMvb2bvdU2abF1tShdkNrr8wKaqYDuw
 5EBStcfyUzfE1+4F5Ds/s7LUswiw54fTYCibDScmfCjZ09hB5qUA4YrKoBwWeC5KIKcP
 0yG77MofzU7VN5yCDfqdlri/v1qDNZfOompf+E2bchVfpxOgXKK1aq4ef200UszTSV0i
 udIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UZWgT5KzsbdnnIQS6h1nh35owoxC0Bf2W5wbwlUKiR4=;
 b=kkrYFUE7XVsIlred9VlBRZTdSn3soWfxiemYAdKp1bd6vxZBrQMsmaAQpoeVhJpRjC
 sLovC+KSsEHQc9aawQnKmWF14bW0f/8ZzXX/OHd2nhN0Bcs2prWDpeUtVJ8xwgr+eq/v
 Ml8wetvd9xEnDYTdlqI3lhGXyie2fAGCb5h7eDk6mX495ldORl8RwzpEw0bMYWkBNPdf
 f8uGtGB3jiyIFm8cv798MO3ULSBzck54I3ZCg0MFqQZILLAFduH7Me75Lzyo1e1RWaoY
 npRoJKQ7D7R/7Jh+crq648QZ61yK3mNSdBK1s3KfUZGKeiiHaDvMWhyFbsSHzv8MlxOl
 WX2g==
X-Gm-Message-State: AOAM533geLl/eG9CPd25pWyuNTMp2RDuTUfFFI7dbkQv/znFAlnGtndw
 T0jeUr/WU0o581s8p8GqQ7UKgTX4tuY=
X-Google-Smtp-Source: ABdhPJxEtu2UH+Z7IX5qh8RjXFElcNxsH693qe0SjHmjSjVlHaonNuTbez9Faqu+wSZNxPZk0a6/Ng==
X-Received: by 2002:a17:90a:2683:: with SMTP id
 m3mr24946133pje.196.1592941023691; 
 Tue, 23 Jun 2020 12:37:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 02/45] target/arm: Improve masking of SCR RES0 bits
Date: Tue, 23 Jun 2020 12:36:15 -0700
Message-Id: <20200623193658.623279-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Protect reads of aa64 id registers with ARM_CP_STATE_AA64.
Use this as a simpler test than arm_el_is_aa64, since EL3
cannot change mode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 972a766730..a29f0a28d8 100644
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


