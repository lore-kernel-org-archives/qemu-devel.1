Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A467C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEDB20734
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvSKw8Jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEDB20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jffIr-0007Uv-6q
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 03:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffGq-0004Vg-RK
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 03:54:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffGq-0003mm-0y
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 03:54:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id d128so10374356wmc.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mDZ0iETBYXQfVbBgPLGAWay8LlgGpDy5q0Nf9qu06w4=;
 b=NvSKw8JpIyw03UQFM1f88VuMO1ro8hw2sN5pqSUa5I6kYKG6YGeqdsuHKsFjAxeiNg
 dZ/96rZ8xGpt9v2PvuLDOaUHg5ZABeqHQCoJklqgV8urfEaCatKaYN8mRUlP2ir585WC
 8Wde3uexd/jb+OUqFuwmfHeJ9n5Ee5cqymdg/pf2cyUhky5cEDc6L+SrdyHvxShUepBq
 ECennE7OrbwjydiR+O8cvjfSD6i0r7iLuEL0Mzi4BLZ9nLTu7smVZgLfyaJ4W3GnwNMd
 XVrFaH+TfEo0EkMw8qEn2OUwH/x3pO9HvG7zjm4faEoXyaIR4SQK3FFujvv3ryFAUU6R
 dhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mDZ0iETBYXQfVbBgPLGAWay8LlgGpDy5q0Nf9qu06w4=;
 b=aT5fcivWsQHLWNQ3mwYco8Bt204Nqhw0fHmdhHwidnIcTBoon0iPa4DSGKn2Rz29Qi
 IiTXnZIFfE/SuA+Wo8lJf8wXR9HBP6ptYOwMW0e0YHV1de9q8Xkd5VK6hKlD5sHe+fRs
 HmD2zg+RwUdDwXJfpd9YAFqpfHYXE8z4ptf/7wm+SPfIuwQyMuOz3JL5B8E3k9LBq8IW
 tK6y2ytV64wxGSvxOYRZjT0xBPeHmYwdW3Em25I3TAYP35mr9NcOEUAHkuKOpYr7nHVx
 yEVncvm1qrcpxCrzJumPBAkNuzVDOnT1o3MVm5as/AAPa3Q5ROwOkBoObYYivpSuO0AN
 ivAA==
X-Gm-Message-State: AOAM531Qf1T7ycE7Q4huYPwptBkAuHfVSLo/3DJDghUoaRe4sDg7W0wW
 0pXaEZx/yfA6F2fGBGFmCbXyet3e
X-Google-Smtp-Source: ABdhPJzdIc2nOYs8MBpS2TDm4GGWt5YDVwc8WSa58g0d3CS+DmVUPbxdOyrU6xGdPPFjOIHIoIBlIA==
X-Received: by 2002:a05:600c:1146:: with SMTP id
 z6mr20222204wmz.179.1590998046478; 
 Mon, 01 Jun 2020 00:54:06 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id b18sm19294949wrn.88.2020.06.01.00.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 00:54:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/usb: Move device-specific declarations to new 'musb.h'
 header
Date: Mon,  1 Jun 2020 09:53:59 +0200
Message-Id: <20200601075400.2043-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601075400.2043-1-f4bug@amsat.org>
References: <20200601075400.2043-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the declarations for the MUSB-HDRC USB2.0 OTG compliant core
into a separate header.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/usb.h      | 30 ----------------------------
 include/hw/usb/musb.h | 46 +++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-musb.c     |  1 +
 hw/usb/tusb6010.c     |  1 +
 4 files changed, 48 insertions(+), 30 deletions(-)
 create mode 100644 include/hw/usb/musb.h

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 1cf1cd9584..e2128c7c45 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -474,36 +474,6 @@ bool usb_host_dev_is_scsi_storage(USBDevice *usbdev);
 
 #define VM_USB_HUB_SIZE 8
 
-/* hw/usb/hdc-musb.c */
-
-enum musb_irq_source_e {
-    musb_irq_suspend = 0,
-    musb_irq_resume,
-    musb_irq_rst_babble,
-    musb_irq_sof,
-    musb_irq_connect,
-    musb_irq_disconnect,
-    musb_irq_vbus_request,
-    musb_irq_vbus_error,
-    musb_irq_rx,
-    musb_irq_tx,
-    musb_set_vbus,
-    musb_set_session,
-    /* Add new interrupts here */
-    musb_irq_max, /* total number of interrupts defined */
-};
-
-typedef struct MUSBState MUSBState;
-
-extern CPUReadMemoryFunc * const musb_read[];
-extern CPUWriteMemoryFunc * const musb_write[];
-
-MUSBState *musb_init(DeviceState *parent_device, int gpio_base);
-void musb_reset(MUSBState *s);
-uint32_t musb_core_intr_get(MUSBState *s);
-void musb_core_intr_clear(MUSBState *s, uint32_t mask);
-void musb_set_size(MUSBState *s, int epnum, int size, int is_tx);
-
 /* usb-bus.c */
 
 #define TYPE_USB_BUS "usb-bus"
diff --git a/include/hw/usb/musb.h b/include/hw/usb/musb.h
new file mode 100644
index 0000000000..26b50132ff
--- /dev/null
+++ b/include/hw/usb/musb.h
@@ -0,0 +1,46 @@
+/*
+ * "Inventra" High-speed Dual-Role Controller (MUSB-HDRC), Mentor Graphics,
+ * USB2.0 OTG compliant core used in various chips.
+ *
+ * Only host-mode and non-DMA accesses are currently supported.
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Written by Andrzej Zaborowski <balrog@zabor.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_USB_MUSB_H
+#define HW_USB_MUSB_H
+
+#include "exec/cpu-common.h"
+
+enum musb_irq_source_e {
+    musb_irq_suspend = 0,
+    musb_irq_resume,
+    musb_irq_rst_babble,
+    musb_irq_sof,
+    musb_irq_connect,
+    musb_irq_disconnect,
+    musb_irq_vbus_request,
+    musb_irq_vbus_error,
+    musb_irq_rx,
+    musb_irq_tx,
+    musb_set_vbus,
+    musb_set_session,
+    /* Add new interrupts here */
+    musb_irq_max /* total number of interrupts defined */
+};
+
+extern CPUReadMemoryFunc * const musb_read[];
+extern CPUWriteMemoryFunc * const musb_write[];
+
+typedef struct MUSBState MUSBState;
+
+MUSBState *musb_init(DeviceState *parent_device, int gpio_base);
+void musb_reset(MUSBState *s);
+uint32_t musb_core_intr_get(MUSBState *s);
+void musb_core_intr_clear(MUSBState *s, uint32_t mask);
+void musb_set_size(MUSBState *s, int epnum, int size, int is_tx);
+
+#endif
diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index c29fbef6fc..ea7a89fd0c 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
+#include "hw/usb/musb.h"
 #include "hw/irq.h"
 #include "hw/hw.h"
 
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 17580876c6..52cf6ec9b8 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
+#include "hw/usb/musb.h"
 #include "hw/arm/omap.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
-- 
2.21.3


