Received: from eggs.gnu.org ([209.51.188.92]:39060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4i-0003TN-Ph
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4h-0000qj-0K
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEb4e-0000nb-Tg
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:10 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 11 Apr 2019 16:52:47 +0200
Message-Id: <20190411145256.8614-7-armbru@redhat.com>
In-Reply-To: <20190411145256.8614-1-armbru@redhat.com>
References: <20190411145256.8614-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/15] pci: Report fatal errors with
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
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6d13ef877b..1808b242dd 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -951,7 +951,7 @@ static uint16_t pci_req_id_cache_extract(PCIReqIDCache *cache)
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
