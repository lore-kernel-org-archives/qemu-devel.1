Received: from eggs.gnu.org ([2001:4830:134:3::10]:37262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fJbX9-0006pY-9L
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fJbX6-0003zH-3o
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:18:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fJbX5-0003z5-W6
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:18:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 18 May 2018 17:18:26 +0800
Message-Id: <20180518091828.12814-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit a4207e3b00e89f934adb231057dcf9a75ac2ae=
45:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2018-05-17 11:59:50 +0100)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/docker-and-block-pull-request

for you to fetch changes up to cd0a6d2b2c3d5cbf82a868d8c6c80961bcda6db5:

  iothread: fix epollfd leak in the process of delIOThread (2018-05-18 17=
:09:54 +0800)

----------------------------------------------------------------
Docker and block patches

Two fairly small fixes.

----------------------------------------------------------------

Jie Wang (1):
  iothread: fix epollfd leak in the process of delIOThread

Philippe Mathieu-Daud=C3=A9 (1):
  docker: Fix trivial typo

 include/block/aio.h           |  8 ++++++++
 tests/docker/Makefile.include |  2 +-
 util/aio-posix.c              | 13 ++++++++++---
 util/aio-win32.c              |  4 ++++
 util/async.c                  |  1 +
 5 files changed, 24 insertions(+), 4 deletions(-)

--=20
2.14.3
