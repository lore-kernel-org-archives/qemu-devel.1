Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF23C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FF420732
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8DF+2NV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FF420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ig0-0000BP-LH
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if0-0007EH-Lx
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7iez-0001kr-H6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:46 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:40073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7iez-0001jS-BS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:45 -0500
Received: by mail-wm1-x32a.google.com with SMTP id d138so2302681wmd.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ImwM0adJI+zaYU2PeeesY4R3AUrKvYPOwthqhAld2eU=;
 b=H8DF+2NVEkZCjeVj3Vs1x0iHvSTeXkAaauvyJUTuUYTZ6JmH6ZHNc+3TtibiVxV2wq
 w3qh4zeIOneWJS6P8t9nlLzSYO01Zm6Z8H3fa7xy/RHeH4Bc/bqHf6JcCeDf1RxIL1jC
 PWx3JFmfNdESJ+8CeHwnWYZeYYsS04MsiIvRbhFv8AYj3TGSQh7e82L8odH6a2wWPs9K
 wjsEE50ZV8/zhaVdPo0G053btWPs0eshipl9jmSLfd0I2YsisYwvgHgYoZu8xHHKOm0L
 lGbciB7WWjfDw6BLEfP8MUji2iDj8yCKId7WqUlO6ipec9QD9Ea8wsLmHJaiWzsNR9yI
 z09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ImwM0adJI+zaYU2PeeesY4R3AUrKvYPOwthqhAld2eU=;
 b=c/xtrA7Vd03lPUr0eoP3lAo73/ZJMB+4SVXsyKGP33YtudpwWA8i8NtW1BjvJp+LrO
 y5xojhoYK/nGthtoF32oT1zBPpGZaP9m5Du6wl6RE4IG9uJtpjZEDSlV0l1ztZFyJgRc
 Tb5qpB18z2HI6rEbvyVVocGC7irTrQes2FBy8Gn3b5KOxhWKSbN6UD0lFFe2seacKrhm
 x12FhCJ5gVY7WP5PE0X1ZaJGkBtWb5hMYzszRCZPZ+07DZP9dkJC62JPTnsKORztc5Nt
 Tiw1rikcOWWLpwfQ/x87LyOox2mW7/SP+XTBIjd8jHWVelzz0UnRMfe/YXOgI2XAPnbi
 3DWA==
X-Gm-Message-State: APjAAAVm7AxCOgseLSioehhXzdb0YDK7nSZJfPWE3/Cx/0WA70TDbY6k
 XIz+bLTC2LWGkX9iEnyAXstP4XWCflMCjw==
X-Google-Smtp-Source: APXvYqw9rSepdizjwcMCjzGhcNoA8G2utvd2kBWWMjH2b6II5k5XUmL/Ap6hEWhmTgWK82+5VTwcAw==
X-Received: by 2002:a1c:2504:: with SMTP id l4mr5768854wml.72.1582907923987;
 Fri, 28 Feb 2020 08:38:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/33] hw/arm: Use TYPE_PL011 to create serial port
Date: Fri, 28 Feb 2020 16:38:08 +0000
Message-Id: <20200228163840.23585-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

From: Gavin Shan <gshan@redhat.com>

This uses TYPE_PL011 when creating the serial port so that the code
looks cleaner.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200224222223.4128-1-gshan@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c    | 3 ++-
 hw/arm/virt.c        | 3 ++-
 hw/arm/xlnx-versal.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 1cba9fc3021..8409ba853de 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -39,6 +39,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
+#include "hw/char/pl011.h"
 #include "net/net.h"
 
 #define RAMLIMIT_GB 8192
@@ -409,7 +410,7 @@ static void create_uart(const SBSAMachineState *sms, int uart,
 {
     hwaddr base = sbsa_ref_memmap[uart].base;
     int irq = sbsa_ref_irqmap[uart];
-    DeviceState *dev = qdev_create(NULL, "pl011");
+    DeviceState *dev = qdev_create(NULL, TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a8191a3e75e..856808599d2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -74,6 +74,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/char/pl011.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -727,7 +728,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     int irq = vms->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
-    DeviceState *dev = qdev_create(NULL, "pl011");
+    DeviceState *dev = qdev_create(NULL, TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 1cf3daaf4f4..403fc7b8814 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -22,6 +22,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/arm/xlnx-versal.h"
+#include "hw/char/pl011.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define GEM_REVISION        0x40070106
@@ -144,7 +145,7 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
         DeviceState *dev;
         MemoryRegion *mr;
 
-        dev = qdev_create(NULL, "pl011");
+        dev = qdev_create(NULL, TYPE_PL011);
         s->lpd.iou.uart[i] = SYS_BUS_DEVICE(dev);
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
         object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
-- 
2.20.1


