Received: from eggs.gnu.org ([2001:4830:134:3::10]:55819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6Sc-0001E5-Do
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6SX-0004mg-Ha
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:21:02 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6SX-0004l7-Bm
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:20:57 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so58086135wmi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:20:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:20:52 +0100
Message-Id: <1485523252-88288-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] s390-pci: fix compilation on older GCC versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cornelia.huck@de.ibm.com, borntraeger@de.ibm.com

S390PCIBusDevice is typedef'ed earlier in the file, before the hunks
that this patch modifies.  The double typedef causes old versions of
GCC to complain.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/s390x/s390-pci-bus.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index b0adefa..a25e926 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -279,7 +279,7 @@ typedef struct S390PCIIOMMUTable {
     S390PCIIOMMU *iommu[PCI_SLOT_MAX];
 } S390PCIIOMMUTable;
 
-typedef struct S390PCIBusDevice {
+struct S390PCIBusDevice {
     DeviceState qdev;
     PCIDevice *pdev;
     ZpciState state;
@@ -301,7 +301,7 @@ typedef struct S390PCIBusDevice {
     IndAddr *indicator;
     QEMUTimer *release_timer;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
-} S390PCIBusDevice;
+};
 
 typedef struct S390PCIBus {
     BusState qbus;
-- 
1.8.3.1
