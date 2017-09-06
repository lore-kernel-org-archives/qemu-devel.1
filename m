Received: from eggs.gnu.org ([2001:4830:134:3::10]:41593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqS-0008NQ-0b
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqH-0001UL-T3
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:27 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:36478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqH-0001Mx-MZ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:17 -0400
Received: by mail-pf0-x235.google.com with SMTP id e199so13451604pfh.3
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:40 -0700
Message-Id: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/32] tcg generic translate loop
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

This is v15 of the patch set, reviewed mostly by Emilio and Alex.
I have converions for additional targets, but this is large enough.


r~


The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e:

  Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tgt-20170906

for you to fetch changes up to d0264d86b026e9d948de577b05ff86d708658576:

  target/arm: Perform per-insn cross-page check only for Thumb (2017-09-06 08:06:48 -0700)

----------------------------------------------------------------
tcg generic translate loop v15

----------------------------------------------------------------
Lluís Vilanova (24):
      target: [tcg] Use a generic enum for DISAS_ values
      tcg: Add generic translation framework
      target/i386: [tcg] Port to DisasContextBase
      target/i386: [tcg] Port to init_disas_context
      target/i386: [tcg] Port to insn_start
      target/i386: [tcg] Port to breakpoint_check
      target/i386: [tcg] Port to translate_insn
      target/i386: [tcg] Port to tb_stop
      target/i386: [tcg] Port to disas_log
      target/i386: [tcg] Port to generic translation framework
      target/arm: [tcg] Port to DisasContextBase
      target/arm: [tcg] Port to init_disas_context
      target/arm: [tcg,a64] Port to init_disas_context
      target/arm: [tcg] Port to tb_start
      target/arm: [tcg] Port to insn_start
      target/arm: [tcg,a64] Port to insn_start
      target/arm: [tcg,a64] Port to breakpoint_check
      target/arm: [tcg] Port to translate_insn
      target/arm: [tcg,a64] Port to translate_insn
      target/arm: [tcg] Port to tb_stop
      target/arm: [tcg,a64] Port to tb_stop
      target/arm: [tcg] Port to disas_log
      target/arm: [tcg,a64] Port to disas_log
      target/arm: [tcg] Port to generic translation framework

Richard Henderson (8):
      tcg: Add generic DISAS_NORETURN
      target/i386: Use generic DISAS_* enumerators
      target/arm: Use DISAS_NORETURN
      target/arm: Delay check for magic kernel page
      target/arm: [a64] Move page and ss checks to init_disas_context
      target/arm: Move ss check to init_disas_context
      target/arm: Split out thumb_tr_translate_insn
      target/arm: Perform per-insn cross-page check only for Thumb

 include/exec/exec-all.h       |  29 ---
 include/exec/translator.h     | 144 +++++++++++++
 target/arm/translate.h        |  39 ++--
 accel/tcg/translator.c        | 138 ++++++++++++
 target/arm/translate-a64.c    | 300 +++++++++++++-------------
 target/arm/translate.c        | 478 +++++++++++++++++++++++-------------------
 target/cris/translate.c       |   7 +-
 target/i386/translate.c       | 298 +++++++++++++-------------
 target/lm32/translate.c       |   6 +
 target/m68k/translate.c       |   7 +-
 target/microblaze/translate.c |   6 +
 target/nios2/translate.c      |   6 +
 target/openrisc/translate.c   |   6 +
 target/s390x/translate.c      |   3 +-
 target/unicore32/translate.c  |   7 +-
 target/xtensa/translate.c     |   4 +
 accel/tcg/Makefile.objs       |   1 +
 17 files changed, 909 insertions(+), 570 deletions(-)
 create mode 100644 include/exec/translator.h
 create mode 100644 accel/tcg/translator.c
