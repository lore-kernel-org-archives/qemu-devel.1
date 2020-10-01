Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9732C47420
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703BE208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoFAJKhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703BE208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNu5H-0005l7-IP
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNtxe-0006Ah-38
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNtxb-0002OL-Pk
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:29:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601540947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9GC9/ihmfVPuNcAnW2v0hGLdwPP8vCySlqQdX6QH/8=;
 b=KoFAJKhOxdJdc2E3cwrEnlkDk+o0PVXt6UwC1YG0HQT8jiRp5ZfzwFsxae6FjcgGh10i7T
 OlnwuokBqPGo7CNcvC/SPozWdDrhykcWdlQMYconVWlyZO73YxvgjPtT52LaO+2/rciucM
 CqD5o0q90qN2e6FDpIqcuLf9PAov0IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-YNEGCN55MQGv-gVaIFGvKA-1; Thu, 01 Oct 2020 04:28:59 -0400
X-MC-Unique: YNEGCN55MQGv-gVaIFGvKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C9EE9CC30;
 Thu,  1 Oct 2020 08:28:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96FEE7B7C0;
 Thu,  1 Oct 2020 08:28:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E686143BFA3; Thu,  1 Oct 2020 10:28:34 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] usb/xhci: add include/hw/usb/xhci.h header file
Date: Thu,  1 Oct 2020 10:28:27 +0200
Message-Id: <20201001082834.15821-3-kraxel@redhat.com>
In-Reply-To: <20201001082834.15821-1-kraxel@redhat.com>
References: <20201001082834.15821-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move a bunch of defines which might be needed outside core xhci
code to that place.  Add XHCI_ prefixes to avoid name clashes.
No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci-sysbus.h |  1 -
 hw/usb/hcd-xhci.h        | 22 ++++++----------------
 include/hw/usb/xhci.h    | 19 +++++++++++++++++++
 hw/usb/hcd-xhci-nec.c    |  4 ++--
 hw/usb/hcd-xhci-pci.c    |  4 ++--
 hw/usb/hcd-xhci-sysbus.c |  4 ++--
 hw/usb/hcd-xhci.c        | 34 ++++++++++++++++------------------
 7 files changed, 47 insertions(+), 41 deletions(-)
 create mode 100644 include/hw/usb/xhci.h

diff --git a/hw/usb/hcd-xhci-sysbus.h b/hw/usb/hcd-xhci-sysbus.h
index a308753ceb9b..fdfcbbee3bf4 100644
--- a/hw/usb/hcd-xhci-sysbus.h
+++ b/hw/usb/hcd-xhci-sysbus.h
@@ -15,7 +15,6 @@
 #include "hcd-xhci.h"
 #include "hw/sysbus.h"
 
-#define TYPE_XHCI_SYSBUS "sysbus-xhci"
 #define XHCI_SYSBUS(obj) \
     OBJECT_CHECK(XHCISysbusState, (obj), TYPE_XHCI_SYSBUS)
 
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index f859a17e73ee..ccf50ae28bed 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -24,23 +24,13 @@
 #include "qom/object.h"
 
 #include "hw/usb.h"
+#include "hw/usb/xhci.h"
 #include "sysemu/dma.h"
 
-#define TYPE_XHCI "base-xhci"
-#define TYPE_NEC_XHCI "nec-usb-xhci"
-#define TYPE_QEMU_XHCI "qemu-xhci"
-
 OBJECT_DECLARE_SIMPLE_TYPE(XHCIState, XHCI)
 
-#define MAXPORTS_2 15
-#define MAXPORTS_3 15
-
-#define MAXPORTS (MAXPORTS_2 + MAXPORTS_3)
-#define MAXSLOTS 64
-#define MAXINTRS 16
-
 /* Very pessimistic, let's hope it's enough for all cases */
-#define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)
+#define EV_QUEUE (((3 * 24) + 16) * XHCI_MAXSLOTS)
 
 typedef struct XHCIStreamContext XHCIStreamContext;
 typedef struct XHCIEPContext XHCIEPContext;
