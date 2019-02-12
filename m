Received: from eggs.gnu.org ([209.51.188.92]:49218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8k-0002Xh-RD
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8Y-0001ds-Ng
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:41 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:38814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8Q-0001SL-U0
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:33 -0500
Received: by mail-pg1-x534.google.com with SMTP id g189so665863pgc.5
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:56:57 -0800
Message-Id: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 00/24] target/hppa patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit 22c5f446514a2a4bb0dbe1fea26713da92fc85fa:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190211' into staging (2019-02-11 17:04:57 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20190211

for you to fetch changes up to 23e76627deba013509b5f1a1e1c53e8e111145aa:

  hw/hppa: forward requests to CPU HPA (2019-02-11 20:49:06 -0800)

----------------------------------------------------------------
Convert to decodetree.
Fix signed overflow conditions.
Fix dcor.
Add CPU MIE to PCI address space.

----------------------------------------------------------------
Richard Henderson (20):
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
      target/hppa: Rearrange log conditions

Sven Schnelle (4):
      target/hppa: move GETPC to HELPER() functions
      target/hppa: Fix addition '</<=' conditions
      target/hppa: fix dcor instruction
      hw/hppa: forward requests to CPU HPA

 hw/hppa/dino.c            |    8 +-
 target/hppa/op_helper.c   |   16 +-
 target/hppa/translate.c   | 3355 ++++++++++++++++++---------------------------
 target/hppa/Makefile.objs |    8 +
 target/hppa/insns.decode  |  527 +++++++
 5 files changed, 1915 insertions(+), 1999 deletions(-)
 create mode 100644 target/hppa/insns.decode
