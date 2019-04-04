Received: from eggs.gnu.org ([209.51.188.92]:40461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hBqkT-0008Sv-IC
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hBqkR-0005at-Dq
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:00:57 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hBqkL-0005OW-IZ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:00:50 -0400
Received: by mail-pf1-x441.google.com with SMTP id t21so454512pfe.2
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 18:00:46 -0700 (PDT)
Date: Wed,  3 Apr 2019 17:55:21 -0700
Message-Id: <20190404005523.6513-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL] RISC-V Patches for 4.0-rc3
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

The following changes since commit 49fc899f8d673dd9e73f3db0d9e9ea60b77c331b:

  Update version for v4.0.0-rc1 release (2019-03-26 17:02:29 +0000)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.0-rc3

for you to fetch changes up to b84ffcecdb7a6a3e9946d0d6d24703199c4880b3:

  riscv: plic: Log guest errors (2019-03-27 20:23:03 -0700)

----------------------------------------------------------------
RISC-V Patches for 4.0-rc3

This patch set contains a pair of tightly coupled PLIC bug fixes:

* We were calculating the PLIC addresses incorrectly.
* We were installing the wrong number of PLIC interrupts.

The two bugs togther resulted in a mostly-working system, but they're
impossible to seperate because fixing one bug would result in
significant breakage.  As a result they're in the same patch.

There is also a cleanup to use qemu_log_mask(LOG_GUEST_ERROR,...) for
error reporting.

As far as I know these are the last outstanding RISC-V patches for 4.0.

----------------------------------------------------------------
Alistair Francis (2):
      riscv: plic: Fix incorrect irq calculation
      riscv: plic: Log guest errors

 hw/riscv/sifive_plic.c      | 16 +++++++++++-----
 hw/riscv/sifive_u.c         |  2 +-
 include/hw/riscv/sifive_e.h |  2 +-
 include/hw/riscv/sifive_u.h |  4 ++--
 include/hw/riscv/virt.h     |  2 +-
 5 files changed, 16 insertions(+), 10 deletions(-)
