Received: from eggs.gnu.org ([2001:4830:134:3::10]:38285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZMEb-0003qB-5C
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZMEW-0004ef-8N
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:53 -0500
Received: from mail.kernel.org ([198.145.29.136]:45086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cZMEV-0004eQ-Qh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:48 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu,  2 Feb 2017 10:35:38 -0800
Message-Id: <1486060541-29146-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1486060541-29146-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1702021024200.17946@sstabellini-ThinkPad-X260>
	<1486060541-29146-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 2/5] xen-platform: add support for unplugging
 NVMe disks...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, peter.maydell@linaro.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

...not just IDE and SCSI.

This patch allows the Xen tool-stack to fully support of NVMe as an
emulated disk type. See [1] for the relevant tool-stack patch discussion.

[1] https://lists.xen.org/archives/html/xen-devel/2017-01/msg01225.html

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/i386/xen/xen_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index f50915f..7d41ebb 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -120,6 +120,7 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *o)
         break;
 
     case PCI_CLASS_STORAGE_SCSI:
+    case PCI_CLASS_STORAGE_EXPRESS:
         object_unparent(OBJECT(d));
         break;
 
-- 
1.9.1
