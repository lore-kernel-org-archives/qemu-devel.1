Received: from eggs.gnu.org ([2001:4830:134:3::10]:48789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fG8vE-0003jV-97
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fG8vA-0004v1-64
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:09:16 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fG8v9-0004un-Uv
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:09:12 -0400
Received: by mail-pl0-x243.google.com with SMTP id a39-v6so2859973pla.10
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 13:09:11 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  9 May 2018 08:07:37 +1200
Message-Id: <1525810060-36690-1-git-send-email-mjc@sifive.com>
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
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)

are available in the git repository at:

  https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.13-minor-fixes-2

for you to fetch changes up to fc28db142ea9331d24d08a6418efa93e258a6876:

  riscv: requires libfdt (2018-05-09 07:57:57 +1200)

----------------------------------------------------------------
RISC-V: QEMU 2.13 Minor Fixes

* Require libfdt when configuring for 'riscv*-softmmu'
* Increase HTIF priority and allow zero base address

Consider backporting to stable branch for 2.12.1

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
