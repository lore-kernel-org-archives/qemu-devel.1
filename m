Received: from eggs.gnu.org ([209.51.188.92]:57082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbM-0008RV-IT
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbL-0005fp-9Y
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbK-0005e6-Sz
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:51 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 28 Apr 2019 08:47:26 +0200
Message-Id: <20190428064731.29913-2-philmd@redhat.com>
In-Reply-To: <20190428064731.29913-1-philmd@redhat.com>
References: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/6] hw/acpi: Move the IPMI stub to the
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

Move the IPMI stub file to the stubs/ directory to simplify the
hw/acpi Makefile.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                         | 1 +
 hw/acpi/Makefile.objs               | 3 +--
 stubs/Makefile.objs                 | 1 +
 hw/acpi/ipmi-stub.c =3D> stubs/ipmi.c | 0
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename hw/acpi/ipmi-stub.c =3D> stubs/ipmi.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23db6f8408a..e1681eca5cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1309,6 +1309,7 @@ S: Maintained
 F: include/hw/ipmi/*
 F: hw/ipmi/*
 F: hw/smbios/smbios_type_38.c
+F: stubs/ipmi.c
 F: tests/ipmi*
 T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
=20
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 2d46e3789ae..4e302feb885 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -14,8 +14,7 @@ common-obj-y +=3D aml-build.o
 common-obj-$(CONFIG_TPM) +=3D tpm.o
=20
 common-obj-$(CONFIG_IPMI) +=3D ipmi.o
-common-obj-$(call lnot,$(CONFIG_IPMI)) +=3D ipmi-stub.o
 else
 common-obj-y +=3D acpi-stub.o
 endif
-common-obj-$(CONFIG_ALL) +=3D acpi-stub.o ipmi-stub.o
+common-obj-$(CONFIG_ALL) +=3D acpi-stub.o
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 269dfa58326..36bb9ff0b1d 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -9,6 +9,7 @@ stub-obj-y +=3D error-printf.o
 stub-obj-y +=3D fdset.o
 stub-obj-y +=3D gdbstub.o
 stub-obj-y +=3D get-vm-name.o
+stub-obj-y +=3D ipmi.o
 stub-obj-y +=3D iothread.o
 stub-obj-y +=3D iothread-lock.o
 stub-obj-y +=3D is-daemonized.o
diff --git a/hw/acpi/ipmi-stub.c b/stubs/ipmi.c
similarity index 100%
rename from hw/acpi/ipmi-stub.c
rename to stubs/ipmi.c
--=20
2.20.1
