Received: from eggs.gnu.org ([2001:4830:134:3::10]:60460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsj-0001vm-LW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsi-00013C-Rb
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:52 -0300
Message-Id: <20170718061005.29518-17-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 16/29] lm32: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Michael Walle <michael@walle.cc>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/lm32/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 692882f447..a9b159a6e3 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1185,7 +1185,7 @@ void lm32_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 
     for (i = 0; i < 32; i++) {
         cpu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
-        if ((i + 1) % 4 == 0) {
+        if (QEMU_IS_ALIGNED(i + 1, 4)) {
             cpu_fprintf(f, "\n");
         }
     }
-- 
2.13.2
