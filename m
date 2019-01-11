Received: from eggs.gnu.org ([209.51.188.92]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxdx-0005cP-7s
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxX7-0005xV-PK
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:11:38 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:51 +0100
Message-Id: <20190111140857.4211-10-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/15] hw/i386: Remove PCMachineClass from
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

Files requiring PCMachineClass already include "hw/i386/pc.h".

To clean "qemu/typedefs.h", move the declaration to "hw/i386/pc.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i386/pc.h    | 4 ++--
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 84720bede9..2c7a69b8f5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -96,7 +96,7 @@ struct PCMachineState {
  *                  way we can use 1GByte pages in the host.
  *
  */
-struct PCMachineClass {
+typedef struct PCMachineClass {
     /*< private >*/
     MachineClass parent_class;
=20
@@ -133,7 +133,7 @@ struct PCMachineClass {
=20
     /* use DMA capable linuxboot option rom */
     bool linuxboot_dma_enabled;
-};
+} PCMachineClass;
=20
 #define TYPE_PC_MACHINE "generic-pc-machine"
 #define PC_MACHINE(obj) \
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 165d335f87..5e9a070ff3 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -70,7 +70,6 @@ typedef struct PCIExpressDevice PCIExpressDevice;
 typedef struct PCIExpressHost PCIExpressHost;
 typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
 typedef struct PCIHostState PCIHostState;
-typedef struct PCMachineClass PCMachineClass;
 typedef struct PCMachineState PCMachineState;
 typedef struct PixelFormat PixelFormat;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
--=20
2.17.2
