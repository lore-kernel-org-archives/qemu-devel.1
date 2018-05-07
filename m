Received: from eggs.gnu.org ([2001:4830:134:3::10]:35472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fFpMx-0008AP-TF
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fFpMt-0006iQ-Ke
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:16:35 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fFpMt-0006hm-DZ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:16:31 -0400
Received: by mail-pf0-x241.google.com with SMTP id a14so23028899pfi.1
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 16:16:31 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Tue,  8 May 2018 11:14:50 +1200
Message-Id: <1525734893-10299-1-git-send-email-mjc@sifive.com>
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
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair.francis@xilinx.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-stable@nongnu.org

The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)

are available in the git repository at:

  https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.13-minor-fixes-1

for you to fetch changes up to d4a63373c0e6349c6f36f56a6290ad639bfa20cb:

  riscv: requires libfdt (2018-05-08 10:57:21 +1200)

----------------------------------------------------------------
RISC-V: QEMU 2.13 Minor Fixes

* Require libfdt when configuring for 'riscv*-softmmu'
* Increase HTIF priority and allow zero address

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
