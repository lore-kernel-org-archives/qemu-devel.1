Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B01C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF56E2084D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF56E2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7M78-0001sP-Tg
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7M4C-0008Oy-3D
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7M4A-0001dL-4J
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:58:59 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i7M48-0001bF-59; Mon, 09 Sep 2019 11:58:58 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mq2za-1iSt262DMw-00nBc7; Mon, 09 Sep 2019 17:58:36 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 17:58:11 +0200
Message-Id: <20190909155813.27760-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909155813.27760-1-laurent@vivier.eu>
References: <20190909155813.27760-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dXX0A0pG8ITV2Z8PgvJaD6rrHOLQTZFzX0lXW661YBR/M2UsIrp
 d/VT6AB1cWQs2rTHaMxZfnDmNhFKBr/a7clAijmW/ka88Ka42qOTnYZHqhHkvn0+FZknNuN
 xkRhh9360kuRbMGHTee6TVFsr5zP6lkIVHNHUpt59FUDzSiGn81CPTfeftqCj+iUeZJ5ho5
 ozDTOJP3Hx72fF6TsE3sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hbJ2So1mPC4=:46RetFbv06BZKzUkF6G3Rq
 UfbKbd8PpEq3Ep2q2+iVh0fQrQdAbZZewIeDe/cEtsQ4Jvxl93rnJlNWtmvWQxZxmBWzLacQM
 rjPcND93Kn2sIt12iw7MpkY0jA56KU7gVaTYyNvJ1nlyJCyQ+9+kSOsEDBIXKBF6afp/am+Rk
 bQC2uJetvlce/NziAVI4z+DqVkxGC6uKTMu1AJBprb70aJQuBfl7EvXFYtBUXgMI6rvd/LIjY
 gmXAevZ48AW0oD7m7+cu9BTKAegvITaHk93I9abKNeYqVFZWfIDj5TyalCHfhMDQPIJe0qBIh
 pQ1lMQWzOJwgmka2OU2BSjRRqbZ8RDLguByjRgmNBMYGK6X7/ZENoUc7XTqB7SnWpl4hV5vIP
 tqIPgA4W3zmbnp4RTy2dkM711Nb+FfDt3s+e7oZfMPOI/aQ8c3sWvDBNdyL8stuIKEuCIsLAb
 JCl8lQNdfLrjZUVSf3yCIPWPnkfubYnttfMJMctPeIcVXeveuV4OYljOrkb9k6j13b6lGZ5cR
 D+dLnDWOMXrkQUzEj6Jr6TBomIZEBN26QTL5giWwd5i6M7Cc/d1XZz1ZzoW9J9OpKWGcE69ZY
 PeP8uiLqoViNG4E9CF6ZS+JLNdNyyXMRjzqPvj+HXvw4JQCj70NsIBIC/jrpf1KiklFexMvW5
 tWRNORBsRDHPuYA0PmMXLKji/yYA6dH1w68DTRWjMQR5HOZHjVSE8X4Eb/xOowQkHuI7GgsBG
 UTEnRTkjYei7Itn9EgIDr22VT2QXLWyACSd8rK0vurRPA7SspHRwt6Bc0xICYvbSTLWyeqbTc
 yMlC6/Py1KvIBX9EH5oSYiJHEcQHEhHl2P12SuFKEM+il/RTTE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PATCH v9 7/9] hw/m68k: add Nubus support for macfb
 video card
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
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
index 867b47673c..02163048cd 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -135,3 +135,4 @@ config ATI_VGA
 
 config MACFB
     bool
+    depends on NUBUS
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index d7c5ef296e..f4fa8e3206 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -15,6 +15,7 @@
 #include "hw/sysbus.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
+#include "hw/nubus/nubus.h"
 #include "hw/display/macfb.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
@@ -382,12 +383,38 @@ static void macfb_sysbus_realize(DeviceState *dev, Error **errp)
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
@@ -395,6 +422,13 @@ static Property macfb_sysbus_properties[] = {
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
@@ -406,6 +440,19 @@ static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
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
@@ -413,9 +460,18 @@ static TypeInfo macfb_sysbus_info = {
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
2.21.0


