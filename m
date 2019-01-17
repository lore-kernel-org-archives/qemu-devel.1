Received: from eggs.gnu.org ([209.51.188.92]:43172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjxwv-000871-LC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjxme-00065L-Ux
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 21:51:57 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 17 Jan 2019 13:51:14 +1100
Message-Id: <20190117025115.81178-3-aik@ozlabs.ru>
In-Reply-To: <20190117025115.81178-1-aik@ozlabs.ru>
References: <20190117025115.81178-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 2/3] vfio: Make vfio_get_region_info_cap
 public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>

This makes vfio_get_region_info_cap() to be used in quirks.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/vfio/vfio-common.h | 2 ++
 hw/vfio/common.c              | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1b434d0..abc82f9 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -189,6 +189,8 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
                              uint32_t subtype, struct vfio_region_info **info);
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
+struct vfio_info_cap_header *
+vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id);
 #endif
 extern const MemoryListener vfio_prereg_listener;
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c185e5a..f58b487 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -711,7 +711,7 @@ static void vfio_listener_release(VFIOContainer *container)
     }
 }
 
-static struct vfio_info_cap_header *
+struct vfio_info_cap_header *
 vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
 {
     struct vfio_info_cap_header *hdr;
-- 
2.17.1
