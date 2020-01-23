Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A176C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59EB20704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GD1rVnsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59EB20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iug7I-0005AF-2s
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRi-0000Sp-2C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRf-0003ru-Vh
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRf-0003pz-Ln
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:59 -0500
Received: by mail-wm1-x331.google.com with SMTP id t14so2967201wmi.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TNju8K/yY0mIPA9rZ4WT+1GVvRX99QV39SbRPGh2iCg=;
 b=GD1rVnsbRyIOZi0HqoCML49dPwoQnKcV4zlem9zySe8bqOuQo6e2boRwmZu/7Bvt7i
 aXQaas2Of2EJ2GHL9pMiFscFOFGaKVJkRC1I2IP+qnWjAsaOAcEyy3/C154icX/0aHRR
 14sSwaFilnxBNpIWelG5sAebw54kKgS57/oXXyy5qrfuuCEe1Nmbhhs5eZ+e/PryUV2d
 WeZHULDahxp0j4fc9B99Z3xlhKL19sFjSVbSUeN9YfBwAzXN7NFu+E1DlrR5/7I0ywww
 CUIRpXAIghaFFmCvi3brOdwYB0bK4rbsVzT7U3HleEQ9XE+0ccvArLwZvGX9eQ4oH+H7
 uYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TNju8K/yY0mIPA9rZ4WT+1GVvRX99QV39SbRPGh2iCg=;
 b=sDvKJ48Q/HKnzKnjUpaVeQQBy6qz2pEHtZdIcYs/YY3I1Nmt6HoTyrzQxjmfSMvf70
 vxs4UoDZfgh5Mkpc8y31SFoIIX6larf+dGQdLFVGust6MVKFimT/YryGB/Rx8AiAFxGN
 KgsysCSUeWxtMXz94CBaX+2sAsm9EIKaoXWNr+La3JVRNwushPsdfOADMZSirTSZvM1H
 Ycpf3iSKLXTf4Tq38B67YJREXQlwikGyFvvGWsI3LLDHz1VkPbseoKbHuDtDmoFZZNJS
 oGHudBHcVNDIjNA3dGLCNwwddiCgjrK2zrUyb+1BFgdXS9CM033VEhhmvf6HYbW3xgAO
 zfXw==
X-Gm-Message-State: APjAAAUHv+tGSvJ7HOMEXFx1plX6PflZkaSyQAFj8977IwWf6wLqhKok
 MQNgqz9VU2vFauhUY3FpbrO3L+GOnmM2lA==
X-Google-Smtp-Source: APXvYqyFRUe78zxuF+swfVJ10V44YwQRe6j/FnsPv8AT+UCZATYaIskXFxC2Vnxu7GW/26t4jsaGBQ==
X-Received: by 2002:a7b:c1c7:: with SMTP id a7mr4719422wmj.168.1579793458447; 
 Thu, 23 Jan 2020 07:30:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] hw/core/or-irq: Increase limit of or-lines to 48
Date: Thu, 23 Jan 2020 15:30:35 +0000
Message-Id: <20200123153041.4248-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

From: Guenter Roeck <linux@roeck-us.net>

Exynos DMA requires up to 33 interrupt lines (32 event interrupts
plus abort interrupt), which all need to be wired together. Increase
the maximum number of or-irq lines to 48 to support this configuration.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200123052540.6132-3-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/or-irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/or-irq.h b/include/hw/or-irq.h
index 3a3230dd844..0038bfbe3d6 100644
--- a/include/hw/or-irq.h
+++ b/include/hw/or-irq.h
@@ -33,7 +33,7 @@
 /* This can safely be increased if necessary without breaking
  * migration compatibility (as long as it remains greater than 15).
  */
-#define MAX_OR_LINES      32
+#define MAX_OR_LINES      48
 
 typedef struct OrIRQState qemu_or_irq;
 
-- 
2.20.1