@@ -217,15 +207,15 @@ typedef struct XHCIState {
     uint32_t dcbaap_high;
     uint32_t config;
 
-    USBPort  uports[MAX_CONST(MAXPORTS_2, MAXPORTS_3)];
-    XHCIPort ports[MAXPORTS];
-    XHCISlot slots[MAXSLOTS];
+    USBPort  uports[MAX_CONST(XHCI_MAXPORTS_2, XHCI_MAXPORTS_3)];
+    XHCIPort ports[XHCI_MAXPORTS];
+    XHCISlot slots[XHCI_MAXSLOTS];
     uint32_t numports;
 
     /* Runtime Registers */
     int64_t mfindex_start;
     QEMUTimer *mfwrap_timer;
-    XHCIInterrupter intr[MAXINTRS];
+    XHCIInterrupter intr[XHCI_MAXINTRS];
 
     XHCIRing cmd_ring;
 
diff --git a/include/hw/usb/xhci.h b/include/hw/usb/xhci.h
new file mode 100644
index 000000000000..dc0c29930dcc
--- /dev/null
+++ b/include/hw/usb/xhci.h
@@ -0,0 +1,19 @@
+#ifndef HW_USB_XHCI_H
+#define HW_USB_XHCI_H
+
+#define TYPE_XHCI "base-xhci"
+#define TYPE_NEC_XHCI "nec-usb-xhci"
+#define TYPE_QEMU_XHCI "qemu-xhci"
+#define TYPE_XHCI_SYSBUS "sysbus-xhci"
+
+#define XHCI_MAXPORTS_2 15
+#define XHCI_MAXPORTS_3 15
+
+#define XHCI_MAXPORTS (XHCI_MAXPORTS_2 + XHCI_MAXPORTS_3)
+#define XHCI_MAXSLOTS 64
+#define XHCI_MAXINTRS 16
+
+/* must be power of 2 */
+#define XHCI_LEN_REGS 0x4000
+
+#endif
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 2efa6fa0f8af..5707b2cabd16 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -34,8 +34,8 @@ static Property nec_xhci_properties[] = {
                     xhci.flags, XHCI_FLAG_SS_FIRST, true),
     DEFINE_PROP_BIT("force-pcie-endcap", XHCIPciState, xhci.flags,
                     XHCI_FLAG_FORCE_PCIE_ENDCAP, false),
-    DEFINE_PROP_UINT32("intrs", XHCIPciState, xhci.numintrs, MAXINTRS),
-    DEFINE_PROP_UINT32("slots", XHCIPciState, xhci.numslots, MAXSLOTS),
+    DEFINE_PROP_UINT32("intrs", XHCIPciState, xhci.numintrs, XHCI_MAXINTRS),
+    DEFINE_PROP_UINT32("slots", XHCIPciState, xhci.numslots, XHCI_MAXSLOTS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a6d746e1da38..b78fcd2bb2d5 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -240,8 +240,8 @@ static void qemu_xhci_instance_init(Object *obj)
 
     s->msi      = ON_OFF_AUTO_OFF;
     s->msix     = ON_OFF_AUTO_AUTO;
-    xhci->numintrs = MAXINTRS;
-    xhci->numslots = MAXSLOTS;
+    xhci->numintrs = XHCI_MAXINTRS;
+    xhci->numslots = XHCI_MAXSLOTS;
     xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
 }
 
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index 852ca5103b4d..570618467356 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -69,8 +69,8 @@ static void xhci_sysbus_instance_init(Object *obj)
 }
 
 static Property xhci_sysbus_props[] = {
-    DEFINE_PROP_UINT32("intrs", XHCISysbusState, xhci.numintrs, MAXINTRS),
-    DEFINE_PROP_UINT32("slots", XHCISysbusState, xhci.numslots, MAXSLOTS),
+    DEFINE_PROP_UINT32("intrs", XHCISysbusState, xhci.numintrs, XHCI_MAXINTRS),
+    DEFINE_PROP_UINT32("slots", XHCISysbusState, xhci.numslots, XHCI_MAXSLOTS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5e8bed9ef90c..79ce5c4be6c4 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -46,15 +46,13 @@
 #define TRANSFER_LIMIT  256
 
 #define LEN_CAP         0x40
-#define LEN_OPER        (0x400 + 0x10 * MAXPORTS)
-#define LEN_RUNTIME     ((MAXINTRS + 1) * 0x20)
-#define LEN_DOORBELL    ((MAXSLOTS + 1) * 0x20)
+#define LEN_OPER        (0x400 + 0x10 * XHCI_MAXPORTS)
+#define LEN_RUNTIME     ((XHCI_MAXINTRS + 1) * 0x20)
+#define LEN_DOORBELL    ((XHCI_MAXSLOTS + 1) * 0x20)
 
 #define OFF_OPER        LEN_CAP
 #define OFF_RUNTIME     0x1000
 #define OFF_DOORBELL    0x2000
-/* must be power of 2 */
-#define LEN_REGS        0x4000
 
 #if (OFF_OPER + LEN_OPER) > OFF_RUNTIME
 #error Increase OFF_RUNTIME
@@ -62,8 +60,8 @@
 #if (OFF_RUNTIME + LEN_RUNTIME) > OFF_DOORBELL
 #error Increase OFF_DOORBELL
 #endif
-#if (OFF_DOORBELL + LEN_DOORBELL) > LEN_REGS
-# error Increase LEN_REGS
+#if (OFF_DOORBELL + LEN_DOORBELL) > XHCI_LEN_REGS
+# error Increase XHCI_LEN_REGS
 #endif
 
 /* bit definitions */
@@ -3276,11 +3274,11 @@ static void usb_xhci_init(XHCIState *xhci)
 
     xhci->usbsts = USBSTS_HCH;
 
-    if (xhci->numports_2 > MAXPORTS_2) {
-        xhci->numports_2 = MAXPORTS_2;
+    if (xhci->numports_2 > XHCI_MAXPORTS_2) {
+        xhci->numports_2 = XHCI_MAXPORTS_2;
     }
-    if (xhci->numports_3 > MAXPORTS_3) {
-        xhci->numports_3 = MAXPORTS_3;
+    if (xhci->numports_3 > XHCI_MAXPORTS_3) {
+        xhci->numports_3 = XHCI_MAXPORTS_3;
     }
     usbports = MAX(xhci->numports_2, xhci->numports_3);
     xhci->numports = xhci->numports_2 + xhci->numports_3;
@@ -3302,7 +3300,7 @@ static void usb_xhci_init(XHCIState *xhci)
                 USB_SPEED_MASK_LOW  |
                 USB_SPEED_MASK_FULL |
                 USB_SPEED_MASK_HIGH;
-            assert(i < MAXPORTS);
+            assert(i < XHCI_MAXPORTS);
             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+1);
             speedmask |= port->speedmask;
         }
@@ -3316,7 +3314,7 @@ static void usb_xhci_init(XHCIState *xhci)
             }
             port->uport = &xhci->uports[i];
             port->speedmask = USB_SPEED_MASK_SUPER;
-            assert(i < MAXPORTS);
+            assert(i < XHCI_MAXPORTS);
             snprintf(port->name, sizeof(port->name), "usb3 port #%d", i+1);
             speedmask |= port->speedmask;
         }
