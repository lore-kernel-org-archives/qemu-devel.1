Received: from eggs.gnu.org ([2001:4830:134:3::10]:34316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3q-0000jw-6l
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3p-00045G-7d
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:46 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 May 2018 18:28:24 -0400
Message-Id: <20180531222835.16558-6-jsnow@redhat.com>
In-Reply-To: <20180531222835.16558-1-jsnow@redhat.com>
References: <20180531222835.16558-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/16] ahci: combine identical clauses in
 port write
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
 hw/ide/ahci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 92780990a3..476841df58 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -330,11 +330,7 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
         check_cmd(s, port);
         break;
     case PORT_TFDATA:
-        /* Read Only. */
-        break;
     case PORT_SIG:
-        /* Read Only */
-        break;
     case PORT_SCR_STAT:
         /* Read Only */
         break;
-- 
2.14.3
