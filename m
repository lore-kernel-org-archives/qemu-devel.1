Received: from eggs.gnu.org ([2001:4830:134:3::10]:50654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlv-0003Bx-13
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlu-0004NP-0c
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlt-0004MB-OA
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGls-0003lz-M6
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:36 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:11 +0100
Message-Id: <20180608124517.29475-26-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/31] target/xtensa: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Message-id: 20180606152128.449-12-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/xtensa/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 89db23852b7..a11162eebe0 100644
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
