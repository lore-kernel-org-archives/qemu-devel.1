Received: from eggs.gnu.org ([2001:4830:134:3::10]:57239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eFa6X-00018P-K4
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eFa6V-00013i-Si
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:26:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:62640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1eFa6V-0000tS-Jq
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:26:19 -0500
From: Chao Gao <chao.gao@intel.com>
Date: Fri, 17 Nov 2017 14:24:23 +0800
Message-Id: <1510899865-40323-2-git-send-email-chao.gao@intel.com>
In-Reply-To: <1510899865-40323-1-git-send-email-chao.gao@intel.com>
References: <1510899865-40323-1-git-send-email-chao.gao@intel.com>
Subject: [Qemu-devel] [PATCH v3 1/3] i386/msi: Correct mask of destination
 ID in MSI address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chao Gao <chao.gao@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Peter Xu <peterx@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>

According to SDM 10.11.1, only [19:12] bits of MSI address are
Destination ID, change the mask to avoid ambiguity for VT-d spec
has used the bit 4 to indicate a remappable interrupt request.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/hw/i386/apic-msidef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/i386/apic-msidef.h b/include/hw/i386/apic-msidef.h
index 8b4d4cc..420b411 100644
--- a/include/hw/i386/apic-msidef.h
+++ b/include/hw/i386/apic-msidef.h
@@ -26,6 +26,6 @@
 
 #define MSI_ADDR_DEST_ID_SHIFT          12
 #define MSI_ADDR_DEST_IDX_SHIFT         4
-#define  MSI_ADDR_DEST_ID_MASK          0x00ffff0
+#define  MSI_ADDR_DEST_ID_MASK          0x000ff000
 
 #endif /* HW_APIC_MSIDEF_H */
-- 
1.8.3.1
