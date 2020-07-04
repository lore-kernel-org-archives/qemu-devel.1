Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78C5C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A133206B7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2lwgSpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A133206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjik-0002Ot-O4
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUv-0002IR-4l; Sat, 04 Jul 2020 10:50:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUs-0003ul-TR; Sat, 04 Jul 2020 10:50:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so34715789wmi.3;
 Sat, 04 Jul 2020 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fJVcVH4doVw6Km6BSM1MV1lDhvP8r9rvGpMs+kFykbo=;
 b=K2lwgSpyWnjq/h8TiOfPsKpInIWHa5+dz+1p8VTR4XavTCAi4oZM+nXkVl8WOqLewb
 ozsFFf2OwYpYbdZ3eiEwdCdNFB8xk060HSlm2pDLSmkmpqjw2t8zgC7WWS6Rtc2pYFI6
 pVhqULi6RzwvieAFZ+T/B0GoMZz0xSebo4MS/liGeIh0HixD4qcgipHRgT3GteBbaP3O
 NfDFlBiaubRh22WagrqyVHDevz3RsDYDG2zHsljANg3QGj+roWzdwYDe+wIiXCkn/EDo
 Tg6k/KyVg3AsKT99KsfBndK/TZAZVe77NfLq7pdi2mAnr6zr2XQ1x/QBBG4elYDZy0FK
 QunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fJVcVH4doVw6Km6BSM1MV1lDhvP8r9rvGpMs+kFykbo=;
 b=kVRRT5Hk9LLV9+iq0VVanKa9JYUrJGCs1Dz67bTvLaPzzVhZTuhz5oJ82rMc64wgg5
 7N1gpm0Ds1KZm1gBxIBId+GtpPa93d9QQE08F3USkF1e6VEOIsu4JVdCHSgrg8QPT/+d
 mNuQVNz5+Cz2MnoUfYO7WrvSUWekHTOViIrVcoplxGF8QvbvG2iuKhMuI+2d65+PurVy
 vhhd47yLGo1G9xwOJUdmpcJxghE/a5vrfj2KdQOFtZhI2Rd585RwZ7rfPL1EE8sjeLpv
 M7hWWSwMoiYXChX504HMwoklasvhpR4MHaqNO1S3OtU3bKAZegj1Dqi0V1MHronrKzMe
 oCNg==
X-Gm-Message-State: AOAM531UMOIXrvpXGObqkFereM6aZHtxSwu/Knwr5XUywB3a4ULETUBC
 +r9KjE2i8XuHLpFkPRkHl0eD5Vdj5AY=
X-Google-Smtp-Source: ABdhPJwBkQVEoJtyk9IO8+500AN1sxUzaC/kjPlQwjEVcQTj3r8o+ql1zItIAXJmSwL9GUWTiy5ETg==
X-Received: by 2002:a1c:5986:: with SMTP id
 n128mr28975302wmb.112.1593874228406; 
 Sat, 04 Jul 2020 07:50:28 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 20/26] hw/usb: Introduce "hw/usb/usb.h" public API
Date: Sat,  4 Jul 2020 16:49:37 +0200
Message-Id: <20200704144943.18292-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only the USB devices require to access the USB internal APIs.

The rest of the code base only wants to consume USB devices
with a generic API. Move the generic declarations to the new
"hw/usb/usb.h" header.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/usb.h      | 27 +-------------------
 include/hw/usb/usb.h  | 58 +++++++++++++++++++++++++++++++++++++++++++
 chardev/baum.c        |  2 +-
 hw/i386/pc.c          |  2 +-
 hw/i386/pc_piix.c     |  2 +-
 hw/i386/pc_q35.c      |  2 +-
 hw/ppc/mac_newworld.c |  2 +-
 hw/ppc/sam460ex.c     |  1 +
 hw/ppc/spapr.c        |  2 +-
 hw/sh4/r2d.c          |  2 +-
 hw/usb/host-stub.c    |  2 +-
 monitor/misc.c        |  2 +-
 softmmu/vl.c          |  2 +-
 13 files changed, 70 insertions(+), 36 deletions(-)
 create mode 100644 include/hw/usb/usb.h

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 7ea502d421..2ea5186ea5 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -26,6 +26,7 @@
  */
 
 #include "hw/qdev-core.h"
+#include "hw/usb/usb.h"
 #include "qemu/iov.h"
 #include "qemu/queue.h"
 
@@ -176,7 +177,6 @@
 typedef struct USBBus USBBus;
 typedef struct USBBusOps USBBusOps;
 typedef struct USBPort USBPort;
-typedef struct USBDevice USBDevice;
 typedef struct USBPacket USBPacket;
 typedef struct USBCombinedPacket USBCombinedPacket;
 typedef struct USBEndpoint USBEndpoint;
@@ -256,9 +256,6 @@ struct USBDevice {
     const USBDescIface  *ifaces[USB_MAX_INTERFACES];
 };
 
-#define TYPE_USB_DEVICE "usb-device"
-#define USB_DEVICE(obj) \
-     OBJECT_CHECK(USBDevice, (obj), TYPE_USB_DEVICE)
 #define USB_DEVICE_CLASS(klass) \
      OBJECT_CLASS_CHECK(USBDeviceClass, (klass), TYPE_USB_DEVICE)
 #define USB_DEVICE_GET_CLASS(obj) \
@@ -459,15 +456,8 @@ void usb_device_reset(USBDevice *dev);
 void usb_wakeup(USBEndpoint *ep, unsigned int stream);
 void usb_generic_async_ctrl_complete(USBDevice *s, USBPacket *p);
 
