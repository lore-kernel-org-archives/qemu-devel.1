Received: from eggs.gnu.org ([2001:4830:134:3::10]:48685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fYFCI-0007Kx-Qb
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fYFCF-0000kL-DA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47429 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fYFCE-000089-Vk
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:39 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 27 Jun 2018 20:29:00 +0200
Message-Id: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/9] MIPS queue 2018-06-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 00928a421d47f49691cace1207481b7aad31b1=
f1:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80626' into staging (2018-06-26 18:23:49 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu.git tags/mips-queue-2018-06-27

for you to fetch changes up to 8e0b373f8aa4b9feec7b44029455587e2e3d2b0f:

  target/mips: Fix gdbstub to read/write 64 bit FP registers (2018-06-27 =
20:13:50 +0200)

Aleksandar Markovic (1):
  MAINTAINERS: update target-mips maintainers

Peter Maydell (3):
  hw/mips/boston: don't make flash region 'nomigrate'
  hw/mips/mips_malta: don't make bios region 'nomigrate'
  hw/pci-host/xilinx-pcie: don't make "io" region be RAM

Yongbok Kim (5):
  target/mips: Raise a RI when given fs is n/a from CTC1
  target/mips: Fix microMIPS on reset
  target/mips: Update gen_flt_ldst()
  target/mips: Fix data type for offset
  target/mips: Fix gdbstub to read/write 64 bit FP registers

 MAINTAINERS               |  6 +++---
 hw/mips/boston.c          |  3 +--
 hw/mips/mips_malta.c      |  2 +-
 hw/pci-host/xilinx-pcie.c |  5 ++---
 target/mips/gdbstub.c     |  3 ++-
 target/mips/op_helper.c   |  3 +++
 target/mips/translate.c   | 28 ++++++++++++++++------------
 7 files changed, 28 insertions(+), 22 deletions(-)

--=20
2.7.4
