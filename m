Received: from eggs.gnu.org ([2001:4830:134:3::10]:45232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGMEe-0002HO-Qx
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGMEa-0003yO-H3
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:22:12 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fGMEa-0003xB-AB
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:22:08 -0400
Received: by mail-pf0-x241.google.com with SMTP id o76so25410962pfi.5
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 03:22:08 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  9 May 2018 22:20:37 +1200
Message-Id: <1525861240-4130-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] RISC-V: QEMU 2.13 Minor Fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)

are available in the git repository at:

  https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.13-minor-fixes-3

for you to fetch changes up to a666409f0df5dce113a5bd2c4c144a0792f2a4a3:

  riscv: requires libfdt (2018-05-09 22:14:28 +1200)

----------------------------------------------------------------
RISC-V: QEMU 2.13 Minor Fixes

* Require libfdt when configuring for 'riscv*-softmmu'
* Increase HTIF priority and allow zero base address

----------------------------------------------------------------
KONRAD Frederic (3):
      riscv: spike: allow base == 0
      riscv: htif: increase the priority of the htif subregion
      riscv: requires libfdt

 configure             |  2 +-
 hw/riscv/riscv_htif.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.7.0
