Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4313FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9B620897
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAG1SOSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9B620897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83ps-000145-6a
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k82l0-0006hR-Ra; Tue, 18 Aug 2020 10:38:34 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k82kz-0002z7-4W; Tue, 18 Aug 2020 10:38:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id 184so17254393wmb.0;
 Tue, 18 Aug 2020 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HBZVH8DbVP87G8OaAytsCzNyqaW3XTQSsMrdJGsu7lU=;
 b=DAG1SOSgzbawLFIyLqQg+HKeKRdOSXKBIsnafrvB5VE82XeY1NItAkJ07Db8Wd72xX
 8KHbBHMYAepStJUVH1AeAgu20ULsvWl8Jg4pj2vmlzIDsH/QqxlqHm/xqj1unu2Yz6sS
 c9cT+HHq2DdOXNe3vhrGgY727CsPe2qXgZgiigibSDPHS0LxiwSlMiOaNqNKr/IeOY57
 Q8rbvNGWTub4diRI3oKJ2HAx39FA5LFGqifAQjvGG1Xqy6bMSr57OB7O4zEE6A4Oi29a
 CGkikf8OxYLhKWm6puKoiiGTp9Ch1VNPQCAKVJtRN8swgTOkzM8q+30uMNjf8nyNzuOp
 aUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HBZVH8DbVP87G8OaAytsCzNyqaW3XTQSsMrdJGsu7lU=;
 b=gxcdXkpW2DVQbV30fEachprr/eaDWG00cxG3ualsZ78Hjdw28qpmCB2lpDqOgAnk5+
 +jgNtT494CnLQ/wFKtyrfpXGn7F73W6hIwY/BiSxw3fqW1ahUZOIJF+6uHROdMGPPAjV
 XzaQ4a8QihTQTmgIbGsPEOZ3dAFWuqRGCoem0Kb6Brho/YEf3ZwqNS+0Tz71B6tGXLA3
 UfHRtvEvaTMkQPTZcpYAR9sERRKVAXMuAs422IBSXF+nzLJFBRnE5pKfYMFw5fgPp05F
 XHXOFMThupis66PlFwqH4EVslK6EnX2KFraJZ/hdPmL2SUnw3bDl4qBWkwsbWlHbqhTQ
 E9jQ==
X-Gm-Message-State: AOAM533ivht/dUYmK6pVrAS/Zxv75rdqpdIV5aXe0OAj7bXrDd3g6y5N
 9jIPPWzzTPCiOR0kuA3l20B9smVlNBU=
X-Google-Smtp-Source: ABdhPJzeATk3WZykFmKe/Kx+k1ecCKzD6QnmiAlprd2fKDp2brjhbVf69J6rHzTFJzQVDBO3GwP9kA==
X-Received: by 2002:a1c:b787:: with SMTP id h129mr220955wmf.93.1597761510886; 
 Tue, 18 Aug 2020 07:38:30 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z8sm139177wmf.42.2020.08.18.07.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 07:38:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/core/sysbus: Make sysbus_pass_irq() arguments
 self-describing
Date: Tue, 18 Aug 2020 16:38:25 +0200
Message-Id: <20200818143825.691110-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818143825.691110-1-f4bug@amsat.org>
References: <20200818143825.691110-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the direction sysbus_pass_irq() pass the GPIOs more obvious
by renaming its arguments as 'from_dev' and 'to_dev'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sysbus.h | 7 ++++++-
 hw/core/sysbus.c    | 5 ++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index da9f85c58ce..65de6f6b062 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -73,7 +73,12 @@ typedef void FindSysbusDeviceFunc(SysBusDevice *sbdev, void *opaque);
 void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory);
 MemoryRegion *sysbus_mmio_get_region(SysBusDevice *dev, int n);
 void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p);
-void sysbus_pass_irq(SysBusDevice *dev, SysBusDevice *target);
+/**
+ * sysbus_pass_irq: Pass through IRQ/GPIO lines from one to another device
+ * @to_dev: Device which needs to expose IRQ/GPIO lines
+ * @from_dev: Device which has the IRQ/GPIO lines
+ */
+void sysbus_pass_irq(SysBusDevice *to_dev, SysBusDevice *from_dev);
 void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size);
 
 
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 70239b7e7d0..bc23a66b5c5 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -181,10 +181,9 @@ void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p)
     qdev_init_gpio_out_named(DEVICE(dev), p, SYSBUS_DEVICE_GPIO_IRQ, 1);
 }
 
-/* Pass IRQs from a target device.  */
-void sysbus_pass_irq(SysBusDevice *dev, SysBusDevice *target)
+void sysbus_pass_irq(SysBusDevice *to_dev, SysBusDevice *from_dev)
 {
-    qdev_pass_gpios(DEVICE(target), DEVICE(dev), SYSBUS_DEVICE_GPIO_IRQ);
+    qdev_pass_gpios(DEVICE(from_dev), DEVICE(to_dev), SYSBUS_DEVICE_GPIO_IRQ);
 }
 
 void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
-- 
2.26.2


