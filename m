Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B525C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C5C2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Woryavd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C5C2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFeg-0008N6-C9
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY6-0001i2-6O
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY4-0001gZ-VN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id g10so9049597wmh.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=htK8mtOwgg6NqaQcgXgF1B0L0BUGt2l0lT6KthZ3y54=;
 b=Woryavd08L6DDD81kZXyJjD/mgYwX8J3XY2idsVpXnh7bWm9B6KArjdiLYl9UVs6he
 iIqtyGodzE/QoBjd3qITvGe3gOeGVsaLOwR7GzymD0+LdFcPChQnoYg+ZhHmT80UA22U
 fGEZKk8+92s0YwVogQ/NSjHP1vfI/3w23+UbZCt4uWCneYRKs6i3iXe6KJi6c4fWFphH
 cNqWm++bsJpYpyzitpllQQtxcMlepnXyZ1j/3M6hOUuJFj8GbpJLt5lCAS/QYo/z6TbJ
 8fI5kdtY8RUWzaKrVVz0Scfavk+fHZLD93P6y9V4TBToa7BNS90/REp2Clfl/Nw9ZhjY
 hesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=htK8mtOwgg6NqaQcgXgF1B0L0BUGt2l0lT6KthZ3y54=;
 b=keBKRN8ku4xZMxNRw0usntwnpnmVcXun/h4Re5iN8Mdef4EEiDMOPW+F7nbsjMPQu/
 bPjMPgzbbMjOSXt5ze1EdcBPKcEvIrFmUGKr7Bz11SwNgnPdWzhIIL90OFjn4Jr59WZ6
 8Rx3gidCHRl7DS/x4MunEHMkpimGftWHsj75/JxqisPS32XUSc8JCgvipY6un0Tt0JRj
 9awUj5tBN/lVkKGEZOHxpzqAWNCfPRnZWOZvn39jAO8iZ6qu96+Ujd76stu3YGTo3qlG
 rr4JReFUYFOaxatFp2i36+vz/keVrghG34u7SbctxMRaKDIWACjwEUFi5Q1oi1xv4APJ
 6QUg==
X-Gm-Message-State: AOAM530pOv1ai0fCrZwvW81WIB/pUrHyN0i68ZT/nVoiSmecYZkInW6A
 x5HsSTlDlkdsngr72crmFIh2PwlN2gsVSQ==
X-Google-Smtp-Source: ABdhPJzBA9IFlC1Hcfm75iclRWk0+VJ8IAO22Xk6QNsYwLYa4VYum+Y1ErYy8dfSkVusQj1YRFbiPw==
X-Received: by 2002:a1c:dfd7:: with SMTP id w206mr3507957wmg.130.1591375827398; 
 Fri, 05 Jun 2020 09:50:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/29] dwc-hsotg (dwc2) USB host controller state definitions
Date: Fri,  5 Jun 2020 17:49:54 +0100
Message-Id: <20200605165007.12095-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Zimmerman <pauldzim@gmail.com>

Add the dwc-hsotg (dwc2) USB host controller state definitions.
Mostly based on hw/usb/hcd-ehci.h.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
Message-id: 20200520235349.21215-4-pauldzim@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/hcd-dwc2.h | 190 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 hw/usb/hcd-dwc2.h

diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
new file mode 100644
index 00000000000..4ba809a07b8
--- /dev/null
+++ b/hw/usb/hcd-dwc2.h
@@ -0,0 +1,190 @@
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
+typedef struct DWC2Class DWC2Class;
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
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    USBBus bus;
+    qemu_irq irq;
+    MemoryRegion *dma_mr;
+    AddressSpace dma_as;
+    MemoryRegion container;
+    MemoryRegion hsotg;
+    MemoryRegion fifos;
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
+struct DWC2Class {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+    ResettablePhases parent_phases;
+
+    /*< public >*/
+};
+
+#define TYPE_DWC2_USB   "dwc2-usb"
+#define DWC2_USB(obj) \
+    OBJECT_CHECK(DWC2State, (obj), TYPE_DWC2_USB)
+#define DWC2_CLASS(klass) \
+    OBJECT_CLASS_CHECK(DWC2Class, (klass), TYPE_DWC2_USB)
+#define DWC2_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(DWC2Class, (obj), TYPE_DWC2_USB)
+
+#endif
-- 
2.20.1


