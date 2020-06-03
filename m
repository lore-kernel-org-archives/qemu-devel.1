Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5B6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285ED20678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzWUjqOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285ED20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgMRX-0001HW-CH
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 02:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgMQq-0000D5-Ut; Wed, 03 Jun 2020 01:59:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgMQq-0000gE-9u; Wed, 03 Jun 2020 01:59:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id l10so918689wrr.10;
 Tue, 02 Jun 2020 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9HBR/Yl1f5/zHKx9ZNXQfOsKlTY6daAsStel41gZZFk=;
 b=RzWUjqOUEXnsK4HzlRZdB0K+M/5ufQ9GJIMKzC4cvUfGAozonyEutkVzUJYHdJ4Hdr
 oxbFiGD0gK6x1eSDAMkaK5y/DerQXbyUTtJz2QcXH9kx/vwwva0LS7ztfo7sHhn1Yqh6
 5ym3Qprvn2ddyWp1FBSLmptdQWkCt9verluEnM6S8opwmZPawNxGB2y6w4P6pr0J63Si
 C3l3zQm/Vns8nNhxRaVZPbb7W0Rkw96JQY0MElE5RIGnTp4HAVKp5tAn9zv0evoczQ8Y
 6yRZAzyjpj4+Y9+dG+ryjFrS2RELKgisuaQlo+CkBc5Y4CUtNVHEQp16Us6eDBf4AiDt
 W9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9HBR/Yl1f5/zHKx9ZNXQfOsKlTY6daAsStel41gZZFk=;
 b=iPwAXlmqDW3PyKQ70fjyIiSaYcFRVefbLihX7YB/r8pyxZST8ijxhBRrR8ezdIzuLe
 G4sGUDnQTwxrWW1Hy3rcVqOiYZ/80LrL7fjEmr9UFak750sqyzJ3GvxrWkLdh5RG65sn
 zNUUj45/0H7IZAQK1C4rTpTP8ky1k0QaGZXpqQQgANbXTLWVR8v35zFsUxHINEbNay3C
 eU0lIcEsOi0cBhDMGHJ1UjK9/Adq4QMkOK7FN4+3hJim7RhAKUCbWWp6W+8EMA4ZCr/G
 Ph9yrRCH5nQZd3egwVn7SHTO9iTI2MDEVSsrzY5CtBEHtZcemR0ecRtPbLvQhCmj3lP8
 82BA==
X-Gm-Message-State: AOAM5331+imc0AwT6iPlziBTakDYnP/F9WRY5wzl605UBDlF5lQmuJbh
 Oa0P8odQZw0awkAyXCF29OdRrZdt
X-Google-Smtp-Source: ABdhPJxq/h9gWfldR/TPZYWY8sGc2O9OnZo5UDiIMtZy5eHnL+7cCuIcxhpDFu8+oq1GoJaHPYKmTg==
X-Received: by 2002:adf:e544:: with SMTP id z4mr11757175wrm.317.1591163957652; 
 Tue, 02 Jun 2020 22:59:17 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 5sm2006291wrr.5.2020.06.02.22.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 22:59:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] hw/adc/stm32f2xx_adc: Correct memory region size and
 access size
Date: Wed,  3 Jun 2020 07:59:15 +0200
Message-Id: <20200603055915.17678-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Seth Kintigh <skintigh@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/adc/stm32f2xx_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index 4f9d485ecf..01a0b14e69 100644
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
2.21.3


