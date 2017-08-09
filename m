Received: from eggs.gnu.org ([2001:4830:134:3::10]:51358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dfdfi-000392-M3
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 22:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dfdfe-0002cC-Ry
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 22:58:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:53881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dfdfe-0002aX-JL
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 22:58:02 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Wed,  9 Aug 2017 16:51:20 -0400
Message-Id: <1502311882-11038-2-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1502311882-11038-1-git-send-email-tianyu.lan@intel.com>
References: <1502311882-11038-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH V2 1/3] i386/msi: Correct mask of destination
 ID in MSI address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Chao Gao <chao.gao@intel.com>, sstabellini@kernel.org, anthony.perard@citrix.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kevin.tian@intel.com, Lan Tianyu <tianyu.lan@intel.com>

From: Chao Gao <chao.gao@intel.com>

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
