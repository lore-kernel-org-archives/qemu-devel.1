Received: from eggs.gnu.org ([2001:4830:134:3::10]:58483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8Q-0003XD-OD
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8P-0008U3-Ix
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8P-0008Tf-EB
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:09 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:15 +0200
Message-Id: <20180531171253.21012-16-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/53] hw: Do not include "sysemu/blockdev.h" if
 it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The header "hw/boards.h" already includes "sysemu/blockdev.h".

Code change produced with:

    $ git grep '#include "sysemu/blockdev.h"' hw | \
      cut -d: -f-1 | \
      xargs fgrep -l '#include "hw/boards.h"' | \
      xargs sed -i.bak '/#include "sysemu\/blockdev.h"/d'

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-14-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/aspeed.c        | 1 -
 hw/arm/omap1.c         | 1 -
 hw/arm/omap2.c         | 1 -
 hw/mips/mips_malta.c   | 1 -
 hw/ppc/ppc405_boards.c | 1 -
 hw/ppc/sam460ex.c      | 1 -
 6 files changed, 6 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index aecb3c1e75..a7110a712f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -19,7 +19,6 @@
 #include "hw/boards.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
=20
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 854996c1ac..9af04728e3 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -28,7 +28,6 @@
 #include "hw/arm/omap.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/soc_dma.h"
-#include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
 #include "qemu/range.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index cc4250b7da..3c7d1364a9 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -23,7 +23,6 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
 #include "hw/boards.h"
 #include "hw/hw.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index af70ecffc0..494f84e290 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -46,7 +46,6 @@
 #include "elf.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/timer/i8254.h"
-#include "sysemu/blockdev.h"
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"             /* SysBusDevice */
 #include "qemu/host-utils.h"
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 0b658931ee..d301067d3b 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -37,7 +37,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "hw/loader.h"
-#include "sysemu/blockdev.h"
 #include "exec/address-spaces.h"
=20
 #define BIOS_FILENAME "ppc405_rom.bin"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index a48e6e6fce..3dd23de71f 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -17,7 +17,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "sysemu/blockdev.h"
 #include "hw/boards.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
--=20
2.17.0
