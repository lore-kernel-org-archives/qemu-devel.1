Received: from eggs.gnu.org ([2001:4830:134:3::10]:58633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWXCN-0005VU-4A
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWXCM-0007rV-CS
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:46:27 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:35156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eWXCM-0007qL-6N
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:46:26 -0500
Received: by mail-pl0-x241.google.com with SMTP id b96so143296pli.2
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:46:26 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  3 Jan 2018 13:44:06 +1300
Message-Id: <1514940265-18093-3-git-send-email-mjc@sifive.com>
In-Reply-To: <1514940265-18093-1-git-send-email-mjc@sifive.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 02/21] RISC-V ELF Machine Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Define RISC-V ELF machine EM_RISCV 243

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
