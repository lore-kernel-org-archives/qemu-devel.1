Received: from eggs.gnu.org ([2001:4830:134:3::10]:34342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FWW-0007LP-E8
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FWV-00051Z-A6
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:14:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Oct 2017 21:12:06 -0300
Message-Id: <20171017001209.32276-37-f4bug@amsat.org>
In-Reply-To: <20171017001209.32276-1-f4bug@amsat.org>
References: <20171017001209.32276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 36/39] i386/pc: move pvpanic.c from hw/misc/
 to hw/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 default-configs/i386-softmmu.mak   | 1 -
 default-configs/x86_64-softmmu.mak | 1 -
 hw/{misc => i386}/pvpanic.c        | 0
 hw/i386/Makefile.objs              | 2 +-
 hw/misc/Makefile.objs              | 1 -
 5 files changed, 1 insertion(+), 4 deletions(-)
 rename hw/{misc => i386}/pvpanic.c (100%)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index dbc4e65652..541ec8604d 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -46,7 +46,6 @@ CONFIG_LPC_ICH9=y
 CONFIG_PCI_Q35=y
 CONFIG_APIC=y
 CONFIG_IOAPIC=y
-CONFIG_PVPANIC=y
 CONFIG_MEM_HOTPLUG=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index f1fe508ff4..23488d324f 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -46,7 +46,6 @@ CONFIG_LPC_ICH9=y
 CONFIG_PCI_Q35=y
 CONFIG_APIC=y
 CONFIG_IOAPIC=y
-CONFIG_PVPANIC=y
 CONFIG_MEM_HOTPLUG=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
diff --git a/hw/misc/pvpanic.c b/hw/i386/pvpanic.c
similarity index 100%
rename from hw/misc/pvpanic.c
rename to hw/i386/pvpanic.c
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index feff56a9b7..41574096f1 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -7,6 +7,6 @@ obj-y += amd_iommu.o
 obj-$(CONFIG_XEN) += ../xenpv/ xen/
 
 obj-y += kvmvapic.o
-obj-y += acpi-build.o
+obj-y += acpi-build.o pvpanic.o
 obj-y += pci-assign-load-rom.o
 obj-y += vmport.o
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 03bc758592..182f9a7d54 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -53,7 +53,6 @@ obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
 obj-$(CONFIG_MPS2_SCC) += mps2-scc.o
 
-obj-$(CONFIG_PVPANIC) += pvpanic.o
 obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
-- 
2.15.0.rc0
