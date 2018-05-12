Received: from eggs.gnu.org ([2001:4830:134:3::10]:60470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMgI-0003yL-I5
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMgH-0008KX-Pr
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:02:54 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:41359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHMgH-0008KR-K3
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:02:53 -0400
Received: by mail-pl0-x22a.google.com with SMTP id az12-v6so4365069plb.8
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 22:02:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 22:02:41 -0700
Message-Id: <20180512050250.12774-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v1.1 0/9] target/m68k: Convert to TranslatorOps
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

[ Ho, hum.  I didn't clear out my scratch directory before sending v1.0. ]

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
