Received: from eggs.gnu.org ([2001:4830:134:3::10]:48250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOtFL-00055T-JB
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 19:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOtFH-0007mw-J4
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 19:14:11 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOtFH-0007kl-CT
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 19:14:07 -0400
Received: by mail-pf0-x242.google.com with SMTP id b74-v6so9716872pfl.5
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 16:14:06 -0700 (PDT)
Received: from cloudburst.twiddle.net (97-126-112-211.tukw.qwest.net.
	[97.126.112.211]) by smtp.gmail.com with ESMTPSA id
	x19-v6sm29357455pfi.5.2018.06.01.16.14.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 01 Jun 2018 16:14:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 16:14:02 -0700
Message-Id: <20180601231403.10525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/1] tcg-next patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 392fba9f583223786f844dce9b2e7f9a0ce0147a:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-010618-1' into staging (2018-06-01 17:32:30 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/tcg-next-pull-request

for you to fetch changes up to 07ea28b41830f946de3841b0ac61a3413679feb9:

  tcg: Pass tb and index to tcg_gen_exit_tb separately (2018-06-01 15:15:27 -0700)

----------------------------------------------------------------
tcg-next queue

----------------------------------------------------------------

Richard Henderson (1):
  tcg: Pass tb and index to tcg_gen_exit_tb separately

 include/exec/gen-icount.h     |  2 +-
 tcg/tcg-op.h                  | 17 +++++++++++++----
 tcg/tcg.h                     |  7 ++++---
 target/alpha/translate.c      | 12 ++++++------
 target/arm/translate-a64.c    |  6 +++---
 target/arm/translate.c        |  8 ++++----
 target/cris/translate.c       |  6 +++---
 target/hppa/translate.c       |  6 +++---
 target/i386/translate.c       |  8 ++++----
 target/lm32/translate.c       |  6 +++---
 target/m68k/translate.c       |  6 +++---
 target/microblaze/translate.c |  6 +++---
 target/mips/translate.c       |  4 ++--
 target/moxie/translate.c      | 14 +++++++-------
 target/nios2/translate.c      |  8 ++++----
 target/openrisc/translate.c   |  6 +++---
 target/ppc/translate.c        |  4 ++--
 target/riscv/translate.c      | 20 ++++++++++----------
 target/s390x/translate.c      | 10 +++++-----
 target/sh4/translate.c        |  8 ++++----
 target/sparc/translate.c      | 16 ++++++++--------
 target/tilegx/translate.c     |  4 ++--
 target/tricore/translate.c    | 20 ++++++++++----------
 target/unicore32/translate.c  |  6 +++---
 target/xtensa/translate.c     |  4 ++--
 tcg/tcg-op.c                  | 24 ++++++++++++++++++++++--
 26 files changed, 134 insertions(+), 104 deletions(-)

-- 
2.17.0
