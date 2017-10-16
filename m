Received: from eggs.gnu.org ([2001:4830:134:3::10]:35107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <humbell@inf.ethz.ch>) id 1e48Dk-00077L-6z
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <humbell@inf.ethz.ch>) id 1e48Dh-0000ud-1n
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:26:28 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:11219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <humbell@inf.ethz.ch>) id 1e48Dg-0000se-QM
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:26:24 -0400
From: <lukas.humbel@inf.ethz.ch>
Date: Mon, 16 Oct 2017 18:03:36 +0200
Message-ID: <1508169816-5993-1-git-send-email-lukas.humbel@inf.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] hw/pci: Add e1000e NIC as command line argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lukas Humbel <lukas.humbel@inf.ethz.ch>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Lukas Humbel <lukas.humbel@inf.ethz.ch>

Signed-off-by: Lukas Humbel <lukas.humbel@inf.ethz.ch>
---
 hw/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1e6fb88..9d6cd04 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1819,6 +1819,7 @@ static const char * const pci_nic_models[] = {
     "i82559er",
     "rtl8139",
     "e1000",
+    "e1000e",
     "pcnet",
     "virtio",
     "sungem",
@@ -1832,6 +1833,7 @@ static const char * const pci_nic_names[] = {
     "i82559er",
     "rtl8139",
     "e1000",
+    "e1000e",
     "pcnet",
     "virtio-net-pci",
     "sungem",
-- 
2.7.4