-/* usb-linux.c */
-void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
-bool usb_host_dev_is_scsi_storage(USBDevice *usbdev);
-
 /* usb-bus.c */
 
-#define TYPE_USB_BUS "usb-bus"
-#define USB_BUS(obj) OBJECT_CHECK(USBBus, (obj), TYPE_USB_BUS)
-
 struct USBBus {
     BusState qbus;
     USBBusOps *ops;
@@ -489,13 +479,8 @@ struct USBBusOps {
 void usb_bus_new(USBBus *bus, size_t bus_size,
                  USBBusOps *ops, DeviceState *host);
 void usb_bus_release(USBBus *bus);
-USBBus *usb_bus_find(int busnr);
 void usb_legacy_register(const char *typename, const char *usbdevice_name,
                          USBDevice *(*usbdevice_init)(const char *params));
-USBDevice *usb_new(const char *name);
-bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp);
-USBDevice *usb_create_simple(USBBus *bus, const char *name);
-USBDevice *usbdevice_create(const char *cmdline);
 void usb_register_port(USBBus *bus, USBPort *port, void *opaque, int index,
                        USBPortOps *ops, int speedmask);
 void usb_register_companion(const char *masterbus, USBPort *ports[],
@@ -506,16 +491,6 @@ void usb_port_location(USBPort *downstream, USBPort *upstream, int portnr);
 void usb_unregister_port(USBBus *bus, USBPort *port);
 void usb_claim_port(USBDevice *dev, Error **errp);
 void usb_release_port(USBDevice *dev);
-/**
- * usb_get_port_path:
- * @dev: the USB device
- *
- * The returned data must be released with g_free()
- * when no longer required.
- *
- * Returns: a dynamically allocated pathname.
- */
-char *usb_get_port_path(USBDevice *dev);
 void usb_device_attach(USBDevice *dev, Error **errp);
 int usb_device_detach(USBDevice *dev);
 void usb_check_attach(USBDevice *dev, Error **errp);
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h
new file mode 100644
index 0000000000..9a13b08503
--- /dev/null
+++ b/include/hw/usb/usb.h
@@ -0,0 +1,58 @@
+/*
+ * QEMU USB API
+ *
+ * Copyright (c) 2005 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#ifndef QEMU_HW_USB_H
+#define QEMU_HW_USB_H
+
+typedef struct USBDevice USBDevice;
+
+#define TYPE_USB_DEVICE "usb-device"
+#define USB_DEVICE(obj) \
+     OBJECT_CHECK(USBDevice, (obj), TYPE_USB_DEVICE)
+
+typedef struct USBBus USBBus;
+
+#define TYPE_USB_BUS "usb-bus"
+#define USB_BUS(obj) OBJECT_CHECK(USBBus, (obj), TYPE_USB_BUS)
+
+USBBus *usb_bus_find(int busnr);
+USBDevice *usb_new(const char *name);
+bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp);
+USBDevice *usb_create_simple(USBBus *bus, const char *name);
+USBDevice *usbdevice_create(const char *cmdline);
+
+/**
+ * usb_get_port_path:
+ * @dev: the USB device
+ *
+ * The returned data must be released with g_free()
+ * when no longer required.
+ *
+ * Returns: a dynamically allocated pathname.
+ */
+char *usb_get_port_path(USBDevice *dev);
+
+void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
+bool usb_host_dev_is_scsi_storage(USBDevice *usbdev);
+
+#endif
diff --git a/chardev/baum.c b/chardev/baum.c
index 9c95e7bc79..fc04bf2e2f 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "ui/console.h"
 #include <brlapi.h>
 #include <brlapi_constants.h>
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4af9679d03..a890f57ac2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -83,7 +83,7 @@
 #include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
 #include "hw/core/cpu.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
 #include "standard-headers/asm-x86/bootparam.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1d832b2878..4d1de7cfab 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -36,7 +36,7 @@
 #include "hw/firmware/smbios.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "net/net.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 047ea8db28..b985f5bea1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -50,7 +50,7 @@
 #include "hw/firmware/smbios.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 828c5992ae..7bf69f4a1f 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -69,7 +69,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
 #include "kvm_ppc.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"
 #include "trace.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index fae970b142..781b45e14b 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -35,6 +35,7 @@
 #include "hw/char/serial.h"
 #include "hw/i2c/ppc4xx_i2c.h"
 #include "hw/i2c/smbus_eeprom.h"
+#include "hw/usb/usb.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/ppc/fdt.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 221d3e7a8c..0c0409077f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -70,7 +70,7 @@
 
 #include "exec/address-spaces.h"
 #include "exec/ram_addr.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "trace.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 443820901d..a39c378855 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -40,7 +40,7 @@
 #include "hw/ide.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/block/flash.h"
 #include "exec/address-spaces.h"
 
diff --git a/hw/usb/host-stub.c b/hw/usb/host-stub.c
index 538ed29684..11b754892d 100644
--- a/hw/usb/host-stub.c
+++ b/hw/usb/host-stub.c
@@ -32,7 +32,7 @@
 
 #include "qemu/osdep.h"
 #include "ui/console.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "monitor/monitor.h"
 
 void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
diff --git a/monitor/misc.c b/monitor/misc.c
index 89bb970b00..65c0f887dd 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -26,7 +26,7 @@
 #include "monitor-internal.h"
 #include "cpu.h"
 #include "monitor/qdev.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/pci/pci.h"
 #include "sysemu/watchdog.h"
 #include "hw/loader.h"
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3e15ee2435..25a13e913e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -41,7 +41,7 @@
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "sysemu/accel.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/isa/isa.h"
 #include "hw/scsi/scsi.h"
 #include "hw/display/vga.h"
-- 
2.21.3


