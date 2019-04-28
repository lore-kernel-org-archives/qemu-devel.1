Received: from eggs.gnu.org ([209.51.188.92]:57127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdba-0000DE-Dd
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbX-00062e-W9
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbX-000626-8e
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:03 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 28 Apr 2019 08:47:28 +0200
Message-Id: <20190428064731.29913-4-philmd@redhat.com>
In-Reply-To: <20190428064731.29913-1-philmd@redhat.com>
References: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/6] hw/acpi: Simplify the Makefile logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Simplify the Makefile logic to ease further modifications/reviews.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/Makefile.objs | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 73eca4f7dff..b5515c626a6 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -1,4 +1,3 @@
-ifeq ($(CONFIG_ACPI),y)
 common-obj-$(CONFIG_ACPI_X86) +=3D core.o piix4.o pcihp.o
 common-obj-$(CONFIG_ACPI_X86_ICH) +=3D ich9.o tco.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu_hotplug.o
@@ -6,10 +5,8 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hot=
plug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
-
-common-obj-y +=3D acpi_interface.o
-common-obj-y +=3D bios-linker-loader.o
-common-obj-y +=3D aml-build.o
-common-obj-$(CONFIG_TPM) +=3D tpm.o
-common-obj-$(CONFIG_IPMI) +=3D ipmi.o
-endif
+common-obj-$(CONFIG_ACPI) +=3D acpi_interface.o
+common-obj-$(CONFIG_ACPI) +=3D bios-linker-loader.o
+common-obj-$(CONFIG_ACPI) +=3D aml-build.o
+common-obj-$(call land,$(CONFIG_ACPI),$(CONFIG_TPM)) +=3D tpm.o
+common-obj-$(call land,$(CONFIG_ACPI),$(CONFIG_IPMI)) +=3D ipmi.o
--=20
2.20.1
