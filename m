Received: from eggs.gnu.org ([2001:4830:134:3::10]:42179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQb-0000YL-7o
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQa-0006UL-CL
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:41 -0300
Message-Id: <20171006235023.11952-47-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 46/88] hw/display/vga: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Gerd: should those files go under Graphics section in MAINTAINERS?

 hw/display/vga-isa-mm.c | 6 +++---
 hw/display/vga.c        | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index 51ccbccc41..7af72864df 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -105,12 +105,12 @@ static void vga_mm_init(ISAVGAMMState *s, hwaddr vram_base,
     MemoryRegion *s_ioport_ctrl, *vga_io_memory;
 
     s->it_shift = it_shift;
-    s_ioport_ctrl = g_malloc(sizeof(*s_ioport_ctrl));
+    s_ioport_ctrl = g_new(MemoryRegion, 1);
     memory_region_init_io(s_ioport_ctrl, NULL, &vga_mm_ctrl_ops, s,
                           "vga-mm-ctrl", 0x100000);
     memory_region_set_flush_coalesced(s_ioport_ctrl);
 
-    vga_io_memory = g_malloc(sizeof(*vga_io_memory));
+    vga_io_memory = g_new(MemoryRegion, 1);
     /* XXX: endianness? */
     memory_region_init_io(vga_io_memory, NULL, &vga_mem_ops, &s->vga,
                           "vga-mem", 0x20000);
@@ -130,7 +130,7 @@ int isa_vga_mm_init(hwaddr vram_base,
 {
     ISAVGAMMState *s;
 
-    s = g_malloc0(sizeof(*s));
+    s = g_new0(ISAVGAMMState, 1);
 
     s->vga.vram_size_mb = VGA_RAM_SIZE >> 20;
     vga_common_init(&s->vga, NULL, true);
diff --git a/hw/display/vga.c b/hw/display/vga.c
index ed24ef7076..bdefa60f30 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2236,7 +2236,7 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
     *vga_ports = vga_portio_list;
     *vbe_ports = vbe_portio_list;
 
-    vga_mem = g_malloc(sizeof(*vga_mem));
+    vga_mem = g_new(MemoryRegion, 1);
     memory_region_init_io(vga_mem, obj, &vga_mem_ops, s,
                           "vga-lowmem", 0x20000);
     memory_region_set_flush_coalesced(vga_mem);
-- 
2.14.2
