Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C628C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1868020723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxjMdZES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1868020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdB0Z-0003O1-96
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdAze-0002JC-9z; Mon, 25 May 2020 07:10:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdAzd-0006qS-MM; Mon, 25 May 2020 07:10:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id i15so16676264wrx.10;
 Mon, 25 May 2020 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JIFaeFek0SvjmieIuqV9ZQHX7s4EvNNwtRVCIFLPqBM=;
 b=VxjMdZESY8SxnXATmKnoAVQKPP1bmGfkLSj+iWBH5Wn91KgVVJnxKc9JJ9j8loY0QK
 P2CwB1golbfv5dari5QV1o5+Uy+z7n+kQ5kGukKXahaF6KZSqYxxwWZpBmezCtwsxu6g
 tdKShgR3mmof2CCpcWDVhuZAEe/16NFYXHZ1LXbMl7RqYUUTtgkTspX56i6kjx558xMD
 3LXyXCPhDAy31y64tkG5WyH0J8Houa82gwL6B2orwTdeAS3E4niDxqbxCkuoXW1752M6
 /2VGxh233rOekUNG9gPGDSHPt23XaMNwsKMQF+9SQRPAt5iVLt5H10YC95QoyddPkStb
 mMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=JIFaeFek0SvjmieIuqV9ZQHX7s4EvNNwtRVCIFLPqBM=;
 b=CUfHg80TqHl1upGY1NwbIMvcRpIiQ4AZ/3pC7+DY3MGWiWgF3UJL7oRku95qu/X2CU
 O8pAHtDKuW1coWtfA40+FkpyMXahBJ1v80+RUxZJ7flfVw0r3NThEmxa1BAOd03TQ3L8
 Er2RJr1ir7rDS6m5eAlctDcuOlhYoRqaMC+jl6fjuC1SuPccH4+LNpjUjpzCgxDBNz10
 LMKYbxbW6Bg0Y5xg/0BJfNOoNXk4X5xMtX6QNUkQgxRndBV4KbwmeTzdnG4AQKADeHql
 my4QrFEzeRwYWLffWxOGurrMC4Zvu7/JdRq59blwnOAuZFs8rTFP+UrqNAtI9yJ/zFuY
 9YwQ==
X-Gm-Message-State: AOAM533g04e63CJKaxhLmkoafEr744AD67NCTiERT0Q+IrZBIaC6R80t
 4eJxEs45IPfW4XGBL1wdic9lSPXLEjM=
X-Google-Smtp-Source: ABdhPJxS9AGEqXaO0oc/HXxWS+H8SxRDHU//deZFT2w938Lf/8XGWneddUC5T1/idfJG7QDma3YvLg==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr11547107wrv.112.1590405003215; 
 Mon, 25 May 2020 04:10:03 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id p65sm17516870wmp.36.2020.05.25.04.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 04:10:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/adc/stm32f2xx_adc: Correct memory region size and
 access size
Date: Mon, 25 May 2020 13:10:01 +0200
Message-Id: <20200525111001.8147-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Commit staged changes... (MemoryRegionOps::impl)
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


