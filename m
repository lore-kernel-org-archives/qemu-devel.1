Received: from eggs.gnu.org ([2001:4830:134:3::10]:52522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ga1RB-0000E5-JG
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ga1R8-0004At-C6
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:44:41 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 20 Dec 2018 17:44:31 +0100
Message-Id: <20181220164433.21705-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Final s390x patches for 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit b72566a4ffaddbc0c0c1f6f5ee91b42ab13ff429:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2018-12-19 15:31:02 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20181220

for you to fetch changes up to aba7a5a2de3dba5917024df25441f715b9249e31:

  hw/s390x: Fix bad mask in time2tod() (2018-12-20 17:07:24 +0100)

----------------------------------------------------------------
Two s390x bugfixes.

----------------------------------------------------------------

Peter Maydell (1):
  hw/s390/ccw.c: Don't take address of packed members

Thomas Huth (1):
  hw/s390x: Fix bad mask in time2tod()

 hw/s390x/css.c         | 32 ++++++++++++++++++++++++++------
 include/hw/s390x/tod.h |  2 +-
 2 files changed, 27 insertions(+), 7 deletions(-)

-- 
2.17.2
