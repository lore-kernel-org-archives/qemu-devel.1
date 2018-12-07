Received: from eggs.gnu.org ([2001:4830:134:3::10]:58538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVJYF-0005Np-6a
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVJYE-00054P-DX
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:04:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVJYE-00053W-7P
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:04:30 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  7 Dec 2018 18:03:57 +0100
Message-Id: <20181207170400.5129-4-philmd@redhat.com>
In-Reply-To: <20181207170400.5129-1-philmd@redhat.com>
References: <20181207170400.5129-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] hw/i386: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/piix4.c      | 1 -
 hw/i386/acpi-build.c | 1 -
 hw/i386/pc.c         | 1 -
 3 files changed, 3 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index e330f24c71..49a33bfcda 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -28,7 +28,6 @@
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/range.h"
-#include "hw/nvram/fw_cfg.h"
 #include "exec/address-spaces.h"
 #include "hw/acpi/piix4.h"
 #include "hw/acpi/pcihp.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 236a20eaa8..1e5c371294 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -35,7 +35,6 @@
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu.h"
-#include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/loader.h"
 #include "hw/isa/isa.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f095725dba..2221dcdb36 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -35,7 +35,6 @@
 #include "hw/ide.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/nvram/fw_cfg.h"
 #include "hw/timer/hpet.h"
 #include "hw/smbios/smbios.h"
 #include "hw/loader.h"
--=20
2.17.2
