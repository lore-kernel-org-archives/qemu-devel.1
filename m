Received: from eggs.gnu.org ([209.51.188.92]:38329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hDZa4-0003SK-Bl
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hDZZy-0008UB-O0
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:05:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
	id 1hDZZu-0008OB-UP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:05:12 -0400
From: Lidong Chen <lidong.chen@oracle.com>
Date: Mon,  8 Apr 2019 15:04:36 -0400
Message-Id: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
Subject: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: f4bug@amsat.org, darren.kenny@oracle.com, liam.merwick@oracle.com, lidong.chen@oracle.com

Due to an off-by-one error, the assert statements allow an
out-of-bounds array access.

Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aaab15f..818f86c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates state)
     if (state == sd_inactive_state) {
         return "inactive";
     }
-    assert(state <= ARRAY_SIZE(state_name));
+    assert(state < ARRAY_SIZE(state_name));
     return state_name[state];
 }
 
@@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
     if (rsp == sd_r1b) {
         rsp = sd_r1;
     }
-    assert(rsp <= ARRAY_SIZE(response_name));
+    assert(rsp < ARRAY_SIZE(response_name));
     return response_name[rsp];
 }
 
-- 
1.8.3.1
