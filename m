Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A8BC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74A1208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74A1208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuaY-0005iq-17
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37610)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hctlE-0004Bj-NJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hctlC-0008Fa-Hw
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:32 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:62250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hctlB-00080c-FZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:30 -0400
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: IXojFbMSqXw6lWGKfl4NsqEIaGuUy1ic5SPVnQ7rhoRLAPslIvOJLnSfXxGiSE0CemPMroNhA7
 UmkbTItzsAKXtJPNhl3gfcLkF1GXvocV2Y+XybqU2CzN/iJ1tf0yggXo2RpV4KeMEjY8inHfk1
 H7kFwmUOwwYQGjqtVXrC5J/rgEQhZKZgQyMQgelmPfpbfVGauzmu+5kMkXBA6jDYUUS/6sgRO+
 oDq3KGkawLln0qdgggLaQZEcdTbbWzpUUemSFiqrLYNcBx9pmnVqBMVq4Te+OgfqO5pL5Cr1tm
 CX8=
X-SBRS: 2.7
X-MesageID: 1846109
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,385,1557201600"; 
   d="scan'208";a="1846109"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Mon, 17 Jun 2019 16:41:04 +0100
Message-ID: <20190617154105.32323-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617154105.32323-1-anthony.perard@citrix.com>
References: <20190617154105.32323-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: [Qemu-devel] [PATCH 3/4] xen: Import Xen public headers used by
 xen-hvm.c
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following "xen: Fix build with public headers", import other Xen
public headers that are describing interfaces.

The headers are cleaned up a bit while importing them. The header
guard symbols are changed to match QEMU's coding style, some other
part of the files that QEMU doesn't use are removed.

xen-mapcache.c doesn't needs params.h, so remove the include.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/xen/xen-hvm.c                 |   6 +-
 hw/i386/xen/xen-mapcache.c            |   2 -
 include/hw/xen/interface/hvm/e820.h   |  28 +++++++
 include/hw/xen/interface/hvm/ioreq.h  | 101 ++++++++++++++++++++++++++
 include/hw/xen/interface/hvm/params.h |  33 +++++++++
 5 files changed, 165 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/xen/interface/hvm/e820.h
 create mode 100644 include/hw/xen/interface/hvm/ioreq.h
 create mode 100644 include/hw/xen/interface/hvm/params.h

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 2939122e7c..725f9c2278 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -26,9 +26,9 @@
 #include "trace.h"
 #include "exec/address-spaces.h"
 
-#include <xen/hvm/ioreq.h>
-#include <xen/hvm/params.h>
-#include <xen/hvm/e820.h>
+#include "hw/xen/interface/hvm/ioreq.h"
+#include "hw/xen/interface/hvm/params.h"
+#include "hw/xen/interface/hvm/e820.h"
 
 //#define DEBUG_XEN_HVM
 
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 254759f776..dc73c86c61 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -17,8 +17,6 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "qemu/bitmap.h"
 
-#include <xen/hvm/params.h>
-
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
 
