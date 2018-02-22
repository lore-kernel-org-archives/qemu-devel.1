Received: from eggs.gnu.org ([2001:4830:134:3::10]:38653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosis-000589-Pi
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosir-0001yX-W5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:50 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosir-0001wQ-Pc
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:49 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiq-00027Q-LQ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:48 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:23:05 +0000
Message-Id: <20180222152307.7499-31-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/32] sdcard: warn if host uses an incorrect
 address for APP CMD (CMD55)
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-15-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d6dd2b9a15..c8351d4f0b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1391,6 +1391,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         case sd_identification_state:
         case sd_inactive_state:
             return sd_illegal;
+        case sd_idle_state:
+            if (rca) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
+            }
         default:
             break;
         }
-- 
2.16.1
