Received: from eggs.gnu.org ([2001:4830:134:3::10]:48370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR1Hz-0006Uq-Lo
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR1Hw-00034d-Jm
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:11 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dR1Hw-00033n-Eu
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:08 -0400
Received: by mail-qk0-x243.google.com with SMTP id v143so3780309qkb.3
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 12:09:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 30 Jun 2017 12:09:00 -0700
Message-Id: <20170630190903.9886-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 0/3] Queued TCG patches
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

None of my TCGTemp patches for now; I'm still trying to understand
how they might (or might not) conflict with multi-threaded code gen
for TCG.


r~


The following changes since commit 82d76dc7fc19a5eb9f731d7faed1792bb97214e0:

  Merge remote-tracking branch 'remotes/famz/tags/block-pull-request' into staging (2017-06-30 16:29:51 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170603

for you to fetch changes up to f3ced3c59287dabc253f83f0c70aa4934470c15e:

  tcg: consistently access cpu->tb_jmp_cache atomically (2017-06-30 11:40:59 -0700)

----------------------------------------------------------------
Queued TCG patches

----------------------------------------------------------------
Emilio G. Cota (3):
      gen-icount: add missing inline to gen_tb_end
      gen-icount: use tcg_ctx.tcg_env instead of cpu_env
      tcg: consistently access cpu->tb_jmp_cache atomically

 include/exec/gen-icount.h | 12 +++++++-----
 include/qom/cpu.h         | 11 ++++++++++-
 accel/tcg/cputlb.c        |  4 ++--
 accel/tcg/translate-all.c | 26 ++++++++++++--------------
 qom/cpu.c                 |  5 +----
 5 files changed, 32 insertions(+), 26 deletions(-)
