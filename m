Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D870C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC87320720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPvCHbLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC87320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04v8-0003F2-VE
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hs-0000Nj-9f
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hr-0002sP-3Z
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:08 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hq-0002r9-TB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:07 -0500
Received: by mail-wm1-x336.google.com with SMTP id t14so2991076wmi.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2ibQFQ8vRdFf6A4S5SdMKP0nibw7kp74YHQp6sWgPGg=;
 b=iPvCHbLOwzHNOwpwlgNBVFcbUWotuQfgLQJ2SLGK5cQLBXZAjrRvsDBkOrtUuyYRuM
 bVc89CAW5LIKwuapjWeZmVftOw6UpxWg7dQWAS4F8AyfgBeNi+Xo1xmPOX76RXdtXRCg
 YRwEA5hJoArrYh+quNForJRyRVDi0Z9EgqsGwLTD1i1p4uEjT7yGsWUjDrMe/OIdYmaH
 ZCvpH3hut4Y7NGU2s4iFzIyMg1JvvePFkyUDjVo19/GM2/OBK44aQTB6mnQ19Sen5f3q
 8+FU5Nk9BmezlPhrDEmWPUST8xPiUqlcH+VpmBrrVqRF2b+ScXcL5/R5S6SP2D4tq2nQ
 CrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ibQFQ8vRdFf6A4S5SdMKP0nibw7kp74YHQp6sWgPGg=;
 b=MTcRnecqXWNlJ+e+4MuxgZk273Apj/PgYPe8gi0cykGh5lgxBJCr6VuPi399FyHESq
 aF0Rla+hm8Cqr8RvaTV1mRx5iOHa68xhwaDGgTJM76HxkKCJ8sno59GXBGBiXG5JOgqS
 09Ix6xCMlpdD4D2z8L5Sy8+ZqdGhJDKMSV6eooFKTzdnVX+Tjkrny3wxyRLdFtiGM15q
 9N5D+Wq7p1LZhncE9W0TSJWt5uCOluz+75pdCoM18M80BU2QXF/j/HO7Eli7i0RxaQkI
 ZLcXlBLxrNj8j7vFpToLnr5stKzdifzARSYJsUotqnVFcxlR9+JAfqPwnq4mCZuoxdY/
 4Gww==
X-Gm-Message-State: APjAAAU/acMEwdlhxmVuDeMmhE+B02kTWelrbNOmIjhj9bs7+ATHjZLW
 nPXSUpmHa6EBWoqgrz7qvs6RTcMTRGg=
X-Google-Smtp-Source: APXvYqwcnciNrvoPQ1oJ/mgcj7UQV3KEysLMOsnkqAZD7wiQGoTHriaZHpbHwrmKQUZHxpYZl+QHuA==
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr4732506wme.25.1581086045714; 
 Fri, 07 Feb 2020 06:34:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/48] target/arm: Tidy ARMMMUIdx m-profile definitions
Date: Fri,  7 Feb 2020 14:33:14 +0000
Message-Id: <20200207143343.30322-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

Replace the magic numbers with the relevant ARM_MMU_IDX_M_* constants.
Keep the definitions short by referencing previous symbols.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index aa121cd9d0a..ad92873943f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2912,14 +2912,14 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_SE10_0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE10_1 = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
-    ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MPrivNegPri = 3 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSUser = 4 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSPriv = 5 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSUserNegPri = 6 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSPrivNegPri = 7 | ARM_MMU_IDX_M,
+    ARMMMUIdx_MUser = ARM_MMU_IDX_M,
+    ARMMMUIdx_MPriv = ARM_MMU_IDX_M | ARM_MMU_IDX_M_PRIV,
+    ARMMMUIdx_MUserNegPri = ARMMMUIdx_MUser | ARM_MMU_IDX_M_NEGPRI,
+    ARMMMUIdx_MPrivNegPri = ARMMMUIdx_MPriv | ARM_MMU_IDX_M_NEGPRI,
+    ARMMMUIdx_MSUser = ARMMMUIdx_MUser | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSPriv = ARMMMUIdx_MPriv | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSUserNegPri = ARMMMUIdx_MUserNegPri | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSPrivNegPri = ARMMMUIdx_MPrivNegPri | ARM_MMU_IDX_M_S,
     /* Indexes below here don't have TLBs and are used only for AT system
      * instructions or for the first stage of an S12 page table walk.
      */
-- 
2.20.1


