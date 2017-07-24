Received: from eggs.gnu.org ([2001:4830:134:3::10]:47782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxW-0002zC-Pg
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxR-0000lA-SQ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:06 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjxR-0000kZ-NP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:01 -0400
Received: by mail-qt0-x244.google.com with SMTP id i19so2540522qte.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:26:56 -0700
Message-Id: <20170724202728.25960-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v15 00/32] Generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, vilanova@ac.upc.edu

I believe I've incorporated all of the feedback from v14.

Several bugs in the ARM transition: extra temp free, thumb
condexec label emission (Emilio).

Lots of comments updated (Emilio, Lluis).


r~


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

-- 
2.13.3
