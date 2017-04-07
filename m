Received: from eggs.gnu.org ([2001:4830:134:3::10]:53440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwOCf-0000sU-5y
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwOCb-0007X4-8t
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:21:05 -0400
Received: from [45.249.212.188] (port=3413 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwOCa-0007Gw-PW
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:21:01 -0400
From: weiqi <weiqi4@huawei.com>
Date: Fri, 7 Apr 2017 14:59:08 +0800
Message-ID: <1491548348-61640-1-git-send-email-weiqi4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] esp-pci: simple clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, Wei Qi <weiqi4@huawei.com>

From: Wei Qi <weiqi4@huawei.com>

It is unnecessary to assign variable 'size' here, because 'size' unused after assignment.

Signed-off-by: Wei Qi <weiqi4@huawei.com>
---
 hw/scsi/esp-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index e295d88..1f5980e 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -192,7 +192,6 @@ static void esp_pci_io_write(void *opaque, hwaddr addr,
         val <<= shift;
         val |= current & ~(mask << shift);
         addr &= ~3;
-        size = 4;
     }
 
     if (addr < 0x40) {
-- 
1.8.3.1
