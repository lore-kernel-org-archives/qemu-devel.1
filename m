Received: from eggs.gnu.org ([2001:4830:134:3::10]:50527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRX-00008B-76
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRW-0001Ml-4K
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:23 -0400
Received: from [59.151.112.132] (port=40007 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRV-0001MR-OG
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:22 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 2 Jun 2017 15:54:38 +0800
Message-ID: <28378a4dc27a2694dfacf5254813d59175cda4e6.1496387804.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/6] pci: Add comment for
 pci_add_capability2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, armbru@redhat.com

Add a comment for pci_add_capability2() to explain the return
value. This may help to make a correct return value check for
its callers.

Cc: mst@redhat.com
Cc: marcel@redhat.com
Cc: armbru@redhat.com
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 53566b8..9810d5f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2276,6 +2276,10 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
     return ret;
 }
 
+/*
+ * On success, pci_add_capability2() returns a positive value.
+ * On failure, it sets an error and returns a negative value.
+ */
 int pci_add_capability2(PCIDevice *pdev, uint8_t cap_id,
                        uint8_t offset, uint8_t size,
                        Error **errp)
-- 
2.9.3
