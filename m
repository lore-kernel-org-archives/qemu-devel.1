Received: from eggs.gnu.org ([209.51.188.92]:37569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1wks-0005Y4-4d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1wkr-0003Tm-Ib
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:24:26 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 18:23:58 +0100
Message-Id: <20190307172401.29451-10-armbru@redhat.com>
In-Reply-To: <20190307172401.29451-1-armbru@redhat.com>
References: <20190307172401.29451-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/12] pc_sysfw: Remove unused PcSysFwDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

This structure is not used since commit 6dd2a5c98a.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/pc_sysfw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 34727c5b1f..46b87afe23 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -40,11 +40,6 @@
=20
 #define BIOS_FILENAME "bios.bin"
=20
-typedef struct PcSysFwDevice {
-    SysBusDevice busdev;
-    uint8_t isapc_ram_fw;
-} PcSysFwDevice;
-
 static void pc_isa_bios_init(MemoryRegion *rom_memory,
                              MemoryRegion *flash_mem,
                              int ram_size)
--=20
2.17.2
