Received: from eggs.gnu.org ([2001:4830:134:3::10]:40864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d61zb-00043y-KI
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d61zY-0004dB-Gp
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:39:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d61zY-0004cD-AL
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:39:24 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 03 May 2017 15:39:19 -0600
Message-ID: <20170503213915.11828.89858.stgit@gimli.home>
In-Reply-To: <20170503213659.11828.39423.stgit@gimli.home>
References: <20170503213659.11828.39423.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 3/3] vfio/pci: Fix incorrect error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

When the "No host device provided" error occurs, the hint message
that starts with "Use -vfio-pci," makes no sense, since "-vfio-pci"
is not a valid command line parameter.

Correct this by replacing "-vfio-pci" with "-device vfio-pci".

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 03a3d0154976..32aca7770177 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2625,8 +2625,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         if (!(~vdev->host.domain || ~vdev->host.bus ||
               ~vdev->host.slot || ~vdev->host.function)) {
             error_setg(errp, "No provided host device");
-            error_append_hint(errp, "Use -vfio-pci,host=DDDD:BB:DD.F "
-                              "or -vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
+            error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
+                              "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
             return;
         }
         vdev->vbasedev.sysfsdev =
