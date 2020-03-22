Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0271AC54EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5B82070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx1C96k8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5B82070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG987-0000ty-RX
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 18:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jG95K-0005dV-W9
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jG95J-0001km-Gt
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:46 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jG95J-0001kU-Af
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:45 -0400
Received: by mail-pg1-x542.google.com with SMTP id 7so6175023pgr.2
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TAly9/d/X3HJ3E1hx4IccIxFzwoI83pMuNOPqWOVyM0=;
 b=Fx1C96k8nr2Fj7E5wDYRNXePfOiY5k8ITy3Ole6aDTRiK1RWyC3AA+K1+Gb9tP0XnI
 VYLvWeMOMdox/dTNI7ru/TX2ykQ2BGjBdkqGMZRlefclR/fhW3u2ahqbK+cQ34Ms3wwE
 JQhcWFTmspRSq2nm0nqgtBA4XzhjRjUUdlCDsHec+7unKWqqMs+o4czcHpgp42+3h1ij
 pHYSbP1Him5kK/gdSx5y7B81TPrfVuEEilBwO9VtV+thSxbTNhUn+n6BBDerzNdZmXTv
 UAmaSB+18s6BlpDwelDY9nWPBlbfvLKQsEso0Ha3SWXORAtsN3UtZQ+n+yvu+WjjBqkB
 1whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TAly9/d/X3HJ3E1hx4IccIxFzwoI83pMuNOPqWOVyM0=;
 b=CUcCUfi7zx3kUh48DrZw64zCamokJ5NnyMOI6k04EyBNZG71QeBTyfvZ5KlgKsnTZ8
 xVrQOO+udj5si9Wmaw6N0LeP7i7yxhaF8XNn1npBjVUE6uctYgJmEnZndTW4y7VSm4Zn
 uMHYoT2smrNGHxRWTr81Y2zYpoWGwPv1GnZHfsa9zLzy7+Pj+Y1vzgdzPWpAmUs+gYu+
 yuU14WVN2BggYSVD1wn5fmXMTtsiEYVDcdYEOQhhYgIzcq6UoCf+pOf4R3btj13cmscT
 ZgBtnetnqvCZNG1hKCXY+gC6oWWvuteCZFRMrmqOTUI6VjiLED2VTUB6TJUOOMkkOMl8
 R0/g==
X-Gm-Message-State: ANhLgQ0oqcYJi1FFXo/yM3YZ4seg+NnwO4WA+qbcAAaprYeiG+5qpybT
 SzgMfqp1bmPQgAJmsUvDFBo=
X-Google-Smtp-Source: ADFU+vuUJJ/smFU+T4fto9PT3C8dv6Cn6iXbTstUcHQ5CaoTBYhr4psElpF7SFtCCzk68H+BR/U6XA==
X-Received: by 2002:a62:3487:: with SMTP id
 b129mr21314547pfa.150.1584916124050; 
 Sun, 22 Mar 2020 15:28:44 -0700 (PDT)
Received: from localhost.localdomain ([75.167.220.149])
 by smtp.gmail.com with ESMTPSA id e10sm11440315pfm.121.2020.03.22.15.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 15:28:43 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: kraxel@redhat.com
Subject: [PATCH 3/6] dwc-hsotg USB host controller state definitions
Date: Sun, 22 Mar 2020 15:27:23 -0700
Message-Id: <20200322222726.10244-4-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322222726.10244-1-pauldzim@gmail.com>
References: <20200322222726.10244-1-pauldzim@gmail.com>
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
Cc: peter.maydell@linaro.org, stefanha@gmail.com, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>, jsnow@redhat.com, f4bug@amsat.org
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
index 0000000000..c5f5037b91
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
+        uint32_t glbreg[0x70/sizeof(uint32_t)];
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
+        uint32_t fszreg[0x4/sizeof(uint32_t)];
+        struct {
+            uint32_t hptxfsiz;      /* 100 */
+        };
+    };
+
+    union {
+        uint32_t hreg0[0x44/sizeof(uint32_t)];
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
+    uint32_t hreg1[0x20*NB_CHAN/sizeof(uint32_t)];
+#define hcchar(_ch)     hreg1[((_ch) << 3) + 0] /* 500, 520, ... */
+#define hcsplt(_ch)     hreg1[((_ch) << 3) + 1] /* 504, 524, ... */
+#define hcint(_ch)      hreg1[((_ch) << 3) + 2] /* 508, 528, ... */
+#define hcintmsk(_ch)   hreg1[((_ch) << 3) + 3] /* 50c, 52c, ... */
+#define hctsiz(_ch)     hreg1[((_ch) << 3) + 4] /* 510, 530, ... */
+#define hcdma(_ch)      hreg1[((_ch) << 3) + 5] /* 514, 534, ... */
+#define hcdmab(_ch)     hreg1[((_ch) << 3) + 7] /* 51c, 53c, ... */
+
+    union {
+        uint32_t pcgreg[0x8/sizeof(uint32_t)];
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


