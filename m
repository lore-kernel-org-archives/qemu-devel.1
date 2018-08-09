Received: from eggs.gnu.org ([2001:4830:134:3::10]:56298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPY-0004tf-BQ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPV-0007Ak-OQ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPV-0007Ab-Dv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:21 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:21 +0300
Message-Id: <1533815202-11967-9-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 08/29] vmsvga: Parse SVGA_CMD_FENCE command to
 avoid FIFO desync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, kraxel@redhat.com, Liran Alon <liran.alon@oracle.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index fab6443a87e2..675c8755ab48 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -760,6 +760,9 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
         case SVGA_CMD_SURFACE_ALPHA_BLEND: /* deprecated */
             args = 12;
             goto badcmd;
+        case SVGA_CMD_FENCE:
+            args = 1;
+            goto badcmd;
 
         /*
          * Other commands that are not listed as depending on any
@@ -767,7 +770,6 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
          */
         case SVGA_CMD_SURFACE_FILL:
         case SVGA_CMD_SURFACE_COPY:
-        case SVGA_CMD_FENCE:
         case SVGA_CMD_INVALID_CMD:
             break; /* Nop */
 
-- 
1.9.1
