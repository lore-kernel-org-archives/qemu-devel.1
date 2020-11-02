Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECCDC388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0F121D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6AK/ZU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0F121D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdTA-0002ct-Fq
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLu-0000yB-6g
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:42 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLr-0006at-JG
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id 33so4707934wrl.7
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=oS0wIyEvl6kAmgjQUcastyFGaftesb6oVP+8lJQGRmA=;
 b=w6AK/ZU8E7lFeVE63BSJIzdZKFOLZf2Ex4ohEHQW3gUvWDN8Jvzh+EPSfjf9cBpLz7
 KpNXTunV+/oY/ijxmkdP94ApH1c3tJxv7OX9y2lo6mI6Q5LTKuAWRxitVZtt35BlHp2L
 LPMiIUmVctrRK7UO/r+mWZ5RwnLgpC09dHMkPxd7K+SSGEFtV63iHFmkHk30dL0SYQRB
 Jd0oFNdY3FM+/oMlzSLnCu4bMjYZlQpMKlZ3hK6uE0gtirSOJUZHMZpUfx9HVXzulTjW
 9Y+fSpe8Dib/mfMlL+Wcnd+yna5n5HqO6cTUK8cYP1oKP9AInJuVdKoPgTYndsUin0oD
 YwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oS0wIyEvl6kAmgjQUcastyFGaftesb6oVP+8lJQGRmA=;
 b=s8iYz+9ku2DyjGtr5p3ExAq/EMVHl48habJ5ea6yjqE3mBj5dRz6eF6RGJfqY6Oz6v
 Y5qfMgcyhc8m6LpVMH/x4wfNfi8/e/2FlO8m3jhSR/tc3Hx0YyisPJjzB1khR3yZUkrO
 /oDySyEM0BO8pRvMsqEGUmKKvKblsg2q7ZpzXfHrPt0tQnPbkYhcG63HiAn9g6TxW18k
 Et92Z4WX/WQc+Jor8IXPWWzgNXZOtujyypLQNGdzAltK5j/VP7HloKjKBGIEmUs5HM7D
 IdVC/ZIiIviXZXNUYnEJGVuzUCGx3Fdoyp4KwjDzr3DUdub3T/4ZdFoJF+xCjGApXn8k
 Wlbg==
X-Gm-Message-State: AOAM533gFkBS15AlyJcxSsKnejb/YdBeZq651Q8QVSK+F4qtzKhiPDq9
 iJyi7wATrBRInE8bZWliFhhY4/9pjE+Ssg==
X-Google-Smtp-Source: ABdhPJygreadJKuXOtZlJ9IkLEy6vxp5T8fWRWMRk4Sox4ohPl2vJZrjN+Klwr5VDEyID+poTYfwfA==
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr20633953wrg.335.1604337035495; 
 Mon, 02 Nov 2020 09:10:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/26] target/arm: fix LORID_EL1 access check
Date: Mon,  2 Nov 2020 17:09:54 +0000
Message-Id: <20201102171005.30690-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>

Secure mode is not exempted from checking SCR_EL3.TLOR, and in the
future HCR_EL2.TLOR when S-EL2 is enabled.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc51175bf05..68545919865 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6679,9 +6679,10 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 #endif
 
 /* Shared logic between LORID and the rest of the LOR* registers.
- * Secure state has already been delt with.
+ * Secure state exclusion has already been dealt with.
  */
-static CPAccessResult access_lor_ns(CPUARMState *env)
+static CPAccessResult access_lor_ns(CPUARMState *env,
+                                    const ARMCPRegInfo *ri, bool isread)
 {
     int el = arm_current_el(env);
 
@@ -6694,16 +6695,6 @@ static CPAccessResult access_lor_ns(CPUARMState *env)
     return CP_ACCESS_OK;
 }
 
-static CPAccessResult access_lorid(CPUARMState *env, const ARMCPRegInfo *ri,
-                                   bool isread)
-{
-    if (arm_is_secure_below_el3(env)) {
-        /* Access ok in secure mode.  */
-        return CP_ACCESS_OK;
-    }
-    return access_lor_ns(env);
-}
-
 static CPAccessResult access_lor_other(CPUARMState *env,
                                        const ARMCPRegInfo *ri, bool isread)
 {
@@ -6711,7 +6702,7 @@ static CPAccessResult access_lor_other(CPUARMState *env,
         /* Access denied in secure mode.  */
         return CP_ACCESS_TRAP;
     }
-    return access_lor_ns(env);
+    return access_lor_ns(env, ri, isread);
 }
 
 /*
@@ -6738,7 +6729,7 @@ static const ARMCPRegInfo lor_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
-      .access = PL1_R, .accessfn = access_lorid,
+      .access = PL1_R, .accessfn = access_lor_ns,
       .type = ARM_CP_CONST, .resetvalue = 0 },
     REGINFO_SENTINEL
 };
-- 
2.20.1


