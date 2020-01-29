Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE79DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E2D205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hsv24qE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E2D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxDM-0004vO-Kb
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxBz-0003VW-Ox
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxBy-0006bb-Sb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:19 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxBy-0006Xu-NN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:18 -0500
Received: by mail-pl1-x642.google.com with SMTP id d9so583115plo.11
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xmTFM7XVxmDplai/Pm/8V26hKCruWDVLPwrJtq92t10=;
 b=Hsv24qE8VM69C/+R13Le8JWRtdyJ+ZhuS3lO29bEYX+8FerBFLRDcNe+HUsLPvCddU
 Vbs6PnEaaUH+3lP/4vd+qjUBpgEWr0NJF3rjSKe4j+4oStUlHd2AHm0aolYCTnum7uUq
 hJ8vx/IBV8XBlRSRQoGFZQ6JF3OsWxpsi6Cuhux2kTITOnTUd+M9Whcn6QWIOJrYI+rY
 p7F2pJ5qNz0Xj+LgOr/Ta6FgwXNCcIfWSgJ7vHunVFXR7ihHcJiNon/9ILcZyLLTeC+K
 kgulh3FY3LWX3mKEn5b/z/tHS4Jib+edd5Kxqe0+BriZNTo0fXDW7bDaWhxmaW3r6iQK
 AIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xmTFM7XVxmDplai/Pm/8V26hKCruWDVLPwrJtq92t10=;
 b=MXapj98p7HccxTFYYrGHvaEjhmlZ65AVmJXHdHMmQfFuRWKyfTGtmHiXmbA33/WoFk
 +UVOK/EoAlS9SE1AH3u5mY1l+E8X67CKBUuklfDZ0oS/r1yXBgBeTvI/QCZeGpMEdjlX
 9gn0SevCLtvGTJRvBlP8K2o4xlLwg8CO/uKoxy1VCVJMZNNt4GYsz75rX3R3o8DBCgKa
 28+oINRfYYKEcHnRUmbELMtv0TR+1JScNKHtihOl3EcYkm7N/y7WHvhgGMUMSWf4FC+z
 hj8LkwZ+1mC5//hfntwyzhBK1lh78zkwIOSs5Pg3U7PAsTEMdJhmTW41ZclkC+tz4JsY
 NZyg==
X-Gm-Message-State: APjAAAUItIrs6NWI7FpwmpWD8V+/mOswvvKYQZqDc8O5n17J/Qisg2kk
 QamC06i/kPAOQKeYOCNe84DTz4nrCPc=
X-Google-Smtp-Source: APXvYqwri33GPXvpO5pfSxFgz1+6AZVyzmH9ngGfi5kZLw+DxUhRAE4mwdBBxgk3Rd6QaMCW1B77Lg==
X-Received: by 2002:a17:902:8e84:: with SMTP id
 bg4mr1867680plb.11.1580342177387; 
 Wed, 29 Jan 2020 15:56:17 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/41] target/arm: Define isar_feature_aa64_vh
Date: Wed, 29 Jan 2020 15:55:34 -0800
Message-Id: <20200129235614.29829-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c1aedbeac0..0477cef1ea 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3678,6 +3678,11 @@ static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
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


