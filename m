Received: from eggs.gnu.org ([2001:4830:134:3::10]:34440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3t-0000nK-J3
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3s-00049v-T3
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:49 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 May 2018 18:28:29 -0400
Message-Id: <20180531222835.16558-11-jsnow@redhat.com>
In-Reply-To: <20180531222835.16558-1-jsnow@redhat.com>
References: <20180531222835.16558-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/16] ahci: fix host register max address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: f4bug@amsat.org, John Snow <jsnow@redhat.com>

Yes, comment, it ought to be 0x2C.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci_internal.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index af366db6f3..f9dcf8b6e6 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -224,8 +224,7 @@ enum AHCIPortIRQ {
 #define SATA_SIGNATURE_CDROM               0xeb140101
 #define SATA_SIGNATURE_DISK                0x00000101
 
-#define AHCI_GENERIC_HOST_CONTROL_REGS_MAX_ADDR 0x20
-                                            /* Shouldn't this be 0x2c? */
+#define AHCI_GENERIC_HOST_CONTROL_REGS_MAX_ADDR 0x2c
 
 #define AHCI_PORT_REGS_START_ADDR          0x100
 #define AHCI_PORT_ADDR_OFFSET_MASK         0x7f
-- 
2.14.3
