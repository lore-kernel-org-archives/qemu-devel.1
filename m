Received: from eggs.gnu.org ([2001:4830:134:3::10]:44012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDVlI-0003Pn-Bx
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDVlH-00080L-Is
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:56:08 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  1 May 2018 15:55:43 +0200
Message-Id: <20180501135547.12414-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/4] M68k for 2.13 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, Michael Tokarev <mjt@tls.msk.ru>

The following changes since commit c2c768500f17fc8cdcfa44d169f089953bb22748:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.13-pull-request' into staging (2018-04-30 10:43:41 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.13-pull-request

for you to fetch changes up to 83dc62f6ed6b4f2afce71d579a630441cca0957c:

  hw/m68k/mcf5208: Fix trivial typo in board description (2018-05-01 15:37:54 +0200)

----------------------------------------------------------------
Some fixes for m68k CPU emulation
including the trivial one from Thomas for mcf5208 (m68k hardware)
----------------------------------------------------------------

Laurent Vivier (2):
  m68k: Fix floatx80_lognp1 (Coverity CID1390587)
  m68k: remove dead code (Coverity CID1390617)

Pavel Dovgalyuk (1):
  m68k: fix subx mem, mem instruction

Thomas Huth (1):
  hw/m68k/mcf5208: Fix trivial typo in board description

 hw/m68k/mcf5208.c       |  2 +-
 target/m68k/softfloat.c | 46 ++++++++++++++++------------------------------
 target/m68k/translate.c |  4 ++--
 3 files changed, 19 insertions(+), 33 deletions(-)

-- 
2.14.3
