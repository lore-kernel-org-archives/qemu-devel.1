Received: from eggs.gnu.org ([209.51.188.92]:44799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4z-0005dV-HZ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4v-0007Wd-PL
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4t-0007Uj-Pa
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:45 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:06 +0100
Message-Id: <1547460140-1473-12-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/25] hw/pcmcia: Remove PCMCIACardState from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

There is only one header file requiring this typedef (hw/arm/pxa.h),
let it include "hw/pcmcia.h" directly to simplify "qemu/typedefs.h".

To clean "qemu/typedefs.h", move the declaration to "hw/pcmcia.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[thuth: slightly tweaked commit message]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/arm/pxa.h    | 1 +
 include/hw/pcmcia.h     | 4 ++--
 include/qemu/typedefs.h | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 0df1199..f6dfb5c 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -12,6 +12,7 @@
=20
 #include "exec/memory.h"
 #include "target/arm/cpu-qom.h"
+#include "hw/pcmcia.h"
=20
 /* Interrupt numbers */
 # define PXA2XX_PIC_SSP3	0
diff --git a/include/hw/pcmcia.h b/include/hw/pcmcia.h
index 79cac9c..1b40807 100644
--- a/include/hw/pcmcia.h
+++ b/include/hw/pcmcia.h
@@ -18,13 +18,13 @@ typedef struct PCMCIASocket {
 #define PCMCIA_CARD_CLASS(cls) \
     OBJECT_CLASS_CHECK(PCMCIACardClass, cls, TYPE_PCMCIA_CARD)
=20
-struct PCMCIACardState {
+typedef struct PCMCIACardState {
     /*< private >*/
     DeviceState parent_obj;
     /*< public >*/
=20
     PCMCIASocket *slot;
-};
+} PCMCIACardState;
=20
 typedef struct PCMCIACardClass {
     /*< private >*/
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 28a8b9e..3bd9215 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -78,7 +78,6 @@ typedef struct PCIHostDeviceAddress PCIHostDeviceAddres=
s;
 typedef struct PCIHostState PCIHostState;
 typedef struct PCMachineClass PCMachineClass;
 typedef struct PCMachineState PCMachineState;
-typedef struct PCMCIACardState PCMCIACardState;
 typedef struct PixelFormat PixelFormat;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
--=20
1.8.3.1
