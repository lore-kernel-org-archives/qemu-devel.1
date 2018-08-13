Received: from eggs.gnu.org ([2001:4830:134:3::10]:42860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fp1Ay-0002t5-PG
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fp1At-0006Cu-SI
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:57:40 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:47816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1fp1At-0006CO-Lb
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:57:35 -0400
From: Julian Brown <julian@codesourcery.com>
Date: Sun, 12 Aug 2018 17:57:12 -0700
Message-ID: <cover.1534121196.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/2] Nios II generic board config and
 semihosting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrew Jenner <Andrew_Jenner@mentor.com>, Sandra Loosemore <sandra@codesourcery.com>, Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>

This is the fourth version of the patch series previously posted here:

http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg04571.html

The contents of the patches are largely the same apart from some linting
from the checkpatch.pl script. I've also rebased and re-tested with
Sandra's new libgloss bits as mentioned in:

http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg00358.html

Thanks,

Julian

Julian Brown (2):
  Add generic Nios II board.
  Add Nios II semihosting support.

 hw/nios2/Makefile.objs     |   2 +-
 hw/nios2/boot.c            |   5 +-
 hw/nios2/generic_nommu.c   | 128 +++++++++++++
 qemu-options.hx            |   8 +-
 target/nios2/Makefile.objs |   2 +-
 target/nios2/cpu.h         |   4 +-
 target/nios2/helper.c      |  11 ++
 target/nios2/nios2-semi.c  | 446 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 598 insertions(+), 8 deletions(-)
 create mode 100644 hw/nios2/generic_nommu.c
 create mode 100644 target/nios2/nios2-semi.c

-- 
2.8.1
