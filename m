Received: from eggs.gnu.org ([2001:4830:134:3::10]:41555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXy-0002Az-4k
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXx-0000b0-E6
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:06 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dSKXx-0000aa-60
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:05 -0400
Received: by mail-lf0-x244.google.com with SMTP id z78so4904788lff.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:55:04 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  4 Jul 2017 11:54:41 +0200
Message-Id: <1499162088-1562-11-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
References: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 10/17] target-microblaze: dec_barrel: Use
 bool instead of unsigned int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Use bool instead of unsigned int to represent flags.
No functional change.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index fbb8bb4..4136a8e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -660,7 +660,7 @@ static void dec_div(DisasContext *dc)
 static void dec_barrel(DisasContext *dc)
 {
     TCGv t0;
-    unsigned int s, t;
+    bool s, t;
 
     if ((dc->tb_flags & MSR_EE_FLAG)
           && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
-- 
2.7.4
