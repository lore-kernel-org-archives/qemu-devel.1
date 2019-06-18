Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80819C31E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFE42082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFE42082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCGg-0003cE-EV
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44077)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hdCDa-0001sj-Rb
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hdCDO-000730-Hm
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:23:58 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:11328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hdCDN-000714-Mm
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:23:50 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: iAHnyEQDiAYjKmkQ/QJYVnRvLCTvnkS/LvsRCzkmeY5mlZNOLWoqsewtTf7RiVdVUM1C6XuBeH
 bVVAV+9DHkdsemZ4k4BK2UxIhqVgp8/dKeDfPRQ+zcXBJ3szcDm/jBO3NOaDdk90p2+Cvzn/pf
 5WhiT0FiUlOLHwpCSfHq3uxLBaxZq8EPk2w/sJV5wvFLtL/PJi3dFMMAGhM8FYFpD0RYd07tOV
 RUCbHIGR8bPhrryM3Eilrg+biCJQUy4H1jQxbbR6H8Bgc3JBvdcM6UaQ3UwaP4s7dBvr2YAzbH
 Fc8=
X-SBRS: 2.7
X-MesageID: 1889147
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,389,1557201600"; 
   d="scan'208";a="1889147"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 18 Jun 2019 12:23:39 +0100
Message-ID: <20190618112341.513-3-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618112341.513-1-anthony.perard@citrix.com>
References: <20190618112341.513-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.142
Subject: [Qemu-devel] [PATCH v2 2/4] xen: Import other xen/io/*.h
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
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul.durrant@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following "xen: Fix build with public headers", import other Xen
public headers that are describing interfaces.

Import fbif.h, kbdif.h, netif.h, console.h, xenbus.h, protocols.h.

While editing xenfb.c, remove the include of event_channel.h as it
isn't needed.

The headers are cleaned up a bit while importing them. The header
guard symbols are changed to match QEMU's coding style, some other
part of the file that QEMU doesn't use are removed.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
---
 hw/9pfs/xen-9pfs.h                      |    2 +-
 hw/block/xen_blkif.h                    |    2 +-
 hw/char/xen_console.c                   |    2 +-
 hw/display/xenfb.c                      |    7 +-
 hw/net/xen_nic.c                        |    2 +-
 include/hw/xen/interface/io/console.h   |   46 ++
 include/hw/xen/interface/io/fbif.h      |  156 ++++
 include/hw/xen/interface/io/kbdif.h     |  566 +++++++++++++
 include/hw/xen/interface/io/netif.h     | 1010 +++++++++++++++++++++++
 include/hw/xen/interface/io/protocols.h |   42 +
 include/hw/xen/interface/io/xenbus.h    |   70 ++
 include/hw/xen/xen_common.h             |    2 +-
 12 files changed, 1898 insertions(+), 9 deletions(-)
 create mode 100644 include/hw/xen/interface/io/console.h
 create mode 100644 include/hw/xen/interface/io/fbif.h
 create mode 100644 include/hw/xen/interface/io/kbdif.h
 create mode 100644 include/hw/xen/interface/io/netif.h
 create mode 100644 include/hw/xen/interface/io/protocols.h
 create mode 100644 include/hw/xen/interface/io/xenbus.h

diff --git a/hw/9pfs/xen-9pfs.h b/hw/9pfs/xen-9pfs.h
index 92dc87e9e0..241e2216a4 100644
--- a/hw/9pfs/xen-9pfs.h
+++ b/hw/9pfs/xen-9pfs.h
@@ -13,7 +13,7 @@
 #ifndef HW_9PFS_XEN_9PFS_H
 #define HW_9PFS_XEN_9PFS_H
 
-#include <xen/io/protocols.h>
+#include "hw/xen/interface/io/protocols.h"
 #include "hw/xen/interface/io/ring.h"
 
 /*
diff --git a/hw/block/xen_blkif.h b/hw/block/xen_blkif.h
index 5a1094d793..99733529c1 100644
--- a/hw/block/xen_blkif.h
+++ b/hw/block/xen_blkif.h
@@ -2,7 +2,7 @@
 #define XEN_BLKIF_H
 
 #include "hw/xen/interface/io/blkif.h"
-#include <xen/io/protocols.h>
+#include "hw/xen/interface/io/protocols.h"
 
 /*
  * Not a real protocol.  Used to generate ring structs which contain
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 91f34ef06c..47e1092263 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -28,7 +28,7 @@
 #include "chardev/char-fe.h"
 #include "hw/xen/xen-legacy-backend.h"
 
-#include <xen/io/console.h>
+#include "hw/xen/interface/io/console.h"
 
 struct buffer {
     uint8_t *data;
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 6202f1150e..3c79913b31 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -32,10 +32,9 @@
 #include "ui/console.h"
 #include "hw/xen/xen-legacy-backend.h"
 
-#include <xen/event_channel.h>
-#include <xen/io/fbif.h>
-#include <xen/io/kbdif.h>
-#include <xen/io/protocols.h>
+#include "hw/xen/interface/io/fbif.h"
+#include "hw/xen/interface/io/kbdif.h"
+#include "hw/xen/interface/io/protocols.h"
 
 #include "trace.h"
 
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 37cda8e4be..ffb3b5898d 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -30,7 +30,7 @@
 #include "net/util.h"
 #include "hw/xen/xen-legacy-backend.h"
 
-#include <xen/io/netif.h>
+#include "hw/xen/interface/io/netif.h"
 
 /* ------------------------------------------------------------- */
 
