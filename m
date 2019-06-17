Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FB9C31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3778208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3778208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctvZ-0003tI-8X
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hctlI-0004KU-L1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hctlC-0008Es-DP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:36 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:62260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hctlA-00082L-BC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:29 -0400
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
IronPort-SDR: T6BohGEw++h1+GHoXfsshj2diqf/tn8AfnI4zOUbwCvFNuPDAjtmLNt2keSpd5eQOZnlzet7b+
 7dJWVOWL7Y/QwWvD/49R4ewdrqcwO9ph/qUuGrf9ArPBOjBR36I2kFHOsfiUylDnH0YlxCMCnL
 FiFJ/cXAuWgmPs0pTWdIuWU8RtwaPXwxJj6GhtkEcW1PjxkL7zkWp0ffcT9ho9iSFIZIcNK9N9
 8QxfoIzoGSO+mriOo/LWx7a36DRPCbsV/fk1OnK8hG4b7x40uP0hsY9iej1IQXNDL5yUfFJZ+v
 jjI=
X-SBRS: 2.7
X-MesageID: 1846123
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,385,1557201600"; 
   d="scan'208";a="1846123"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Mon, 17 Jun 2019 16:41:02 +0100
Message-ID: <20190617154105.32323-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617154105.32323-1-anthony.perard@citrix.com>
References: <20190617154105.32323-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: [Qemu-devel] [PATCH 1/4] xen: Fix build with public headers
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

Following 37677d7db3 "Clean up a few header guard symbols", QEMU start
to fail to build:

In file included from ~/xen/tools/../tools/include/xen/io/blkif.h:31:0,
                 from ~/xen/tools/qemu-xen-dir/hw/block/xen_blkif.h:5,
                 from ~/xen/tools/qemu-xen-dir/hw/block/xen-block.c:22:
~/xen/tools/../tools/include/xen/io/ring.h:68:0: error: "__CONST_RING_SIZE" redefined [-Werror]
 #define __CONST_RING_SIZE(_s, _sz) \

In file included from ~/xen/tools/qemu-xen-dir/hw/block/xen_blkif.h:4:0,
                 from ~/xen/tools/qemu-xen-dir/hw/block/xen-block.c:22:
~/xen/tools/qemu-xen-dir/include/hw/xen/io/ring.h:66:0: note: this is the location of the previous definition
 #define __CONST_RING_SIZE(_s, _sz) \

The issue is that some public xen headers have been imported (by
f65eadb639 "xen: import ring.h from xen") but not all. With the change
in the guards symbole, the ring.h header start to be imported twice.

Fix the build by importing blkif.h and usbif.h and there dependencies.
Some cleanup have been done on those files.

Subsequent patches will import other Xen public headers.

ring.h have been moved to "hw/xen/interface/" along with blkif.h and
usbif.h as those describe interface (and would allow to also import a
xen.h header if that was necessary).

xen-mapcache.c doesn't needs grant_table.h.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/9pfs/xen-9pfs.h                       |   2 +-
 hw/block/xen_blkif.h                     |   3 +-
 hw/usb/xen-usb.c                         |   3 +-
 hw/xen/xen-legacy-backend.c              |   2 -
 include/hw/xen/interface/grant_table.h   |  36 ++
 include/hw/xen/interface/io/blkif.h      | 712 +++++++++++++++++++++++
 include/hw/xen/{ => interface}/io/ring.h |   0
 include/hw/xen/interface/io/usbif.h      | 254 ++++++++
 8 files changed, 1005 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/xen/interface/grant_table.h
 create mode 100644 include/hw/xen/interface/io/blkif.h
 rename include/hw/xen/{ => interface}/io/ring.h (100%)
 create mode 100644 include/hw/xen/interface/io/usbif.h

diff --git a/hw/9pfs/xen-9pfs.h b/hw/9pfs/xen-9pfs.h
index fbdee3d843..92dc87e9e0 100644
--- a/hw/9pfs/xen-9pfs.h
+++ b/hw/9pfs/xen-9pfs.h
@@ -14,7 +14,7 @@
 #define HW_9PFS_XEN_9PFS_H
 
 #include <xen/io/protocols.h>
