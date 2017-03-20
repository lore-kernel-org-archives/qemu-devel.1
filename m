Received: from eggs.gnu.org ([2001:4830:134:3::10]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvb-0003yN-HR
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvV-00072B-D5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:51 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:26502)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvV-0006zK-7z
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:45 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Mar 2017 13:00:19 +0000
Message-ID: <1490014826-4472-4-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
References: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for v2.9 03/10] target-mips: log bad
 coprocessor0 register accesses with LOG_UNIMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1fe0ff3..5c030a9 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4872,7 +4872,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
     return;
=20
 cp0_unimplemented:
-    LOG_DISAS("mfhc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mfhc0 %s (reg %d sel %d)\n", rn, reg, sel)=
;
     tcg_gen_movi_tl(arg, 0);
 }
=20
@@ -4944,7 +4944,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
=20
     (void)rn; /* avoid a compiler warning */
 cp0_unimplemented:
-    LOG_DISAS("mthc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n", rn, reg, sel)=
;
 }
=20
 static inline void gen_mfc0_unimplemented(DisasContext *ctx, TCGv arg)
@@ -5627,7 +5627,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
     return;
=20
 cp0_unimplemented:
-    LOG_DISAS("mfc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mfc0 %s (reg %d sel %d)\n", rn, reg, sel);
     gen_mfc0_unimplemented(ctx, arg);
 }
=20
@@ -6294,7 +6294,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
     return;
=20
 cp0_unimplemented:
-    LOG_DISAS("mtc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mtc0 %s (reg %d sel %d)\n", rn, reg, sel);
 }
=20
 #if defined(TARGET_MIPS64)
@@ -6928,7 +6928,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
     return;
=20
 cp0_unimplemented:
-    LOG_DISAS("dmfc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "dmfc0 %s (reg %d sel %d)\n", rn, reg, sel)=
;
     gen_mfc0_unimplemented(ctx, arg);
 }
=20
@@ -7593,7 +7593,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
     return;
=20
 cp0_unimplemented:
-    LOG_DISAS("dmtc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "dmtc0 %s (reg %d sel %d)\n", rn, reg, sel)=
;
 }
 #endif /* TARGET_MIPS64 */
=20
--=20
2.7.4
