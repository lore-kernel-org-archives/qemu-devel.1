Received: from eggs.gnu.org ([2001:4830:134:3::10]:56528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQD-0005Ns-QH
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQB-0007YU-6R
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQA-0007YF-RS
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:03 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:35 +0300
Message-Id: <1533815202-11967-23-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 22/29] vmsvga: Increase size of cursor AND
 bitmask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, kraxel@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>, Liran Alon <liran.alon@oracle.com>

From: Leonid Shatz <leonid.shatz@oracle.com>

Some guests are using 64x64 32bpp cursor pixel array, the old size of 1024 integers
was not sufficient to store such large masks.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index ef2c8bdbf5be..46f03fe90ac0 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -620,7 +620,7 @@ struct vmsvga_cursor_definition_s {
     int hot_y;
     uint32_t and_mask_bpp; // Value must be 1 or equal to BITS_PER_PIXEL
     uint32_t xor_mask_bpp; // Value must be 1 or equal to BITS_PER_PIXEL
-    uint32_t and_mask[1024];
+    uint32_t and_mask[4096];
     uint32_t xor_mask[4096];
 };
 
-- 
1.9.1
