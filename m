Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96058C04A6B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 00:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CACF214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 00:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tw4XYoHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CACF214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45473 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOWkE-0002xL-3o
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 20:17:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOWjJ-0002eY-6A
	for qemu-devel@nongnu.org; Wed, 08 May 2019 20:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOWjG-0001kw-MB
	for qemu-devel@nongnu.org; Wed, 08 May 2019 20:16:09 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hOWjG-0001kC-Ee
	for qemu-devel@nongnu.org; Wed, 08 May 2019 20:16:06 -0400
Received: by mail-qk1-x741.google.com with SMTP id c1so430212qkk.4
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JzoqpO9MLDdp0DJGgTsCMnF2KGJktUQDl4iixfJ2GgM=;
	b=tw4XYoHz1yGs11K/RIKoZgkrU5m8rb+qcpfmsk+DIdRntaKVkYAbXlbRtNmD1Aa9gA
	wiwuVpRoxrP5KPg/5b2jOw/FGKWDMVg1dqZt49bI63xHkAg1KcOCOlBZAV5yDgRd5Rvj
	iXqg4hvNThQQ1WA8SSRfMViRJZbvbpr+cPBvOSgFZ4OEU8EMSnCoaDyGGNtfgKmYw2c2
	EkPR5pnppYKLIhMUyUhB0oDQKqz92qq70M+YsFxXBuicQbfLkLX6dDOAPfvIUTnBiVsu
	XiAGwkknZsgY5LGFz9OCBnW2gV87x/wqoFH0QLadvKqYGAgthT56m4hgYVRAr3sMjx9z
	xM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JzoqpO9MLDdp0DJGgTsCMnF2KGJktUQDl4iixfJ2GgM=;
	b=PHiTCu6SAr6PRZiK8O2AAFfn0TDDEuYjwM2tGGwvPYbOHmia/yQEi+ofVCwdSOXN4G
	zZuJQ33hQLYdKtCJUxqf5Z5wF4JxOBIufNdGLd5YqI7Rtr1fVQ/qQFcJdV0zMyIXprTF
	RCmqQ0pOeW6iKBcdUVVjcS1vvCw7jSPW3vBdTDZgB3408te0RGqTequxF1jLKwFC7kED
	ODhW0xzf6n6ptB3bXGWqhTlppMNnAiv1zJ8Ib2Cz4HReC9LWNHESO0Emkr1UT9fxTonv
	g7m4OlikDtn0iQeMKI0wgeq4G7iRva/dtTDzMj2o8zwzv/s/9HN67yKVeBCbP4rCcnXn
	pOLA==
X-Gm-Message-State: APjAAAVh0l4G7o8PFqawPkJKeWghn3ai4M6wzJkZAp2vmNRICnFGdyKz
	6lJZsZdIHgSbuTdteqDbdwjZYJC5QAJyFGlikSw3eqP/
X-Google-Smtp-Source: APXvYqzlimfLBW+8TvKzF4vGGZsWhHAlm2HVYChhCg0F2NRbSVpTtjAp7etoXkZNOOteDIOKNmRwYZfrjH4VyRI2Dr0=
X-Received: by 2002:a37:2d81:: with SMTP id t123mr691530qkh.316.1557360963625; 
	Wed, 08 May 2019 17:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
In-Reply-To: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Thu, 9 May 2019 08:15:44 +0800
Message-ID: <CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::741
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH] Multiple ramfb enhancements
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

Pulled back the `qemu_create_displaysurface_guestmem` function to create
the display surface so that the guest memory gets properly unmaped.

Only allow one resolution change per guest boot, which prevents a
crash when the guest writes garbage to the configuration space (e.g.
when rebooting).

