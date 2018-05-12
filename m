Received: from eggs.gnu.org ([2001:4830:134:3::10]:59910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMdU-0007Mw-2I
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMdP-0007J9-5d
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:00:00 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:34111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHMdO-0007It-Va
	for qemu-devel@nongnu.org; Sat, 12 May 2018 00:59:55 -0400
Received: by mail-pg0-x233.google.com with SMTP id g20-v6so3255349pgv.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 21:59:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 21:59:39 -0700
Message-Id: <20180512045950.12386-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/9] target/m68k: Convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

FYI, I've only tested this with linux-user-test-0.3 and
our qemu coldfire testing kernel.


r~


Richard Henderson (9):
  target/m68k: Use DISAS_NORETURN for exceptions
  target/m68k: Replace DISAS_TB_JUMP with DISAS_NORETURN
  target/m68k: Remove DISAS_JUMP_NEXT as unused
  target/m68k: Use lookup_and_goto_tb for DISAS_JUMP
  target/m68k: Rename DISAS_UPDATE and gen_lookup_tb
  target/m68k: Convert to DisasContextBase
  target/m68k: Convert to TranslatorOps
  target/m68k: Improve ending TB at page boundaries
  target/m68k: Merge disas_m68k_insn into m68k_tr_translate_insn

 target/m68k/translate.c | 354 ++++++++++++++++++++--------------------
 1 file changed, 179 insertions(+), 175 deletions(-)

-- 
2.17.0
