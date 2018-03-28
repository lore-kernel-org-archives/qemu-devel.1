Received: from eggs.gnu.org ([2001:4830:134:3::10]:35675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f0zme-0003NY-1s
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 21:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f0zma-00023w-2g
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 21:21:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:51413)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f0zmZ-00022r-QC
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 21:21:44 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 28 Mar 2018 09:19:53 +0800
Message-Id: <20180328011953.19496-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH] vfio: remove DPRINTF() definition from
 vfio-common.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org

This macro isn't used by any VFIO code. And its name is
too generic. The vfio-common.h (in include/hw/vfio) can
be included by other modules in QEMU. It can introduce
conflicts.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 include/hw/vfio/vfio-common.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d9360148e6..cecbd4e386 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -34,15 +34,6 @@
 #define ERR_PREFIX "vfio error: %s: "
 #define WARN_PREFIX "vfio warning: %s: "
 
-/*#define DEBUG_VFIO*/
-#ifdef DEBUG_VFIO
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "vfio: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
     VFIO_DEVICE_TYPE_PLATFORM = 1,
-- 
2.11.0
