Received: from eggs.gnu.org ([2001:4830:134:3::10]:50531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9Yt3-0004N5-8E
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9Ysy-0007o3-EL
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:55:33 -0400
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:54921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9Ysy-0007nI-8e
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:55:28 -0400
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Tue, 31 Oct 2017 11:54:35 -0400
Message-ID: <20171031155435.4618-3-michael.nawrocki@gtri.gatech.edu>
In-Reply-To: <20171031155435.4618-1-michael.nawrocki@gtri.gatech.edu>
References: <20171031155435.4618-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] Add i82559a eepro100 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, marcel@redhat.com, Mike
	Nawrocki <michael.nawrocki@gtri.gatech.edu>

Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
---
 hw/net/eepro100.c    | 2 +-
 hw/pci/pci.c         | 2 ++
 include/hw/pci/pci.h | 1 +
 qemu-options.hx      | 2 +-
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 91dd058010..2c7c5cdeb9 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1973,7 +1973,7 @@ static E100PCIDeviceInfo e100_devices[] = {
         .name = "i82559a",
         .desc = "Intel i82559A Ethernet",
         .device = i82559A,
-        .device_id = PCI_DEVICE_ID_INTEL_82557,
+        .device_id = PCI_DEVICE_ID_INTEL_82559,
         .revision = 0x06,
         .stats_size = 80,
         .has_extended_tcb_support = true,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5ed3c8dca4..1126ad1eb3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1826,6 +1826,7 @@ static const char * const pci_nic_models[] = {
     "ne2k_pci",
     "i82551",
     "i82557b",
+    "i82559a",
     "i82559er",
     "rtl8139",
     "e1000",
@@ -1839,6 +1840,7 @@ static const char * const pci_nic_names[] = {
     "ne2k_pci",
     "i82551",
     "i82557b",
+    "i82559a",
     "i82559er",
     "rtl8139",
     "e1000",
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 8d02a0a383..f30e2cfb72 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -70,6 +70,7 @@ extern bool pci_available;
 /* Intel (0x8086) */
 #define PCI_DEVICE_ID_INTEL_82551IT      0x1209
 #define PCI_DEVICE_ID_INTEL_82557        0x1229
+#define PCI_DEVICE_ID_INTEL_82559        0x1030
 #define PCI_DEVICE_ID_INTEL_82801IR      0x2922
 
 /* Red Hat / Qumranet (for QEMU) -- see pci-ids.txt */
diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b4dd..a39c7e44b3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2047,7 +2047,7 @@ that the card should have; this option currently only affects virtio cards; set
 @var{v} = 0 to disable MSI-X. If no @option{-net} option is specified, a single
 NIC is created.  QEMU can emulate several different models of network card.
 Valid values for @var{type} are
-@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
+@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559a}, @code{i82559er},
 @code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
 @code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
 Not all devices are supported on all targets.  Use @code{-net nic,model=help}
-- 
2.14.2
