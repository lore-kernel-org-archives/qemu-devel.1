Received: from eggs.gnu.org ([2001:4830:134:3::10]:40786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dkOfq-0004HY-Sj
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dkOfn-0003RU-Q2
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:57:54 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1dkOfn-0003Qm-KW
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:57:51 -0400
Received: by mail-pf0-x244.google.com with SMTP id m6so726143pfm.1
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 22:57:50 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Wed, 23 Aug 2017 14:57:08 +0900
Message-Id: <cover.1503467674.git.shorne@gmail.com>
Subject: [Qemu-devel] [PATCH 0/5] OpenRISC SMP Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Openrisc <openrisc@lists.librecores.org>, Stafford Horne <shorne@gmail.com>

Hello,

This series adds SMP support for OpenRISC.  The platform is based on the
work that Stefan Kristiansson did around 2012 implemented in Verilog and
run on FPGAs.  I have been working to upstream this work, these are my QEMU
patches I have been used to help with testing.

I have documented the platform in the OpenRISC 1.2 specification proposal
available here:
  https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf

My latest kernel patches are available here:
  https://github.com/stffrdhrn/linux.git openrisc-4.13-smp-qspinlock

Stafford Horne (5):
  openrisc/ompic: Add OpenRISC Multicore PIC (OMPIC)
  target/openrisc: Make coreid and numcores configurable in state
  openrisc/cputimer: Perparation for Multicore
  openrisc: Initial SMP support
  openrisc: Only kick cpu on timeout, not on update

 default-configs/or1k-softmmu.mak |   1 +
 hw/intc/Makefile.objs            |   1 +
 hw/intc/ompic.c                  | 179 +++++++++++++++++++++++++++++++++++++++
 hw/openrisc/cputimer.c           |  64 ++++++++++----
 hw/openrisc/openrisc_sim.c       |  87 ++++++++++++++-----
 target/openrisc/cpu.c            |   1 -
 target/openrisc/cpu.h            |   7 +-
 target/openrisc/machine.c        |   8 +-
 target/openrisc/sys_helper.c     |   8 +-
 9 files changed, 308 insertions(+), 48 deletions(-)
 create mode 100644 hw/intc/ompic.c

-- 
2.13.5
