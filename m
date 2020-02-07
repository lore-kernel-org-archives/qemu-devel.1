Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241BEC35242
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E769A218AC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZjbkFE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E769A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04n1-0002Fu-3I
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hq-0000HK-HW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hp-0002pL-EG
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:06 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hp-0002nF-71
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:05 -0500
Received: by mail-wr1-x441.google.com with SMTP id a6so2912572wrx.12
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yxq4YxHd2MI+/+Xjtj2NcaZECHeURog87fN3pYPdVps=;
 b=LZjbkFE7uVmk/lfce4cMTzCHKdwhw9nYAys8p6AdQfNkDB3uw7my6IUyFE2k/FhL4t
 Z/Z1Hrn4Vt3pZmzEuFNpCaev0H1DGxp/Qv+avjWHnjlvKMECasbY/XdcG6Pr4MNW5+Da
 VcXeQNaeZGKC79IPw5/AqL2h6ykdjHYYOr46QCktp//v1mVXC43NwhgahCDz/Pg0f9nE
 KJUOiBR/PCOV0J/+ttiPgkGC8Wm749gi2PP9PvJszcZ2sBd7GvqX4qmGnVHt04brT/6A
 1knjlyrh3xI5BAj0i2Z1PVWLNlsahif68D4fI9Wkc0NP1YK/g6wjgvfOcXjsLh0hph8W
 i+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yxq4YxHd2MI+/+Xjtj2NcaZECHeURog87fN3pYPdVps=;
 b=F6cOHx3aISkiopnzT4kqLiOPM7GUzkUa3kUOqg0ckKM+W9mHLCqqUpnE6ggUKyNwkU
 wW+UXHETF7DRDRx+y/Rdqg7OCdQRwQWGbHUvSgyn8EouZop6N1ukv/bJEXNHv+G+5x+t
 2rhZFzl4zmzY+z9ljfGleVoFnTC7HCVVrNtam11f3IfqNPJC9ifrE1ETisEjKrytxYzP
 PtX1GGWRoQlSF7mOdLoK2W3UmcbWr+CxrtizTpFyxS6PIWyBHDKRbJZucL7eUedCnOip
 IN/+/W6WTc79JQ89MRn8z6ogpbEVnR7vQmW1KwNsgRXISBTmTUarQLGiqRq4t7Nhbocf
 +Z6w==
X-Gm-Message-State: APjAAAWkq+odSj9iMYsUqibEu+gzIPfG8AURN5bHuBC0Nmbz8TZ/u1t+
 gEru+tVuDm4uR/vQFC5aRmKSKzZDwNc=
X-Google-Smtp-Source: APXvYqx1/h2NF/L4KAF9241u/Qzxfsq+2DpWePXCgiS23QsOsEtcw5M4Zm7gMy7PSrCYxwRBtf6p9g==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr5288263wru.296.1581086043994; 
 Fri, 07 Feb 2020 06:34:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/48] target/arm: Expand TBFLAG_ANY.MMUIDX to 4 bits
Date: Fri,  7 Feb 2020 14:33:12 +0000
Message-Id: <20200207143343.30322-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

We are about to expand the number of mmuidx to 10, and so need 4 bits.
For the benefit of reading the number out of -d exec, align it to the
penultimate nibble.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fce6a426c88..aa9728cff62 100644
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


