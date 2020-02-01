Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F41C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12101205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGM+maJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12101205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyjl-0001eX-8r
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySn-0007lL-0j
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySm-0006yW-5Y
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:52 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySm-0006xM-0Q
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:52 -0500
Received: by mail-pf1-x442.google.com with SMTP id 2so5254483pfg.12
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R5MdH0QSS5QR9LjDBIPxSmfGJkuxTedNapCxShIB2BQ=;
 b=BGM+maJ/M91rj6IrfmdQO8CxB3GZp1aw60k8UKn0K5aH/SNug0si/Eq6xyfz90mVDe
 bELX5qaUxMOwZh8WYPoD0dzjJLct0KbE7Io4IaqyKR16rYKrrR1stbr+zWSUP5abm8SH
 oz3k020J91SCx3wUEKF2NP0tvZbVlCDjK1o9hFY9zbpWkpN1Qo492ZOy7ZYCh42Zd7Oj
 /zvU8X0Cu5XJViDxhibwFGKWtgkHtVhNckgrIJpcemvHzmRSnaO6iT1DwTn0XLftr+lO
 ylct6TZ9bbikQegjyT3o1gTxBtnfPiOEzDkngJ4zJC/1G/bQt1hGCSBUqpnQnfS+6lfx
 HM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R5MdH0QSS5QR9LjDBIPxSmfGJkuxTedNapCxShIB2BQ=;
 b=CWKu2lIWz6OO4Sg8oE6SEltrODFlC8izGblac3NNrgFOobkQaLejzf1XZiXrA9qjtX
 cvC0f0jeu9fBBDh4sbEYBGU3GNHRKOn7P5RzhKreeguZvwLtj45t7F8zthl2VORJZisQ
 Cl14MenxMKtvwieF/B+q0ianqqM1kBlOvZI61Q54UuqYu6+NafvjPtRBnVc6Zah/zYMF
 RHHC2QiH361CET/5q/6QYpy8VziM9zDeHY53HJ58dNQ8JuPDIihQWkmhQUZxqR5R7nJb
 tpAcWjsNum6230WIao/A6j/7PlZdwT8r7Ppml8Nmu7o13FE+YpOSVe0SJ1rWufsKTTdb
 HPvA==
X-Gm-Message-State: APjAAAWq4ANvz4uQaEOAyD+LKGw6TDrTX96ahf9u1fkdtY1gj1wIOugy
 KFGd3J1tPiUy5iJHa/Bitlql6CWzgYA=
X-Google-Smtp-Source: APXvYqz1bQ83tJRmSVEDUgww5RNQTUnUsEkdoZCzM5iznaZjPIE1wWkd02RlFnUw6ZMyTdcJqqANUA==
X-Received: by 2002:a63:ec49:: with SMTP id r9mr13361103pgj.445.1580585390120; 
 Sat, 01 Feb 2020 11:29:50 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 27/41] target/arm: Update define_one_arm_cp_reg_with_opaque
 for VHE
Date: Sat,  1 Feb 2020 11:29:02 -0800
Message-Id: <20200201192916.31796-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

For ARMv8.1, op1 == 5 is reserved for EL2 aliases of
EL1 and EL0 registers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 992ab2a15f..2aa04d0613 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7586,13 +7586,10 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
             mask = PL0_RW;
             break;
         case 4:
+        case 5:
             /* min_EL EL2 */
             mask = PL2_RW;
             break;
-        case 5:
-            /* unallocated encoding, so not possible */
-            assert(false);
-            break;
         case 6:
             /* min_EL EL3 */
             mask = PL3_RW;
-- 
2.20.1


