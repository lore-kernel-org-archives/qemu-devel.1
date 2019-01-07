Received: from eggs.gnu.org ([209.51.188.92]:33267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggabg-0008FT-Tt
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggabe-0000Ie-Nr
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:30:40 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 Jan 2019 17:30:18 -0200
Message-Id: <20190107193020.21744-2-ehabkost@redhat.com>
In-Reply-To: <20190107193020.21744-1-ehabkost@redhat.com>
References: <20190107193020.21744-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] spapr: Eliminate
 SPAPR_PCI_2_7_MMIO_WIN_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org

The macro is only used in one place, where the purpose of the
value is obvious.  Eliminate the macro so we don't need to rely
on stringify().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/pci-host/spapr.h | 1 -
 hw/ppc/spapr.c              | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 7c66c3872f..a85a995b6c 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -99,7 +99,6 @@ struct sPAPRPHBState {
 #define SPAPR_PCI_BASE               (1ULL << 45) /* 32 TiB */
 #define SPAPR_PCI_LIMIT              (1ULL << 46) /* 64 TiB */
 
-#define SPAPR_PCI_2_7_MMIO_WIN_SIZE  0xf80000000
 #define SPAPR_PCI_IO_WIN_SIZE        0x10000
 
 #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5671608cea..bff42f0adb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4225,7 +4225,7 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
         {
             .driver   = TYPE_SPAPR_PCI_HOST_BRIDGE,
             .property = "mem_win_size",
-            .value    = stringify(SPAPR_PCI_2_7_MMIO_WIN_SIZE),
+            .value    = "0xf80000000",
         },
         {
             .driver   = TYPE_SPAPR_PCI_HOST_BRIDGE,
-- 
2.18.0.rc1.1.g3f1ff2140
