Received: from eggs.gnu.org ([2001:4830:134:3::10]:44570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leandro.lupori@gmail.com>) id 1fFgVC-0005RU-03
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leandro.lupori@gmail.com>) id 1fFgV7-0003iR-T3
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:48:30 -0400
From: luporl <leandro.lupori@gmail.com>
Date: Mon,  7 May 2018 10:48:06 -0300
Message-Id: <20180507134806.33043-1-leandro.lupori@gmail.com>
Subject: [Qemu-devel] [PATCH] Allow PIR read in privileged mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: luporl <leandro.lupori@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

According to PowerISA, the PIR register should be readable in privileged
mode also, not only in hypervisor privileged mode.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Leandro Lupori <leandro.lupori@gmail.com>
Reviewed-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
---
 target/ppc/translate_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index a72be6d121..7b56e3ffb9 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -7816,7 +7816,7 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
     /* Processor identification */
     spr_register_hv(env, SPR_PIR, "PIR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, SPR_NOACCESS,
                  &spr_read_generic, NULL,
                  0x00000000);
     spr_register_hv(env, SPR_HID0, "HID0",
-- 
2.11.0
