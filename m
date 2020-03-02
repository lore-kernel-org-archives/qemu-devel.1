Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A5C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB0C21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgQTd5Ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB0C21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pRU-0008H3-Ev
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pL0-0006jy-8R
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKz-0007bW-By
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:42 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8pKz-0007av-6g
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:41 -0500
Received: by mail-pg1-x542.google.com with SMTP id a14so167590pgb.11
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uuvmt8nnRxpkzrlRvGkzXacr9M5W6UoCPdAN4Hxg8gg=;
 b=JgQTd5Uam3c76kYxK5iuzGdkmvCMFZaz2gRBOAzcas+O7KsG7sexziMGBYq5Ih3sQK
 L7YRkafhys+Ik7+Toag/mRHmKmep7sFRPe8mzj3Bn13ragNfmBXrq/zSDgtDbGTJ6MvK
 904SNobNuOdZrEmMQGEXDPpfTEd83OC3WFkCsG5ds0vJ5hliqXfhDTK56Sy2eYHP5cum
 el1L274mOlUTHMDz7mLzsS3tYKTuizryQI7Qr9yxqKjnp3KmEBm3EE0RtXVvTLg3Jeob
 BmdY+QGRby4yHiLbErUTsLWN+WwbvIOcTBbcjCjoN8mnDxrGikz2XtIFt8ykZtpHO+Oo
 sLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uuvmt8nnRxpkzrlRvGkzXacr9M5W6UoCPdAN4Hxg8gg=;
 b=GSbV8uRyeFAvjouu+MnwrE56wu4TgYL4wfnVdwW8rRwzDiY9nEV5GpgLVoD4LbC5kj
 yGbvY3fAzLqRUzgGbZF/U4zcbA0s7NPo8/A2mvOlv2ZUgQLelx9rD1QOlmLGEP5PGLef
 jPIB7k9Ro7FZf/NiuKTTrIXwx2aMLfhn1AjaEpulrM5Aa11fDryed/TWiE6fmx1Qkz1s
 hgg571WTM1YIDE73VR15mPoyzDgwW7vfmMV6gfXJtuFHB4K4goaXa258r4ad971wiC2Y
 vgeRF2mCbOtnKq0iZphSw/+WL+ZowQSmiuXkmm427KwdmbKO9js9qeXVhnEcu9yI42tL
 w/ZA==
X-Gm-Message-State: ANhLgQ1bwjHT4gqFdhUM1/K+XKV0LpnvW4/WPHpdaMtjrBFjeS5tyMbC
 CipjvfxcZ2GhSRJbuEGr2bn6gx1OWzQ=
X-Google-Smtp-Source: ADFU+vv8L0GqwQl7mSj+6pKEfr/gb1fNlw010a1bGeHmENrPd9/yATlR0yIObaMGbKG+mBGR2kYWow==
X-Received: by 2002:a62:be0a:: with SMTP id l10mr250698pff.110.1583171920020; 
 Mon, 02 Mar 2020 09:58:40 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id s18sm99510pjp.24.2020.03.02.09.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:58:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/9] target/arm: Clean address for DC ZVA
Date: Mon,  2 Mar 2020 09:58:27 -0800
Message-Id: <20200302175829.2183-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302175829.2183-1-richard.henderson@linaro.org>
References: <20200302175829.2183-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This data access was forgotten when we added support for cleaning
addresses of TBI information.

Fixes: 3a471103ac1823ba
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c910a49b4e..fefe8af7f5 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1784,7 +1784,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         return;
     case ARM_CP_DC_ZVA:
         /* Writes clear the aligned block of memory which rt points into. */
-        tcg_rt = cpu_reg(s, rt);
+        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt));
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
     default:
-- 
2.20.1


