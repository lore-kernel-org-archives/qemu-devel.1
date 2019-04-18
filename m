Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC2CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821D8218EA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821D8218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBRN-0006gn-M0
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 14:07:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBMV-00033P-Ql
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBMO-0001ja-UH
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hHBM2-0001PM-Fm; Thu, 18 Apr 2019 14:01:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF0D4550CF;
	Thu, 18 Apr 2019 18:01:34 +0000 (UTC)
Received: from thuth.com (ovpn-116-56.ams2.redhat.com [10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C7A31001E98;
	Thu, 18 Apr 2019 18:01:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Date: Thu, 18 Apr 2019 20:00:31 +0200
Message-Id: <20190418180057.3593-4-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 18 Apr 2019 18:01:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-QEMU-4.1 v5 03/29] hw/usb/hcd-ohci: Move
 PCI-related code into a separate file
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Rob Herring <robh@kernel.org>, qemu-block@nongnu.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>,
	Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>,
	Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418180031.pBiwaIQTvuauU8p7LoRz0sDSt7HZyULy1r25JH-CoPM@z>

Some machines (like the pxa2xx-based ARM machines) only have a sysbus
OHCI controller, but no PCI. With the new Kconfig-style build system,
it will soon be possible to create QEMU binaries that only contain
such PCI-less machines. However, the two OHCI controllers, for sysbus
and for PCI, are currently both located in one file, so the PCI code
is still required for linking here. Move the OHCI-PCI device code
into a separate file, so that it is possible to use the sysbus OHCI
device also without the PCI dependency.

Apart from moving code to a new file (and a new header), this patch
might also fix one subtle bug: The ohci_die() function always assumed
to be running with a OHCI-PCI controller and called some PCI-specific
functions - but if I got the code right, ohci_die() might also get
called for the sysbus-OHCI device, so it likely failed in that case.
I've changed this part of the code now, so that there are two ohci_die()
implementations now, one for sysbus and one for PCI.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/Kconfig        |   6 +-
 hw/usb/Makefile.objs  |   1 +
 hw/usb/hcd-ohci-pci.c | 166 ++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.c     | 244 +++---------------------------------------
 hw/usb/hcd-ohci.h     | 132 +++++++++++++++++++++++
 5 files changed, 321 insertions(+), 228 deletions(-)
 create mode 100644 hw/usb/hcd-ohci-pci.c
 create mode 100644 hw/usb/hcd-ohci.h

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index a1b7acb12a..564305e283 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -8,10 +8,14 @@ config USB_UHCI
     select USB
=20
 config USB_OHCI
+    bool
+    select USB
+
+config USB_OHCI_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
-    select USB
+    select USB_OHCI
=20
 config USB_EHCI
     bool
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 2b929649ac..81688f6e70 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -5,6 +5,7 @@ common-obj-$(CONFIG_USB) +=3D desc.o desc-msos.o
 # usb host adapters
 common-obj-$(CONFIG_USB_UHCI) +=3D hcd-uhci.o
 common-obj-$(CONFIG_USB_OHCI) +=3D hcd-ohci.o
+common-obj-$(CONFIG_USB_OHCI_PCI) +=3D hcd-ohci-pci.o
 common-obj-$(CONFIG_USB_EHCI) +=3D hcd-ehci.o hcd-ehci-pci.o
 common-obj-$(CONFIG_USB_EHCI_SYSBUS) +=3D hcd-ehci.o hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) +=3D hcd-xhci.o
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
new file mode 100644
index 0000000000..e972df35c9
--- /dev/null
+++ b/hw/usb/hcd-ohci-pci.c
@@ -0,0 +1,166 @@
+/*
+ * QEMU USB OHCI Emulation
+ * Copyright (c) 2004 Gianni Tedesco
+ * Copyright (c) 2006 CodeSourcery
+ * Copyright (c) 2006 Openedhand Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "qapi/error.h"
+#include "qemu/timer.h"
+#include "hw/usb.h"
+#include "hw/pci/pci.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-dma.h"
+#include "trace.h"
+#include "hcd-ohci.h"
+
+#define TYPE_PCI_OHCI "pci-ohci"
+#define PCI_OHCI(obj) OBJECT_CHECK(OHCIPCIState, (obj), TYPE_PCI_OHCI)
+
+typedef struct {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    OHCIState state;
+    char *masterbus;
+    uint32_t num_ports;
+    uint32_t firstport;
+} OHCIPCIState;
+
+/**
+ * A typical O/EHCI will stop operating, set itself into error state
+ * (which can be queried by MMIO) and will set PERR in its config
+ * space to signal that it got an error
+ */
+static void ohci_pci_die(OHCIState *ohci)
+{
+    OHCIPCIState *dev =3D container_of(ohci, OHCIPCIState, state);
+
+    trace_usb_ohci_die();
+
+    ohci_set_interrupt(ohci, OHCI_INTR_UE);
+    ohci_bus_stop(ohci);
+    pci_set_word(dev->parent_obj.config + PCI_STATUS,
+                 PCI_STATUS_DETECTED_PARITY);
+}
+
+static void usb_ohci_realize_pci(PCIDevice *dev, Error **errp)
+{
+    Error *err =3D NULL;
+    OHCIPCIState *ohci =3D PCI_OHCI(dev);
+
+    dev->config[PCI_CLASS_PROG] =3D 0x10; /* OHCI */
+    dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin A */
+
+    usb_ohci_init(&ohci->state, DEVICE(dev), ohci->num_ports, 0,
+                  ohci->masterbus, ohci->firstport,
+                  pci_get_address_space(dev), ohci_pci_die, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    ohci->state.irq =3D pci_allocate_irq(dev);
+    pci_register_bar(dev, 0, 0, &ohci->state.mem);
+}
+
+static void usb_ohci_exit(PCIDevice *dev)
+{
+    OHCIPCIState *ohci =3D PCI_OHCI(dev);
+    OHCIState *s =3D &ohci->state;
+
+    trace_usb_ohci_exit(s->name);
+    ohci_bus_stop(s);
+
+    if (s->async_td) {
+        usb_cancel_packet(&s->usb_packet);
+        s->async_td =3D 0;
+    }
+    ohci_stop_endpoints(s);
+
+    if (!ohci->masterbus) {
+        usb_bus_release(&s->bus);
+    }
+
+    timer_del(s->eof_timer);
+    timer_free(s->eof_timer);
+}
+
+static void usb_ohci_reset_pci(DeviceState *d)
+{
+    PCIDevice *dev =3D PCI_DEVICE(d);
+    OHCIPCIState *ohci =3D PCI_OHCI(dev);
+    OHCIState *s =3D &ohci->state;
+
+    ohci_hard_reset(s);
+}
+
+static Property ohci_pci_properties[] =3D {
+    DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),
+    DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),
+    DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_ohci =3D {
+    .name =3D "ohci",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, OHCIPCIState),
+        VMSTATE_STRUCT(state, OHCIPCIState, 1, vmstate_ohci_state, OHCIS=
tate),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void ohci_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->realize =3D usb_ohci_realize_pci;
+    k->exit =3D usb_ohci_exit;
+    k->vendor_id =3D PCI_VENDOR_ID_APPLE;
+    k->device_id =3D PCI_DEVICE_ID_APPLE_IPID_USB;
+    k->class_id =3D PCI_CLASS_SERIAL_USB;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+    dc->desc =3D "Apple USB Controller";
+    dc->props =3D ohci_pci_properties;
+    dc->hotpluggable =3D false;
+    dc->vmsd =3D &vmstate_ohci;
+    dc->reset =3D usb_ohci_reset_pci;
+}
+
+static const TypeInfo ohci_pci_info =3D {
+    .name          =3D TYPE_PCI_OHCI,
+    .parent        =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(OHCIPCIState),
+    .class_init    =3D ohci_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void ohci_pci_register_types(void)
+{
+    type_register_static(&ohci_pci_info);
+}
+
+type_init(ohci_pci_register_types)
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 81cf5ab7a5..343816d561 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -30,86 +30,19 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
-#include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
 #include "trace.h"
+#include "hcd-ohci.h"
=20
 /* This causes frames to occur 1000x slower */
 //#define OHCI_TIME_WARP 1
=20
-/* Number of Downstream Ports on the root hub.  */
-
-#define OHCI_MAX_PORTS 15
-
 #define ED_LINK_LIMIT 32
=20
 static int64_t usb_frame_time;
 static int64_t usb_bit_time;
=20
-typedef struct OHCIPort {
-    USBPort port;
-    uint32_t ctrl;
-} OHCIPort;
-
-typedef struct {
-    USBBus bus;
-    qemu_irq irq;
-    MemoryRegion mem;
-    AddressSpace *as;
-    uint32_t num_ports;
-    const char *name;
-
-    QEMUTimer *eof_timer;
-    int64_t sof_time;
-
-    /* OHCI state */
-    /* Control partition */
-    uint32_t ctl, status;
-    uint32_t intr_status;
-    uint32_t intr;
-
-    /* memory pointer partition */
-    uint32_t hcca;
-    uint32_t ctrl_head, ctrl_cur;
-    uint32_t bulk_head, bulk_cur;
-    uint32_t per_cur;
-    uint32_t done;
-    int32_t done_count;
-
-    /* Frame counter partition */
-    uint16_t fsmps;
-    uint8_t fit;
-    uint16_t fi;
-    uint8_t frt;
-    uint16_t frame_number;
-    uint16_t padding;
-    uint32_t pstart;
-    uint32_t lst;
-
-    /* Root Hub partition */
-    uint32_t rhdesc_a, rhdesc_b;
-    uint32_t rhstatus;
-    OHCIPort rhport[OHCI_MAX_PORTS];
-
-    /* PXA27x Non-OHCI events */
-    uint32_t hstatus;
-    uint32_t hmask;
-    uint32_t hreset;
-    uint32_t htest;
-
-    /* SM501 local memory offset */
-    dma_addr_t localmem_base;
-
-    /* Active packets.  */
-    uint32_t old_ctl;
-    USBPacket usb_packet;
-    uint8_t usb_buf[8192];
-    uint32_t async_td;
-    bool async_complete;
-
-} OHCIState;
-
 /* Host Controller Communications Area */
 struct ohci_hcca {
     uint32_t intr[32];
@@ -122,7 +55,6 @@ struct ohci_hcca {
 #define ED_WBACK_OFFSET offsetof(struct ohci_ed, head)
 #define ED_WBACK_SIZE   4
=20
-static void ohci_bus_stop(OHCIState *ohci);
 static void ohci_async_cancel_device(OHCIState *ohci, USBDevice *dev);
=20
 /* Bitfields for the first word of an Endpoint Desciptor.  */
@@ -229,16 +161,6 @@ struct ohci_iso_td {
 #define OHCI_STATUS_OCR       (1<<3)
 #define OHCI_STATUS_SOC       ((1<<6)|(1<<7))
=20
-#define OHCI_INTR_SO          (1U<<0) /* Scheduling overrun */
-#define OHCI_INTR_WD          (1U<<1) /* HcDoneHead writeback */
-#define OHCI_INTR_SF          (1U<<2) /* Start of frame */
-#define OHCI_INTR_RD          (1U<<3) /* Resume detect */
-#define OHCI_INTR_UE          (1U<<4) /* Unrecoverable error */
-#define OHCI_INTR_FNO         (1U<<5) /* Frame number overflow */
-#define OHCI_INTR_RHSC        (1U<<6) /* Root hub status change */
-#define OHCI_INTR_OC          (1U<<30) /* Ownership change */
-#define OHCI_INTR_MIE         (1U<<31) /* Master Interrupt Enable */
-
 #define OHCI_HCCA_SIZE        0x100
 #define OHCI_HCCA_MASK        0xffffff00
=20
@@ -302,25 +224,9 @@ struct ohci_iso_td {
=20
 #define OHCI_HRESET_FSBIR       (1 << 0)
=20
-static void ohci_die(OHCIState *ohci);
-
-/* Update IRQ levels */
-static inline void ohci_intr_update(OHCIState *ohci)
+static inline void ohci_die(OHCIState *ohci)
 {
-    int level =3D 0;
-
-    if ((ohci->intr & OHCI_INTR_MIE) &&
-        (ohci->intr_status & ohci->intr))
-        level =3D 1;
-
-    qemu_set_irq(ohci->irq, level);
-}
-
-/* Set an interrupt */
-static inline void ohci_set_interrupt(OHCIState *ohci, uint32_t intr)
-{
-    ohci->intr_status |=3D intr;
-    ohci_intr_update(ohci);
+    ohci->ohci_die(ohci);
 }
=20
 /* Attach or detach a device on a root hub port.  */
@@ -426,7 +332,7 @@ static USBDevice *ohci_find_device(OHCIState *ohci, u=
int8_t addr)
     return NULL;
 }
=20
-static void ohci_stop_endpoints(OHCIState *ohci)
+void ohci_stop_endpoints(OHCIState *ohci)
 {
     USBDevice *dev;
     int i, j;
@@ -498,7 +404,7 @@ static void ohci_soft_reset(OHCIState *ohci)
     ohci->lst =3D OHCI_LS_THRESH;
 }
=20
-static void ohci_hard_reset(OHCIState *ohci)
+void ohci_hard_reset(OHCIState *ohci)
 {
     ohci_soft_reset(ohci);
     ohci->ctl =3D 0;
@@ -1372,7 +1278,7 @@ static int ohci_bus_start(OHCIState *ohci)
 }
=20
 /* Stop sending SOF tokens on the bus */
-static void ohci_bus_stop(OHCIState *ohci)
+void ohci_bus_stop(OHCIState *ohci)
 {
     trace_usb_ohci_stop(ohci->name);
     timer_del(ohci->eof_timer);
@@ -1852,15 +1758,16 @@ static USBPortOps ohci_port_ops =3D {
 static USBBusOps ohci_bus_ops =3D {
 };
=20
-static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
-                          uint32_t num_ports, dma_addr_t localmem_base,
-                          char *masterbus, uint32_t firstport,
-                          AddressSpace *as, Error **errp)
+void usb_ohci_init(OHCIState *ohci, DeviceState *dev, uint32_t num_ports=
,
+                   dma_addr_t localmem_base, char *masterbus,
+                   uint32_t firstport, AddressSpace *as,
+                   void (*ohci_die_func)(OHCIState *ohci), Error **errp)
 {
     Error *err =3D NULL;
     int i;
=20
     ohci->as =3D as;
+    ohci->ohci_die =3D ohci_die_func;
=20
     if (num_ports > OHCI_MAX_PORTS) {
         error_setg(errp, "OHCI num-ports=3D%u is too big (limit is %u po=
rts)",
@@ -1919,85 +1826,16 @@ static void usb_ohci_init(OHCIState *ohci, Device=
State *dev,
                                    ohci_frame_boundary, ohci);
 }
=20
-#define TYPE_PCI_OHCI "pci-ohci"
-#define PCI_OHCI(obj) OBJECT_CHECK(OHCIPCIState, (obj), TYPE_PCI_OHCI)
-
-typedef struct {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    OHCIState state;
-    char *masterbus;
-    uint32_t num_ports;
-    uint32_t firstport;
-} OHCIPCIState;
-
-/** A typical O/EHCI will stop operating, set itself into error state
- * (which can be queried by MMIO) and will set PERR in its config
- * space to signal that it got an error
+/**
+ * A typical O/EHCI will stop operating, set itself into error state
+ * (which can be queried by MMIO) to signal that it got an error
  */
-static void ohci_die(OHCIState *ohci)
+static void ohci_sysbus_die(OHCIState *ohci)
 {
-    OHCIPCIState *dev =3D container_of(ohci, OHCIPCIState, state);
-
     trace_usb_ohci_die();
=20
     ohci_set_interrupt(ohci, OHCI_INTR_UE);
     ohci_bus_stop(ohci);
-    pci_set_word(dev->parent_obj.config + PCI_STATUS,
-                 PCI_STATUS_DETECTED_PARITY);
-}
-
-static void usb_ohci_realize_pci(PCIDevice *dev, Error **errp)
-{
-    Error *err =3D NULL;
-    OHCIPCIState *ohci =3D PCI_OHCI(dev);
-
-    dev->config[PCI_CLASS_PROG] =3D 0x10; /* OHCI */
-    dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin A */
-
-    usb_ohci_init(&ohci->state, DEVICE(dev), ohci->num_ports, 0,
-                  ohci->masterbus, ohci->firstport,
-                  pci_get_address_space(dev), &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    ohci->state.irq =3D pci_allocate_irq(dev);
-    pci_register_bar(dev, 0, 0, &ohci->state.mem);
-}
-
-static void usb_ohci_exit(PCIDevice *dev)
-{
-    OHCIPCIState *ohci =3D PCI_OHCI(dev);
-    OHCIState *s =3D &ohci->state;
-
-    trace_usb_ohci_exit(s->name);
-    ohci_bus_stop(s);
-
-    if (s->async_td) {
-        usb_cancel_packet(&s->usb_packet);
-        s->async_td =3D 0;
-    }
-    ohci_stop_endpoints(s);
-
-    if (!ohci->masterbus) {
-        usb_bus_release(&s->bus);
-    }
-
-    timer_del(s->eof_timer);
-    timer_free(s->eof_timer);
-}
-
-static void usb_ohci_reset_pci(DeviceState *d)
-{
-    PCIDevice *dev =3D PCI_DEVICE(d);
-    OHCIPCIState *ohci =3D PCI_OHCI(dev);
-    OHCIState *s =3D &ohci->state;
-
-    ohci_hard_reset(s);
 }
=20
 #define TYPE_SYSBUS_OHCI "sysbus-ohci"
@@ -2023,7 +1861,7 @@ static void ohci_realize_pxa(DeviceState *dev, Erro=
r **errp)
=20
     usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
                   s->masterbus, s->firstport,
-                  &address_space_memory, &err);
+                  &address_space_memory, ohci_sysbus_die, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -2040,13 +1878,6 @@ static void usb_ohci_reset_sysbus(DeviceState *dev=
)
     ohci_hard_reset(ohci);
 }
=20
-static Property ohci_pci_properties[] =3D {
-    DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),
-    DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),
-    DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static const VMStateDescription vmstate_ohci_state_port =3D {
     .name =3D "ohci-core/port",
     .version_id =3D 1,
@@ -2075,7 +1906,7 @@ static const VMStateDescription vmstate_ohci_eof_ti=
mer =3D {
     },
 };
=20
-static const VMStateDescription vmstate_ohci_state =3D {
+const VMStateDescription vmstate_ohci_state =3D {
     .name =3D "ohci-core",
     .version_id =3D 1,
     .minimum_version_id =3D 1,
@@ -2122,46 +1953,6 @@ static const VMStateDescription vmstate_ohci_state=
 =3D {
     }
 };
=20
-static const VMStateDescription vmstate_ohci =3D {
-    .name =3D "ohci",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(parent_obj, OHCIPCIState),
-        VMSTATE_STRUCT(state, OHCIPCIState, 1, vmstate_ohci_state, OHCIS=
tate),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void ohci_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
-
-    k->realize =3D usb_ohci_realize_pci;
-    k->exit =3D usb_ohci_exit;
-    k->vendor_id =3D PCI_VENDOR_ID_APPLE;
-    k->device_id =3D PCI_DEVICE_ID_APPLE_IPID_USB;
-    k->class_id =3D PCI_CLASS_SERIAL_USB;
-    set_bit(DEVICE_CATEGORY_USB, dc->categories);
-    dc->desc =3D "Apple USB Controller";
-    dc->props =3D ohci_pci_properties;
-    dc->hotpluggable =3D false;
-    dc->vmsd =3D &vmstate_ohci;
-    dc->reset =3D usb_ohci_reset_pci;
-}
-
-static const TypeInfo ohci_pci_info =3D {
-    .name          =3D TYPE_PCI_OHCI,
-    .parent        =3D TYPE_PCI_DEVICE,
-    .instance_size =3D sizeof(OHCIPCIState),
-    .class_init    =3D ohci_pci_class_init,
-    .interfaces =3D (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
 static Property ohci_sysbus_properties[] =3D {
     DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
     DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
@@ -2190,7 +1981,6 @@ static const TypeInfo ohci_sysbus_info =3D {
=20
 static void ohci_register_types(void)
 {
-    type_register_static(&ohci_pci_info);
     type_register_static(&ohci_sysbus_info);
 }
=20
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
new file mode 100644
index 0000000000..481ceba7ff
--- /dev/null
+++ b/hw/usb/hcd-ohci.h
@@ -0,0 +1,132 @@
+/*
+ * QEMU USB OHCI Emulation
+ * Copyright (c) 2004 Gianni Tedesco
+ * Copyright (c) 2006 CodeSourcery
+ * Copyright (c) 2006 Openedhand Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ */
+
+#ifndef HCD_OHCI_H
+#define HCD_OHCI_H
+
+#include "sysemu/dma.h"
+
+/* Number of Downstream Ports on the root hub: */
+#define OHCI_MAX_PORTS 15
+
+typedef struct OHCIPort {
+    USBPort port;
+    uint32_t ctrl;
+} OHCIPort;
+
+typedef struct OHCIState {
+    USBBus bus;
+    qemu_irq irq;
+    MemoryRegion mem;
+    AddressSpace *as;
+    uint32_t num_ports;
+    const char *name;
+
+    QEMUTimer *eof_timer;
+    int64_t sof_time;
+
+    /* OHCI state */
+    /* Control partition */
+    uint32_t ctl, status;
+    uint32_t intr_status;
+    uint32_t intr;
+
+    /* memory pointer partition */
+    uint32_t hcca;
+    uint32_t ctrl_head, ctrl_cur;
+    uint32_t bulk_head, bulk_cur;
+    uint32_t per_cur;
+    uint32_t done;
+    int32_t done_count;
+
+    /* Frame counter partition */
+    uint16_t fsmps;
+    uint8_t fit;
+    uint16_t fi;
+    uint8_t frt;
+    uint16_t frame_number;
+    uint16_t padding;
+    uint32_t pstart;
+    uint32_t lst;
+
+    /* Root Hub partition */
+    uint32_t rhdesc_a, rhdesc_b;
+    uint32_t rhstatus;
+    OHCIPort rhport[OHCI_MAX_PORTS];
+
+    /* PXA27x Non-OHCI events */
+    uint32_t hstatus;
+    uint32_t hmask;
+    uint32_t hreset;
+    uint32_t htest;
+
+    /* SM501 local memory offset */
+    dma_addr_t localmem_base;
+
+    /* Active packets.  */
+    uint32_t old_ctl;
+    USBPacket usb_packet;
+    uint8_t usb_buf[8192];
+    uint32_t async_td;
+    bool async_complete;
+
+    void (*ohci_die)(struct OHCIState *ohci);
+} OHCIState;
+
+extern const VMStateDescription vmstate_ohci_state;
+
+#define OHCI_INTR_SO          (1U << 0)   /* Scheduling overrun */
+#define OHCI_INTR_WD          (1U << 1)   /* HcDoneHead writeback */
+#define OHCI_INTR_SF          (1U << 2)   /* Start of frame */
+#define OHCI_INTR_RD          (1U << 3)   /* Resume detect */
+#define OHCI_INTR_UE          (1U << 4)   /* Unrecoverable error */
+#define OHCI_INTR_FNO         (1U << 5)   /* Frame number overflow */
+#define OHCI_INTR_RHSC        (1U << 6)   /* Root hub status change */
+#define OHCI_INTR_OC          (1U << 30)  /* Ownership change */
+#define OHCI_INTR_MIE         (1U << 31)  /* Master Interrupt Enable */
+
+/* Update IRQ levels */
+static inline void ohci_intr_update(OHCIState *ohci)
+{
+    int level =3D 0;
+
+    if ((ohci->intr & OHCI_INTR_MIE) &&
+        (ohci->intr_status & ohci->intr))
+        level =3D 1;
+
+    qemu_set_irq(ohci->irq, level);
+}
+
+/* Set an interrupt */
+static inline void ohci_set_interrupt(OHCIState *ohci, uint32_t intr)
+{
+    ohci->intr_status |=3D intr;
+    ohci_intr_update(ohci);
+}
+
+void usb_ohci_init(OHCIState *ohci, DeviceState *dev, uint32_t num_ports=
,
+                   dma_addr_t localmem_base, char *masterbus,
+                   uint32_t firstport, AddressSpace *as,
+                   void (*ohci_die_func)(OHCIState *ohci), Error **errp)=
;
+void ohci_hard_reset(OHCIState *ohci);
+void ohci_bus_stop(OHCIState *ohci);
+void ohci_stop_endpoints(OHCIState *ohci);
+
+#endif
--=20
2.21.0


