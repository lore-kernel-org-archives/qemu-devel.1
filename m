Received: from eggs.gnu.org ([2001:4830:134:3::10]:50297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rIs-0004DC-Ot
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rIr-0008SZ-SY
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:42:28 -0300
Message-Id: <20180415234307.28132-3-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/41] hw: Do not include
 "sysemu/block-backend.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Remove those unneeded includes to speed up the compilation
process a little bit. (Missed in 7eceff5b5a1fa)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/cris/axis_dev88.c | 1 -
 hw/sh4/r2d.c         | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 9ccc4350a5..1775e53e25 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -34,7 +34,6 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "boot.h"
-#include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 458ed83297..f5f3deab37 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -40,7 +40,6 @@
 #include "hw/loader.h"
 #include "hw/usb.h"
 #include "hw/block/flash.h"
-#include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
 
 #define FLASH_BASE 0x00000000
-- 
2.17.0
