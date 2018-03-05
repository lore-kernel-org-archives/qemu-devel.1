Received: from eggs.gnu.org ([2001:4830:134:3::10]:41882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoI1-00044n-Ee
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHz-0007JN-WE
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:21 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 08:27:26 -0300
Message-Id: <20180305112732.26471-25-f4bug@amsat.org>
In-Reply-To: <20180305112732.26471-1-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 24/30] hw/ipack: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 hw/ipack/tpci200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index da05c8589d..56c0ad8932 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -597,9 +597,9 @@ static void tpci200_realize(PCIDevice *pci_dev, Error **errp)
     memory_region_init_io(&s->las1, OBJECT(s), &tpci200_las1_ops,
                           s, "tpci200_las1", 1024);
     memory_region_init_io(&s->las2, OBJECT(s), &tpci200_las2_ops,
-                          s, "tpci200_las2", 1024*1024*32);
+                          s, "tpci200_las2", 32 * M_BYTE);
     memory_region_init_io(&s->las3, OBJECT(s), &tpci200_las3_ops,
-                          s, "tpci200_las3", 1024*1024*16);
+                          s, "tpci200_las3", 16 * M_BYTE);
     pci_register_bar(&s->dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);
     pci_register_bar(&s->dev, 1, PCI_BASE_ADDRESS_SPACE_IO,     &s->io);
     pci_register_bar(&s->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->las0);
-- 
2.16.2
