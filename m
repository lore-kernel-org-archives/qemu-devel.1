Received: from eggs.gnu.org ([2001:4830:134:3::10]:40786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTA9-0001iz-8s
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTA6-0008Ul-62
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:41 -0500
Received: from ozlabs.org ([103.22.144.67]:60147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ecTA5-0008TT-8k
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 19 Jan 2018 20:40:04 +1100
Message-Id: <20180119094015.28266-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180119094015.28266-1-david@gibson.dropbear.id.au>
References: <20180119094015.28266-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/13] default-configs/ppc-softmmu: Restructure
 the switches according to the machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, lvivier@redhat.com, agraf@suse.de, qemu-ppc@nognu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

Order the CONFIG switches in ppc-softmmu.mak according to the machine
classes where they are used (embedded, Mac or PReP), so that it is
easier for the users to disable a set of switches completely if they
are not needed.

Also add the missing CONFIG_IDE_SII3112 switch to the embedded section
which was previously only added to ppcemb-softmmu.mak.

And while we're at it, also remove the CONFIG_IDE_CMD646 switch since
this controller does not seem to be used by any ppc machine in QEMU.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc-softmmu.mak | 59 ++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index bb225c6e46..3baed6a8fd 100644
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
2.14.3
