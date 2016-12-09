Received: from eggs.gnu.org ([2001:4830:134:3::10]:43773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFNkI-0001Du-JJ
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFNkE-0008S8-Hc
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:10:02 -0500
Received: from mail-wj0-f175.google.com ([209.85.210.175]:35406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFNkE-0008RF-74
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:09:58 -0500
Received: by mail-wj0-f175.google.com with SMTP id v7so18351743wjy.2
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 08:09:58 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1479906121-12211-1-git-send-email-rth@twiddle.net>
Date: Fri, 09 Dec 2016 16:08:54 +0000
Message-ID: <87pol1xey1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 00/64] tcg 2.9 patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> This is a combination of two patch sets that have had previous
> revisions, as well as some new patches.  I wanted to post this
> all together since Alex was having trouble with prerequisites.
>
> The full tree is at
>
>   git://github.com/rth7680/qemu.git tcg-2.9

OK I've finished my pass through this uber-set. I've given it a fairly
good tyre-kicking on ARM (guest and hosts) with RISU so I think you can
have a:

Tested-by: Alex Bennée <alex.bennee@linaro.org>

for the ARM bits at least.

>
> Changes since v3:
>   * PPC host patches have been properly annotated for cpu revision,
>     - cnttz[wd] are power9 inventions,
>     - cntpop[wd] are power7 inventions.
>
>   * X86 host checks the correct cpuid bit for lzcnt.
>
>   * Generic TCG has significant changes to enable "interesting"
>     combinations of constraints for X86 host bsr/bsf and to some
>     extent lzcnt/tzcnt.
>
>   * Opcode for ctpop.  I had begun with only the helpers for ctpop,
>     but added the opcode after I discovered that power7/8 could use
>     that as a better alternative for implementing ctz.
>
>   * Updates to the i386 and ppc disassemblers, to handle the new
>     insns that we're emitting.
>
>
> r~
>
>
> Richard Henderson (64):
>   tcg: Add field extraction primitives
>   tcg: Minor adjustments to deposit expanders
>   tcg: Add deposit_z expander
>   tcg/aarch64: Implement field extraction opcodes
>   tcg/arm: Move isa detection to tcg-target.h
>   tcg/arm: Implement field extraction opcodes
>   tcg/i386: Implement field extraction opcodes
>   tcg/mips: Implement field extraction opcodes
>   tcg/ppc: Implement field extraction opcodes
>   tcg/s390: Expose host facilities to tcg-target.h
>   tcg/s390: Implement field extraction opcodes
>   tcg/s390: Support deposit into zero
>   target-alpha: Use deposit and extract ops
>   target-arm: Use new deposit and extract ops
>   target-i386: Use new deposit and extract ops
>   target-mips: Use the new extract op
>   target-ppc: Use the new deposit and extract ops
>   target-s390x: Use the new deposit and extract ops
>   tcg/optimize: Fold movcond 0/1 into setcond
>   tcg: Add markup for output requires new register
>   tcg: Transition flat op_defs array to a target callback
>   tcg: Pass the opcode width to target_parse_constraint
>   tcg: Allow an operand to be matching or a constant
>   tcg: Add clz and ctz opcodes
>   disas/i386.c: Handle tzcnt
>   disas/ppc: Handle popcnt and cnttz
>   target-alpha: Use the ctz and clz opcodes
>   target-cris: Use clz opcode
>   target-microblaze: Use clz opcode
>   target-mips: Use clz opcode
>   target-openrisc: Use clz and ctz opcodes
>   target-ppc: Use clz and ctz opcodes
>   target-s390x: Use clz opcode
>   target-tilegx: Use clz and ctz opcodes
>   target-tricore: Use clz opcode
>   target-unicore32: Use clz opcode
>   target-xtensa: Use clz opcode
>   target-arm: Use clz opcode
>   target-i386: Use clz and ctz opcodes
>   tcg/ppc: Handle ctz and clz opcodes
>   tcg/aarch64: Handle ctz and clz opcodes
>   tcg/arm: Handle ctz and clz opcodes
>   tcg/mips: Handle clz opcode
>   tcg/s390: Handle clz opcode
>   tcg/i386: Fuly convert tcg_target_op_def
>   tcg/i386: Hoist common arguments in tcg_out_op
>   tcg/i386: Allow bmi2 shiftx to have non-matching operands
>   tcg/i386: Handle ctz and clz opcodes
>   tcg/i386: Rely on undefined/undocumented behaviour of BSF/BSR
>   tcg: Add helpers for clrsb
>   target-arm: Use clrsb helper
>   target-tricore: Use clrsb helper
>   target-xtensa: Use clrsb helper
>   tcg: Add opcode for ctpop
>   target-alpha: Use ctpop helper
>   target-ppc: Use ctpop helper
>   target-s390x: Avoid a loop for popcnt
>   target-sparc: Use ctpop helper
>   target-tilegx: Use ctpop helper
>   target-i386: Use ctpop helper
>   qemu/host-utils.h: Reduce the operation count in the fallback ctpop
>   tcg: Use ctpop to generate ctz if needed
>   tcg/ppc: Handle ctpop opcode
>   tcg/i386: Handle ctpop opcode
>
>  disas/i386.c                  |  12 +-
>  disas/ppc.c                   |  10 +
>  include/qemu/host-utils.h     |  25 +-
>  target-alpha/helper.h         |   4 -
>  target-alpha/int_helper.c     |  15 -
>  target-alpha/translate.c      |  73 +++--
>  target-arm/helper-a64.c       |  20 --
>  target-arm/helper-a64.h       |   4 -
>  target-arm/helper.c           |   5 -
>  target-arm/helper.h           |   1 -
>  target-arm/translate-a64.c    |  95 ++----
>  target-arm/translate.c        |  43 +--
>  target-cris/helper.h          |   1 -
>  target-cris/op_helper.c       |   5 -
>  target-cris/translate.c       |   2 +-
>  target-i386/cc_helper.c       |   3 +
>  target-i386/cpu.h             |   1 +
>  target-i386/helper.h          |   2 -
>  target-i386/int_helper.c      |  11 -
>  target-i386/ops_sse.h         |  26 --
>  target-i386/ops_sse_header.h  |   1 -
>  target-i386/translate.c       |  89 ++---
>  target-microblaze/helper.h    |   1 -
>  target-microblaze/op_helper.c |   5 -
>  target-microblaze/translate.c |   2 +-
>  target-mips/helper.h          |   7 -
>  target-mips/op_helper.c       |  22 --
>  target-mips/translate.c       |  35 +-
>  target-openrisc/helper.h      |   2 -
>  target-openrisc/int_helper.c  |  19 --
>  target-openrisc/translate.c   |   6 +-
>  target-ppc/helper.h           |   7 +-
>  target-ppc/int_helper.c       |  38 +--
>  target-ppc/translate.c        |  61 ++--
>  target-s390x/helper.h         |   1 -
>  target-s390x/int_helper.c     |  21 +-
>  target-s390x/translate.c      |  36 ++-
>  target-sparc/helper.c         |   5 -
>  target-sparc/helper.h         |   1 -
>  target-sparc/translate.c      |   2 +-
>  target-tilegx/helper.c        |  15 -
>  target-tilegx/helper.h        |   3 -
>  target-tilegx/translate.c     |   6 +-
>  target-tricore/helper.h       |   3 -
>  target-tricore/op_helper.c    |  15 -
>  target-tricore/translate.c    |   7 +-
>  target-unicore32/helper.c     |  10 -
>  target-unicore32/helper.h     |   3 -
>  target-unicore32/translate.c  |   6 +-
>  target-xtensa/helper.h        |   2 -
>  target-xtensa/op_helper.c     |  13 -
>  target-xtensa/translate.c     |   4 +-
>  tcg-runtime.c                 |  40 +++
>  tcg/README                    |  28 +-
>  tcg/aarch64/tcg-target.h      |  10 +
>  tcg/aarch64/tcg-target.inc.c  |  90 +++++-
>  tcg/arm/tcg-target.h          |  41 ++-
>  tcg/arm/tcg-target.inc.c      | 119 ++++---
>  tcg/i386/tcg-target.h         |  17 +
>  tcg/i386/tcg-target.inc.c     | 732 +++++++++++++++++++++++++++---------------
>  tcg/ia64/tcg-target.h         |  10 +
>  tcg/ia64/tcg-target.inc.c     |  28 +-
>  tcg/mips/tcg-target.h         |   5 +
>  tcg/mips/tcg-target.inc.c     |  66 +++-
>  tcg/optimize.c                |  94 ++++++
>  tcg/ppc/tcg-target.h          |  13 +
>  tcg/ppc/tcg-target.inc.c      | 117 ++++++-
>  tcg/s390/tcg-target.h         | 128 ++++----
>  tcg/s390/tcg-target.inc.c     | 173 ++++++----
>  tcg/sparc/tcg-target.h        |  10 +
>  tcg/sparc/tcg-target.inc.c    |  28 +-
>  tcg/tcg-op.c                  | 695 ++++++++++++++++++++++++++++++++++++++-
>  tcg/tcg-op.h                  |  42 +++
>  tcg/tcg-opc.h                 |  10 +
>  tcg/tcg-runtime.h             |   9 +
>  tcg/tcg.c                     | 173 +++++-----
>  tcg/tcg.h                     |  14 +-
>  tcg/tci/tcg-target.h          |  10 +
>  tcg/tci/tcg-target.inc.c      |  25 +-
>  79 files changed, 2425 insertions(+), 1108 deletions(-)


--
Alex Bennée
