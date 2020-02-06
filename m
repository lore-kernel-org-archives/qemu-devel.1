Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB5C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138AE206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqYfdw01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138AE206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf1A-0002Mp-61
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoa-0003Qm-7X
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoY-0008B5-BX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:20 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoY-00087F-4k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:18 -0500
Received: by mail-wm1-x343.google.com with SMTP id p9so5801155wmc.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/jp9dPIEO5yqK2062Mzo5TQr68i8UpmoWEFzQZre7b0=;
 b=mqYfdw01a3mdSuMszDjuc6Nd9TxbXSk0f65YWjFQwIat6B2cOVuQtEb4/k2Peiv8n0
 J7/vUy1LX+Px20o4LdCsRnsvnkd02vSYhVxZUdiklNWVG2u4VBsSoFvE3mpL8Qf4CrfT
 Z+p7AvFnmpmHcAUzwrPJVFf/Rw5uOvIPTrXm66ot41tRBXwYLOOAPpKaURBUZsHHYxHO
 2208x2HwqYnejwnkWwllbnoUgXF4thuD08/BsJ0GaI0K2Kj+T9ly5y21d9iWMbB3VAhV
 h35E7nGi2sa5o+YejBLSWHWLV2Abil42aPFvHd5CwnH/bTqfnxm9Wgkvw9cZlbAxMD6r
 no4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/jp9dPIEO5yqK2062Mzo5TQr68i8UpmoWEFzQZre7b0=;
 b=H6wXo9VvEYNcAks0INePeshWcYCAVsDnrhjHkrYm3hRTsxkmtoS+7kAihc+k4uUjTl
 mrxtuWOFgpu0iZEA5DRbIuezm0gaHNIbgT3csKJe7sihPnHDgGT+xVI0YRsD25dAVsl2
 r6eSlCC5YH7SGtOuTtCsESgV8VF5NxRkGlTVH1i6M7pNVKZn/5A2YfuKCRHeNvuQmPZI
 sF75lf3UAeybwcW2wI7CiLFGok9lgjidSVxP8Nzfxa+0CyD9jCbS9W85nuzHGaAHeNpL
 llv13IllqBrWMu7kgNoim4OW1pFcp6CMUYtkFdJOApMAvNvzBlR01LIwQqpHbO44cUxP
 ocDA==
X-Gm-Message-State: APjAAAXsevhx39SoA5Wn5IWbOTzBgPVorzl71kY92d2Ye5Ze98zyXloQ
 NA/mb4mgyGUPFzCqrs27TMYhaTxpCuFy3Q==
X-Google-Smtp-Source: APXvYqwCrjr4jlZ64LBPEUqHPdOVi8xts/vFBx7QI0kHrHJ6dvlKa9xWP/UIpNWJ3G13wqN8dYPIXQ==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr3748845wme.64.1580986516933; 
 Thu, 06 Feb 2020 02:55:16 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 32/41] target/arm: Update arm_phys_excp_target_el for TGE
Date: Thu,  6 Feb 2020 10:54:39 +0000
Message-Id: <20200206105448.4726-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TGE bit routes all asynchronous exceptions to EL2.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3b7b459314..56a62b11d0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8446,6 +8446,12 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
         break;
     };
 
+    /*
+     * For these purposes, TGE and AMO/IMO/FMO both force the
+     * interrupt to EL2.  Fold TGE into the bit extracted above.
+     */
+    hcr |= (hcr_el2 & HCR_TGE) != 0;
+
     /* Perform a table-lookup for the target EL given the current state */
     target_el = target_el_table[is64][scr][rw][hcr][secure][cur_el];
 
-- 
2.20.1


