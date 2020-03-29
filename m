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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C68C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277AE20732
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwO96i1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277AE20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jILiD-0008Dm-B9
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 20:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jILev-0002cl-BY
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jILeq-0007T6-MR
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:37 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:38425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jILeq-0007Rs-B2
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:32 -0400
Received: by mail-pl1-x62c.google.com with SMTP id w3so5117011plz.5
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=z4T8niSba4SuCbxmbjwzidJiFfjIc+qG+EJGRVvgEaI=;
 b=VwO96i1PRA3GN+Sjrdfo46JNaux1qyu8vAjRBSF10gbFVPeGFxxHuG7xUwy9BnjTBU
 5iGTRVYgGTHgqzmb9MS3VfrZuw52P4mnJY4vDZi0yzMISFcrFKWmgwNPK3uVJtc2wg7m
 AN1Ws3X7oh25p2vrg2vSrwjZA5FUrtfoJYOYEVhbDAEkoWKKmvbLkmRnsYcoRiY2uLdl
 Fm0lbD1/chG+IOyO/6ZSC5MgYzBAnGoBao3MHeWsxhRv7LYjb0Kqd5F87q2ieKYzsYfe
 LyzfT8bNgWTWox2g97GYTKKiCgKBe2cCJScBm1iZiLoFaYh1Z86I3+I+gpWJkX5rZLjm
 3HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=z4T8niSba4SuCbxmbjwzidJiFfjIc+qG+EJGRVvgEaI=;
 b=h327K/fOyyJOFq0jN9bY+IWFzvOHSsTHfkdSQ6vtoLmUj/H8SjYE72o61ZBOMYmjqG
 fTJBiM8Hh8xlsBodk+2CA3UVxTgO/jJLuKMZLdAmUEUAg16/k17SA6UBXWgQ7L3U8xYC
 POEJ4rPiVyoulXgL9K3irxjuLLX0S4kI55mWeSywmtI2erLVVvyZGJpA+fXbud6MN6ST
 4GTVHrc4z0D1o+plpBFHdNPFd8N9iIml2Z+arZh3GjceZPGGqMI/8+TY4Oh4khnyvoSj
 DB8xuQtXXVvAEkfwpoHhc8aUmp2EcA1NUtHLJlhX4ZfmsORp3MWMbOT2CnlyIjkKfmjB
 0X5A==
X-Gm-Message-State: ANhLgQ1cyjoVbbD5UyFdaqxE6Qa9SKBh6OAQWSPoyKReL3jjml7/RJaN
 z9/SO2xuiCgKfzV9z02GA68=
X-Google-Smtp-Source: ADFU+vuoHwaqKnC5G201OrAWT6URJUaSIhKG4Eso2PaEorNKuoZZF7txESjO/NjDA60r++LZSA+jfQ==
X-Received: by 2002:a17:902:6b49:: with SMTP id
 g9mr6058277plt.305.1585441111000; 
 Sat, 28 Mar 2020 17:18:31 -0700 (PDT)
Received: from paulz-G33T-M.Home ([75.167.220.149])
 by smtp.gmail.com with ESMTPSA id u14sm6626890pgg.67.2020.03.28.17.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2020 17:18:30 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 4/6] dwc-hsotg USB host controller emulation
Date: Sat, 28 Mar 2020 17:17:03 -0700
Message-Id: <20200329001705.15966-5-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329001705.15966-1-pauldzim@gmail.com>
References: <20200329001705.15966-1-pauldzim@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
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

Add the dwc-hsotg (dwc2) USB host controller emulation code.
Based on hw/usb/hcd-ehci.c and hw/usb/hcd-ohci.c.

Note that to use this with the dwc-otg driver in the Raspbian
kernel, you must pass the option "dwc_otg.fiq_fsm_enable=0" on
the kernel command line.

Emulation of slave mode and of descriptor-DMA mode has not been
implemented yet. These modes are seldom used.

I have used some on-line sources of information while developing
this emulation, including:

http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
has a pretty complete description of the controller starting on
page 370.

https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf
has a description of the controller registers starting on page
130.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 hw/usb/hcd-dwc2.c   | 1301 +++++++++++++++++++++++++++++++++++++++++++
 hw/usb/trace-events |   47 ++
 2 files changed, 1348 insertions(+)
 create mode 100644 hw/usb/hcd-dwc2.c

diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
new file mode 100644
index 0000000000..fd85543f4d
--- /dev/null
+++ b/hw/usb/hcd-dwc2.c
@@ -0,0 +1,1301 @@
+/*
+ * dwc-hsotg (dwc2) USB host controller emulation
+ *
+ * Based on hw/usb/hcd-ehci.c and hw/usb/hcd-ohci.c
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
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/usb/dwc2-regs.h"
+#include "hw/usb/hcd-dwc2.h"
+#include "trace.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+
+#define USB_HZ_FS       12000000
+#define USB_HZ_HS       96000000
+
+/* nifty macros from Arnon's EHCI version  */
+#define get_field(data, field) \
+    (((data) & field##_MASK) >> field##_SHIFT)
+
+#define set_field(data, newval, field) do { \
+    uint32_t val = *data; \
+    val &= ~field##_MASK; \
+    val |= ((newval) << field##_SHIFT) & field##_MASK; \
+    *data = val; \
+} while (0)
+
+#define get_bit(data, bitmask) \
+    (!!((data) & bitmask))
+
+/* update irq line */
+static inline void dwc2_update_irq(DWC2State *s)
+{
+    static int oldlevel;
+    int level = 0;
+
+    if ((s->gintsts & s->gintmsk) && (s->gahbcfg & GAHBCFG_GLBL_INTR_EN)) {
+        level = 1;
+    }
+    if (level != oldlevel) {
+        oldlevel = level;
+        trace_usb_dwc2_update_irq(level);
+        qemu_set_irq(s->irq, level);
+    }
+}
+
+/* flag interrupt condition */
+static inline void dwc2_raise_global_irq(DWC2State *s, uint32_t intr)
+{
+    if (!(s->gintsts & intr)) {
+        s->gintsts |= intr;
+        trace_usb_dwc2_raise_global_irq(intr);
+        dwc2_update_irq(s);
+    }
+}
+
+static inline void dwc2_lower_global_irq(DWC2State *s, uint32_t intr)
+{
+    if (s->gintsts & intr) {
+        s->gintsts &= ~intr;
+        trace_usb_dwc2_lower_global_irq(intr);
+        dwc2_update_irq(s);
+    }
+}
+
+static inline void dwc2_raise_host_irq(DWC2State *s, uint32_t host_intr)
+{
+    if (!(s->haint & host_intr)) {
+        s->haint |= host_intr;
+        s->haint &= 0xffff;
+        trace_usb_dwc2_raise_host_irq(host_intr);
+        if (s->haint & s->haintmsk) {
+            dwc2_raise_global_irq(s, GINTSTS_HCHINT);
+        }
+    }
+}
+
+static inline void dwc2_lower_host_irq(DWC2State *s, uint32_t host_intr)
+{
+    if (s->haint & host_intr) {
+        s->haint &= ~host_intr;
+        trace_usb_dwc2_lower_host_irq(host_intr);
+        if (!(s->haint & s->haintmsk)) {
+            dwc2_lower_global_irq(s, GINTSTS_HCHINT);
+        }
+    }
+}
+
+static inline void dwc2_update_hc_irq(DWC2State *s, int index)
+{
+    uint32_t host_intr = 1 << (index >> 3);
+
+    if (s->hreg1[index + 2] & s->hreg1[index + 3]) {
+        dwc2_raise_host_irq(s, host_intr);
+    } else {
+        dwc2_lower_host_irq(s, host_intr);
+    }
+}
+
+/* set a timer for EOF */
+static void dwc2_eof_timer(DWC2State *s)
+{
+    timer_mod(s->eof_timer, s->sof_time + s->usb_frame_time);
+}
+
+/* Set a timer for EOF and generate a SOF event */
+static void dwc2_sof(DWC2State *s)
+{
+    s->sof_time += s->usb_frame_time;
+    trace_usb_dwc2_sof(s->sof_time);
+    dwc2_eof_timer(s);
+    dwc2_raise_global_irq(s, GINTSTS_SOF);
+}
+
+/* Do frame processing on frame boundary */
+static void dwc2_frame_boundary(void *opaque)
+{
+    DWC2State *s = opaque;
+
+    /* Frame boundary, so do EOF stuff here */
+
+    /* Increment frame number */
+    s->frame_number = (s->frame_number + 1) & 0xffff;
+    s->hfnum = (s->hfnum & ~HFNUM_FRNUM_MASK) |
+               (s->frame_number & HFNUM_MAX_FRNUM);
+
+    /* Do SOF stuff here */
+    dwc2_sof(s);
+}
+
+/* Start sending SOF tokens on the USB bus */
+static int dwc2_bus_start(DWC2State *s)
+{
+    trace_usb_dwc2_bus_start();
+    s->sof_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    dwc2_eof_timer(s);
+
+    return 1;
+}
+
+/* Stop sending SOF tokens on the USB bus */
+static void dwc2_bus_stop(DWC2State *s)
+{
+    trace_usb_dwc2_bus_stop();
+    timer_del(s->eof_timer);
+}
+
+static USBDevice *dwc2_find_device(DWC2State *s, uint8_t addr)
+{
+    USBDevice *dev;
+    USBPort *port;
+    int i;
+
+    trace_usb_dwc2_find_device(addr);
+    for (i = 0; i < NB_PORTS; i++) {
+        port = &s->ports[i];
+        if (!(s->hprt0 & HPRT0_ENA)) {
+            trace_usb_dwc2_port_disabled(i);
+            continue;
+        }
+        dev = usb_find_device(port, addr);
+        if (dev != NULL) {
+            trace_usb_dwc2_device_found(i);
+            return dev;
+        }
+    }
+    trace_usb_dwc2_device_not_found();
+    return NULL;
+}
+
+static const char *pstatus[] = {
+    "USB_RET_SUCCESS", "USB_RET_NODEV", "USB_RET_NAK", "USB_RET_STALL",
+    "USB_RET_BABBLE", "USB_RET_IOERROR", "USB_RET_ASYNC",
+    "USB_RET_ADD_TO_QUEUE", "USB_RET_REMOVE_FROM_QUEUE"
+};
+
+static uint32_t pintr[] = {
+    HCINTMSK_XFERCOMPL, HCINTMSK_XACTERR, HCINTMSK_NAK, HCINTMSK_STALL,
+    HCINTMSK_BBLERR, HCINTMSK_XACTERR, HCINTMSK_XACTERR, HCINTMSK_XACTERR,
+    HCINTMSK_XACTERR
+};
+
+static const char *types[] = {
+    "Ctrl", "Isoc", "Bulk", "Intr"
+};
+
+static const char *dirs[] = {
+    "Out", "In"
+};
+
+static void dwc2_handle_packet(DWC2State *s, USBDevice *dev, USBEndpoint *ep,
+                               uint32_t index, bool send) {
+    DWC2Packet *p;
+    uint32_t hcchar = s->hreg1[index];
+    uint32_t hctsiz = s->hreg1[index + 4];
+    uint32_t hcdma = s->hreg1[index + 5];
+    uint32_t chan, epnum, epdir, eptype, mps, pid, pcnt, len, tlen, intr = 0;
+    uint32_t tpcnt, stsidx, actual = 0;
+    bool do_intr = false, done = false;
+
+    epnum = get_field(hcchar, HCCHAR_EPNUM);
+    epdir = get_bit(hcchar, HCCHAR_EPDIR);
+    eptype = get_field(hcchar, HCCHAR_EPTYPE);
+    mps = get_field(hcchar, HCCHAR_MPS);
+    pid = get_field(hctsiz, TSIZ_SC_MC_PID);
+    pcnt = get_field(hctsiz, TSIZ_PKTCNT);
+    len = get_field(hctsiz, TSIZ_XFERSIZE);
+    assert(len <= MAX_XFER_SIZE);
+    chan = index >> 3;
+    p = &s->packet[chan];
+
+    trace_usb_dwc2_handle_packet(chan, dev, &p->packet, epnum, types[eptype],
+                                 dirs[epdir], mps, len, pcnt);
+
+    if (eptype == USB_ENDPOINT_XFER_CONTROL && pid == TSIZ_SC_MC_PID_SETUP) {
+        pid = USB_TOKEN_SETUP;
+    } else {
+        pid = epdir ? USB_TOKEN_IN : USB_TOKEN_OUT;
+    }
+
+    tlen = len;
+    if (p->small) {
+        if (tlen > mps) {
+            tlen = mps;
+        }
+    }
+
+    if (send) {
+        if (pid != USB_TOKEN_IN) {
+            trace_usb_dwc2_memory_read(hcdma, tlen);
+            if (dma_memory_read(&s->dma_as, hcdma,
+                                s->usb_buf[chan], tlen) != MEMTX_OK) {
+                fprintf(stderr, "%s: dma_memory_read failed\n", __func__);
+            }
+        }
+
+        usb_packet_init(&p->packet);
+        usb_packet_setup(&p->packet, pid, ep, 0, hcdma,
+                         pid != USB_TOKEN_IN, true);
+        usb_packet_addbuf(&p->packet, s->usb_buf[chan], tlen);
+        p->async = DWC2_ASYNC_NONE;
+        usb_handle_packet(dev, &p->packet);
+    }
+
+    stsidx = -p->packet.status;
+    assert(stsidx < sizeof(pstatus) / sizeof(*pstatus));
+    actual = p->packet.actual_length;
+    trace_usb_dwc2_packet_status(pstatus[stsidx], actual);
+    if (p->packet.status != USB_RET_SUCCESS &&
+            p->packet.status != USB_RET_NAK &&
+            p->packet.status != USB_RET_STALL &&
+            p->packet.status != USB_RET_ASYNC) {
+        fprintf(stderr, "%s: packet status %s\n", __func__, pstatus[stsidx]);
+    }
+
+    if (p->packet.status == USB_RET_ASYNC) {
+        trace_usb_dwc2_async_packet(&p->packet, chan, dev, epnum, tlen);
+        usb_device_flush_ep_queue(dev, ep);
+        assert(p->async != DWC2_ASYNC_INFLIGHT);
+        p->dev = dev;
+        p->ep = ep;
+        p->index = index;
+        p->epnum = epnum;
+        p->mps = mps;
+        p->pid = pid;
+        p->pcnt = pcnt;
+        p->len = tlen;
+        p->needs_service = false;
+        p->async = DWC2_ASYNC_INFLIGHT;
+        return;
+    }
+
+    if (p->packet.status == USB_RET_SUCCESS) {
+        if (pid == USB_TOKEN_IN) {
+            trace_usb_dwc2_memory_write(hcdma, actual);
+            if (dma_memory_write(&s->dma_as, hcdma, s->usb_buf[chan],
+                                 actual) != MEMTX_OK) {
+                fprintf(stderr, "%s: dma_memory_write failed\n", __func__);
+            }
+        }
+
+        tpcnt = actual / mps;
+        if (actual % mps) {
+            tpcnt++;
+            if (pid == USB_TOKEN_IN) {
+                done = true;
+            }
+        }
+
+        pcnt -= tpcnt < pcnt ? tpcnt : pcnt;
+        set_field(&hctsiz, pcnt, TSIZ_PKTCNT);
+        len -= actual < len ? actual : len;
+        set_field(&hctsiz, len, TSIZ_XFERSIZE);
+        s->hreg1[index + 4] = hctsiz;
+        hcdma += actual;
+        s->hreg1[index + 5] = hcdma;
+
+        if (!pcnt || len == 0 || actual == 0) {
+            done = true;
+        }
+    } else {
+        intr |= pintr[stsidx];
+        if (p->packet.status == USB_RET_NAK &&
+            (eptype == USB_ENDPOINT_XFER_CONTROL ||
+             eptype == USB_ENDPOINT_XFER_BULK)) {
+            /*
+             * for ctrl/bulk, automatically retry on NAK,
+             * but send the interrupt anyway
+             */
+            intr &= ~HCINTMSK_RESERVED14_31;
+            s->hreg1[index + 2] |= intr;
+            do_intr = true;
+        } else {
+            intr |= HCINTMSK_CHHLTD;
+            done = true;
+        }
+    }
+
+    usb_packet_cleanup(&p->packet);
+
+    if (done) {
+        hcchar &= ~HCCHAR_CHENA;
+        s->hreg1[index] = hcchar;
+        if (!(intr & HCINTMSK_CHHLTD)) {
+            intr |= HCINTMSK_CHHLTD | HCINTMSK_XFERCOMPL;
+        }
+        intr &= ~HCINTMSK_RESERVED14_31;
+        s->hreg1[index + 2] |= intr;
+        p->needs_service = false;
+        trace_usb_dwc2_packet_done(pstatus[stsidx], actual, len, pcnt);
+        dwc2_update_hc_irq(s, index);
+        return;
+    }
+
+    p->dev = dev;
+    p->ep = ep;
+    p->index = index;
+    p->epnum = epnum;
+    p->mps = mps;
+    p->pid = pid;
+    p->pcnt = pcnt;
+    p->len = tlen;
+    p->needs_service = true;
+    trace_usb_dwc2_packet_next(pstatus[stsidx], len, pcnt);
+    if (do_intr) {
+        dwc2_update_hc_irq(s, index);
+    }
+}
+
+/* Attach or detach a device on root hub */
+
+static const char *speeds[] = {
+    "low", "full", "high"
+};
+
+static void dwc2_attach(USBPort *port)
+{
+    DWC2State *s = port->opaque;
+    int hispd = 0;
+
+    trace_usb_dwc2_attach(port);
+    assert(port->index < NB_PORTS);
+
+    if (!port->dev || !port->dev->attached) {
+        return;
+    }
+
+    assert(port->dev->speed <= USB_SPEED_HIGH);
+    trace_usb_dwc2_attach_speed(speeds[port->dev->speed]);
+    s->hprt0 &= ~HPRT0_SPD_MASK;
+
+    switch (port->dev->speed) {
+    case USB_SPEED_LOW:
+        s->hprt0 |= HPRT0_SPD_LOW_SPEED << HPRT0_SPD_SHIFT;
+        break;
+    case USB_SPEED_FULL:
+        s->hprt0 |= HPRT0_SPD_FULL_SPEED << HPRT0_SPD_SHIFT;
+        break;
+    case USB_SPEED_HIGH:
+        s->hprt0 |= HPRT0_SPD_HIGH_SPEED << HPRT0_SPD_SHIFT;
+        hispd = 1;
+        break;
+    }
+
+    if (hispd) {
+        s->usb_frame_time = NANOSECONDS_PER_SECOND / 8000;        /* 125000 */
+        if (NANOSECONDS_PER_SECOND >= USB_HZ_HS) {
+            s->usb_bit_time = NANOSECONDS_PER_SECOND / USB_HZ_HS; /* 10.4 */
+        } else {
+            s->usb_bit_time = 1;
+        }
+    } else {
+        s->usb_frame_time = NANOSECONDS_PER_SECOND / 1000;        /* 1000000 */
+        if (NANOSECONDS_PER_SECOND >= USB_HZ_FS) {
+            s->usb_bit_time = NANOSECONDS_PER_SECOND / USB_HZ_FS; /* 83.3 */
+        } else {
+            s->usb_bit_time = 1;
+        }
+    }
+
+    s->fi = 11999;
+    s->hprt0 |= HPRT0_CONNDET | HPRT0_CONNSTS;
+
+    dwc2_bus_start(s);
+    dwc2_raise_global_irq(s, GINTSTS_PRTINT);
+}
+
+static void dwc2_detach(USBPort *port)
+{
+    DWC2State *s = port->opaque;
+
+    trace_usb_dwc2_detach(port);
+    assert(port->index < NB_PORTS);
+
+    dwc2_bus_stop(s);
+
+    s->hprt0 &= ~(HPRT0_SPD_MASK | HPRT0_SUSP | HPRT0_ENA | HPRT0_CONNSTS);
+    s->hprt0 |= HPRT0_CONNDET | HPRT0_ENACHG;
+
+    dwc2_raise_global_irq(s, GINTSTS_PRTINT);
+}
+
+static void dwc2_child_detach(USBPort *port, USBDevice *child)
+{
+    trace_usb_dwc2_child_detach(port, child);
+    assert(port->index < NB_PORTS);
+}
+
+static void dwc2_wakeup(USBPort *port)
+{
+    DWC2State *s = port->opaque;
+
+    trace_usb_dwc2_wakeup(port);
+    assert(port->index < NB_PORTS);
+
+    if (s->hprt0 & HPRT0_SUSP) {
+        s->hprt0 |= HPRT0_RES;
+        dwc2_raise_global_irq(s, GINTSTS_PRTINT);
+    }
+
+    qemu_bh_schedule(s->async_bh);
+}
+
+static void dwc2_async_packet_complete(USBPort *port, USBPacket *packet)
+{
+    DWC2State *s = port->opaque;
+    DWC2Packet *p;
+
+    p = container_of(packet, DWC2Packet, packet);
+    trace_usb_dwc2_async_packet_complete(port, packet, p->index >> 3,
+                                         p->dev, p->epnum, p->len);
+    assert(port->index < NB_PORTS);
+    assert(p->async == DWC2_ASYNC_INFLIGHT);
+
+    if (packet->status == USB_RET_REMOVE_FROM_QUEUE) {
+        usb_packet_cleanup(packet);
+        return;
+    }
+
+    dwc2_handle_packet(s, p->dev, p->ep, p->index, false);
+
+    p->async = DWC2_ASYNC_FINISHED;
+    qemu_bh_schedule(s->async_bh);
+}
+
+static USBPortOps dwc2_port_ops = {
+    .attach = dwc2_attach,
+    .detach = dwc2_detach,
+    .child_detach = dwc2_child_detach,
+    .wakeup = dwc2_wakeup,
+    .complete = dwc2_async_packet_complete,
+};
+
+static uint32_t dwc2_get_frame_remaining(DWC2State *s)
+{
+    uint32_t fr = 0;
+    int64_t tks;
+
+    tks = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->sof_time;
+    if (tks < 0) {
+        tks = 0;
+    }
+
+    /* avoid muldiv if possible */
+    if (tks >= s->usb_frame_time || tks < s->usb_bit_time) {
+        goto out;
+    }
+
+    /* tks = number of ns since SOF, divided by 83 (fs) or 10 (hs) */
+    tks = tks / s->usb_bit_time;
+    if (tks >= (int64_t)s->fi) {
+        goto out;
+    }
+
+    /* remaining = frame interval minus tks */
+    fr = (uint32_t)((int64_t)s->fi - tks);
+
+out:
+    return fr;
+}
+
+static void dwc2_work_bh(void *opaque)
+{
+    DWC2State *s = opaque;
+    DWC2Packet *p;
+    int64_t t_now, expire_time;
+    int chan;
+    bool done = false, need_timer = false;
+
+    trace_usb_dwc2_work_bh();
+    if (s->working) {
+        return;
+    }
+    s->working = true;
+
+    t_now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    chan = s->next_chan;
+
+    while (true) {
+        p = &s->packet[chan];
+        if (p->needs_service) {
+            trace_usb_dwc2_work_bh_service(s->next_chan, chan,
+                                           p->dev, p->epnum);
+            dwc2_handle_packet(s, p->dev, p->ep, p->index, true);
+            need_timer = true;
+            done = true;
+        }
+        if (++chan == NB_CHAN) {
+            chan = 0;
+        }
+        if (done) {
+            s->next_chan = chan;
+            trace_usb_dwc2_work_bh_next(chan);
+            break;
+        }
+        if (chan == s->next_chan) {
+            break;
+        }
+    }
+
+    if (need_timer) {
+        expire_time = t_now + NANOSECONDS_PER_SECOND / 4000;
+        timer_mod(s->frame_timer, expire_time);
+    }
+    s->working = false;
+}
+
+static void dwc2_enable_chan(DWC2State *s,  uint32_t index)
+{
+    USBDevice *dev;
+    USBEndpoint *ep;
+    uint32_t hcchar;
+    uint32_t hctsiz;
+    uint32_t devadr, epnum, epdir, eptype, pid, len;
+    DWC2Packet *p;
+
+    assert((index >> 3) < NB_CHAN);
+    p = &s->packet[index >> 3];
+    hcchar = s->hreg1[index];
+    hctsiz = s->hreg1[index + 4];
+    devadr = get_field(hcchar, HCCHAR_DEVADDR);
+    epnum = get_field(hcchar, HCCHAR_EPNUM);
+    epdir = get_bit(hcchar, HCCHAR_EPDIR);
+    eptype = get_field(hcchar, HCCHAR_EPTYPE);
+    pid = get_field(hctsiz, TSIZ_SC_MC_PID);
+    len = get_field(hctsiz, TSIZ_XFERSIZE);
+
+    dev = dwc2_find_device(s, devadr);
+
+    trace_usb_dwc2_enable_chan(index >> 3, dev, &p->packet, epnum);
+    if (dev == NULL) {
+        fprintf(stderr, "%s: no device found\n", __func__);
+        return;
+    }
+
+    if (eptype == USB_ENDPOINT_XFER_CONTROL && pid == TSIZ_SC_MC_PID_SETUP) {
+        pid = USB_TOKEN_SETUP;
+    } else {
+        pid = epdir ? USB_TOKEN_IN : USB_TOKEN_OUT;
+    }
+
+    ep = usb_ep_get(dev, pid, epnum);
+
+    /*
+     * Hack: Networking doesn't like us delivering large transfers, it kind
+     * of works but the latency is horrible. So if the tansfer is <= the mtu
+     * size, we take that as a hint that this might be a network transfer,
+     * and do the transfer packet-by-packet.
+     */
+    if (len > 1536) {
+        p->small = false;
+    } else {
+        p->small = true;
+    }
+
+    dwc2_handle_packet(s, dev, ep, index, true);
+    qemu_bh_schedule(s->async_bh);
+}
+
+static const char *glbregnm[] = {
+    "GOTGCTL  ", "GOTGINT  ", "GAHBCFG  ", "GUSBCFG  ", "GRSTCTL  ",
+    "GINTSTS  ", "GINTMSK  ", "GRXSTSR  ", "GRXSTSP  ", "GRXFSIZ  ",
+    "GNPTXFSIZ", "GNPTXSTS ", "GI2CCTL  ", "GPVNDCTL ", "GGPIO    ",
+    "GUID     ", "GSNPSID  ", "GHWCFG1  ", "GHWCFG2  ", "GHWCFG3  ",
+    "GHWCFG4  ", "GLPMCFG  ", "GPWRDN   ", "GDFIFOCFG", "GADPCTL  ",
+    "GREFCLK  ", "GINTMSK2 ", "GINTSTS2 "
+};
+
+static uint64_t dwc2_glbreg_read(void *ptr, hwaddr addr, unsigned size)
+{
+    DWC2State *s = ptr;
+    uint32_t reg = s->glbregbase + addr;
+    uint32_t val;
+
+    assert(reg <= GINTSTS2);
+    val = s->glbreg[addr >> 2];
+
+    switch (reg) {
+    case GRSTCTL:
+        /* clear any self-clearing bits that were set */
+        val &= ~(GRSTCTL_TXFFLSH | GRSTCTL_RXFFLSH | GRSTCTL_IN_TKNQ_FLSH |
+                 GRSTCTL_FRMCNTRRST | GRSTCTL_HSFTRST | GRSTCTL_CSFTRST);
+        s->glbreg[addr >> 2] = val;
+        break;
+    default:
+        break;
+    }
+
+    trace_usb_dwc2_glbreg_read(addr, glbregnm[addr >> 2], val);
+    return val;
+}
+
+static void dwc2_glbreg_write(void *ptr, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    DWC2State *s = ptr;
+    uint64_t orig = val;
+    uint32_t reg = s->glbregbase + addr;
+    uint32_t *mmio;
+    uint32_t old;
+    int iflg = 0;
+
+    assert(reg <= GINTSTS2);
+    mmio = &s->glbreg[addr >> 2];
+    old = *mmio;
+
+    switch (reg) {
+    case GOTGCTL:
+        /* don't allow setting of read-only bits */
+        val &= ~(GOTGCTL_MULT_VALID_BC_MASK | GOTGCTL_BSESVLD |
+                 GOTGCTL_ASESVLD | GOTGCTL_DBNC_SHORT | GOTGCTL_CONID_B |
+                 GOTGCTL_HSTNEGSCS | GOTGCTL_SESREQSCS);
+        /* don't allow clearing of read-only bits */
+        val |= old & (GOTGCTL_MULT_VALID_BC_MASK | GOTGCTL_BSESVLD |
+                      GOTGCTL_ASESVLD | GOTGCTL_DBNC_SHORT | GOTGCTL_CONID_B |
+                      GOTGCTL_HSTNEGSCS | GOTGCTL_SESREQSCS);
+        break;
+    case GAHBCFG:
+        if ((val & GAHBCFG_GLBL_INTR_EN) && !(old & GAHBCFG_GLBL_INTR_EN)) {
+            iflg = 1;
+        }
+        break;
+    case GRSTCTL:
+        val |= GRSTCTL_AHBIDLE;
+        val &= ~GRSTCTL_DMAREQ;
+        if (!(old & GRSTCTL_TXFFLSH) && (val & GRSTCTL_TXFFLSH)) {
+                /* TODO - TX fifo flush */
+        }
+        if (!(old & GRSTCTL_RXFFLSH) && (val & GRSTCTL_RXFFLSH)) {
+                /* TODO - RX fifo flush */
+        }
+        if (!(old & GRSTCTL_IN_TKNQ_FLSH) && (val & GRSTCTL_IN_TKNQ_FLSH)) {
+                /* TODO - device IN token queue flush */
+        }
+        if (!(old & GRSTCTL_FRMCNTRRST) && (val & GRSTCTL_FRMCNTRRST)) {
+                /* TODO - host frame counter reset */
+        }
+        if (!(old & GRSTCTL_HSFTRST) && (val & GRSTCTL_HSFTRST)) {
+                /* TODO - ? soft reset */
+        }
+        if (!(old & GRSTCTL_CSFTRST) && (val & GRSTCTL_CSFTRST)) {
+                /* TODO - core soft reset */
+        }
+        /* don't allow clearing of self-clearing bits */
+        val |= old & (GRSTCTL_TXFFLSH | GRSTCTL_RXFFLSH |
+                      GRSTCTL_IN_TKNQ_FLSH | GRSTCTL_FRMCNTRRST |
+                      GRSTCTL_HSFTRST | GRSTCTL_CSFTRST);
+        break;
+    case GINTSTS:
+        /* clear the write-1-to-clear bits */
+        val |= ~old;
+        val = ~val;
+        /* don't allow clearing of read-only bits */
+        val |= old & (GINTSTS_PTXFEMP | GINTSTS_HCHINT | GINTSTS_PRTINT |
+                      GINTSTS_OEPINT | GINTSTS_IEPINT | GINTSTS_GOUTNAKEFF |
+                      GINTSTS_GINNAKEFF | GINTSTS_NPTXFEMP | GINTSTS_RXFLVL |
+                      GINTSTS_OTGINT | GINTSTS_CURMODE_HOST);
+        iflg = 1;
+        break;
+    case GINTMSK:
+        iflg = 1;
+        break;
+    default:
+        break;
+    }
+
+    val &= 0xffffffff;
+    trace_usb_dwc2_glbreg_write(addr, glbregnm[addr >> 2], orig, old, val);
+    *mmio = val;
+
+    if (iflg) {
+        dwc2_update_irq(s);
+    }
+}
+
+static uint64_t dwc2_fszreg_read(void *ptr, hwaddr addr, unsigned size)
+{
+    DWC2State *s = ptr;
+    uint32_t reg = s->fszregbase + addr;
+    uint32_t val;
+
+    assert(reg <= HPTXFSIZ);
+    val = s->fszreg[addr >> 2];
+
+    trace_usb_dwc2_fszreg_read(addr, val);
+    return val;
+}
+
+static void dwc2_fszreg_write(void *ptr, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    DWC2State *s = ptr;
+    uint64_t orig = val;
+    uint32_t reg = s->fszregbase + addr;
+    uint32_t *mmio;
+    uint32_t old;
+
+    assert(reg <= HPTXFSIZ);
+    mmio = &s->fszreg[addr >> 2];
+    old = *mmio;
+
+    val &= 0xffffffff;
+    trace_usb_dwc2_fszreg_write(addr, orig, old, val);
+    *mmio = val;
+}
+
+static const char *hreg0nm[] = {
+    "HCFG     ", "HFIR     ", "HFNUM    ", "<rsvd>   ", "HPTXSTS  ",
+    "HAINT    ", "HAINTMSK ", "HFLBADDR ", "<rsvd>   ", "<rsvd>   ",
+    "<rsvd>   ", "<rsvd>   ", "<rsvd>   ", "<rsvd>   ", "<rsvd>   ",
+    "<rsvd>   ", "HPRT0    "
+};
+
+static uint64_t dwc2_hreg0_read(void *ptr, hwaddr addr, unsigned size)
+{
+    DWC2State *s = ptr;
+    uint32_t reg = s->hreg0base + addr;
+    uint32_t val;
+
+    assert(reg <= HPRT0);
+    val = s->hreg0[addr >> 2];
+
+    switch (reg) {
+    case HFNUM:
+        val = (dwc2_get_frame_remaining(s) << HFNUM_FRREM_SHIFT) |
+              ((s->frame_number & HFNUM_MAX_FRNUM) << HFNUM_FRNUM_SHIFT);
+        break;
+    default:
+        break;
+    }
+
+    trace_usb_dwc2_hreg0_read(addr, hreg0nm[addr >> 2], val);
+    return val;
+}
+
+static void dwc2_hreg0_write(void *ptr, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    DWC2State *s = ptr;
+    uint64_t orig = val;
+    uint32_t reg = s->hreg0base + addr;
+    USBDevice *dev = s->ports[0].dev;
+    uint32_t *mmio;
+    uint32_t tval, told, old;
+    int prst = 0;
+    int iflg = 0;
+
+    assert(reg <= HPRT0);
+    mmio = &s->hreg0[addr >> 2];
+    old = *mmio;
+
+    switch (reg) {
+    case HFIR:
+        break;
+    case HFNUM:
+    case HPTXSTS:
+    case HAINT:
+        fprintf(stderr, "%s: write to read-only register\n", __func__);
+        return;
+    case HAINTMSK:
+        val &= 0xffff;
+        break;
+    case HPRT0:
+        /* don't allow clearing of read-only bits */
+        val |= old & (HPRT0_SPD_MASK | HPRT0_LNSTS_MASK | HPRT0_OVRCURRACT |
+                      HPRT0_CONNSTS);
+        /* don't allow clearing of self-clearing bits */
+        val |= old & (HPRT0_SUSP | HPRT0_RES);
+        /* don't allow setting of self-setting bits */
+        if (!(old & HPRT0_ENA) && (val & HPRT0_ENA)) {
+            val &= ~HPRT0_ENA;
+        }
+        /* clear the write-1-to-clear bits */
+        tval = val & (HPRT0_OVRCURRCHG | HPRT0_ENACHG | HPRT0_ENA |
+                      HPRT0_CONNDET);
+        told = old & (HPRT0_OVRCURRCHG | HPRT0_ENACHG | HPRT0_ENA |
+                      HPRT0_CONNDET);
+        tval |= ~told;
+        tval = ~tval;
+        tval &= (HPRT0_OVRCURRCHG | HPRT0_ENACHG | HPRT0_ENA |
+                 HPRT0_CONNDET);
+        val &= ~(HPRT0_OVRCURRCHG | HPRT0_ENACHG | HPRT0_ENA |
+                 HPRT0_CONNDET);
+        val |= tval;
+        if (!(val & HPRT0_RST) && (old & HPRT0_RST)) {
+            if (dev && dev->attached) {
+                val |= HPRT0_ENA | HPRT0_ENACHG;
+                prst = 1;
+            }
+        }
+        if (val & (HPRT0_OVRCURRCHG | HPRT0_ENACHG | HPRT0_CONNDET)) {
+            iflg = 1;
+        } else {
+            iflg = -1;
+        }
+        break;
+    default:
+        break;
+    }
+
+    val &= 0xffffffff;
+
+    if (prst) {
+        trace_usb_dwc2_hreg0_write(addr, hreg0nm[addr >> 2], orig, old,
+                                   val & ~HPRT0_CONNDET);
+        trace_usb_dwc2_hreg0_action("call usb_port_reset");
+        usb_port_reset(&s->ports[0]);
+        val &= ~HPRT0_CONNDET;
+    } else {
+        trace_usb_dwc2_hreg0_write(addr, hreg0nm[addr >> 2], orig, old, val);
+    }
+
+    *mmio = val;
+
+    if (iflg > 0) {
+        trace_usb_dwc2_hreg0_action("enable PRTINT");
+        dwc2_raise_global_irq(s, GINTSTS_PRTINT);
+    } else if (iflg < 0) {
+        trace_usb_dwc2_hreg0_action("disable PRTINT");
+        dwc2_lower_global_irq(s, GINTSTS_PRTINT);
+    }
+}
+
+static const char *hreg1nm[] = {
+    "HCCHAR  ", "HCSPLT  ", "HCINT   ", "HCINTMSK", "HCTSIZ  ", "HCDMA   ",
+    "<rsvd>  ", "HCDMAB  "
+};
+
+static uint64_t dwc2_hreg1_read(void *ptr, hwaddr addr, unsigned size)
+{
+    DWC2State *s = ptr;
+    uint32_t reg = s->hreg1base + addr;
+    uint32_t val;
+
+    assert(reg <= HCDMAB(NB_CHAN - 1));
+    val = s->hreg1[addr >> 2];
+
+    trace_usb_dwc2_hreg1_read(addr, hreg1nm[(addr >> 2) & 7], addr >> 5, val);
+    assert(s->hreg1base + (addr & 0x1c) <= HCDMAB(NB_CHAN));
+    return val;
+}
+
+static void dwc2_hreg1_write(void *ptr, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    DWC2State *s = ptr;
+    uint64_t orig = val;
+    uint32_t reg = s->hreg1base + addr;
+    uint32_t *mmio;
+    uint32_t old;
+    int iflg = 0;
+    int enflg = 0;
+    int disflg = 0;
+
+    assert(reg <= HCDMAB(NB_CHAN - 1));
+    mmio = &s->hreg1[addr >> 2];
+    old = *mmio;
+
+    switch (s->hreg1base + (addr & 0x1c)) {
+    case HCCHAR(0):
+        if ((val & HCCHAR_CHDIS) && !(old & HCCHAR_CHDIS)) {
+            val &= ~(HCCHAR_CHENA | HCCHAR_CHDIS);
+            disflg = 1;
+        } else {
+            val |= old & HCCHAR_CHDIS;
+            if ((val & HCCHAR_CHENA) && !(old & HCCHAR_CHENA)) {
+                val &= ~HCCHAR_CHDIS;
+                enflg = 1;
+            } else {
+                val |= old & HCCHAR_CHENA;
+            }
+        }
+        break;
+    case HCINT(0):
+        /* clear the write-1-to-clear bits */
+        val |= ~old;
+        val = ~val;
+        val &= ~HCINTMSK_RESERVED14_31;
+        iflg = 1;
+        break;
+    case HCINTMSK(0):
+        val &= ~HCINTMSK_RESERVED14_31;
+        iflg = 1;
+        break;
+    case HCDMAB(0):
+        fprintf(stderr, "%s: write to read-only register\n", __func__);
+        return;
+    default:
+        break;
+    }
+
+    val &= 0xffffffff;
+    trace_usb_dwc2_hreg1_write(addr, hreg1nm[(addr >> 2) & 7], addr >> 5,
+                               orig, old, val);
+    *mmio = val;
+
+    if (disflg) {
+        /* set ChHltd in HCINT */
+        s->hreg1[((addr >> 2) & ~7) + 2] |= HCINTMSK_CHHLTD;
+        iflg = 1;
+    }
+
+    if (enflg) {
+        dwc2_enable_chan(s, (addr >> 2) & ~7);
+    }
+
+    if (iflg) {
+        dwc2_update_hc_irq(s, (addr >> 2) & ~7);
+    }
+}
+
+static const char *pcgregnm[] = {
+        "PCGCTL   ", "PCGCCTL1 "
+};
+
+static uint64_t dwc2_pcgreg_read(void *ptr, hwaddr addr, unsigned size)
+{
+    DWC2State *s = ptr;
+    uint32_t reg = s->pcgregbase + addr;
+    uint32_t val;
+
+    assert(reg <= PCGCCTL1);
+    val = s->pcgreg[addr >> 2];
+
+    trace_usb_dwc2_pcgreg_read(addr, pcgregnm[addr >> 2], val);
+    return val;
+}
+
+static void dwc2_pcgreg_write(void *ptr, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    DWC2State *s = ptr;
+    uint64_t orig = val;
+    uint32_t reg = s->pcgregbase + addr;
+    uint32_t *mmio;
+    uint32_t old;
+
+    assert(reg <= PCGCCTL1);
+    mmio = &s->pcgreg[addr >> 2];
+    old = *mmio;
+
+    val &= 0xffffffff;
+    trace_usb_dwc2_pcgreg_write(addr, pcgregnm[addr >> 2], orig, old, val);
+    *mmio = val;
+}
+
+static uint64_t dwc2_hreg2_read(void *ptr, hwaddr addr, unsigned size)
+{
+    /* TODO - implement FIFOs to support slave mode */
+    trace_usb_dwc2_hreg2_read(addr, addr >> 12, 0);
+    return 0;
+}
+
+static void dwc2_hreg2_write(void *ptr, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    uint64_t orig = val;
+
+    /* TODO - implement FIFOs to support slave mode */
+    val &= 0xffffffff;
+    trace_usb_dwc2_hreg2_write(addr, addr >> 12, orig, 0, val);
+}
+
+static const MemoryRegionOps dwc2_mmio_glbreg_ops = {
+    .read = dwc2_glbreg_read,
+    .write = dwc2_glbreg_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static const MemoryRegionOps dwc2_mmio_fszreg_ops = {
+    .read = dwc2_fszreg_read,
+    .write = dwc2_fszreg_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static const MemoryRegionOps dwc2_mmio_hreg0_ops = {
+    .read = dwc2_hreg0_read,
+    .write = dwc2_hreg0_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static const MemoryRegionOps dwc2_mmio_hreg1_ops = {
+    .read = dwc2_hreg1_read,
+    .write = dwc2_hreg1_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static const MemoryRegionOps dwc2_mmio_pcgreg_ops = {
+    .read = dwc2_pcgreg_read,
+    .write = dwc2_pcgreg_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static const MemoryRegionOps dwc2_mmio_hreg2_ops = {
+    .read = dwc2_hreg2_read,
+    .write = dwc2_hreg2_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void dwc2_wakeup_endpoint(USBBus *bus, USBEndpoint *ep,
+                                 unsigned int stream)
+{
+    DWC2State *s = container_of(bus, DWC2State, bus);
+
+    trace_usb_dwc2_wakeup_endpoint(ep, stream);
+
+    /* TODO - do something here? */
+    qemu_bh_schedule(s->async_bh);
+}
+
+static USBBusOps dwc2_bus_ops = {
+    .wakeup_endpoint = dwc2_wakeup_endpoint,
+};
+
+static void dwc2_work_timer(void *opaque)
+{
+    DWC2State *s = opaque;
+
+    trace_usb_dwc2_work_timer();
+    qemu_bh_schedule(s->async_bh);
+}
+
+/* host controller initialization */
+static void dwc2_reset(DWC2State *s)
+{
+    USBDevice *devs[NB_PORTS];
+    int i;
+
+    trace_usb_dwc2_reset();
+    timer_del(s->frame_timer);
+    qemu_bh_cancel(s->async_bh);
+
+    for (i = 0; i < NB_PORTS; i++) {
+        devs[i] = s->ports[i].dev;
+        if (devs[i] && devs[i]->attached) {
+            usb_detach(&s->ports[i]);
+        }
+    }
+
+    dwc2_bus_stop(s);
+
+    s->gotgctl = GOTGCTL_BSESVLD | GOTGCTL_ASESVLD | GOTGCTL_CONID_B;
+    s->gotgint = 0;
+    s->gahbcfg = 0;
+    s->gusbcfg = 5 << GUSBCFG_USBTRDTIM_SHIFT;
+    s->grstctl = GRSTCTL_AHBIDLE;
+    s->gintsts = GINTSTS_CONIDSTSCHNG | GINTSTS_PTXFEMP | GINTSTS_NPTXFEMP |
+                 GINTSTS_CURMODE_HOST;
+    s->gintmsk = 0;
+    s->grxstsr = 0;
+    s->grxstsp = 0;
+    s->grxfsiz = 1024;
+    s->gnptxfsiz = 1024 << FIFOSIZE_DEPTH_SHIFT;
+    s->gnptxsts = (4 << FIFOSIZE_DEPTH_SHIFT) | 1024;
+    s->gi2cctl = GI2CCTL_I2CDATSE0 | GI2CCTL_ACK;
+    s->gpvndctl = 0;
+    s->ggpio = 0;
+    s->guid = 0;
+    s->gsnpsid = 0x4f54294a;
+    s->ghwcfg1 = 0;
+    s->ghwcfg2 = (8 << GHWCFG2_DEV_TOKEN_Q_DEPTH_SHIFT) |
+                 (4 << GHWCFG2_HOST_PERIO_TX_Q_DEPTH_SHIFT) |
+                 (4 << GHWCFG2_NONPERIO_TX_Q_DEPTH_SHIFT) |
+                 GHWCFG2_DYNAMIC_FIFO |
+                 GHWCFG2_PERIO_EP_SUPPORTED |
+                 ((NB_CHAN - 1) << GHWCFG2_NUM_HOST_CHAN_SHIFT) |
+                 (GHWCFG2_INT_DMA_ARCH << GHWCFG2_ARCHITECTURE_SHIFT) |
+                 (GHWCFG2_OP_MODE_NO_SRP_CAPABLE_HOST << GHWCFG2_OP_MODE_SHIFT);
+    s->ghwcfg3 = (4096 << GHWCFG3_DFIFO_DEPTH_SHIFT) |
+                 (4 << GHWCFG3_PACKET_SIZE_CNTR_WIDTH_SHIFT) |
+                 (4 << GHWCFG3_XFER_SIZE_CNTR_WIDTH_SHIFT);
+    s->ghwcfg4 = 0;
+    s->glpmcfg = 0;
+    s->gpwrdn = GPWRDN_PWRDNRSTN;
+    s->gdfifocfg = 0;
+    s->gadpctl = 0;
+    s->grefclk = 0;
+    s->gintmsk2 = 0;
+    s->gintsts2 = 0;
+
+    s->hptxfsiz = 500 << FIFOSIZE_DEPTH_SHIFT;
+
+    s->hcfg = 2 << HCFG_RESVALID_SHIFT;
+    s->hfir = 60000;
+    s->hfnum = 0x3fff;
+    s->hptxsts = (16 << TXSTS_QSPCAVAIL_SHIFT) | 32768;
+    s->haint = 0;
+    s->haintmsk = 0;
+    s->hprt0 = 0;
+
+    memset(s->hreg1, 0, sizeof(s->hreg1));
+    memset(s->pcgreg, 0, sizeof(s->pcgreg));
+
+    s->sof_time = 0;
+    s->fsmps = 0x2778;
+    s->fi = 11999;
+    s->frame_number = 0;
+
+    for (i = 0; i < NB_CHAN; i++) {
+        s->packet[i].needs_service = false;
+    }
+
+    dwc2_update_irq(s);
+
+    for (i = 0; i < NB_PORTS; i++) {
+        s->hprt0 = HPRT0_PWR;
+        if (devs[i] && devs[i]->attached) {
+            usb_attach(&s->ports[i]);
+            usb_device_reset(devs[i]);
+        }
+    }
+}
+
+static void dwc2_realize(DWC2State *s, DeviceState *dev, Error **errp)
+{
+    Object *obj;
+    Error *err = NULL;
+    int i;
+
+    if (s->portnr > NB_PORTS) {
+        error_setg(errp, "Too many ports! Max port number is %d",
+                   NB_PORTS);
+        return;
+    }
+
+    obj = object_property_get_link(OBJECT(dev), "dma-mr", &err);
+    if (err || obj == NULL) {
+        error_setg(errp, "dwc2: required dma-mr link not found: %s",
+                   error_get_pretty(err));
+        return;
+    }
+
+    s->dma_mr = MEMORY_REGION(obj);
+    address_space_init(&s->dma_as, s->dma_mr, NULL);
+
+    usb_bus_new(&s->bus, sizeof(s->bus), &dwc2_bus_ops, dev);
+    for (i = 0; i < s->portnr; i++) {
+        usb_register_port(&s->bus, &s->ports[i], s, i, &dwc2_port_ops,
+                          USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |
+                          USB_SPEED_MASK_HIGH);
+        s->ports[i].dev = 0;
+    }
+
+    s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, dwc2_work_timer, s);
+    s->async_bh = qemu_bh_new(dwc2_work_bh, s);
+    s->working = false;
+    s->next_chan = 0;
+    s->device = dev;
+}
+
+static void dwc2_init(DWC2State *s, DeviceState *dev)
+{
+    s->usb_frame_time = NANOSECONDS_PER_SECOND / 1000;          /* 1000000 */
+    if (NANOSECONDS_PER_SECOND >= USB_HZ_FS) {
+        s->usb_bit_time = NANOSECONDS_PER_SECOND / USB_HZ_FS;   /* 83.3 */
+    } else {
+        s->usb_bit_time = 1;
+    }
+
+    s->fi = 11999;
+
+    memory_region_init(&s->mem, OBJECT(dev), "dwc2", DWC2_MMIO_SIZE);
+    memory_region_init_io(&s->mem_glbreg, OBJECT(dev), &dwc2_mmio_glbreg_ops, s,
+                          "global", 0x70);
+    memory_region_init_io(&s->mem_fszreg, OBJECT(dev), &dwc2_mmio_fszreg_ops, s,
+                          "hptxfsiz", 0x4);
+    memory_region_init_io(&s->mem_hreg0, OBJECT(dev), &dwc2_mmio_hreg0_ops, s,
+                          "host", 0x44);
+    memory_region_init_io(&s->mem_hreg1, OBJECT(dev), &dwc2_mmio_hreg1_ops, s,
+                          "host channels", 0x20 * NB_CHAN);
+    memory_region_init_io(&s->mem_pcgreg, OBJECT(dev), &dwc2_mmio_pcgreg_ops, s,
+                          "power/clock", 0x8);
+    memory_region_init_io(&s->mem_hreg2, OBJECT(dev), &dwc2_mmio_hreg2_ops, s,
+                          "host fifos", NB_CHAN * 0x1000);
+
+    memory_region_add_subregion(&s->mem, s->glbregbase, &s->mem_glbreg);
+    memory_region_add_subregion(&s->mem, s->fszregbase, &s->mem_fszreg);
+    memory_region_add_subregion(&s->mem, s->hreg0base, &s->mem_hreg0);
+    memory_region_add_subregion(&s->mem, s->hreg1base, &s->mem_hreg1);
+    memory_region_add_subregion(&s->mem, s->pcgregbase, &s->mem_pcgreg);
+    memory_region_add_subregion(&s->mem, s->hreg2base, &s->mem_hreg2);
+
+    s->eof_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                dwc2_frame_boundary, s);
+}
+
+static void dwc2_sysbus_reset(DeviceState *dev)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(dev);
+    DWC2State *s = DWC2_USB(d);
+
+    dwc2_reset(s);
+}
+
+static void dwc2_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(dev);
+    DWC2State *s = DWC2_USB(dev);
+
+    s->glbregbase = 0;
+    s->fszregbase = 0x0100;
+    s->hreg0base = 0x0400;
+    s->hreg1base = 0x0500;
+    s->pcgregbase = 0x0e00;
+    s->hreg2base = 0x1000;
+    s->portnr = NB_PORTS;
+    s->as = &address_space_memory;
+
+    dwc2_realize(s, dev, errp);
+    dwc2_init(s, dev);
+    sysbus_init_irq(d, &s->irq);
+    sysbus_init_mmio(d, &s->mem);
+}
+
+static void dwc2_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = dwc2_sysbus_realize;
+    dc->reset = dwc2_sysbus_reset;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+}
+
+static const TypeInfo dwc2_usb_type_info = {
+    .name          = TYPE_DWC2_USB,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DWC2State),
+    .class_init    = dwc2_class_init,
+};
+
+static void dwc2_usb_register_types(void)
+{
+    type_register_static(&dwc2_usb_type_info);
+}
+
+type_init(dwc2_usb_register_types)
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 1c24d82c09..6cc2554285 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -176,6 +176,53 @@ usb_xhci_xfer_error(void *xfer, uint32_t ret) "%p: ret %d"
 usb_xhci_unimplemented(const char *item, int nr) "%s (0x%x)"
 usb_xhci_enforced_limit(const char *item) "%s"
 
+# hcd-dwc2.c
+usb_dwc2_update_irq(uint32_t level) "level=%d"
+usb_dwc2_raise_global_irq(uint32_t intr) "0x%08x"
+usb_dwc2_lower_global_irq(uint32_t intr) "0x%08x"
+usb_dwc2_raise_host_irq(uint32_t intr) "0x%04x"
+usb_dwc2_lower_host_irq(uint32_t intr) "0x%04x"
+usb_dwc2_sof(int64_t next) "next SOF %" PRId64
+usb_dwc2_bus_start(void) "start SOFs"
+usb_dwc2_bus_stop(void) "stop SOFs"
+usb_dwc2_find_device(uint8_t addr) "%d"
+usb_dwc2_port_disabled(uint32_t pnum) "port %d disabled"
+usb_dwc2_device_found(uint32_t pnum) "device found on port %d"
+usb_dwc2_device_not_found(void) "device not found"
+usb_dwc2_handle_packet(uint32_t chan, void *dev, void *pkt, uint32_t ep, const char *type, const char *dir, uint32_t mps, uint32_t len, uint32_t pcnt) "ch %d dev %p pkt %p ep %d type %s dir %s mps %d len %d pcnt %d"
+usb_dwc2_memory_read(uint32_t addr, uint32_t len) "addr %d len %d"
+usb_dwc2_packet_status(const char *status, uint32_t len) "status %s len %d"
+usb_dwc2_async_packet(void *pkt, uint32_t chan, void *dev, uint32_t ep, uint32_t len) "pkt %p ch %d dev %p ep %d len %d"
+usb_dwc2_memory_write(uint32_t addr, uint32_t len) "addr %d len %d"
+usb_dwc2_packet_done(const char *status, uint32_t actual, uint32_t len, uint32_t pcnt) "status %s actual %d len %d pcnt %d"
+usb_dwc2_packet_next(const char *status, uint32_t len, uint32_t pcnt) "status %s len %d pcnt %d"
+usb_dwc2_attach(void *port) "port %p"
+usb_dwc2_attach_speed(const char *speed) "%s-speed device attached"
+usb_dwc2_detach(void *port) "port %p"
+usb_dwc2_child_detach(void *port, void *child) "port %p child %p"
+usb_dwc2_wakeup(void *port) "port %p"
+usb_dwc2_async_packet_complete(void *port, void *pkt, uint32_t chan, void *dev, uint32_t ep, uint32_t len) "port %p packet %p ch %d dev %p ep %d len %d"
+usb_dwc2_work_bh(void) ""
+usb_dwc2_work_bh_service(uint32_t first, uint32_t current, void *dev, uint32_t ep) "first %d servicing %d dev %p ep %d"
+usb_dwc2_work_bh_next(uint32_t chan) "next %d"
+usb_dwc2_enable_chan(uint32_t chan, void *dev, void *pkt, uint32_t ep) "ch %d dev %p pkt %p ep %d"
+usb_dwc2_glbreg_read(uint64_t addr, const char *reg, uint32_t val) " 0x%04" PRIx64 " %s val 0x%08x"
+usb_dwc2_glbreg_write(uint64_t addr, const char *reg, uint64_t val, uint32_t old, uint64_t result) "0x%04" PRIx64 " %s val 0x%08" PRIx64 " old 0x%08x result 0x%08" PRIx64
+usb_dwc2_fszreg_read(uint64_t addr, uint32_t val) " 0x%04" PRIx64 " HPTXFSIZ  val 0x%08x"
+usb_dwc2_fszreg_write(uint64_t addr, uint64_t val, uint32_t old, uint64_t result) "0x%04" PRIx64 " HPTXFSIZ  val 0x%08" PRIx64 " old 0x%08x result 0x%08" PRIx64
+usb_dwc2_hreg0_read(uint64_t addr, const char *reg, uint32_t val) "  0x%04" PRIx64 " %s val 0x%08x"
+usb_dwc2_hreg0_write(uint64_t addr, const char *reg, uint64_t val, uint32_t old, uint64_t result) " 0x%04" PRIx64 " %s val 0x%08" PRIx64 " old 0x%08x result 0x%08" PRIx64
+usb_dwc2_hreg1_read(uint64_t addr, const char *reg, uint64_t chan, uint32_t val) "  0x%04" PRIx64 " %s%" PRId64 " val 0x%08x"
+usb_dwc2_hreg1_write(uint64_t addr, const char *reg, uint64_t chan, uint64_t val, uint32_t old, uint64_t result) " 0x%04" PRIx64 " %s%" PRId64 " val 0x%08" PRIx64 " old 0x%08x result 0x%08" PRIx64
+usb_dwc2_pcgreg_read(uint64_t addr, const char *reg, uint32_t val) " 0x%04" PRIx64 " %s val 0x%08x"
+usb_dwc2_pcgreg_write(uint64_t addr, const char *reg, uint64_t val, uint32_t old, uint64_t result) "0x%04" PRIx64 " %s val 0x%08" PRIx64 " old 0x%08x result 0x%08" PRIx64
+usb_dwc2_hreg2_read(uint64_t addr, uint64_t fifo, uint32_t val) "  0x%04" PRIx64 " FIFO%" PRId64 "     val 0x%08x"
+usb_dwc2_hreg2_write(uint64_t addr, uint64_t fifo, uint64_t val, uint32_t old, uint64_t result) " 0x%04" PRIx64 " FIFO%" PRId64 "     val 0x%08" PRIx64 " old 0x%08x result 0x%08" PRIx64
+usb_dwc2_hreg0_action(const char *s) "%s"
+usb_dwc2_wakeup_endpoint(void *ep, uint32_t stream) "endp %p stream %d"
+usb_dwc2_work_timer(void) ""
+usb_dwc2_reset(void) "=== RESET ==="
+
 # desc.c
 usb_desc_device(int addr, int len, int ret) "dev %d query device, len %d, ret %d"
 usb_desc_device_qualifier(int addr, int len, int ret) "dev %d query device qualifier, len %d, ret %d"
-- 
2.17.1


