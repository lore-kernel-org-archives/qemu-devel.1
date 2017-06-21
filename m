Received: from eggs.gnu.org ([2001:4830:134:3::10]:36855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNfEA-0008BZ-Hn
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNfE8-0008TF-U3
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:59:22 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNfE8-0008Sq-Mp
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:59:20 -0400
Received: by mail-lf0-x242.google.com with SMTP id u62so20947380lfg.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 05:59:20 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 21 Jun 2017 14:59:10 +0200
Message-Id: <1498049955-28646-3-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1498049955-28646-1-git-send-email-edgar.iglesias@gmail.com>
References: <1498049955-28646-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/7] target-microblaze: dec_barrel: Use
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

Reviewed-by: Richard Henderson <rth@twiddle.net>
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