@@ -3331,8 +3329,8 @@ static void usb_xhci_realize(DeviceState *dev, Error **errp)
 
     XHCIState *xhci = XHCI(dev);
 
-    if (xhci->numintrs > MAXINTRS) {
-        xhci->numintrs = MAXINTRS;
+    if (xhci->numintrs > XHCI_MAXINTRS) {
+        xhci->numintrs = XHCI_MAXINTRS;
     }
     while (xhci->numintrs & (xhci->numintrs - 1)) {   /* ! power of 2 */
         xhci->numintrs++;
@@ -3340,8 +3338,8 @@ static void usb_xhci_realize(DeviceState *dev, Error **errp)
     if (xhci->numintrs < 1) {
         xhci->numintrs = 1;
     }
-    if (xhci->numslots > MAXSLOTS) {
-        xhci->numslots = MAXSLOTS;
+    if (xhci->numslots > XHCI_MAXSLOTS) {
+        xhci->numslots = XHCI_MAXSLOTS;
     }
     if (xhci->numslots < 1) {
         xhci->numslots = 1;
@@ -3355,7 +3353,7 @@ static void usb_xhci_realize(DeviceState *dev, Error **errp)
     usb_xhci_init(xhci);
     xhci->mfwrap_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, xhci_mfwrap_timer, xhci);
 
-    memory_region_init(&xhci->mem, OBJECT(dev), "xhci", LEN_REGS);
+    memory_region_init(&xhci->mem, OBJECT(dev), "xhci", XHCI_LEN_REGS);
     memory_region_init_io(&xhci->mem_cap, OBJECT(dev), &xhci_cap_ops, xhci,
                           "capabilities", LEN_CAP);
     memory_region_init_io(&xhci->mem_oper, OBJECT(dev), &xhci_oper_ops, xhci,
-- 
2.27.0


