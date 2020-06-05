Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08CBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABFB2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMIWoObQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABFB2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFby-0001Ur-Nx
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY1-0001Wb-1c
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXz-0001fi-FB
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:24 -0400
Received: by mail-wm1-x341.google.com with SMTP id r9so9048251wmh.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cM/nenshJFdr/xOFmEA2BlgzqbESOdnacOqE/yTx7cc=;
 b=HMIWoObQKqDqwtD4kVek/6HJj3mlAFwFTqg0umhwfKwz5KPwbVgK7HVDK4CCSUqPPI
 zvn4T57IW98INGNa17b2AREnP10oPB4BNBFJXvX8CYvMCrePBK0i+QMFM0VHUBFsWg0e
 G41F2A+Fkn7dVOogFXAP7TXgzQxEi23BpO26QiyvdT9xZBe5X5Q8QpEltJUlDd8KB1AL
 7Sigc1uICwjGivSmG6haQyYitvwZPghdL0MzhhUG2v36zrq/Ol/PTnoiNLEgd0Va2LEw
 NEbthbQKxK5sxNMTjgoclyh2KwKQqfGpAIyhfiiR5mJFZjlUCjfHiAD6AKdbYdC+E6CT
 UnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cM/nenshJFdr/xOFmEA2BlgzqbESOdnacOqE/yTx7cc=;
 b=n99oAKAuEX0K9nVPu2aMOhTc6VleNE6GO3Th3N1Nue2G684KlDLLL69tfRETjFsbF9
 ML7B5GR6i+LMlzu4Yx6uaMNxS5HH1LeEoSvt/RBNHXiS5hAgU98DxKx97hC1JdQmm6ht
 kUyZVJLpxQdRmMylFFzCXWV0MFRP1bgtcCt0UkG+urj8j8hSY4wcNwCmnfP3dzGDHqcX
 SHyHvCiDaTXWGhXno6VpNJEai9bu4NFMiVz8F3xlKeVADoON+kBKPQOncP53+ru9hBMI
 dy+YhfGOuPL4Id9V3B1XGk1rWIb00hxmwt55KVJLAKdyEkKV3LJlVKiLMHpZBG05sE4H
 fysQ==
X-Gm-Message-State: AOAM532FOAs7wt5+lFOHLswtVqt9aK+7qqyeTPI0C5ay98Bmv+TFUjQs
 dHwXbvIknz96QdMY9zzlkn+4kfFpgy5PJw==
X-Google-Smtp-Source: ABdhPJykdUIU2pmojqyggMkI55Zbh9nPuR3lUwtKN4Sg70vpskB04kWwuaeUdUVTjsHKUQcUu54lNw==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr3691831wml.77.1591375821845; 
 Fri, 05 Jun 2020 09:50:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/29] hw/adc/stm32f2xx_adc: Correct memory region size and
 access size
Date: Fri,  5 Jun 2020 17:49:49 +0100
Message-Id: <20200605165007.12095-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The ADC region size is 256B, split as:
 - [0x00 - 0x4f] defined
 - [0x50 - 0xff] reserved

All registers are 32-bit (thus when the datasheet mentions the
last defined register is 0x4c, it means its address range is
0x4c .. 0x4f.

This model implementation is also 32-bit. Set MemoryRegionOps
'impl' fields.

See:
  'RM0033 Reference manual Rev 8', Table 10.13.18 "ADC register map".

Reported-by: Seth Kintigh <skintigh@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200603055915.17678-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/adc/stm32f2xx_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index 4f9d485ecf2..01a0b14e69d 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -246,6 +246,8 @@ static const MemoryRegionOps stm32f2xx_adc_ops = {
     .read = stm32f2xx_adc_read,
     .write = stm32f2xx_adc_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
 };
 
 static const VMStateDescription vmstate_stm32f2xx_adc = {
@@ -278,7 +280,7 @@ static void stm32f2xx_adc_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
 
     memory_region_init_io(&s->mmio, obj, &stm32f2xx_adc_ops, s,
-                          TYPE_STM32F2XX_ADC, 0xFF);
+                          TYPE_STM32F2XX_ADC, 0x100);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
-- 
2.20.1


