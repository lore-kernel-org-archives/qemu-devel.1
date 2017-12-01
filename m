Received: from eggs.gnu.org ([2001:4830:134:3::10]:54745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKonv-0000lj-7d
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKonr-00073Z-Uu
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eKonr-00073I-OG
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:43 -0500
Date: Fri, 1 Dec 2017 19:08:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1512148088-28733-2-git-send-email-mst@redhat.com>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512148088-28733-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] i386/msi: Correct mask of destination ID in
 MSI address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Chao Gao <chao.gao@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, Anthony PERARD <anthony.perard@citrix.com>, Peter Xu <peterx@redhat.com>

From: Chao Gao <chao.gao@intel.com>

According to SDM 10.11.1, only [19:12] bits of MSI address are
Destination ID, change the mask to avoid ambiguity for VT-d spec
has used the bit 4 to indicate a remappable interrupt request.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
