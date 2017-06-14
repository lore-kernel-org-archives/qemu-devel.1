Received: from eggs.gnu.org ([2001:4830:134:3::10]:44928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0m0-0001mG-4G
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0lw-0007HX-Vk
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:20 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dL0lw-0007Gg-Qo
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:16 -0400
Received: by mail-qk0-x243.google.com with SMTP id u8so2292211qka.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 22:23:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 13 Jun 2017 22:23:01 -0700
Message-Id: <20170614052311.13785-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 00/10] TCG queued patches
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

The patches from Emilio, plus the code reversions suggested by Alex.


r~



The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170613

for you to fetch changes up to a2dd0eba95c436d500c9450ecb794f6b5db731ab:

  tcg: Remove tb_htable_lookup from helper_lookup_tb_ptr (2017-06-13 22:13:05 -0700)

----------------------------------------------------------------
Queued TCG patches

----------------------------------------------------------------
Emilio G. Cota (3):
      util: add cacheinfo
      tcg: allocate TB structs before the corresponding translated code
      translate-all: consolidate tb init in tb_gen_code

Richard Henderson (7):
      tcg/aarch64: Use ADR in tcg_out_movi
      tcg/arm: Use indirect branch for goto_tb
      tcg/arm: Remove limit on code buffer size
      tcg/arm: Try pc-relative addresses for movi
      tcg/arm: Use ldr (literal) for goto_tb
      Revert "target/aarch64: optimize indirect branches"
      tcg: Remove tb_htable_lookup from helper_lookup_tb_ptr

 include/exec/exec-all.h      |   5 +-
 include/exec/tb-context.h    |   3 +-
 include/qemu/osdep.h         |   3 +
 target/arm/translate-a64.c   |   3 +-
 tcg-runtime.c                |  32 +++-----
 tcg/aarch64/tcg-target.inc.c |   7 +-
 tcg/arm/tcg-target.inc.c     |  78 ++++++++++--------
 tcg/ppc/tcg-target.inc.c     |  71 +----------------
 tcg/tcg.c                    |  20 +++++
 tcg/tcg.h                    |   2 +-
 translate-all.c              |  46 ++++++-----
 util/Makefile.objs           |   1 +
 util/cacheinfo.c             | 185 +++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 308 insertions(+), 148 deletions(-)
 create mode 100644 util/cacheinfo.c
