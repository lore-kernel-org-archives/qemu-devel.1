Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1F3C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 23:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729CE2075E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 23:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729CE2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUfpK-00029W-M8
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 19:11:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUfl7-0006Ih-H3
	for qemu-devel@nongnu.org; Sat, 25 May 2019 19:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUfVG-0002fS-1w
	for qemu-devel@nongnu.org; Sat, 25 May 2019 18:51:05 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59261)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hUfVD-0002SJ-Jr; Sat, 25 May 2019 18:51:00 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MZk5x-1hA1R128xT-00WjpI; Sun, 26 May 2019 00:50:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 00:50:11 +0200
Message-Id: <20190525225013.13916-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525225013.13916-1-laurent@vivier.eu>
References: <20190525225013.13916-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aVplGuzw0YN9cUOzdqeCZjWbVxXH1A3B2xPEQ5UO32cbHrOktPv
	6azmhHCLFI0Apbej11hsBupx0z6OHt+pUayF2RQb+mRocoeRmif8Q/K5lXpbVcHCF7Jx8lo
	qzJq1zeyjmGS5M5EbHkAtPW0EZ5TaWEBXBy4yeBTFXZaIY0iRPcbqDu4dCRn10/rDh5E7lT
	ENO5vCkQ+ggK05A7w2dTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:re9EMkvHFZE=:EOllFh1OFqT69KdYd73w2l
	HQn9bQ67lPeZGWch6a7aM92cmX1iw6nMsYt60ycjUiujijobD3jU2V1oYdb1gfhipkuVAtx6H
	rcH718JusG6hUNqu/L3eIckXdWq+OiTZXzbtzspnjI9i3nsi8lIqUCml0wiZo4zYG/BtaDCmV
	3JXm22kyQ2XHgiaRxu4fT0ueOC4xRSkirBYKyMuyPqfJAXoETfjaOt91t2nmeL8q2D7Y4iGj8
	S/hQ4/H/c+UA2WxLL6xDxHejGyT68sU0s77uV2gs94eg+ZHl+bUk54OyD5q03mu18uEPguq5l
	ztrZ7xhEMYYFJ4ktNDqCaD6udBiHReEiXYcYbQYHY19wsDPdEj1EYAUG0CSfvBv129spRU+zc
	xqXcqs8SwEfluY2z/5qOS9SVY04fgR9CZVTxWDF7yAiDgVcAU47pPJuJerjnw+1yPL/x1JXJH
	ruAwSKFrz37THrlU17CuXmWuZPTL/mwiHAw4B9MXy73BZxPEPHOygAq6Kr+qgUfxDSIF2/QA9
	TgF7A7rXZVXAIn2UoZdj8OAJ/9ZnNtefupDAtvvjm0aOah2C/w3o3amNcmmE8YLXgr0JSL1un
	oKFh/susr0eF0LJgi3knW20zxZCpmw+Rl/ybL9zWwOMOtcnhFFhr/8FUsVGMUtuxaGv8qbAlK
	KQK7TM9ctem7no+k14c2fEVIcKIgzD0CQ16Tp97rJ8l++7Ypt+636jKzVzxvBFWi1n0BT4/Av
	IUal50fijdEQnycFR2jReV9uMlml0PTyTefDAKJPhgbr71PhS6gN5S/7OUs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PATCH v7 08/10] hw/m68k: add Nubus support for macfb
 video card
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
	Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/display/Kconfig         |  1 +
 hw/display/macfb.c         | 56 ++++++++++++++++++++++++++++++++++++++
 include/hw/display/macfb.h | 21 ++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 48284269e0..f962cd8a04 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -123,3 +123,4 @@ config ATI_VGA
 
 config MACFB
     bool
+    depends on NUBUS
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 61ba2e9e15..458e268d86 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -15,6 +15,7 @@
 #include "hw/sysbus.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
+#include "hw/nubus/nubus.h"
 #include "hw/display/macfb.h"
 #include "qapi/error.h"
 
@@ -380,12 +381,38 @@ static void macfb_sysbus_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &ms->mem_vram);
 }
 
