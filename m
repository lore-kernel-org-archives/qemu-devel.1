Received: from eggs.gnu.org ([2001:4830:134:3::10]:34620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBU-0008B4-3f
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBT-0004GR-56
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:12 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBT-0004FM-1c
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:11 -0500
Received: by mail-qt0-x242.google.com with SMTP id q18so10489809qtl.3
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:30:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:51 -0300
Message-Id: <20180215042900.16078-22-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 21/30] hw/misc: use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Jiri Slaby <jslaby@suse.cz>

It ease code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/auxbus.c | 2 +-
 hw/misc/edu.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index b4cacd664b..c78aaebcbe 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -68,7 +68,7 @@ AUXBus *aux_init_bus(DeviceState *parent, const char *name)
 
     /* Memory related. */
     bus->aux_io = g_malloc(sizeof(*bus->aux_io));
-    memory_region_init(bus->aux_io, OBJECT(bus), "aux-io", (1 << 20));
+    memory_region_init(bus->aux_io, OBJECT(bus), "aux-io", 2 * M_BYTE);
     address_space_init(&bus->aux_addr_space, bus->aux_io, "aux-io");
     return bus;
 }
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 34eb05d213..ce8235dfc4 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -357,7 +357,7 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
                        edu, QEMU_THREAD_JOINABLE);
 
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
-                    "edu-mmio", 1 << 20);
+                    "edu-mmio", 1 * M_BYTE);
     pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &edu->mmio);
 }
 
-- 
2.16.1
