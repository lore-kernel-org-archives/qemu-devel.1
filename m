Received: from eggs.gnu.org ([209.51.188.92]:49561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCCtO-0002fa-GV
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCCtN-000301-F4
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:33493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hCCtN-0002vu-5c
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:37 -0400
Received: by mail-pf1-x429.google.com with SMTP id i19so2270855pfd.0
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 17:39:36 -0700 (PDT)
Date: Thu,  4 Apr 2019 17:39:22 -0700
Message-Id: <20190405003924.1906-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL] RISC-V Patches for 4.0-rc3, v2
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

The following changes since commit 061b51e9195670e9d190cdec46fabcb3c77763fb:

  Update version for v4.0.0-rc2 release (2019-04-02 17:01:20 +0100)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.0-rc3-v2

for you to fetch changes up to 79bcac250f96ba1d4fdecfdc6e3363c9024703a4:

  riscv: plic: Log guest errors (2019-04-04 16:36:21 -0700)

----------------------------------------------------------------
RISC-V Patches for 4.0-rc3, v2

This patch set contains a pair of tightly coupled PLIC bug fixes:

* We were calculating the PLIC addresses incorrectly.
* We were installing the wrong number of PLIC interrupts.

The two bugs togther resulted in a mostly-working system, but they're
impossible to seperate because fixing one bug would result in
significant breakage.  As a result they're in the same patch.

There is also a cleanup to use qemu_log_mask(LOG_GUEST_ERROR,...) for
error reporting.

As far as I know these are the last outstanding RISC-V patches for 4.0.

v2 no longer fails "make check" for me... sorry!

----------------------------------------------------------------
Alistair Francis (2):
      riscv: plic: Fix incorrect irq calculation
      riscv: plic: Log guest errors

 hw/riscv/sifive_plic.c      | 16 +++++++++++-----
 include/hw/riscv/sifive_e.h |  2 +-
 include/hw/riscv/sifive_u.h |  4 ++--
 include/hw/riscv/virt.h     |  2 +-
 4 files changed, 15 insertions(+), 9 deletions(-)
