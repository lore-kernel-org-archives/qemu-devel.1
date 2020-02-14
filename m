Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D744CC3B1B9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06FA22314
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaX2BiSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06FA22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fWR-0005tv-Oj
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVI-0004Dg-Ij
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVH-0008UP-Fc
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:52 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVH-0008U2-A6
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:51 -0500
Received: by mail-pj1-x1043.google.com with SMTP id m13so4258490pjb.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RVsYrCWRH15jUkV+nOTPRiB+8FHjPwEImYNiw048qj0=;
 b=kaX2BiSmMPf/dfANlgf46MUoRKKJDjpVu6h1ilLmhlQBV4XnDzZZWN9aBQNbaFjb4O
 /J4/zU3BOhvSmsgPTaR+FW3TMwszwTCJjT6AW9m8TjuYtPNNO/bunaoEs9QOThwbzYeF
 v8aZ1dyAXdI5lZGbb2bKLgMPJlZ8RQwdAjNtUdgRDZsfvd2Lw66BoI7cUigQFSMRWlOp
 mzm93p2rYHQypeJPShBHctNU9eRYN03cIDsAU/9FDYFucEJm/hEyznn8ZDWkw7GAzGik
 xX9PBH8w/pdnVXzALsg0QWNrktrWW9MS/+H7vZzChZhyKeIyUugB+CdDIQVY7B1LmJ1E
 bDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RVsYrCWRH15jUkV+nOTPRiB+8FHjPwEImYNiw048qj0=;
 b=rJVat+HxPp0VL4GYSdL72N2q4lrv88Gd7nxrNYrhF9pPlOqcpTf4XTASMC0o/eRQvN
 i6SeRMa5BaGC6XeZy/ErBmmKr+Cc+Asik3+V/w6+glzcPPMs9CZ+L+R12mRbYKT8jo0R
 /ZIoTHrkdyD/31PueQqythagrX0STzIztx0iwbhQL8Wyzjl3lCqPijX5rRB2omZ5iEEL
 3Gj10cnuY6fbEUcCr3o3TvH7w5cyZvJObohqOlJhBb26i+RcVUXE9F4C4/xzSt6aiLTq
 wWzJO8MrCaldAP/wVO3LWYw9FscaYfXfQxg+d2e+eJXH2DuwTDkteJg2eZwFuXYFPDo8
 GD1g==
X-Gm-Message-State: APjAAAV1gLByxS1F/+dV2SmDJmff+KD18nevOrVp9+WkZMtOcB5r91f5
 1muFIHf+nSzEQ1kwQNEwHVlwa+vWyfQ=
X-Google-Smtp-Source: APXvYqyKdviVyFbFySrHUtnJbmNWIzOfTuf4gND+ozEmjKTqwzZmtF6Y3DC0MQcRPDDyH0NO4i4tAA==
X-Received: by 2002:a17:902:b116:: with SMTP id
 q22mr4689987plr.324.1581704149957; 
 Fri, 14 Feb 2020 10:15:49 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:15:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/19] target/arm: Fix field extract from MVFR[0-2]
Date: Fri, 14 Feb 2020 10:15:29 -0800
Message-Id: <20200214181547.21408-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

These registers are 32-bits wide.  Cut and paste used FIELD_EX64
instead of the more proper FIELD_EX32.  In practice all this did
was use an unnecessary 64-bit operation, producing correct results.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e943ffe8a9..28cb2be6fc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3415,18 +3415,18 @@ static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 static inline bool isar_feature_aa32_fp_d32(const ARMISARegisters *id)
 {
     /* Return true if D16-D31 are implemented */
-    return FIELD_EX64(id->mvfr0, MVFR0, SIMDREG) >= 2;
+    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) >= 2;
 }
 
 static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr0, MVFR0, FPSHVEC) > 0;
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
 }
 
 static inline bool isar_feature_aa32_fpdp(const ARMISARegisters *id)
 {
     /* Return true if CPU supports double precision floating point */
-    return FIELD_EX64(id->mvfr0, MVFR0, FPDP) > 0;
+    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
 }
 
 /*
@@ -3436,32 +3436,32 @@ static inline bool isar_feature_aa32_fpdp(const ARMISARegisters *id)
  */
 static inline bool isar_feature_aa32_fp16_spconv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr1, MVFR1, FPHP) > 0;
+    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 0;
 }
 
 static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr1, MVFR1, FPHP) > 1;
+    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
 }
 
 static inline bool isar_feature_aa32_vsel(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 1;
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 1;
 }
 
 static inline bool isar_feature_aa32_vcvt_dr(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 2;
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 2;
 }
 
 static inline bool isar_feature_aa32_vrint(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 3;
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 3;
 }
 
 static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 4;
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 4;
 }
 
 static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
-- 
2.20.1


