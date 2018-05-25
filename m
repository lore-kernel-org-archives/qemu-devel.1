Received: from eggs.gnu.org ([2001:4830:134:3::10]:52600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYP-0006RM-5h
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYL-00083J-UT
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:25 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:55:08 -0400
Message-Id: <20180525235509.11282-16-jsnow@redhat.com>
In-Reply-To: <20180525235509.11282-1-jsnow@redhat.com>
References: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 15/16] ahci: delete old host register address
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
