Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D85C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410AD20704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKVr1j4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410AD20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iug3d-0001Tj-Mh
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRe-0000Pb-Vc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRd-0003nH-RL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:58 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRd-0003m8-JU
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:57 -0500
Received: by mail-wm1-x342.google.com with SMTP id b19so3002121wmj.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MnSW5xo5N20Gx6H+HBzm44iLQgb7EW3irvToiBE8BDM=;
 b=fKVr1j4/qHOhAXs/jhgMkCr3gDH+CA68zGDd5BcV4EikQLZCXt1oVGXBBn11bwVjom
 nTLTXvULf+/cH3ql9uKOhiE3CbdpbdQPG00Kxx7gATPMoYuabVxtiTqCnp8lGh5kE2TM
 AFqO6lD+0QdpHUW0yQVMK8XvsvOSMXTqgl3D7BAOH/jrC0Gqok+DLtkylR0D/lUnaoFZ
 IsvUkIu1JgfBn/7xma8QXXlpFvCLQ92ufrmf6N0xJm1LRySkaL6fuaXYKK8yrZbHT2so
 ACen64g7BKfbByzMBa4pKCgLEYU1cPnH3f3mvwwk9Ul1gG0qVd+KLPZdx5W7j7jWEwf7
 2R+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MnSW5xo5N20Gx6H+HBzm44iLQgb7EW3irvToiBE8BDM=;
 b=QH2pNdghc33VpiSToD0CMetMy5slL2IrafqqSSvQWneVDb5Yg8Fd1ow86fkZWdY+2M
 e3UlCkCXK6LC3kusyU4yxZT4Mz6uft4GcIKeCG3tjYa+kdMisFcrJMlqgll9sGfCbsJ9
 M89zKYeLLq+R01unV5B55/UjpLSauWQ1ItuY8fV2XgydS0rlFglQRnVzPLT3VWM2lBvn
 kjAYF/aJPY8+4Wvuk9/3JfyGCQjrEjp7K8tayB/cFPcmMCN4PBXZ/aQlEbnbYQLk5c4z
 MXkSrgljI09xno7C1l0N6KYeFunyHotHXrdALjHNWwF2VWceIONSStfTqPajPcm3EYb6
 PmJA==
X-Gm-Message-State: APjAAAUXI13oZbV5EKZKm+r8JLS1MmfTUaQ+bYovcJKYimvt0u0YQCiU
 dIMq3JEiSIGBtGf7LfrVCiG5yuZfUZA1sw==
X-Google-Smtp-Source: APXvYqzCixfzFD6I49MTCfI2NGkimNRMrRXKdUazVsLELL72qRe7Fwhup+rEOaPx8LaJftsVZQfn7Q==
X-Received: by 2002:a05:600c:54c:: with SMTP id
 k12mr4731477wmc.124.1579793456413; 
 Thu, 23 Jan 2020 07:30:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/20] hw/misc/stm32f4xx_syscfg: Fix copy/paste error
Date: Thu, 23 Jan 2020 15:30:33 +0000
Message-Id: <20200123153041.4248-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Missed in 870c034da0b, hopefully reported by Coverity.

Fixes: Coverity CID 1412793 (Incorrect expression)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200121213853.9601-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/stm32f4xx_syscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
index dbcdca59f8e..f960e4ea1ee 100644
--- a/hw/misc/stm32f4xx_syscfg.c
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -47,7 +47,7 @@ static void stm32f4xx_syscfg_set_irq(void *opaque, int irq, int level)
     STM32F4xxSyscfgState *s = opaque;
     int icrreg = irq / 4;
     int startbit = (irq & 3) * 4;
-    uint8_t config = config = irq / 16;
+    uint8_t config = irq / 16;
 
     trace_stm32f4xx_syscfg_set_irq(irq / 16, irq % 16, level);
 
-- 
2.20.1


