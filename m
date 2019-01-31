Received: from eggs.gnu.org ([209.51.188.92]:48473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpGQt-0007qH-NC
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpGQr-0008NQ-NX
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:47:23 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 31 Jan 2019 18:47:08 +0100
Message-Id: <1548956828-10210-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/s390x: Fix the function arguments in the
 pci stub file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

The arguments of the stub functions to not match the real implementation
(and the prototypes in the header) anymore, so if you try to compile s390x
without CONFIG_PCI, the build currently fails.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-pci-stub.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
index ad4c5a7..145759e 100644
--- a/hw/s390x/s390-pci-stub.c
+++ b/hw/s390x/s390-pci-stub.c
@@ -29,38 +29,40 @@ void s390_pci_sclp_deconfigure(SCCB *sccb)
 }
 
 /* target/s390x/kvm.c */
-int clp_service_call(S390CPU *cpu, uint8_t r2)
+int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
 {
     return -1;
 }
 
-int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
+int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 {
     return -1;
 }
 
-int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
+int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 {
     return -1;
 }
 
-int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
+int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
+                         uintptr_t ra)
 {
     return -1;
 }
 
-int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
+int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 {
     return -1;
 }
 
 int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
-                        uint8_t ar)
+                        uint8_t ar, uintptr_t ra)
 {
     return -1;
 }
 
-int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
+int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
+                        uintptr_t ra)
 {
     return -1;
 }
-- 
1.8.3.1
