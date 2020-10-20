Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD4EC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C104721534
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3Ekgn0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C104721534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu7V-0004iW-OS
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0d-0004CP-M1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0a-0003qu-Na
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so2780235wrv.7
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kmrpujIYHxAX8yVXk3nU79vFEhUn765LzbagDMPL/ls=;
 b=I3Ekgn0PHJPOIjnwrPCcE+WZy1gNdgfDsmr8ZZaMos4fdqWIJNxR87/wP2sbEzODgV
 f7CgMoIuiAHDTAsKnMS2syKds55dJRVTK4d2duk+jpOTymbxnEdp36aTFYg/6TFVOMkL
 /2lVZm12T2QzWvaPSiJ14u0jbVUiTwYHVH0RpGHDJJ+pMb6iw+CoeUNFvX8NWVI+R24E
 V+2OaNh7vf2sTdfpJC70iATITolgSbn2zEvrv4vMDEDwwW0SiLBxnWMybk2D27XzP9bm
 6ewLHI2M6Jj2KY7gJqTNz1ti6ooHOq/7odMzX2iwkoUTeL7ANiiTgUQSnt1frlyVmGob
 TVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kmrpujIYHxAX8yVXk3nU79vFEhUn765LzbagDMPL/ls=;
 b=M5b2CcedyQUZofYtw0wPet/1rx4zjz1TS+XNOmVXDlz7b6+a4/vo4+0RSKlvnYKgQT
 mCutrzyBt6BTaY1mAmEtShNVIYHbttFtVTeD+nwUMpVLcneL734iagiDBUu0nN3JAqDN
 a9CWBDkS9GaL0VLtDGnHJlKz5OH4f8NuCfW5NVmchkck/PfpDCw/sBHGwXSLELesF5pR
 9WkNInws3DKXey8xUYisJUup8ftqcl00Vg/LlzJznNc5PMRoUmtef8EY4+lRei+yrJkA
 jnBaTb7+7QruTpuMryqTlK7DnK6vLGEsmEhphJ7+jBXZEDHbsbcnMWRqfd8bq14o/53s
 jU0g==
X-Gm-Message-State: AOAM532tNpu8Rkp/EzboK9PV4+MMDoVacdfHYeTEl8xMPf9Em19Pr7Yp
 aewqMWtSrHtPW6NZRNg8bUMWi2jZqTaSmQ==
X-Google-Smtp-Source: ABdhPJx54GDznd2ryeFbsiLZ5EtK0ItJAIbYO3FCVv0P/b9LYu26RCKAeJgXOIyxQScJNqotN5clCQ==
X-Received: by 2002:a5d:698e:: with SMTP id g14mr4134926wru.232.1603209426703; 
 Tue, 20 Oct 2020 08:57:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/41] hw/arm/strongarm: Fix 'time to transmit a char' unit
 comment
Date: Tue, 20 Oct 2020 16:56:18 +0100
Message-Id: <20201020155656.8045-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The time to transmit a char is expressed in nanoseconds, not in ticks.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201014213601.205222-1-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/strongarm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index d7133eea6f9..ca7c385f313 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -935,7 +935,7 @@ struct StrongARMUARTState {
     uint8_t rx_start;
     uint8_t rx_len;
 
-    uint64_t char_transmit_time; /* time to transmit a char in ticks*/
+    uint64_t char_transmit_time; /* time to transmit a char in nanoseconds */
     bool wait_break_end;
     QEMUTimer *rx_timeout_timer;
     QEMUTimer *tx_timer;
-- 
2.20.1


