Received: from eggs.gnu.org ([2001:4830:134:3::10]:60489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcvvq-0007MM-5D
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcvvm-0003YY-4p
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dcvvl-0003Y8-S1
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:51:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3755E81241
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 15:51:28 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed,  2 Aug 2017 18:51:13 +0300
Message-Id: <20170802155113.62471-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH] docs/pcie.txt: Replace ioh3420 with
 pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, lersek@redhat.com, mst@redhat.com, drjones@redhat.com

Do not mention ioh3420 in the "how to" doc.
The device still works and can be used by already
existing setups, but no need to be mentioned.

Suggested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 docs/pcie.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/docs/pcie.txt b/docs/pcie.txt
index 5bada24..f990033 100644
--- a/docs/pcie.txt
+++ b/docs/pcie.txt
@@ -43,8 +43,8 @@ Place only the following kinds of devices directly on the Root Complex:
         strangely when PCI Express devices are integrated
         with the Root Complex.
 
-    (2) PCI Express Root Ports (ioh3420), for starting exclusively PCI Express
-        hierarchies.
+    (2) PCI Express Root Ports (pcie-root-port), for starting exclusively
+        PCI Express hierarchies.
 
     (3) DMI-PCI Bridges (i82801b11-bridge), for starting legacy PCI
         hierarchies.
@@ -65,7 +65,7 @@ Place only the following kinds of devices directly on the Root Complex:
           -device pxb-pcie,id=pcie.1,bus_nr=x[,numa_node=y][,addr=z]
       Only PCI Express Root Ports and DMI-PCI bridges can be connected
       to the pcie.1 bus:
-          -device ioh3420,id=root_port1[,bus=pcie.1][,chassis=x][,slot=y][,addr=z]                                     \
+          -device pcie-root-port,id=root_port1[,bus=pcie.1][,chassis=x][,slot=y][,addr=z]                                     \
           -device i82801b11-bridge,id=dmi_pci_bridge1,bus=pcie.1
 
 
@@ -107,14 +107,14 @@ Plug only PCI Express devices into PCI Express Ports.
                                              ------------
 
 2.2.1 Plugging a PCI Express device into a PCI Express Root Port:
-          -device ioh3420,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]  \
+          -device pcie-root-port,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]  \
           -device <dev>,bus=root_port1
 2.2.2 Using multi-function PCI Express Root Ports:
-      -device ioh3420,id=root_port1,multifunction=on,chassis=x,addr=z.0[,slot=y][,bus=pcie.0] \
-      -device ioh3420,id=root_port2,chassis=x1,addr=z.1[,slot=y1][,bus=pcie.0] \
-      -device ioh3420,id=root_port3,chassis=x2,addr=z.2[,slot=y2][,bus=pcie.0] \
+      -device pcie-root-port,id=root_port1,multifunction=on,chassis=x,addr=z.0[,slot=y][,bus=pcie.0] \
+      -device pcie-root-port,id=root_port2,chassis=x1,addr=z.1[,slot=y1][,bus=pcie.0] \
+      -device pcie-root-port,id=root_port3,chassis=x2,addr=z.2[,slot=y2][,bus=pcie.0] \
 2.2.3 Plugging a PCI Express device into a Switch:
-      -device ioh3420,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]  \
+      -device pcie-root-port,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]  \
       -device x3130-upstream,id=upstream_port1,bus=root_port1[,addr=x]          \
       -device xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=x1,slot=y1[,addr=z1]] \
       -device <dev>,bus=downstream_port1
-- 
2.9.4
