Received: from eggs.gnu.org ([2001:4830:134:3::10]:60377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2h1-0003OS-Mj
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2gy-0008Mz-TW
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:11 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZ2gy-0008MD-Lv
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:08 -0400
Received: by mail-lf0-x244.google.com with SMTP id k82so4722895lfg.0
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 15:16:08 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 01:15:43 +0300
Message-Id: <1500761743-1669-7-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v2 6/6] hw/pci: add hint capabilty for
 additional bus reservation to pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kraxel@redhat.com, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/pci-bridge/pcie_root_port.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index b0e49e1..ca92d85 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -106,6 +106,11 @@ static void rp_realize(PCIDevice *d, Error **errp)
     pcie_aer_root_init(d);
     rp_aer_vector_update(d);
 
+    rc = pci_bridge_help_cap_init(d, 0, p->bus_reserve, 0, 0, 0, errp);
+    if (rc < 0) {
+        goto err;
+    }
+
     return;
 
 err:
-- 
2.7.4
