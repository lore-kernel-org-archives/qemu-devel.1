Received: from eggs.gnu.org ([209.51.188.92]:44923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz59-0005kd-9R
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz53-0007b8-IH
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz51-0007Zh-PK
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:52 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:12 +0100
Message-Id: <1547460140-1473-18-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/25] hw/i386: Remove PCMachineClass from
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

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Files requiring PCMachineClass already include "hw/i386/pc.h".

To clean "qemu/typedefs.h", move the declaration to "hw/i386/pc.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/pc.h    | 4 ++--
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0abbe45..882fd8d 100644
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
index 4c694b7..5edf44e 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -74,7 +74,6 @@ typedef struct PCIExpressDevice PCIExpressDevice;
 typedef struct PCIExpressHost PCIExpressHost;
 typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
 typedef struct PCIHostState PCIHostState;
-typedef struct PCMachineClass PCMachineClass;
 typedef struct PCMachineState PCMachineState;
 typedef struct PixelFormat PixelFormat;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
--=20
1.8.3.1
