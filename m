Received: from eggs.gnu.org ([2001:4830:134:3::10]:60410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdP5-0007GN-PY
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdP4-0000Zw-Mt
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:43:43 -0500
Received: from mail.kernel.org ([198.145.29.136]:38258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdP4-0000Zg-Fy
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:43:42 -0500
Date: Tue, 31 Jan 2017 20:43:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485888144-16531-16-git-send-email-mst@redhat.com>
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485888144-16531-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v4 15/23] msix: Follow CODING_STYLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cao jin <caoj.fnst@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Cao jin <caoj.fnst@cn.fujitsu.com>

CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/msix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index ee1714d..c938a9b 100644
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
MST
