Received: from eggs.gnu.org ([2001:4830:134:3::10]:52411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYK-0006LY-RN
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYJ-0007xz-5k
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:55:01 -0400
Message-Id: <20180525235509.11282-9-jsnow@redhat.com>
In-Reply-To: <20180525235509.11282-1-jsnow@redhat.com>
References: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 08/16] ahci: delete old port register address
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>

They're now unused.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci_internal.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index eb7e1eefc0..db00c9aa39 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -102,24 +102,6 @@ enum AHCIPortReg {
     AHCI_PORT_REG__COUNT      = 32
 };
 
-/* registers for each SATA port */
-#define PORT_LST_ADDR             0x00 /* command list DMA addr */
-#define PORT_LST_ADDR_HI          0x04 /* command list DMA addr hi */
-#define PORT_FIS_ADDR             0x08 /* FIS rx buf addr */
-#define PORT_FIS_ADDR_HI          0x0c /* FIS rx buf addr hi */
-#define PORT_IRQ_STAT             0x10 /* interrupt status */
-#define PORT_IRQ_MASK             0x14 /* interrupt enable/disable mask */
-#define PORT_CMD                  0x18 /* port command */
-
-#define PORT_TFDATA               0x20 /* taskfile data */
-#define PORT_SIG                  0x24 /* device TF signature */
-#define PORT_SCR_STAT             0x28 /* SATA phy register: SStatus */
-#define PORT_SCR_CTL              0x2c /* SATA phy register: SControl */
-#define PORT_SCR_ERR              0x30 /* SATA phy register: SError */
-#define PORT_SCR_ACT              0x34 /* SATA phy register: SActive */
-#define PORT_CMD_ISSUE            0x38 /* command issue */
-#define PORT_RESERVED             0x3c /* reserved */
-
 /* Port interrupt bit descriptors */
 enum AHCIPortIRQ {
     AHCI_PORT_IRQ_BIT_DHRS = 0,
-- 
2.14.3
