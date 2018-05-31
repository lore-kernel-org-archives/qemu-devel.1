Received: from eggs.gnu.org ([2001:4830:134:3::10]:34558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW40-0000tU-7t
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3z-0004GE-D9
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:56 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 May 2018 18:28:34 -0400
Message-Id: <20180531222835.16558-16-jsnow@redhat.com>
In-Reply-To: <20180531222835.16558-1-jsnow@redhat.com>
References: <20180531222835.16558-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/16] ahci: delete old host register
 address definitions
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci_internal.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index f9dcf8b6e6..2953243929 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -55,12 +55,6 @@
 #define RX_FIS_UNK                0x60 /* offset of Unknown FIS data */
 
 /* global controller registers */
-#define HOST_CAP                  0x00 /* host capabilities */
-#define HOST_CTL                  0x04 /* global host control */
-#define HOST_IRQ_STAT             0x08 /* interrupt status */
-#define HOST_PORTS_IMPL           0x0c /* bitmap of implemented ports */
-#define HOST_VERSION              0x10 /* AHCI spec. version compliancy */
-
 enum AHCIHostReg {
     AHCI_HOST_REG_CAP        = 0,  /* CAP: host capabilities */
     AHCI_HOST_REG_CTL        = 1,  /* GHC: global host control */
-- 
2.14.3
