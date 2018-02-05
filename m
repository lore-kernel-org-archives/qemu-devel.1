Received: from eggs.gnu.org ([2001:4830:134:3::10]:58170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eiaCD-0004or-8u
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eiaCC-00061v-9q
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:24:05 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eiaCC-00061S-3r
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:24:04 -0500
Received: by mail-pg0-x243.google.com with SMTP id x25so5056246pge.3
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 22:24:04 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Mon,  5 Feb 2018 19:22:27 +1300
Message-Id: <1517811767-75958-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1517811767-75958-1-git-send-email-mjc@sifive.com>
References: <1517811767-75958-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v4 02/22] RISC-V ELF Machine Definition
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
