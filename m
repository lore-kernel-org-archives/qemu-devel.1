Received: from eggs.gnu.org ([2001:4830:134:3::10]:50190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fTYnt-0002US-LZ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fTYnr-0006A3-KT
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:09 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:41736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fTYnr-00069D-C8
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:07 -0400
Received: by mail-lf0-x22d.google.com with SMTP id d24-v6so11380616lfa.8
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:25:07 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 14 Jun 2018 22:25:01 +0200
Message-Id: <20180614202502.668-2-edgar.iglesias@gmail.com>
In-Reply-To: <20180614202502.668-1-edgar.iglesias@gmail.com>
References: <20180614202502.668-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 1/2] target-microblaze: mmu: Correct masking
 of output addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Correct the masking of output addresses.

This fixes Coverity CID 1391441.

Fixes: commit 3924a9aa02
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/mmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index f4ceaea520..fcf86b12d5 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -159,7 +159,6 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
 
             lu->vaddr = tlb_tag;
             lu->paddr = tlb_rpn & mmu->c_addr_mask;
-            lu->paddr = tlb_rpn;
             lu->size = tlb_size;
             lu->err = ERR_HIT;
             lu->idx = i;
-- 
2.14.1
