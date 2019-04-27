Received: from eggs.gnu.org ([209.51.188.92]:37225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQeT-0008IJ-EW
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQbq-00078z-Eu
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKQbk-00074g-G4
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:55:26 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat, 27 Apr 2019 18:55:04 +0200
Message-Id: <20190427165504.29846-3-philmd@redhat.com>
In-Reply-To: <20190427165504.29846-1-philmd@redhat.com>
References: <20190427165504.29846-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] hw/acpi: Always build the acpi/core.o file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Samuel Ortiz <sameo@linux.intel.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The 'core' ACPI functions are not X86-specific.
Let this file be built unconditionally, this will allow
us to use ACPI on non-X86 architectures.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/Makefile.objs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index c86edfbed90..09c810ac556 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -1,4 +1,5 @@
-common-obj-$(CONFIG_ACPI_X86) +=3D core.o piix4.o pcihp.o
+common-obj-$(CONFIG_ACPI) +=3D core.o
+common-obj-$(CONFIG_ACPI_X86) +=3D piix4.o pcihp.o
 common-obj-$(CONFIG_ACPI_X86_ICH) +=3D ich9.o tco.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu_hotplug.o
 common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotplug.o
--=20
2.20.1
