Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858F3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CCE21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5zlf7qR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CCE21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pNv-0003fj-CL
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKt-0006af-7n
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKs-0007XY-B0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:35 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8pKs-0007XC-5w
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:34 -0500
Received: by mail-pj1-x1044.google.com with SMTP id o2so103952pjp.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SmyuQTNOfGklwQG6G7fcasvxH7i/TWvMZQATgc7JYwI=;
 b=E5zlf7qRFUNGm3M6JUSO6MuqSa1+o82//RPtACzUuRGMfuZRUdAgDjWO6A7Yj/M5Fy
 aDA7br2lBM9O2I5cOS8eK93fwtjc7WAaSMIzhMqsjXo3rTcWRpC7EMpx9hGXR6jIcJV6
 H0FSDPHAJKVhYMb2djE9OrxuEVWiOPrxCELpxJSW+JV95dRPE4T2TfZNvzEoPUB/eCOB
 4RzwzreuFzaoraSP+7NLi4eSFrZEhX1/0EfKX61v5mKLg4qw6xkeXigX8NRq3V0kKGTN
 mV6D76TKRPxShHToU9d5rjyi8mEwwyFImSfVvAnzBZJv39HPtKRUnwleNzWZYJB6iFvN
 AUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SmyuQTNOfGklwQG6G7fcasvxH7i/TWvMZQATgc7JYwI=;
 b=IfGzUQvY6EQoTYHNWQxqBZMS0QzRj/DTNXAOxBZs+PZZyGoeBSBtqqI7M8sDnFAJUB
 z4h9OdX7y3RZU+5MAmSCdb2VWGexDp+8fndP7NnU8DEdmNgS296hMA4MSTU5lyHN4T6M
 V4FZwPr/K5CcW84wIC5TQnIwNJLfQ1U6pnQv2CgW6R7miIygyOG+f7laxfnrI6xQ06ER
 pNfGRwLRAquZVKipqh2q5K1JHU39nrBbxcQRX/9TugfeE7Hpw7mvz1WbESrL72QULeVI
 0y8g4JzF6acPIMPW5BObpjBrClYaTHJofXiX4O30eQ1r42izFhF+b6/S1QnZN3qaAxxQ
 1IBQ==
X-Gm-Message-State: ANhLgQ0j8idw2aqddX/QSxcbL9Fw8r9dd9WdqS/M1DHFgYsRqCLR0nsb
 VFidcrb/VmfkDA/QHLIelCGgEwGyiMo=
X-Google-Smtp-Source: ADFU+vscfNivff/dxL6t9Y8wVfS1/QblkawbdW+R1cJTDiFOZuQFNLsj1eEWAnYbjiNxNvseeo6zIQ==
X-Received: by 2002:a17:90a:6545:: with SMTP id f5mr130697pjs.42.1583171912913; 
 Mon, 02 Mar 2020 09:58:32 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id s18sm99510pjp.24.2020.03.02.09.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:58:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] target/arm: Replicate TBI/TBID bits for single range
 regimes
Date: Mon,  2 Mar 2020 09:58:21 -0800
Message-Id: <20200302175829.2183-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302175829.2183-1-richard.henderson@linaro.org>
References: <20200302175829.2183-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replicate the single TBI bit from TCR_EL2 and TCR_EL3 so that
we can unconditionally use pointer bit 55 to index into our
composite TBI1:TBI0 field.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6be9ffa09e..37ffe06c05 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10316,7 +10316,8 @@ static int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx)
     } else if (mmu_idx == ARMMMUIdx_Stage2) {
         return 0; /* VTCR_EL2 */
     } else {
-        return extract32(tcr, 20, 1);
+        /* Replicate the single TBI bit so we always have 2 bits.  */
+        return extract32(tcr, 20, 1) * 3;
     }
 }
 
@@ -10327,7 +10328,8 @@ static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
     } else if (mmu_idx == ARMMMUIdx_Stage2) {
         return 0; /* VTCR_EL2 */
     } else {
-        return extract32(tcr, 29, 1);
+        /* Replicate the single TBID bit so we always have 2 bits.  */
+        return extract32(tcr, 29, 1) * 3;
     }
 }
 
-- 
2.20.1


