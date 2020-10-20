Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C97C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CC222249
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAHf7kFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CC222249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuG6-00083Z-7b
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0v-0004sR-LF
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:29 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0t-0003uF-Pw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:29 -0400
Received: by mail-wm1-x344.google.com with SMTP id e2so2518360wme.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YrWpQQEYvZIHm9mkqIONBrLjRZ1+eXAY+UxoL4kTIS0=;
 b=yAHf7kFlaxIEgwDyjWOgdm/yGabp+ZT9/9GbzRDVYx01XXC0AXwR0+865VuhP6IldK
 TCXCuHWqE0Dsx0zxgkaF6n6nx/l+li9utrFqkP5a3dWyTMX/1Ns8lYYMVk73qXjtg5qA
 +iFlG5Y9S5/Km6RkzGiqpI89UgmFgzxrGHGQscVgui6KnHIdkStBOgFx1uQn2zY7KxGS
 J8otvZlwKXRBcmKNJ3Wr7XsgkedcJNaqn0JHPSzkiwFHn2v6Djv9B2j5kKyneHQl552R
 6/YT9N443RjT9j/nN1dUIXQKj9FwUF9wZlpNmgvB5pF5v04a+dCoWcT8gzzwpQftoJTI
 QO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YrWpQQEYvZIHm9mkqIONBrLjRZ1+eXAY+UxoL4kTIS0=;
 b=C1GoWHXv6zg6AIdbK4v3G9etyJHBwpjIwKyTaWqgax6uDPldOzPdMr1hkitTfrWWcl
 ud3vzcbjaHi18gOxuqwdfQAoHjiJ0pGGp15fpRriViPLQQ3NIxmyIaQ5eiwmo80MEJnH
 yLZwkh/0bL4RaLKZsPw1wLXS5U4oNGbHKHnKDPtbKXR3gwEUb74/hM2fR2gb2t8eOLyx
 JAx09qS4DCutgt0GZXm0QbX16ueKjLBW0lAq0cL6Dbu1ZZgC2hLZBNkM4lCZrRSnm0gh
 9hutQy2ap81gN+d3DL++VHy6SvOUaWxzNO+s5HBOMxe1AmwlmVMvL1GlUMwpozS49bSs
 YcYw==
X-Gm-Message-State: AOAM533877U9x6GGnZlRsbGpKBqFeQjF1/ynM2Tveccq8xFQMR/4FB4S
 48cvIFfAG0MbIkdailRmU+dcO2vQt5wiXg==
X-Google-Smtp-Source: ABdhPJx+unsmbc1nmgY6rJINK0BVCSiptlORu1RNkYIwzv7ZjyPzGkjPCOqt/sXcyDRT8m0jCFX4GQ==
X-Received: by 2002:a7b:c741:: with SMTP id w1mr3705675wmk.67.1603209446053;
 Tue, 20 Oct 2020 08:57:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/41] target/arm: Fix reported EL for mte_check_fail
Date: Tue, 20 Oct 2020 16:56:31 +0100
Message-Id: <20201020155656.8045-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

The reporting in AArch64.TagCheckFail only depends on PSTATE.EL,
and not the AccType of the operation.  There are two guest
visible problems that affect LDTR and STTR because of this:

(1) Selecting TCF0 vs TCF1 to decide on reporting,
(2) Report "data abort same el" not "data abort lower el".

Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-id: 20201008162155.161886-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/mte_helper.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 734cc5ca675..153bd1e9df8 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -525,14 +525,10 @@ static void mte_check_fail(CPUARMState *env, uint32_t desc,
     reg_el = regime_el(env, arm_mmu_idx);
     sctlr = env->cp15.sctlr_el[reg_el];
 
-    switch (arm_mmu_idx) {
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E20_0:
-        el = 0;
+    el = arm_current_el(env);
+    if (el == 0) {
         tcf = extract64(sctlr, 38, 2);
-        break;
-    default:
-        el = reg_el;
+    } else {
         tcf = extract64(sctlr, 40, 2);
     }
 
-- 
2.20.1


