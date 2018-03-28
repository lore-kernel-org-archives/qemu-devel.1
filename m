Received: from eggs.gnu.org ([2001:4830:134:3::10]:39004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1Hsa-000447-45
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1HsW-0000VH-W2
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:41:08 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f1HsW-0000Uk-Pr
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:41:04 -0400
Received: by mail-pg0-x242.google.com with SMTP id 201so1561458pgg.3
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 13:41:04 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 28 Mar 2018 13:40:17 -0700
Message-Id: <1522269619-48636-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] RISC-V: Important fixes for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>

The following changes since commit 043289bef4d9c0d277c45695c676a6cc9fca48a0:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180328' into staging (2018-03-28 13:30:10 +0100)

are available in the git repository at:

  https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-important-fixes

for you to fetch changes up to 33b4f859f1e1ea6722d10c3e9c0e3d85afb44ff4:

  RISC-V: Fix incorrect disassembly for addiw (2018-03-28 11:12:02 -0700)

----------------------------------------------------------------
RISC-V: Important fixes for QEMU 2.12

This series includes changes that are considered important.
i.e. correct user-visible bugs that are exercised by common
operations such as -cpu list (CPU model changes) or -d in_asm
(fix for disassembly of addiw)

----------------------------------------------------------------
Michael Clark (2):
      RISC-V: Convert cpu definition to future model
      RISC-V: Fix incorrect disassembly for addiw

 disas/riscv.c      |   2 +-
 target/riscv/cpu.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------
 2 files changed, 70 insertions(+), 55 deletions(-)
