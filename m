Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957F0C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69807214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69807214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABWE-0004zA-9f
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iABRa-0001Zt-RE
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iABRZ-00063F-MO
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:14:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iABRZ-00062U-F9
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C0B7877A64;
 Tue, 17 Sep 2019 11:14:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9375C219;
 Tue, 17 Sep 2019 11:14:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8597017536; Tue, 17 Sep 2019 13:14:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 13:14:40 +0200
Message-Id: <20190917111441.27405-2-kraxel@redhat.com>
In-Reply-To: <20190917111441.27405-1-kraxel@redhat.com>
References: <20190917111441.27405-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 17 Sep 2019 11:14:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/2] vga: move access helpers to separate
 include file
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 flier_m@outlook.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga-access.h  | 49 ++++++++++++++++++++++++++++++++++++++++
 hw/display/vga-helpers.h | 26 ---------------------
 hw/display/vga.c         |  1 +
 3 files changed, 50 insertions(+), 26 deletions(-)
 create mode 100644 hw/display/vga-access.h

diff --git a/hw/display/vga-access.h b/hw/display/vga-access.h
new file mode 100644
index 000000000000..c0fbd9958b2e
--- /dev/null
+++ b/hw/display/vga-access.h
@@ -0,0 +1,49 @@
+/*
+ * QEMU VGA Emulator templates
+ *
+ * Copyright (c) 2003 Fabrice Bellard
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
+
+static inline uint8_t vga_read_byte(VGACommonState *vga, uint32_t addr)
+{
+    return vga->vram_ptr[addr & vga->vbe_size_mask];
+}
+
+static inline uint16_t vga_read_word_le(VGACommonState *vga, uint32_t addr)
+{
+    uint32_t offset = addr & vga->vbe_size_mask & ~1;
+    uint16_t *ptr = (uint16_t *)(vga->vram_ptr + offset);
+    return lduw_le_p(ptr);
+}
+
+static inline uint16_t vga_read_word_be(VGACommonState *vga, uint32_t addr)
+{
+    uint32_t offset = addr & vga->vbe_size_mask & ~1;
+    uint16_t *ptr = (uint16_t *)(vga->vram_ptr + offset);
+    return lduw_be_p(ptr);
+}
+
+static inline uint32_t vga_read_dword_le(VGACommonState *vga, uint32_t addr)
+{
+    uint32_t offset = addr & vga->vbe_size_mask & ~3;
+    uint32_t *ptr = (uint32_t *)(vga->vram_ptr + offset);
+    return ldl_le_p(ptr);
+}
diff --git a/hw/display/vga-helpers.h b/hw/display/vga-helpers.h
index 5a752b3f9efd..10e9cfd40a04 100644
--- a/hw/display/vga-helpers.h
+++ b/hw/display/vga-helpers.h
@@ -95,32 +95,6 @@ static void vga_draw_glyph9(uint8_t *d, int linesize,
     } while (--h);
 }
 
-static inline uint8_t vga_read_byte(VGACommonState *vga, uint32_t addr)
-{
-    return vga->vram_ptr[addr & vga->vbe_size_mask];
-}
-
-static inline uint16_t vga_read_word_le(VGACommonState *vga, uint32_t addr)
-{
-    uint32_t offset = addr & vga->vbe_size_mask & ~1;
-    uint16_t *ptr = (uint16_t *)(vga->vram_ptr + offset);
-    return lduw_le_p(ptr);
-}
-
-static inline uint16_t vga_read_word_be(VGACommonState *vga, uint32_t addr)
-{
-    uint32_t offset = addr & vga->vbe_size_mask & ~1;
-    uint16_t *ptr = (uint16_t *)(vga->vram_ptr + offset);
-    return lduw_be_p(ptr);
-}
-
-static inline uint32_t vga_read_dword_le(VGACommonState *vga, uint32_t addr)
-{
-    uint32_t offset = addr & vga->vbe_size_mask & ~3;
-    uint32_t *ptr = (uint32_t *)(vga->vram_ptr + offset);
-    return ldl_le_p(ptr);
-}
-
 /*
  * 4 color mode
  */
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 573d223d46f0..82ebe5361096 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1009,6 +1009,7 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
 typedef void vga_draw_line_func(VGACommonState *s1, uint8_t *d,
                                 uint32_t srcaddr, int width);
 
+#include "vga-access.h"
 #include "vga-helpers.h"
 
 /* return true if the palette was modified */
-- 
2.18.1


