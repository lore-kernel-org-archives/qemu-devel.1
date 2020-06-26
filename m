Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CABC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314812053B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umlJJTd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314812053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jof78-00026u-DK
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5k-0007gd-Ca
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:31:52 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5i-0001hw-Rz
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:31:52 -0400
Received: by mail-pf1-x441.google.com with SMTP id q17so4053070pfu.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UZWgT5KzsbdnnIQS6h1nh35owoxC0Bf2W5wbwlUKiR4=;
 b=umlJJTd80Zwe+YUzQlau5Iu6kwFEOCcslmhxU/MxyCJwjb9dBAMEYRyfZyld4F9CzB
 IP1jUasoKi7T6uyI3bJ3i4FpTSkC/fj4IDNMdWM8oR5fgymCahj/ebfpKTOQjNp4FALJ
 aWAdoJye91pQctFbRIq7Lx3Nx8K4zut9sNtyV2rrckswz1kgE2WMVEjuptlDmYaxxFq1
 rwDAT3guU4GHQSOdH7N0d6ZvvOsxVCp9Te/jyxD2mYNTBZbgNmhFGN+dgS4TKY6w8Pvh
 hMIY/UDpKv+q02Ed2rfFlAuERPz2QcLFLAumXWdRQ5vy2LwZRG8nOamolYaQrsB3rWPK
 bvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UZWgT5KzsbdnnIQS6h1nh35owoxC0Bf2W5wbwlUKiR4=;
 b=hIeD40cu3HkMtTte0T3hrfVJ3IwP6ZNmCtqDS6mXC4dGa/98w9kqlKiO2pQ6Pa+euL
 KeNvuSGjbpdOkUNGRMOzs8gCRxIqh/tB0uVuGb/s2kvdJlgW8uiXs1vsD2ql6q0Hfe76
 o6Z9G9FS8fbjzpV1PHfv98GH5TPdUZ0UbwJbAgXX84Eis0psJLh2yh5UPVSKT4z9p3VC
 kBGAFL6/oufg9Y6Tzz8Re7Otl3R/TO6uEL1RFc3YMEGKoeL8i1VR2ZEbgn9Hl0ZN6dpr
 n6A3pSX7E0xWXQPS/CMJMOBY6pXutF4N4ikIo8VnsC8rh3YMiQKJY9/+GN9e/WwkA2sQ
 GuqA==
X-Gm-Message-State: AOAM530dyHvPxl81vgwGmZT3UCuEx/mWTgA4PQqZt44GK38rJvwV0UxG
 CUIqBBXhltxyTjhWRjyg4LsidjLHGOU=
X-Google-Smtp-Source: ABdhPJzRU2VjstwHQwKIlPfOlHeUQnX7olz54QMtR514+mLmSnyMshzH3uqwOKfdx3vs4l9Yi1/84g==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr894357pgh.309.1593142309227;
 Thu, 25 Jun 2020 20:31:49 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:31:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 02/46] target/arm: Improve masking of SCR RES0 bits
Date: Thu, 25 Jun 2020 20:31:00 -0700
Message-Id: <20200626033144.790098-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
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


