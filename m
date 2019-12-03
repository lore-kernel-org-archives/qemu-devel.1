Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47743C43215
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C0320674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Izp9v5Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C0320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyKC-0006ja-04
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxL-0003Pq-Ve
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxK-0000Ee-Ll
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:27 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxJ-0000Ax-QZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:25 -0500
Received: by mail-pg1-x544.google.com with SMTP id x7so856475pgl.11
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aoqGCvUwZ9zHGUr/7mZ7wYeC4xbBuuKrf6uyPIypdjI=;
 b=Izp9v5MlBqNtp4jro4gtAVYir3ZfPGQ7CqdwA/DVFQh/A9OCBHyhXS/GkWvIZ6rBq7
 3iMrAr3L9Kt8WS8hZlNAT9J2ToCIQp0YRpXezQ1jaZUYD10r29jD9eQr9QX8yjP5cCDD
 8+vVHESEjAflzEIs1A+0uncLKA/Zp7PY71j6zraqQmUY7GDmc2elmEJn2QfF0+ycRLED
 px/jkgc8yN8LINZnwqefUTInLs/kd8yRHExadVXzeWj6ind0APPsVyuLZ7aAo7/Ja73E
 LfMYd7um6YMHFD3t4Im9IfytlejVGqkSrmI0TNgjogWnD+0Fq/8jiRc/21RHpVq5pm8w
 qCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aoqGCvUwZ9zHGUr/7mZ7wYeC4xbBuuKrf6uyPIypdjI=;
 b=kvttemMCigLS3mOToGv36GUM0HjHWXC5RJzmtaom/iVzkISJc4mN8VjEReUeHGG/57
 3UOUcOng2rjB231pHgA0KflihI+Rn8zGCi4yiCDZATPAnN/JmSK0Q5pN1xPiLRxEhg8b
 5PSOVO+q8fN6xRTyURAwlr8xlR13HJJIF1bX6y3Ktz5TAq2yEi402v2kt4MLHJRsMNc/
 S5/ZM6EQomXG1sswiMOJ/+51ZNwxivp7XYQHV+pF1Lnul0Yn4z9mSNUuQgDy/YpTDh2g
 jgBCGoKS0vm3cTxf0ZeAAw/qCXvFaLA5GnwiYpMle5z/b50sTG8c364YAlyOD1I9Xf6r
 Y1XQ==
X-Gm-Message-State: APjAAAWk4o9sKzQTZa1wuAicMgMdFt5maFuIPxcaXe3hlFoeWu6tFgzp
 V+0Dg4YyngmmcTC1WiK7uUPFE/2Nnyk=
X-Google-Smtp-Source: APXvYqxDv/43y80Y2xLYUJ9y+W9is+dy3GkSYsuaLDDW1yvFQFQ1cQdzf/vKCHB1WxBl+LcMlkHf/Q==
X-Received: by 2002:a62:1b4b:: with SMTP id b72mr2330826pfb.96.1575340224106; 
 Mon, 02 Dec 2019 18:30:24 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 35/40] target/arm: Update arm_cpu_do_interrupt_aarch64 for
 VHE
Date: Mon,  2 Dec 2019 18:29:32 -0800
Message-Id: <20191203022937.1474-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When VHE is enabled, we need to take the aa32-ness of EL0
from PSTATE not HCR_EL2, which is controlling EL1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f2d18bd51a..f3785d5ad6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8887,14 +8887,19 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * immediately lower than the target level is using AArch32 or AArch64
          */
         bool is_aa64;
+        uint64_t hcr;
 
         switch (new_el) {
         case 3:
             is_aa64 = (env->cp15.scr_el3 & SCR_RW) != 0;
             break;
         case 2:
-            is_aa64 = (env->cp15.hcr_el2 & HCR_RW) != 0;
-            break;
+            hcr = arm_hcr_el2_eff(env);
+            if ((hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+                is_aa64 = (hcr & HCR_RW) != 0;
+                break;
+            }
+            /* fall through */
         case 1:
             is_aa64 = is_a64(env);
             break;
-- 
2.17.1


