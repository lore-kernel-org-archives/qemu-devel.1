Received: from eggs.gnu.org ([2001:4830:134:3::10]:52325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k8-0007mW-JH
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k3-00048u-Dt
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:34 +1100
Message-Id: <20170202051445.5735-97-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 096/107] target/ppc: Remove unused
 POWERPC_FAMILY(POWER)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

We do not support POWER1 CPUs in QEMU, so it does not make sense
to keep this stub around.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c7f7624..76f79fa 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -5217,28 +5217,6 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
 
 /* Non-embedded PowerPC                                                      */
 
-/* POWER : same as 601, without mfmsr, mfsr                                  */
-POWERPC_FAMILY(POWER)(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
-
-    dc->desc = "POWER";
-    /* pcc->insns_flags = XXX_TODO; */
-    /* POWER RSC (from RAD6000) */
-    pcc->msr_mask = (1ull << MSR_EE) |
-                    (1ull << MSR_PR) |
-                    (1ull << MSR_FP) |
-                    (1ull << MSR_ME) |
-                    (1ull << MSR_FE0) |
-                    (1ull << MSR_SE) |
-                    (1ull << MSR_DE) |
-                    (1ull << MSR_AL) |
-                    (1ull << MSR_EP) |
-                    (1ull << MSR_IR) |
-                    (1ull << MSR_DR);
-}
-
 #define POWERPC_MSRR_601     (0x0000000000001040ULL)
 
 static void init_proc_601 (CPUPPCState *env)
-- 
2.9.3
