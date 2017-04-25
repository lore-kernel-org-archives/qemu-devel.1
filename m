Received: from eggs.gnu.org ([2001:4830:134:3::10]:53229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d2sSY-0001qu-N8
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 00:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d2sST-0002XW-Si
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 00:52:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d2sST-0002Wq-Ko
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 00:52:13 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3P4nFLe071513
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 00:52:12 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a1j61cn0n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 00:52:11 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 00:52:10 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 06:52:01 +0200
Message-Id: <20170425045201.71457-1-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC 1/1] vfio/pci: Fix incorrect error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, alex.williamson@redhat.com

When the "No host device provided" error occurs, the hint message
that starts with "Use -vfio-pci," makes no sense, since "-vfio-pci"
is not a valid command line parameter.

Correct this by replacing "-vfio-pci" with "-device vfio-pci".

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 03a3d01..32aca77 100644
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
-- 
2.10.2
