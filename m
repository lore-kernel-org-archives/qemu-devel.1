Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD9FC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CE3218AC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CE3218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6cyZ-0005ST-Jg
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 11:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i6cwO-0003jW-3U
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i6cwM-0007gQ-Be
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:56 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i6cwM-0007fn-54
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:54 -0400
Received: by mail-wr1-f43.google.com with SMTP id q17so4746940wrx.10
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 08:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VpLOyuIbEO1Jv3ImX5dwNgUJpuLil1FFem8OVxVL+ig=;
 b=ZkSZCL7COqwPMt9DLauxQsha01PVt+s0FZw0NsI0tbEqXHCyiQ2C0CnObDA5MakNc0
 Ge/VqFYKWxz2Hks5z4Ow6E/WiQg2hZhgzZE3pbIHW0gMR9FzfvXpKAN51zTD/xNYQe5I
 Hax6+c7FtzDV4qzxDKpXd34nErUVAKRAaNRLnk3j3ftYWaN2bJkbZF5zoRmM3kEgqJUd
 RPIGjcfjaA6D7UM2kQ0XRwqG/S+sD+umlqAXUwp6SWRPstxXSxWWoUjSZNVXEOIP5zNO
 +O8itM6aGHdaWnsS+nrdw+75+lu9lVlGFJ0PzgXZG9gHGcPk85LRiFE2CC/KGu6tsba6
 l7Uw==
X-Gm-Message-State: APjAAAUdHjWGLvkLRosBeUZoqoOX9YE+Xp+ww/CweLZjH3FjNlPbQnJ5
 KybcWv+XS40AAzMWN2mQaac=
X-Google-Smtp-Source: APXvYqzBJZ4HM2UM7A8J5SCK0wdH64AtkxMZZv3oxIbfef2OaGX+QxxDl+H2g0VxCXfCl0vPY1bl6Q==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr7097117wrp.303.1567871273114; 
 Sat, 07 Sep 2019 08:47:53 -0700 (PDT)
Received: from thl530.multi.box (pD9E8385F.dip0.t-ipconnect.de.
 [217.232.56.95])
 by smtp.gmail.com with ESMTPSA id s19sm17173418wrb.14.2019.09.07.08.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 08:47:52 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Sat,  7 Sep 2019 17:47:37 +0200
Message-Id: <20190907154744.4136-2-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907154744.4136-1-huth@tuxfamily.org>
References: <20190907154744.4136-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.43
Subject: [Qemu-devel] [PULL 1/8] m68k: Add NeXTcube framebuffer device
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NeXTcube uses a linear framebuffer with 4 greyscale colors and
a fixed resolution of 1120 * 832.
This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at

 https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-fb.c

and altered to fit the latest interface of the current QEMU (e.g.
the device has been "qdev"-ified etc.).

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190831074519.32613-2-huth@tuxfamily.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 default-configs/m68k-softmmu.mak |   1 +
 hw/display/Makefile.objs         |   1 +
 hw/display/next-fb.c             | 146 +++++++++++++++++++++++++++++++
 hw/m68k/Kconfig                  |   4 +
 include/hw/m68k/next-cube.h      |   7 ++
 5 files changed, 159 insertions(+)
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
index 0f11d55b14..5a4066383b 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -38,6 +38,7 @@ common-obj-$(CONFIG_RASPI) += bcm2835_fb.o
 common-obj-$(CONFIG_SM501) += sm501.o
 common-obj-$(CONFIG_TCX) += tcx.o
 common-obj-$(CONFIG_CG3) += cg3.o
+common-obj-$(CONFIG_NEXTCUBE) += next-fb.o
 
 obj-$(CONFIG_VGA) += vga.o
 
diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
new file mode 100644
index 0000000000..2b726a10f8
--- /dev/null
+++ b/hw/display/next-fb.c
@@ -0,0 +1,146 @@
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
+#include "ui/pixel_ops.h"
+#include "hw/m68k/next-cube.h"
+
+#define NEXTFB(obj) OBJECT_CHECK(NeXTFbState, (obj), TYPE_NEXTFB)
+
+struct NeXTFbState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion fb_mr;
+    MemoryRegionSection fbsection;
+    QemuConsole *con;
+
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
+    framebuffer_update_display(surface, &s->fbsection, s->cols, s->rows,
+                               src_width, dest_width, 0, 1, nextfb_draw_line,
+                               s, &first, &last);
+
+    dpy_gfx_update(s->con, 0, 0, s->cols, s->rows);
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
+
+    /* Note: This device does not any state that we have to reset or migrate */
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
index 0000000000..090c7c51aa
--- /dev/null
+++ b/include/hw/m68k/next-cube.h
@@ -0,0 +1,7 @@
+
+#ifndef NEXT_CUBE_H
+#define NEXT_CUBE_H
+
+#define TYPE_NEXTFB "next-fb"
+
+#endif /* NEXT_CUBE_H */
-- 
2.21.0


