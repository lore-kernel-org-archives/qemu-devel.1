Received: from eggs.gnu.org ([2001:4830:134:3::10]:46305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrT-0001vO-KF
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrR-0004QW-MA
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:49171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPrR-0004Oi-Bm
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:09 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301977-24481-7-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
References: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [Intel-gfx][RFC 6/9] drm/i915/gvt: Introduce new flag
 to indicate migration capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 26 Jun 2017 08:59:12 -0000
To: qemu-devel@nongnu.org
Cc: zhenyuw@linux.intel.com, zhi.a.wang@intel.com, joonas.lahtinen@linux.intel.com, kevin.tian@intel.com, xiao.zheng@intel.com, Yulei Zhang <yulei.zhang@intel.com>

New device flag VFIO_DEVICE_FLAGS_MIGRATABLE is added for vfio mdev
device vGPU to claim the capability for live migration.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 1 +
 include/uapi/linux/vfio.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index d2b13ae..c44b319 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -940,6 +940,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 
 		info.flags = VFIO_DEVICE_FLAGS_PCI;
 		info.flags |= VFIO_DEVICE_FLAGS_RESET;
+		info.flags |= VFIO_DEVICE_FLAGS_MIGRATABLE;
 		info.num_regions = VFIO_PCI_NUM_REGIONS;
 		info.num_irqs = VFIO_PCI_NUM_IRQS;
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ae46105..9ad9ce1 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -199,6 +199,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
 #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
+#define VFIO_DEVICE_FLAGS_MIGRATABLE (1 << 5)   /* Device supports migrate */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
-- 
2.7.4
