Received: from eggs.gnu.org ([2001:4830:134:3::10]:56226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPP-0004mi-I0
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPM-00076q-V7
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPM-00076H-Eu
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:12 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:18 +0300
Message-Id: <1533815202-11967-6-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 05/29] vmsvga: Show registers and commands on
 debug output as decimals
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

For better readability of debug output, show these values in decimal notation,
as they are defined in source by decimal integers.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 2e6ac5dfad8a..2fbb9e7f6c9f 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -773,7 +773,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
                 vmsvga_fifo_read(s);
             }
             if (!cmd_ignored) {
-                printf("%s: Unknown command 0x%02x in SVGA command FIFO\n",
+                printf("%s: Unknown command %d in SVGA command FIFO\n",
                        __func__, cmd);
             }
             break;
@@ -964,7 +964,7 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
             ret = s->scratch[s->index - SVGA_SCRATCH_BASE];
             break;
         }
-        printf("%s: Bad register %02x\n", __func__, s->index);
+        printf("%s: Bad register %d\n", __func__, s->index);
         ret = 0;
         break;
     }
@@ -1092,7 +1092,7 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
             s->scratch[s->index - SVGA_SCRATCH_BASE] = value;
             break;
         }
-        printf("%s: Bad register %02x\n", __func__, s->index);
+        printf("%s: Bad register %d\n", __func__, s->index);
     }
 }
 
-- 
1.9.1
