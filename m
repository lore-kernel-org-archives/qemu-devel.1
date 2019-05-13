Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20238C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDBE208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+bdhhH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDBE208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55774 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9fD-0007UW-4t
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 08:02:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hQ9aQ-0003Yn-FX
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hQ9aP-0001So-98
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hQ9aP-0001SF-2P
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id b18so4953261wrq.12
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Cb6ypY+QVCjZPXzcsPv+3xj/2MSR1UVyWcvLGS9tb9s=;
	b=b+bdhhH1pgI1LdW9aezyT+xGnySlMx4o8eETBpGD/dN4TlvjOHgBmerRYPp+QV+kUN
	ekwslQArVwfQjkmFDXGpFDGvI1Qt3+p2U8OZuDMN6JlAn0AW8t46nVEnH+R1fPwhodRm
	07ESRsTbVBPpb1vPKdGatVvTcu3w8xedcY5GFG4mawaiidErQ+DnxCQlW1weacF6K2wo
	t6XHg0dXEb1e99XvkjkKLioUvBdI9GCeEKJWakUxps3TVMVRF/wafg61whLr5FQ5Tfst
	RhR63q7IyUuU1uwmqAVqBpu5pg0I0gy5d0fnCf459tu5BSxLEki+WnMpAb5zsTEg0fdc
	E1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Cb6ypY+QVCjZPXzcsPv+3xj/2MSR1UVyWcvLGS9tb9s=;
	b=uTVxnHtTF8pUiU0okJmpVU6Cx9T/SuyoiEBqCQjegMAbcvV/NRfXdPMTx4gGAG1Lmj
	dDnSg2MoSJjfbGRy2HA/Md5mgw8Nt/+afdKTYrIsvu9soE3o9/7GINptoE/tyhJn2yC1
	GxiB7pa8nqen3OnfKmADrThyJHexywDM49Bzmt2asCOS0gUg7Fl8lmzcXl5VST9QGwJ0
	HBewCwg2QDJuGyTPXz0D17FzexOGLkbyr3o3i3QemL9RfFoNcrrx+Rwk3ui1HEn7YpVh
	rLlhLunze3NJBNLPvzqTph9HDnxhZD77kLt53RtAMINiIfCpuysy57Zub0XyQcc3e2Sn
	8mSA==
X-Gm-Message-State: APjAAAVTUI3GfGmzd6dQhIyQb2jXvfJQnkwuWJ64plyqIgRW7KLuuGI2
	uoXV+n954nFPdq6vANclK62H+3DE
X-Google-Smtp-Source: APXvYqy/jP/gflelwq2PBs5IonjeRzkA6p0agrevW21QoogKb1FfJyoOY18MGQg/9QrZbiUY5rTk6g==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr17843450wrv.52.1557748659876; 
	Mon, 13 May 2019 04:57:39 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id z5sm5238554wmi.34.2019.05.13.04.57.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 May 2019 04:57:39 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:57:31 +0300
Message-Id: <20190513115731.17588-4-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513115731.17588-1-marcel.apfelbaum@gmail.com>
References: <20190513115731.17588-1-marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH V3 3/3] hw/display/ramfb: initialize fw-config
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
Cc: alex.williamson@redhat.com, kraxel@redhat.com, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Qiming <hqm03ster@gmail.com>

If xres / yres were specified in QEMU command line, write them as an initial
resolution to the fw-config space on guest reset, which a later BIOS / OVMF
patch can take advantage of.

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
[fixed malformed patch]
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/display/ramfb-standalone.c | 12 +++++++++++-
 hw/display/ramfb.c            | 16 +++++++++++++++-
 hw/vfio/display.c             |  4 ++--
 include/hw/display/ramfb.h    |  2 +-
 stubs/ramfb.c                 |  2 +-
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index da3229a1f6..6441449e7b 100644
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
index 0fe79aa856..b4eb283ef8 100644
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
index a3d9c8f5be..2c2d3e5b71 100644
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
diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
index b33a2c467b..f6c2de93b2 100644
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
index 48143f3354..0799093a5d 100644
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


