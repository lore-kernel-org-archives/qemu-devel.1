Received: from eggs.gnu.org ([2001:4830:134:3::10]:59904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2dD-0000Qg-T8
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2dC-0006l0-Rb
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:15 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZ2dC-0006kl-KQ
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:14 -0400
Received: by mail-lf0-x242.google.com with SMTP id t128so758235lff.3
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 15:12:14 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 01:11:48 +0300
Message-Id: <1500761510-1556-3-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v2 2/4] pci: add RedHat vendor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: marcel@redhat.com, kraxel@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 src/hw/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/hw/pci_ids.h b/src/hw/pci_ids.h
index 4ac73b4..db2e694 100644
--- a/src/hw/pci_ids.h
+++ b/src/hw/pci_ids.h
@@ -2263,6 +2263,8 @@
 #define PCI_DEVICE_ID_KORENIX_JETCARDF0	0x1600
 #define PCI_DEVICE_ID_KORENIX_JETCARDF1	0x16ff
 
+#define PCI_VENDOR_ID_REDHAT 		0x1b36
+
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
-- 
2.7.4
