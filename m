Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3208C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB312064B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMuGC4V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB312064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHEK-0008WQ-US
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3H-0002bl-CM
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH39-0006Vx-C2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:44 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH38-0006Ry-RX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:42 -0500
Received: by mail-pl1-x643.google.com with SMTP id bd4so2278388plb.8
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=by8LmgJPpfyV7BVjX7xy3BTMjxptfd86p6Ff5RwnARA=;
 b=GMuGC4V7qbLrXldRswf9I4Cz9sQCnBllz+QBDFO5rKgczlx8XsGS42O+Nx3PgjwkWw
 RHaiip+5E3aVI5FNn4qBPdttJZVjudkgWu6WOTcrPNe7Rk+bosKLCCkrCuZHQYYVKsM3
 3Y1vj9WMNikaYWrI3RLkngPPRh9CqlHtZVDHBGLB4dmN+ms67w7vWLktOsMIAWGonAWr
 bgDre4oCrFRf8UJUuDeVETlKInZmN3OQEM9LA3ksrnpoiNkixJgjmPVvqvpGCKXO/y+d
 lDj56iymXp7zOgt5nmSx2H6+PGgpxexY2oRm2T60+Tz6ZRBm/Wgkiy+pwmghblx8dBc5
 Y+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=by8LmgJPpfyV7BVjX7xy3BTMjxptfd86p6Ff5RwnARA=;
 b=BFDd7MLIGcLa00WjxrXFGRmb30cYzN45mctuXH0wFAOwl4j6puZxDpByJUWlFU0ZK4
 g6gWHsYE+NZ3YFaluJWhE+hgsS+J5LeNVmUFzCnFbPwDESqLWbCNvISnQcRV0KqzGAvn
 /4qeGNVijhnM4etamcv07gwoQPh8BBVGT5oPkH4cDz5dGNgbrpYigO/kWm4Gk1PzysB0
 2iGgY3sIoFFVOIqAr94w7PmNS+VrB121uLz4XIz3RxPhdtdtNFGhsPUxONUA3wiYhPM4
 zHvuCV/HkaVFPHTn1H28YOhmg3ZA2FkdCaBKb4mLAtDNSs0L59WXtrx6suXM5YvOQoHD
 lKRQ==
X-Gm-Message-State: APjAAAUqAfu+Q5sEngAuRfG42PN26LFdli8Gb1RxLSsHr/I5wWZ1qOxL
 VW+tLb5kq8pU8Yd1KeF6fkGGyA2a4nw=
X-Google-Smtp-Source: APXvYqyUfz/m6dxpoYyLwAvkMX0j6Jn4wqJsm8WtdrWaHFFS1yhKyNNELcmV2KwF10DRUsmcVGM+4Q==
X-Received: by 2002:a17:90a:a44:: with SMTP id
 o62mr8242690pjo.80.1575413621392; 
 Tue, 03 Dec 2019 14:53:41 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/11] target/arm: Add isar_feature tests for PAN + ATS1E1
Date: Tue,  3 Dec 2019 14:53:27 -0800
Message-Id: <20191203225333.17055-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

Include definitions for all of the bits in ID_MMFR3.
We already have a definition for ID_AA64MMFR1.PAN.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 49dc436e5e..170dd5b124 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1694,6 +1694,15 @@ FIELD(ID_ISAR6, FHM, 8, 4)
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
@@ -3401,6 +3410,16 @@ static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
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
@@ -3550,6 +3569,16 @@ static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
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
2.17.1


