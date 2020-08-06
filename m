Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44610C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE3023103
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaiTm7ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE3023103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fBs-0000Hn-BV
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fAn-0007VZ-Oo
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:39:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fAm-0004Jd-AW
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:39:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id a15so43838305wrh.10
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FNDqhM8BnSE18oBN3qPjUTS6kYdhfDUSkvSLUFeNsoY=;
 b=jaiTm7ijp25y3TICjcB7NWOez2tqEHlyDYC96MrY4tSzws85jII7tFIieDBge72i4W
 iF3+mjL9KTi0dSXvm/GgDAvK1aGpV3itb6tirRbnGr1BjcrGwHAjcf9wVd2NDo1ieYUT
 6wDyz2OB+8u03JaJfeq1l+d7N9L4eTblIxcZVjckyvYqXkWtpZDMH96rha5BJz1pue7g
 Z80a8K9VzjgEirX9T8Tg+5rDh+7t3IaFV1hcn30fIUtIW/HDvn0urymhxi/JWrBdD/Mz
 wlFgvwAkFACnL8GNCPBgpdTF40swmJ+ZivusabUShLNFlU1MEItwb3V3H1qQqgX19KcZ
 0nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FNDqhM8BnSE18oBN3qPjUTS6kYdhfDUSkvSLUFeNsoY=;
 b=LkZH58nCQzuSPCcVqirRRKfDRtsYzO8NjuQQLZmpsAYp1KF6U0w3Bw/ocqheXDBM61
 taTz0MmFbL96pg6fycU44HKo/PYfD1AqOQXmYs6r3ITU0uvrNLdCUEWge+edLpFECnyk
 tXZyz0x4t9ZG5n5CYFTN1nByelS85EvM71/NnWNOPDzd6IBG+2Y6qtWx/seJrGO3kcvC
 MpvyA/5c/XZSiv1MFRm01IsF5/PEroVHspmsOm0f1beIVfdxKrXEBl7FyZVo67RV2EnZ
 nX0+nQAUhA8ZYfIzJHLSBZLz92hmA8QtXtbtdcZHqf4P9d7wZACulK6fOOyHt/31WvH6
 MgMA==
X-Gm-Message-State: AOAM531j7xc24oywwTSUGEZ1FiWQda7mTisHqQPaTr9YFZ6XJbUL/IZV
 +0hgNSmitRKGDSiVWLK+H0GZuREu
X-Google-Smtp-Source: ABdhPJyTyt4M2RvJmPvEW8RgfXWlM34FmpwMUEYHkbvK/tYKIXrUilCFDtC6pR2KQPEa6wM/QD0GKQ==
X-Received: by 2002:adf:ce89:: with SMTP id r9mr7790475wrn.116.1596717541819; 
 Thu, 06 Aug 2020 05:39:01 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j5sm6615395wmb.15.2020.08.06.05.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 05:39:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/3] hw/clock: Remove unused clock_init*() functions
Date: Thu,  6 Aug 2020 14:38:56 +0200
Message-Id: <20200806123858.30058-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806123858.30058-1-f4bug@amsat.org>
References: <20200806123858.30058-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

clock_init*() inlined funtions are simple wrappers around
clock_set*() and are not used. Remove them in favor of clock_set*().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/clock.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index f822a94220..468fed0996 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -209,17 +209,4 @@ static inline bool clock_is_enabled(const Clock *clk)
     return clock_get(clk) != 0;
 }
 
-static inline void clock_init(Clock *clk, uint64_t value)
-{
-    clock_set(clk, value);
-}
-static inline void clock_init_hz(Clock *clk, uint64_t value)
-{
-    clock_set_hz(clk, value);
-}
-static inline void clock_init_ns(Clock *clk, uint64_t value)
-{
-    clock_set_ns(clk, value);
-}
-
 #endif /* QEMU_HW_CLOCK_H */
-- 
2.21.3


