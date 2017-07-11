Received: from eggs.gnu.org ([2001:4830:134:3::10]:55850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dUwtk-0005j0-1t
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dUwtg-0005xi-Tl
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:24 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:24688)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dUwtg-0005wZ-NZ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:20 -0400
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
	by Forcepoint Email with ESMTPS id 4031E6B48DC26
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 16:16:13 +0100 (IST)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Tue, 11 Jul 2017 16:16:03 +0100
Message-ID: <1499786165-9404-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 0/2] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit b5ed2e11ef39a308dcbef46f66774557b4a41fce:

  build: disable Xen on ARM (2017-07-11 11:23:47 +0100)

are available in the git repository at:

  git://github.com/yongbok/upstream-qemu.git tags/mips-20170711

for you to fetch changes up to 9768e2abf7ca3ef181f7cec134d7305c1643f78a:

  mips/malta: load the initrd at the end of the low memory (2017-07-11 15:06:34 +0100)

----------------------------------------------------------------
MIPS patches 2017-07-11

Changes:
* Fix MSA copy_[s|u]_df corner case of rd = 0
* Update malta to load the initrd at the end of the low memory

----------------------------------------------------------------

Aurelien Jarno (1):
  mips/malta: load the initrd at the end of the low memory

Miodrag Dinic (1):
  target/mips: fix msa copy_[s|u]_df rd = 0 corner case

 hw/mips/mips_malta.c    | 5 +++--
 target/mips/translate.c | 8 ++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.7.4
