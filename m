Received: from eggs.gnu.org ([2001:4830:134:3::10]:33440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2CL-0001ZO-GF
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2CK-0002ou-IB
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:20:05 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:43975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ey2CK-0002oP-Cy
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:20:04 -0400
Received: by mail-pl0-x242.google.com with SMTP id f23-v6so11037958plr.10
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 14:20:04 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Mon, 19 Mar 2018 14:18:48 -0700
Message-Id: <1521494329-19546-26-git-send-email-mjc@sifive.com>
In-Reply-To: <1521494329-19546-1-git-send-email-mjc@sifive.com>
References: <1521494329-19546-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v4 25/26] RISC-V: Remove erroneous comment from
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 808eab7..c3a029a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -280,7 +280,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
         tcg_gen_andi_tl(source2, source2, 0x1F);
         tcg_gen_sar_tl(source1, source1, source2);
         break;
-        /* fall through to SRA */
 #endif
     case OPC_RISC_SRA:
         tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
-- 
2.7.0
