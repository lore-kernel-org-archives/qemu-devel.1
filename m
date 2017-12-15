Received: from eggs.gnu.org ([2001:4830:134:3::10]:60198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePtSX-0001RP-9v
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePtSU-0002q8-4A
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:41 -0500
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233]:36323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ePtST-0002pU-VU
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:38 -0500
Received: by mail-it0-x233.google.com with SMTP id d16so20542028itj.1
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 09:07:37 -0800 (PST)
Received: from cloudburst.twiddle.net (141-126-166-226.dhcp.chtrptr.net.
	[141.126.166.226]) by smtp.gmail.com with ESMTPSA id
	k23sm4012974iti.22.2017.12.15.09.07.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 15 Dec 2017 09:07:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Dec 2017 11:07:25 -0600
Message-Id: <20171215170732.31125-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/7] TCG misc patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Two reviewed patches from the 2.11 soft-freeze era, and five
preparatory patches extract from my host vector patch set.

One more post for review...


r~


Alex Bennée (1):
  target/*helper: don't check retaddr before calling cpu_restore_state

Richard Henderson (6):
  target/moxie: Fix tlb_fill
  tcg: Remove TCGV_UNUSED* and TCGV_IS_UNUSED*
  tcg: Dynamically allocate TCGOps
  tcg: Generalize TCGOp parameters
  tcg: Add tcg_signed_cond
  tcg: Allow 6 arguments to TCG helpers

 include/exec/gen-icount.h                  |   9 +-
 include/exec/helper-gen.h                  |  11 +++
 include/exec/helper-head.h                 |   2 +
 include/exec/helper-proto.h                |   5 +
 include/exec/helper-tcg.h                  |   7 ++
 include/qemu/queue.h                       |   5 +
 target/arm/translate.h                     |  10 +-
 tcg/tcg-op.h                               |   4 -
 tcg/tcg.h                                  |  60 +++++-------
 target/alpha/mem_helper.c                  |  13 +--
 target/alpha/translate.c                   |  22 ++---
 target/arm/op_helper.c                     |  18 ++--
 target/arm/translate-a64.c                 |  37 ++++---
 target/arm/translate.c                     |  31 +++---
 target/cris/translate.c                    |   4 +-
 target/hppa/translate.c                    |  63 ++++++------
 target/i386/svm_helper.c                   |   4 +-
 target/i386/translate.c                    |  13 ++-
 target/lm32/op_helper.c                    |   7 +-
 target/lm32/translate.c                    |   2 -
 target/m68k/op_helper.c                    |   7 +-
 target/m68k/translate.c                    |  14 +--
 target/microblaze/op_helper.c              |   7 +-
 target/microblaze/translate.c              |   4 -
 target/mips/translate.c                    |   2 +-
 target/moxie/helper.c                      |   5 +-
 target/nios2/mmu.c                         |   7 +-
 target/nios2/translate.c                   |   6 +-
 target/openrisc/mmu_helper.c               |   6 +-
 target/ppc/translate.c                     |   2 +-
 target/s390x/translate.c                   |  42 ++++----
 target/sh4/translate.c                     |   2 +-
 target/sparc/translate.c                   |   2 +-
 target/tilegx/translate.c                  |  10 +-
 target/tricore/op_helper.c                 |  13 +--
 target/unicore32/op_helper.c               |   7 +-
 target/unicore32/translate.c               |   4 +-
 tcg/optimize.c                             |  20 +---
 tcg/tcg-op.c                               |  24 -----
 tcg/tcg.c                                  | 149 +++++++++++------------------
 tcg/tci.c                                  |  12 ++-
 tcg/tci/tcg-target.inc.c                   |   6 +-
 scripts/coccinelle/cpu_restore_state.cocci |  19 ++++
 43 files changed, 305 insertions(+), 392 deletions(-)
 create mode 100644 scripts/coccinelle/cpu_restore_state.cocci

-- 
2.14.3