+const uint8_t macfb_rom[] = {
+    255, 0, 0, 0,
+};
+
+static void macfb_nubus_realize(DeviceState *dev, Error **errp)
+{
+    NubusDevice *nd = NUBUS_DEVICE(dev);
+    MacfbNubusState *s = NUBUS_MACFB(dev);
+    MacfbNubusDeviceClass *ndc = MACFB_NUBUS_GET_CLASS(dev);
+    MacfbState *ms = &s->macfb;
+
+    ndc->parent_realize(dev, errp);
+
+    macfb_common_realize(dev, ms, errp);
+    memory_region_add_subregion(&nd->slot_mem, DAFB_BASE, &ms->mem_ctrl);
+    memory_region_add_subregion(&nd->slot_mem, VIDEO_BASE, &ms->mem_vram);
+
+    nubus_register_rom(nd, macfb_rom, sizeof(macfb_rom), 1, 9, 0xf);
+}
+
 static void macfb_sysbus_reset(DeviceState *d)
 {
     MacfbSysBusState *s = MACFB(d);
     macfb_reset(&s->macfb);
 }
 
+static void macfb_nubus_reset(DeviceState *d)
+{
+    MacfbNubusState *s = NUBUS_MACFB(d);
+    macfb_reset(&s->macfb);
+}
+
 static Property macfb_sysbus_properties[] = {
     DEFINE_PROP_UINT32("width", MacfbSysBusState, macfb.width, 640),
     DEFINE_PROP_UINT32("height", MacfbSysBusState, macfb.height, 480),
@@ -393,6 +420,13 @@ static Property macfb_sysbus_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static Property macfb_nubus_properties[] = {
+    DEFINE_PROP_UINT32("width", MacfbNubusState, macfb.width, 640),
+    DEFINE_PROP_UINT32("height", MacfbNubusState, macfb.height, 480),
+    DEFINE_PROP_UINT8("depth", MacfbNubusState, macfb.depth, 8),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -404,6 +438,19 @@ static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
     dc->props = macfb_sysbus_properties;
 }
 
+static void macfb_nubus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    MacfbNubusDeviceClass *ndc = MACFB_NUBUS_DEVICE_CLASS(klass);
+
+    device_class_set_parent_realize(dc, macfb_nubus_realize,
+                                    &ndc->parent_realize);
+    dc->desc = "Nubus Macintosh framebuffer";
+    dc->reset = macfb_nubus_reset;
+    dc->vmsd = &vmstate_macfb;
+    dc->props = macfb_nubus_properties;
+}
+
 static TypeInfo macfb_sysbus_info = {
     .name          = TYPE_MACFB,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -411,9 +458,18 @@ static TypeInfo macfb_sysbus_info = {
     .class_init    = macfb_sysbus_class_init,
 };
 
+static TypeInfo macfb_nubus_info = {
+    .name          = TYPE_NUBUS_MACFB,
+    .parent        = TYPE_NUBUS_DEVICE,
+    .instance_size = sizeof(MacfbNubusState),
+    .class_init    = macfb_nubus_class_init,
+    .class_size    = sizeof(MacfbNubusDeviceClass),
+};
+
 static void macfb_register_types(void)
 {
     type_register_static(&macfb_sysbus_info);
+    type_register_static(&macfb_nubus_info);
 }
 
 type_init(macfb_register_types)
diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
index 3fe2592735..26367ae2c4 100644
--- a/include/hw/display/macfb.h
+++ b/include/hw/display/macfb.h
@@ -40,4 +40,25 @@ typedef struct {
     MacfbState macfb;
 } MacfbSysBusState;
 
+#define MACFB_NUBUS_DEVICE_CLASS(class) \
+    OBJECT_CLASS_CHECK(MacfbNubusDeviceClass, (class), TYPE_NUBUS_MACFB)
+#define MACFB_NUBUS_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(MacfbNubusDeviceClass, (obj), TYPE_NUBUS_MACFB)
+
+typedef struct MacfbNubusDeviceClass {
+    DeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+} MacfbNubusDeviceClass;
+
+#define TYPE_NUBUS_MACFB "nubus-macfb"
+#define NUBUS_MACFB(obj) \
+    OBJECT_CHECK(MacfbNubusState, (obj), TYPE_NUBUS_MACFB)
+
+typedef struct {
+    NubusDevice busdev;
+
+    MacfbState macfb;
+} MacfbNubusState;
+
 #endif
-- 
2.20.1


