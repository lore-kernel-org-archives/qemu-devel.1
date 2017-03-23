Received: from eggs.gnu.org ([2001:4830:134:3::10]:50878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cr24q-00063r-77
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cr24p-00051Q-Gk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:42:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cr24p-0004wS-96
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:42:51 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 12:42:41 +0000
Message-Id: <1490272961-1128-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9] disas/microblaze: Remove unused REG_PC
 define
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

The REG_PC define in disas/microblaze.c clashes with a define in
the Linux SPARC system headers:

/home/pm215/qemu/disas/microblaze.c:162:0: error: "REG_PC" redefined [-Werror]
 #define REG_PC  32 /* PC */

In file included from /usr/include/signal.h:326:0,
                 from /home/pm215/qemu/include/qemu/osdep.h:86,
                 from /home/pm215/qemu/disas/microblaze.c:36:
/usr/include/sparc64-linux-gnu/sys/ucontext.h:96:0: note: this is the location of the previous definition
 #define REG_PC  (1)

Since the code doesn't actually use the REG_PC define
anywhere, the simplest fix is just to remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 disas/microblaze.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 407c0a3..7795a0b 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -159,7 +159,7 @@ enum microblaze_instr_type {
 #define MIN_PVR_REGNUM 0
 #define MAX_PVR_REGNUM 15
 
-#define REG_PC  32 /* PC */
+/* 32 is REG_PC */
 #define REG_MSR 33 /* machine status reg */
 #define REG_EAR 35 /* Exception reg */
 #define REG_ESR 37 /* Exception reg */
-- 
2.7.4
