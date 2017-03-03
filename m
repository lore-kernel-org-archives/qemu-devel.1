Received: from eggs.gnu.org ([2001:4830:134:3::10]:58813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq4f-0002cO-8r
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq4e-0001mR-EZ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:28:57 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 17:28:50 +0100
Message-Id: <1488558530-21016-3-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] ppc: avoid typedef redefinitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, qemu-ppc@nongnu.org

These cause compilation failures on CentOS 6 or other operating
systems with older GCCs.

Cc: David Gibson <dgibson@redhat.com>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	It would probably be better to remove the
	sPAPRMachineState typedef from xics.h instead,
	but this is a quick fix to restore the centos6
	docker target.

 include/hw/ppc/spapr.h | 1 -
 include/hw/ppc/xics.h  | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index cfd2711..15f4371 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -21,7 +21,6 @@ typedef struct sPAPREventSource sPAPREventSource;
 #define SPAPR_TIMEBASE_FREQ     512000000ULL
 
 typedef struct sPAPRMachineClass sPAPRMachineClass;
-typedef struct sPAPRMachineState sPAPRMachineState;
 
 #define TYPE_SPAPR_MACHINE      "spapr-machine"
 #define SPAPR_MACHINE(obj) \
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1945913..9a5e715 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -139,9 +139,9 @@ struct ICSIRQState {
     uint8_t flags;
 };
 
-typedef struct XICSFabric {
+struct XICSFabric {
     Object parent;
-} XICSFabric;
+};
 
 #define TYPE_XICS_FABRIC "xics-fabric"
 #define XICS_FABRIC(obj)                                     \
-- 
1.8.3.1
