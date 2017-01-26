Received: from eggs.gnu.org ([2001:4830:134:3::10]:56332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWa6s-0001B0-5x
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 21:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWa6p-00072i-3Z
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 21:48:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWa6o-00072V-UZ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 21:48:23 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 26 Jan 2017 10:48:13 +0800
Message-Id: <20170126024815.22841-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] HBitmap patches
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

The following changes since commit c7f1cf01b8245762ca5864e835d84f6677ae8b1f:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-01-25 17:54:14 +0000)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/for-upstream

for you to fetch changes up to 7cdc49b9a2ee127b2403f6ce98ce3f96afb41733:

  test-hbitmap: Add hbitmap_is_serializable() calls (2017-01-26 10:25:01 +0800)

----------------------------------------------------------------

Two patches by Max submitted back in 2.8 timeframe.

----------------------------------------------------------------

Max Reitz (2):
  hbitmap: Add hbitmap_is_serializable()
  test-hbitmap: Add hbitmap_is_serializable() calls

 include/qemu/hbitmap.h | 13 +++++++++++++
 tests/test-hbitmap.c   | 11 +++++++++++
 util/hbitmap.c         | 22 +++++++++++++++++++---
 3 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.9.3
