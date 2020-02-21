Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2452CC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D782073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meTFDMpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D782073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Sm-0007Q1-34
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582g-0007z0-Ao
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582e-0003LI-T6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:30 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:45255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582e-0003J2-M1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:28 -0500
Received: by mail-wr1-x435.google.com with SMTP id g3so1979405wrs.12
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=H0G7hXnYvNjV+3hg2JTTqmpRPLVuBfK7HJumeWhX01g=;
 b=meTFDMpHcmCtVdBg/0lVITSarUn7N2NIPdPgMrLfRzBB68GnBLA6U0nw7b/8W17h2t
 srkuzT5CW1ezBH6rDwA9XOniRqkoqiI8HS4SvGkCPucNm/K6wImd7Cq+FKUO2XgzPNwC
 o3lmRjDzpugjJqCoXCDRs44GNX2RnaJr3T1Z9KIdBvygsEutsyOc0Ttn09hX1HBMhhmh
 UL/6XLCHniHrZP1ukwKrAvCYaUcwCCqML4VOvS8ZjeOuV3gokoLrD1p1teUTVvhI2n3b
 Y5BAUIJNkocakokyo73+sypMjqQe9+8OvsG4t/wfUVG3suVfQ37s9mHILAwRTnEm9gr7
 dAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H0G7hXnYvNjV+3hg2JTTqmpRPLVuBfK7HJumeWhX01g=;
 b=J7vnQg5AXrpLXdQSH/fgcNlkKWMjYQcZ/RkDU/aeyCFm31TjUFxjnpuWFEp8aPZXxb
 ESwiS8bNn3t2w7sQ+EF+WBr33lhv87as9eo8oR7EfPhRxMFTe0/j1zDqI5fvNQ4MPyeF
 VjKtLqWkAsSU2TjDfAgvfY/8vi1i8J8MPonMP4glKhDmnMcZNe6SZjiLR3l/z3WE4p2k
 Z7yNKtrz3A1sxI83NqSNBIwh2SwCBX0mZ/txNjyK93TymgYkbqJjy6WOPd6FAhF+Gzk6
 yJFiIIi5yPTlTADuOr3xKe5oN/B58i0B7IYf7L4x2UjrbT3JkGYEJCXQJ072N5VzHJt6
 4CIQ==
X-Gm-Message-State: APjAAAVtf1NS9LkJxJ4QFm5dyclcqeFVufrj1zB0FucZWcQVsP/FGSDO
 VNJ/84ylqK7khRtwq98QcJqYJxMTmul+7w==
X-Google-Smtp-Source: APXvYqzomLCJYx/cL2Y3xPl6H+nCgLDgGY1Dpcl3zg/Gy0QiI2KGkeC0vp4hL3w58VtjseA/gvieEg==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr46559849wru.235.1582290507235; 
 Fri, 21 Feb 2020 05:08:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/52] arm: allwinner: Wire up USB ports
Date: Fri, 21 Feb 2020 13:07:25 +0000
Message-Id: <20200221130740.7583-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

Instantiate EHCI and OHCI controllers on Allwinner A10. OHCI ports are
modeled as companions of the respective EHCI ports.

With this patch applied, USB controllers are discovered and instantiated
when booting the cubieboard machine with a recent Linux kernel.

ehci-platform 1c14000.usb: EHCI Host Controller
ehci-platform 1c14000.usb: new USB bus registered, assigned bus number 1
ehci-platform 1c14000.usb: irq 26, io mem 0x01c14000
ehci-platform 1c14000.usb: USB 2.0 started, EHCI 1.00
ehci-platform 1c1c000.usb: EHCI Host Controller
ehci-platform 1c1c000.usb: new USB bus registered, assigned bus number 2
ehci-platform 1c1c000.usb: irq 31, io mem 0x01c1c000
ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
ohci-platform 1c14400.usb: Generic Platform OHCI controller
ohci-platform 1c14400.usb: new USB bus registered, assigned bus number 3
ohci-platform 1c14400.usb: irq 27, io mem 0x01c14400
ohci-platform 1c1c400.usb: Generic Platform OHCI controller
ohci-platform 1c1c400.usb: new USB bus registered, assigned bus number 4
ohci-platform 1c1c400.usb: irq 32, io mem 0x01c1c400
usb 2-1: new high-speed USB device number 2 using ehci-platform
usb-storage 2-1:1.0: USB Mass Storage device detected
scsi host1: usb-storage 2-1:1.0
usb 3-1: new full-speed USB device number 2 using ohci-platform
input: QEMU QEMU USB Mouse as /devices/platform/soc/1c14400.usb/usb3/3-1/3-1:1.0/0003:0627:0001.0001/input/input0

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200217204812.9857-4-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-a10.h |  6 +++++
 hw/arm/allwinner-a10.c         | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 40d0b1d9c05..8af724548f0 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -8,12 +8,16 @@
 #include "hw/intc/allwinner-a10-pic.h"
 #include "hw/net/allwinner_emac.h"
 #include "hw/ide/ahci.h"
