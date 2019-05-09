Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A9CC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C04721019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsZAofiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C04721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49941 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOdyi-0001YZ-Nq
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:00:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOdx6-0000d8-2z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOdx4-0003ed-82
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:58:52 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hOdx3-0003eJ-Vs
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:58:50 -0400
Received: by mail-qt1-x842.google.com with SMTP id t1so1421404qtc.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=GWS5GLOqKieqwDax26YsaNBkCaykmO887t79OMrbris=;
	b=dsZAofiS+AwAtBkyGlNIgMjVaNb4BZ7mwxKv8pmUiDMHyJGtwC+oobjrwWWisl5u08
	xaKxKvw2pk7oCEzpyun9Y/mgP4kWXoMY57hJ81juOeBU8JnqKjuBkFxDiPYViuWlY+9t
	VzS//kRFxgrnE2H0UsxW9DESIB4yY4K9Bjlhjx/v14dhRUdUqEgFNDkzvSddt94e3g1o
	INAw+8XuRvJEBgE12Md7jxffXxJVAYj0Gc0K9sYZuYDMYyB5DEFppF0mFE8REF2dS5hU
	02tULoZzg7hK5DR9eVXjc4U4Hz7sBF56AggxKQKIu50myZsUx5OEpVcMfK2438v8Riw2
	54Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=GWS5GLOqKieqwDax26YsaNBkCaykmO887t79OMrbris=;
	b=K2GBVkUgY+dtvTmha9bLt4s5GBwVXfsKOD2i6BTqpKGjRwKMLPCoi49Xrjr3IG1f1r
	vx23WCEd35bpfkQnZxYoNNeQgx3MLLlSLleU1gTNaroUdglyc7rWh2fnNhnSO4Oq/lfE
	Htkf5qmpk0i1z0OFuZdc+V7DT/iVXQ+Hf0uvCJJctW7KzcSO4Kq1Ky64KzwtJ05mh++g
	D3edrOx1Gy0oZkYYxCp9WEZyG6FLltepaKdWtwM+ZPbnWZ3NeI4gjW0+tX84ep22OytH
	aivmCeoKg3WEbX/KLWC+IknQqY1lrNMB6PHmdLhZkmZQHIknyzdv9sUHv3wN1/oLltdz
	cQSg==
X-Gm-Message-State: APjAAAWXSyOD5lublMWm2Jo/w9V5Q7DJHk9puJmBaPrE7oDZtA7T9Pqm
	/JB6LC1CyubyLIX+7kFgO7qyAxwSykXKl02cqFEeIQ==
X-Google-Smtp-Source: APXvYqxeX7YS+lHIXo1ooDtMv6Fhv1gAPztUKFCeG2lEPBw/BOPVF9Lf8sC6m09u7Jr7qH5q2E6MY/0WmyeVHEO0oCA=
X-Received: by 2002:a0c:ba99:: with SMTP id x25mr2350878qvf.212.1557388729319; 
	Thu, 09 May 2019 00:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
In-Reply-To: <CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Thu, 9 May 2019 15:58:37 +0800
Message-ID: <CABSdmrndpONH_fVHbktHbBXvXPKESeRfis06TjrNRRfBpJzXLA@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH 3/3] ramfb enhancement
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

Write an initial resolution to the configuration space on guest reset,
which a later BIOS / OVMF patch can take advantage of.

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
---
 hw/display/ramfb-standalone.c | 12 +++++++++++-
 hw/display/ramfb.c            | 16 +++++++++++++++-
 hw/vfio/display.c             |  4 ++--
 hw/vfio/pci.c                 |  6 ++++--
 include/hw/display/ramfb.h    |  2 +-
 stubs/ramfb.c                 |  2 +-
 6 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index da3229a..6441449 100644
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
@@ -33,15 +36,22 @@ static void ramfb_realizefn(DeviceState *dev, Error
**errp)
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
index fa6296b..0033ac8 100644
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
     hwaddr addr, length;
     struct RAMFBCfg cfg;
     bool locked;
@@ -120,9 +122,11 @@ static void ramfb_reset(void *opaque)
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
@@ -134,6 +138,16 @@ RAMFBState *ramfb_setup(Error **errp)

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
index a3d9c8f..2c2d3e5 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -352,7 +352,7 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice
*vdev, Error **errp)
                                           &vfio_display_dmabuf_ops,
                                           vdev);
     if (vdev->enable_ramfb) {
-        vdev->dpy->ramfb = ramfb_setup(errp);
+        vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
     }
     vfio_display_edid_init(vdev);
     return 0;
@@ -478,7 +478,7 @@ static int vfio_display_region_init(VFIOPCIDevice
*vdev, Error **errp)
                                           &vfio_display_region_ops,
                                           vdev);
     if (vdev->enable_ramfb) {
-        vdev->dpy->ramfb = ramfb_setup(errp);
+        vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
     }
     return 0;
 }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8cecb53..5d64daa 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3080,8 +3080,10 @@ static void vfio_realize(PCIDevice *pdev, Error
**errp)
             error_setg(errp, "xres and yres properties require
display=on");
             goto out_teardown;
         }
-        if (vdev->dpy->edid_regs == NULL) {
-            error_setg(errp, "xres and yres properties need edid support");
+        if (vdev->dpy->edid_regs == NULL && !vdev->enable_ramfb) {
+            error_setg(errp,
+                       "xres and yres properties need edid support"
+                       " or ramfb=on");
             goto out_teardown;
         }
     }
diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
index b33a2c4..f6c2de9 100644
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
diff --git a/stubs/ramfb.c b/stubs/ramfb.c
index 48143f3..0799093 100644
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
2.17.1
