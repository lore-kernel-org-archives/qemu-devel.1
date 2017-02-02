Received: from eggs.gnu.org ([2001:4830:134:3::10]:52700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kG-0007wr-JE
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kA-0004Hv-7t
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:44 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:30 +1100
Message-Id: <20170202051445.5735-93-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 092/107] powerpc/cpu-models: rename ISAv3.00
 logical PVR definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This logical PVR value now corresponds to ISA version 3.00 so rename it
accordingly.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-models.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index aafbbd7..d587e69 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -601,7 +601,7 @@ enum {
     CPU_POWERPC_LOGICAL_2_06       = 0x0F000003,
     CPU_POWERPC_LOGICAL_2_06_PLUS  = 0x0F100003,
     CPU_POWERPC_LOGICAL_2_07       = 0x0F000004,
-    CPU_POWERPC_LOGICAL_2_08       = 0x0F000005,
+    CPU_POWERPC_LOGICAL_3_00       = 0x0F000005,
 };
 
 /* System version register (used on MPC 8xxx)                                */
-- 
2.9.3
