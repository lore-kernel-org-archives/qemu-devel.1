Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39064C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AECF21D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wye5DEjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AECF21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYjt-0006ic-JS
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQYgL-0002Wk-Pv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:22:17 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQYgC-0007e3-W5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:22:17 -0400
Received: by mail-ot1-x341.google.com with SMTP id q21so5999940ota.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=siDQkbvJh9Bvpko0a5lV9YTIkAumZtHw2Xcw/++VZdY=;
 b=Wye5DEjHWxQHtc/xyy4JqjU0Jj/GF+1CrQloR02V1GTG4c/t8gNQqdXxBJwSVgW3Nq
 9Jubj0jphT3qdYuPh2t0kJA0SeRHDZMHqkxd8Y0PZN33xV+FIdJ8j3kYq0H0+gZEE0TF
 cm2AI5VBuACe1OWLCqBLYu8YR3FKYTEtSIyCDpO45klC+gB9fhM4Sg3gnIlpUmSuBdQx
 AM2LKgjyCuIpCU9ca8vDQvWrZaTehsZOMBvRO5lVuGrIY/B7cx4rtWe1mdPB122a7dGf
 i9lyREBIJfUy4EfTRrC6zggXbW9ybd5UWSBmOGti1/GduE1FQz9Gcdmc8voz1A9ZZ+TO
 0Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=siDQkbvJh9Bvpko0a5lV9YTIkAumZtHw2Xcw/++VZdY=;
 b=DmhmXmeht5Oif8Ok/WHuI0/9D5KrMQSvYHs65F5d13QaCY6kypRBsc3OGM1ENQHJcv
 krJBqCJjF63qU+YYJ0zy+qvn7hdhoZAUctJw9p40+sdVTN/BPeRviTWNsfXVbqVf1mX4
 HPZO93Arvi3tSBdtbn9TRHc3cag8QTc5101myyizGG6eWE/3LpuUSOPV3Cxdtw/+QTKU
 rx2uPrm75BryvbO60xRIeXppdPlYhqhA4sixl5T6B2o+Ybbgfs4dOO98XOqoHmlPEUUQ
 zdMp9+3kHAVRLhs+m3D3qEd5QlsbFG8NT/Zc4ZU5y/rktv7dt48tloUl/eZnkNI4t0JV
 cUGQ==
X-Gm-Message-State: AOAM533CFhm2VJAOPbqY+eq9zLULOER+1WaUS3EwklBqSDy1m8iPux5s
 tkBtVpJUNc1u7t81ruU27GJ4ZnynaAJmdrZU
X-Google-Smtp-Source: ABdhPJwaMIc4XJkw5ujvlIY4ORtvV1HrNmIFf/xfNfOQNNvrovZjYJYQ17iVQMaRJc41wQKnZeT6rg==
X-Received: by 2002:a9d:2a83:: with SMTP id e3mr5346596otb.237.1602174119678; 
 Thu, 08 Oct 2020 09:21:59 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id l138sm5076218oih.32.2020.10.08.09.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 09:21:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/arm: Remove redundant mmu_idx lookup
Date: Thu,  8 Oct 2020 11:21:53 -0500
Message-Id: <20201008162155.161886-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008162155.161886-1-richard.henderson@linaro.org>
References: <20201008162155.161886-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, vincenzo.frascino@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already have the full ARMMMUIdx as computed from the
function parameter.

For the purpose of regime_has_2_ranges, we can ignore any
difference between AccType_Normal and AccType_Unpriv, which
would be the only difference between the passed mmu_idx
and arm_mmu_idx_el.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 5615c6706c..734cc5ca67 100644
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
2.25.1


