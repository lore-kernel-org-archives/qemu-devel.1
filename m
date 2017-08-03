Received: from eggs.gnu.org ([2001:4830:134:3::10]:35386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNS-00016K-AN
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNN-0002TL-8V
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:30 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:48334)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNN-0002R9-2E
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:25 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 3 Aug 2017 15:45:07 +0100
Message-ID: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit aaaec6acad7cf97372d48c1b09126a09697519=
c8:

  Update version for v2.10.0-rc1 release (2017-08-02 16:36:32 +0100)

are available in the git repository at:

  git://github.com/yongbok/upstream-qemu.git tags/mips-20170803

for you to fetch changes up to d673a68db6963e86536b125af464bb6ed03eba33:

  target/mips: Fix RDHWR CC with icount (2017-08-02 22:18:13 +0100)

----------------------------------------------------------------
MIPS patches 2017-08-03

Changes:
KVM T&E segment support for TCG
malta: leave space for the bootmap after the initrd
Apply CP0.PageMask before writing into TLB entry
Fix fallout from indirect branch optimisation

----------------------------------------------------------------

Aurelien Jarno (1):
  mips/malta: leave space for the bootmap after the initrd

James Hogan (6):
  target-mips: Don't stop on [d]mtc0 DESAVE/KScratch
  mips: Improve segment defs for KVM T&E guests
  mips: Add KVM T&E segment support for TCG
  target/mips: Use BS_EXCP where interrupts are expected
  target/mips: Drop redundant gen_io_start/stop()
  target/mips: Fix RDHWR CC with icount

Leon Alrae (1):
  target-mips: apply CP0.PageMask before writing into TLB entry

 hw/mips/addr.c            | 12 ++++++++
 hw/mips/mips_malta.c      | 24 +++++++--------
 include/hw/mips/cpudevs.h |  5 ++--
 target/mips/helper.c      | 27 +++++++++--------
 target/mips/op_helper.c   |  5 ++--
 target/mips/translate.c   | 74 ++++++++++++++++++++++++++++++-----------=
------
 6 files changed, 90 insertions(+), 57 deletions(-)

--=20
2.7.4
