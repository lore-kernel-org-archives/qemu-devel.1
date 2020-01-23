Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02F9214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdnFD6CY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02F9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugR0-00062y-FM
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRY-0000D7-54
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRT-0003aP-10
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:52 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRS-0003ZD-RI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:46 -0500
Received: by mail-wr1-x431.google.com with SMTP id c14so3536556wrn.7
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eblYmalTC0fBvO9ZzHTdvSGAe+FYdbVrliGqrCf/xro=;
 b=fdnFD6CYOpkjB1F24hS4zxcc+QJG4WcDgSjjs4JfZLvkGvDCehPmi7xsIod/W/gc1W
 xBR6mBB6wbRL4bMlfnlhR2xU8Llk2vJzjDLaNczQCOXenT2uSVg0MyGp0b1JO0Ykpk82
 2eeCiP2vvMqyxNF46DEhTMCRN7HQ+6eMCeLlbzoG20CrharPZJdmDOEENdx+rXDk4tPy
 3aCKp4ZfEQDFs1+a9okRNFcdV4hld1vZ+rknqPIc+lYLwpxmXfc7NWNZs/sacEsvUk7k
 PlrvM254VptlBWe4Qjy95CWkECQ0Ijq66xKhXiNfkR2fSdHQ/0Fno4M8mObYbfd/69Uz
 wJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eblYmalTC0fBvO9ZzHTdvSGAe+FYdbVrliGqrCf/xro=;
 b=Eg5sRg2MwJFhfX/C5mH8FjSOKt9srx60VrV5hGqJPlxqA0eWwb4SbCXOOUC7qUMDzA
 74JFYsUG1u0jABZHOVqgZGGCuV8NFlNHwh6H0KSp73kbpBWiqFs9WqUZyrU/xc7EeHCX
 3DHM+iz+69c0a2Gc+j02ZygZ/6eXTZf3FIKgoQarkh6yINMWH+BLfncoOj4FIx6xNEKn
 v6+DzDQIvMusM9VRH8XERtA2BKlZNc/xIb9nx7z/upV99q1iC6QuC3+q6BZs3IMICMHq
 TM/LBD8DK2jj0/PukB+BLymn5aqPOAum4L5Sw0aTMj3PTKipeF5rMkc85SSC+dFqEmzo
 MW+g==
X-Gm-Message-State: APjAAAWJVut+yYtE+fRQ6JIjz1TnexbpgbTQt9E9Ry7E13DENVHoyrsi
 lQMsZMKrRwpUU2MZpcfYAOIySzwltVShAw==
X-Google-Smtp-Source: APXvYqyN1+AxQkkuZzIY8uBGFRJY3TZLd2k9ioHb3uRJxhcCxLMpLlF+kE8npYMv1B/qY8X2pXuvsg==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr17903994wrp.167.1579793445634; 
 Thu, 23 Jan 2020 07:30:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] target/arm: Fix PAuth sbox functions
Date: Thu, 23 Jan 2020 15:30:23 +0000
Message-Id: <20200123153041.4248-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

From: Vincent Dehors <vincent.dehors@smile.fr>

In the PAC computation, sbox was applied over wrong bits.
As this is a 4-bit sbox, bit index should be incremented by 4 instead of 16.

Test vector from QARMA paper (https://eprint.iacr.org/2016/444.pdf) was
used to verify one computation of the pauth_computepac() function which
uses sbox2.

Launchpad: https://bugs.launchpad.net/bugs/1859713
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Vincent DEHORS <vincent.dehors@smile.fr>
Signed-off-by: Adrien GRASSEIN <adrien.grassein@smile.fr>
Message-id: 20200116230809.19078-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/pauth_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index d3194f20437..0a5f41e10c5 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -89,7 +89,7 @@ static uint64_t pac_sub(uint64_t i)
     uint64_t o = 0;
     int b;
 
-    for (b = 0; b < 64; b += 16) {
+    for (b = 0; b < 64; b += 4) {
         o |= (uint64_t)sub[(i >> b) & 0xf] << b;
     }
     return o;
@@ -104,7 +104,7 @@ static uint64_t pac_inv_sub(uint64_t i)
     uint64_t o = 0;
     int b;
 
-    for (b = 0; b < 64; b += 16) {
+    for (b = 0; b < 64; b += 4) {
         o |= (uint64_t)inv_sub[(i >> b) & 0xf] << b;
     }
     return o;
-- 
2.20.1


