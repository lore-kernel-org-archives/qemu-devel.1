Received: from eggs.gnu.org ([2001:4830:134:3::10]:40952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5VM8-0004id-Rm
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5VM4-0007Ij-3V
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:53:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f5VM3-0007Hq-PG
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:52:59 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  9 Apr 2018 13:52:11 +0200
Message-Id: <20180409115212.875-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/2] linux-user: fix microblaze
 get_sp_from_cpustate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Laurent Vivier <laurent@vivier.eu>

get_sigframe() uses regs[1] and this is actual SP.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/microblaze/target_signal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/microblaze/target_signal.h b/linux-user/microblaze/target_signal.h
index de2b0f49d5..642865f12e 100644
--- a/linux-user/microblaze/target_signal.h
+++ b/linux-user/microblaze/target_signal.h
@@ -23,7 +23,7 @@ typedef struct target_sigaltstack {
 
 static inline abi_ulong get_sp_from_cpustate(CPUMBState *state)
 {
-    return state->regs[14];
+    return state->regs[1];
 }
 
 
-- 
2.14.3
