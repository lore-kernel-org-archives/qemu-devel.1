Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25499C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 22:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F015E215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 22:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F015E215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdj1z-0006XT-9m
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 18:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36033)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hdiwt-0001hp-2W
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hdiwr-0007oJ-I4
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:20:58 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55057)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hdiwo-0007iW-NU; Wed, 19 Jun 2019 18:20:54 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MdNse-1iCmhc0YGO-00ZLPw; Thu, 20 Jun 2019 00:20:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 00:19:31 +0200
Message-Id: <20190619221933.1981-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619221933.1981-1-laurent@vivier.eu>
References: <20190619221933.1981-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:h0lBnGkz286V7bvmWJ5gZuoalWyxGJLRdgvCJL6C2vsCn/TDHqS
 k0fcJfguog0gImKHUOK0shFyCvOtT4rOxvXqfU0hy1sdk0ZCioGGTFx8jLxxlPhk85ulkZX
 hSgG99cF+3lVI4NdI0dccWxq35LzIljLcBt1KG6lMV6AaBUDkQtj1WNqNNCyQztEi8eZn33
 SYDM4zLnLOAei1AswraDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AMA5apviTAg=:ajeo4knuuyb9O/kg5/WMmg
 2rcl7SPq3HbOcR8tDob7NG5jeGHBJVBRBzChlskLT/EWXNY8P26PdrFDQh3pDU+o86/pvM+UN
 F6qoCe/xtlyj6ADSoFhsjUIk3El1Ni/EY+fqY9nKACx4uSKYHiCsffuN1qjXUcWGbOcFgwUIu
 OirOHuvIuJQuzdVBqTM6B4TD7bEJ5bjtHtI8rkXImDHe+Rr56/F4hxoFoL/Gh8IWPJs3qTEzj
 20ar72m8SQQNCB7ymXJ6w3Ord7nA5FLkO4ltiNr/iPUP/KFIRy7iF34Q5sQzuhtBBjDMdHdKS
 gCn64FEV1M7CliQ28HEFXR6XPzn3+tGkVB64Tz8HBAyHwYSm/3gSKj7SY/HnH1XqbOJ+BfX1R
 72oamyGEP2L3PLS2BcmwI27Y8aT+87FJIfIgcDxVX5fKaeggI8YGiWr3KzO3YZcoJcofGHtjH
 J33m96aULtX4+1aEXsl8OecCfxO9kUh1oPYHVHtQjXRIPN9BgRf9xUzeFuzFO2/5pg06GC2gI
 GPyWX5mzYRduNpffwzMaUh59nhxCm23Fic8xsXNHe5hI7Yc+HjOFrchlv7BvWmtcvH8yxoyf2
 1LJA8rBMW0fZaZFPRFokB/vnQ6OMS5KjwTmuqTtGb44xY7DtMoCXFinhJmodWbiJO/91kiSm5
 rrMNOLEMWpnHvUB6f+oFhEyH3++Et8Xzq7MW4Q4VjcgCrkjexI+wqYUrrhqEMQ/efQP7K9Ye1
 ijF//PiqC6VRtJSDq668pGvz5j807nZtR/MnCdphIjhV+aPOfRw7sYhip2I=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PATCH v8 08/10] hw/m68k: add Nubus support for macfb
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
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
index 035cd85bcf..95096d3c82 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -133,3 +133,4 @@ config ATI_VGA
 
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
2.21.0