+#include "hw/usb/hcd-ohci.h"
+#include "hw/usb/hcd-ehci.h"
 
 #include "target/arm/cpu.h"
 
 
 #define AW_A10_SDRAM_BASE       0x40000000
 
+#define AW_A10_NUM_USB          2
+
 #define TYPE_AW_A10 "allwinner-a10"
 #define AW_A10(obj) OBJECT_CHECK(AwA10State, (obj), TYPE_AW_A10)
 
@@ -28,6 +32,8 @@ typedef struct AwA10State {
     AwEmacState emac;
     AllwinnerAHCIState sata;
     MemoryRegion sram_a;
+    EHCISysBusState ehci[AW_A10_NUM_USB];
+    OHCISysBusState ohci[AW_A10_NUM_USB];
 } AwA10State;
 
 #endif
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 1cde1656116..2ae9c15311c 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -24,11 +24,15 @@
 #include "hw/arm/allwinner-a10.h"
 #include "hw/misc/unimp.h"
 #include "sysemu/sysemu.h"
+#include "hw/boards.h"
+#include "hw/usb/hcd-ohci.h"
 
 #define AW_A10_PIC_REG_BASE     0x01c20400
 #define AW_A10_PIT_REG_BASE     0x01c20c00
 #define AW_A10_UART0_REG_BASE   0x01c28000
 #define AW_A10_EMAC_BASE        0x01c0b000
+#define AW_A10_EHCI_BASE        0x01c14000
+#define AW_A10_OHCI_BASE        0x01c14400
 #define AW_A10_SATA_BASE        0x01c18000
 
 static void aw_a10_init(Object *obj)
@@ -49,6 +53,17 @@ static void aw_a10_init(Object *obj)
 
     sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
                           TYPE_ALLWINNER_AHCI);
+
+    if (machine_usb(current_machine)) {
+        int i;
+
+        for (i = 0; i < AW_A10_NUM_USB; i++) {
+            sysbus_init_child_obj(obj, "ehci[*]", OBJECT(&s->ehci[i]),
+                                  sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
+            sysbus_init_child_obj(obj, "ohci[*]", OBJECT(&s->ohci[i]),
+                                  sizeof(s->ohci[i]), TYPE_SYSBUS_OHCI);
+        }
+    }
 }
 
 static void aw_a10_realize(DeviceState *dev, Error **errp)
@@ -121,6 +136,34 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2,
                    qdev_get_gpio_in(dev, 1),
                    115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+
+    if (machine_usb(current_machine)) {
+        int i;
+
+        for (i = 0; i < AW_A10_NUM_USB; i++) {
+            char bus[16];
+
+            sprintf(bus, "usb-bus.%d", i);
+
+            object_property_set_bool(OBJECT(&s->ehci[i]), true,
+                                     "companion-enable", &error_fatal);
+            object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized",
+                                     &error_fatal);
+            sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                            AW_A10_EHCI_BASE + i * 0x8000);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                               qdev_get_gpio_in(dev, 39 + i));
+
+            object_property_set_str(OBJECT(&s->ohci[i]), bus, "masterbus",
+                                    &error_fatal);
+            object_property_set_bool(OBJECT(&s->ohci[i]), true, "realized",
+                                     &error_fatal);
+            sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                            AW_A10_OHCI_BASE + i * 0x8000);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                               qdev_get_gpio_in(dev, 64 + i));
+        }
+    }
 }
 
 static void aw_a10_class_init(ObjectClass *oc, void *data)
-- 
2.20.1


