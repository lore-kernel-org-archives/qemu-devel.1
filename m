Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D868BC3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71A9214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TldB7RgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71A9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izesa-0003aE-Qo
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoM-00033M-Kz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoK-00073F-W1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:06 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoK-0006xG-Ob
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:04 -0500
Received: by mail-wm1-x342.google.com with SMTP id a9so6468903wmj.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ixb/CItwkgiX4L1TLeUOJYRuRP+Ce/EIhWk9K8Yxl5c=;
 b=TldB7RgAFfNQfBCwzQT2IicXDdk/I3kkkDDsIlQxUDJJnzgMTDPQ2i4gIfR+Qk7Hzj
 P+VAKP+DgICWDnM+MEI13vWUlGhhcglbJU5Rbls2BwLPmfMzdOZsYqvp/iKoiX2qx5wJ
 EHV5QU3rsrbYDGmvEL464FIXhtn+/GhumlXWDTV4WVwd6Ck0RV4Ug7X4VzG4b5fiUpb7
 K6pxKc8AMzH8z3GepU+bnclsyjJu+bW2cV9G7iZ2dBjNsjOv6tfabO6LkTUIhtykmimo
 BHD90ohUCoXBj4YVY55SpMAyjWJFpy4VXl2SghXxL/Xgu8fWNZFRcgWG33oKxgyJx+fc
 ve5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ixb/CItwkgiX4L1TLeUOJYRuRP+Ce/EIhWk9K8Yxl5c=;
 b=cTjxu1JqwiffDcN1oRc9nGxU/Xtdx3JWjSm32aHP3Sis6a2e0ChoHjjn+kueeWnU5M
 cRM7+3jKGY0ULqWhPTVIlskt0dmosLDu3UYnGi761ZYFpPjPh9Mxl4I4HnkASwc9Pngq
 BmGIpaocr3ExctQVomaeGffl/Voakrgz1Cw4SlvI2hmV0SHeivoitn5mEyDXWc3gOrVr
 DAAjZcWEPmnoxMB6mx9HhoirJWoZP7Zu7e8dbc7jbkmUWCdMJM4bhafprSucOmYWbsL9
 bvWQ9xSyY935PslWcplRkVIRY1o+kZIxMo+SlE8IJMO0UzLKtmXVQnG+YkrHR+9eqgUf
 p10g==
X-Gm-Message-State: APjAAAUcgCRFwNus9HbBf1xlI08RtuIPBZOPA0jPHugc2o8bRwuJaHCb
 AFAImraGu4y1LL/DqNPtD4vgia5rW3DzJw==
X-Google-Smtp-Source: APXvYqzIB30deemuptGYzqxcODci+2xHEAdE09aCeqMoh8bzwhR91zLt8AAdfieLO0uSa5aTPoV2aw==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr3700562wmg.63.1580986503302; 
 Thu, 06 Feb 2020 02:55:03 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 16/41] target/arm: Expand TBFLAG_ANY.MMUIDX to 4 bits
Date: Thu,  6 Feb 2020 10:54:23 +0000
Message-Id: <20200206105448.4726-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

We are about to expand the number of mmuidx to 10, and so need 4 bits.
For the benefit of reading the number out of -d exec, align it to the
penultimate nibble.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fce6a426c8..aa9728cff6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3214,7 +3214,7 @@ typedef ARMCPU ArchCPU;
  * We put flags which are shared between 32 and 64 bit mode at the top
  * of the word, and flags which apply to only one mode at the bottom.
  *
- *  31          21    18    14          9              0
+ *  31          20    18    14          9              0
  * +--------------+-----+-----+----------+--------------+
  * |              |     |   TBFLAG_A32   |              |
  * |              |     +-----+----------+  TBFLAG_AM32 |
@@ -3222,19 +3222,19 @@ typedef ARMCPU ArchCPU;
  * |              |           +-------------------------|
  * |              |           |       TBFLAG_A64        |
  * +--------------+-----------+-------------------------+
- *  31          21          14                         0
+ *  31          20          14                         0
  *
  * Unless otherwise noted, these bits are cached in env->hflags.
  */
 FIELD(TBFLAG_ANY, AARCH64_STATE, 31, 1)
-FIELD(TBFLAG_ANY, MMUIDX, 28, 3)
-FIELD(TBFLAG_ANY, SS_ACTIVE, 27, 1)
-FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)     /* Not cached. */
+FIELD(TBFLAG_ANY, SS_ACTIVE, 30, 1)
+FIELD(TBFLAG_ANY, PSTATE_SS, 29, 1)     /* Not cached. */
+FIELD(TBFLAG_ANY, BE_DATA, 28, 1)
+FIELD(TBFLAG_ANY, MMUIDX, 24, 4)
 /* Target EL if we take a floating-point-disabled exception */
-FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
-FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
+FIELD(TBFLAG_ANY, FPEXC_EL, 22, 2)
 /* For A-profile only, target EL for debug exceptions.  */
-FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)
+FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 20, 2)
 
 /*
  * Bit usage when in AArch32 state, both A- and M-profile.
-- 
2.20.1


