Received: from eggs.gnu.org ([2001:4830:134:3::10]:39444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaGG-0004zz-CX
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaGF-0003mj-Ij
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 12:21:28 -0300
Message-Id: <20180606152128.449-12-f4bug@amsat.org>
In-Reply-To: <20180606152128.449-1-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 11/11] target/xtensa: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because I think the qemu_log_mask() was previously intended to concatenate
output to stderr... (multiple registers described on a single line).

 target/xtensa/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 89db23852b..a11162eebe 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2234,7 +2234,7 @@ static void translate_rur(DisasContext *dc, const uint32_t arg[],
         if (uregnames[par[0]].name) {
             tcg_gen_mov_i32(cpu_R[arg[0]], cpu_UR[par[0]]);
         } else {
-            qemu_log_mask(LOG_UNIMP, "RUR %d not implemented, ", par[0]);
+            qemu_log_mask(LOG_UNIMP, "RUR %d not implemented\n", par[0]);
         }
     }
 }
@@ -2375,7 +2375,7 @@ static void translate_slli(DisasContext *dc, const uint32_t arg[],
 {
     if (gen_window_check2(dc, arg[0], arg[1])) {
         if (arg[2] == 32) {
-            qemu_log_mask(LOG_GUEST_ERROR, "slli a%d, a%d, 32 is undefined",
+            qemu_log_mask(LOG_GUEST_ERROR, "slli a%d, a%d, 32 is undefined\n",
                           arg[0], arg[1]);
         }
         tcg_gen_shli_i32(cpu_R[arg[0]], cpu_R[arg[1]], arg[2] & 0x1f);
@@ -2571,7 +2571,7 @@ static void translate_wur(DisasContext *dc, const uint32_t arg[],
         if (uregnames[par[0]].name) {
             gen_wur(par[0], cpu_R[arg[0]]);
         } else {
-            qemu_log_mask(LOG_UNIMP, "WUR %d not implemented, ", par[0]);
+            qemu_log_mask(LOG_UNIMP, "WUR %d not implemented\n", par[0]);
         }
     }
 }
-- 
2.17.1
