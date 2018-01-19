Received: from eggs.gnu.org ([2001:4830:134:3::10]:53899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecZxA-0007q8-FE
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecZx9-0002td-ML
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:55:44 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 19 Jan 2018 16:55:25 +0000
Message-Id: <1516380925-15651-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/vfio/platform: Init the interrupt mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Add the initialization of the mutex protecting the interrupt list.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index da84abf..0d4bc0a 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -643,6 +643,8 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     vbasedev->dev = dev;
     vbasedev->ops = &vfio_platform_ops;
 
+    qemu_mutex_init(&vdev->intp_mutex);
+
     trace_vfio_platform_realize(vbasedev->sysfsdev ?
                                 vbasedev->sysfsdev : vbasedev->name,
                                 vdev->compat);
-- 
1.9.1