diff --git a/include/hw/xen/interface/hvm/e820.h b/include/hw/xen/interface/hvm/e820.h
new file mode 100644
index 0000000000..9cb141e3c4
--- /dev/null
+++ b/include/hw/xen/interface/hvm/e820.h
@@ -0,0 +1,28 @@
+/*
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
+ * Copyright (c) 2006, Keir Fraser
+ */
+
+#ifndef XEN_PUBLIC_HVM_E820_H
+#define XEN_PUBLIC_HVM_E820_H
+
+#define HVM_BELOW_4G_RAM_END        0xF0000000
+
+#endif /* XEN_PUBLIC_HVM_E820_H */
diff --git a/include/hw/xen/interface/hvm/ioreq.h b/include/hw/xen/interface/hvm/ioreq.h
new file mode 100644
index 0000000000..453f320c28
--- /dev/null
+++ b/include/hw/xen/interface/hvm/ioreq.h
@@ -0,0 +1,101 @@
+/*
+ * ioreq.h: I/O request definitions for device models
+ * Copyright (c) 2004, Intel Corporation.
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
+ */
+
+#ifndef XEN_PUBLIC_HVM_IOREQ_H
+#define XEN_PUBLIC_HVM_IOREQ_H
+
+#define IOREQ_READ      1
+#define IOREQ_WRITE     0
+
+#define STATE_IOREQ_NONE        0
+#define STATE_IOREQ_READY       1
+#define STATE_IOREQ_INPROCESS   2
+#define STATE_IORESP_READY      3
+
+#define IOREQ_TYPE_PIO          0 /* pio */
+#define IOREQ_TYPE_COPY         1 /* mmio ops */
+#define IOREQ_TYPE_PCI_CONFIG   2
+#define IOREQ_TYPE_TIMEOFFSET   7
+#define IOREQ_TYPE_INVALIDATE   8 /* mapcache */
+
+/*
+ * VMExit dispatcher should cooperate with instruction decoder to
+ * prepare this structure and notify service OS and DM by sending
+ * virq.
+ *
+ * For I/O type IOREQ_TYPE_PCI_CONFIG, the physical address is formatted
+ * as follows:
+ *
+ * 63....48|47..40|39..35|34..32|31........0
+ * SEGMENT |BUS   |DEV   |FN    |OFFSET
+ */
+struct ioreq {
+    uint64_t addr;          /* physical address */
+    uint64_t data;          /* data (or paddr of data) */
+    uint32_t count;         /* for rep prefixes */
+    uint32_t size;          /* size in bytes */
+    uint32_t vp_eport;      /* evtchn for notifications to/from device model */
+    uint16_t _pad0;
+    uint8_t state:4;
+    uint8_t data_is_ptr:1;  /* if 1, data above is the guest paddr
+                             * of the real data to use. */
+    uint8_t dir:1;          /* 1=read, 0=write */
+    uint8_t df:1;
+    uint8_t _pad1:1;
+    uint8_t type;           /* I/O type */
+};
+typedef struct ioreq ioreq_t;
+
+struct shared_iopage {
+    struct ioreq vcpu_ioreq[1];
+};
+typedef struct shared_iopage shared_iopage_t;
+
+struct buf_ioreq {
+    uint8_t  type;   /* I/O type                    */
+    uint8_t  pad:1;
+    uint8_t  dir:1;  /* 1=read, 0=write             */
+    uint8_t  size:2; /* 0=>1, 1=>2, 2=>4, 3=>8. If 8, use two buf_ioreqs */
+    uint32_t addr:20;/* physical address            */
+    uint32_t data;   /* data                        */
+};
+typedef struct buf_ioreq buf_ioreq_t;
+
+#define IOREQ_BUFFER_SLOT_NUM     511 /* 8 bytes each, plus 2 4-byte indexes */
+struct buffered_iopage {
+#ifdef __XEN__
+    union bufioreq_pointers {
+        struct {
+#endif
+            uint32_t read_pointer;
+            uint32_t write_pointer;
+#ifdef __XEN__
+        };
+        uint64_t full;
+    } ptrs;
+#endif
+    buf_ioreq_t buf_ioreq[IOREQ_BUFFER_SLOT_NUM];
+}; /* NB. Size of this structure must be no greater than one page. */
+typedef struct buffered_iopage buffered_iopage_t;
+
+#endif /* XEN_PUBLIC_HVM_IOREQ_H */
diff --git a/include/hw/xen/interface/hvm/params.h b/include/hw/xen/interface/hvm/params.h
new file mode 100644
index 0000000000..a4b6ff3853
--- /dev/null
+++ b/include/hw/xen/interface/hvm/params.h
@@ -0,0 +1,33 @@
+/*
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
+ * Copyright (c) 2007, Keir Fraser
+ */
+
+#ifndef XEN_PUBLIC_HVM_PARAMS_H
+#define XEN_PUBLIC_HVM_PARAMS_H
+
+/*
+ * Parameter space for HVMOP_{set,get}_param.
+ */
+
+/* ACPI S state: currently support S0 and S3 on x86. */
+#define HVM_PARAM_ACPI_S_STATE 14
+
+#endif /* XEN_PUBLIC_HVM_PARAMS_H */
-- 
Anthony PERARD


