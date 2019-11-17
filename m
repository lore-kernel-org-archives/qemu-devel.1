Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A9C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 09:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DAE206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 09:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbaOldtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DAE206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWGXx-00072T-DG
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 04:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWGW1-0004dD-LH
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 04:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWGW0-0004Vs-KS
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 04:06:41 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWGW0-0004U8-ER
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 04:06:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id z10so15893573wrs.12
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 01:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X1Vrnl0U1WStHfXGelt9HfqdmyYRaXH+N+hAEhNxwRQ=;
 b=CbaOldtwUMerikJ/WPu12Q1PZINNTUNiunVTnlezW3yZ6mO5mvZ+EMe8BIOL4IUTPL
 IGJVXSmJIXg8JegYPS6nvQki6e8ptwCcLJMxtBEc3ltczb0/Q3m0baj0hu6Jlmy53anc
 6GYMZbTPt4znPyykSVa8f/76PYqelsAKl4boBcr4vywU0jyh395O87Ex1GtUFUaaPfms
 UDUXG9s/tJil/hrNVvkpv7BK2WFTbZl59xs5+kAQNjPS4XNK5thz3siZUleqCdfD67tB
 ePR+/jlrULCZeOwxghNGSu4IuMheu+vhb082vD40XpgLiIpC65JhhPhLYbtab5mbXhSX
 Plpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X1Vrnl0U1WStHfXGelt9HfqdmyYRaXH+N+hAEhNxwRQ=;
 b=LBrg8yw5Zba6q8KcwqsT9iAgNKpAr7sGt//vXLfZggCU/UYMeVr4cwCiuLkrsrl20B
 kBpVBuLfnJ/7AjPf7fLvZiR5yDg9eg6loIbsLmU0rsZ4SaJvH4xwKoDRWAmpR4WnA9aA
 WXcmr4wzJDUKD8f1OImViNFTU2k88RkA2VcbW+C2cG8IzyVmvmS6w1qLMtneJeWMP3uT
 hnEVAhABq2ay3wt3eNYKoqhrCe2/94d+NEcAAh5I6y9dV5CO21v7kPpa2QpMQd39Frgl
 HCwkdR9GqliLUJPIqY+AVl6nWv8XLS7d/FdBQfzIPiuy18F7GPXVP8KCqkxFiwGJqs9w
 n9Ew==
X-Gm-Message-State: APjAAAW5JWzwG9U2M5xDSblH38wqdFeflAuah8ayL6NQqjU2/BKprzKN
 7PYZQgfMlTQq966NiWYtc+7Q5SB0PwpGug==
X-Google-Smtp-Source: APXvYqxvFEThtzhRuS34CHeVPEHv1waRZQBLOs0C8pUvW+objtS6w9HRgadL3jHUapP33arF1cfV+Q==
X-Received: by 2002:adf:d091:: with SMTP id y17mr25498844wrh.182.1573981599222; 
 Sun, 17 Nov 2019 01:06:39 -0800 (PST)
Received: from localhost.localdomain (180.red-80-27-55.dynamicip.rima-tde.net.
 [80.27.55.180])
 by smtp.gmail.com with ESMTPSA id 91sm19773679wrm.42.2019.11.17.01.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2019 01:06:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/arm: Relax r13 restriction for ldrex/strex for v8.0
Date: Sun, 17 Nov 2019 10:06:21 +0100
Message-Id: <20191117090621.32425-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191117090621.32425-1-richard.henderson@linaro.org>
References: <20191117090621.32425-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Armv8-A removes UNPREDICTABLE for R13 for these cases.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b285b23858..3db8103966 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8931,11 +8931,11 @@ static bool op_strex(DisasContext *s, arg_STREX *a, MemOp mop, bool rel)
     /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rd == 15 || a->rn == 15 || a->rt == 15
         || a->rd == a->rn || a->rd == a->rt
-        || (s->thumb && (a->rd == 13 || a->rt == 13))
+        || (!ENABLE_ARCH_8 && s->thumb && (a->rd == 13 || a->rt == 13))
         || (mop == MO_64
             && (a->rt2 == 15
                 || a->rd == a->rt2
-                || (s->thumb && a->rt2 == 13)))) {
+                || (!ENABLE_ARCH_8 && s->thumb && a->rt2 == 13)))) {
         unallocated_encoding(s);
         return true;
     }
@@ -9087,10 +9087,10 @@ static bool op_ldrex(DisasContext *s, arg_LDREX *a, MemOp mop, bool acq)
 
     /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rn == 15 || a->rt == 15
-        || (s->thumb && a->rt == 13)
+        || (!ENABLE_ARCH_8 && s->thumb && a->rt == 13)
         || (mop == MO_64
             && (a->rt2 == 15 || a->rt == a->rt2
-                || (s->thumb && a->rt2 == 13)))) {
+                || (!ENABLE_ARCH_8 && s->thumb && a->rt2 == 13)))) {
         unallocated_encoding(s);
         return true;
     }
-- 
2.17.1


