Received: from eggs.gnu.org ([2001:4830:134:3::10]:59592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd3d-0002v4-JF
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd3X-0005q3-Es
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:41 -0500
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:48113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRd3X-0005oW-79
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:35 -0500
Received: from player158.ha.ovh.net (unknown [10.109.146.132])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 8AF46196F14
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:05:33 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 27 Nov 2018 14:05:29 +0100
Message-ID: <154332392916.541746.3772338098005086592.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.0 3/9] ppc405_boards: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/ppc405_boards.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 3be3fe4432b4..f35b412c88dd 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -149,7 +149,7 @@ static void ref405ep_init(MachineState *machine)
     MemoryRegion *bios;
     MemoryRegion *sram = g_new(MemoryRegion, 1);
     ram_addr_t bdloc;
-    MemoryRegion *ram_memories = g_malloc(2 * sizeof(*ram_memories));
+    MemoryRegion *ram_memories = g_new(MemoryRegion, 2);
     hwaddr ram_bases[2], ram_sizes[2];
     target_ulong sram_size;
     long bios_size;
@@ -446,7 +446,7 @@ static void taihu_405ep_init(MachineState *machine)
     qemu_irq *pic;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *bios;
-    MemoryRegion *ram_memories = g_malloc(2 * sizeof(*ram_memories));
+    MemoryRegion *ram_memories = g_new(MemoryRegion, 2);
     MemoryRegion *ram = g_malloc0(sizeof(*ram));
     hwaddr ram_bases[2], ram_sizes[2];
     long bios_size;
