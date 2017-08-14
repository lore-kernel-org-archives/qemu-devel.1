Received: from eggs.gnu.org ([2001:4830:134:3::10]:52251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDDz-0003hS-Lp
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDDu-0004jl-4c
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:07:59 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 14 Aug 2017 14:07:37 +0300
Message-Id: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 0/7] Trivial patches for 2017-08-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

There are just a few small thigs, I've omitted larger series for now.

The following changes since commit 9db6ffc76676731a25a5538ab71e8ca6ac234f80:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-08-11 15:11:50 +0100)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to a808c0865b720e22ca2929ec3d362d4610fbad51:

  hw/misc/mmio_interface: Return after error_setg() to avoid crash (2017-08-14 13:06:54 +0300)

----------------------------------------------------------------
trivial patches for 2017-08-14

----------------------------------------------------------------
Cleber Rosa (3):
      qemu-iotests: get rid of _full_imgproto_details()
      qemu-iotests: remove commented out variables
      qemu-iotests: remove comment about root privileges requirement

Eduardo Otubo (1):
      unicore32: abort when entering "x 0" on the monitor

Eric Blake (1):
      libqtest: Fix typo in comments

Thomas Huth (2):
      qemu-doc: Fix "-net van" typo
      hw/misc/mmio_interface: Return after error_setg() to avoid crash

 hw/misc/mmio_interface.c     |  2 ++
 qemu-doc.texi                |  2 +-
 target/unicore32/softmmu.c   |  8 ++++----
 tests/libqtest.h             |  8 ++++----
 tests/qemu-iotests/check     | 13 +------------
 tests/qemu-iotests/common.rc |  5 -----
 6 files changed, 12 insertions(+), 26 deletions(-)
