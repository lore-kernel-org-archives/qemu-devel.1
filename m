Received: from eggs.gnu.org ([2001:4830:134:3::10]:51793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTT-0007js-07
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTP-0003Jx-Uc
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:43 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTP-0003Ji-Q9
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:39 -0500
Received: by mail-qt0-x244.google.com with SMTP id i40so12057629qti.8
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:55 -0300
Message-Id: <20180108024558.17983-27-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 26/29] configs/mips-softmmu: use common
 CONFIG_PCI_PIIX instead of CONFIG_PIIX4
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
 default-configs/mips-softmmu-common.mak | 2 +-
 hw/isa/Makefile.objs                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 7d8f5db983..f29beb1419 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -22,7 +22,7 @@ CONFIG_ACPI_NVDIMM=y
 CONFIG_ACPI_CPU_HOTPLUG=y
 CONFIG_APM=y
 CONFIG_I8257=y
-CONFIG_PIIX4=y
+CONFIG_PCI_PIIX=y
 CONFIG_IDE_ISA=y
 CONFIG_IDE_PIIX=y
 CONFIG_NE2000_ISA=y
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index cac655ba58..fa071082d4 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -3,7 +3,7 @@ common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
 common-obj-$(CONFIG_APM) += apm.o
 common-obj-$(CONFIG_I82378) += i82378.o
 common-obj-$(CONFIG_PC87312) += pc87312.o
-common-obj-$(CONFIG_PIIX4) += piix4.o
+common-obj-$(CONFIG_PCI_PIIX) += piix4.o
 common-obj-$(CONFIG_VT82C686) += vt82c686.o
 
 obj-$(CONFIG_LPC_ICH9) += lpc_ich9.o
-- 
2.15.1
