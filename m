Received: from eggs.gnu.org ([2001:4830:134:3::10]:43988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dQY3y-0006kr-FW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dQY3v-000731-7M
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:56:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:52319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dQY3u-00071P-Uh
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:56:43 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Thu, 29 Jun 2017 01:49:52 -0400
Message-Id: <1498715394-16402-2-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1498715394-16402-1-git-send-email-tianyu.lan@intel.com>
References: <1498715394-16402-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH 1/3] i386/msi: Correct mask of destination ID
 in MSI address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xensource.com
Cc: Chao Gao <chao.gao@intel.com>, mst@redhat.com, marcel@redhat.com, sstabellini@kernel.org, anthony.perard@citrix.com, kevin.tian@intel.com, Lan Tianyu <tianyu.lan@intel.com>

From: Chao Gao <chao.gao@intel.com>

According to SDM 10.11.1, only [19:12] bits of MSI address are
Destination ID, change the mask to avoid ambiguity for VT-d spec
has used the bit 4 to indicate a remappable interrupt request.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
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
