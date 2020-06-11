Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03B8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3292074B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZNkGSuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3292074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUCC-0002Xo-Rd
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAl-0002M1-1s
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAi-0001U4-Pe
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xcbD8i3A9N4avhL5fnu9eOklAsAWnY6vq5+mxC0CfFI=;
 b=GZNkGSuu/cH8RRLQCNNRfHyiNeRLxiR9XtlqoCmiV+b3H+0b7KD1N/T+dDcDaNWpoG5yEe
 KTfZddFZehFkg2zR2CNV27E6P/09qPJ9O5YmJPvomov4ZadMovqJKr6kFdlLKDUtjIVjnC
 8bkRvcVBT8UqP6Zf9XzotzlNyrliIN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-4xbkdldbPN6MIkhb0u97zg-1; Thu, 11 Jun 2020 15:47:27 -0400
X-MC-Unique: 4xbkdldbPN6MIkhb0u97zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2D83A0C01;
 Thu, 11 Jun 2020 19:47:26 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FA598FF6A;
 Thu, 11 Jun 2020 19:47:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 111/115] hw/usb: Move device-specific declarations to new
 'hcd-musb.h' header
Date: Thu, 11 Jun 2020 15:44:45 -0400
Message-Id: <20200611194449.31468-112-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Move the declarations for the MUSB-HDRC USB2.0 OTG compliant core
into a separate header.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200601141536.15192-3-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/hcd-musb.c         |  1 +
 hw/usb/tusb6010.c         |  1 +
 include/hw/usb.h          | 30 -------------------------
 include/hw/usb/hcd-musb.h | 46 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 30 deletions(-)
 create mode 100644 include/hw/usb/hcd-musb.h

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
-- 
2.26.2



