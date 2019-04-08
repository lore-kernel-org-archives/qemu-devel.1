Received: from eggs.gnu.org ([209.51.188.92]:49052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPld-0008DM-Tj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlc-0003i8-QL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDPlc-0003hB-HH
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:36 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Apr 2019 10:36:18 +0200
Message-Id: <20190408083627.7479-7-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-1-armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 06/15] pci: Report fatal errors with
 error_report(), not error_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 35451c1e99..a74995b596 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -927,7 +927,7 @@ static uint16_t pci_req_id_cache_extract(PCIReqIDCache *cache)
         result = PCI_BUILD_BDF(bus_n, 0);
         break;
     default:
-        error_printf("Invalid PCI requester ID cache type: %d\n",
+        error_report("Invalid PCI requester ID cache type: %d",
                      cache->type);
         exit(1);
         break;
-- 
2.17.2
