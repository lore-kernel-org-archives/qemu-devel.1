Received: from eggs.gnu.org ([2001:4830:134:3::10]:52736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFs-00057f-Fr
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFr-0002Ng-KX
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 20:39:16 -0300
Message-Id: <20170508233918.9043-10-f4bug@amsat.org>
In-Reply-To: <20170508233918.9043-1-f4bug@amsat.org>
References: <20170508233918.9043-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/11] target/sparc: fix DEBUG_MMU DPRINTF()
 arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

invalid since 96df2bc99f9

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/sparc/ldst_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 57968d9143..aa83a49a88 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1631,7 +1631,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 
             if (oldreg != env->immu.mmuregs[reg]) {
                 DPRINTF_MMU("immu change reg[%d]: 0x%016" PRIx64 " -> 0x%016"
-                            PRIx64 "\n", reg, oldreg, env->immuregs[reg]);
+                            PRIx64 "\n", reg, oldreg, env->immu.mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
             dump_mmu(stdout, fprintf, env);
@@ -1715,7 +1715,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 
             if (oldreg != env->dmmu.mmuregs[reg]) {
                 DPRINTF_MMU("dmmu change reg[%d]: 0x%016" PRIx64 " -> 0x%016"
-                            PRIx64 "\n", reg, oldreg, env->dmmuregs[reg]);
+                            PRIx64 "\n", reg, oldreg, env->dmmu.mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
             dump_mmu(stdout, fprintf, env);
-- 
2.11.0