diff --git a/include/hw/xen/interface/io/console.h b/include/hw/xen/interface/io/console.h
new file mode 100644
index 0000000000..b14316981f
--- /dev/null
+++ b/include/hw/xen/interface/io/console.h
@@ -0,0 +1,46 @@
+/******************************************************************************
+ * console.h
+ *
+ * Console I/O interface for Xen guest OSes.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * Copyright (c) 2005, Keir Fraser
+ */
+
+#ifndef XEN_PUBLIC_IO_CONSOLE_H
+#define XEN_PUBLIC_IO_CONSOLE_H
+
+typedef uint32_t XENCONS_RING_IDX;
+
+#define MASK_XENCONS_IDX(idx, ring) ((idx) & (sizeof(ring)-1))
+
+struct xencons_interface {
+    char in[1024];
+    char out[2048];
+    XENCONS_RING_IDX in_cons, in_prod;
+    XENCONS_RING_IDX out_cons, out_prod;
+};
+
+#ifdef XEN_WANT_FLEX_CONSOLE_RING
+#include "ring.h"
+DEFINE_XEN_FLEX_RING(xencons);
+#endif
+
+#endif /* XEN_PUBLIC_IO_CONSOLE_H */
diff --git a/include/hw/xen/interface/io/fbif.h b/include/hw/xen/interface/io/fbif.h
new file mode 100644
index 0000000000..4e25423490
--- /dev/null
+++ b/include/hw/xen/interface/io/fbif.h
@@ -0,0 +1,156 @@
+/*
+ * fbif.h -- Xen virtual frame buffer device
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * Copyright (C) 2005 Anthony Liguori <aliguori@us.ibm.com>
+ * Copyright (C) 2006 Red Hat, Inc., Markus Armbruster <armbru@redhat.com>
+ */
+
+#ifndef XEN_PUBLIC_IO_FBIF_H
+#define XEN_PUBLIC_IO_FBIF_H
+
+/* Out events (frontend -> backend) */
+
+/*
+ * Out events may be sent only when requested by backend, and receipt
+ * of an unknown out event is an error.
+ */
+
+/* Event type 1 currently not used */
+/*
+ * Framebuffer update notification event
+ * Capable frontend sets feature-update in xenstore.
+ * Backend requests it by setting request-update in xenstore.
+ */
+#define XENFB_TYPE_UPDATE 2
+
+struct xenfb_update
+{
+    uint8_t type;    /* XENFB_TYPE_UPDATE */
+    int32_t x;      /* source x */
+    int32_t y;      /* source y */
+    int32_t width;  /* rect width */
+    int32_t height; /* rect height */
+};
+
+/*
+ * Framebuffer resize notification event
+ * Capable backend sets feature-resize in xenstore.
+ */
+#define XENFB_TYPE_RESIZE 3
+
+struct xenfb_resize
+{
+    uint8_t type;    /* XENFB_TYPE_RESIZE */
+    int32_t width;   /* width in pixels */
+    int32_t height;  /* height in pixels */
+    int32_t stride;  /* stride in bytes */
+    int32_t depth;   /* depth in bits */
+    int32_t offset;  /* offset of the framebuffer in bytes */
+};
+
+#define XENFB_OUT_EVENT_SIZE 40
+
+union xenfb_out_event
+{
+    uint8_t type;
+    struct xenfb_update update;
+    struct xenfb_resize resize;
+    char pad[XENFB_OUT_EVENT_SIZE];
+};
+
+/* In events (backend -> frontend) */
+
+/*
+ * Frontends should ignore unknown in events.
+ */
+
+/*
+ * Framebuffer refresh period advice
+ * Backend sends it to advise the frontend their preferred period of
+ * refresh.  Frontends that keep the framebuffer constantly up-to-date
+ * just ignore it.  Frontends that use the advice should immediately
+ * refresh the framebuffer (and send an update notification event if
+ * those have been requested), then use the update frequency to guide
+ * their periodical refreshs.
+ */
+#define XENFB_TYPE_REFRESH_PERIOD 1
+#define XENFB_NO_REFRESH 0
+
+struct xenfb_refresh_period
+{
+    uint8_t type;    /* XENFB_TYPE_UPDATE_PERIOD */
+    uint32_t period; /* period of refresh, in ms,
+                      * XENFB_NO_REFRESH if no refresh is needed */
+};
+
+#define XENFB_IN_EVENT_SIZE 40
+
+union xenfb_in_event
+{
+    uint8_t type;
+    struct xenfb_refresh_period refresh_period;
+    char pad[XENFB_IN_EVENT_SIZE];
+};
+
+/* shared page */
+
+#define XENFB_IN_RING_SIZE 1024
+#define XENFB_IN_RING_LEN (XENFB_IN_RING_SIZE / XENFB_IN_EVENT_SIZE)
+#define XENFB_IN_RING_OFFS 1024
+#define XENFB_IN_RING(page) \
+    ((union xenfb_in_event *)((char *)(page) + XENFB_IN_RING_OFFS))
+#define XENFB_IN_RING_REF(page, idx) \
+    (XENFB_IN_RING((page))[(idx) % XENFB_IN_RING_LEN])
+
+#define XENFB_OUT_RING_SIZE 2048
+#define XENFB_OUT_RING_LEN (XENFB_OUT_RING_SIZE / XENFB_OUT_EVENT_SIZE)
+#define XENFB_OUT_RING_OFFS (XENFB_IN_RING_OFFS + XENFB_IN_RING_SIZE)
+#define XENFB_OUT_RING(page) \
+    ((union xenfb_out_event *)((char *)(page) + XENFB_OUT_RING_OFFS))
+#define XENFB_OUT_RING_REF(page, idx) \
+    (XENFB_OUT_RING((page))[(idx) % XENFB_OUT_RING_LEN])
+
+struct xenfb_page
+{
+    uint32_t in_cons, in_prod;
+    uint32_t out_cons, out_prod;
+
+    int32_t width;          /* the width of the framebuffer (in pixels) */
+    int32_t height;         /* the height of the framebuffer (in pixels) */
+    uint32_t line_length;   /* the length of a row of pixels (in bytes) */
+    uint32_t mem_length;    /* the length of the framebuffer (in bytes) */
+    uint8_t depth;          /* the depth of a pixel (in bits) */
+
+    /*
+     * Framebuffer page directory
+     *
+     * Each directory page holds PAGE_SIZE / sizeof(*pd)
+     * framebuffer pages, and can thus map up to PAGE_SIZE *
+     * PAGE_SIZE / sizeof(*pd) bytes.  With PAGE_SIZE == 4096 and
+     * sizeof(unsigned long) == 4/8, that's 4 Megs 32 bit and 2 Megs
+     * 64 bit.  256 directories give enough room for a 512 Meg
+     * framebuffer with a max resolution of 12,800x10,240.  Should
+     * be enough for a while with room leftover for expansion.
+     */
+    unsigned long pd[256];
+};
+
+#endif
diff --git a/include/hw/xen/interface/io/kbdif.h b/include/hw/xen/interface/io/kbdif.h
new file mode 100644
index 0000000000..252cf10156
--- /dev/null
+++ b/include/hw/xen/interface/io/kbdif.h
@@ -0,0 +1,566 @@
+/*
+ * kbdif.h -- Xen virtual keyboard/mouse
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * Copyright (C) 2005 Anthony Liguori <aliguori@us.ibm.com>
+ * Copyright (C) 2006 Red Hat, Inc., Markus Armbruster <armbru@redhat.com>
+ */
+
+#ifndef XEN_PUBLIC_IO_KBDIF_H
+#define XEN_PUBLIC_IO_KBDIF_H
+
+/*
+ *****************************************************************************
+ *                     Feature and Parameter Negotiation
+ *****************************************************************************
+ *
+ * The two halves of a para-virtual driver utilize nodes within
+ * XenStore to communicate capabilities and to negotiate operating parameters.
+ * This section enumerates these nodes which reside in the respective front and
+ * backend portions of XenStore, following XenBus convention.
+ *
+ * All data in XenStore is stored as strings.  Nodes specifying numeric
+ * values are encoded in decimal. Integer value ranges listed below are
+ * expressed as fixed sized integer types capable of storing the conversion
+ * of a properly formated node string, without loss of information.
+ *
+ *****************************************************************************
+ *                            Backend XenBus Nodes
+ *****************************************************************************
+ *
+ *---------------------------- Features supported ----------------------------
+ *
+ * Capable backend advertises supported features by publishing
+ * corresponding entries in XenStore and puts 1 as the value of the entry.
+ * If a feature is not supported then 0 must be set or feature entry omitted.
+ *
+ * feature-disable-keyboard
+ *      Values:         <uint>
+ *
+ *      If there is no need to expose a virtual keyboard device by the
+ *      frontend then this must be set to 1.
+ *
+ * feature-disable-pointer
+ *      Values:         <uint>
+ *
+ *      If there is no need to expose a virtual pointer device by the
+ *      frontend then this must be set to 1.
+ *
+ * feature-abs-pointer
+ *      Values:         <uint>
+ *
+ *      Backends, which support reporting of absolute coordinates for pointer
+ *      device should set this to 1.
+ *
+ * feature-multi-touch
+ *      Values:         <uint>
+ *
+ *      Backends, which support reporting of multi-touch events
+ *      should set this to 1.
+ *
+ * feature-raw-pointer
+ *      Values:        <uint>
+ *
+ *      Backends, which support reporting raw (unscaled) absolute coordinates
+ *      for pointer devices should set this to 1. Raw (unscaled) values have
+ *      a range of [0, 0x7fff].
+ *
+ *-----------------------  Device Instance Parameters ------------------------
+ *
+ * unique-id
+ *      Values:         <string>
+ *
+ *      After device instance initialization it is assigned a unique ID,
+ *      so every instance of the frontend can be identified by the backend
+ *      by this ID. This can be UUID or such.
+ *
+ *------------------------- Pointer Device Parameters ------------------------
+ *
+ * width
+ *      Values:         <uint>
+ *
+ *      Maximum X coordinate (width) to be used by the frontend
+ *      while reporting input events, pixels, [0; UINT32_MAX].
+ *
+ * height
+ *      Values:         <uint>
+ *
+ *      Maximum Y coordinate (height) to be used by the frontend
+ *      while reporting input events, pixels, [0; UINT32_MAX].
+ *
+ *----------------------- Multi-touch Device Parameters ----------------------
+ *
+ * multi-touch-num-contacts
+ *      Values:         <uint>
+ *
+ *      Number of simultaneous touches reported.
+ *
+ * multi-touch-width
+ *      Values:         <uint>
+ *
+ *      Width of the touch area to be used by the frontend
+ *      while reporting input events, pixels, [0; UINT32_MAX].
+ *
+ * multi-touch-height
+ *      Values:         <uint>
+ *
+ *      Height of the touch area to be used by the frontend
+ *      while reporting input events, pixels, [0; UINT32_MAX].
+ *
+ *****************************************************************************
+ *                            Frontend XenBus Nodes
+ *****************************************************************************
+ *
+ *------------------------------ Feature request -----------------------------
+ *
+ * Capable frontend requests features from backend via setting corresponding
+ * entries to 1 in XenStore. Requests for features not advertised as supported
+ * by the backend have no effect.
+ *
+ * request-abs-pointer
+ *      Values:         <uint>
+ *
+ *      Request backend to report absolute pointer coordinates
+ *      (XENKBD_TYPE_POS) instead of relative ones (XENKBD_TYPE_MOTION).
+ *
+ * request-multi-touch
+ *      Values:         <uint>
+ *
+ *      Request backend to report multi-touch events.
+ *
+ * request-raw-pointer
+ *      Values:         <uint>
+ *
+ *      Request backend to report raw unscaled absolute pointer coordinates.
+ *      This option is only valid if request-abs-pointer is also set.
+ *      Raw unscaled coordinates have the range [0, 0x7fff]
+ *
+ *----------------------- Request Transport Parameters -----------------------
+ *
+ * event-channel
+ *      Values:         <uint>
+ *
+ *      The identifier of the Xen event channel used to signal activity
+ *      in the ring buffer.
+ *
+ * page-gref
+ *      Values:         <uint>
+ *
+ *      The Xen grant reference granting permission for the backend to map
+ *      a sole page in a single page sized event ring buffer.
+ *
+ * page-ref
+ *      Values:         <uint>
+ *
+ *      OBSOLETE, not recommended for use.
+ *      PFN of the shared page.
+ */
+
+/*
+ * EVENT CODES.
+ */
+
+#define XENKBD_TYPE_MOTION             1
+#define XENKBD_TYPE_RESERVED           2
+#define XENKBD_TYPE_KEY                3
+#define XENKBD_TYPE_POS                4
+#define XENKBD_TYPE_MTOUCH             5
+
+/* Multi-touch event sub-codes */
+
+#define XENKBD_MT_EV_DOWN              0
+#define XENKBD_MT_EV_UP                1
+#define XENKBD_MT_EV_MOTION            2
+#define XENKBD_MT_EV_SYN               3
+#define XENKBD_MT_EV_SHAPE             4
+#define XENKBD_MT_EV_ORIENT            5
+
+/*
+ * CONSTANTS, XENSTORE FIELD AND PATH NAME STRINGS, HELPERS.
+ */
+
+#define XENKBD_DRIVER_NAME             "vkbd"
+
+#define XENKBD_FIELD_FEAT_DSBL_KEYBRD  "feature-disable-keyboard"
+#define XENKBD_FIELD_FEAT_DSBL_POINTER "feature-disable-pointer"
+#define XENKBD_FIELD_FEAT_ABS_POINTER  "feature-abs-pointer"
+#define XENKBD_FIELD_FEAT_RAW_POINTER  "feature-raw-pointer"
+#define XENKBD_FIELD_FEAT_MTOUCH       "feature-multi-touch"
+#define XENKBD_FIELD_REQ_ABS_POINTER   "request-abs-pointer"
+#define XENKBD_FIELD_REQ_RAW_POINTER   "request-raw-pointer"
+#define XENKBD_FIELD_REQ_MTOUCH        "request-multi-touch"
+#define XENKBD_FIELD_RING_GREF         "page-gref"
+#define XENKBD_FIELD_EVT_CHANNEL       "event-channel"
+#define XENKBD_FIELD_WIDTH             "width"
+#define XENKBD_FIELD_HEIGHT            "height"
+#define XENKBD_FIELD_MT_WIDTH          "multi-touch-width"
+#define XENKBD_FIELD_MT_HEIGHT         "multi-touch-height"
+#define XENKBD_FIELD_MT_NUM_CONTACTS   "multi-touch-num-contacts"
+#define XENKBD_FIELD_UNIQUE_ID         "unique-id"
+
+/* OBSOLETE, not recommended for use */
+#define XENKBD_FIELD_RING_REF          "page-ref"
+
+/*
+ *****************************************************************************
+ * Description of the protocol between frontend and backend driver.
+ *****************************************************************************
+ *
+ * The two halves of a Para-virtual driver communicate with
+ * each other using a shared page and an event channel.
+ * Shared page contains a ring with event structures.
+ *
+ * All reserved fields in the structures below must be 0.
+ *
+ *****************************************************************************
+ *                           Backend to frontend events
+ *****************************************************************************
+ *
+ * Frontends should ignore unknown in events.
+ * All event packets have the same length (40 octets)
+ * All event packets have common header:
+ *
+ *          0         octet
+ * +-----------------+
+ * |       type      |
+ * +-----------------+
+ * type - uint8_t, event code, XENKBD_TYPE_???
+ *
+ *
+ * Pointer relative movement event
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |  _TYPE_MOTION  |                     reserved                     | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                               rel_x                               | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                               rel_y                               | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                               rel_z                               | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 40
+ * +----------------+----------------+----------------+----------------+
+ *
+ * rel_x - int32_t, relative X motion
+ * rel_y - int32_t, relative Y motion
+ * rel_z - int32_t, relative Z motion (wheel)
+ */
+
+struct xenkbd_motion
+{
+    uint8_t type;
+    int32_t rel_x;
+    int32_t rel_y;
+    int32_t rel_z;
+};
+
+/*
+ * Key event (includes pointer buttons)
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |  _TYPE_KEY     |     pressed    |            reserved             | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                              keycode                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 12
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 40
+ * +----------------+----------------+----------------+----------------+
+ *
+ * pressed - uint8_t, 1 if pressed; 0 otherwise
+ * keycode - uint32_t, KEY_* from linux/input.h
+ */
+
+struct xenkbd_key
+{
+    uint8_t type;
+    uint8_t pressed;
+    uint32_t keycode;
+};
+
+/*
+ * Pointer absolute position event
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |  _TYPE_POS     |                     reserved                     | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                               abs_x                               | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                               abs_y                               | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                               rel_z                               | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 40
+ * +----------------+----------------+----------------+----------------+
+ *
+ * abs_x - int32_t, absolute X position (in FB pixels)
+ * abs_y - int32_t, absolute Y position (in FB pixels)
+ * rel_z - int32_t, relative Z motion (wheel)
+ */
+
+struct xenkbd_position
+{
+    uint8_t type;
+    int32_t abs_x;
+    int32_t abs_y;
+    int32_t rel_z;
+};
+
+/*
+ * Multi-touch event and its sub-types
+ *
+ * All multi-touch event packets have common header:
+ *
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |  _TYPE_MTOUCH  |   event_type   |   contact_id   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ *
+ * event_type - unt8_t, multi-touch event sub-type, XENKBD_MT_EV_???
+ * contact_id - unt8_t, ID of the contact
+ *
+ * Touch interactions can consist of one or more contacts.
+ * For each contact, a series of events is generated, starting
+ * with a down event, followed by zero or more motion events,
+ * and ending with an up event. Events relating to the same
+ * contact point can be identified by the ID of the sequence: contact ID.
+ * Contact ID may be reused after XENKBD_MT_EV_UP event and
+ * is in the [0; XENKBD_FIELD_NUM_CONTACTS - 1] range.
+ *
+ * For further information please refer to documentation on Wayland [1],
+ * Linux [2] and Windows [3] multi-touch support.
+ *
+ * [1] https://cgit.freedesktop.org/wayland/wayland/tree/protocol/wayland.xml
+ * [2] https://www.kernel.org/doc/Documentation/input/multi-touch-protocol.txt
+ * [3] https://msdn.microsoft.com/en-us/library/jj151564(v=vs.85).aspx
+ *
+ *
+ * Multi-touch down event - sent when a new touch is made: touch is assigned
+ * a unique contact ID, sent with this and consequent events related
+ * to this touch.
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |  _TYPE_MTOUCH  |   _MT_EV_DOWN  |   contact_id   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                               abs_x                               | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                               abs_y                               | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 40
+ * +----------------+----------------+----------------+----------------+
+ *
+ * abs_x - int32_t, absolute X position, in pixels
+ * abs_y - int32_t, absolute Y position, in pixels
+ *
+ * Multi-touch contact release event
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |  _TYPE_MTOUCH  |  _MT_EV_UP     |   contact_id   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 40
+ * +----------------+----------------+----------------+----------------+
+ *
+ * Multi-touch motion event
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |  _TYPE_MTOUCH  |  _MT_EV_MOTION |   contact_id   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                               abs_x                               | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                               abs_y                               | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 40
+ * +----------------+----------------+----------------+----------------+
+ *
+ * abs_x - int32_t, absolute X position, in pixels,
+ * abs_y - int32_t, absolute Y position, in pixels,
+ *
+ * Multi-touch input synchronization event - shows end of a set of events
+ * which logically belong together.
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |  _TYPE_MTOUCH  |  _MT_EV_SYN    |   contact_id   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 40
+ * +----------------+----------------+----------------+----------------+
+ *
+ * Multi-touch shape event - touch point's shape has changed its shape.
+ * Shape is approximated by an ellipse through the major and minor axis
+ * lengths: major is the longer diameter of the ellipse and minor is the
+ * shorter one. Center of the ellipse is reported via
+ * XENKBD_MT_EV_DOWN/XENKBD_MT_EV_MOTION events.
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |  _TYPE_MTOUCH  |  _MT_EV_SHAPE  |   contact_id   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                               major                               | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                               minor                               | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 40
+ * +----------------+----------------+----------------+----------------+
+ *
+ * major - unt32_t, length of the major axis, pixels
+ * minor - unt32_t, length of the minor axis, pixels
+ *
+ * Multi-touch orientation event - touch point's shape has changed
+ * its orientation: calculated as a clockwise angle between the major axis
+ * of the ellipse and positive Y axis in degrees, [-180; +180].
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |  _TYPE_MTOUCH  |  _MT_EV_ORIENT |   contact_id   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |           orientation           |            reserved             | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 16
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 40
+ * +----------------+----------------+----------------+----------------+
+ *
+ * orientation - int16_t, clockwise angle of the major axis
+ */
+
+struct xenkbd_mtouch {
+    uint8_t type;            /* XENKBD_TYPE_MTOUCH */
+    uint8_t event_type;      /* XENKBD_MT_EV_??? */
+    uint8_t contact_id;
+    uint8_t reserved[5];     /* reserved for the future use */
+    union {
+        struct {
+            int32_t abs_x;   /* absolute X position, pixels */
+            int32_t abs_y;   /* absolute Y position, pixels */
+        } pos;
+        struct {
+            uint32_t major;  /* length of the major axis, pixels */
+            uint32_t minor;  /* length of the minor axis, pixels */
+        } shape;
+        int16_t orientation; /* clockwise angle of the major axis */
+    } u;
+};
+
+#define XENKBD_IN_EVENT_SIZE 40
+
+union xenkbd_in_event
+{
+    uint8_t type;
+    struct xenkbd_motion motion;
+    struct xenkbd_key key;
+    struct xenkbd_position pos;
+    struct xenkbd_mtouch mtouch;
+    char pad[XENKBD_IN_EVENT_SIZE];
+};
+
+/*
+ *****************************************************************************
+ *                            Frontend to backend events
+ *****************************************************************************
+ *
+ * Out events may be sent only when requested by backend, and receipt
+ * of an unknown out event is an error.
+ * No out events currently defined.
+
+ * All event packets have the same length (40 octets)
+ * All event packets have common header:
+ *          0         octet
+ * +-----------------+
+ * |       type      |
+ * +-----------------+
+ * type - uint8_t, event code
+ */
+
+#define XENKBD_OUT_EVENT_SIZE 40
+
+union xenkbd_out_event
+{
+    uint8_t type;
+    char pad[XENKBD_OUT_EVENT_SIZE];
+};
+
+/*
+ *****************************************************************************
+ *                            Shared page
+ *****************************************************************************
+ */
+
+#define XENKBD_IN_RING_SIZE 2048
+#define XENKBD_IN_RING_LEN (XENKBD_IN_RING_SIZE / XENKBD_IN_EVENT_SIZE)
+#define XENKBD_IN_RING_OFFS 1024
+#define XENKBD_IN_RING(page) \
+    ((union xenkbd_in_event *)((char *)(page) + XENKBD_IN_RING_OFFS))
+#define XENKBD_IN_RING_REF(page, idx) \
+    (XENKBD_IN_RING((page))[(idx) % XENKBD_IN_RING_LEN])
+
+#define XENKBD_OUT_RING_SIZE 1024
+#define XENKBD_OUT_RING_LEN (XENKBD_OUT_RING_SIZE / XENKBD_OUT_EVENT_SIZE)
+#define XENKBD_OUT_RING_OFFS (XENKBD_IN_RING_OFFS + XENKBD_IN_RING_SIZE)
+#define XENKBD_OUT_RING(page) \
+    ((union xenkbd_out_event *)((char *)(page) + XENKBD_OUT_RING_OFFS))
+#define XENKBD_OUT_RING_REF(page, idx) \
+    (XENKBD_OUT_RING((page))[(idx) % XENKBD_OUT_RING_LEN])
+
+struct xenkbd_page
+{
+    uint32_t in_cons, in_prod;
+    uint32_t out_cons, out_prod;
+};
+
+#endif /* XEN_PUBLIC_IO_KBDIF_H */
diff --git a/include/hw/xen/interface/io/netif.h b/include/hw/xen/interface/io/netif.h
new file mode 100644
index 0000000000..f4a28a43b1
--- /dev/null
+++ b/include/hw/xen/interface/io/netif.h
@@ -0,0 +1,1010 @@
+/******************************************************************************
+ * netif.h
+ *
+ * Unified network-device I/O interface for Xen guest OSes.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * Copyright (c) 2003-2004, Keir Fraser
+ */
+
+#ifndef XEN_PUBLIC_IO_NETIF_H
+#define XEN_PUBLIC_IO_NETIF_H
+
+#include "ring.h"
+#include "../grant_table.h"
+
+/*
+ * Older implementation of Xen network frontend / backend has an
+ * implicit dependency on the MAX_SKB_FRAGS as the maximum number of
+ * ring slots a skb can use. Netfront / netback may not work as
+ * expected when frontend and backend have different MAX_SKB_FRAGS.
+ *
+ * A better approach is to add mechanism for netfront / netback to
+ * negotiate this value. However we cannot fix all possible
+ * frontends, so we need to define a value which states the minimum
+ * slots backend must support.
+ *
+ * The minimum value derives from older Linux kernel's MAX_SKB_FRAGS
+ * (18), which is proved to work with most frontends. Any new backend
+ * which doesn't negotiate with frontend should expect frontend to
+ * send a valid packet using slots up to this value.
+ */
+#define XEN_NETIF_NR_SLOTS_MIN 18
+
+/*
+ * Notifications after enqueuing any type of message should be conditional on
+ * the appropriate req_event or rsp_event field in the shared ring.
+ * If the client sends notification for rx requests then it should specify
+ * feature 'feature-rx-notify' via xenbus. Otherwise the backend will assume
+ * that it cannot safely queue packets (as it may not be kicked to send them).
+ */
+
+/*
+ * "feature-split-event-channels" is introduced to separate guest TX
+ * and RX notification. Backend either doesn't support this feature or
+ * advertises it via xenstore as 0 (disabled) or 1 (enabled).
+ *
+ * To make use of this feature, frontend should allocate two event
+ * channels for TX and RX, advertise them to backend as
+ * "event-channel-tx" and "event-channel-rx" respectively. If frontend
+ * doesn't want to use this feature, it just writes "event-channel"
+ * node as before.
+ */
+
+/*
+ * Multiple transmit and receive queues:
+ * If supported, the backend will write the key "multi-queue-max-queues" to
+ * the directory for that vif, and set its value to the maximum supported
+ * number of queues.
+ * Frontends that are aware of this feature and wish to use it can write the
+ * key "multi-queue-num-queues", set to the number they wish to use, which
+ * must be greater than zero, and no more than the value reported by the backend
+ * in "multi-queue-max-queues".
+ *
+ * Queues replicate the shared rings and event channels.
+ * "feature-split-event-channels" may optionally be used when using
+ * multiple queues, but is not mandatory.
+ *
+ * Each queue consists of one shared ring pair, i.e. there must be the same
+ * number of tx and rx rings.
+ *
+ * For frontends requesting just one queue, the usual event-channel and
+ * ring-ref keys are written as before, simplifying the backend processing
+ * to avoid distinguishing between a frontend that doesn't understand the
+ * multi-queue feature, and one that does, but requested only one queue.
+ *
+ * Frontends requesting two or more queues must not write the toplevel
+ * event-channel (or event-channel-{tx,rx}) and {tx,rx}-ring-ref keys,
+ * instead writing those keys under sub-keys having the name "queue-N" where
+ * N is the integer ID of the queue for which those keys belong. Queues
+ * are indexed from zero. For example, a frontend with two queues and split
+ * event channels must write the following set of queue-related keys:
+ *
+ * /local/domain/1/device/vif/0/multi-queue-num-queues = "2"
+ * /local/domain/1/device/vif/0/queue-0 = ""
+ * /local/domain/1/device/vif/0/queue-0/tx-ring-ref = "<ring-ref-tx0>"
+ * /local/domain/1/device/vif/0/queue-0/rx-ring-ref = "<ring-ref-rx0>"
+ * /local/domain/1/device/vif/0/queue-0/event-channel-tx = "<evtchn-tx0>"
+ * /local/domain/1/device/vif/0/queue-0/event-channel-rx = "<evtchn-rx0>"
+ * /local/domain/1/device/vif/0/queue-1 = ""
+ * /local/domain/1/device/vif/0/queue-1/tx-ring-ref = "<ring-ref-tx1>"
+ * /local/domain/1/device/vif/0/queue-1/rx-ring-ref = "<ring-ref-rx1"
+ * /local/domain/1/device/vif/0/queue-1/event-channel-tx = "<evtchn-tx1>"
+ * /local/domain/1/device/vif/0/queue-1/event-channel-rx = "<evtchn-rx1>"
+ *
+ * If there is any inconsistency in the XenStore data, the backend may
+ * choose not to connect any queues, instead treating the request as an
+ * error. This includes scenarios where more (or fewer) queues were
+ * requested than the frontend provided details for.
+ *
+ * Mapping of packets to queues is considered to be a function of the
+ * transmitting system (backend or frontend) and is not negotiated
+ * between the two. Guests are free to transmit packets on any queue
+ * they choose, provided it has been set up correctly. Guests must be
+ * prepared to receive packets on any queue they have requested be set up.
+ */
+
+/*
+ * "feature-no-csum-offload" should be used to turn IPv4 TCP/UDP checksum
+ * offload off or on. If it is missing then the feature is assumed to be on.
+ * "feature-ipv6-csum-offload" should be used to turn IPv6 TCP/UDP checksum
+ * offload on or off. If it is missing then the feature is assumed to be off.
+ */
+
+/*
+ * "feature-gso-tcpv4" and "feature-gso-tcpv6" advertise the capability to
+ * handle large TCP packets (in IPv4 or IPv6 form respectively). Neither
+ * frontends nor backends are assumed to be capable unless the flags are
+ * present.
+ */
+
+/*
+ * "feature-multicast-control" and "feature-dynamic-multicast-control"
+ * advertise the capability to filter ethernet multicast packets in the
+ * backend. If the frontend wishes to take advantage of this feature then
+ * it may set "request-multicast-control". If the backend only advertises
+ * "feature-multicast-control" then "request-multicast-control" must be set
+ * before the frontend moves into the connected state. The backend will
+ * sample the value on this state transition and any subsequent change in
+ * value will have no effect. However, if the backend also advertises
+ * "feature-dynamic-multicast-control" then "request-multicast-control"
+ * may be set by the frontend at any time. In this case, the backend will
+ * watch the value and re-sample on watch events.
+ *
+ * If the sampled value of "request-multicast-control" is set then the
+ * backend transmit side should no longer flood multicast packets to the
+ * frontend, it should instead drop any multicast packet that does not
+ * match in a filter list.
+ * The list is amended by the frontend by sending dummy transmit requests
+ * containing XEN_NETIF_EXTRA_TYPE_MCAST_{ADD,DEL} extra-info fragments as
+ * specified below.
+ * Note that the filter list may be amended even if the sampled value of
+ * "request-multicast-control" is not set, however the filter should only
+ * be applied if it is set.
+ */
+
+/*
+ * Control ring
+ * ============
+ *
+ * Some features, such as hashing (detailed below), require a
+ * significant amount of out-of-band data to be passed from frontend to
+ * backend. Use of xenstore is not suitable for large quantities of data
+ * because of quota limitations and so a dedicated 'control ring' is used.
+ * The ability of the backend to use a control ring is advertised by
+ * setting:
+ *
+ * /local/domain/X/backend/<domid>/<vif>/feature-ctrl-ring = "1"
+ *
+ * The frontend provides a control ring to the backend by setting:
+ *
+ * /local/domain/<domid>/device/vif/<vif>/ctrl-ring-ref = <gref>
+ * /local/domain/<domid>/device/vif/<vif>/event-channel-ctrl = <port>
+ *
+ * where <gref> is the grant reference of the shared page used to
+ * implement the control ring and <port> is an event channel to be used
+ * as a mailbox interrupt. These keys must be set before the frontend
+ * moves into the connected state.
+ *
+ * The control ring uses a fixed request/response message size and is
+ * balanced (i.e. one request to one response), so operationally it is much
+ * the same as a transmit or receive ring.
+ * Note that there is no requirement that responses are issued in the same
+ * order as requests.
+ */
+
+/*
+ * Hash types
+ * ==========
+ *
+ * For the purposes of the definitions below, 'Packet[]' is an array of
+ * octets containing an IP packet without options, 'Array[X..Y]' means a
+ * sub-array of 'Array' containing bytes X thru Y inclusive, and '+' is
+ * used to indicate concatenation of arrays.
+ */
+
+/*
+ * A hash calculated over an IP version 4 header as follows:
+ *
+ * Buffer[0..8] = Packet[12..15] (source address) +
+ *                Packet[16..19] (destination address)
+ *
+ * Result = Hash(Buffer, 8)
+ */
+#define _XEN_NETIF_CTRL_HASH_TYPE_IPV4 0
+#define XEN_NETIF_CTRL_HASH_TYPE_IPV4 \
+    (1 << _XEN_NETIF_CTRL_HASH_TYPE_IPV4)
+
+/*
+ * A hash calculated over an IP version 4 header and TCP header as
+ * follows:
+ *
+ * Buffer[0..12] = Packet[12..15] (source address) +
+ *                 Packet[16..19] (destination address) +
+ *                 Packet[20..21] (source port) +
+ *                 Packet[22..23] (destination port)
+ *
+ * Result = Hash(Buffer, 12)
+ */
+#define _XEN_NETIF_CTRL_HASH_TYPE_IPV4_TCP 1
+#define XEN_NETIF_CTRL_HASH_TYPE_IPV4_TCP \
+    (1 << _XEN_NETIF_CTRL_HASH_TYPE_IPV4_TCP)
+
+/*
+ * A hash calculated over an IP version 6 header as follows:
+ *
+ * Buffer[0..32] = Packet[8..23]  (source address ) +
+ *                 Packet[24..39] (destination address)
+ *
+ * Result = Hash(Buffer, 32)
+ */
+#define _XEN_NETIF_CTRL_HASH_TYPE_IPV6 2
+#define XEN_NETIF_CTRL_HASH_TYPE_IPV6 \
+    (1 << _XEN_NETIF_CTRL_HASH_TYPE_IPV6)
+
+/*
+ * A hash calculated over an IP version 6 header and TCP header as
+ * follows:
+ *
+ * Buffer[0..36] = Packet[8..23]  (source address) +
+ *                 Packet[24..39] (destination address) +
+ *                 Packet[40..41] (source port) +
+ *                 Packet[42..43] (destination port)
+ *
+ * Result = Hash(Buffer, 36)
+ */
+#define _XEN_NETIF_CTRL_HASH_TYPE_IPV6_TCP 3
+#define XEN_NETIF_CTRL_HASH_TYPE_IPV6_TCP \
+    (1 << _XEN_NETIF_CTRL_HASH_TYPE_IPV6_TCP)
+
+/*
+ * Hash algorithms
+ * ===============
+ */
+
+#define XEN_NETIF_CTRL_HASH_ALGORITHM_NONE 0
+
+/*
+ * Toeplitz hash:
+ */
+
+#define XEN_NETIF_CTRL_HASH_ALGORITHM_TOEPLITZ 1
+
+/*
+ * Control requests (struct xen_netif_ctrl_request)
+ * ================================================
+ *
+ * All requests have the following format:
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * |    id     |   type    |         data[0]       |
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * |         data[1]       |         data[2]       |
+ * +-----+-----+-----+-----+-----------------------+
+ *
+ * id: the request identifier, echoed in response.
+ * type: the type of request (see below)
+ * data[]: any data associated with the request (determined by type)
+ */
+
+struct xen_netif_ctrl_request {
+    uint16_t id;
+    uint16_t type;
+
+#define XEN_NETIF_CTRL_TYPE_INVALID               0
+#define XEN_NETIF_CTRL_TYPE_GET_HASH_FLAGS        1
+#define XEN_NETIF_CTRL_TYPE_SET_HASH_FLAGS        2
+#define XEN_NETIF_CTRL_TYPE_SET_HASH_KEY          3
+#define XEN_NETIF_CTRL_TYPE_GET_HASH_MAPPING_SIZE 4
+#define XEN_NETIF_CTRL_TYPE_SET_HASH_MAPPING_SIZE 5
+#define XEN_NETIF_CTRL_TYPE_SET_HASH_MAPPING      6
+#define XEN_NETIF_CTRL_TYPE_SET_HASH_ALGORITHM    7
+#define XEN_NETIF_CTRL_TYPE_GET_GREF_MAPPING_SIZE 8
+#define XEN_NETIF_CTRL_TYPE_ADD_GREF_MAPPING      9
+#define XEN_NETIF_CTRL_TYPE_DEL_GREF_MAPPING     10
+
+    uint32_t data[3];
+};
+
+/*
+ * Control responses (struct xen_netif_ctrl_response)
+ * ==================================================
+ *
+ * All responses have the following format:
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * |    id     |   type    |         status        |
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * |         data          |
+ * +-----+-----+-----+-----+
+ *
+ * id: the corresponding request identifier
+ * type: the type of the corresponding request
+ * status: the status of request processing
+ * data: any data associated with the response (determined by type and
+ *       status)
+ */
+
+struct xen_netif_ctrl_response {
+    uint16_t id;
+    uint16_t type;
+    uint32_t status;
+
+#define XEN_NETIF_CTRL_STATUS_SUCCESS           0
+#define XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED     1
+#define XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER 2
+#define XEN_NETIF_CTRL_STATUS_BUFFER_OVERFLOW   3
+
+    uint32_t data;
+};
+
+/*
+ * Static Grants (struct xen_netif_gref)
+ * =====================================
+ *
+ * A frontend may provide a fixed set of grant references to be mapped on
+ * the backend. The message of type XEN_NETIF_CTRL_TYPE_ADD_GREF_MAPPING
+ * prior its usage in the command ring allows for creation of these mappings.
+ * The backend will maintain a fixed amount of these mappings.
+ *
+ * XEN_NETIF_CTRL_TYPE_GET_GREF_MAPPING_SIZE lets a frontend query how many
+ * of these mappings can be kept.
+ *
+ * Each entry in the XEN_NETIF_CTRL_TYPE_{ADD,DEL}_GREF_MAPPING input table has
+ * the following format:
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * | grant ref             |  flags    |  status   |
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ *
+ * grant ref: grant reference (IN)
+ * flags: flags describing the control operation (IN)
+ * status: XEN_NETIF_CTRL_STATUS_* (OUT)
+ *
+ * 'status' is an output parameter which does not require to be set to zero
+ * prior to its usage in the corresponding control messages.
+ */
+
+struct xen_netif_gref {
+       grant_ref_t ref;
+       uint16_t flags;
+
+#define _XEN_NETIF_CTRLF_GREF_readonly    0
+#define XEN_NETIF_CTRLF_GREF_readonly    (1U<<_XEN_NETIF_CTRLF_GREF_readonly)
+
+       uint16_t status;
+};
+
+/*
+ * Control messages
+ * ================
+ *
+ * XEN_NETIF_CTRL_TYPE_SET_HASH_ALGORITHM
+ * --------------------------------------
+ *
+ * This is sent by the frontend to set the desired hash algorithm.
+ *
+ * Request:
+ *
+ *  type    = XEN_NETIF_CTRL_TYPE_SET_HASH_ALGORITHM
+ *  data[0] = a XEN_NETIF_CTRL_HASH_ALGORITHM_* value
+ *  data[1] = 0
+ *  data[2] = 0
+ *
+ * Response:
+ *
+ *  status = XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED     - Operation not
+ *                                                     supported
+ *           XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER - The algorithm is not
+ *                                                     supported
+ *           XEN_NETIF_CTRL_STATUS_SUCCESS           - Operation successful
+ *
+ * NOTE: Setting data[0] to XEN_NETIF_CTRL_HASH_ALGORITHM_NONE disables
+ *       hashing and the backend is free to choose how it steers packets
+ *       to queues (which is the default behaviour).
+ *
+ * XEN_NETIF_CTRL_TYPE_GET_HASH_FLAGS
+ * ----------------------------------
+ *
+ * This is sent by the frontend to query the types of hash supported by
+ * the backend.
+ *
+ * Request:
+ *
+ *  type    = XEN_NETIF_CTRL_TYPE_GET_HASH_FLAGS
+ *  data[0] = 0
+ *  data[1] = 0
+ *  data[2] = 0
+ *
+ * Response:
+ *
+ *  status = XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED - Operation not supported
+ *           XEN_NETIF_CTRL_STATUS_SUCCESS       - Operation successful
+ *  data   = supported hash types (if operation was successful)
+ *
+ * NOTE: A valid hash algorithm must be selected before this operation can
+ *       succeed.
+ *
+ * XEN_NETIF_CTRL_TYPE_SET_HASH_FLAGS
+ * ----------------------------------
+ *
+ * This is sent by the frontend to set the types of hash that the backend
+ * should calculate. (See above for hash type definitions).
+ * Note that the 'maximal' type of hash should always be chosen. For
+ * example, if the frontend sets both IPV4 and IPV4_TCP hash types then
+ * the latter hash type should be calculated for any TCP packet and the
+ * former only calculated for non-TCP packets.
+ *
+ * Request:
+ *
+ *  type    = XEN_NETIF_CTRL_TYPE_SET_HASH_FLAGS
+ *  data[0] = bitwise OR of XEN_NETIF_CTRL_HASH_TYPE_* values
+ *  data[1] = 0
+ *  data[2] = 0
+ *
+ * Response:
+ *
+ *  status = XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED     - Operation not
+ *                                                     supported
+ *           XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER - One or more flag
+ *                                                     value is invalid or
+ *                                                     unsupported
+ *           XEN_NETIF_CTRL_STATUS_SUCCESS           - Operation successful
+ *  data   = 0
+ *
+ * NOTE: A valid hash algorithm must be selected before this operation can
+ *       succeed.
+ *       Also, setting data[0] to zero disables hashing and the backend
+ *       is free to choose how it steers packets to queues.
+ *
+ * XEN_NETIF_CTRL_TYPE_SET_HASH_KEY
+ * --------------------------------
+ *
+ * This is sent by the frontend to set the key of the hash if the algorithm
+ * requires it. (See hash algorithms above).
+ *
+ * Request:
+ *
+ *  type    = XEN_NETIF_CTRL_TYPE_SET_HASH_KEY
+ *  data[0] = grant reference of page containing the key (assumed to
+ *            start at beginning of grant)
+ *  data[1] = size of key in octets
+ *  data[2] = 0
+ *
+ * Response:
+ *
+ *  status = XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED     - Operation not
+ *                                                     supported
+ *           XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER - Key size is invalid
+ *           XEN_NETIF_CTRL_STATUS_BUFFER_OVERFLOW   - Key size is larger
+ *                                                     than the backend
+ *                                                     supports
+ *           XEN_NETIF_CTRL_STATUS_SUCCESS           - Operation successful
+ *  data   = 0
+ *
+ * NOTE: Any key octets not specified are assumed to be zero (the key
+ *       is assumed to be empty by default) and specifying a new key
+ *       invalidates any previous key, hence specifying a key size of
+ *       zero will clear the key (which ensures that the calculated hash
+ *       will always be zero).
+ *       The maximum size of key is algorithm and backend specific, but
+ *       is also limited by the single grant reference.
+ *       The grant reference may be read-only and must remain valid until
+ *       the response has been processed.
+ *
+ * XEN_NETIF_CTRL_TYPE_GET_HASH_MAPPING_SIZE
+ * -----------------------------------------
+ *
+ * This is sent by the frontend to query the maximum size of mapping
+ * table supported by the backend. The size is specified in terms of
+ * table entries.
+ *
+ * Request:
+ *
+ *  type    = XEN_NETIF_CTRL_TYPE_GET_HASH_MAPPING_SIZE
+ *  data[0] = 0
+ *  data[1] = 0
+ *  data[2] = 0
+ *
+ * Response:
+ *
+ *  status = XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED - Operation not supported
+ *           XEN_NETIF_CTRL_STATUS_SUCCESS       - Operation successful
+ *  data   = maximum number of entries allowed in the mapping table
+ *           (if operation was successful) or zero if a mapping table is
+ *           not supported (i.e. hash mapping is done only by modular
+ *           arithmetic).
+ *
+ * XEN_NETIF_CTRL_TYPE_SET_HASH_MAPPING_SIZE
+ * -------------------------------------
+ *
+ * This is sent by the frontend to set the actual size of the mapping
+ * table to be used by the backend. The size is specified in terms of
+ * table entries.
+ * Any previous table is invalidated by this message and any new table
+ * is assumed to be zero filled.
+ *
+ * Request:
+ *
+ *  type    = XEN_NETIF_CTRL_TYPE_SET_HASH_MAPPING_SIZE
+ *  data[0] = number of entries in mapping table
+ *  data[1] = 0
+ *  data[2] = 0
+ *
+ * Response:
+ *
+ *  status = XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED     - Operation not
+ *                                                     supported
+ *           XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER - Table size is invalid
+ *           XEN_NETIF_CTRL_STATUS_SUCCESS           - Operation successful
+ *  data   = 0
+ *
+ * NOTE: Setting data[0] to 0 means that hash mapping should be done
+ *       using modular arithmetic.
+ *
+ * XEN_NETIF_CTRL_TYPE_SET_HASH_MAPPING
+ * ------------------------------------
+ *
+ * This is sent by the frontend to set the content of the table mapping
+ * hash value to queue number. The backend should calculate the hash from
+ * the packet header, use it as an index into the table (modulo the size
+ * of the table) and then steer the packet to the queue number found at
+ * that index.
+ *
+ * Request:
+ *
+ *  type    = XEN_NETIF_CTRL_TYPE_SET_HASH_MAPPING
+ *  data[0] = grant reference of page containing the mapping (sub-)table
+ *            (assumed to start at beginning of grant)
+ *  data[1] = size of (sub-)table in entries
+ *  data[2] = offset, in entries, of sub-table within overall table
+ *
+ * Response:
+ *
+ *  status = XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED     - Operation not
+ *                                                     supported
+ *           XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER - Table size or content
+ *                                                     is invalid
+ *           XEN_NETIF_CTRL_STATUS_BUFFER_OVERFLOW   - Table size is larger
+ *                                                     than the backend
+ *                                                     supports
+ *           XEN_NETIF_CTRL_STATUS_SUCCESS           - Operation successful
+ *  data   = 0
+ *
+ * NOTE: The overall table has the following format:
+ *
+ *          0     1     2     3     4     5     6     7  octet
+ *       +-----+-----+-----+-----+-----+-----+-----+-----+
+ *       |       mapping[0]      |       mapping[1]      |
+ *       +-----+-----+-----+-----+-----+-----+-----+-----+
+ *       |                       .                       |
+ *       |                       .                       |
+ *       |                       .                       |
+ *       +-----+-----+-----+-----+-----+-----+-----+-----+
+ *       |      mapping[N-2]     |      mapping[N-1]     |
+ *       +-----+-----+-----+-----+-----+-----+-----+-----+
+ *
+ *       where N is specified by a XEN_NETIF_CTRL_TYPE_SET_HASH_MAPPING_SIZE
+ *       message and each  mapping must specifies a queue between 0 and
+ *       "multi-queue-num-queues" (see above).
+ *       The backend may support a mapping table larger than can be
+ *       mapped by a single grant reference. Thus sub-tables within a
+ *       larger table can be individually set by sending multiple messages
+ *       with differing offset values. Specifying a new sub-table does not
+ *       invalidate any table data outside that range.
+ *       The grant reference may be read-only and must remain valid until
+ *       the response has been processed.
+ *
+ * XEN_NETIF_CTRL_TYPE_GET_GREF_MAPPING_SIZE
+ * -----------------------------------------
+ *
+ * This is sent by the frontend to fetch the number of grefs that can be kept
+ * mapped in the backend.
+ *
+ * Request:
+ *
+ *  type    = XEN_NETIF_CTRL_TYPE_GET_GREF_MAPPING_SIZE
+ *  data[0] = queue index (assumed 0 for single queue)
+ *  data[1] = 0
+ *  data[2] = 0
+ *
+ * Response:
+ *
+ *  status = XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED     - Operation not
+ *                                                     supported
+ *           XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER - The queue index is
+ *                                                     out of range
+ *           XEN_NETIF_CTRL_STATUS_SUCCESS           - Operation successful
+ *  data   = maximum number of entries allowed in the gref mapping table
+ *           (if operation was successful) or zero if it is not supported.
+ *
+ * XEN_NETIF_CTRL_TYPE_ADD_GREF_MAPPING
+ * ------------------------------------
+ *
+ * This is sent by the frontend for backend to map a list of grant
+ * references.
+ *
+ * Request:
+ *
+ *  type    = XEN_NETIF_CTRL_TYPE_ADD_GREF_MAPPING
+ *  data[0] = queue index
+ *  data[1] = grant reference of page containing the mapping list
+ *            (r/w and assumed to start at beginning of page)
+ *  data[2] = size of list in entries
+ *
+ * Response:
+ *
+ *  status = XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED     - Operation not
+ *                                                     supported
+ *           XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER - Operation failed
+ *           XEN_NETIF_CTRL_STATUS_SUCCESS           - Operation successful
+ *
+ * NOTE: Each entry in the input table has the format outlined
+ *       in struct xen_netif_gref.
+ *       Contrary to XEN_NETIF_CTRL_TYPE_DEL_GREF_MAPPING, the struct
+ *       xen_netif_gref 'status' field is not used and therefore the response
+ *       'status' determines the success of this operation. In case of
+ *       failure none of grants mappings get added in the backend.
+ *
+ * XEN_NETIF_CTRL_TYPE_DEL_GREF_MAPPING
+ * ------------------------------------
+ *
+ * This is sent by the frontend for backend to unmap a list of grant
+ * references.
+ *
+ * Request:
+ *
+ *  type    = XEN_NETIF_CTRL_TYPE_DEL_GREF_MAPPING
+ *  data[0] = queue index
+ *  data[1] = grant reference of page containing the mapping list
+ *            (r/w and assumed to start at beginning of page)
+ *  data[2] = size of list in entries
+ *
+ * Response:
+ *
+ *  status = XEN_NETIF_CTRL_STATUS_NOT_SUPPORTED     - Operation not
+ *                                                     supported
+ *           XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER - Operation failed
+ *           XEN_NETIF_CTRL_STATUS_SUCCESS           - Operation successful
+ *  data   = number of entries that were unmapped
+ *
+ * NOTE: Each entry in the input table has the format outlined in struct
+ *       xen_netif_gref.
+ *       The struct xen_netif_gref 'status' field determines if the entry
+ *       was successfully removed.
+ *       The entries used are only the ones representing grant references that
+ *       were previously the subject of a XEN_NETIF_CTRL_TYPE_ADD_GREF_MAPPING
+ *       operation. Any other entries will have their status set to
+ *       XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER upon completion.
+ */
+
+DEFINE_RING_TYPES(xen_netif_ctrl,
+                  struct xen_netif_ctrl_request,
+                  struct xen_netif_ctrl_response);
+
+/*
+ * Guest transmit
+ * ==============
+ *
+ * This is the 'wire' format for transmit (frontend -> backend) packets:
+ *
+ *  Fragment 1: netif_tx_request_t  - flags = NETTXF_*
+ *                                    size = total packet size
+ * [Extra 1: netif_extra_info_t]    - (only if fragment 1 flags include
+ *                                     NETTXF_extra_info)
+ *  ...
+ * [Extra N: netif_extra_info_t]    - (only if extra N-1 flags include
+ *                                     XEN_NETIF_EXTRA_MORE)
+ *  ...
+ *  Fragment N: netif_tx_request_t  - (only if fragment N-1 flags include
+ *                                     NETTXF_more_data - flags on preceding
+ *                                     extras are not relevant here)
+ *                                    flags = 0
+ *                                    size = fragment size
+ *
+ * NOTE:
+ *
+ * This format slightly is different from that used for receive
+ * (backend -> frontend) packets. Specifically, in a multi-fragment
+ * packet the actual size of fragment 1 can only be determined by
+ * subtracting the sizes of fragments 2..N from the total packet size.
+ *
+ * Ring slot size is 12 octets, however not all request/response
+ * structs use the full size.
+ *
+ * tx request data (netif_tx_request_t)
+ * ------------------------------------
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * | grant ref             | offset    | flags     |
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * | id        | size      |
+ * +-----+-----+-----+-----+
+ *
+ * grant ref: Reference to buffer page.
+ * offset: Offset within buffer page.
+ * flags: NETTXF_*.
+ * id: request identifier, echoed in response.
+ * size: packet size in bytes.
+ *
+ * tx response (netif_tx_response_t)
+ * ---------------------------------
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * | id        | status    | unused                |
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * | unused                |
+ * +-----+-----+-----+-----+
+ *
+ * id: reflects id in transmit request
+ * status: NETIF_RSP_*
+ *
+ * Guest receive
+ * =============
+ *
+ * This is the 'wire' format for receive (backend -> frontend) packets:
+ *
+ *  Fragment 1: netif_rx_request_t  - flags = NETRXF_*
+ *                                    size = fragment size
+ * [Extra 1: netif_extra_info_t]    - (only if fragment 1 flags include
+ *                                     NETRXF_extra_info)
+ *  ...
+ * [Extra N: netif_extra_info_t]    - (only if extra N-1 flags include
+ *                                     XEN_NETIF_EXTRA_MORE)
+ *  ...
+ *  Fragment N: netif_rx_request_t  - (only if fragment N-1 flags include
+ *                                     NETRXF_more_data - flags on preceding
+ *                                     extras are not relevant here)
+ *                                    flags = 0
+ *                                    size = fragment size
+ *
+ * NOTE:
+ *
+ * This format slightly is different from that used for transmit
+ * (frontend -> backend) packets. Specifically, in a multi-fragment
+ * packet the size of the packet can only be determined by summing the
+ * sizes of fragments 1..N.
+ *
+ * Ring slot size is 8 octets.
+ *
+ * rx request (netif_rx_request_t)
+ * -------------------------------
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * | id        | pad       | gref                  |
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ *
+ * id: request identifier, echoed in response.
+ * gref: reference to incoming granted frame.
+ *
+ * rx response (netif_rx_response_t)
+ * ---------------------------------
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * | id        | offset    | flags     | status    |
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ *
+ * id: reflects id in receive request
+ * offset: offset in page of start of received packet
+ * flags: NETRXF_*
+ * status: -ve: NETIF_RSP_*; +ve: Rx'ed pkt size.
+ *
+ * NOTE: Historically, to support GSO on the frontend receive side, Linux
+ *       netfront does not make use of the rx response id (because, as
+ *       described below, extra info structures overlay the id field).
+ *       Instead it assumes that responses always appear in the same ring
+ *       slot as their corresponding request. Thus, to maintain
+ *       compatibility, backends must make sure this is the case.
+ *
+ * Extra Info
+ * ==========
+ *
+ * Can be present if initial request or response has NET{T,R}XF_extra_info,
+ * or previous extra request has XEN_NETIF_EXTRA_MORE.
+ *
+ * The struct therefore needs to fit into either a tx or rx slot and
+ * is therefore limited to 8 octets.
+ *
+ * NOTE: Because extra info data overlays the usual request/response
+ *       structures, there is no id information in the opposite direction.
+ *       So, if an extra info overlays an rx response the frontend can
+ *       assume that it is in the same ring slot as the request that was
+ *       consumed to make the slot available, and the backend must ensure
+ *       this assumption is true.
+ *
+ * extra info (netif_extra_info_t)
+ * -------------------------------
+ *
+ * General format:
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * |type |flags| type specific data                |
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * | padding for tx        |
+ * +-----+-----+-----+-----+
+ *
+ * type: XEN_NETIF_EXTRA_TYPE_*
+ * flags: XEN_NETIF_EXTRA_FLAG_*
+ * padding for tx: present only in the tx case due to 8 octet limit
+ *                 from rx case. Not shown in type specific entries
+ *                 below.
+ *
+ * XEN_NETIF_EXTRA_TYPE_GSO:
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * |type |flags| size      |type | pad | features  |
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ *
+ * type: Must be XEN_NETIF_EXTRA_TYPE_GSO
+ * flags: XEN_NETIF_EXTRA_FLAG_*
+ * size: Maximum payload size of each segment. For example,
+ *       for TCP this is just the path MSS.
+ * type: XEN_NETIF_GSO_TYPE_*: This determines the protocol of
+ *       the packet and any extra features required to segment the
+ *       packet properly.
+ * features: EN_NETIF_GSO_FEAT_*: This specifies any extra GSO
+ *           features required to process this packet, such as ECN
+ *           support for TCPv4.
+ *
+ * XEN_NETIF_EXTRA_TYPE_MCAST_{ADD,DEL}:
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * |type |flags| addr                              |
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ *
+ * type: Must be XEN_NETIF_EXTRA_TYPE_MCAST_{ADD,DEL}
+ * flags: XEN_NETIF_EXTRA_FLAG_*
+ * addr: address to add/remove
+ *
+ * XEN_NETIF_EXTRA_TYPE_HASH:
+ *
+ * A backend that supports teoplitz hashing is assumed to accept
+ * this type of extra info in transmit packets.
+ * A frontend that enables hashing is assumed to accept
+ * this type of extra info in receive packets.
+ *
+ *    0     1     2     3     4     5     6     7  octet
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ * |type |flags|htype| alg |LSB ---- value ---- MSB|
+ * +-----+-----+-----+-----+-----+-----+-----+-----+
+ *
+ * type: Must be XEN_NETIF_EXTRA_TYPE_HASH
+ * flags: XEN_NETIF_EXTRA_FLAG_*
+ * htype: Hash type (one of _XEN_NETIF_CTRL_HASH_TYPE_* - see above)
+ * alg: The algorithm used to calculate the hash (one of
+ *      XEN_NETIF_CTRL_HASH_TYPE_ALGORITHM_* - see above)
+ * value: Hash value
+ */
+
+/* Protocol checksum field is blank in the packet (hardware offload)? */
+#define _NETTXF_csum_blank     (0)
+#define  NETTXF_csum_blank     (1U<<_NETTXF_csum_blank)
+
+/* Packet data has been validated against protocol checksum. */
+#define _NETTXF_data_validated (1)
+#define  NETTXF_data_validated (1U<<_NETTXF_data_validated)
+
+/* Packet continues in the next request descriptor. */
+#define _NETTXF_more_data      (2)
+#define  NETTXF_more_data      (1U<<_NETTXF_more_data)
+
+/* Packet to be followed by extra descriptor(s). */
+#define _NETTXF_extra_info     (3)
+#define  NETTXF_extra_info     (1U<<_NETTXF_extra_info)
+
+#define XEN_NETIF_MAX_TX_SIZE 0xFFFF
+struct netif_tx_request {
+    grant_ref_t gref;
+    uint16_t offset;
+    uint16_t flags;
+    uint16_t id;
+    uint16_t size;
+};
+typedef struct netif_tx_request netif_tx_request_t;
+
+/* Types of netif_extra_info descriptors. */
+#define XEN_NETIF_EXTRA_TYPE_NONE      (0)  /* Never used - invalid */
+#define XEN_NETIF_EXTRA_TYPE_GSO       (1)  /* u.gso */
+#define XEN_NETIF_EXTRA_TYPE_MCAST_ADD (2)  /* u.mcast */
+#define XEN_NETIF_EXTRA_TYPE_MCAST_DEL (3)  /* u.mcast */
+#define XEN_NETIF_EXTRA_TYPE_HASH      (4)  /* u.hash */
+#define XEN_NETIF_EXTRA_TYPE_MAX       (5)
+
+/* netif_extra_info_t flags. */
+#define _XEN_NETIF_EXTRA_FLAG_MORE (0)
+#define XEN_NETIF_EXTRA_FLAG_MORE  (1U<<_XEN_NETIF_EXTRA_FLAG_MORE)
+
+/* GSO types */
+#define XEN_NETIF_GSO_TYPE_NONE         (0)
+#define XEN_NETIF_GSO_TYPE_TCPV4        (1)
+#define XEN_NETIF_GSO_TYPE_TCPV6        (2)
+
+/*
+ * This structure needs to fit within both netif_tx_request_t and
+ * netif_rx_response_t for compatibility.
+ */
+struct netif_extra_info {
+    uint8_t type;
+    uint8_t flags;
+    union {
+        struct {
+            uint16_t size;
+            uint8_t type;
+            uint8_t pad;
+            uint16_t features;
+        } gso;
+        struct {
+            uint8_t addr[6];
+        } mcast;
+        struct {
+            uint8_t type;
+            uint8_t algorithm;
+            uint8_t value[4];
+        } hash;
+        uint16_t pad[3];
+    } u;
+};
+typedef struct netif_extra_info netif_extra_info_t;
+
+struct netif_tx_response {
+    uint16_t id;
+    int16_t  status;
+};
+typedef struct netif_tx_response netif_tx_response_t;
+
+struct netif_rx_request {
+    uint16_t    id;        /* Echoed in response message.        */
+    uint16_t    pad;
+    grant_ref_t gref;
+};
+typedef struct netif_rx_request netif_rx_request_t;
+
+/* Packet data has been validated against protocol checksum. */
+#define _NETRXF_data_validated (0)
+#define  NETRXF_data_validated (1U<<_NETRXF_data_validated)
+
+/* Protocol checksum field is blank in the packet (hardware offload)? */
+#define _NETRXF_csum_blank     (1)
+#define  NETRXF_csum_blank     (1U<<_NETRXF_csum_blank)
+
+/* Packet continues in the next request descriptor. */
+#define _NETRXF_more_data      (2)
+#define  NETRXF_more_data      (1U<<_NETRXF_more_data)
+
+/* Packet to be followed by extra descriptor(s). */
+#define _NETRXF_extra_info     (3)
+#define  NETRXF_extra_info     (1U<<_NETRXF_extra_info)
+
+/* Packet has GSO prefix. Deprecated but included for compatibility */
+#define _NETRXF_gso_prefix     (4)
+#define  NETRXF_gso_prefix     (1U<<_NETRXF_gso_prefix)
+
+struct netif_rx_response {
+    uint16_t id;
+    uint16_t offset;
+    uint16_t flags;
+    int16_t  status;
+};
+typedef struct netif_rx_response netif_rx_response_t;
+
+/*
+ * Generate netif ring structures and types.
+ */
+
+DEFINE_RING_TYPES(netif_tx, struct netif_tx_request, struct netif_tx_response);
+DEFINE_RING_TYPES(netif_rx, struct netif_rx_request, struct netif_rx_response);
+
+#define NETIF_RSP_DROPPED         -2
+#define NETIF_RSP_ERROR           -1
+#define NETIF_RSP_OKAY             0
+/* No response: used for auxiliary requests (e.g., netif_extra_info_t). */
+#define NETIF_RSP_NULL             1
+
+#endif
diff --git a/include/hw/xen/interface/io/protocols.h b/include/hw/xen/interface/io/protocols.h
new file mode 100644
index 0000000000..3d1cac322b
--- /dev/null
+++ b/include/hw/xen/interface/io/protocols.h
@@ -0,0 +1,42 @@
+/******************************************************************************
+ * protocols.h
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * Copyright (c) 2008, Keir Fraser
+ */
+
+#ifndef XEN_PROTOCOLS_H
+#define XEN_PROTOCOLS_H
+
+#define XEN_IO_PROTO_ABI_X86_32     "x86_32-abi"
+#define XEN_IO_PROTO_ABI_X86_64     "x86_64-abi"
+#define XEN_IO_PROTO_ABI_ARM        "arm-abi"
+
+#if defined(__i386__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_X86_32
+#elif defined(__x86_64__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_X86_64
+#elif defined(__arm__) || defined(__aarch64__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_ARM
+#else
+# error arch fixup needed here
+#endif
+
+#endif
diff --git a/include/hw/xen/interface/io/xenbus.h b/include/hw/xen/interface/io/xenbus.h
new file mode 100644
index 0000000000..13d26c51cd
--- /dev/null
+++ b/include/hw/xen/interface/io/xenbus.h
@@ -0,0 +1,70 @@
+/*****************************************************************************
+ * xenbus.h
+ *
+ * Xenbus protocol details.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * Copyright (C) 2005 XenSource Ltd.
+ */
+
+#ifndef XEN_PUBLIC_IO_XENBUS_H
+#define XEN_PUBLIC_IO_XENBUS_H
+
+/*
+ * The state of either end of the Xenbus, i.e. the current communication
+ * status of initialisation across the bus.  States here imply nothing about
+ * the state of the connection between the driver and the kernel's device
+ * layers.
+ */
+enum xenbus_state {
+    XenbusStateUnknown       = 0,
+
+    XenbusStateInitialising  = 1,
+
+    /*
+     * InitWait: Finished early initialisation but waiting for information
+     * from the peer or hotplug scripts.
+     */
+    XenbusStateInitWait      = 2,
+
+    /*
+     * Initialised: Waiting for a connection from the peer.
+     */
+    XenbusStateInitialised   = 3,
+
+    XenbusStateConnected     = 4,
+
+    /*
+     * Closing: The device is being closed due to an error or an unplug event.
+     */
+    XenbusStateClosing       = 5,
+
+    XenbusStateClosed        = 6,
+
+    /*
+     * Reconfiguring: The device is being reconfigured.
+     */
+    XenbusStateReconfiguring = 7,
+
+    XenbusStateReconfigured  = 8
+};
+typedef enum xenbus_state XenbusState;
+
+#endif /* XEN_PUBLIC_IO_XENBUS_H */
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 9a8155e172..0504b43659 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -12,7 +12,7 @@
 
 #include <xenctrl.h>
 #include <xenstore.h>
-#include <xen/io/xenbus.h>
+#include "hw/xen/interface/io/xenbus.h"
 
 #include "hw/hw.h"
 #include "hw/xen/xen.h"
-- 
Anthony PERARD


