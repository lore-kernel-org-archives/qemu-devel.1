Received: from eggs.gnu.org ([2001:4830:134:3::10]:41539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHm-0003ZY-7I
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHl-00075E-9h
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:06 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 08:27:18 -0300
Message-Id: <20180305112732.26471-17-f4bug@amsat.org>
In-Reply-To: <20180305112732.26471-1-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 16/30] hw/sh4: use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, "open list:Block layer core" <qemu-block@nongnu.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/tc58128.c | 2 +-
 hw/sh4/r2d.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index 1d9f7ee000..3e658d509f 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -26,7 +26,7 @@ typedef struct {
 
 static tc58128_dev tc58128_devs[2];
 
-#define FLASH_SIZE (16*1024*1024)
+#define FLASH_SIZE (16 * M_BYTE)
 
 static void init_dev(tc58128_dev * dev, const char *filename)
 {
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 458ed83297..720bd6ad04 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -292,7 +292,7 @@ static void r2d_init(MachineState *machine)
     dinfo = drive_get(IF_PFLASH, 0, 0);
     pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          (16 * 1024), FLASH_SIZE >> 16,
+                          16 * K_BYTE, FLASH_SIZE >> 16,
                           1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
                           0x555, 0x2aa, 0);
 
-- 
2.16.2
