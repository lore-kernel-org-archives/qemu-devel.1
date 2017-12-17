Received: from eggs.gnu.org ([2001:4830:134:3::10]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQn8q-0008A3-OS
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:35:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQn8l-0003eR-ST
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:35:04 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:49 +0300
Message-Id: <59fa07bea2f0d340691ca3ed56311e2fdae681fa.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 44/61] hw/ide: remove old i386 dependency
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

and remove a duplicated include

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 1 -
 hw/ide/cmd646.c     | 1 -
 hw/ide/core.c       | 3 +--
 hw/ide/ich.c        | 1 -
 hw/ide/isa.c        | 1 -
 hw/ide/microdrive.c | 1 -
 hw/ide/pci.c        | 1 -
 hw/ide/piix.c       | 2 +-
 hw/ide/via.c        | 1 -
 9 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 373311f91a..451b18b419 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
=20
 #include "qemu/error-report.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 86b2a8f504..65aff518ec 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -24,7 +24,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 471d0c928b..1ea5812b7e 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -24,17 +24,16 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/blockdev.h"
 #include "sysemu/dma.h"
 #include "hw/block/block.h"
 #include "sysemu/block-backend.h"
 #include "qemu/cutils.h"
-#include "qemu/error-report.h"
=20
 #include "hw/ide/internal.h"
 #include "trace.h"
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 8dd0ced6b3..c01b24ecbe 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -63,7 +63,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 40213d662c..9fb24fc92b 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -24,7 +24,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index 17917c0b30..fde4d4645e 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -24,7 +24,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/pcmcia.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 25f1d36f3a..1ab0a892d0 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -24,7 +24,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index dfb21f65fa..a3afe1fd29 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -25,11 +25,11 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/blockdev.h"
 #include "sysemu/dma.h"
=20
 #include "hw/ide/pci.h"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 35c3059325..117ac4d95e 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -25,7 +25,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "sysemu/block-backend.h"
--=20
2.11.0
