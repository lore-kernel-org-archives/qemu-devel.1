Received: from eggs.gnu.org ([209.51.188.92]:39205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3WC9-0001VD-G6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3WAo-0005Oz-UE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:25:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:27862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h3WAo-0005Ok-M9
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:25:42 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 12 Mar 2019 09:24:57 +0800
Message-Id: <20190312012457.8092-4-richardw.yang@linux.intel.com>
In-Reply-To: <20190312012457.8092-1-richardw.yang@linux.intel.com>
References: <20190312012457.8092-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/3] nvdimm: use NVDIMM_ACPI_IO_LEN for the
 proper IO size
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

The IO range is defined to 4 bytes with NVDIMM_ACPI_IO_LEN, so it is
more proper to use this macro instead of calculating it by sizeof.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/nvdimm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index e63a1ef15d..2457c1aa44 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -992,7 +992,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
     field = aml_field(NVDIMM_DSM_IOPORT, AML_DWORD_ACC, AML_NOLOCK,
                       AML_PRESERVE);
     aml_append(field, aml_named_field(NVDIMM_DSM_NOTIFY,
-               sizeof(uint32_t) * BITS_PER_BYTE));
+               NVDIMM_ACPI_IO_LEN * BITS_PER_BYTE));
     aml_append(method, field);
 
     /*
-- 
2.19.1
