Received: from eggs.gnu.org ([2001:4830:134:3::10]:51758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTN-0007e3-EL
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTM-0003IV-Jj
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:37 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTM-0003IB-Fr
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:36 -0500
Received: by mail-qt0-x242.google.com with SMTP id d4so12062712qtj.5
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:36 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:54 -0300
Message-Id: <20180108024558.17983-26-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 25/29] hw/i386: move piix from hw/pci-host to
 hw/southbridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/{pci-host => southbridge}/piix.c | 0
 MAINTAINERS                         | 2 +-
 hw/Makefile.objs                    | 1 +
 hw/pci-host/Makefile.objs           | 1 -
 hw/southbridge/Makefile.objs        | 1 +
 5 files changed, 3 insertions(+), 2 deletions(-)
 rename hw/{pci-host => southbridge}/piix.c (100%)
 create mode 100644 hw/southbridge/Makefile.objs

diff --git a/hw/pci-host/piix.c b/hw/southbridge/piix.c
similarity index 100%
rename from hw/pci-host/piix.c
rename to hw/southbridge/piix.c
diff --git a/MAINTAINERS b/MAINTAINERS
index a4dc72a47b..e88ed8851b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -848,7 +848,6 @@ M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
 F: include/hw/i386/
 F: hw/i386/
-F: hw/pci-host/piix.c
 F: hw/pci-host/i440fx.c
 F: hw/pci-host/q35.c
 F: hw/pci-host/pam.c
@@ -879,6 +878,7 @@ F: hw/intc/i8259*
 F: hw/isa/isa-superio.c
 F: hw/misc/debugexit.c
 F: hw/misc/pc-testdev.c
+F: hw/southbridge/piix.c
 F: hw/timer/hpet*
 F: hw/timer/i8254*
 F: hw/timer/mc146818rtc*
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index cf4cb2010b..1594754976 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -21,6 +21,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += net/
 devices-dirs-$(CONFIG_SOFTMMU) += nvram/
 devices-dirs-$(CONFIG_SOFTMMU) += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
+devices-dirs-$(CONFIG_SOFTMMU) += southbridge/
 devices-dirs-$(CONFIG_SOFTMMU) += pcmcia/
 devices-dirs-$(CONFIG_SOFTMMU) += scsi/
 devices-dirs-$(CONFIG_SOFTMMU) += sd/
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index acf61023b5..1ef713df2b 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -13,7 +13,6 @@ common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
 
 common-obj-$(CONFIG_PCI_APB) += apb.o
 common-obj-$(CONFIG_FULONG) += bonito.o
-common-obj-$(CONFIG_PCI_PIIX) += piix.o
 common-obj-$(CONFIG_PCI_I440FX) += i440fx.o
 common-obj-$(CONFIG_PCI_Q35) += q35.o
 common-obj-$(CONFIG_PCI_GENERIC) += gpex.o
diff --git a/hw/southbridge/Makefile.objs b/hw/southbridge/Makefile.objs
new file mode 100644
index 0000000000..88e9273b3c
--- /dev/null
+++ b/hw/southbridge/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_PCI_PIIX) += piix.o
-- 
2.15.1
