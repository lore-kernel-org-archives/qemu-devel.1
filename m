Received: from eggs.gnu.org ([2001:4830:134:3::10]:54594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1chET4-0000Ao-P0
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1chET1-00035f-MZ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:55:22 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:58849)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1chET1-000350-HZ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:55:19 -0500
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 24 Feb 2017 11:54:59 +0000
Message-ID: <1487937300-33744-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 2d896b454a0e19ec4c1ddbb0e0b65b7e54fcedf3:

  Revert "hw/mips: MIPS Boston board support" (2017-02-23 18:04:45 +0000)

are available in the git repository at:

  git://github.com/yongbok/upstream-qemu.git tags/mips-20170224-2

for you to fetch changes up to df1d8a1f29f567567b9d20be685a4241282e7005:

  hw/mips: MIPS Boston board support (2017-02-24 10:37:21 +0000)

----------------------------------------------------------------
MIPS patches 2017-02-24-2

CHanges:
* Add the Boston board with fixing the make check issue on 32-bit hosts.

----------------------------------------------------------------

Paul Burton (1):
  hw/mips: MIPS Boston board support

 configure                            |   2 +-
 default-configs/mips64el-softmmu.mak |   3 +
 hw/mips/Makefile.objs                |   1 +
 hw/mips/boston.c                     | 577 +++++++++++++++++++++++++++++++++++
 4 files changed, 582 insertions(+), 1 deletion(-)
 create mode 100644 hw/mips/boston.c

-- 
2.7.4
