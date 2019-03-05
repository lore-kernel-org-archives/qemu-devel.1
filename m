Received: from eggs.gnu.org ([209.51.188.92]:49090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Cw4-0006YW-9w
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Cw3-0002Xm-Km
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:28:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1Cw3-0002X1-EJ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:28:55 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Mar 2019 17:28:26 +0100
Message-Id: <20190305162829.20079-3-philmd@redhat.com>
In-Reply-To: <20190305162829.20079-1-philmd@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/5] hw/mips/malta: Remove fl_sectors variable
 (used one single time)
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

fl_sectors is only used in one place, with bios_size =3D FLASH_SIZE.
Use it directly and remove the variable.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_malta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index b4cd8f02ad..00e5aac98b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1210,7 +1210,6 @@ void mips_malta_init(MachineState *machine)
     DriveInfo *dinfo;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int fl_idx =3D 0;
-    int fl_sectors =3D bios_size >> 16;
     int be;
=20
     DeviceState *dev =3D qdev_create(NULL, TYPE_MIPS_MALTA);
@@ -1279,7 +1278,7 @@ void mips_malta_init(MachineState *machine)
     fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
                                BIOS_SIZE,
                                pflash_blk,
-                               65536, fl_sectors,
+                               65536, FLASH_SIZE >> 16,
                                4, 0x0000, 0x0000, 0x0000, 0x0000, be);
     bios =3D pflash_cfi01_get_memory(fl);
     fl_idx++;
--=20
2.20.1
