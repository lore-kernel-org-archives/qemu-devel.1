Received: from eggs.gnu.org ([2001:4830:134:3::10]:38968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPcKw-0006Tv-Qr
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPcKs-00058A-U8
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:55:14 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gPcKq-00052C-QS
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:55:09 -0500
Received: by mail-pl1-x642.google.com with SMTP id e5so7669583plb.5
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 15:55:00 -0800 (PST)
Date: Wed, 21 Nov 2018 15:46:50 -0800
Message-Id: <20181121234651.24596-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH for-3.1 1/2] MAINTAINERS: Any file with "riscv"
 in the name is a RISC-V file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>

There was a recent thread about unmaintained files in QEMU where it was
noted that a few RISC-V related files had slipped through the patterns
in our MAINTAINERS file entry.  This patch adds some more aggressive
pattern matching in an attempt to rectify this situation.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1032406c5607..e89adc81d5d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -255,6 +255,8 @@ F: target/riscv/
 F: hw/riscv/
 F: include/hw/riscv/
 F: disas/riscv.c
+K: riscv
+N: riscv
 
 S390
 M: Richard Henderson <rth@twiddle.net>
-- 
2.18.1
