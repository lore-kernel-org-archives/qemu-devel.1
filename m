Received: from eggs.gnu.org ([2001:4830:134:3::10]:55764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFmch-0005cc-R5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFmcb-0007fY-Hb
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:52266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFmcb-0007ek-BT
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:01 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 30 May 2017 21:15:48 +0200
Message-Id: <20170530191553.31500-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 0/5] Queued target/sh4 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Aurelien Jarno <aurelien@aurel32.net>

The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b04:

  Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (2017-05-30 14:15:15 +0100)

are available in the git repository at:

  git://git.aurel32.net/qemu.git tags/pull-target-sh4-20170530

for you to fetch changes up to be53081a619443dc4512039d89345475ef7d9a46:

  target/sh4: fix RTE instruction delay slot (2017-05-30 21:00:56 +0200)

----------------------------------------------------------------
Queued target/sh4 patches

----------------------------------------------------------------
Aurelien Jarno (5):
      target/sh4: log unauthorized accesses using qemu_log_mask
      target/sh4: fix reset when using a kernel and an initrd
      target/sh4: introduce DELAY_SLOT_MASK
      target/sh4: ignore interrupts in a delay slot
      target/sh4: fix RTE instruction delay slot

 target/sh4/cpu.h       | 12 ++++++++++--
 target/sh4/helper.c    | 28 ++++++++++++++++++++++------
 target/sh4/translate.c | 25 ++++++++++++++-----------
 3 files changed, 46 insertions(+), 19 deletions(-)


Note that is based against master, but rather against
https://github.com/stefanha/qemu/commits/staging

-- 
2.11.0
