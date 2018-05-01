Received: from eggs.gnu.org ([2001:4830:134:3::10]:44036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDVlJ-0003Qt-DO
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDVlI-00081A-MA
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:56:09 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  1 May 2018 15:55:47 +0200
Message-Id: <20180501135547.12414-5-laurent@vivier.eu>
In-Reply-To: <20180501135547.12414-1-laurent@vivier.eu>
References: <20180501135547.12414-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 4/4] hw/m68k/mcf5208: Fix trivial typo in board
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
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <huth@tuxfamily.org>

It's the MCF5208 evaluation board, not the MCF5206 eval board.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180429094002.3293c9de@thl530.multi.box>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
