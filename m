Received: from eggs.gnu.org ([2001:4830:134:3::10]:40526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eeYm1-00029M-OH
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eeYm1-0005bI-1y
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:04:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:64671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1eeYm0-0005Wb-Pg
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:04:25 -0500
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 25 Jan 2018 12:03:27 +0800
Message-Id: <20180125040328.22867-6-tiwei.bie@intel.com>
In-Reply-To: <20180125040328.22867-1-tiwei.bie@intel.com>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH v1 5/6] vfio: remove DPRINTF() definition from
 vfio-common.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

This macro isn't used by any VFIO code. And its name is
too generic. The vfio-common.h (in include/hw/vfio) can
be included by other modules in QEMU. It can introduce
conflicts.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 include/hw/vfio/vfio-common.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 2383ded670..3fe99636f3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -33,15 +33,6 @@
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
2.13.3
