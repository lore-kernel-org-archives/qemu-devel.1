Received: from eggs.gnu.org ([2001:4830:134:3::10]:54107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQkxL-0005UV-E3
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 21:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQkxH-0007dw-AX
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 21:15:03 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:58 +0300
Message-Id: <18da395c4d7ac9f4233f55c75b2808722dc75e23.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 53/61] hw/acpi/ich9: extract
 ACPI_PM_PROP_TCO_ENABLED from i386/pc
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

enable_tco is specific to i386/pc.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/ich9.h | 2 ++
 include/hw/i386/pc.h   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index a352c94fde..59aeb06393 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -63,6 +63,8 @@ typedef struct ICH9LPCPMRegs {
     TCOIORegs tco_regs;
 } ICH9LPCPMRegs;
=20
+#define ACPI_PM_PROP_TCO_ENABLED "enable_tco"
+
 void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
                   bool smm_enabled,
                   qemu_irq sci_irq);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 252526e600..3794473108 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -151,8 +151,6 @@ struct PCMachineClass {
 #define PC_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(PCMachineClass, (klass), TYPE_PC_MACHINE)
=20
-#define ACPI_PM_PROP_TCO_ENABLED "enable_tco"
-
 /* parallel.c */
=20
 void parallel_hds_isa_init(ISABus *bus, int n);
--=20
2.11.0
