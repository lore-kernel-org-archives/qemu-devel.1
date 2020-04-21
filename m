Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54342C38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFB82078C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcmvrCns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFB82078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQi45-0002eh-4s
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 21:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQi0v-0006Fe-Nw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQi0v-0004k3-1w
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:47:53 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jQi0u-0004eR-0W
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:47:52 -0400
Received: by mail-pg1-x543.google.com with SMTP id r4so6026565pgg.4
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 18:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KF2FAPy1iU0GUQW6HwtRNXsuQel1Sf+Iau8rIWPtQLE=;
 b=pcmvrCnsHh8jrVAYJSXGhweyLnDag5zw5R7S4QS6yypUaSJ1PqG34f1O3CMMJ6bDes
 uR2pqVbDZX+9olGaCYwHolTPGAm89AnY95P7xZAHly7qBfFFG/VUJbEvj3Y/OSrQPN5y
 zB8FLfcWvQK+JMu2Bxqm7iT4RWqvbYVqWmdtr/Be7od1ar98vfXg+wYfN9cClSwgVpuw
 FLQu7h93sg0jQCh7WfmkYAceUmg/YfomvmDnYtmvrxlfvrXcMVrvwQPptdGxKl3g8Apx
 Atrv4m+2VypU3OcejiNEXKzM1P01zFuCdCrlO9TqdlvXV9S8tOOO1c5oPoeyUz6nyA17
 60KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KF2FAPy1iU0GUQW6HwtRNXsuQel1Sf+Iau8rIWPtQLE=;
 b=MpjPRfUROXjFaTpLoZG7wM0iwu8EVQYSsOCXlL2Z+wRD6cV8BPBuxk2/3jorrow9OP
 KRlyMZoTIpf+cV9MlQbvG5ghbrfHB7m/8aIZVT9Q04/if6r2qLf1EM49PXUb3f8DbtcT
 PSbLlsPkzVDkVQuAnEAOlmmB0WfQZTCRmi6Bu5rIbAxjyvcR4Y+jb9mS0I4RW3PFNfBD
 w4RlrHxjoB9I6GNuQzX1EZdOj4i68JDrAoULT35itREnkX8bjduCzB9oK3TSxELWK0+5
 mXOMKKdby6vfSAGb7oiUbgjCsHz9GZ1GZh89ogTmU/EcuuijbbQhH1fjNQ077bi8BiY9
 ij6g==
X-Gm-Message-State: AGi0PuZwxhNxNfQedRV+GxO6fShnRMnt2YVzr0+GF6NrTtVgz4T51Tf0
 LWmZjTcZbnTW789To6j0TSU=
X-Google-Smtp-Source: APiQypL9RsJqwgsX7L/yYSNUS+6Ma+9211njSW/1e6mXhTZY5JrRg9XWnd0hb4seOydmO0OjnjuPzQ==
X-Received: by 2002:a63:b447:: with SMTP id n7mr18618662pgu.278.1587433670362; 
 Mon, 20 Apr 2020 18:47:50 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id q11sm654868pgs.25.2020.04.20.18.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 18:47:49 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 3/7] dwc-hsotg (dwc2) USB host controller state definitions
Date: Mon, 20 Apr 2020 18:45:47 -0700
Message-Id: <20200421014551.10426-4-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421014551.10426-1-pauldzim@gmail.com>
References: <20200421014551.10426-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=pauldzim@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::543
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
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the dwc-hsotg (dwc2) USB host controller state definitions.
Mostly based on hw/usb/hcd-ehci.h.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 hw/usb/hcd-dwc2.h | 184 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100644 hw/usb/hcd-dwc2.h

diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
new file mode 100644
index 0000000000..403afd1747
--- /dev/null
+++ b/hw/usb/hcd-dwc2.h
@@ -0,0 +1,184 @@
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
+#define DWC2_MMIO_SIZE      0x11000
+
+#define DWC2_NB_CHAN        8       /* Number of host channels */
+#define DWC2_MAX_XFER_SIZE  65536   /* Max transfer size expected in HCTSIZ */
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
+    uint32_t devadr;
+    uint32_t epnum;
+    uint32_t epdir;
+    uint32_t mps;
+    uint32_t pid;
+    uint32_t index;
+    uint32_t pcnt;
+    uint32_t len;
+    int32_t async;
+    bool small;
+    bool needs_service;
+};
+
+struct DWC2State {
+    SysBusDevice parent_obj;
+    USBBus bus;
+    qemu_irq irq;
+    MemoryRegion *dma_mr;
+    AddressSpace dma_as;
+    MemoryRegion mem;
+    MemoryRegion mem_glbreg;
+    MemoryRegion mem_fszreg;
+    MemoryRegion mem_hreg0;
+    MemoryRegion mem_hreg1;
+    MemoryRegion mem_pcgreg;
+    MemoryRegion mem_hreg2;
+
+    uint16_t glbregbase;
+    uint16_t fszregbase;
+    uint16_t hreg0base;
+    uint16_t hreg1base;
+    uint16_t pcgregbase;
+    uint16_t hfifobase;
+
+    union {
+#define DWC2_GLBREG_SIZE    0x70
+        uint32_t glbreg[DWC2_GLBREG_SIZE / sizeof(uint32_t)];
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
+#define DWC2_FSZREG_SIZE    0x04
+        uint32_t fszreg[DWC2_FSZREG_SIZE / sizeof(uint32_t)];
+        struct {
+            uint32_t hptxfsiz;      /* 100 */
+        };
+    };
+
+    union {
+#define DWC2_HREG0_SIZE     0x44
+        uint32_t hreg0[DWC2_HREG0_SIZE / sizeof(uint32_t)];
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
+#define DWC2_HREG1_SIZE     (0x20 * DWC2_NB_CHAN)
+    uint32_t hreg1[DWC2_HREG1_SIZE / sizeof(uint32_t)];
+
+#define hcchar(_ch)     hreg1[((_ch) << 3) + 0] /* 500, 520, ... */
+#define hcsplt(_ch)     hreg1[((_ch) << 3) + 1] /* 504, 524, ... */
+#define hcint(_ch)      hreg1[((_ch) << 3) + 2] /* 508, 528, ... */
+#define hcintmsk(_ch)   hreg1[((_ch) << 3) + 3] /* 50c, 52c, ... */
+#define hctsiz(_ch)     hreg1[((_ch) << 3) + 4] /* 510, 530, ... */
+#define hcdma(_ch)      hreg1[((_ch) << 3) + 5] /* 514, 534, ... */
+#define hcdmab(_ch)     hreg1[((_ch) << 3) + 7] /* 51c, 53c, ... */
+
+    union {
+#define DWC2_PCGREG_SIZE    0x08
+        uint32_t pcgreg[DWC2_PCGREG_SIZE / sizeof(uint32_t)];
+        struct {
+            uint32_t pcgctl;        /* e00 */
+            uint32_t pcgcctl1;      /* e04 */
+        };
+    };
+
+    /* TODO - implement FIFO registers for slave mode */
+#define DWC2_HFIFO_SIZE     (0x1000 * DWC2_NB_CHAN)
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
+    uint32_t usb_version;
+    uint16_t frame_number;
+    uint16_t fi;
+    uint16_t next_chan;
+    bool working;
+    USBPort uport;
+    DWC2Packet packet[DWC2_NB_CHAN];                   /* one packet per chan */
+    uint8_t usb_buf[DWC2_NB_CHAN][DWC2_MAX_XFER_SIZE]; /* one buffer per chan */
+};
+
+#define TYPE_DWC2_USB   "dwc2-usb"
+#define DWC2_USB(obj)   OBJECT_CHECK(DWC2State, (obj), TYPE_DWC2_USB)
+
+#endif
-- 
2.17.1


