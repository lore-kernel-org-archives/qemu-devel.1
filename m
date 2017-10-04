Received: from eggs.gnu.org ([2001:4830:134:3::10]:48490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dzfHE-0008TA-QJ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dzfHB-00050Y-Lq
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:43:36 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:38824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dzfHB-0004zi-G4
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:43:33 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 1678E1353CD
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:43:31 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 04 Oct 2017 10:43:18 +0200
Message-ID: <150710659849.14714.9839994452901108634.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: fix RTAS method name in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 352ff3d614e8..b284e0b9d43e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2334,7 +2334,8 @@ static void ppc_spapr_init(MachineState *machine)
     /* Set up Interrupt Controller before we create the VCPUs */
     xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
 
-    /* Set up containers for ibm,client-set-architecture negotiated options */
+    /* Set up containers for ibm,client-architecture-support negotiated options
+     */
     spapr->ov5 = spapr_ovec_new();
     spapr->ov5_cas = spapr_ovec_new();
 
