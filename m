Received: from eggs.gnu.org ([2001:4830:134:3::10]:55784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1df3QX-0007qF-1j
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1df3QT-0002Vz-T0
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:16:01 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:34542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1df3QT-0002Vm-Nq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:15:57 -0400
Received: by mail-ua0-x241.google.com with SMTP id k43so1948668uaf.1
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 05:15:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  8 Aug 2017 09:15:44 -0300
Message-Id: <20170808121544.12850-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.10] target/mips: remove MIPS16 ASE from
 4Km
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

MIPS32 4Km does not support the MIPS16 instruction set, see:
    MIPS32 4K Processor Core Family Software UM (MD00016 Rev 01.18)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
probably incorrect copy/paste from 8d162c2b68db72623a507069fda0e35ccd1c6b85

 target/mips/translate_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 255d25bacd..7297c8c000 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -149,7 +149,7 @@ static const mips_def_t mips_defs[] =
         .CP0_Status_rw_bitmask = 0x1258FF17,
         .SEGBITS = 32,
         .PABITS = 32,
-        .insn_flags = CPU_MIPS32 | ASE_MIPS16,
+        .insn_flags = CPU_MIPS32,
         .mmu_type = MMU_TYPE_FMT,
     },
     {
-- 
2.13.3
