Received: from eggs.gnu.org ([2001:4830:134:3::10]:60406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsf-0001rO-Dj
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLse-0000yp-KI
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:51 -0300
Message-Id: <20170718061005.29518-16-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 15/29] microblaze: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci
(also added braces to satisfy checkpatch)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/microblaze/op_helper.c | 3 ++-
 target/microblaze/translate.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 1e07e21c1c..41ab52fb7a 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -108,8 +108,9 @@ void helper_debug(CPUMBState *env)
              (env->sregs[SR_MSR] & MSR_IE));
     for (i = 0; i < 32; i++) {
         qemu_log("r%2.2d=%8.8x ", i, env->regs[i]);
-        if ((i + 1) % 4 == 0)
+        if (QEMU_IS_ALIGNED(i + 1, 4)) {
             qemu_log("\n");
+        }
     }
     qemu_log("\n\n");
 }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index cb65d1e129..ae7b3c71b0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1839,9 +1839,10 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 
     for (i = 0; i < 32; i++) {
         cpu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
-        if ((i + 1) % 4 == 0)
+        if (QEMU_IS_ALIGNED(i + 1, 4)) {
             cpu_fprintf(f, "\n");
         }
+    }
     cpu_fprintf(f, "\n\n");
 }
 
-- 
2.13.2
