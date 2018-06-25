Received: from eggs.gnu.org ([2001:4830:134:3::10]:58217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fXXl6-0002gx-J3
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fXXkz-0002MF-If
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40212 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fXXkz-000234-B0
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:37 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 25 Jun 2018 22:05:55 +0200
Message-Id: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Target MIPS queue, 2018-06-25
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

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

The following changes since commit 35e238c9330669882487f9929e0aa979004318=
53:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180625-pull-r=
equest' into staging (2018-06-25 15:25:26 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu.git=20

for you to fetch changes up to 2209731f338baaad3a1ef419fab1928e1e51ec17:

  target/mips: Fix gdbstub to read/write 64 bit FP registers (2018-06-25 =
21:21:24 +0200)

----------------------------------------------------------------
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
