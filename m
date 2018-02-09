Received: from eggs.gnu.org ([2001:4830:134:3::10]:35384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ekDBG-0007Qj-Cu
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ekDBD-0005zU-73
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:13:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ekDBC-0005wn-Ul
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:13:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w19IDa0m041690
	for <qemu-devel@nongnu.org>; Fri, 9 Feb 2018 13:13:44 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g1fq1abe8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 13:13:43 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 9 Feb 2018 11:13:42 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri,  9 Feb 2018 16:13:30 -0200
Message-Id: <20180209181330.17371-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] hw/ppc: rename functions in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Commit bcb5ce08cf ("spapr: Rename machine init functions for clarity")
renamed ppc_spapr_reset to spapr_machine_reset and ppc_spapr_init
to spapr_machine_init. Let's also rename the references in
comments.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c       | 3 ++-
 hw/ppc/spapr_hcall.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 659be6b746..96515036e6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -464,7 +464,8 @@ static int spapr_populate_memory(sPAPRMachineState *spapr, void *fdt)
             }
         }
         if (!mem_start) {
-            /* ppc_spapr_init() checks for rma_size <= node0_size already */
+            /* spapr_machine_init() checks for rma_size <= node0_size
+             * already */
             spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
             mem_start += spapr->rma_size;
             node_size -= spapr->rma_size;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 4d0e6eb0cf..badf01cece 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1635,7 +1635,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov1_guest,
                                                           OV1_PPC_3_00);
     if (!spapr->cas_reboot) {
-        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
+        /* If spapr_machine_reset() did not set up a HPT but one is necessary
          * (because the guest isn't going to use radix) then set it up here. */
         if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
             /* legacy hash or new hash: */
-- 
2.14.3
