Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6096DC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256612070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTE6qICl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256612070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYnW-0002HM-B3
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKy-0007V9-B0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKv-0001zO-TL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:42 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:42242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKv-0001zE-PB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:41 -0400
Received: by mail-qk1-x742.google.com with SMTP id e11so8143101qkg.9
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=leGMjXpK2HH4jKgWKo9xRsuJr3HkPgiK0233yCfpGgs=;
 b=wTE6qIClP3eBP7ZZPOPSKZoaEQ6IrulwXyPvoluFpXrk9V/SrDEE9uxS0kcTvOItbc
 6GEZ5obQ8hOEHkH891GV50s9vJhjb5Z4kpLQ54gP2V+CTM8OaUKhDuerEXwc9DGTfzQF
 BcG+Fsyq6YlPN3ukZ43huNvp4lz9mN1qceIXBTOjVNoOMC4z3lLv9caxMpdHsEObtQNz
 6tGOB2TWVSdnf/6WVrujSgEcTzmZnRSJgJw90Td51hxg2QuMzdF3JhstMh5i9Ox2rBtF
 p1rsJQyCUMmgKDyRe9/MzVNUSHFC6FBmFGVqdhaDTKvukxKOR4AJO2qNXUspG04KJhcg
 Ti2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=leGMjXpK2HH4jKgWKo9xRsuJr3HkPgiK0233yCfpGgs=;
 b=fJPR1wC9+5lHzbTvP1//LQBmHHctOG88cnknG90RpD7XwlBGt1A/sl54mwD/MBEU/U
 Kmtp1XdIP+Fdj7eJMnnmf3DPDQBzEvZLtO8bLpOKZD9ozTz/soVxFSV3MCWkzzp7Q46/
 vlDJMAuX+oIjrWP0a6ZBWXSQ9F7V+7/FhPTLUXYpoUEYsRfGU7sQnnUwjHFf9hqX6Y90
 eTWaKekOv1LtrIc9uAENqlbf/5lhLtHODesBXniJV2CXHUgpr+GCwec1C+MAHA91za9w
 NGqjucLGLb9Q0Q7cjHRCKZFpNWGleWm7gLA0aSF0IJIA9Imf642eOOkhf3hFJzzvc4i1
 kl5w==
X-Gm-Message-State: ANhLgQ0dzrNEhvID9n5/wxVIgGEgq+F92fXgb6+aRFbBf8sA3StlzEn8
 F5LFP7e+1YsnQJPuor+6uxblkBVCNNBIHg==
X-Google-Smtp-Source: ADFU+vvT6+egTHc2OvUj+UXGlWEDXXmUAxcg7IaLTPZ5/YpnhpEc5wlp3nrEgQc16CU0eMnFr8CLhA==
X-Received: by 2002:a37:8044:: with SMTP id b65mr9108183qkd.238.1585251521031; 
 Thu, 26 Mar 2020 12:38:41 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:40 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 49/74] lm32: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:31 -0400
Message-Id: <20200326193156.4322-50-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Michael Walle <michael@walle.cc>, "Emilio G. Cota" <cota@braap.org>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Michael Walle <michael@walle.cc>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/lm32/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index c50ad5fa15..9e7d8ca929 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -96,7 +96,7 @@ static void lm32_cpu_init_cfg_reg(LM32CPU *cpu)
 
 static bool lm32_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void lm32_cpu_reset(DeviceState *dev)
-- 
2.17.1


