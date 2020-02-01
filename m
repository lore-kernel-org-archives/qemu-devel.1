Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F96C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1ED20723
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arTGeDCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1ED20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyTX-00005d-QB
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySH-0006z0-QP
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySG-0006ON-PK
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:21 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySG-0006Nh-JV
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:20 -0500
Received: by mail-pg1-x541.google.com with SMTP id l3so1378738pgi.8
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rc7GWhvDJSvKK3kcrwfoinx92lO9NamYy4AUIrW65F4=;
 b=arTGeDCOMbtv0vglGPSNvvB5bAW/zFL+pUad+KTskZFuBfKS2skrRLe5jRAKtKR17c
 DahCn3hNB2VESpV8Larry9+25LGN5p7TufZ66a///U8NlcjKCsUe78rDJnd/pW4poSTZ
 pbhGayfZZWFtZPbP4e8SQ/I615yC5H0ga7LI1zRIcsw9b+BfR/Fh2lWTlbTPz+9kIQSY
 eg2vNNNz4z3ft9h+FA9CzFXfPvKzMXpfp6kEH18bo6YdKFQ2SacFNDLr6Txpk5sh2qpq
 qkFWxZU5YIONuTKHF+iGmYI/m7PwsGM1XDUn4fyk+oPNDixuxByu/mGirKf3+lDCjPu2
 U+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rc7GWhvDJSvKK3kcrwfoinx92lO9NamYy4AUIrW65F4=;
 b=ek/iXivoH0EfyS9Sc4lszcVUblDdDzut5NvHztZ9nJHjknaJaXJg8ldUH9Uhw52La3
 YXo1lyMizD2d6w216xMphuZo1ir6SD9ND3cTMOrM+dkFl4pK8IHJbNJnlijE+LlwGABN
 qnLTdBL5O5Nte5Q19UTkws/WujJPb2CXKEDVgwLWN98JidaaiNUbhIluWYD3R8AQ9Kee
 vPMXZzj1pEBP4/2pvRuUfp3DapJSllkXIzZHOtNCmbjuw1OfHKG15OLkeBlWCEqIVryV
 TClZm+J7TN6GuOwukbos1GRicymz0erLNfeaH0e2XdjRPFDWkXNNC7Rp60RplyHAtaiC
 WEbg==
X-Gm-Message-State: APjAAAUvkFQ2jz2wXc3ST2LxPHT2FSpzIKvxmldKlWgwcJ+4GvpRb1dI
 YUyb73B2mW2vYtneQO9WFKDrltkfPm4=
X-Google-Smtp-Source: APXvYqwdRLR2DX7dchnWRduI4O5vl//pSaX+bms6CuGoOKggGIDBzR5/b2Xyh/ab2VD16jpfQVCg4A==
X-Received: by 2002:a63:66c6:: with SMTP id
 a189mr15515245pgc.401.1580585359244; 
 Sat, 01 Feb 2020 11:29:19 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 01/41] target/arm: Define isar_feature_aa64_vh
Date: Sat,  1 Feb 2020 11:28:36 -0800
Message-Id: <20200201192916.31796-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 608fcbd0b7..2a53f5d09b 100644
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


