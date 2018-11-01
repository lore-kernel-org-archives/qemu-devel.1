Received: from eggs.gnu.org ([2001:4830:134:3::10]:49243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gIMoa-0007Cb-Bo
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 19:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gIMoV-0005DH-SC
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 19:55:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:41363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gIMoV-0005BY-9J
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 19:55:47 -0400
Received: by mail-pl1-x62b.google.com with SMTP id p16-v6so105198plr.8
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 16:55:46 -0700 (PDT)
Date: Thu,  1 Nov 2018 16:55:22 -0700
Message-Id: <20181101235525.29042-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL] RISC-V Patches for the 3.1 Soft Freeze, Part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-sf1

for you to fetch changes up to a094b3544f2855c0489f5df3c938b14b9a5899e5:

  Add qemu-riscv@nongnu.org as the RISC-V list (2018-10-30 11:04:29 -0700)

----------------------------------------------------------------
RISC-V Patches for the 3.1 Soft Freeze, Part 2

This tag contains a few simple patches that I'd like to target for the
QEMU soft freeze.  There's only one code change: a fix to our PMP
implementation that avoids an internal truncation while computing a
partial PMP read.

I also have two updates to the MAINTAINERS file: one to add Alistair as
a RISC-V maintainer, and one to add our newly created mailing list.

----------------------------------------------------------------
Dayeol Lee (1):
      target/riscv/pmp.c: pmpcfg_csr_read returns bogus value on RV64

Palmer Dabbelt (2):
      Add Alistair as a RISC-V Maintainer
      Add qemu-riscv@nongnu.org as the RISC-V list

 MAINTAINERS        | 2 ++
 target/riscv/pmp.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
