Received: from eggs.gnu.org ([2001:4830:134:3::10]:35760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gFGrM-0005nc-Dm
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gFGrH-0001T5-KY
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:57:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gFGrA-0001Kq-P0
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:57:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id y16so5095131wrw.3
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 03:57:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 24 Oct 2018 12:57:32 +0200
Message-Id: <20181024105733.18605-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] disas/mips: Increase 'member of ISAs' flag
 holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Fredrik Noring <noring@nocrew.org>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Increase the size of 'membership' holder size to 64 bits. This is
needed for future extensions since existing bits are almost all used.
(This change is related to f9c9cd63e3),

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 disas/mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/mips.c b/disas/mips.c
index 97f661a37e..d73d4094d8 100644
--- a/disas/mips.c
+++ b/disas/mips.c
@@ -301,7 +301,7 @@ struct mips_opcode
   unsigned long pinfo2;
   /* A collection of bits describing the instruction sets of which this
      instruction or macro is a member. */
-  unsigned long membership;
+  uint64_t membership;
 };
 
 /* These are the characters which may appear in the args field of an
-- 
2.19.1
