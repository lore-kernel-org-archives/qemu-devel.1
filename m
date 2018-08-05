Received: from eggs.gnu.org ([2001:4830:134:3::10]:39569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fmNkg-0005I1-9i
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 14:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fmNkb-0003xp-CD
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 14:27:38 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Sun,  5 Aug 2018 14:26:19 -0400
Message-Id: <20180805182625.13540-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH 0/6] Some improvements in z/Arch instructions
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>

Add BAL, BALR, CVB instructions
Fix few bugs in PACK, CSST

Pavel Zbitskiy (6):
  target/s390x: add BAL and BALR instructions
  target/s390x: fix CSST decoding and runtime alignment check
  target/s390x: fix ipm polluting irrelevant bits
  target/s390x: add EX support for TRT and TRTR
  target/s390x: fix PACK reading 1 byte less and writing 1 byte more
  target/s390x: implement CVB, CVBY and CVBG

 target/s390x/helper.h      |  2 ++
 target/s390x/insn-data.def |  7 ++++++
 target/s390x/int_helper.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/mem_helper.c  | 24 +++++++++++++++----
 target/s390x/translate.c   | 52 +++++++++++++++++++++++++++++++++++++----
 5 files changed, 135 insertions(+), 8 deletions(-)

-- 
2.16.2.windows.1
