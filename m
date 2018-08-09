Received: from eggs.gnu.org ([2001:4830:134:3::10]:56659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQY-0005g9-Cr
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQV-0007ir-Qc
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQV-0007iU-Fx
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:23 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:42 +0300
Message-Id: <1533815202-11967-30-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 29/29] vmsvga: Don't allow setting screen size
 with zero width or height
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

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 389248b4badf..1803a565fa07 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1566,6 +1566,9 @@ static inline void vmsvga_check_size(struct vmsvga_state_s *s)
     DisplaySurface *surface = qemu_console_surface(s->vga.con);
     uint32_t new_stride;
 
+    /* Don't allow setting uninitialized 0-size screen */
+    if ((s->new_width == 0) || (s->new_height == 0)) return;
+
     new_stride = (s->use_pitchlock >= 0) ?
         s->pitchlock :
         ((s->new_depth * s->new_width) / 8);
-- 
1.9.1
