Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD334C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46D12175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46D12175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU64w-0004uj-VJ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:01:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hU631-0003f6-Gj
	for qemu-devel@nongnu.org; Fri, 24 May 2019 04:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hU60y-00007i-6k
	for qemu-devel@nongnu.org; Fri, 24 May 2019 04:57:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hU60x-00007K-VN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 04:57:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DA823086239;
	Fri, 24 May 2019 08:57:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-101.ams2.redhat.com
	[10.36.116.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 843AB19728;
	Fri, 24 May 2019 08:57:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 8B33B1753A; Fri, 24 May 2019 10:57:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 10:57:17 +0200
Message-Id: <20190524085717.3493-4-kraxel@redhat.com>
In-Reply-To: <20190524085717.3493-1-kraxel@redhat.com>
References: <20190524085717.3493-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 24 May 2019 08:57:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/3] hw/display/ramfb: initialize fw-config
 space with xres/ yres
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Hou Qiming <hqm03ster@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Qiming <hqm03ster@gmail.com>

If xres / yres were specified in QEMU command line, write them as an initial
resolution to the fw-config space on guest reset, which a later BIOS / OVMF
patch can take advantage of.

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-id: 20190513115731.17588-4-marcel.apfelbaum@gmail.com
[fixed malformed patch]
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/display/ramfb.h    |  2 +-
 hw/display/ramfb-standalone.c | 12 +++++++++++-
 hw/display/ramfb.c            | 16 +++++++++++++++-
 hw/vfio/display.c             |  4 ++--
 stubs/ramfb.c                 |  2 +-
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
index b33a2c467b28..f6c2de93b222 100644
--- a/include/hw/display/ramfb.h
+++ b/include/hw/display/ramfb.h
@@ -4,7 +4,7 @@
 /* ramfb.c */
 typedef struct RAMFBState RAMFBState;
 void ramfb_display_update(QemuConsole *con, RAMFBState *s);
-RAMFBState *ramfb_setup(Error **errp);
+RAMFBState *ramfb_setup(DeviceState *dev, Error **errp);
 
 /* ramfb-standalone.c */
 #define TYPE_RAMFB_DEVICE "ramfb"
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index da3229a1f6cb..6441449e7bc1 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/loader.h"
+#include "hw/isa/isa.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
 #include "sysemu/sysemu.h"
@@ -11,6 +12,8 @@ typedef struct RAMFBStandaloneState {
     SysBusDevice parent_obj;
     QemuConsole *con;
     RAMFBState *state;
+    uint32_t xres;
+    uint32_t yres;
 } RAMFBStandaloneState;
 
 static void display_update_wrapper(void *dev)
@@ -33,15 +36,22 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
     RAMFBStandaloneState *ramfb = RAMFB(dev);
 
     ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
-    ramfb->state = ramfb_setup(errp);
+    ramfb->state = ramfb_setup(dev, errp);
 }
 
+static Property ramfb_properties[] = {
+    DEFINE_PROP_UINT32("xres", RAMFBStandaloneState, xres, 0),
+    DEFINE_PROP_UINT32("yres", RAMFBStandaloneState, yres, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void ramfb_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->realize = ramfb_realizefn;
+    dc->props = ramfb_properties;
     dc->desc = "ram framebuffer standalone device";
     dc->user_creatable = true;
 }
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 0fe79aa8565f..b4eb283ef8cf 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -12,6 +12,7 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/option.h"
 #include "hw/loader.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
@@ -29,6 +30,7 @@ struct QEMU_PACKED RAMFBCfg {
 struct RAMFBState {
     DisplaySurface *ds;
     uint32_t width, height;
+    uint32_t starting_width, starting_height;
     struct RAMFBCfg cfg;
     bool locked;
 };
@@ -114,9 +116,11 @@ static void ramfb_reset(void *opaque)
     RAMFBState *s = (RAMFBState *)opaque;
     s->locked = false;
     memset(&s->cfg, 0, sizeof(s->cfg));
+    s->cfg.width = s->starting_width;
+    s->cfg.height = s->starting_height;
 }
 
-RAMFBState *ramfb_setup(Error **errp)
+RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
 {
     FWCfgState *fw_cfg = fw_cfg_find();
     RAMFBState *s;
@@ -128,6 +132,16 @@ RAMFBState *ramfb_setup(Error **errp)
 
     s = g_new0(RAMFBState, 1);
 
+    const char *s_fb_width = qemu_opt_get(dev->opts, "xres");
+    const char *s_fb_height = qemu_opt_get(dev->opts, "yres");
+    if (s_fb_width) {
+        s->cfg.width = atoi(s_fb_width);
+        s->starting_width = s->cfg.width;
+    }
+    if (s_fb_height) {
+        s->cfg.height = atoi(s_fb_height);
+        s->starting_height = s->cfg.height;
+    }
     s->locked = false;
 
     rom_add_vga("vgabios-ramfb.bin");
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index a3d9c8f5beac..2c2d3e5b71d6 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -352,7 +352,7 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
                                           &vfio_display_dmabuf_ops,
                                           vdev);
     if (vdev->enable_ramfb) {
-        vdev->dpy->ramfb = ramfb_setup(errp);
+        vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
     }
     vfio_display_edid_init(vdev);
     return 0;
@@ -478,7 +478,7 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
                                           &vfio_display_region_ops,
                                           vdev);
     if (vdev->enable_ramfb) {
-        vdev->dpy->ramfb = ramfb_setup(errp);
+        vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
     }
     return 0;
 }
diff --git a/stubs/ramfb.c b/stubs/ramfb.c
index 48143f33542f..0799093a5d6e 100644
--- a/stubs/ramfb.c
+++ b/stubs/ramfb.c
@@ -6,7 +6,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
 {
 }
 
-RAMFBState *ramfb_setup(Error **errp)
+RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
 {
     error_setg(errp, "ramfb support not available");
     return NULL;
-- 
2.18.1


