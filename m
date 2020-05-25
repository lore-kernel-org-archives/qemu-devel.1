Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CCDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FED20723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4vL5Pn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FED20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdAyK-0001Bb-GP
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdAxl-0000WW-Ob; Mon, 25 May 2020 07:08:09 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdAxh-0006fS-KP; Mon, 25 May 2020 07:08:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id x14so11345931wrp.2;
 Mon, 25 May 2020 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iL4sfFhqdm2R6XSdcTGkQgrXLA57/EPgzfZDT6s/zo4=;
 b=c4vL5Pn0EiXaGmh+WIcWpYcG97xR8MTSJtlHK2Z6Bosy4Mk8m+qLXJuI/LNPhwpfCA
 TzEyy7iCghRrPYA6rs04sQyu63xSEsAameQqPLHIPOF/bEm16+96B/VRRdtg7Oh7rWiy
 SdVshGj1ERnWmBGTsyOra5xCH2deQVcZRjqEMphFnsinPPkyly+Axc79paiDj+9JYw4P
 vj0ISywtWUEuf8j4WfJNWx8LkKXHcfElthcpmDJuU1T7XSyS0GyTQU5GxL3YahJR+khG
 fXNr+bntB6UvtjOSAZ4V0Q3Oy/ZR56qH9FzapJ5p+3PotaEllopmhCm1suIrpryBOsLK
 dsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=iL4sfFhqdm2R6XSdcTGkQgrXLA57/EPgzfZDT6s/zo4=;
 b=H4glLr9t0PogEwvMLgQGjjylkoVW/jBtTAsgDAFsuQbxXjXT1ukZvmeCnyHiN/sbPp
 G2P8eDizr1M91B81nXPTasGqPyoysACBmZikssiKZmMBcxJh8W8O/usWl8xX/LurMaw+
 uDvYs6a3VAH15nT7fw+HlTN2W2ph2q0w06MZc7+s033gwao52U7byzs00PwjALobpJqR
 e508XarZVNjIlHo1PULgUeOr2c0LpZ2elvaeWirukwxbZ0jfAQmOLtbltt0EA6vjnSZC
 nkV+q4sIRvL774PA6vh1CIq2DugklBYSBIycjpY4xWLBlnrpZ9rZ7zGMsI029NMnhH9a
 WswQ==
X-Gm-Message-State: AOAM530c+FMrt4VOVckwUsE7vjFoBfOOm0jRHc/roEf6EIQyIoqQwa9e
 Q//TuHd56ekxNqHwpLhqlrHMcj/c5FY=
X-Google-Smtp-Source: ABdhPJxk/upJpXhSNBmnOev0P1ihl4NJCHghZLINkO9kLLYkads9EVhm/62yPqOL71GIGeBmRlOaig==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr15840731wri.342.1590404883316; 
 Mon, 25 May 2020 04:08:03 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id o8sm10642573wmb.20.2020.05.25.04.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 04:08:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/adc/stm32f2xx_adc: Correct memory region size and access
 size
Date: Mon, 25 May 2020 13:08:00 +0200
Message-Id: <20200525110800.7230-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair@alistair23.me>
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
 hw/adc/stm32f2xx_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index 4f9d485ecf..5d834a98f6 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -278,7 +278,7 @@ static void stm32f2xx_adc_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
 
     memory_region_init_io(&s->mmio, obj, &stm32f2xx_adc_ops, s,
-                          TYPE_STM32F2XX_ADC, 0xFF);
+                          TYPE_STM32F2XX_ADC, 0x100);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
-- 
2.21.3


