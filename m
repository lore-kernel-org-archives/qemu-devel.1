Received: from eggs.gnu.org ([209.51.188.92]:42991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0taf-0001nQ-Vo
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0tac-0000co-F5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:49:32 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Mar 2019 20:48:55 +0100
Message-Id: <20190304194857.9780-3-philmd@redhat.com>
In-Reply-To: <20190304194857.9780-1-philmd@redhat.com>
References: <20190304194857.9780-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] hw/i386/pc_sysfw: Remove obsolete
 PcSysFwDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

This structure is not used since 6dd2a5c98a.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
2.20.1
