Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A135CC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3EE222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwIWoKCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3EE222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FpK-0006Vq-Jn
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgw-0004M6-Um
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgs-0001ob-R1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:10 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgs-0001kC-JL
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:06 -0500
Received: by mail-wm1-x32c.google.com with SMTP id g1so6528815wmh.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rmiH96/cndBLaHM0LWVL6bzqgE3M22u8BWrhcwmNQ28=;
 b=XwIWoKCcD+UrEnxAOVpdW/CvkkrRePkXQWhg5NtU1mKPqZr55FjZfMvqWFOTbCZnN5
 UoItpMzzbxCAuJCNWwfHgZ1Sz3YjjO2TIS87SVMP3xtBrvJKDgxlQhz1gZshervX2mUD
 Jn547f6lVDMyW29nscqZaskinPcfOwq7OLRLi/0L618jkNk4G31fUI1aCVNavs4JFa/g
 ArVY+cv33EM3cS0kDUE2XNiNrm7lC+kNvZ/k9U6gEx4klO6z4vz5/6in1RbCPTm8P+xK
 CeKWhqzvcfCZhTxZt2cs/VVHub70VLutMVatGpFzY7MyYLSUMkZqHaFTDG0hLsFJ4c/x
 sZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rmiH96/cndBLaHM0LWVL6bzqgE3M22u8BWrhcwmNQ28=;
 b=Edb8B7ee5r2Qr8neeqHIc1bNUA5rM9crNwBVUqqt2PK1SqKKvZynj9LLfzMKe3QCRH
 DDjFw05JRU0WAhx1dQcwOBeGy+AaIFtsqYTWAchYGiPgMsoigf2LrTDuXJKgPdt+mULx
 IFHfUlHDlKIQVuiUdp08yIomm7EG1vP5/qoQZ6ILB6E2Kv64LIKLpyvO8Jw7gNw/6qKT
 pNbmZXp1Qv3V8awF5w91uM99mXdgs8VvPaI8cdqlLzeXkDSLGvBdAfgvMh3z2UTD4gwX
 8/Sx/pB17crbhrhBdusg/9m+yeMh/2eqadfZv/o8ekWXTqiNfKAtBqJGzM5Tbr1STRJv
 viAg==
X-Gm-Message-State: APjAAAUIAHEV0EiFAusvCwao5CCWWZztqBWR/0RPfYbabE7gs3FS/zQ8
 loZUmCBRYSLAmiNyChpWvDB+ismiIdM=
X-Google-Smtp-Source: APXvYqz1IQFINGVDCo7iKW85x2FYCsqhTrxcNlEdTbwOXgxFPogT3WrqWP6tsXIWt3/LRbrBIMGbOA==
X-Received: by 2002:a05:600c:211:: with SMTP id
 17mr6140547wmi.60.1581604923152; 
 Thu, 13 Feb 2020 06:42:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/46] target/arm: Add isar_feature tests for PAN + ATS1E1
Date: Thu, 13 Feb 2020 14:41:11 +0000
Message-Id: <20200213144145.818-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

Include definitions for all of the bits in ID_MMFR3.
We already have a definition for ID_AA64MMFR1.PAN.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c63bceaaa5f..08b2f5d73e4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1727,6 +1727,15 @@ FIELD(ID_ISAR6, FHM, 8, 4)
 FIELD(ID_ISAR6, SB, 12, 4)
 FIELD(ID_ISAR6, SPECRES, 16, 4)
 
+FIELD(ID_MMFR3, CMAINTVA, 0, 4)
+FIELD(ID_MMFR3, CMAINTSW, 4, 4)
+FIELD(ID_MMFR3, BPMAINT, 8, 4)
+FIELD(ID_MMFR3, MAINTBCST, 12, 4)
+FIELD(ID_MMFR3, PAN, 16, 4)
+FIELD(ID_MMFR3, COHWALK, 20, 4)
+FIELD(ID_MMFR3, CMEMSZ, 24, 4)
+FIELD(ID_MMFR3, SUPERSEC, 28, 4)
+
 FIELD(ID_MMFR4, SPECSEI, 0, 4)
 FIELD(ID_MMFR4, AC2, 4, 4)
 FIELD(ID_MMFR4, XNX, 8, 4)
@@ -3443,6 +3452,16 @@ static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
     return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 4;
 }
 
+static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) != 0;
+}
+
+static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) >= 2;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
@@ -3602,6 +3621,16 @@ static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
 }
 
+static inline bool isar_feature_aa64_pan(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) != 0;
+}
+
+static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
+}
+
 static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
-- 
2.20.1


