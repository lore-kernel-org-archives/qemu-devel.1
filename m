Received: from eggs.gnu.org ([209.51.188.92]:39205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3WCA-0001VD-7O
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3WAm-0005OL-UX
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:25:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:27859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h3WAm-0005Nh-Lc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:25:40 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 12 Mar 2019 09:24:56 +0800
Message-Id: <20190312012457.8092-3-richardw.yang@linux.intel.com>
In-Reply-To: <20190312012457.8092-1-richardw.yang@linux.intel.com>
References: <20190312012457.8092-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/3] nvdimm: use *function* directly instead
 of allocating it again
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

At the beginning or nvdimm_build_common_dsm(), variable *function* is
already allocated for Arg2.

This patch reuse variable *function* instead of allocating it again.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/nvdimm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 39af8cdba8..e63a1ef15d 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1086,7 +1086,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
      */
     aml_append(method, aml_store(handle, aml_name(NVDIMM_DSM_HANDLE)));
     aml_append(method, aml_store(aml_arg(1), aml_name(NVDIMM_DSM_REVISION)));
-    aml_append(method, aml_store(aml_arg(2), aml_name(NVDIMM_DSM_FUNCTION)));
+    aml_append(method, aml_store(function, aml_name(NVDIMM_DSM_FUNCTION)));
 
     /*
      * The fourth parameter (Arg3) of _DSM is a package which contains
-- 
2.19.1