-#include "hw/xen/io/ring.h"
+#include "hw/xen/interface/io/ring.h"
 
 /*
  * Do not merge into xen-9p-backend.c: clang doesn't allow unused static
diff --git a/hw/block/xen_blkif.h b/hw/block/xen_blkif.h
index a353693ea0..5a1094d793 100644
--- a/hw/block/xen_blkif.h
+++ b/hw/block/xen_blkif.h
@@ -1,8 +1,7 @@
 #ifndef XEN_BLKIF_H
 #define XEN_BLKIF_H
 
-#include "hw/xen/io/ring.h"
-#include <xen/io/blkif.h>
+#include "hw/xen/interface/io/blkif.h"
 #include <xen/io/protocols.h>
 
 /*
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index b20d0cfadf..dfbb418e77 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -32,8 +32,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 
-#include "hw/xen/io/ring.h"
-#include <xen/io/usbif.h>
+#include "hw/xen/interface/io/usbif.h"
 
 /*
  * Check for required support of usbif.h: USBIF_SHORT_NOT_OK was the last
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 36fd1e9b09..3715c94fa6 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -34,8 +34,6 @@
 #include "hw/xen/xen_pvdev.h"
 #include "monitor/qdev.h"
 
-#include <xen/grant_table.h>
-
 DeviceState *xen_sysdev;
 BusState *xen_sysbus;
 
diff --git a/include/hw/xen/interface/grant_table.h b/include/hw/xen/interface/grant_table.h
new file mode 100644
index 0000000000..302e404814
--- /dev/null
+++ b/include/hw/xen/interface/grant_table.h
@@ -0,0 +1,36 @@
+/******************************************************************************
+ * grant_table.h
+ *
+ * Interface for granting foreign access to page frames, and receiving
+ * page-ownership transfers.
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
+ * Copyright (c) 2004, K A Fraser
+ */
+
+#ifndef XEN_PUBLIC_GRANT_TABLE_H
+#define XEN_PUBLIC_GRANT_TABLE_H
+
+/*
+ * Reference to a grant entry in a specified domain's grant table.
+ */
+typedef uint32_t grant_ref_t;
+
+#endif /* XEN_PUBLIC_GRANT_TABLE_H */
diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interface/io/blkif.h
new file mode 100644
index 0000000000..2fe77271c9
--- /dev/null
+++ b/include/hw/xen/interface/io/blkif.h
@@ -0,0 +1,712 @@
+/******************************************************************************
+ * blkif.h
+ *
+ * Unified block-device I/O interface for Xen guest OSes.
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
+ * Copyright (c) 2012, Spectra Logic Corporation
+ */
+
+#ifndef XEN_PUBLIC_IO_BLKIF_H
+#define XEN_PUBLIC_IO_BLKIF_H
+
+#include "ring.h"
+#include "../grant_table.h"
+
+/*
+ * Front->back notifications: When enqueuing a new request, sending a
+ * notification can be made conditional on req_event (i.e., the generic
+ * hold-off mechanism provided by the ring macros). Backends must set
+ * req_event appropriately (e.g., using RING_FINAL_CHECK_FOR_REQUESTS()).
+ *
+ * Back->front notifications: When enqueuing a new response, sending a
+ * notification can be made conditional on rsp_event (i.e., the generic
+ * hold-off mechanism provided by the ring macros). Frontends must set
+ * rsp_event appropriately (e.g., using RING_FINAL_CHECK_FOR_RESPONSES()).
+ */
+
+#ifndef blkif_vdev_t
+#define blkif_vdev_t   uint16_t
+#endif
+#define blkif_sector_t uint64_t
+
+/*
+ * Feature and Parameter Negotiation
+ * =================================
+ * The two halves of a Xen block driver utilize nodes within the XenStore to
+ * communicate capabilities and to negotiate operating parameters.  This
+ * section enumerates these nodes which reside in the respective front and
+ * backend portions of the XenStore, following the XenBus convention.
+ *
+ * All data in the XenStore is stored as strings.  Nodes specifying numeric
+ * values are encoded in decimal.  Integer value ranges listed below are
+ * expressed as fixed sized integer types capable of storing the conversion
+ * of a properly formated node string, without loss of information.
+ *
+ * Any specified default value is in effect if the corresponding XenBus node
+ * is not present in the XenStore.
+ *
+ * XenStore nodes in sections marked "PRIVATE" are solely for use by the
+ * driver side whose XenBus tree contains them.
+ *
+ * XenStore nodes marked "DEPRECATED" in their notes section should only be
+ * used to provide interoperability with legacy implementations.
+ *
+ * See the XenBus state transition diagram below for details on when XenBus
+ * nodes must be published and when they can be queried.
+ *
+ *****************************************************************************
+ *                            Backend XenBus Nodes
+ *****************************************************************************
+ *
+ *------------------ Backend Device Identification (PRIVATE) ------------------
+ *
+ * mode
+ *      Values:         "r" (read only), "w" (writable)
+ *
+ *      The read or write access permissions to the backing store to be
+ *      granted to the frontend.
+ *
+ * params
+ *      Values:         string
+ *
+ *      A free formatted string providing sufficient information for the
+ *      hotplug script to attach the device and provide a suitable
+ *      handler (ie: a block device) for blkback to use.
+ *
+ * physical-device
+ *      Values:         "MAJOR:MINOR"
+ *      Notes: 11
+ *
+ *      MAJOR and MINOR are the major number and minor number of the
+ *      backing device respectively.
+ *
+ * physical-device-path
+ *      Values:         path string
+ *
+ *      A string that contains the absolute path to the disk image. On
+ *      NetBSD and Linux this is always a block device, while on FreeBSD
+ *      it can be either a block device or a regular file.
+ *
+ * type
+ *      Values:         "file", "phy", "tap"
+ *
+ *      The type of the backing device/object.
+ *
+ *
+ * direct-io-safe
+ *      Values:         0/1 (boolean)
+ *      Default Value:  0
+ *
+ *      The underlying storage is not affected by the direct IO memory
+ *      lifetime bug.  See:
+ *        http://lists.xen.org/archives/html/xen-devel/2012-12/msg01154.html
+ *
+ *      Therefore this option gives the backend permission to use
+ *      O_DIRECT, notwithstanding that bug.
+ *
+ *      That is, if this option is enabled, use of O_DIRECT is safe,
+ *      in circumstances where we would normally have avoided it as a
+ *      workaround for that bug.  This option is not relevant for all
+ *      backends, and even not necessarily supported for those for
+ *      which it is relevant.  A backend which knows that it is not
+ *      affected by the bug can ignore this option.
+ *
+ *      This option doesn't require a backend to use O_DIRECT, so it
+ *      should not be used to try to control the caching behaviour.
+ *
+ *--------------------------------- Features ---------------------------------
+ *
+ * feature-barrier
+ *      Values:         0/1 (boolean)
+ *      Default Value:  0
+ *
+ *      A value of "1" indicates that the backend can process requests
+ *      containing the BLKIF_OP_WRITE_BARRIER request opcode.  Requests
+ *      of this type may still be returned at any time with the
+ *      BLKIF_RSP_EOPNOTSUPP result code.
+ *
+ * feature-flush-cache
+ *      Values:         0/1 (boolean)
+ *      Default Value:  0
+ *
+ *      A value of "1" indicates that the backend can process requests
+ *      containing the BLKIF_OP_FLUSH_DISKCACHE request opcode.  Requests
+ *      of this type may still be returned at any time with the
+ *      BLKIF_RSP_EOPNOTSUPP result code.
+ *
+ * feature-discard
+ *      Values:         0/1 (boolean)
+ *      Default Value:  0
+ *
+ *      A value of "1" indicates that the backend can process requests
+ *      containing the BLKIF_OP_DISCARD request opcode.  Requests
+ *      of this type may still be returned at any time with the
+ *      BLKIF_RSP_EOPNOTSUPP result code.
+ *
+ * feature-persistent
+ *      Values:         0/1 (boolean)
+ *      Default Value:  0
+ *      Notes: 7
+ *
+ *      A value of "1" indicates that the backend can keep the grants used
+ *      by the frontend driver mapped, so the same set of grants should be
+ *      used in all transactions. The maximum number of grants the backend
+ *      can map persistently depends on the implementation, but ideally it
+ *      should be RING_SIZE * BLKIF_MAX_SEGMENTS_PER_REQUEST. Using this
+ *      feature the backend doesn't need to unmap each grant, preventing
+ *      costly TLB flushes. The backend driver should only map grants
+ *      persistently if the frontend supports it. If a backend driver chooses
+ *      to use the persistent protocol when the frontend doesn't support it,
+ *      it will probably hit the maximum number of persistently mapped grants
+ *      (due to the fact that the frontend won't be reusing the same grants),
+ *      and fall back to non-persistent mode. Backend implementations may
+ *      shrink or expand the number of persistently mapped grants without
+ *      notifying the frontend depending on memory constraints (this might
+ *      cause a performance degradation).
+ *
+ *      If a backend driver wants to limit the maximum number of persistently
+ *      mapped grants to a value less than RING_SIZE *
+ *      BLKIF_MAX_SEGMENTS_PER_REQUEST a LRU strategy should be used to
+ *      discard the grants that are less commonly used. Using a LRU in the
+ *      backend driver paired with a LIFO queue in the frontend will
+ *      allow us to have better performance in this scenario.
+ *
+ *----------------------- Request Transport Parameters ------------------------
+ *
+ * max-ring-page-order
+ *      Values:         <uint32_t>
+ *      Default Value:  0
+ *      Notes:          1, 3
+ *
+ *      The maximum supported size of the request ring buffer in units of
+ *      lb(machine pages). (e.g. 0 == 1 page,  1 = 2 pages, 2 == 4 pages,
+ *      etc.).
+ *
+ * max-ring-pages
+ *      Values:         <uint32_t>
+ *      Default Value:  1
+ *      Notes:          DEPRECATED, 2, 3
+ *
+ *      The maximum supported size of the request ring buffer in units of
+ *      machine pages.  The value must be a power of 2.
+ *
+ *------------------------- Backend Device Properties -------------------------
+ *
+ * discard-enable
+ *      Values:         0/1 (boolean)
+ *      Default Value:  1
+ *
+ *      This optional property, set by the toolstack, instructs the backend
+ *      to offer (or not to offer) discard to the frontend. If the property
+ *      is missing the backend should offer discard if the backing storage
+ *      actually supports it.
+ *
+ * discard-alignment
+ *      Values:         <uint32_t>
+ *      Default Value:  0
+ *      Notes:          4, 5
+ *
+ *      The offset, in bytes from the beginning of the virtual block device,
+ *      to the first, addressable, discard extent on the underlying device.
+ *
+ * discard-granularity
+ *      Values:         <uint32_t>
+ *      Default Value:  <"sector-size">
+ *      Notes:          4
+ *
+ *      The size, in bytes, of the individually addressable discard extents
+ *      of the underlying device.
+ *
+ * discard-secure
+ *      Values:         0/1 (boolean)
+ *      Default Value:  0
+ *      Notes:          10
+ *
+ *      A value of "1" indicates that the backend can process BLKIF_OP_DISCARD
+ *      requests with the BLKIF_DISCARD_SECURE flag set.
+ *
+ * info
+ *      Values:         <uint32_t> (bitmap)
+ *
+ *      A collection of bit flags describing attributes of the backing
+ *      device.  The VDISK_* macros define the meaning of each bit
+ *      location.
+ *
+ * sector-size
+ *      Values:         <uint32_t>
+ *
+ *      The logical block size, in bytes, of the underlying storage. This
+ *      must be a power of two with a minimum value of 512.
+ *
+ *      NOTE: Because of implementation bugs in some frontends this must be
+ *            set to 512, unless the frontend advertizes a non-zero value
+ *            in its "feature-large-sector-size" xenbus node. (See below).
+ *
+ * physical-sector-size
+ *      Values:         <uint32_t>
+ *      Default Value:  <"sector-size">
+ *
+ *      The physical block size, in bytes, of the backend storage. This
+ *      must be an integer multiple of "sector-size".
+ *
+ * sectors
+ *      Values:         <uint64_t>
+ *
+ *      The size of the backend device, expressed in units of "sector-size".
+ *      The product of "sector-size" and "sectors" must also be an integer
+ *      multiple of "physical-sector-size", if that node is present.
+ *
+ *****************************************************************************
+ *                            Frontend XenBus Nodes
+ *****************************************************************************
+ *
+ *----------------------- Request Transport Parameters -----------------------
+ *
+ * event-channel
+ *      Values:         <uint32_t>
+ *
+ *      The identifier of the Xen event channel used to signal activity
+ *      in the ring buffer.
+ *
+ * ring-ref
+ *      Values:         <uint32_t>
+ *      Notes:          6
+ *
+ *      The Xen grant reference granting permission for the backend to map
+ *      the sole page in a single page sized ring buffer.
+ *
+ * ring-ref%u
+ *      Values:         <uint32_t>
+ *      Notes:          6
+ *
+ *      For a frontend providing a multi-page ring, a "number of ring pages"
+ *      sized list of nodes, each containing a Xen grant reference granting
+ *      permission for the backend to map the page of the ring located
+ *      at page index "%u".  Page indexes are zero based.
+ *
+ * protocol
+ *      Values:         string (XEN_IO_PROTO_ABI_*)
+ *      Default Value:  XEN_IO_PROTO_ABI_NATIVE
+ *
+ *      The machine ABI rules governing the format of all ring request and
+ *      response structures.
+ *
+ * ring-page-order
+ *      Values:         <uint32_t>
+ *      Default Value:  0
+ *      Maximum Value:  MAX(ffs(max-ring-pages) - 1, max-ring-page-order)
+ *      Notes:          1, 3
+ *
+ *      The size of the frontend allocated request ring buffer in units
+ *      of lb(machine pages). (e.g. 0 == 1 page, 1 = 2 pages, 2 == 4 pages,
+ *      etc.).
+ *
+ * num-ring-pages
+ *      Values:         <uint32_t>
+ *      Default Value:  1
+ *      Maximum Value:  MAX(max-ring-pages,(0x1 << max-ring-page-order))
+ *      Notes:          DEPRECATED, 2, 3
+ *
+ *      The size of the frontend allocated request ring buffer in units of
+ *      machine pages.  The value must be a power of 2.
+ *
+ *--------------------------------- Features ---------------------------------
+ *
+ * feature-persistent
+ *      Values:         0/1 (boolean)
+ *      Default Value:  0
+ *      Notes: 7, 8, 9
+ *
+ *      A value of "1" indicates that the frontend will reuse the same grants
+ *      for all transactions, allowing the backend to map them with write
+ *      access (even when it should be read-only). If the frontend hits the
+ *      maximum number of allowed persistently mapped grants, it can fallback
+ *      to non persistent mode. This will cause a performance degradation,
+ *      since the the backend driver will still try to map those grants
+ *      persistently. Since the persistent grants protocol is compatible with
+ *      the previous protocol, a frontend driver can choose to work in
+ *      persistent mode even when the backend doesn't support it.
+ *
+ *      It is recommended that the frontend driver stores the persistently
+ *      mapped grants in a LIFO queue, so a subset of all persistently mapped
+ *      grants gets used commonly. This is done in case the backend driver
+ *      decides to limit the maximum number of persistently mapped grants
+ *      to a value less than RING_SIZE * BLKIF_MAX_SEGMENTS_PER_REQUEST.
+ *
+ * feature-large-sector-size
+ *      Values:         0/1 (boolean)
+ *      Default Value:  0
+ *
+ *      A value of "1" indicates that the frontend will correctly supply and
+ *      interpret all sector-based quantities in terms of the "sector-size"
+ *      value supplied in the backend info, whatever that may be set to.
+ *      If this node is not present or its value is "0" then it is assumed
+ *      that the frontend requires that the logical block size is 512 as it
+ *      is hardcoded (which is the case in some frontend implementations).
+ *
+ *------------------------- Virtual Device Properties -------------------------
+ *
+ * device-type
+ *      Values:         "disk", "cdrom", "floppy", etc.
+ *
+ * virtual-device
+ *      Values:         <uint32_t>
+ *
+ *      A value indicating the physical device to virtualize within the
+ *      frontend's domain.  (e.g. "The first ATA disk", "The third SCSI
+ *      disk", etc.)
+ *
+ *      See docs/misc/vbd-interface.txt for details on the format of this
+ *      value.
+ *
+ * Notes
+ * -----
+ * (1) Multi-page ring buffer scheme first developed in the Citrix XenServer
+ *     PV drivers.
+ * (2) Multi-page ring buffer scheme first used in some RedHat distributions
+ *     including a distribution deployed on certain nodes of the Amazon
+ *     EC2 cluster.
+ * (3) Support for multi-page ring buffers was implemented independently,
+ *     in slightly different forms, by both Citrix and RedHat/Amazon.
+ *     For full interoperability, block front and backends should publish
+ *     identical ring parameters, adjusted for unit differences, to the
+ *     XenStore nodes used in both schemes.
+ * (4) Devices that support discard functionality may internally allocate space
+ *     (discardable extents) in units that are larger than the exported logical
+ *     block size. If the backing device has such discardable extents the
+ *     backend should provide both discard-granularity and discard-alignment.
+ *     Providing just one of the two may be considered an error by the frontend.
+ *     Backends supporting discard should include discard-granularity and
+ *     discard-alignment even if it supports discarding individual sectors.
+ *     Frontends should assume discard-alignment == 0 and discard-granularity
+ *     == sector size if these keys are missing.
+ * (5) The discard-alignment parameter allows a physical device to be
+ *     partitioned into virtual devices that do not necessarily begin or
+ *     end on a discardable extent boundary.
+ * (6) When there is only a single page allocated to the request ring,
+ *     'ring-ref' is used to communicate the grant reference for this
+ *     page to the backend.  When using a multi-page ring, the 'ring-ref'
+ *     node is not created.  Instead 'ring-ref0' - 'ring-refN' are used.
+ * (7) When using persistent grants data has to be copied from/to the page
+ *     where the grant is currently mapped. The overhead of doing this copy
+ *     however doesn't suppress the speed improvement of not having to unmap
+ *     the grants.
+ * (8) The frontend driver has to allow the backend driver to map all grants
+ *     with write access, even when they should be mapped read-only, since
+ *     further requests may reuse these grants and require write permissions.
+ * (9) Linux implementation doesn't have a limit on the maximum number of
+ *     grants that can be persistently mapped in the frontend driver, but
+ *     due to the frontent driver implementation it should never be bigger
+ *     than RING_SIZE * BLKIF_MAX_SEGMENTS_PER_REQUEST.
+ *(10) The discard-secure property may be present and will be set to 1 if the
+ *     backing device supports secure discard.
+ *(11) Only used by Linux and NetBSD.
+ */
+
+/*
+ * Multiple hardware queues/rings:
+ * If supported, the backend will write the key "multi-queue-max-queues" to
+ * the directory for that vbd, and set its value to the maximum supported
+ * number of queues.
+ * Frontends that are aware of this feature and wish to use it can write the
+ * key "multi-queue-num-queues" with the number they wish to use, which must be
+ * greater than zero, and no more than the value reported by the backend in
+ * "multi-queue-max-queues".
+ *
+ * For frontends requesting just one queue, the usual event-channel and
+ * ring-ref keys are written as before, simplifying the backend processing
+ * to avoid distinguishing between a frontend that doesn't understand the
+ * multi-queue feature, and one that does, but requested only one queue.
+ *
+ * Frontends requesting two or more queues must not write the toplevel
+ * event-channel and ring-ref keys, instead writing those keys under sub-keys
+ * having the name "queue-N" where N is the integer ID of the queue/ring for
+ * which those keys belong. Queues are indexed from zero.
+ * For example, a frontend with two queues must write the following set of
+ * queue-related keys:
+ *
+ * /local/domain/1/device/vbd/0/multi-queue-num-queues = "2"
+ * /local/domain/1/device/vbd/0/queue-0 = ""
+ * /local/domain/1/device/vbd/0/queue-0/ring-ref = "<ring-ref#0>"
+ * /local/domain/1/device/vbd/0/queue-0/event-channel = "<evtchn#0>"
+ * /local/domain/1/device/vbd/0/queue-1 = ""
+ * /local/domain/1/device/vbd/0/queue-1/ring-ref = "<ring-ref#1>"
+ * /local/domain/1/device/vbd/0/queue-1/event-channel = "<evtchn#1>"
+ *
+ * It is also possible to use multiple queues/rings together with
+ * feature multi-page ring buffer.
+ * For example, a frontend requests two queues/rings and the size of each ring
+ * buffer is two pages must write the following set of related keys:
+ *
+ * /local/domain/1/device/vbd/0/multi-queue-num-queues = "2"
+ * /local/domain/1/device/vbd/0/ring-page-order = "1"
+ * /local/domain/1/device/vbd/0/queue-0 = ""
+ * /local/domain/1/device/vbd/0/queue-0/ring-ref0 = "<ring-ref#0>"
+ * /local/domain/1/device/vbd/0/queue-0/ring-ref1 = "<ring-ref#1>"
+ * /local/domain/1/device/vbd/0/queue-0/event-channel = "<evtchn#0>"
+ * /local/domain/1/device/vbd/0/queue-1 = ""
+ * /local/domain/1/device/vbd/0/queue-1/ring-ref0 = "<ring-ref#2>"
+ * /local/domain/1/device/vbd/0/queue-1/ring-ref1 = "<ring-ref#3>"
+ * /local/domain/1/device/vbd/0/queue-1/event-channel = "<evtchn#1>"
+ *
+ */
+
+/*
+ * STATE DIAGRAMS
+ *
+ *****************************************************************************
+ *                                   Startup                                 *
+ *****************************************************************************
+ *
+ * Tool stack creates front and back nodes with state XenbusStateInitialising.
+ *
+ * Front                                Back
+ * =================================    =====================================
+ * XenbusStateInitialising              XenbusStateInitialising
+ *  o Query virtual device               o Query backend device identification
+ *    properties.                          data.
+ *  o Setup OS device instance.          o Open and validate backend device.
+ *                                       o Publish backend features and
+ *                                         transport parameters.
+ *                                                      |
+ *                                                      |
+ *                                                      V
+ *                                      XenbusStateInitWait
+ *
+ * o Query backend features and
+ *   transport parameters.
+ * o Allocate and initialize the
+ *   request ring.
+ * o Publish transport parameters
+ *   that will be in effect during
+ *   this connection.
+ *              |
+ *              |
+ *              V
+ * XenbusStateInitialised
+ *
+ *                                       o Query frontend transport parameters.
+ *                                       o Connect to the request ring and
+ *                                         event channel.
+ *                                       o Publish backend device properties.
+ *                                                      |
+ *                                                      |
+ *                                                      V
+ *                                      XenbusStateConnected
+ *
+ *  o Query backend device properties.
+ *  o Finalize OS virtual device
+ *    instance.
+ *              |
+ *              |
+ *              V
+ * XenbusStateConnected
+ *
+ * Note: Drivers that do not support any optional features, or the negotiation
+ *       of transport parameters, can skip certain states in the state machine:
+ *
+ *       o A frontend may transition to XenbusStateInitialised without
+ *         waiting for the backend to enter XenbusStateInitWait.  In this
+ *         case, default transport parameters are in effect and any
+ *         transport parameters published by the frontend must contain
+ *         their default values.
+ *
+ *       o A backend may transition to XenbusStateInitialised, bypassing
+ *         XenbusStateInitWait, without waiting for the frontend to first
+ *         enter the XenbusStateInitialised state.  In this case, default
+ *         transport parameters are in effect and any transport parameters
+ *         published by the backend must contain their default values.
+ *
+ *       Drivers that support optional features and/or transport parameter
+ *       negotiation must tolerate these additional state transition paths.
+ *       In general this means performing the work of any skipped state
+ *       transition, if it has not already been performed, in addition to the
+ *       work associated with entry into the current state.
+ */
+
+/*
+ * REQUEST CODES.
+ */
+#define BLKIF_OP_READ              0
+#define BLKIF_OP_WRITE             1
+/*
+ * All writes issued prior to a request with the BLKIF_OP_WRITE_BARRIER
+ * operation code ("barrier request") must be completed prior to the
+ * execution of the barrier request.  All writes issued after the barrier
+ * request must not execute until after the completion of the barrier request.
+ *
+ * Optional.  See "feature-barrier" XenBus node documentation above.
+ */
+#define BLKIF_OP_WRITE_BARRIER     2
+/*
+ * Commit any uncommitted contents of the backing device's volatile cache
+ * to stable storage.
+ *
+ * Optional.  See "feature-flush-cache" XenBus node documentation above.
+ */
+#define BLKIF_OP_FLUSH_DISKCACHE   3
+/*
+ * Used in SLES sources for device specific command packet
+ * contained within the request. Reserved for that purpose.
+ */
+#define BLKIF_OP_RESERVED_1        4
+/*
+ * Indicate to the backend device that a region of storage is no longer in
+ * use, and may be discarded at any time without impact to the client.  If
+ * the BLKIF_DISCARD_SECURE flag is set on the request, all copies of the
+ * discarded region on the device must be rendered unrecoverable before the
+ * command returns.
+ *
+ * This operation is analogous to performing a trim (ATA) or unamp (SCSI),
+ * command on a native device.
+ *
+ * More information about trim/unmap operations can be found at:
+ * http://t13.org/Documents/UploadedDocuments/docs2008/
+ *     e07154r6-Data_Set_Management_Proposal_for_ATA-ACS2.doc
+ * http://www.seagate.com/staticfiles/support/disc/manuals/
+ *     Interface%20manuals/100293068c.pdf
+ *
+ * Optional.  See "feature-discard", "discard-alignment",
+ * "discard-granularity", and "discard-secure" in the XenBus node
+ * documentation above.
+ */
+#define BLKIF_OP_DISCARD           5
+
+/*
+ * Recognized if "feature-max-indirect-segments" in present in the backend
+ * xenbus info. The "feature-max-indirect-segments" node contains the maximum
+ * number of segments allowed by the backend per request. If the node is
+ * present, the frontend might use blkif_request_indirect structs in order to
+ * issue requests with more than BLKIF_MAX_SEGMENTS_PER_REQUEST (11). The
+ * maximum number of indirect segments is fixed by the backend, but the
+ * frontend can issue requests with any number of indirect segments as long as
+ * it's less than the number provided by the backend. The indirect_grefs field
+ * in blkif_request_indirect should be filled by the frontend with the
+ * grant references of the pages that are holding the indirect segments.
+ * These pages are filled with an array of blkif_request_segment that hold the
+ * information about the segments. The number of indirect pages to use is
+ * determined by the number of segments an indirect request contains. Every
+ * indirect page can contain a maximum of
+ * (PAGE_SIZE / sizeof(struct blkif_request_segment)) segments, so to
+ * calculate the number of indirect pages to use we have to do
+ * ceil(indirect_segments / (PAGE_SIZE / sizeof(struct blkif_request_segment))).
+ *
+ * If a backend does not recognize BLKIF_OP_INDIRECT, it should *not*
+ * create the "feature-max-indirect-segments" node!
+ */
+#define BLKIF_OP_INDIRECT          6
+
+/*
+ * Maximum scatter/gather segments per request.
+ * This is carefully chosen so that sizeof(blkif_ring_t) <= PAGE_SIZE.
+ * NB. This could be 12 if the ring indexes weren't stored in the same page.
+ */
+#define BLKIF_MAX_SEGMENTS_PER_REQUEST 11
+
+/*
+ * Maximum number of indirect pages to use per request.
+ */
+#define BLKIF_MAX_INDIRECT_PAGES_PER_REQUEST 8
+
+/*
+ * NB. 'first_sect' and 'last_sect' in blkif_request_segment, as well as
+ * 'sector_number' in blkif_request, blkif_request_discard and
+ * blkif_request_indirect are sector-based quantities. See the description
+ * of the "feature-large-sector-size" frontend xenbus node above for
+ * more information.
+ */
+struct blkif_request_segment {
+    grant_ref_t gref;        /* reference to I/O buffer frame        */
+    /* @first_sect: first sector in frame to transfer (inclusive).   */
+    /* @last_sect: last sector in frame to transfer (inclusive).     */
+    uint8_t     first_sect, last_sect;
+};
+
+/*
+ * Starting ring element for any I/O request.
+ */
+struct blkif_request {
+    uint8_t        operation;    /* BLKIF_OP_???                         */
+    uint8_t        nr_segments;  /* number of segments                   */
+    blkif_vdev_t   handle;       /* only for read/write requests         */
+    uint64_t       id;           /* private guest value, echoed in resp  */
+    blkif_sector_t sector_number;/* start sector idx on disk (r/w only)  */
+    struct blkif_request_segment seg[BLKIF_MAX_SEGMENTS_PER_REQUEST];
+};
+typedef struct blkif_request blkif_request_t;
+
+/*
+ * Cast to this structure when blkif_request.operation == BLKIF_OP_DISCARD
+ * sizeof(struct blkif_request_discard) <= sizeof(struct blkif_request)
+ */
+struct blkif_request_discard {
+    uint8_t        operation;    /* BLKIF_OP_DISCARD                     */
+    uint8_t        flag;         /* BLKIF_DISCARD_SECURE or zero         */
+#define BLKIF_DISCARD_SECURE (1<<0)  /* ignored if discard-secure=0      */
+    blkif_vdev_t   handle;       /* same as for read/write requests      */
+    uint64_t       id;           /* private guest value, echoed in resp  */
+    blkif_sector_t sector_number;/* start sector idx on disk             */
+    uint64_t       nr_sectors;   /* number of contiguous sectors to discard*/
+};
+typedef struct blkif_request_discard blkif_request_discard_t;
+
+struct blkif_request_indirect {
+    uint8_t        operation;    /* BLKIF_OP_INDIRECT                    */
+    uint8_t        indirect_op;  /* BLKIF_OP_{READ/WRITE}                */
+    uint16_t       nr_segments;  /* number of segments                   */
+    uint64_t       id;           /* private guest value, echoed in resp  */
+    blkif_sector_t sector_number;/* start sector idx on disk (r/w only)  */
+    blkif_vdev_t   handle;       /* same as for read/write requests      */
+    grant_ref_t    indirect_grefs[BLKIF_MAX_INDIRECT_PAGES_PER_REQUEST];
+#ifdef __i386__
+    uint64_t       pad;          /* Make it 64 byte aligned on i386      */
+#endif
+};
+typedef struct blkif_request_indirect blkif_request_indirect_t;
+
+struct blkif_response {
+    uint64_t        id;              /* copied from request */
+    uint8_t         operation;       /* copied from request */
+    int16_t         status;          /* BLKIF_RSP_???       */
+};
+typedef struct blkif_response blkif_response_t;
+
+/*
+ * STATUS RETURN CODES.
+ */
+ /* Operation not supported (only happens on barrier writes). */
+#define BLKIF_RSP_EOPNOTSUPP  -2
+ /* Operation failed for some unspecified reason (-EIO). */
+#define BLKIF_RSP_ERROR       -1
+ /* Operation completed successfully. */
+#define BLKIF_RSP_OKAY         0
+
+/*
+ * Generate blkif ring structures and types.
+ */
+DEFINE_RING_TYPES(blkif, struct blkif_request, struct blkif_response);
+
+#define VDISK_CDROM        0x1
+#define VDISK_REMOVABLE    0x2
+#define VDISK_READONLY     0x4
+
+#endif /* XEN_PUBLIC_IO_BLKIF_H */
diff --git a/include/hw/xen/io/ring.h b/include/hw/xen/interface/io/ring.h
similarity index 100%
rename from include/hw/xen/io/ring.h
rename to include/hw/xen/interface/io/ring.h
diff --git a/include/hw/xen/interface/io/usbif.h b/include/hw/xen/interface/io/usbif.h
new file mode 100644
index 0000000000..ae3dc720fa
--- /dev/null
+++ b/include/hw/xen/interface/io/usbif.h
@@ -0,0 +1,254 @@
+/*
+ * usbif.h
+ *
+ * USB I/O interface for Xen guest OSes.
+ *
+ * Copyright (C) 2009, FUJITSU LABORATORIES LTD.
+ * Author: Noboru Iwamatsu <n_iwamatsu@jp.fujitsu.com>
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
+#ifndef XEN_PUBLIC_IO_USBIF_H
+#define XEN_PUBLIC_IO_USBIF_H
+
+#include "ring.h"
+#include "../grant_table.h"
+
+/*
+ * Feature and Parameter Negotiation
+ * =================================
+ * The two halves of a Xen pvUSB driver utilize nodes within the XenStore to
+ * communicate capabilities and to negotiate operating parameters. This
+ * section enumerates these nodes which reside in the respective front and
+ * backend portions of the XenStore, following the XenBus convention.
+ *
+ * Any specified default value is in effect if the corresponding XenBus node
+ * is not present in the XenStore.
+ *
+ * XenStore nodes in sections marked "PRIVATE" are solely for use by the
+ * driver side whose XenBus tree contains them.
+ *
+ *****************************************************************************
+ *                            Backend XenBus Nodes
+ *****************************************************************************
+ *
+ *------------------ Backend Device Identification (PRIVATE) ------------------
+ *
+ * num-ports
+ *      Values:         unsigned [1...31]
+ *
+ *      Number of ports for this (virtual) USB host connector.
+ *
+ * usb-ver
+ *      Values:         unsigned [1...2]
+ *
+ *      USB version of this host connector: 1 = USB 1.1, 2 = USB 2.0.
+ *
+ * port/[1...31]
+ *      Values:         string
+ *
+ *      Physical USB device connected to the given port, e.g. "3-1.5".
+ *
+ *****************************************************************************
+ *                            Frontend XenBus Nodes
+ *****************************************************************************
+ *
+ *----------------------- Request Transport Parameters -----------------------
+ *
+ * event-channel
+ *      Values:         unsigned
+ *
+ *      The identifier of the Xen event channel used to signal activity
+ *      in the ring buffer.
+ *
+ * urb-ring-ref
+ *      Values:         unsigned
+ *
+ *      The Xen grant reference granting permission for the backend to map
+ *      the sole page in a single page sized ring buffer. This is the ring
+ *      buffer for urb requests.
+ *
+ * conn-ring-ref
+ *      Values:         unsigned
+ *
+ *      The Xen grant reference granting permission for the backend to map
+ *      the sole page in a single page sized ring buffer. This is the ring
+ *      buffer for connection/disconnection requests.
+ *
+ * protocol
+ *      Values:         string (XEN_IO_PROTO_ABI_*)
+ *      Default Value:  XEN_IO_PROTO_ABI_NATIVE
+ *
+ *      The machine ABI rules governing the format of all ring request and
+ *      response structures.
+ *
+ */
+
+enum usb_spec_version {
+	USB_VER_UNKNOWN = 0,
+	USB_VER_USB11,
+	USB_VER_USB20,
+	USB_VER_USB30,	/* not supported yet */
+};
+
+/*
+ *  USB pipe in usbif_request
+ *
+ *  - port number:	bits 0-4
+ *				(USB_MAXCHILDREN is 31)
+ *
+ *  - operation flag:	bit 5
+ *				(0 = submit urb,
+ *				 1 = unlink urb)
+ *
+ *  - direction:		bit 7
+ *				(0 = Host-to-Device [Out]
+ *				 1 = Device-to-Host [In])
+ *
+ *  - device address:	bits 8-14
+ *
+ *  - endpoint:		bits 15-18
+ *
+ *  - pipe type:	bits 30-31
+ *				(00 = isochronous, 01 = interrupt,
+ *				 10 = control, 11 = bulk)
+ */
+
+#define USBIF_PIPE_PORT_MASK	0x0000001f
+#define USBIF_PIPE_UNLINK	0x00000020
+#define USBIF_PIPE_DIR		0x00000080
+#define USBIF_PIPE_DEV_MASK	0x0000007f
+#define USBIF_PIPE_DEV_SHIFT	8
+#define USBIF_PIPE_EP_MASK	0x0000000f
+#define USBIF_PIPE_EP_SHIFT	15
+#define USBIF_PIPE_TYPE_MASK	0x00000003
+#define USBIF_PIPE_TYPE_SHIFT	30
+#define USBIF_PIPE_TYPE_ISOC	0
+#define USBIF_PIPE_TYPE_INT	1
+#define USBIF_PIPE_TYPE_CTRL	2
+#define USBIF_PIPE_TYPE_BULK	3
+
+#define usbif_pipeportnum(pipe)			((pipe) & USBIF_PIPE_PORT_MASK)
+#define usbif_setportnum_pipe(pipe, portnum)	((pipe) | (portnum))
+
+#define usbif_pipeunlink(pipe)			((pipe) & USBIF_PIPE_UNLINK)
+#define usbif_pipesubmit(pipe)			(!usbif_pipeunlink(pipe))
+#define usbif_setunlink_pipe(pipe)		((pipe) | USBIF_PIPE_UNLINK)
+
+#define usbif_pipein(pipe)			((pipe) & USBIF_PIPE_DIR)
+#define usbif_pipeout(pipe)			(!usbif_pipein(pipe))
+
+#define usbif_pipedevice(pipe)			\
+		(((pipe) >> USBIF_PIPE_DEV_SHIFT) & USBIF_PIPE_DEV_MASK)
+
+#define usbif_pipeendpoint(pipe)		\
+		(((pipe) >> USBIF_PIPE_EP_SHIFT) & USBIF_PIPE_EP_MASK)
+
+#define usbif_pipetype(pipe)			\
+		(((pipe) >> USBIF_PIPE_TYPE_SHIFT) & USBIF_PIPE_TYPE_MASK)
+#define usbif_pipeisoc(pipe)	(usbif_pipetype(pipe) == USBIF_PIPE_TYPE_ISOC)
+#define usbif_pipeint(pipe)	(usbif_pipetype(pipe) == USBIF_PIPE_TYPE_INT)
+#define usbif_pipectrl(pipe)	(usbif_pipetype(pipe) == USBIF_PIPE_TYPE_CTRL)
+#define usbif_pipebulk(pipe)	(usbif_pipetype(pipe) == USBIF_PIPE_TYPE_BULK)
+
+#define USBIF_MAX_SEGMENTS_PER_REQUEST (16)
+#define USBIF_MAX_PORTNR	31
+#define USBIF_RING_SIZE	4096
+
+/*
+ * RING for transferring urbs.
+ */
+struct usbif_request_segment {
+	grant_ref_t gref;
+	uint16_t offset;
+	uint16_t length;
+};
+
+struct usbif_urb_request {
+	uint16_t id; /* request id */
+	uint16_t nr_buffer_segs; /* number of urb->transfer_buffer segments */
+
+	/* basic urb parameter */
+	uint32_t pipe;
+	uint16_t transfer_flags;
+#define USBIF_SHORT_NOT_OK	0x0001
+	uint16_t buffer_length;
+	union {
+		uint8_t ctrl[8]; /* setup_packet (Ctrl) */
+
+		struct {
+			uint16_t interval; /* maximum (1024*8) in usb core */
+			uint16_t start_frame; /* start frame */
+			uint16_t number_of_packets; /* number of ISO packet */
+			uint16_t nr_frame_desc_segs; /* number of iso_frame_desc segments */
+		} isoc;
+
+		struct {
+			uint16_t interval; /* maximum (1024*8) in usb core */
+			uint16_t pad[3];
+		} intr;
+
+		struct {
+			uint16_t unlink_id; /* unlink request id */
+			uint16_t pad[3];
+		} unlink;
+
+	} u;
+
+	/* urb data segments */
+	struct usbif_request_segment seg[USBIF_MAX_SEGMENTS_PER_REQUEST];
+};
+typedef struct usbif_urb_request usbif_urb_request_t;
+
+struct usbif_urb_response {
+	uint16_t id; /* request id */
+	uint16_t start_frame;  /* start frame (ISO) */
+	int32_t status; /* status (non-ISO) */
+	int32_t actual_length; /* actual transfer length */
+	int32_t error_count; /* number of ISO errors */
+};
+typedef struct usbif_urb_response usbif_urb_response_t;
+
+DEFINE_RING_TYPES(usbif_urb, struct usbif_urb_request, struct usbif_urb_response);
+#define USB_URB_RING_SIZE __CONST_RING_SIZE(usbif_urb, USBIF_RING_SIZE)
+
+/*
+ * RING for notifying connect/disconnect events to frontend
+ */
+struct usbif_conn_request {
+	uint16_t id;
+};
+typedef struct usbif_conn_request usbif_conn_request_t;
+
+struct usbif_conn_response {
+	uint16_t id; /* request id */
+	uint8_t portnum; /* port number */
+	uint8_t speed; /* usb_device_speed */
+#define USBIF_SPEED_NONE	0
+#define USBIF_SPEED_LOW		1
+#define USBIF_SPEED_FULL	2
+#define USBIF_SPEED_HIGH	3
+};
+typedef struct usbif_conn_response usbif_conn_response_t;
+
+DEFINE_RING_TYPES(usbif_conn, struct usbif_conn_request, struct usbif_conn_response);
+#define USB_CONN_RING_SIZE __CONST_RING_SIZE(usbif_conn, USBIF_RING_SIZE)
+
+#endif /* XEN_PUBLIC_IO_USBIF_H */
-- 
Anthony PERARD


