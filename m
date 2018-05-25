Received: from eggs.gnu.org ([2001:4830:134:3::10]:52505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYM-0006O3-SW
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYJ-0007xp-44
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:22 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:55:02 -0400
Message-Id: <20180525235509.11282-10-jsnow@redhat.com>
In-Reply-To: <20180525235509.11282-1-jsnow@redhat.com>
References: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 09/16] ahci: add host register enumeration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c          | 15 +++++++++++++++
 hw/ide/ahci_internal.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 61ac8e46c8..674e06853e 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -46,6 +46,21 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
 
+__attribute__((__unused__)) /* TODO */
+static const char *AHCIHostReg_lookup[AHCI_HOST_REG__COUNT] = {
+    [AHCI_HOST_REG_CAP]        = "CAP",
+    [AHCI_HOST_REG_CTL]        = "GHC",
+    [AHCI_HOST_REG_IRQ_STAT]   = "IS",
+    [AHCI_HOST_REG_PORTS_IMPL] = "PI",
+    [AHCI_HOST_REG_VERSION]    = "VS",
+    [AHCI_HOST_REG_CCC_CTL]    = "CCC_CTL",
+    [AHCI_HOST_REG_CCC_PORTS]  = "CCC_PORTS",
+    [AHCI_HOST_REG_EM_LOC]     = "EM_LOC",
+    [AHCI_HOST_REG_EM_CTL]     = "EM_CTL",
+    [AHCI_HOST_REG_CAP2]       = "CAP2",
+    [AHCI_HOST_REG_BOHC]       = "BOHC",
+};
+
 static const char *AHCIPortReg_lookup[AHCI_PORT_REG__COUNT] = {
     [AHCI_PORT_REG_LST_ADDR]    = "PxCLB",
     [AHCI_PORT_REG_LST_ADDR_HI] = "PxCLBU",
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index db00c9aa39..af366db6f3 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -61,6 +61,21 @@
 #define HOST_PORTS_IMPL           0x0c /* bitmap of implemented ports */
 #define HOST_VERSION              0x10 /* AHCI spec. version compliancy */
 
+enum AHCIHostReg {
+    AHCI_HOST_REG_CAP        = 0,  /* CAP: host capabilities */
+    AHCI_HOST_REG_CTL        = 1,  /* GHC: global host control */
+    AHCI_HOST_REG_IRQ_STAT   = 2,  /* IS: interrupt status */
+    AHCI_HOST_REG_PORTS_IMPL = 3,  /* PI: bitmap of implemented ports */
+    AHCI_HOST_REG_VERSION    = 4,  /* VS: AHCI spec. version compliancy */
+    AHCI_HOST_REG_CCC_CTL    = 5,  /* CCC_CTL: CCC Control */
+    AHCI_HOST_REG_CCC_PORTS  = 6,  /* CCC_PORTS: CCC Ports */
+    AHCI_HOST_REG_EM_LOC     = 7,  /* EM_LOC: Enclosure Mgmt Location */
+    AHCI_HOST_REG_EM_CTL     = 8,  /* EM_CTL: Enclosure Mgmt Control */
+    AHCI_HOST_REG_CAP2       = 9,  /* CAP2: host capabilities, extended */
+    AHCI_HOST_REG_BOHC       = 10, /* BOHC: firmare/os handoff ctrl & status */
+    AHCI_HOST_REG__COUNT     = 11
+};
+
 /* HOST_CTL bits */
 #define HOST_CTL_RESET            (1 << 0)  /* reset controller; self-clear */
 #define HOST_CTL_IRQ_EN           (1 << 1)  /* global IRQ enable */
-- 
2.14.3
