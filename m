Received: from eggs.gnu.org ([209.51.188.92]:37814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmcG0-0001WX-TL
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmcG0-0000GA-6o
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:29:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 24 Jan 2019 10:28:57 +0000
Message-Id: <20190124102900.20079-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>

The following changes since commit f6b06fcceef465de0cf2514c9f76fe01928967=
81:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190121-pull-requ=
est' into staging (2019-01-23 17:57:47 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 8595685986152334b1ec28c78cb0e5e855d56b54:

  qemu-coroutine-sleep: drop CoSleepCB (2019-01-24 10:05:16 +0000)

----------------------------------------------------------------
Pull request

Changelog: No user-visible changes.

----------------------------------------------------------------

Stefan Hajnoczi (2):
  throttle-groups: fix restart coroutine iothread race
  iotests: add 238 for throttling tgm unregister iothread segfault

Vladimir Sementsov-Ogievskiy (1):
  qemu-coroutine-sleep: drop CoSleepCB

 include/block/throttle-groups.h |  5 ++++
 block/throttle-groups.c         |  9 +++++++
 util/qemu-coroutine-sleep.c     | 27 +++++++------------
 tests/qemu-iotests/238          | 47 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/238.out      |  6 +++++
 tests/qemu-iotests/group        |  1 +
 6 files changed, 78 insertions(+), 17 deletions(-)
 create mode 100755 tests/qemu-iotests/238
 create mode 100644 tests/qemu-iotests/238.out

--=20
2.20.1
