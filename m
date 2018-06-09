Received: from eggs.gnu.org ([2001:4830:134:3::10]:38920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fRYgI-0003zR-1v
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 03:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fRYgF-0002s6-0U
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 03:53:02 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:59834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1fRYgE-0002qt-JM
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 03:52:58 -0400
From: Dima Stepanov <dimastep@yandex-team.ru>
Date: Sat,  9 Jun 2018 10:52:41 +0300
Message-Id: <1528530764-21376-1-git-send-email-dimastep@yandex-team.ru>
Subject: [Qemu-devel] [PATCH v1 0/3] misc fixes found by static analyzer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru, dimastep@yandex-team.ru

During the development process we used scan-build as static analyzer to
check the changes. There are some issues found. The patch set below is
to resolve issues found.

Dima Stepanov (3):
  memfd: fix possible usage of the uninitialized file descriptor
  qcow2: fix the uninitialized bitmap_table variable
  memory: fix possible NULL pointer dereference

 block/qcow2-bitmap.c | 1 -
 memory.c             | 2 +-
 util/memfd.c         | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4
