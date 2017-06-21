Received: from eggs.gnu.org ([2001:4830:134:3::10]:36874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNfEB-0008C2-33
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNfEA-0008Tf-A4
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:59:23 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNfEA-0008TL-2W
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:59:22 -0400
Received: by mail-lf0-x244.google.com with SMTP id l200so9421401lfg.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 05:59:21 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 21 Jun 2017 14:59:11 +0200
Message-Id: <1498049955-28646-4-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1498049955-28646-1-git-send-email-edgar.iglesias@gmail.com>
References: <1498049955-28646-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 3/7] target-microblaze: dec_barrel: Add
 braces around if-statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add braces around if-statements.
No functional change.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index e959de7..504ed88 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -681,13 +681,14 @@ static void dec_barrel(DisasContext *dc)
     tcg_gen_mov_tl(t0, *(dec_alu_op_b(dc)));
     tcg_gen_andi_tl(t0, t0, 31);
 
-    if (s)
+    if (s) {
         tcg_gen_shl_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
-    else {
-        if (t)
+    } else {
+        if (t) {
             tcg_gen_sar_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
-        else
+        } else {
             tcg_gen_shr_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
+        }
     }
 }
 
-- 
2.7.4
