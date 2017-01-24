Received: from eggs.gnu.org ([2001:4830:134:3::10]:58937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cVyks-0005Cr-Jn
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cVykn-0006Zw-Oj
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:55:14 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 24 Jan 2017 11:55:07 +0100
Message-Id: <1485255307-11799-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/ppc: Remove unused POWERPC_FAMILY(POWER)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org

We do not support POWER1 CPUs in QEMU, so it does not make sense
to keep this stub around.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/translate_init.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 19ef250..70333c5 100644
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
1.8.3.1
