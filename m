Received: from eggs.gnu.org ([2001:4830:134:3::10]:43628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQA2-0003gD-6i
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQA0-0002qv-W3
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:16:14 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 16 Jan 2018 13:15:56 +0100
Message-Id: <1516104958-3881-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1516104958-3881-1-git-send-email-thuth@redhat.com>
References: <1516104958-3881-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] default-configs/ppc-softmmu:
 Restructure the switches according to the machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, BALATON Zoltan <balaton@eik.bme.hu>

Order the CONFIG switches in ppc-softmmu.mak according to the machine
classes where they are used (embedded, Mac or PReP), so that it is
easier for the users to disable a set of switches completely if they
are not needed.

Also add the missing CONFIG_IDE_SII3112 switch to the embedded section
which was previously only added to ppcemb-softmmu.mak.

And while we're at it, also remove the CONFIG_IDE_CMD646 switch since
this controller does not seem to be used by any ppc machine in QEMU.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/ppc-softmmu.mak | 59 ++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index bb225c6..3baed6a 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -3,52 +3,57 @@
 include pci.mak
 include sound.mak
 include usb.mak
+
+# For embedded PPCs:
 CONFIG_PPC4XX=y
-CONFIG_ESCC=y
 CONFIG_M48T59=y
 CONFIG_SERIAL=y
-CONFIG_PARALLEL=y
-CONFIG_I8254=y
-CONFIG_PCKBD=y
-CONFIG_FDC=y
 CONFIG_I8257=y
-CONFIG_I82374=y
 CONFIG_OPENPIC=y
-CONFIG_PREP_PCI=y
-CONFIG_I82378=y
-CONFIG_PC87312=y
-CONFIG_MACIO=y
-CONFIG_SUNGEM=y
-CONFIG_PCSPK=y
-CONFIG_CS4231A=y
-CONFIG_CUDA=y
-CONFIG_ADB=y
-CONFIG_MAC_NVRAM=y
-CONFIG_MAC_DBDMA=y
-CONFIG_HEATHROW_PIC=y
-CONFIG_GRACKLE_PCI=y
-CONFIG_UNIN_PCI=y
-CONFIG_DEC_PCI=y
 CONFIG_PPCE500_PCI=y
-CONFIG_IDE_ISA=y
-CONFIG_IDE_CMD646=y
-CONFIG_IDE_MACIO=y
-CONFIG_NE2000_ISA=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_PTIMER=y
 CONFIG_I8259=y
 CONFIG_XILINX=y
 CONFIG_XILINX_ETHLITE=y
-CONFIG_PREP=y
-CONFIG_MAC=y
 CONFIG_E500=y
 CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
 CONFIG_SM501=y
+CONFIG_IDE_SII3112=y
+
+# For Macs
+CONFIG_MAC=y
+CONFIG_ESCC=y
+CONFIG_MACIO=y
+CONFIG_SUNGEM=y
+CONFIG_CUDA=y
+CONFIG_ADB=y
+CONFIG_MAC_NVRAM=y
+CONFIG_MAC_DBDMA=y
+CONFIG_HEATHROW_PIC=y
+CONFIG_GRACKLE_PCI=y
+CONFIG_UNIN_PCI=y
+CONFIG_DEC_PCI=y
+CONFIG_IDE_MACIO=y
+
 # For PReP
+CONFIG_PREP=y
+CONFIG_PREP_PCI=y
 CONFIG_SERIAL_ISA=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_RS6000_MC=y
+CONFIG_PARALLEL=y
+CONFIG_I82374=y
+CONFIG_I82378=y
+CONFIG_I8254=y
+CONFIG_PCKBD=y
+CONFIG_FDC=y
+CONFIG_NE2000_ISA=y
+CONFIG_PC87312=y
+CONFIG_PCSPK=y
+CONFIG_IDE_ISA=y
+CONFIG_CS4231A=y
-- 
1.8.3.1
