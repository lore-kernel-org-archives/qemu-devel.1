Received: from eggs.gnu.org ([2001:4830:134:3::10]:45657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvV-0003um-PO
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvR-000700-RS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:45 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:29049)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvR-0006yN-Lt
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:41 -0400
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
	by Forcepoint Email with ESMTPS id 1174BFF7DDAB5
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 13:00:35 +0000 (GMT)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Mar 2017 13:00:16 +0000
Message-ID: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for v2.9 00/10] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

The following changes since commit bedf13ecab38bcd479e9db6994ebc3b2c5c7a3=
ae:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170320-1=
' into staging (2017-03-20 10:05:45 +0000)

are available in the git repository at:

  git://github.com/yongbok/upstream-qemu.git tags/mips-20170320

for you to fetch changes up to 659f42d8c30bad9bf677652fc9d3f0ada63fd6e0:

  MAINTAINERS: update for MIPS devices (2017-03-20 11:20:46 +0000)

----------------------------------------------------------------
MIPS patches 2017-03-20

Changes:
* Fix clang warnings
* Fix delay slot detection in gen_msa_branch()
* Fix rc4030 interval timer
* Fix rc4030 to tranlate memory accesses only when they occur
* Fix 4c4030 a mixed declarations and code warning
* Update MAINTAINERS file

----------------------------------------------------------------

Herv=C3=A9 Poussineau (1):
  dma/rc4030: translate memory accesses only when they occur

Philippe Mathieu-Daud=C3=A9 (5):
  target-mips: fix compiler warnings (clang 5)
  target-mips: remove old & unuseful comments
  target-mips: log bad coprocessor0 register accesses with LOG_UNIMP
  target-mips: replace break by goto cp0_unimplemented
  target-mips: replace few LOG_DISAS() with trace points

Prasad J Pandit (1):
  dma: rc4030: limit interval timer reload value

Yongbok Kim (3):
  target/mips: fix delay slot detection in gen_msa_branch()
  dma/rc4030: fix a mixed declarations and code warning
  MAINTAINERS: update for MIPS devices

 MAINTAINERS              |  17 ++++-
 Makefile.objs            |   1 +
 hw/dma/rc4030.c          | 162 +++++++++++------------------------------=
------
 target/mips/helper.c     |  16 +++--
 target/mips/trace-events |   5 ++
 target/mips/translate.c  | 131 ++++++++++++++++++--------------------
 6 files changed, 133 insertions(+), 199 deletions(-)
 create mode 100644 target/mips/trace-events

--=20
2.7.4
