Received: from eggs.gnu.org ([2001:4830:134:3::10]:37305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQilr-0005Fr-1J
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 18:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQiln-0005sh-6I
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 18:55:03 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:42 +0300
Message-Id: <37c4c1a375fefadd9b09b704a97c8f9598624dce.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/61] misc: avoid "include/" in include path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/adb.c      | 2 +-
 hw/ssi/aspeed_smc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index fcca3a8eb9..924a3f9fd5 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -24,8 +24,8 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/input/adb.h"
+#include "hw/input/adb-keys.h"
 #include "ui/console.h"
-#include "include/hw/input/adb-keys.h"
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index cb515730c5..992617fd3a 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
-#include "include/qemu/error-report.h"
+#include "qemu/error-report.h"
 #include "exec/address-spaces.h"
=20
 #include "hw/ssi/aspeed_smc.h"
--=20
2.11.0
