Received: from eggs.gnu.org ([2001:4830:134:3::10]:38961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dX7RU-0004Wa-At
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dX7RT-0005UA-Ka
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:56:12 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dX7RT-0005TT-EQ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:56:11 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 17 Jul 2017 16:55:54 +0200
Message-Id: <20170717145556.14142-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] target/mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

Two additional MIPS patches that have been sent a few weeks ago and
which got reviewed.

Thanks,
Aurelien

The following changes since commit 77031ee1ce4c7e5f4b4941535c4912eb2eb3503c:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-20170717' into staging (2017-07-17 12:52:59 +0100)

are available in the git repository at:

  git://git.aurel32.net/qemu.git tags/pull-target-mips-20170717

for you to fetch changes up to 06a57e5cc7ee5292a4915117ebf951e310a28264:

  target/mips: optimize WSBH, DSBH and DSHD (2017-07-17 16:48:21 +0200)

----------------------------------------------------------------
Queued target/mips patches

----------------------------------------------------------------
Aurelien Jarno (1):
      target/mips: optimize WSBH, DSBH and DSHD

Pavel Dovgalyuk (1):
      mips: set CP0 Debug DExcCode for SDBBP instruction

 target/mips/helper.c    |  2 ++
 target/mips/translate.c | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.11.0
