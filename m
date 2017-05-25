Received: from eggs.gnu.org ([2001:4830:134:3::10]:57199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoM-0006UL-K9
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoL-0007Ru-Nt
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:15 +1000
Message-Id: <20170525035132.24268-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/18] target/ppc: reset reservation in do_rfi()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

For transitioning back to userspace after the interrupt.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a6bcb47..9cb2123 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -995,6 +995,9 @@ static inline void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
      */
     cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
 
+    /* Reset the reservation */
+    env->reserve_addr = -1;
+
     /* Context synchronizing: check if TCG TLB needs flush */
     check_tlb_flush(env, false);
 }
-- 
2.9.4
