Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F0DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E404B20720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmY1GFkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E404B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxvFW-0008C3-6P
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 12:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jxvEs-0007gD-Dm
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:35:34 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jxvEq-0008WV-P0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:35:34 -0400
Received: by mail-pl1-x642.google.com with SMTP id q17so10480629pls.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yRKeuIb3S/CPSg/9o/b2IVVuDvOtAIxwNSt2XmbJjGk=;
 b=kmY1GFkODvFfHwcjM2PvVQCzV167DYLvpY3uCggrJ363S29/Ptur1r4BJu2/FQwY3O
 QuZAg7obKrLXu/caLR3FkMfo5t+ofCFl9ZfPl9tHhz1c9tQRjMOaTnro8G1gKNxnyxwk
 RqAAv2DPsW3sDtyuLD8TA9T4FoanqvEdPcl8uJNc9aB0l8XURP8rAl0Y833SH6eTggEI
 7ZlQ9ionoo5bGYFkiv+rPWbZzrX1phw35CzpkzBTZrjFqY3Y3zbdJY8+mRjS/PoXQmhq
 PzE/B3CLf0y+Q+yOdyhSm+sFKLRu1kq0SVGk+KwXXDLdfutMAVwIcxDataILHkHmVADq
 rrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yRKeuIb3S/CPSg/9o/b2IVVuDvOtAIxwNSt2XmbJjGk=;
 b=mz8JFCIpTtnfM0lmRsth2hyP8aaZmsMU6jamxShCnNDzuDcLa24/LHqxxh87iADp2G
 NkVPx6A+e8/7FFt7MX4Fj3HeTdYarID4hn30CFf2MbPblwq98FpU4p77SviGJmSzWaUW
 N2gN3wiC1pkOdKfaq/JwHbZiDsEjEq6chRL51CgCYPBspyiY2S6c2p291YEgCm0B+oKK
 ysri+Rk/SeUaoxjkezfyPZyowy/r2jlN9yTMDnz2lZ9ed99KBQ2fnJjTzIn7P9GyHF62
 Tz5ZEiPf/DlvjWRMAbPj6x0n07unnAqqvuvvBNhgxwmTVFSD1KjVodr/N6rpWdYQbQ0V
 kmFA==
X-Gm-Message-State: AOAM530lGPKzktfleHjSMJAngmBwf0i5jb8BOsSUDazqUiT2HobF6AqY
 QLSY8+wUXARf/On/QkuMdBk8wz1iXko=
X-Google-Smtp-Source: ABdhPJyOqSpyFHdhUcIdyyh4RPT+Yd2agLuxg2JAKHFCq3JWbhwvhcmwUx8nHx6illLSHgbM5ur1pw==
X-Received: by 2002:a17:90b:188d:: with SMTP id
 mn13mr5860108pjb.229.1595349330271; 
 Tue, 21 Jul 2020 09:35:30 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id g22sm18527701pgb.82.2020.07.21.09.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 09:35:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] target/arm: Always pass cacheattr in S1_ptw_translate
Date: Tue, 21 Jul 2020 09:35:28 -0700
Message-Id: <20200721163528.80080-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: peter.maydell@linaro.org, Jan Kiszka <jan.kiszka@siemens.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we changed the interface of get_phys_addr_lpae to require
the cacheattr parameter, this spot was missed.  The compiler is
unable to detect the use of NULL vs the nonnull attribute here.

Fixes: 7e98e21c098
Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c69a2baf1d..8ef0fb478f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10204,21 +10204,11 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
         int s2prot;
         int ret;
         ARMCacheAttrs cacheattrs = {};
-        ARMCacheAttrs *pcacheattrs = NULL;
-
-        if (env->cp15.hcr_el2 & HCR_PTW) {
-            /*
-             * PTW means we must fault if this S1 walk touches S2 Device
-             * memory; otherwise we don't care about the attributes and can
-             * save the S2 translation the effort of computing them.
-             */
-            pcacheattrs = &cacheattrs;
-        }
 
         ret = get_phys_addr_lpae(env, addr, MMU_DATA_LOAD, ARMMMUIdx_Stage2,
                                  false,
                                  &s2pa, &txattrs, &s2prot, &s2size, fi,
-                                 pcacheattrs);
+                                 &cacheattrs);
         if (ret) {
             assert(fi->type != ARMFault_None);
             fi->s2addr = addr;
@@ -10226,8 +10216,11 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
             fi->s1ptw = true;
             return ~0;
         }
-        if (pcacheattrs && (pcacheattrs->attrs & 0xf0) == 0) {
-            /* Access was to Device memory: generate Permission fault */
+        if ((env->cp15.hcr_el2 & HCR_PTW) && (cacheattrs.attrs & 0xf0) == 0) {
+            /*
+             * PTW set and S1 walk touched S2 Device memory:
+             * generate Permission fault.
+             */
             fi->type = ARMFault_Permission;
             fi->s2addr = addr;
             fi->stage2 = true;
-- 
2.25.1


