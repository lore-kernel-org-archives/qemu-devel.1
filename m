Received: from eggs.gnu.org ([2001:4830:134:3::10]:39444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKPjn-0000ot-VN
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKPjm-0008QA-RE
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:50:36 -0400
Received: from [59.151.112.132] (port=3263 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKPjm-0008Pr-FV
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:50:34 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 12 Jun 2017 21:48:28 +0800
Message-ID: <419cb616b32171046db02617863b55dec93fdc3f.1497272778.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1497272778.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1497272778.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 2/9] pci: Add comment for
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

Comments for pci_add_capability2() to explain the return
value. This may help to make a correct return value check
for its callers.

Cc: mst@redhat.com
Cc: marcel@redhat.com
Cc: armbru@redhat.com
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 53566b8..b73bfea 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2276,6 +2276,12 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
     return ret;
 }
 
+/*
+ * On success, pci_add_capability2() returns a positive value
+ * that the offset of the pci capability.
+ * On failure, it sets an error and returns a negative error
+ * code.
+ */
 int pci_add_capability2(PCIDevice *pdev, uint8_t cap_id,
                        uint8_t offset, uint8_t size,
                        Error **errp)
-- 
2.9.3
