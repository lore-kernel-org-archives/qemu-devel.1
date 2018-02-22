Received: from eggs.gnu.org ([2001:4830:134:3::10]:38565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosim-00050I-AD
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosik-0001qe-Ux
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosik-0001pM-OA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:42 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosij-00026D-JP
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:41 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:23:00 +0000
Message-Id: <20180222152307.7499-26-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/32] sdcard: handle CMD54 (SDIO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Linux uses it to poll the bus before polling for a card.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-10-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cc5caaf4f0..63da05eaef 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1371,9 +1371,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         }
         break;
 
-    case 52:
-    case 53:
-        /* CMD52, CMD53: reserved for SDIO cards
+    case 52 ... 54:
+        /* CMD52, CMD53, CMD54: reserved for SDIO cards
          * (see the SDIO Simplified Specification V2.0)
          * Handle as illegal command but do not complain
          * on stderr, as some OSes may use these in their
-- 
2.16.1
