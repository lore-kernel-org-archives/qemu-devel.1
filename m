Received: from eggs.gnu.org ([209.51.188.92]:38300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotmo-0004Y8-2P
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotmg-0008RN-Vv
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:26 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:36502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gotmd-0008LF-9w
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:21 -0500
Received: by mail-pf1-x42f.google.com with SMTP id b85so141260pfc.3
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 09:36:16 -0800 (PST)
Date: Wed, 30 Jan 2019 09:35:51 -0800
Message-Id: <20190130173601.3268-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PR RFC] RISC-V Patches for 3.2, Part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org

The following changes since commit 5385a5988c8a55bebdc878c05b96648579b5d6e0:

  hw/virtio/virtio-balloon: zero-initialize the virtio_balloon_config struct (2019-01-21 17:20:36 +0000)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-3.2-part3

for you to fetch changes up to 461ab9de46d085a37b0da6f096aadc4e0dda4d4c:

  target/riscv: fix counter-enable checks in ctr() (2019-01-29 11:33:38 -0800)

----------------------------------------------------------------
RISC-V Patches for 3.2, Part 3

This patch set contains a handful of patches I've collected over the
last few weeks.  There's nothing really fundamental, but I thought it
would be good to send these out now as there are some other patch sets
on the mailing list that are getting ready to go.

As far as the actual patches, there's:

* A set that cleans up our FS dirty-mode handling.
* Support for writing MISA.
* The removal of Michael as a maintainer.
* A fix to {m,s}counteren handling.

This passes my standard "boots Fedora" test case.

----------------------------------------------------------------
Alistair Francis (1):
      RISC-V: Add priv_ver to DisasContext

Michael Clark (5):
      RISC-V: Implement mstatus.TSR/TW/TVM
      RISC-V: Use riscv prefix consistently on cpu helpers
      RISC-V: Add misa to DisasContext
      RISC-V: Add misa.MAFD checks to translate
      RISC-V: Add misa runtime write support

Palmer Dabbelt (1):
      MAINTAINERS: Remove Michael Clark as a RISC-V Maintainer

Richard Henderson (2):
      RISC-V: Split out mstatus_fs from tb_flags
      RISC-V: Mark mstatus.fs dirty

Xi Wang (1):
      target/riscv: fix counter-enable checks in ctr()

 MAINTAINERS               |   1 -
 linux-user/riscv/signal.c |   4 +-
 target/riscv/cpu.c        |   2 +-
 target/riscv/cpu.h        |  31 ++---
 target/riscv/cpu_bits.h   |  11 ++
 target/riscv/cpu_helper.c |  10 +-
 target/riscv/csr.c        | 103 ++++++++++++----
 target/riscv/fpu_helper.c |   6 +-
 target/riscv/op_helper.c  |  47 +++++---
 target/riscv/translate.c  | 290 +++++++++++++++++++++++++++++++++++++++-------
 10 files changed, 396 insertions(+), 109 deletions(-)
