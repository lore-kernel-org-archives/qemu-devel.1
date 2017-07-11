Received: from eggs.gnu.org ([2001:4830:134:3::10]:40867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxo-0002nM-Ff
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxl-0007j6-C5
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:56 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:02 +1000
Message-Id: <20170711043917.1757-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/17] spapr: refresh "platform-specific" hcalls
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

We have more of these since the addition of KVMPPC_H_LOGICAL_MEMOP in 2012.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/spapr.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 12bf969..a184ffa 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -377,9 +377,8 @@ struct sPAPRMachineState {
  * as well.
  *
  * We also need some hcalls which are specific to qemu / KVM-on-POWER.
- * So far we just need one for H_RTAS, but in future we'll need more
- * for extensions like virtio.  We put those into the 0xf000-0xfffc
- * range which is reserved by PAPR for "platform-specific" hcalls.
+ * We put those into the 0xf000-0xfffc range which is reserved by PAPR
+ * for "platform-specific" hcalls.
  */
 #define KVMPPC_HCALL_BASE       0xf000
 #define KVMPPC_H_RTAS           (KVMPPC_HCALL_BASE + 0x0)
-- 
2.9.4
