Received: from eggs.gnu.org ([2001:4830:134:3::10]:53719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKp7o-0006KE-Hk
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKp7k-0002hr-LN
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:33:52 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:45188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gKp7k-0002J6-Bs
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:33:48 -0500
Received: by mail-pl1-x62c.google.com with SMTP id o19-v6so9910924pll.12
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 10:33:20 -0800 (PST)
Date: Thu,  8 Nov 2018 10:33:05 -0800
Message-Id: <20181108183306.4361-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL] A Single RISC-V Patch for 3.1-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org

The following changes since commit a7ce790a029bd94eb320d8c69f38900f5233997e:

  tcg/tcg-op.h: Add multiple include guard (2018-11-08 15:15:32 +0000)

are available in the Git repository at:

  git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-rc1

for you to fetch changes up to 00a014ac01feac875468d38c376f7e06f050f992:

  riscv: spike: Fix memory leak in the board init (2018-11-08 08:41:06 -0800)

----------------------------------------------------------------
A Single RISC-V Patch for 3.1-rc1

This tag contains a single patch that I'd like to target for rc1: a fix
for a memory leak that was detected by static code analysis.

There are still three patch sets that I'd like to try to get up for 3.1:

* The patch set Basian just published that contains fixes for a pair of
  issues he found when converting our port to decodetree.
* An as-of-yet-unwritten fix to the third issue that Basian pointed out.
* A fix to our fflags bug, which is currently coupled to some CSR
  refactoring that I don't think is OK for 3.1.

I'm at Plumbers next week (and I think Alistair is there too?), but I'll
try to find a way to squeeze in as much as possible.

----------------------------------------------------------------
Alistair Francis (1):
      riscv: spike: Fix memory leak in the board init

 hw/riscv/spike.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
