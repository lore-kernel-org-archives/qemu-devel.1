Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88275C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5249920738
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7KgInLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5249920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jflFX-0004iE-FG
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 10:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflE9-0002xI-CV; Mon, 01 Jun 2020 10:15:45 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflE7-0007y9-RT; Mon, 01 Jun 2020 10:15:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id k26so11542055wmi.4;
 Mon, 01 Jun 2020 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W1QfjnoxgOl1dLnHFXbO/n4gzPKJ9EZXLUkU+m3W2Dk=;
 b=m7KgInLWpq8xaaOgriflsimDe2GR6UhauuP6MsGZtUdinXY4Vpg7QvQa96AMu2iKBX
 acEFhFXNj7Rxow0aSEwpL4Xu6x9sdOdlnV7IFOoRIGLKqnJqkLhAnVK2sctCe6+H4G6E
 aC++B0/GxT8O6nEqH4D0VllsiLk1tnKPjCuIxTHVEXLOngxV+z2NPpDIFYAP/hKyUctX
 4jUYWFVsWO9saKGIs7GZHKjFd//3WP9sDAl2NArcCiB9NeQ3ami9cimx6nX4Ka1A4r/Z
 kP84Ad+9Z6ON/QU506mN+g13+ML++Ows+NwQ8yYo7P1KsI+GZ3s24m0fFimIuf97CSYy
 1S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W1QfjnoxgOl1dLnHFXbO/n4gzPKJ9EZXLUkU+m3W2Dk=;
 b=BQmvn8q/eNv7j2xCqpfOZXWrSLzDZDY51Ot3vn9bz8ZxvHtYIxIvcaZ5NJnR7Ce9hx
 WjojBmzCSs5Xmck0nOywnNOw6OeHtVdymcUBl9aHxIhQkKNwlOcRpApnyw7dKAeb3Qsv
 260irJm36Hih307vJdXSTOAVadJEOxDEkGky4PEI0nlcie9aEFm7ohWLEfKzfIX5KvHT
 ynSHew8Nv5oyb9EYUn1Z8ZvkbfiuublwPVtRuWpUDnBfnSMMpv5lFPatwov+Tz2t9yRN
 gmQoyFw17MK0kbKqwbV9cyDWPN7Infq8Jmz6JVkvVlVSQhatuAK/ErYYEdsE/13NRuyW
 xCEQ==
X-Gm-Message-State: AOAM531Hni+5ITdz887N0xoI34sul+0f1WYjUmJt/OXwdckU/34tI7y3
 C48x+Fjsy22kAwov5roKF6THPrnm
X-Google-Smtp-Source: ABdhPJz8TmPwL4zTqTOiZI3hrQSYxJHcxwjQKmJjBNep+TD8EU/GTQD9oeE/GtxgCVzHiunwljbfQQ==
X-Received: by 2002:a05:600c:21c2:: with SMTP id
 x2mr22018833wmj.33.1591020941824; 
 Mon, 01 Jun 2020 07:15:41 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a124sm12864182wmh.4.2020.06.01.07.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 07:15:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/usb: Move device-specific declarations to new
 'hcd-musb.h' header
Date: Mon,  1 Jun 2020 16:15:35 +0200
Message-Id: <20200601141536.15192-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601141536.15192-1-f4bug@amsat.org>
References: <20200601141536.15192-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the declarations for the MUSB-HDRC USB2.0 OTG compliant core
into a separate header.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/usb.h          | 30 -------------------------
 include/hw/usb/hcd-musb.h | 46 +++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-musb.c         |  1 +
 hw/usb/tusb6010.c         |  1 +
 4 files changed, 48 insertions(+), 30 deletions(-)
 create mode 100644 include/hw/usb/hcd-musb.h

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
diff --git a/include/hw/usb/hcd-musb.h b/include/hw/usb/hcd-musb.h
new file mode 100644
index 0000000000..26b50132ff
--- /dev/null
+++ b/include/hw/usb/hcd-musb.h
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
index c29fbef6fc..5ab13feb3a 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
+#include "hw/usb/hcd-musb.h"
 #include "hw/irq.h"
 #include "hw/hw.h"
 
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 17580876c6..27eb28d3e4 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
+#include "hw/usb/hcd-musb.h"
 #include "hw/arm/omap.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
-- 
2.21.3


