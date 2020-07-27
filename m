Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD83C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6F92053B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4Jcadsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6F92053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04yh-0007gB-5Y
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uZ-0001Yd-3P
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uX-0001M6-ED
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:30 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so15311899wrw.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=R9nya5qllTCM3YMYSzF0QauvCLw6C0mO2StmL8/Bb3Y=;
 b=D4JcadsbbjMe67R37gKM0i6ccbHQ/Y5Mf+30LKl2kG7E65l1GzPHTSAH61jm13hZxW
 jZ3lkYJqTNfsJqBVVW30gtpVbHgbL3l350QNjUK1DtHESCIetQ+bSinW1Y3EpnFEUoJD
 1LJsr60/4cxe5mXajCgOy5px3QaLgr3JR0EiKJ/iq5zkyhGcbs7MFOcqB7UF3QIaU4mr
 JR5v5LEJ9S7MwzgKqQ7jTX3cMmxPXXf4xXpYDEOEkbzIDf2vk5HQ9Z+N0XKhl+yGqijP
 +nmGmULZWlHmg+yxKM8mZ9k7b3r5Cad/0lxa1/fprn7Ls4/BVIEK5BZt6oimTryzxBFq
 5uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R9nya5qllTCM3YMYSzF0QauvCLw6C0mO2StmL8/Bb3Y=;
 b=I68+eyrwN1/5voKWBzCulcGhTVZJRVmN6nLTwk1WplifJViSdOvYoTLlNYvEoPWayZ
 BhFBcKW+owQRPrGY8eGOBq5pTxJoe7xyDhS2HJzHJgrUICaF0JXL73hMWYT3vk9rsNiJ
 4MogZsDgFntW79GO0SzdBs85BLMUIEAxdp0xrlqMFmM71sGyOcKDhg/ghBep8oXov+mF
 yQdYa0N8i1uH+vGkM324cL9K8T3NoKmqcJ3aGy6x2NH+h1y6rYVlKYFUVKT39I70g9za
 n+14HmcY+kGQEXqizI9q8W5Ozhyh8RcppvF/iEyPbm6bVB2APLODNjk+ppZ8BVz1Kd8H
 QYFg==
X-Gm-Message-State: AOAM532jxgpUgPMP7yq5lpeup9OhR/Rs8O7NPMQwzx0bkdukFLrNzMwn
 oh/yFJSTU1easkUP7D229xBLkZB9o1EbjA==
X-Google-Smtp-Source: ABdhPJz7k1KZYdY/+EBfD1qzAgwexagrf+4/T0hQ+05mZelWjRn3pA1RWAUSguBExattBgoc+0PbtA==
X-Received: by 2002:adf:de09:: with SMTP id b9mr8154842wrm.409.1595863167650; 
 Mon, 27 Jul 2020 08:19:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h199sm18744996wme.42.2020.07.27.08.19.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 08:19:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] target/arm: Always pass cacheattr in S1_ptw_translate
Date: Mon, 27 Jul 2020 16:19:16 +0100
Message-Id: <20200727151920.19150-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727151920.19150-1-peter.maydell@linaro.org>
References: <20200727151920.19150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

When we changed the interface of get_phys_addr_lpae to require
the cacheattr parameter, this spot was missed.  The compiler is
unable to detect the use of NULL vs the nonnull attribute here.

Fixes: 7e98e21c098
Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Jan Kiszka <jan.kiskza@siemens.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c69a2baf1d3..8ef0fb478f4 100644
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
2.20.1


