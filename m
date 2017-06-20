Received: from eggs.gnu.org ([2001:4830:134:3::10]:44737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiK-0002tO-1E
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiI-0003ZF-Ap
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:12 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNLiI-0003YH-3N
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:10 -0400
Received: by mail-lf0-x242.google.com with SMTP id n136so4201569lfn.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 09:09:10 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Jun 2017 18:08:59 +0200
Message-Id: <1497974944-27050-3-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/7] target-microblaze: dec_barrel: Use
 extract32
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

Use extract32 instead of opencoding the shifting and masking.
No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4136a8e..e959de7 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -670,8 +670,8 @@ static void dec_barrel(DisasContext *dc)
         return;
     }
 
-    s = dc->imm & (1 << 10);
-    t = dc->imm & (1 << 9);
+    s = extract32(dc->imm, 10, 1);
+    t = extract32(dc->imm, 9, 1);
 
     LOG_DIS("bs%s%s r%d r%d r%d\n",
             s ? "l" : "r", t ? "a" : "l", dc->rd, dc->ra, dc->rb);
-- 
2.7.4
