Received: from eggs.gnu.org ([2001:4830:134:3::10]:50280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1U-00079N-Vu
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1R-0007Z1-OX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:36 -0500
Received: from [59.151.112.132] (port=54479 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1R-0007T8-DJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:33 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Tue, 17 Jan 2017 14:18:46 +0800
Message-ID: <1484633936-25344-2-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 01/11] msix: Follow CODING_STYLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/pci/msix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 0ec1cb14fc60..0cee631ecc55 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -447,8 +447,10 @@ void msix_notify(PCIDevice *dev, unsigned vector)
 {
     MSIMessage msg;
 
-    if (vector >= dev->msix_entries_nr || !dev->msix_entry_used[vector])
+    if (vector >= dev->msix_entries_nr || !dev->msix_entry_used[vector]) {
         return;
+    }
+
     if (msix_is_masked(dev, vector)) {
         msix_set_pending(dev, vector);
         return;
@@ -483,8 +485,10 @@ void msix_reset(PCIDevice *dev)
 /* Mark vector as used. */
 int msix_vector_use(PCIDevice *dev, unsigned vector)
 {
-    if (vector >= dev->msix_entries_nr)
+    if (vector >= dev->msix_entries_nr) {
         return -EINVAL;
+    }
+
     dev->msix_entry_used[vector]++;
     return 0;
 }
-- 
2.1.0
