Received: from eggs.gnu.org ([209.51.188.92]:39205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3WCB-0001VD-0o
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3WAm-0005O8-EL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:25:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:27859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h3WAm-0005Nh-4R
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:25:40 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 12 Mar 2019 09:24:55 +0800
Message-Id: <20190312012457.8092-2-richardw.yang@linux.intel.com>
In-Reply-To: <20190312012457.8092-1-richardw.yang@linux.intel.com>
References: <20190312012457.8092-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/3] nvdimm: fix typo in
 nvdimm_build_nvdimm_devices argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, Wei Yang <richardw.yang@linux.intel.com>

>From dsm_dma_arrea to dsm_dma_area.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/nvdimm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index e53b2cb681..39af8cdba8 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1260,7 +1260,7 @@ static void nvdimm_build_nvdimm_devices(Aml *root_dev, uint32_t ram_slots)
 }
 
 static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
-                              BIOSLinker *linker, GArray *dsm_dma_arrea,
+                              BIOSLinker *linker, GArray *dsm_dma_area,
                               uint32_t ram_slots)
 {
     Aml *ssdt, *sb_scope, *dev;
@@ -1307,7 +1307,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
                                                NVDIMM_ACPI_MEM_ADDR);
 
     bios_linker_loader_alloc(linker,
-                             NVDIMM_DSM_MEM_FILE, dsm_dma_arrea,
+                             NVDIMM_DSM_MEM_FILE, dsm_dma_area,
                              sizeof(NvdimmDsmIn), false /* high memory */);
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
-- 
2.19.1
