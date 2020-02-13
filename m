Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2EEC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0722073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4k24XMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0722073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fia-0005xw-RE
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgi-0004Au-L5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgg-0001Ow-9T
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:56 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgf-0001Do-Vg
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:54 -0500
Received: by mail-wr1-x42c.google.com with SMTP id k11so6970095wrd.9
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=f8MVuQbyXMPSpPZbTgaHloaqevQsik5k4zRik3DAIMk=;
 b=i4k24XMH0VZiu9Y5QgNyCsLQsN55yZWKvAjGwnviXsZMcW9f0brdqRMiYEnxEsn4Fl
 YifVxG5CuerHeWCSps380NwbN6jcN0+2n6Q0apy+obCB4QFU6EAQzhR+7TJhEuTXeMXT
 WJBi+hJuu9/f0DVd70Lpn9FWiF4VVzO1cIXapMtUeqDOZ/Ow8JTFxY+uEww3iIkP4tOK
 YXtynUBJ0Mfky4FEaOCtzLrIo30pkmKw9uLh5AUyUkUuu++fY625JKfWxc/aC/XMsOsg
 m6FXBQWytO0Anw5uAsUVGqy6s/II7AQgfcZlW4IO1PbQSWvY5zn71G6SovWmc8v97nQA
 VRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f8MVuQbyXMPSpPZbTgaHloaqevQsik5k4zRik3DAIMk=;
 b=DlSGn+rCHLW9sXE1q/P3Hb4fzDV8UH6QwK6awB2c/b1KJUZWgu+ptXA9cVHowECW8f
 2MOFr4SaxulwEHJ91s/3MxMcKaIFe/jBkJEQ1LL5RRmeCjoco24hM8zeI/StM0nvvnpD
 MY4efZZg7pdZbw9P0y65hyHyAMkZCBynv+1JBvRo+NjuU2rV+f34aQs1v2cO3ChVUIvi
 9CarmUoFyoAXimYGfPvPy1iVoaWAu0r+bpzc0eXGYnZxdtwrmB3r3nTRa8NSgWspMKM8
 okpWcg4uUWdH/cNfS+jNkCYsSpqw5GBz6Y5BqYGLD5uFerDTOfosV6l6nML4eKhLASsE
 JSAQ==
X-Gm-Message-State: APjAAAUWKmGvCD+CDI55f6/j1CtXq5W6U5q6GdN6jyxCjfxdGxFaFWhD
 OdpdOf0mqU19CqiHVRFNTQBSDM9rkGc=
X-Google-Smtp-Source: APXvYqyeO/M2dTS1CSFuECRCXDtOqmb5VqLYRRz4yUzcH2ZWOHHQJ9XD0Q406uH6snvv5JPwZHxZ1A==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr24012683wrw.60.1581604909127; 
 Thu, 13 Feb 2020 06:41:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/46] i.MX: Fix inverted register bits in wdt code.
Date: Thu, 13 Feb 2020 14:41:00 +0000
Message-Id: <20200213144145.818-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

From: Roman Kapl <rka@sysgo.com>

Documentation says for WDA '0: Assert WDOG output.' and for SRS
'0: Assert system reset signal.'.

Signed-off-by: Roman Kapl <rka@sysgo.com>
Message-id: 20200207095409.11227-1-rka@sysgo.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/imx2_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/imx2_wdt.c b/hw/misc/imx2_wdt.c
index 5576778a323..2aedfe803a4 100644
--- a/hw/misc/imx2_wdt.c
+++ b/hw/misc/imx2_wdt.c
@@ -29,7 +29,7 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
                            uint64_t value, unsigned int size)
 {
     if (addr == IMX2_WDT_WCR &&
-        (value & (IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS))) {
+        (~value & (IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS))) {
         watchdog_perform_action();
     }
 }
-- 
2.20.1


