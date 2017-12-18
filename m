Received: from eggs.gnu.org ([2001:4830:134:3::10]:57298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45a-0007HM-AG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45Z-000472-BM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:50 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eR45Z-0003uK-3Z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:49 -0500
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 18 Dec 2017 23:40:24 +0100
Message-Id: <20171218224030.26726-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/6] Queued target/sh4 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

The following changes since commit eaefea537b476cb853e2edbdc68e969ec777e4bb:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-12-18 14:17:42 +0000)

are available in the Git repository at:

  git://git.aurel32.net/qemu.git tags/pull-target-sh4-20171218

for you to fetch changes up to 6f1c2af641d6e7aceb2e5671a45b3d6e5966dfb8:

  target/sh4: Convert to DisasContextBase (2017-12-18 23:35:33 +0100)

----------------------------------------------------------------
Queued target/sh4 patches

----------------------------------------------------------------
Alex Bennée (1):
      target/sh4: fix TCG leak during gusa sequence

Philippe Mathieu-Daudé (1):
      target/sh4: add missing tcg_temp_free() in _decode_opc()

Richard Henderson (4):
      target/sh4: Use cmpxchg for movco when parallel_cpus
      target/sh4: Convert to DisasJumpType
      target/sh4: Do not singlestep after exceptions
      target/sh4: Convert to DisasContextBase

 linux-user/main.c      |  19 +++-
 target/sh4/cpu.h       |   4 +-
 target/sh4/helper.c    |   1 +
 target/sh4/translate.c | 273 ++++++++++++++++++++++++++++---------------------
 4 files changed, 174 insertions(+), 123 deletions(-)

-- 
2.15.1
