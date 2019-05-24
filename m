Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF41C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6D72081C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6D72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50139 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4Io-0000Wa-Qn
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:07:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hU4Ea-0005PV-ST
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hU4EY-0006LM-TV
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hU4EW-0006GO-Vy
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:03:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56238368E3
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 07:03:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-101.ams2.redhat.com
	[10.36.116.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DFE725B689;
	Fri, 24 May 2019 07:03:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id E43911753C; Fri, 24 May 2019 09:03:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 09:03:10 +0200
Message-Id: <20190524070310.4952-6-kraxel@redhat.com>
In-Reply-To: <20190524070310.4952-1-kraxel@redhat.com>
References: <20190524070310.4952-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 24 May 2019 07:03:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 5/5] usb-hub: emulate per port power
 switching
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for per port power switching.
Virtual power of course ;)

Use port-power=on property to enable this.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-hub.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 29f4d6723e26..2b64d6ef0349 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
+#include "qemu/timer.h"
 #include "trace.h"
 #include "hw/usb.h"
 #include "desc.h"
@@ -41,6 +42,8 @@ typedef struct USBHubState {
     USBDevice dev;
     USBEndpoint *intr;
     uint32_t num_ports;
+    bool port_power;
+    QEMUTimer *port_timer;
     USBHubPort ports[MAX_PORTS];
 } USBHubState;
 
@@ -203,6 +206,20 @@ static bool usb_hub_port_update(USBHubPort *port)
     return notify;
 }
 
+static void usb_hub_port_update_timer(void *opaque)
+{
+    USBHubState *s = opaque;
+    bool notify = false;
+    int i;
+
+    for (i = 0; i < s->num_ports; i++) {
+        notify |= usb_hub_port_update(&s->ports[i]);
+    }
+    if (notify) {
+        usb_wakeup(s->intr, 0);
+    }
+}
+
 static void usb_hub_attach(USBPort *port1)
 {
     USBHubState *s = port1->opaque;
@@ -405,6 +422,11 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
                 usb_wakeup(s->intr, 0);
                 break;
             case PORT_POWER:
+                if (s->port_power) {
+                    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+                    usb_hub_port_set(port, PORT_STAT_POWER);
+                    timer_mod(s->port_timer, now + 5000000); /* 5 ms */
+                }
                 break;
             default:
                 goto fail;
@@ -445,6 +467,14 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
             case PORT_C_RESET:
                 port->wPortChange &= ~PORT_STAT_C_RESET;
                 break;
+            case PORT_POWER:
+                if (s->port_power) {
+                    usb_hub_port_clear(port, PORT_STAT_POWER);
+                    usb_hub_port_clear(port, PORT_STAT_CONNECTION);
+                    usb_hub_port_clear(port, PORT_STAT_ENABLE);
+                    usb_hub_port_clear(port, PORT_STAT_SUSPEND);
+                    port->wPortChange = 0;
+                }
             default:
                 goto fail;
             }
@@ -457,6 +487,11 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
                    sizeof(qemu_hub_hub_descriptor));
             data[2] = s->num_ports;
 
+            if (s->port_power) {
+                data[3] &= ~0x03;
+                data[3] |= 0x01;
+            }
+
             /* fill DeviceRemovable bits */
             limit = DIV_ROUND_UP(s->num_ports + 1, 8) + 7;
             for (n = 7; n < limit; n++) {
@@ -536,6 +571,9 @@ static void usb_hub_unrealize(USBDevice *dev, Error **errp)
         usb_unregister_port(usb_bus_from_device(dev),
                             &s->ports[i].port);
     }
+
+    timer_del(s->port_timer);
+    timer_free(s->port_timer);
 }
 
 static USBPortOps usb_hub_port_ops = {
@@ -565,6 +603,8 @@ static void usb_hub_realize(USBDevice *dev, Error **errp)
 
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
+    s->port_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                 usb_hub_port_update_timer, s);
     s->intr = usb_ep_get(dev, USB_TOKEN_IN, 1);
     for (i = 0; i < s->num_ports; i++) {
         port = &s->ports[i];
@@ -587,6 +627,24 @@ static const VMStateDescription vmstate_usb_hub_port = {
     }
 };
 
+static bool usb_hub_port_timer_needed(void *opaque)
+{
+    USBHubState *s = opaque;
+
+    return s->port_power;
+}
+
+static const VMStateDescription vmstate_usb_hub_port_timer = {
+    .name = "usb-hub/port-timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = usb_hub_port_timer_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_TIMER_PTR(port_timer, USBHubState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_usb_hub = {
     .name = "usb-hub",
     .version_id = 1,
@@ -596,11 +654,16 @@ static const VMStateDescription vmstate_usb_hub = {
         VMSTATE_STRUCT_ARRAY(ports, USBHubState, MAX_PORTS, 0,
                              vmstate_usb_hub_port, USBHubPort),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_usb_hub_port_timer,
+        NULL
     }
 };
 
 static Property usb_hub_properties[] = {
     DEFINE_PROP_UINT32("ports", USBHubState, num_ports, 8),
+    DEFINE_PROP_BOOL("port-power", USBHubState, port_power, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.18.1


