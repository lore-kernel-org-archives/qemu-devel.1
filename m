Received: from eggs.gnu.org ([2001:4830:134:3::10]:43119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4n-0000rG-Fb
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4m-0002c9-Dz
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:17 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:40 -0500
Message-Id: <20170313195547.21466-24-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 23/30] trace: Fix parameter types in hw/ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:PowerPC" <qemu-ppc@nongnu.org>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/ppc/trace-events | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 43d265f..3414c46 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -20,18 +20,18 @@ spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=
 # hw/ppc/spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
 spapr_iommu_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=%"PRIx64" ioba=0x%"PRIx64" ret=%"PRId64" tce=0x%"PRIx64
-spapr_iommu_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN, uint64_t tceN, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcelist=0x%"PRIx64" iobaN=0x%"PRIx64" tceN=0x%"PRIx64" ret=%"PRId64
+spapr_iommu_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, int iobaN, uint64_t tceN, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcelist=0x%"PRIx64" iobaN=0x%x tceN=0x%"PRIx64" ret=%"PRId64
 spapr_iommu_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcevalue=0x%"PRIx64" npages=%"PRId64" ret=%"PRId64
 spapr_iommu_pci_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
 spapr_iommu_pci_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=%"PRIx64" ioba=0x%"PRIx64" ret=%"PRId64" tce=0x%"PRIx64
-spapr_iommu_pci_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN, uint64_t tceN, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcelist=0x%"PRIx64" iobaN=0x%"PRIx64" tceN=0x%"PRIx64" ret=%"PRId64
+spapr_iommu_pci_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, int iobaN, uint64_t tceN, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcelist=0x%"PRIx64" iobaN=0x%x tceN=0x%"PRIx64" ret=%"PRId64
 spapr_iommu_pci_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcevalue=0x%"PRIx64" npages=%"PRId64" ret=%"PRId64
-spapr_iommu_xlate(uint64_t liobn, uint64_t ioba, uint64_t tce, unsigned perm, unsigned pgsize) "liobn=%"PRIx64" 0x%"PRIx64" -> 0x%"PRIx64" perm=%u mask=%x"
-spapr_iommu_new_table(uint64_t liobn, void *table, int fd) "liobn=%"PRIx64" table=%p fd=%d"
-spapr_iommu_pre_save(uint64_t liobn, uint32_t nb, uint64_t offs, uint32_t ps) "liobn=%"PRIx64" %"PRIx32" bus_offset=%"PRIx64" ps=%"PRIu32
-spapr_iommu_post_load(uint64_t liobn, uint32_t pre_nb, uint32_t post_nb, uint64_t offs, uint32_t ps) "liobn=%"PRIx64" %"PRIx32" => %"PRIx32" bus_offset=%"PRIx64" ps=%"PRIu32
+spapr_iommu_xlate(uint32_t liobn, uint64_t ioba, uint64_t tce, unsigned perm, hwaddr pgsize) "liobn=%"PRIx32" 0x%"PRIx64" -> 0x%"PRIx64" perm=%u mask=%" HWADDR_PRIx
+spapr_iommu_new_table(uint32_t liobn, void *table, int fd) "liobn=%"PRIx32" table=%p fd=%d"
+spapr_iommu_pre_save(uint32_t liobn, uint32_t nb, uint64_t offs, uint32_t ps) "liobn=%"PRIx32" %"PRIx32" bus_offset=%"PRIx64" ps=%"PRIu32
+spapr_iommu_post_load(uint32_t liobn, uint32_t pre_nb, uint32_t post_nb, uint64_t offs, uint32_t ps) "liobn=%"PRIx32" %"PRIx32" => %"PRIx32" bus_offset=%"PRIx64" ps=%"PRIu32
 spapr_iommu_ddw_query(uint64_t buid, uint32_t cfgaddr, unsigned wa, uint64_t win_size, uint32_t pgmask) "buid=%"PRIx64" addr=%"PRIx32", %u windows available, max window size=%"PRIx64", mask=%"PRIx32
-spapr_iommu_ddw_create(uint64_t buid, uint32_t cfgaddr, uint64_t pg_size, uint64_t req_size, uint64_t start, uint32_t liobn) "buid=%"PRIx64" addr=%"PRIx32", page size=0x%"PRIx64", requested=0x%"PRIx64", start addr=%"PRIx64", liobn=%"PRIx32
+spapr_iommu_ddw_create(uint64_t buid, uint32_t cfgaddr, unsigned long long pg_size, unsigned long long req_size, uint64_t start, uint32_t liobn) "buid=%"PRIx64" addr=%"PRIx32", page size=0x%llx, requested=0x%llx, start addr=%"PRIx64", liobn=%"PRIx32
 spapr_iommu_ddw_remove(uint32_t liobn) "liobn=%"PRIx32
 spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfgaddr) "buid=%"PRIx64" addr=%"PRIx32

@@ -92,7 +92,7 @@ rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"

 # hw/ppc/mac_newworld.c
 mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
-mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
+mac99_uninorth_read(uint64_t addr, uint32_t value) "addr=0x%" PRIx64 " val=0x%"PRIx32

 # hw/ppc/ppc4xx_pci.c
 ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn %x irq %d -> %d"
-- 
2.9.3
