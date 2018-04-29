Received: from eggs.gnu.org ([2001:4830:134:3::10]:53531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fCgwP-0001ni-3A
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 03:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fCgwM-0001LS-14
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 03:40:13 -0400
Date: Sun, 29 Apr 2018 09:40:02 +0200
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20180429094002.3293c9de@thl530.multi.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] hw/m68k/mcf5208: Fix trivial typo in board
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>

It's the MCF5208 evaluation board, not the MCF5206 eval board.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf5208.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 7aca58542e..ae3dcc98c3 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -315,7 +315,7 @@ static void mcf5208evb_init(MachineState *machine)
 
 static void mcf5208evb_machine_init(MachineClass *mc)
 {
-    mc->desc = "MCF5206EVB";
+    mc->desc = "MCF5208EVB";
     mc->init = mcf5208evb_init;
     mc->is_default = 1;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
-- 
2.14.3
