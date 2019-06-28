Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DCCC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F87208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F87208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvmZ-0004Vs-J3
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34466)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hgvQG-0007za-40
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hgvQA-0000H9-GL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:16:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hgvQ6-0008Io-Cx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:16:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so9963502wmj.5
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 11:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u9zhG8rg54XfiTs94v7mHs1mcSSNli/GonRCvA/Rm7M=;
 b=U0s2crETJzgvYEyO5VrBnNIBSxMz0jSGPVFwwJ7jBDA1V19jIUH9LJ84ROurP9fCsP
 9a9L9oV1kMhQHAgrQqZJBZc/qDJTosmzii5C5G/OAW2Ii9YylvwasyVP+QySCZf3ABui
 LPN4TfZKc/WcUpsXVljcsVhYi0g/QTV+OBIjCjOQmhLUCczoxMHv4zRCCtAnv5lO/iLP
 bOX4EyX4ThXkrHGpoP+puJVFpsLHjt6Yg5DqWxDr62H8bGxMHEUq2sdKIaZz/YR4V0T2
 OkJXU3qi/J/Dy+Zf8FnO98rdB2bzwCSWDy6sHbvBNW2SSmYnzAJGiMnyJcDkzTjLSCRU
 T3aA==
X-Gm-Message-State: APjAAAWf3e7HjroeG6uUSjwhEAMO99jb2FTKcjdHAzq4gO5QKOkXzQBS
 aEYY+igUTI1h+4SnFP/jBpepuGsT
X-Google-Smtp-Source: APXvYqwq7dp6EbJJvwNO2IyEWxgZlURhcxY/0AXywyf3NcxlcagouSSXzPp0BZvES8W3H3aGrs+/GQ==
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr7670688wme.56.1561745745275; 
 Fri, 28 Jun 2019 11:15:45 -0700 (PDT)
Received: from thl530.multi.box (p5791D57D.dip0.t-ipconnect.de.
 [87.145.213.125])
 by smtp.gmail.com with ESMTPSA id s10sm3331447wmf.8.2019.06.28.11.15.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 11:15:44 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 20:15:33 +0200
Message-Id: <20190628181536.13729-2-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628181536.13729-1-huth@tuxfamily.org>
References: <20190628181536.13729-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: [Qemu-devel] [PATCH v2 1/4] m68k: Add NeXTcube framebuffer device
 emulation
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NeXTcube uses a linear framebuffer with 4 greyscale colors and
a fixed resolution of 1120 * 832.
This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at

 https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-fb.c

and altered to fit the latest interface of the current QEMU (e.g.
the device has been "qdev"-ified etc.).

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 default-configs/m68k-softmmu.mak |   1 +
 hw/display/Makefile.objs         |   1 +
 hw/display/next-fb.c             | 157 +++++++++++++++++++++++++++++++
 hw/m68k/Kconfig                  |   4 +
 include/hw/m68k/next-cube.h      |   8 ++
 5 files changed, 171 insertions(+)
 create mode 100644 hw/display/next-fb.c
 create mode 100644 include/hw/m68k/next-cube.h

diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index 4049a8f2ba..d67ab8b96d 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -6,3 +6,4 @@ CONFIG_SEMIHOSTING=y
 #
 CONFIG_AN5206=y
 CONFIG_MCF5208=y
+CONFIG_NEXTCUBE=y
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index a64998fc7b..8d1c71026d 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -38,6 +38,7 @@ obj-$(CONFIG_RASPI) += bcm2835_fb.o
 obj-$(CONFIG_SM501) += sm501.o
 obj-$(CONFIG_TCX) += tcx.o
 obj-$(CONFIG_CG3) += cg3.o
+obj-$(CONFIG_NEXTCUBE) += next-fb.o
 
 obj-$(CONFIG_VGA) += vga.o
 
diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
new file mode 100644
index 0000000000..740102d7e9
--- /dev/null
+++ b/hw/display/next-fb.c
@@ -0,0 +1,157 @@
+/*
+ * NeXT Cube/Station Framebuffer Emulation
+ *
+ * Copyright (c) 2011 Bryce Lanham
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "ui/console.h"
+#include "hw/hw.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/display/framebuffer.h"
+#define BITS 8
+#include "ui/pixel_ops.h"
+#include "hw/m68k/next-cube.h"
+
+#define TYPE_NEXTFB "next-fb"
+#define NEXTFB(obj) OBJECT_CHECK(NeXTFbState, (obj), TYPE_NEXTFB)
+
+struct NeXTFbState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion fb_mr;
+    MemoryRegionSection fbsection;
+    QemuConsole *con;
+
+    uint32_t pitch;
+    uint32_t cols;
+    uint32_t rows;
+    int invalidate;
+};
+typedef struct NeXTFbState NeXTFbState;
+
+static void nextfb_draw_line(void *opaque, uint8_t *d, const uint8_t *s,
+                             int width, int pitch)
+{
+    NeXTFbState *nfbstate = NEXTFB(opaque);
+    static const uint32_t pal[4] = {
+        0xFFFFFFFF, 0xFFAAAAAA, 0xFF555555, 0xFF000000
+    };
+    uint32_t *buf = (uint32_t *)d;
+    int i = 0;
+
+    for (i = 0; i < nfbstate->cols / 4; i++) {
+        int j = i * 4;
+        uint8_t src = s[i];
+        buf[j + 3] = pal[src & 0x3];
+        src >>= 2;
+        buf[j + 2] = pal[src & 0x3];
+        src >>= 2;
+        buf[j + 1] = pal[src & 0x3];
+        src >>= 2;
+        buf[j + 0] = pal[src & 0x3];
+    }
+}
+
+static void nextfb_update(void *opaque)
+{
+    NeXTFbState *s = NEXTFB(opaque);
+    int dest_width = 4;
+    int src_width;
+    int first = 0;
+    int last  = 0;
+    DisplaySurface *surface = qemu_console_surface(s->con);
+
+    src_width = s->cols / 4 + 8;
+    dest_width = s->cols * 4;
+
+    if (s->invalidate) {
+        framebuffer_update_memory_section(&s->fbsection, &s->fb_mr, 0,
+                                          s->cols, src_width);
+        s->invalidate = 0;
+    }
+
+    framebuffer_update_display(surface, &s->fbsection, 1120, 832,
+                               src_width, dest_width, 0, 1, nextfb_draw_line,
+                               s, &first, &last);
+
+    dpy_gfx_update(s->con, 0, 0, 1120, 832);
+}
+
+static void nextfb_invalidate(void *opaque)
+{
+    NeXTFbState *s = NEXTFB(opaque);
+    s->invalidate = 1;
+}
+
+static const GraphicHwOps nextfb_ops = {
+    .invalidate  = nextfb_invalidate,
+    .gfx_update  = nextfb_update,
+};
+
+static void nextfb_realize(DeviceState *dev, Error **errp)
+{
+    NeXTFbState *s = NEXTFB(dev);
+
+    memory_region_init_ram(&s->fb_mr, OBJECT(dev), "next-video", 0x1CB100,
+                           &error_fatal);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->fb_mr);
+
+    s->invalidate = 1;
+    s->cols = 1120;
+    s->rows = 832;
+
+    s->con = graphic_console_init(dev, 0, &nextfb_ops, s);
+    qemu_console_resize(s->con, s->cols, s->rows);
+}
+
+static void nextfb_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->realize = nextfb_realize;
+}
+
+static const TypeInfo nextfb_info = {
+    .name          = TYPE_NEXTFB,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(NeXTFbState),
+    .class_init    = nextfb_class_init,
+};
+
+static void nextfb_register_types(void)
+{
+    type_register_static(&nextfb_info);
+}
+
+type_init(nextfb_register_types)
+
+void nextfb_init(void)
+{
+    DeviceState *dev;
+
+    dev = qdev_create(NULL, TYPE_NEXTFB);
+    qdev_init_nofail(dev);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xB000000);
+}
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 49ef0b3f6d..ec58a2eb06 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -7,3 +7,7 @@ config MCF5208
     bool
     select COLDFIRE
     select PTIMER
+
+config NEXTCUBE
+    bool
+    select FRAMEBUFFER
diff --git a/include/hw/m68k/next-cube.h b/include/hw/m68k/next-cube.h
new file mode 100644
index 0000000000..cf07243bda
--- /dev/null
+++ b/include/hw/m68k/next-cube.h
@@ -0,0 +1,8 @@
+
+#ifndef NEXT_CUBE_H
+#define NEXT_CUBE_H
+
+/* next-fb.c */
+void nextfb_init(void);
+
+#endif /* NEXT_CUBE_H */
-- 
2.21.0


