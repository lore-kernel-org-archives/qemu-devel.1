Received: from eggs.gnu.org ([2001:4830:134:3::10]:59036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fDAQ3-00063Q-8J
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fDAQ2-00050Y-6l
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:47 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:40087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fDAQ1-0004zx-UY
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:46 -0400
Received: by mail-lf0-x241.google.com with SMTP id j16-v6so12574528lfb.7
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 08:08:45 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 30 Apr 2018 17:08:35 +0200
Message-Id: <20180430150837.20470-4-edgar.iglesias@gmail.com>
In-Reply-To: <20180430150837.20470-1-edgar.iglesias@gmail.com>
References: <20180430150837.20470-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 3/5] target-microblaze: Don't clobber the IMM
 reg for ld/st reversed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Do not clobber the IMM register on reversed load/stores.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index ec12fed49d..100883e2cc 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -952,7 +952,6 @@ static void dec_load(DisasContext *dc)
                 tcg_gen_sub_tl(low, tcg_const_tl(3), low);
                 tcg_gen_andi_tl(t, t, ~3);
                 tcg_gen_or_tl(t, t, low);
-                tcg_gen_mov_tl(env_imm, t);
                 tcg_temp_free(low);
                 break;
             }
@@ -1104,7 +1103,6 @@ static void dec_store(DisasContext *dc)
                 tcg_gen_sub_tl(low, tcg_const_tl(3), low);
                 tcg_gen_andi_tl(t, t, ~3);
                 tcg_gen_or_tl(t, t, low);
-                tcg_gen_mov_tl(env_imm, t);
                 tcg_temp_free(low);
                 break;
             }
-- 
2.14.1
