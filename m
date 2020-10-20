Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3617C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B7A21741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVk0pXBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B7A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuD6-0004Mb-24
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0u-0004pL-Iv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:28 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0s-0003u2-OP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:28 -0400
Received: by mail-wm1-x342.google.com with SMTP id d3so2505672wma.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3DOt0L/FWDsEDahIMvaggmBdwk9GrrLY6As/3hpqnqg=;
 b=nVk0pXBGBImtakvLTzo/t2hY05/ucoSTfUGEtHXF1oeyZ9bieTnk+NKyqOWpfJG4Kr
 9eFZJdJoyH2UvwgiyaOrdkcrc667q1h/RANQ9vf/TxOsUpioN9J+VMH0wG2iQMjM96Pz
 iyV3rWjtcjlR24I0435qDUur9MCPunX51Lvgp/H1UpSCbbUKXTVnwgPz4oOps0Rr3HV9
 GmCNnBsden/6ubydHF31pWMeFYTfE7u39AI0TGP3qLFlerSA46ukHGqxdIX47XVobwy9
 cTgSjl1X+PwNqWTV/+w4kUsk+S3dDfdsRWXr+LYiBybGK6MOeom2H02ckxyfkkpcvRXe
 Tv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3DOt0L/FWDsEDahIMvaggmBdwk9GrrLY6As/3hpqnqg=;
 b=e999erS4w1u6J4G+e0njK4Ucx/C8u65ONmQteYGc/bLIvtgcy2mEypY16guwZg5aDd
 Lw2KrbKTTgWgzPcYlhuAPjmUGXaRLz3k7nwZWUb4EMnN0vACH7ZAR5TuuMTNuu580MJg
 xtam10WdV+tT6nthEmUmIqsY7+9rfWONRJQHvGfIjoc2RY3fWz8PlB0MPtAq7ZPmK0VF
 f2BEtuhq6OUE4k9nMFIaDZX21Phw5OIPz1kP2ACdAWG8Y7rYtMXfHQwbcNVD/MnR7I0J
 7z63KjLhfcB2a8Ek8l5S9g9K10ymFG6saDxCFEN2BESqrb7X6UDo8C9f5wL7pGWyiuBb
 hiOg==
X-Gm-Message-State: AOAM532MnKFoyRwgKl8mvPJ94owSn7cjl8mge+XVrM6dM1nQarjkCYox
 o085HT9gXd2wmEamAJsvs8TVuvO1owf8dg==
X-Google-Smtp-Source: ABdhPJzGCyh8O0+5A5R763WRXTjvCYpMaY4jMhbEls1wWIhN7g33oC2OrFr/xgpnFY+3XTShE2vIHA==
X-Received: by 2002:a05:600c:210f:: with SMTP id
 u15mr3799312wml.53.1603209444999; 
 Tue, 20 Oct 2020 08:57:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/41] target/arm: Remove redundant mmu_idx lookup
Date: Tue, 20 Oct 2020 16:56:30 +0100
Message-Id: <20201020155656.8045-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

We already have the full ARMMMUIdx as computed from the
function parameter.

For the purpose of regime_has_2_ranges, we can ignore any
difference between AccType_Normal and AccType_Unpriv, which
would be the only difference between the passed mmu_idx
and arm_mmu_idx_el.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-id: 20201008162155.161886-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/mte_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 5615c6706cb..734cc5ca675 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -563,8 +563,7 @@ static void mte_check_fail(CPUARMState *env, uint32_t desc,
 
     case 2:
         /* Tag check fail causes asynchronous flag set.  */
-        mmu_idx = arm_mmu_idx_el(env, el);
-        if (regime_has_2_ranges(mmu_idx)) {
+        if (regime_has_2_ranges(arm_mmu_idx)) {
             select = extract64(dirty_ptr, 55, 1);
         } else {
             select = 0;
-- 
2.20.1


