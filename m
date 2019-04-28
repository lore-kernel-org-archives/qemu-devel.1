Received: from eggs.gnu.org ([209.51.188.92]:57095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbS-0008WS-Fn
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbQ-0005sm-Vb
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbP-0005jH-2p
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:56 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 28 Apr 2019 08:47:27 +0200
Message-Id: <20190428064731.29913-3-philmd@redhat.com>
In-Reply-To: <20190428064731.29913-1-philmd@redhat.com>
References: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/6] hw/acpi: Move the ACPI stub to the
 stubs/ directory
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

Move the ACPI stub file to the stubs/ directory to greatly simplify
the hw/acpi Makefile.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                         | 1 +
 hw/acpi/Makefile.objs               | 5 -----
 stubs/Makefile.objs                 | 1 +
 hw/acpi/acpi-stub.c =3D> stubs/acpi.c | 0
 4 files changed, 2 insertions(+), 5 deletions(-)
 rename hw/acpi/acpi-stub.c =3D> stubs/acpi.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1681eca5cb..d05a3d36511 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1357,6 +1357,7 @@ F: hw/acpi/*
 F: hw/smbios/*
 F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
+F: stubs/acpi.c
 F: tests/bios-tables-test.c
 F: tests/acpi-utils.[hc]
 F: tests/data/acpi/
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 4e302feb885..73eca4f7dff 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -6,15 +6,10 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_ho=
tplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
-common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
=20
 common-obj-y +=3D acpi_interface.o
 common-obj-y +=3D bios-linker-loader.o
 common-obj-y +=3D aml-build.o
 common-obj-$(CONFIG_TPM) +=3D tpm.o
-
 common-obj-$(CONFIG_IPMI) +=3D ipmi.o
-else
-common-obj-y +=3D acpi-stub.o
 endif
-common-obj-$(CONFIG_ALL) +=3D acpi-stub.o
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 36bb9ff0b1d..47ee66a71f2 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,3 +1,4 @@
+stub-obj-y +=3D acpi.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
diff --git a/hw/acpi/acpi-stub.c b/stubs/acpi.c
similarity index 100%
rename from hw/acpi/acpi-stub.c
rename to stubs/acpi.c
--=20
2.20.1
