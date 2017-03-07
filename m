Received: from eggs.gnu.org ([2001:4830:134:3::10]:34263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cl4cW-00083z-AZ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cl4cR-0002ZS-FK
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:13:00 -0500
Received: from mail.kernel.org ([198.145.29.136]:59454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cl4cR-0002ZD-9e
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:12:55 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon,  6 Mar 2017 18:12:42 -0800
Message-Id: <1488852768-8935-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1488852768-8935-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703061807431.17906@sstabellini-ThinkPad-X260>
	<1488852768-8935-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH 2/8] xen: introduce the header file for the Xen
 9pfs transport protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, jgross@suse.com

It uses the new ring.h macros to declare rings and interfaces.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
CC: anthony.perard@citrix.com
CC: jgross@suse.com
---
 hw/9pfs/xen_9pfs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 hw/9pfs/xen_9pfs.h

diff --git a/hw/9pfs/xen_9pfs.h b/hw/9pfs/xen_9pfs.h
new file mode 100644
index 0000000..c4e8901
--- /dev/null
+++ b/hw/9pfs/xen_9pfs.h
@@ -0,0 +1,20 @@
+#ifndef XEN_9PFS_H
+#define XEN_9PFS_H
+
+#include "hw/xen/io/ring.h"
+#include <xen/io/protocols.h>
+
+struct xen_9pfs_header {
+	uint32_t size;
+	uint8_t id;
+	uint16_t tag;
+
+	/* uint8_t sdata[]; */
+} __attribute__((packed));
+
+#define PAGE_SHIFT XC_PAGE_SHIFT
+#define XEN_9PFS_RING_ORDER 6
+#define XEN_9PFS_RING_SIZE  XEN_FLEX_RING_SIZE(XEN_9PFS_RING_ORDER)
+DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
+
+#endif
-- 
1.9.1
