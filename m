Received: from eggs.gnu.org ([209.51.188.92]:39016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtfoW-0000tE-Qa
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtfcw-0003gh-LU
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:30:03 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:33765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtfcw-0003cT-3j
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:30:02 -0500
Received: by mail-pl1-x636.google.com with SMTP id y10so90329plp.0
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:30:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Feb 2019 13:29:56 -0800
Message-Id: <20190212212957.32393-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 00/24] target/hppa patch queue
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

v2 fixes the clang build failure.  I've addressed this by changing
the names of two of the insns.decode argument sets.  This could
probably use an additional error from decodetree.py itself...

Only reposting the changed patch, 12/24.


r~


The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc06:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-02-12 10:53:37 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20190212

for you to fetch changes up to cb82c5728c3402248068002c0d13f55f9adcb073:

  hw/hppa: forward requests to CPU HPA (2019-02-12 08:59:21 -0800)

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
