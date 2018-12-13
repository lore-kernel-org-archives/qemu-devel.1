Received: from eggs.gnu.org ([2001:4830:134:3::10]:50668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC5-0003ch-Ly
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC3-00025m-Bv
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:49 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:05 +1100
Message-Id: <20181213040126.6768-7-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/27] ppc405_boards: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405_boards.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 3be3fe4432..f35b412c88 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -149,7 +149,7 @@ static void ref405ep_init(MachineState *machine)
     MemoryRegion *bios;
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
     ram_addr_t bdloc;
-    MemoryRegion *ram_memories =3D g_malloc(2 * sizeof(*ram_memories));
+    MemoryRegion *ram_memories =3D g_new(MemoryRegion, 2);
     hwaddr ram_bases[2], ram_sizes[2];
     target_ulong sram_size;
     long bios_size;
@@ -446,7 +446,7 @@ static void taihu_405ep_init(MachineState *machine)
     qemu_irq *pic;
     MemoryRegion *sysmem =3D get_system_memory();
     MemoryRegion *bios;
-    MemoryRegion *ram_memories =3D g_malloc(2 * sizeof(*ram_memories));
+    MemoryRegion *ram_memories =3D g_new(MemoryRegion, 2);
     MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
     hwaddr ram_bases[2], ram_sizes[2];
     long bios_size;
--=20
2.19.2
