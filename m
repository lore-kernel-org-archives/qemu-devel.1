Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA80C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A72F2074F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQyhI/5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A72F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsBx0-0003KI-RZ
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 17:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBu3-0007Bs-D8
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 17:10:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBu1-0004qZ-QZ
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 17:10:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so27494932wrl.8
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 14:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0uVc1RwrLMQTCvhtTK0p0uUR1koiTD8RW3TLjeqwhns=;
 b=jQyhI/5YYDXiS/6oRlHxKFZRz39HKRwaJryKzojw8cFnKCp5SscGDOawLoQfQSv7gn
 CQdxjB7M2RyEn1PxeK/OohUpFOhjYFL8uT0RbJK+tTnSy/gSWukidzwU9e2bmPZwlljf
 vtTOq9yUvGMZHbyGahEKB84Zg2SrKmOViw7Wonwx5N8SiCecThtfbaCVTKF0DrtvGa3l
 G1+IRUNdLgUCFpHwrCnYElB1lzZYpkAIotHx/eA93zFEz3V+h2S6nmLFt/A2qSIp5I3P
 xERr/sLzTp0lvedmFR9Be9TlLRCwg3n4MJzIXqsfOfw+sRUBHY4COv/Ih2rWFycxRcgQ
 GcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0uVc1RwrLMQTCvhtTK0p0uUR1koiTD8RW3TLjeqwhns=;
 b=NbjDcACoRXuOQAZ+tewMj+fdg/bQWgcoOqktQBUBDJ6jor3XXxl9TVhNRQ7UYRqQbU
 TW06dCoVmR+1EtI23S6odG+o0Y4RrnHzmS9NtsB86Hevg6Hb7RgQkDQcuPLRO0p6d4Q7
 qHCYIVj8Gua8CObd/C0ykbM+f852GmBT6QtgZfwUC+y53iorXuSW1Ek+flwPyBCDUhS3
 v/b9iFcFIKquuZBdnN8UfHMZr7IWSO7/BUQLPAWGvHs07vEGRKGFF9H7nPvTXsua0NhY
 bGmGH0rgsEuruKey1Pb4m7sWJ4ttPV/QsZl1IWPWZGNf6AG5E6nP7yCgaogUNqwPORKO
 n4ww==
X-Gm-Message-State: AOAM532rrqsHEEcJUN6XqxssKbliS+d8fF7Yv9NA8NWVsWrxN9tSaKfe
 gnXZi0yiJncYfbOqygMjh6EXE9k63+Y=
X-Google-Smtp-Source: ABdhPJwGaPdNiouywgbyHEMo19745phH81vXpdYVh82rIUV6Z7/+4yvJoR6lFcyqy9bcuMR7WOLYxQ==
X-Received: by 2002:adf:ed4f:: with SMTP id u15mr44625398wro.318.1593983420004; 
 Sun, 05 Jul 2020 14:10:20 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r8sm21102004wrp.40.2020.07.05.14.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 14:10:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/lm32/milkymist: Un-inline milkymist_memcard_create()
Date: Sun,  5 Jul 2020 23:10:13 +0200
Message-Id: <20200705211016.15241-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705211016.15241-1-f4bug@amsat.org>
References: <20200705211016.15241-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we will modify milkymist_memcard_create(), move it first
to the source file where it is used.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/lm32/milkymist-hw.h | 11 -----------
 hw/lm32/milkymist.c    | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/lm32/milkymist-hw.h b/hw/lm32/milkymist-hw.h
index 05e2c2a5a7..5dca5d52f5 100644
--- a/hw/lm32/milkymist-hw.h
+++ b/hw/lm32/milkymist-hw.h
@@ -31,17 +31,6 @@ static inline DeviceState *milkymist_hpdmc_create(hwaddr base)
     return dev;
 }
 
-static inline DeviceState *milkymist_memcard_create(hwaddr base)
-{
-    DeviceState *dev;
-
-    dev = qdev_new("milkymist-memcard");
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-
-    return dev;
-}
-
 static inline DeviceState *milkymist_vgafb_create(hwaddr base,
         uint32_t fb_offset, uint32_t fb_mask)
 {
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 85913bb68b..469e3c4322 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -80,6 +80,17 @@ static void main_cpu_reset(void *opaque)
     env->deba = reset_info->flash_base;
 }
 
+static DeviceState *milkymist_memcard_create(hwaddr base)
+{
+    DeviceState *dev;
+
+    dev = qdev_new("milkymist-memcard");
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+
+    return dev;
+}
+
 static void
 milkymist_init(MachineState *machine)
 {
-- 
2.21.3


