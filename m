Received: from eggs.gnu.org ([2001:4830:134:3::10]:47906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWX-000348-G9
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWV-00087v-O7
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:21 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZSWV-00087Y-JW
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:19 -0500
Received: by mail-pg0-x241.google.com with SMTP id d6so1676363pgv.2
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 18:23:19 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 18:21:45 -0800
Message-Id: <1515637324-96034-3-git-send-email-mjc@sifive.com>
In-Reply-To: <1515637324-96034-1-git-send-email-mjc@sifive.com>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 02/21] RISC-V ELF Machine Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

Define RISC-V ELF machine EM_RISCV 243

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 include/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index e8a515c..8e457fc 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -112,6 +112,8 @@ typedef int64_t  Elf64_Sxword;
 
 #define EM_UNICORE32    110     /* UniCore32 */
 
+#define EM_RISCV        243     /* RISC-V */
+
 /*
  * This is an interim value that we will use until the committee comes
  * up with a final number.
-- 
2.7.0
