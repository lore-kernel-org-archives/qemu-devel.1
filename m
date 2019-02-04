Received: from eggs.gnu.org ([209.51.188.92]:39255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9v-0001at-1a
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9o-0000k8-EQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:03:18 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:22 +1100
Message-Id: <20190204090124.26191-36-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/37] hw/ppc: Don't include m48t59.h if it is
 not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

These files don't use anything from m48t59.h, so no need to include
this header here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_newworld.c | 1 -
 hw/ppc/mac_oldworld.c | 1 -
 hw/ppc/ppc.c          | 2 --
 hw/ppc/ppc_booke.c    | 1 -
 4 files changed, 5 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index bb19eaba36..f1c8400efd 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -53,7 +53,6 @@
 #include "hw/ppc/mac.h"
 #include "hw/input/adb.h"
 #include "hw/ppc/mac_dbdma.h"
-#include "hw/timer/m48t59.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 817f70e52c..98d531d114 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -30,7 +30,6 @@
 #include "hw/ppc/ppc.h"
 #include "mac.h"
 #include "hw/input/adb.h"
-#include "hw/timer/m48t59.h"
 #include "sysemu/sysemu.h"
 #include "net/net.h"
 #include "hw/isa/isa.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 98b409f83d..cffdc3914a 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -30,10 +30,8 @@
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
-#include "hw/timer/m48t59.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "hw/loader.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
 #include "trace.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 23bcf1b138..4f11e00a17 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -28,7 +28,6 @@
 #include "hw/ppc/ppc.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
-#include "hw/timer/m48t59.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "kvm_ppc.h"
--=20
2.20.1
