Received: from eggs.gnu.org ([209.51.188.92]:49285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1CwM-0006rd-L3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1CwL-0002pf-Jz
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:29:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1CwL-0002ou-Bc
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:29:13 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Mar 2019 17:28:29 +0100
Message-Id: <20190305162829.20079-6-philmd@redhat.com>
In-Reply-To: <20190305162829.20079-1-philmd@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/5] mips_malta: Clean up definition of flash
 memory size somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

pflash_cfi01_register() takes a size in bytes, a block size in bytes
and a number of blocks.  mips_malta_init() passes BIOS_SIZE, 65536,
FLASH_SIZE >> 16.  Actually consistent only because BIOS_SIZE (defined
in include/hw/mips/bios.h as (4 * MiB)) matches FLASH_SIZE (defined
locally as 0x400000).  Confusing all the same.

Pass FLASH_SIZE instead of BIOS_SIZE.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
[PMD: rebased]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 04788ff50a..a5726edaa7 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1280,7 +1280,7 @@ void mips_malta_init(MachineState *machine)
 #endif
     }
     fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
-                               BIOS_SIZE,
+                               FLASH_SIZE,
                                pflash_blk,
                                65536, FLASH_SIZE >> 16,
                                4, 0x0000, 0x0000, 0x0000, 0x0000, be);
--=20
2.20.1
