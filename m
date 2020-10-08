Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA398C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B9121789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCT2ewGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B9121789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWyv-0004BN-Um
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrx-0004Bi-O3
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWru-0005yQ-GC
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id d3so6722620wma.4
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kVcdD0KzUJAO3jRrFwWmt99n+ZYoK7ZLoVAUEZINIj4=;
 b=kCT2ewGmGfgub88ar9ltrPiiRo6Jzw4UK4iAJ/zLevuIOlw2RxB7pif8xQt1LUMWho
 YUJ1CY+zriqUVq3z90Ez31xW/VUhhGShgM0fY37sYiZCJxaSMJ7bXzr8U3QrTaYt3Dqv
 djob/hd4fBZxjKuMI1gYza7Hvjw8+EzuBmQG2ANlU0HWnPk0RRSys+MWp3UnbbD/CdtY
 36gof5AW2ZfG7Afv3ldZaYAeflwZ5t2LidDu4NzuavB08l/tnJHbZYLhB4wig9Ju9Dj6
 gcTNVj+tng8hu2Rfr6tJO+s88uEuvxu0uiJKyQ4ecq7rkrLUwaKylnz7r91vMgiZzBJb
 SMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kVcdD0KzUJAO3jRrFwWmt99n+ZYoK7ZLoVAUEZINIj4=;
 b=bOTZ6NIwdEqnpIykDeeZhYHU+OGVgMRYPKfa49OtQfTQg50Q/EHEoY7oG5pwUKH5TS
 yXpzYlEh02TS27M3QkLdlmEUoc1Ex/T9Tm/gJRuTsflLYJQWR6ziGeWD4SVVXkhaCCxf
 VhVMYhGCrBF1W96um0eVqKBmnWs1PvuGoK9OVWRecgksLI/70evzSHEnIyJjKJrcTWNy
 zs+F1djv+W1wznk5VTqR8J7rngoaQibqMGrBMBR1ajxENKAmkbF0Ds+KfSzYzJvlF/fu
 ZpndHv25pRw5HWb63NH6Yk2BHyyftGBDrcB+jdjtAP0eCC0xqdM7KASPAwnErd4rIvFP
 FFhw==
X-Gm-Message-State: AOAM531ZZMMPa2F31bWluyqS2rXsoJV1Llpr617Es8WgHOe6HX3wB/fr
 S2gHEX/VoUxPq6tkD4ayBLUS1lSbjlmlEKtT
X-Google-Smtp-Source: ABdhPJwUKmppUgRKJTfm0XMn2McqTBLyIhTFTmjzmnJLZEXhdygTJ+XqhDRngYysXjoOh/+e28SmIQ==
X-Received: by 2002:a1c:1bd1:: with SMTP id b200mr9521154wmb.171.1602167164754; 
 Thu, 08 Oct 2020 07:26:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] hw/arm/sbsa-ref : allocate IRQs for SMMUv3
Date: Thu,  8 Oct 2020 15:25:49 +0100
Message-Id: <20201008142557.9845-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Graeme Gregory <graeme@nuviainc.com>

Original commit did not allocate IRQs for the SMMUv3 in the irqmap
effectively using irq 0->3 (shared with other devices). Assuming
original intent was to allocate unique IRQs then add an allocation
to the irqmap.

Fixes: e9fdf453240 ("hw/arm: Add arm SBSA reference machine, devices part")
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20201007100732.4103790-3-graeme@nuviainc.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 65e64883b51..01863510d0f 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -133,6 +133,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_SECURE_UART_MM] = 9,
     [SBSA_AHCI] = 10,
     [SBSA_EHCI] = 11,
+    [SBSA_SMMU] = 12, /* ... to 15 */
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
-- 
2.20.1


