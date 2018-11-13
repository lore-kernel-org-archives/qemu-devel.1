Received: from eggs.gnu.org ([2001:4830:134:3::10]:51381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gMiSr-0003Re-5D
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gMiSj-0006Vu-7O
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:51:24 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:46907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gMiSi-0006Uy-O6
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:51:17 -0500
Received: by mail-pg1-x536.google.com with SMTP id w7so6441110pgp.13
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 15:51:15 -0800 (PST)
Date: Tue, 13 Nov 2018 15:50:41 -0800
Message-Id: <20181113235045.14155-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PR RFC] RISC-V Patches for 3.1-rc2
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

The following changes since commit cb968d275c145467c8b385a3618a207ec111eab1:

  Update version for v3.1.0-rc1 release (2018-11-13 18:16:14 +0000)

are available in the Git repository at:

  git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-rc2

for you to fetch changes up to 3502dc824a7b0218abb49f4350e80a49829748cf:

  RISC-V: Respect fences for user-only emulators (2018-11-13 15:12:15 -0800)

----------------------------------------------------------------
RISC-V Patches for 3.1-rc2

This pull request contains four patches that aren't really related to
each other aside from all being bug fixes that I think should go in for
3.1.0:

* The second half of Alistair's memory leak patch set that I missed last
  week.
* A fix to make fclass.d availiable only on RV64IFD systems (without
  this it's availiable on RV32IFD systems, truncating the result).
* A fix to make sfence.vm availiable only in priv-1.9.1, and sfence.vma
  only availiable in priv-1.10.
* A change to respect fences in user-mode emulators, which were
  previously treated as NOPs.

As usual, this builds and boot Linux for me.  I don't think I have
anything else planned for 3.1.0, but I may be wrong as things are a bit
hectic this week.

----------------------------------------------------------------
Alistair Francis (1):
      hw/riscv/virt: Free the test device tree node name

Bastian Koppelmann (2):
      target/riscv: Fix FCLASS_D being treated as RV64 only
      target/riscv: Fix sfence.vm/a both available in any priv version

Palmer Dabbelt (1):
      RISC-V: Respect fences for user-only emulators

 hw/riscv/virt.c          |  1 +
 target/riscv/translate.c | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)
