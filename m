Received: from eggs.gnu.org ([2001:4830:134:3::10]:38324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gAZrG-0007n9-Mk
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gAZrB-0004n4-Lg
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:14:26 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 11 Oct 2018 05:14:03 -0700
Message-Id: <1539260043-4264-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] i440fx: use ARRAY_SIZE for pam_regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>

Cc: qemu-trivial@nongnu.org 

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/pci-host/piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 0e608347c1..230d5d2ea3 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -142,7 +142,7 @@ static void i440fx_update_memory_mappings(PCII440FXState *d)
     PCIDevice *pd = PCI_DEVICE(d);
 
     memory_region_transaction_begin();
-    for (i = 0; i < 13; i++) {
+    for (i = 0; i < ARRAY_SIZE(d->pam_regions); i++) {
         pam_update(&d->pam_regions[i], i,
                    pd->config[I440FX_PAM + (DIV_ROUND_UP(i, 2))]);
     }
@@ -401,7 +401,7 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
 
     init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
              &f->pam_regions[0], PAM_BIOS_BASE, PAM_BIOS_SIZE);
-    for (i = 0; i < 12; ++i) {
+    for (i = 0; i < ARRAY_SIZE(f->pam_regions) - 1; ++i) {
         init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
                  &f->pam_regions[i+1], PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE,
                  PAM_EXPAN_SIZE);
-- 
2.11.0
