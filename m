Received: from eggs.gnu.org ([2001:4830:134:3::10]:56011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GUf-0004Jt-El
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GUc-000355-AZ
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:20:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:05 +0300
Message-Id: <2d812d6dff5267d80c54125f15a090539573d29e.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 02/23] ppc_booke: drop useless assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: KONRAD Frederic <fred.konrad@greensocs.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: KONRAD Frederic <fred.konrad@greensocs.com>

The tb_env variable is set two lines above. So just drop the double assignment.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/ppc/ppc_booke.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 60baffaf1d..23bcf1b138 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -282,7 +282,6 @@ void store_booke_tcr(CPUPPCState *env, target_ulong val)
     ppc_tb_t *tb_env = env->tb_env;
     booke_timer_t *booke_timer = tb_env->opaque;
 
-    tb_env = env->tb_env;
     env->spr[SPR_BOOKE_TCR] = val;
     kvmppc_set_tcr(cpu);
 
-- 
2.11.0
