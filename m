Received: from eggs.gnu.org ([2001:4830:134:3::10]:58257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsX-0003gP-Ls
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsW-0002fX-Sq
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMFsW-0002fF-OH
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:44 -0400
Date: Fri, 25 May 2018 19:47:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527266793-301361-4-git-send-email-mst@redhat.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527266793-301361-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/20] hppa: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, peter.maydell@linaro.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/hppa/hppa_sys.h | 2 +-
 hw/hppa/machine.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/hppa_sys.h b/hw/hppa/hppa_sys.h
index a182d1f..f98cc8d 100644
--- a/hw/hppa/hppa_sys.h
+++ b/hw/hppa/hppa_sys.h
@@ -10,7 +10,7 @@
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
=20
-#include "hw/hppa/hppa_hardware.h"
+#include "hppa_hardware.h"
=20
 PCIBus *dino_init(MemoryRegion *, qemu_irq *, qemu_irq *);
=20
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a1d6b0e..aba269b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -16,7 +16,7 @@
 #include "hw/ide.h"
 #include "hw/timer/i8254.h"
 #include "hw/char/serial.h"
-#include "hw/hppa/hppa_sys.h"
+#include "hppa_sys.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
--=20
MST
