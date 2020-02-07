Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1EDC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6877720838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCckIU0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6877720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04il-0001ag-Hr
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04ha-00083v-Fe
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hZ-0002DN-Do
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:50 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hZ-0002Au-7H
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:49 -0500
Received: by mail-wr1-x42a.google.com with SMTP id w12so2978772wrt.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wiym8FeREOUNdMDL8foZ2tGZjtJnFWi/X62fmxihxGc=;
 b=JCckIU0zA5hUmZXresDdkWaXhnrVotLjpdpFswhVy9EkKGTAQYysUv1jJZR6Dv5Mn7
 PxXdvfMVcN39I+kFhXroIOGgXPyPyPjq2ekvOKzQKnL5RR02iN/m3YmT+I2duwGCewRA
 aRC8leL3Jxh/D18KDEUo1q1DMtzsYbK0SbK7ShyLsyc3ClMO/x0KIsjfECXtaHs7bETJ
 v5YcZbZiCcL7oDijw80gKlBRQzoXgPGoCUAoZLYhznJgh6978R01OUpvl7nkpci+RdF9
 JiEKpFfsD2cH8cOMV3mX37XK6igfCJ1wXkMlcGkhBllvmakha7AhutrOZRFg5m4KeVsa
 kGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wiym8FeREOUNdMDL8foZ2tGZjtJnFWi/X62fmxihxGc=;
 b=IyGt6oVzGJvlhPpHR6kNluvWQzxmA1Hft+vm3wpo/bZEq69TLZ+f/KVdrYIysu2mrf
 ygkRnbydkJ9hwq0dShYG/ZVskrB2Ph9H36xsx7DvyDk9k/44iakRmILwoTgt1kAocqFT
 cb0hwii+MDut790mySqbnk0ZSt4xI/IZfW5fmG+W3+xHAdXOuoJpr0SyD7Ca5SsNItJ7
 j5KoHXUc1t7+OPFeS5ecXUnm6S559ULCzSS7/O/K3hS58IwKT8eArUg/UjU/Tffak5vL
 SOOnfJa6ixktULmZRFmDYNjjnAiaE85z016fxrlSgMc1mirIdn6E2SFdbhkmbJSU0Ifd
 J2ww==
X-Gm-Message-State: APjAAAUS5UjtaTyCa8RojhmkYLpRuJPHfhO9LLaoFG1dEM4X76CNLdzS
 ap6FKysmJ1/kXGu/eCbCdIe1RNJjB08=
X-Google-Smtp-Source: APXvYqwfvTVQtwJxY9Iqq804yJH9/rKxPDJzzDtaaZUgcE6sTBv7NYvfgd8p0IhksIWV8BMlDDwGTA==
X-Received: by 2002:adf:f986:: with SMTP id f6mr5251522wrr.182.1581086028007; 
 Fri, 07 Feb 2020 06:33:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:33:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/48] target/arm: Define isar_feature_aa64_vh
Date: Fri,  7 Feb 2020 14:32:57 +0000
Message-Id: <20200207143343.30322-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 608fcbd0b75..2a53f5d09be 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3685,6 +3685,11 @@ static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
 }
 
+static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
+}
+
 static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
-- 
2.20.1


