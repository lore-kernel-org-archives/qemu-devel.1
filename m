Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30E0C04AB2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF8D216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktIn2HqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF8D216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46607 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8cC-0003mJ-Sd
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:43:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hP8PN-0001WU-3x
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hP8PG-0003uH-KQ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:30:00 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:36522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hP8PG-0003sq-EI
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:29:58 -0400
Received: by mail-qt1-x844.google.com with SMTP id a17so6027208qth.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=U6QV41w4C/OX4ODHx6H00NnrOOwJDGnMfm7tyshfa30=;
	b=ktIn2HqQG/J2ls+fRuWRGGxdIeZmOFLcoeSRIv/7jpEYUKmiuFUHbrvJ9zZy+oHuTn
	OyNnL5yNe5tFwjU9cu3AxMqNzvp6oKHfb9eb99GNjNt40ksg59AsxXIQAbT5Pcnzk3WG
	ulHEJZF6hIIqfNEldSkkX3eDh8nrh7z0AIn6bWyFpjia7xKEbQQafmyt++sh/27G/+Ne
	KUO3Qy6uSC8G5c5z7U/+7h3zxoF/qDSm1pMTBEFzYDoRw/PsuFlszaSMPqvLeNjtx5ry
	fd7gJNX4I3EN36cp2ex2ecB7CV3WyCxrAv8J40boYwbxEPkZ6/7SrFzuYa/OPdBES1C7
	VoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=U6QV41w4C/OX4ODHx6H00NnrOOwJDGnMfm7tyshfa30=;
	b=DSyPJ7tEpeEgzlhuHde8OQWgNjvpefwiuCll7bttv1L7vN/Njpp0Tks4oPvMAAi6kl
	aEwkt1ysZj1B/7BBG8XO2mYh/TbjVoN2eXJM0FeTui487Z6eSbp7MKc32WGT7OO3ZRvK
	n8dDDFQYVIo0jgrAe10EQmccL/GkkNi7kdwIRKTo5HvFKCsXn/jlPwq3X1gfWfyBDUJ8
	4pgvksszJqTTAmxJmYQyknHw5fDSIA7F/ces/IxL5bz8r/ACWyIFuA5wNKpaNu247/jM
	FwUFbLZcPJG/R1V3fwEb3q43ZrjpCLsXzMhOWDEcSF8E5MMNfX+y6I1NF4zlla8lJ/20
	BrDA==
X-Gm-Message-State: APjAAAWaY9nQ1W9baOicha9d8+QgY16K2mnWM9L0oycKH1X0qf10zCLV
	0r4SVr1HVPmEy6HutIraZO5hWQv6Vqwe/0BXx9nxyLan
X-Google-Smtp-Source: APXvYqxsk0c8S9VP4buWCcH3Itj/Flq8nM3YL2IeB7dgzYwyCIl/gwUvdH5I1bxoMlK2YDMN0QvtLx2UMq6jKUzCkDk=
X-Received: by 2002:a0c:ba99:: with SMTP id x25mr10132385qvf.212.1557505795045;
	Fri, 10 May 2019 09:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrndpONH_fVHbktHbBXvXPKESeRfis06TjrNRRfBpJzXLA@mail.gmail.com>
	<b6064b77-5ca4-03e1-80ef-027313096cb2@gmail.com>
	<CABSdmrkW6G23ZGDA7iLucM45vL0HHGsr2F76H0Mf8S0xkhPnsQ@mail.gmail.com>
	<3e619b5c-8fb3-2655-2d92-37598db098d8@gmail.com>
	<20190510085947.y62lttdtrg5cxx6b@sirius.home.kraxel.org>
	<3fb8b79d-9f68-2342-d3ae-3aefa873109b@gmail.com>
	<20190510103900.botgnbbo2ii4jxgo@sirius.home.kraxel.org>
	<01de4824-5c19-6b6c-5b75-fa54a883ab4a@gmail.com>
	<CABSdmrnVzi5ZTF58tnt8T8=gsVe2ZNqtZKCBcbZQ9Lb+CCCkdg@mail.gmail.com>
In-Reply-To: <CABSdmrnVzi5ZTF58tnt8T8=gsVe2ZNqtZKCBcbZQ9Lb+CCCkdg@mail.gmail.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Sat, 11 May 2019 00:29:34 +0800
Message-ID: <CABSdmrkhuePsnumOj+0pQOC7Ku5hmrs5AKH5YoLqonV-E_UmOQ@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::844
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH v2 3/3] hw/display/ramfb: initialize fw-config
 space with xres / yres
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

If xres / yres were specified in QEMU command line, write them as an initial
resolution to the fw-config space on guest reset, which a later BIOS / OVMF
patch can take advantage of.

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
---
 hw/display/ramfb-standalone.c | 12 +++++++++++-
 hw/display/ramfb.c            | 16 +++++++++++++++-
 hw/vfio/display.c             |  4 ++--
 include/hw/display/ramfb.h    |  2 +-
 stubs/ramfb.c                 |  2 +-
 5 files changed, 30 insertions(+), 6 deletions(-)

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
index d255ddc..9179d17 100644
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
@@ -116,9 +118,11 @@ static void ramfb_reset(void *opaque)
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
@@ -130,6 +134,16 @@ RAMFBState *ramfb_setup(Error **errp)

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
