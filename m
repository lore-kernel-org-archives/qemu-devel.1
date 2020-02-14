Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017A9C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C489522314
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mn3JnS8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C489522314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fWd-0006Nj-W0
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVP-0004LF-Es
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVO-00006p-EG
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:59 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVO-00006X-8s
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:58 -0500
Received: by mail-pg1-x541.google.com with SMTP id 6so5358938pgk.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bFodYZjZFzCVB6GfD5JV/0vM0v0zus5xTQluYRgEuVA=;
 b=mn3JnS8Jvr4MDWK75x/kpAf+V1CcrWOmtB8fH9hTWJDDutpUIdanPEueHvcfjp8xWC
 UDtDMGKyC3jkuHnsuJKxYdK6yBkhQzwwrL4ABIqP4I65X0vOjoeLVg/mWF5gllcQQl+3
 rIl2Re3huWwrV5d3Wpi0q2FeRWX/IVMAsk0NS1ViyETsYI1isb8D94TlexzfNK6xLP6S
 mfcMwIOMO+Bye+yvxxPm0mb1jbtfzlLU2EoTg8jqxPw2RpzfLZlZEqVctCgw8vugy4ee
 F/FczYcXN5yy4OUKkCZsyaDxmc9D9QqqpZRt44/CPrVix0Lekh3LRwBUmuFJ2FLIDBiY
 PteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bFodYZjZFzCVB6GfD5JV/0vM0v0zus5xTQluYRgEuVA=;
 b=RgsOpeTxZ7qODK/3u4EdtrO/Ru8MuZZkR00O634QgugcoLqqK01sXzk7dGDzKz82o4
 hvdQHdGwYxbhZSRyFsHL0A8wgJKcl9tN5ZKkK8/DNG0fUKt9UFWC0qnDnuWRWG8cEDTZ
 aKVQbOUQ6XGY1RwMuD7BfOdQ62ahJbdRqc2vG3Z3vsumeDXSQkDwUfQffWNGTgGAK701
 QGqXzRhonnmwh0u2roQnz/6aqD8Lc8l/V9bEmR2OHIzvEBRv1vskD0Tvj/+vSqy2hZQw
 Y595+qsp1ylw4Pq4lk4oK0F8Zf7wfd1RFmjkx9g4WodSmX06Rk+SHhv8fkRk/bakwe2k
 aWbQ==
X-Gm-Message-State: APjAAAVM1K/xoFlZ1jJoW1HrtrU1P98RV++2nMhs2zCf+Gig3wiBdoMq
 QrVCPpqQN3ihLvjWELulsIxKoBDtYTI=
X-Google-Smtp-Source: APXvYqwJbdQcs2Grf6oVy4T2qW9FmJj6kuzceV5HdALmuzVrfJ5m4L6O9wUUKecZu0cegUijVE2tzQ==
X-Received: by 2002:a63:4525:: with SMTP id s37mr4756791pga.418.1581704157012; 
 Fri, 14 Feb 2020 10:15:57 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:15:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/19] target/arm: Add isar_feature_aa32_{fpsp_v2, fpsp_v3,
 fpdp_v3}
Date: Fri, 14 Feb 2020 10:15:35 -0800
Message-Id: <20200214181547.21408-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will shortly use these to test for VFPv2 and VFPv3
in different situations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5f08cbd2d8..4ff28418df 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3429,12 +3429,30 @@ static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
 }
 
+static inline bool isar_feature_aa32_fpsp_v2(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports single precision floating point, VFPv2 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) > 0;
+}
+
+static inline bool isar_feature_aa32_fpsp_v3(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports single precision floating point, VFPv3 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) >= 2;
+}
+
 static inline bool isar_feature_aa32_fpdp_v2(const ARMISARegisters *id)
 {
     /* Return true if CPU supports double precision floating point, VFPv2 */
     return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
 }
 
+static inline bool isar_feature_aa32_fpdp_v3(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports double precision floating point, VFPv3 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) >= 2;
+}
+
 /*
  * We always set the FP and SIMD FP16 fields to indicate identical
  * levels of support (assuming SIMD is implemented at all), so
-- 
2.20.1


