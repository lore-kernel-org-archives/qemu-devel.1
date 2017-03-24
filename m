Received: from eggs.gnu.org ([2001:4830:134:3::10]:58507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1crOl9-0005YX-Rg
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1crOl6-0002tN-MC
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:56:03 -0400
From: fred.konrad@greensocs.com
Date: Fri, 24 Mar 2017 13:55:47 +0100
Message-Id: <1490360147-26450-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH] ppc_booke: drop useless assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

The tb_env variable is set two lines above. So just drop the double assignment.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 hw/ppc/ppc_booke.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 60baffa..23bcf1b 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -282,7 +282,6 @@ void store_booke_tcr(CPUPPCState *env, target_ulong val)
     ppc_tb_t *tb_env = env->tb_env;
     booke_timer_t *booke_timer = tb_env->opaque;
 
-    tb_env = env->tb_env;
     env->spr[SPR_BOOKE_TCR] = val;
     kvmppc_set_tcr(cpu);
 
-- 
1.8.3.1
