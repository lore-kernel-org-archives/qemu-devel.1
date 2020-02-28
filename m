Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C07C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C02B20732
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVBok5pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C02B20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7igK-0000sM-Ln
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if9-0007Kx-97
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if8-0001qz-A3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:55 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7if8-0001qW-3p
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:54 -0500
Received: by mail-wr1-x42b.google.com with SMTP id z15so3707575wrl.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qGZ+hkeDo4DLkuBIrqEdZXUncCd+tIHU06Z8m9ZQiI8=;
 b=EVBok5plp2swBkBlt3cKGXscx9khXWHu7NM5IMfEpOTL0EmFeRCyJ1FbmTAyGMxDTc
 dA9fQYIbHa/s9kc4W9Jz7jbYPolRmwPxZuVAT0k/v5AGtOfdoks4rWD0c9jIqNOmOBFD
 wwdvPksgGMIKro2NBPwFh6UCuvv2nBW2rs9CcZ4KItAza7EHI9Laj0FaGjEv9OHj+A3z
 O0TUhkvBam6/RawsvLZu2O940oWNfibfSXIPFRoSUlXtJRDh12ykyfPJ6AM87S4QrMTH
 TVEt+T6o35Uk9D0HTFyWNbxSihIt2WRZxCkf6B8RrUHozV3eyAuco/OV1iUpqMoDTW+P
 m+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qGZ+hkeDo4DLkuBIrqEdZXUncCd+tIHU06Z8m9ZQiI8=;
 b=cs+h13HvB1YP7MlWa0fEX7b4zcIjPy0M4DSOgS4SKBUFDe01uaVZpv0Sk2F2dph9Fr
 jiC4yrln9r3iz3U2thasvoAgpX/4VNlZd0KtL7CnzMJR6RVfHYYqaiKJFPKNw9ldPc00
 ao2X4fSVI0YqqktryvDHF21Ho0t+hL1wGav70Wg0PlFpFb2T7yPEzktvVIWA/NAm6/5a
 YaWCjhX8r81vh93B8zCj8zYQTRjZQE2w7PLQbl70ZN/R2si+4FQ1lkmu7dBclrIDrUCA
 DGhe7mdiTUI0geq8VKAyzRgrAvkOd1GZLgdqntkAa6L2zGsKr68fzvc2Xf10znQXoPwW
 854g==
X-Gm-Message-State: APjAAAVPDrJHUHC1NYUpkgVpvNNFrSoVcCpFxCaxpRmuQZorxzIwqKHI
 n8JYXjaHHFZ/XJEYGv8hTo8xxzpr+o4vcQ==
X-Google-Smtp-Source: APXvYqySh1vMh7hJzIrc+Pbqo6HGOSx+T+4ogT2M+kzaYoZibKdJ93b1L6xATqyY2S/hWhgjvGte3Q==
X-Received: by 2002:a5d:4450:: with SMTP id x16mr5491088wrr.242.1582907932781; 
 Fri, 28 Feb 2020 08:38:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/33] target/arm: Add isar_feature_aa32_{fpsp_v2, fpsp_v3,
 fpdp_v3}
Date: Fri, 28 Feb 2020 16:38:16 +0000
Message-Id: <20200228163840.23585-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

We will shortly use these to test for VFPv2 and VFPv3
in different situations.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224222232.13807-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1e6eac0cd2a..f7a90f512e3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3470,12 +3470,30 @@ static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
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


