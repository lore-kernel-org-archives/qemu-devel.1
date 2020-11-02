Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3155AC388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F323204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKpzIh2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F323204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdSG-0001Hd-8G
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLu-0000z3-IK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:42 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLp-0006aF-K6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:42 -0500
Received: by mail-wr1-x433.google.com with SMTP id n15so15538392wrq.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OEozF0m7quoDCvuv9KYsnQo/7jKMGFoMyuZr94zyBD4=;
 b=HKpzIh2I6fjpdQ1XMY1MCHNOMt/nG1C3XMAXb6rv8aQLxxVn9TkO9kzyELw9cN3dLS
 GaPwXxs52FL4zxet+Kne0yMJSN+1sXWFjbe8XwICsC0bJ/jDBm6wiBxioswobTZNrQxT
 RCCA4hUQ+4Zkea2gUlG0wPbNx7K46HnHobiU2dxJjuE86ceAh2sNS99JczOCwFKBVBDd
 s0wmMKzEHgujwiVSLhkLWEsfu0y+67/yrT2rErq0PLaE32LMSKOQ3Ap+LjL/IMhnjucw
 BGpJlKUIAU+hw8X8BmJu18rp38IyE3uaINY5IcMb8SY2DZ1oPi83+DF29KRaTXEj2P6w
 U4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OEozF0m7quoDCvuv9KYsnQo/7jKMGFoMyuZr94zyBD4=;
 b=cy5ZrK35c/2Ya2IWH7Zh56rRltNLkQNXUEbd+WTfDIdJdfNDGluzwRRmWGPwDbOKuU
 yy+SPRz+ngY1bbz9p5XDO9p1ahHpkxrU8jqcxOp+EfgCrgnVr8MSkxFNDZAUzjwyBrbw
 B0tGPrOjxS7PpJ1cxwS5P4e9atfgOLo0Ry967s1eQbQ2N0cVQiyGdua32437B6ZEra9a
 9NMaAYQyqhzwDTVwoEPA6JCknBsO+uWwfy7WbuCc8j+wrPiXBBrv1geoSymDu7PuIOER
 Y1gh9UyIHZqNQbJ8nznOTa3mwIFQM5oNhH+7x+DGq74aei7pvMngl6vtEB8Xf1TOn0Oj
 r5kQ==
X-Gm-Message-State: AOAM531vE/zgc+jpFUy+jWvooyd67nBOD5vxNFLDnaFr8jFlFPe/ik34
 DiI3b/OpormQC6XRlQ6V/B/6hIG0OQWtuw==
X-Google-Smtp-Source: ABdhPJxR2Zg/J62S0b/+T1Qhng7FsG4npXY6uT9qITyy+9QJ0sWDkE+ynHmcyuMXK1aPxrQOkbxmzQ==
X-Received: by 2002:a5d:67ca:: with SMTP id n10mr21075052wrw.209.1604337034432; 
 Mon, 02 Nov 2020 09:10:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/26] target/arm: fix handling of HCR.FB
Date: Mon,  2 Nov 2020 17:09:53 +0000
Message-Id: <20201102171005.30690-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

HCR should be applied when NS is set, not when it is cleared.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 97bb6b8c01b..dc51175bf05 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -731,13 +731,12 @@ static void tlbimvaa_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
 /*
  * Non-IS variants of TLB operations are upgraded to
- * IS versions if we are at NS EL1 and HCR_EL2.FB is set to
+ * IS versions if we are at EL1 and HCR_EL2.FB is effectively set to
  * force broadcast of these operations.
  */
 static bool tlb_force_broadcast(CPUARMState *env)
 {
-    return (env->cp15.hcr_el2 & HCR_FB) &&
-        arm_current_el(env) == 1 && arm_is_secure_below_el3(env);
+    return arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_FB);
 }
 
 static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.20.1