Write an initial resolution to the configuration space on guest reset,
which a later BIOS / OVMF patch can take advantage of.

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
---
 hw/display/ramfb-standalone.c | 12 ++++-
 hw/display/ramfb.c            | 91 +++++++++++++++++++++++++++++------
 hw/vfio/display.c             |  4 +-
 hw/vfio/pci.c                 |  6 ++-
 include/hw/display/ramfb.h    |  2 +-
 stubs/ramfb.c                 |  2 +-
 6 files changed, 96 insertions(+), 21 deletions(-)

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
index 25c8ad7..0033ac8 100644
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
@@ -29,18 +30,57 @@ struct QEMU_PACKED RAMFBCfg {
 struct RAMFBState {
     DisplaySurface *ds;
     uint32_t width, height;
+    uint32_t starting_width, starting_height;
+    hwaddr addr, length;
     struct RAMFBCfg cfg;
+    bool locked;
 };

+static void qemu_unmap_displaysurface_guestmem(pixman_image_t *image,
+                                               void *unused)
+{
+    void *data = pixman_image_get_data(image);
+    uint32_t size = pixman_image_get_stride(image) *
+        pixman_image_get_height(image);
+    cpu_physical_memory_unmap(data, size, 0, 0);
+}
+
+static DisplaySurface *qemu_create_displaysurface_guestmem(
+    int width, int height,
+    pixman_format_code_t format,
+    int linesize, uint64_t addr)
+{
+    DisplaySurface *surface;
+    hwaddr size;
+    void *data;
+
+    if (linesize == 0) {
+        linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
+    }
+
+    size = (hwaddr)linesize * height;
+    data = cpu_physical_memory_map(addr, &size, 0);
+    if (size != (hwaddr)linesize * height) {
+        cpu_physical_memory_unmap(data, size, 0, 0);
+        return NULL;
+    }
+
+    surface = qemu_create_displaysurface_from
+        (width, height, format, linesize, data);
+    pixman_image_set_destroy_function
+        (surface->image, qemu_unmap_displaysurface_guestmem, NULL);
+
+    return surface;
+}
+
 static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 {
     RAMFBState *s = dev;
-    void *framebuffer;
-    uint32_t fourcc, format;
+    uint32_t fourcc, format, width, height;
     hwaddr stride, addr, length;

-    s->width  = be32_to_cpu(s->cfg.width);
-    s->height = be32_to_cpu(s->cfg.height);
+    width     = be32_to_cpu(s->cfg.width);
+    height    = be32_to_cpu(s->cfg.height);
     stride    = be32_to_cpu(s->cfg.stride);
     fourcc    = be32_to_cpu(s->cfg.fourcc);
     addr      = be64_to_cpu(s->cfg.addr);
@@ -48,17 +88,18 @@ static void ramfb_fw_cfg_write(void *dev, off_t offset,
size_t len)
     format    = qemu_drm_format_to_pixman(fourcc);

     fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
-            s->width, s->height, addr);
-    framebuffer = address_space_map(&address_space_memory,
-                                    addr, &length, false,
-                                    MEMTXATTRS_UNSPECIFIED);
-    if (!framebuffer || length < stride * s->height) {
-        s->width = 0;
-        s->height = 0;
+            width, height, addr);
+    if (s->locked) {
+        fprintf(stderr, "%s: resolution locked, change rejected\n",
__func__);
         return;
     }
-    s->ds = qemu_create_displaysurface_from(s->width, s->height,
-                                            format, stride, framebuffer);
+    s->locked = true;
+    s->addr = addr;
+    s->length = length;
+    s->width = width;
+    s->height = height;
+    s->ds = qemu_create_displaysurface_guestmem(s->width, s->height,
+                                                format, stride, s->addr);
 }

 void ramfb_display_update(QemuConsole *con, RAMFBState *s)
@@ -76,7 +117,16 @@ void ramfb_display_update(QemuConsole *con, RAMFBState
*s)
     dpy_gfx_update_full(con);
 }

-RAMFBState *ramfb_setup(Error **errp)
+static void ramfb_reset(void *opaque)
+{
+    RAMFBState *s = (RAMFBState *)opaque;
+    s->locked = false;
+    memset(&s->cfg, 0, sizeof(s->cfg));
+    s->cfg.width = s->starting_width;
+    s->cfg.height = s->starting_height;
+}
+
+RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
 {
     FWCfgState *fw_cfg = fw_cfg_find();
     RAMFBState *s;
@@ -88,9 +138,22 @@ RAMFBState *ramfb_setup(Error **errp)

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
+    s->locked = false;
+
     rom_add_vga("vgabios-ramfb.bin");
     fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                              NULL, ramfb_fw_cfg_write, s,
                              &s->cfg, sizeof(s->cfg), false);
+    qemu_register_reset(ramfb_reset, s);
     return s;
 }
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
