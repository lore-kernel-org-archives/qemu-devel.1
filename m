Received: from eggs.gnu.org ([209.51.188.92]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxe6-0005j5-22
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxVA-0000Xt-Le
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:09:37 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:44 +0100
Message-Id: <20190111140857.4211-3-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/15] hw/pcmcia: Remove PCMCIACardState from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrzej Zaborowski <balrogg@gmail.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

There is only one file requiring this typedef (hw/arm/pxa.h),
let it include "hw/pcmcia.h" directly to simplify "qemu/typedefs.h".

To clean "qemu/typedefs.h", move the declaration to "hw/pcmcia.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/hw/arm/pxa.h    | 1 +
 include/hw/pcmcia.h     | 4 ++--
 include/qemu/typedefs.h | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 0df1199caa..f6dfb5c0cf 100644
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
index 79cac9c761..1b4080764f 100644
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
index 28a8b9e7c2..3bd9215d55 100644
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
2.17.2
