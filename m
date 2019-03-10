Received: from eggs.gnu.org ([209.51.188.92]:48994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2mdi-0001QH-If
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2mdh-0006jC-S2
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:48:30 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 10 Mar 2019 01:47:49 +0100
Message-Id: <20190310004749.27029-5-philmd@redhat.com>
In-Reply-To: <20190310004749.27029-1-philmd@redhat.com>
References: <20190310004749.27029-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/4] hw/arm/virt: Use
 edk2_add_host_crypto_policy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:Virt" <qemu-arm@nongnu.org>

Enable the EDK2 Crypto Policy features on the Virt machine.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/virt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7f66ddad89..940f41056a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -55,6 +55,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "kvm_arm.h"
 #include "hw/firmware/smbios.h"
+#include "hw/firmware/uefi_edk2.h"
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
@@ -1304,6 +1305,11 @@ static void virt_build_smbios(VirtMachineState *vm=
s)
     }
 }
=20
+static void virt_uefi_setup(VirtMachineState *vms)
+{
+    edk2_add_host_crypto_policy(vms->fw_cfg);
+}
+
 static
 void virt_machine_done(Notifier *notifier, void *data)
 {
@@ -1332,6 +1338,7 @@ void virt_machine_done(Notifier *notifier, void *da=
ta)
=20
     virt_acpi_setup(vms);
     virt_build_smbios(vms);
+    virt_uefi_setup(vms);
 }
=20
 static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
--=20
2.20.1
