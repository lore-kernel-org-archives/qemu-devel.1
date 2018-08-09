Received: from eggs.gnu.org ([2001:4830:134:3::10]:56352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPh-00050t-6V
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPe-0007E2-L2
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPe-0007Dd-Ak
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:30 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:24 +0300
Message-Id: <1533815202-11967-12-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 11/29] vmsvga: Remove handler of
 SVGA_CMD_INVALID_CMD
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

This should be better handled by switch default case, which will output debugging
message about encountering this command, instead of silently discarding.
If such command is ever encountered, it serves as indicator of broken FIFO
command decoding chain.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index c30ae9b4b204..f0e6b4bc74ba 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -776,13 +776,6 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             args = 1;
             goto badcmd;
 
-        /*
-         * Other commands that are not listed as depending on any
-         * CAPABILITIES bits, but are not described in the README either.
-         */
-        case SVGA_CMD_INVALID_CMD:
-            break; /* Nop */
-
         default:
             args = 0;
             goto badcmd;
-- 
1.9.1
