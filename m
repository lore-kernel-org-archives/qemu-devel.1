Received: from eggs.gnu.org ([2001:4830:134:3::10]:52949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cMixv-00053b-Oq
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 17:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cMixs-0001cB-H8
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 17:14:27 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Thu, 29 Dec 2016 23:12:12 +0100
Message-Id: <1483049536-21548-3-git-send-email-hpoussin@reactos.org>
In-Reply-To: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/6] vga: increase priority of 0xa0000 memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

VGA device registers vram as BAR 0. If this BAR is activated as a very lo=
w address which
crosses 0xa0000-0xbffff, low memory region is not accessible anymore.

This fixes display on PReP machine if we enable PCI mapping at address 0.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 hw/display/vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 2a88b3c..c573f35 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2265,7 +2265,7 @@ void vga_init(VGACommonState *s, Object *obj, Memor=
yRegion *address_space,
     memory_region_add_subregion_overlap(address_space,
                                         0x000a0000,
                                         vga_io_memory,
-                                        1);
+                                        2);
     memory_region_set_coalescing(vga_io_memory);
     if (init_vga_ports) {
         portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");
--=20
2.1.4
