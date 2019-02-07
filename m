Received: from eggs.gnu.org ([209.51.188.92]:58134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griFt-0007A1-0J
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griFs-0001Nf-65
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:08 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griFr-0001Lk-Tj
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:08 -0500
Received: by mail-wr1-x442.google.com with SMTP id v13so11218777wrw.5
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:53:41 +0000
Message-Id: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/19] target/hppa: Convert to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, svens@stackframe.org

I started this last year, but only recently have found the time
to ferret out the bugs.

I've tested this vs the gcc execute.exp testsuite, against which
there are no regressions.  It also continues to boot my old debian
sid installation.

I had not previously been aware, but I now know this fixes a bug
with respect to the purge data cache (PDC) instruction.

Helge or Sven, if you have a chance to do a bit more testing in
the next week, I would appreciate it.  Otherwise we can fix any
other minor problems on mainline.

This is based on the target/hppa pull request from this week;
the whole tree can be found at

  https://github.com/rth7680/qemu.git tgt-hppa


r~


Richard Henderson (19):
  target/hppa: Use DisasContextBase.is_jmp
  target/hppa: Begin using scripts/decodetree.py
  target/hppa: Convert move to/from system registers
  target/hppa: Convert remainder of system insns
  target/hppa: Unify specializations of OR
  target/hppa: Convert memory management insns
  target/hppa: Convert arithmetic/logical insns
  target/hppa: Convert indexed memory insns
  target/hppa: Convert fp multiply-add
  target/hppa: Convert conditional branches
  target/hppa: Convert shift, extract, deposit insns
  target/hppa: Convert direct and indirect branches
  target/hppa: Convert arithmetic immediate insns
  target/hppa: Convert offset memory insns
  target/hppa: Convert fp indexed memory insns
  target/hppa: Convert halt/reset insns
  target/hppa: Convert fp fused multiply-add insns
  target/hppa: Convert fp operate insns
  target/hppa: Merge translate_one into hppa_tr_translate_insn

 target/hppa/translate.c   | 3218 +++++++++++++++----------------------
 target/hppa/Makefile.objs |    8 +
 target/hppa/insns.decode  |  527 ++++++
 3 files changed, 1802 insertions(+), 1951 deletions(-)
 create mode 100644 target/hppa/insns.decode

-- 
2.17.2
