Received: from eggs.gnu.org ([2001:4830:134:3::10]:52768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQso4-0000pD-6n
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQso0-0003CU-8t
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:05:44 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:52267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQso0-0003BU-2z
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:05:40 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 8BFFE10EA3F
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 12:05:38 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 30 Jun 2017 12:05:32 +0200
Message-ID: <149881713243.18888.18140083803237379387.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: refresh "platform-specific" hcalls
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

We have more of these since the addition of KVMPPC_H_LOGICAL_MEMOP in 2012.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/hw/ppc/spapr.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a66bbac35242..1826cc4fd696 100644
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
