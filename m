Received: from eggs.gnu.org ([2001:4830:134:3::10]:57043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da48I-0002GB-5G
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da48F-0001rF-5G
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:34 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:42460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da48E-0001pS-Ub
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:31 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id BBBB511661A
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:00:29 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:00:22 +0200
Message-ID: <150100562212.27487.3148886355304043696.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 11/26] spapr_iommu: unregister vmstate
 at unrealize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_iommu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 8ec4e7a40834..40a44c563824 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -374,6 +374,8 @@ static void spapr_tce_table_unrealize(DeviceState *dev, Error **errp)
 {
     sPAPRTCETable *tcet = SPAPR_TCE_TABLE(dev);
 
+    vmstate_unregister(DEVICE(tcet), &vmstate_spapr_tce_table, tcet);
+
     QLIST_REMOVE(tcet, list);
 
     spapr_tce_table_disable(tcet);
