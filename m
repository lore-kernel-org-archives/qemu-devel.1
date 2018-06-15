Received: from eggs.gnu.org ([2001:4830:134:3::10]:45134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fTqGU-0001m0-5n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fTqGT-0007CJ-9C
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:03:50 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:35982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fTqGT-0007C0-1Q
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:03:49 -0400
Received: by mail-lf0-x234.google.com with SMTP id u4-v6so15111101lff.3
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 08:03:48 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 15 Jun 2018 17:03:42 +0200
Message-Id: <20180615150343.4937-2-edgar.iglesias@gmail.com>
In-Reply-To: <20180615150343.4937-1-edgar.iglesias@gmail.com>
References: <20180615150343.4937-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v1 1/2] target-microblaze: mmu: Correct masking
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
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Correct the masking of output addresses.

This fixes Coverity CID 1391441.

Fixes: commit 3924a9aa02
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
