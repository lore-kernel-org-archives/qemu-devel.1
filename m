Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072E9C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67372076E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkj6uWMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67372076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jILg1-00040l-19
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 20:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jILen-0002OT-Lf
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jILem-0007Pg-8C
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jILem-0007P9-2V
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id x7so6749244pgh.5
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8fsL0XhBWhFnnr1XVrc5f/CVK6jbax3HPezkpV/NUu4=;
 b=Tkj6uWMIWcAViPPG6L0lLk4GtXzs5zzld1aG5yQIg48ZN3mUklFHj2pd3PeElSBFOj
 kZ1Zpde9PhnhPZKJwOj1kKkiVEt0l1s+k28G+cBEnpmsxEtiVB7EdknnHyJCGdTvdF8C
 ztHgIwJme7Kidco1h/FOAI5FTnQwsJNQ31+DFjfBQdVdFPxwilbD9uGqfgiTJ2Q/iw4b
 X2bvb55knZCZ3OiA9+e6Jhb5W6Ebjbwh6O6B4XJqXiT1rFwXr3P02HoTO+X24g2Wy/4u
 IIzPbUqEGCqDUlPM7bPWzH1ASamh/DxVWeLRFFQl6iLLtyqMS+Ee2NYTNJuOoZUyxDr6
 IirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8fsL0XhBWhFnnr1XVrc5f/CVK6jbax3HPezkpV/NUu4=;
 b=V7Un3kOjYKHJc2mVkQ18hHeBs6LopTxyF2gvQuTtNiJm8l5xOnhre4eIlkdyS6zIix
 PsLVVL+nC+c+rpS+jB39AJQBpfyl0mO/cE+MW9pPK3ZO5dbrGB7cNjOGcfOjAuvdxMeu
 0Y78j0K/zqjgZPYxEwH5b6WgZK4TihQfs0E7GJGBeNPuvrQKb+dr9PMY3yL4GYLpm472
 OGt0wa/+ZRjgArKXWd8EbfK2PVju1tcmNuqpEd472NReCoMEBNstKs3egpry/T6MgFco
 0jy6GMBjl2srpZ8/kU7vx/2/AAy6fP07ebF5K1luIzvuYbT1nkost/BvjNSVgJyWC0ep
 LM4w==
X-Gm-Message-State: ANhLgQ1lCLik+gpnvwJKca1BtMKtlnM+eZnAEPpm9qu6eYCzSxbFoGU0
 vA8LiD6uJABI1d1+Cs45MG8=
X-Google-Smtp-Source: ADFU+vtGsl6Ur255dJTMyFmkEtj5keVvgQhLj9Rb+V5lfBCAZBzo49HplIt62xeTPxeZR8V7rpkLgQ==
X-Received: by 2002:a63:a601:: with SMTP id t1mr6489358pge.23.1585441106037;
 Sat, 28 Mar 2020 17:18:26 -0700 (PDT)
Received: from paulz-G33T-M.Home ([75.167.220.149])
 by smtp.gmail.com with ESMTPSA id u14sm6626890pgg.67.2020.03.28.17.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2020 17:18:25 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/6] dwc-hsotg USB host controller state definitions
Date: Sat, 28 Mar 2020 17:17:02 -0700
Message-Id: <20200329001705.15966-4-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329001705.15966-1-pauldzim@gmail.com>
References: <20200329001705.15966-1-pauldzim@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the dwc-hsotg (dwc2) USB host controller state definitions.
Mostly based on hw/usb/hcd-ehci.h.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 hw/usb/hcd-dwc2.h | 180 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 hw/usb/hcd-dwc2.h

diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
new file mode 100644
index 0000000000..80956fa318
--- /dev/null
+++ b/hw/usb/hcd-dwc2.h
@@ -0,0 +1,180 @@
+/*
+ * dwc-hsotg (dwc2) USB host controller state definitions
+ *
+ * Based on hw/usb/hcd-ehci.h
+ *
+ * Copyright (c) 2020 Paul Zimmerman <pauldzim@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef HW_USB_DWC2_H
+#define HW_USB_DWC2_H
+
+#include "qemu/timer.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/usb.h"
+#include "sysemu/dma.h"
+
+#define DWC2_MMIO_SIZE  0x11000
+
+#define NB_PORTS        1       /* Number of downstream ports */
+#define NB_CHAN         8       /* Number of host channels */
+#define MAX_XFER_SIZE   65536   /* Max transfer size expected in HCTSIZ */
+
+typedef struct DWC2Packet DWC2Packet;
+typedef struct DWC2State DWC2State;
+
+enum async_state {
+    DWC2_ASYNC_NONE = 0,
+    DWC2_ASYNC_INITIALIZED,
+    DWC2_ASYNC_INFLIGHT,
+    DWC2_ASYNC_FINISHED,
+};
+
+struct DWC2Packet {
+    USBPacket packet;
+    USBDevice *dev;
+    USBEndpoint *ep;
+    uint32_t index;
+    uint32_t epnum;
+    uint32_t mps;
+    uint32_t pid;
+    uint32_t pcnt;
+    uint32_t len;
+    bool small;
+    bool needs_service;
+    enum async_state async;
+};
+
+struct DWC2State {
+    SysBusDevice parent_obj;
+    USBBus bus;
+    DeviceState *device;
+    qemu_irq irq;
+    MemoryRegion *dma_mr;
+    AddressSpace *as;
+    AddressSpace dma_as;
+    MemoryRegion mem;
+    MemoryRegion mem_glbreg;
+    MemoryRegion mem_fszreg;
+    MemoryRegion mem_hreg0;
+    MemoryRegion mem_hreg1;
+    MemoryRegion mem_pcgreg;
+    MemoryRegion mem_hreg2;
+    uint16_t glbregbase;
+    uint16_t fszregbase;
+    uint16_t hreg0base;
+    uint16_t hreg1base;
+    uint16_t pcgregbase;
+    uint16_t hreg2base;
+    uint16_t portnr;
+
+    union {
+        uint32_t glbreg[0x70 / sizeof(uint32_t)];
+        struct {
+            uint32_t gotgctl;       /* 00 */
+            uint32_t gotgint;       /* 04 */
+            uint32_t gahbcfg;       /* 08 */
+            uint32_t gusbcfg;       /* 0c */
+            uint32_t grstctl;       /* 10 */
+            uint32_t gintsts;       /* 14 */
+            uint32_t gintmsk;       /* 18 */
+            uint32_t grxstsr;       /* 1c */
+            uint32_t grxstsp;       /* 20 */
+            uint32_t grxfsiz;       /* 24 */
+            uint32_t gnptxfsiz;     /* 28 */
+            uint32_t gnptxsts;      /* 2c */
+            uint32_t gi2cctl;       /* 30 */
+            uint32_t gpvndctl;      /* 34 */
+            uint32_t ggpio;         /* 38 */
+            uint32_t guid;          /* 3c */
+            uint32_t gsnpsid;       /* 40 */
+            uint32_t ghwcfg1;       /* 44 */
+            uint32_t ghwcfg2;       /* 48 */
+            uint32_t ghwcfg3;       /* 4c */
+            uint32_t ghwcfg4;       /* 50 */
+            uint32_t glpmcfg;       /* 54 */
+            uint32_t gpwrdn;        /* 58 */
+            uint32_t gdfifocfg;     /* 5c */
+            uint32_t gadpctl;       /* 60 */
+            uint32_t grefclk;       /* 64 */
+            uint32_t gintmsk2;      /* 68 */
+            uint32_t gintsts2;      /* 6c */
+        };
+    };
+
+    union {
+        uint32_t fszreg[0x4 / sizeof(uint32_t)];
+        struct {
+            uint32_t hptxfsiz;      /* 100 */
+        };
+    };
+
+    union {
+        uint32_t hreg0[0x44 / sizeof(uint32_t)];
+        struct {
+            uint32_t hcfg;          /* 400 */
+            uint32_t hfir;          /* 404 */
+            uint32_t hfnum;         /* 408 */
+            uint32_t rsvd0;         /* 40c */
+            uint32_t hptxsts;       /* 410 */
+            uint32_t haint;         /* 414 */
+            uint32_t haintmsk;      /* 418 */
+            uint32_t hflbaddr;      /* 41c */
+            uint32_t rsvd1[8];      /* 420-43c */
+            uint32_t hprt0;         /* 440 */
+        };
+    };
+
+    uint32_t hreg1[0x20 * NB_CHAN / sizeof(uint32_t)];
+#define hcchar(_ch)     hreg1[((_ch) << 3) + 0] /* 500, 520, ... */
+#define hcsplt(_ch)     hreg1[((_ch) << 3) + 1] /* 504, 524, ... */
+#define hcint(_ch)      hreg1[((_ch) << 3) + 2] /* 508, 528, ... */
+#define hcintmsk(_ch)   hreg1[((_ch) << 3) + 3] /* 50c, 52c, ... */
+#define hctsiz(_ch)     hreg1[((_ch) << 3) + 4] /* 510, 530, ... */
+#define hcdma(_ch)      hreg1[((_ch) << 3) + 5] /* 514, 534, ... */
+#define hcdmab(_ch)     hreg1[((_ch) << 3) + 7] /* 51c, 53c, ... */
+
+    union {
+        uint32_t pcgreg[0x8 / sizeof(uint32_t)];
+        struct {
+            uint32_t pcgctl;        /* e00 */
+            uint32_t pcgcctl1;      /* e04 */
+        };
+    };
+
+    /* TODO - implement FIFO registers for slave mode */
+
+    /*
+     *  Internal state
+     */
+    QEMUTimer *eof_timer;
+    QEMUTimer *frame_timer;
+    QEMUBH *async_bh;
+    int64_t sof_time;
+    int64_t usb_frame_time;
+    int64_t usb_bit_time;
+    uint16_t frame_number;
+    uint16_t fsmps;
+    uint16_t fi;
+    uint16_t next_chan;
+    bool working;
+    USBPort ports[NB_PORTS];
+    DWC2Packet packet[NB_CHAN];                 /* one packet per channel */
+    uint8_t usb_buf[NB_CHAN][MAX_XFER_SIZE];    /* one buffer per channel */
+};
+
+#define TYPE_DWC2_USB   "dwc2-usb"
+#define DWC2_USB(obj)   OBJECT_CHECK(DWC2State, (obj), TYPE_DWC2_USB)
+
+#endif
-- 
2.17.1


