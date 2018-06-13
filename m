Received: from eggs.gnu.org ([2001:4830:134:3::10]:50763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fT10q-0002Rr-2R
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fT10m-0004Q2-CD
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:16 -0400
Received: from forwardcorp1o.cmail.yandex.net ([2a02:6b8:0:1a72::290]:49186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1fT10l-0004LQ-VI
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:12 -0400
From: Dima Stepanov <dimastep@yandex-team.ru>
Date: Wed, 13 Jun 2018 11:19:53 +0300
Message-Id: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
Subject: [Qemu-devel] [PATCH v2 0/2] misc fixes found by static analyzer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru

During the development process we used scan-build as static analyzer to
check the changes. There are some issues found. The patch set below is
to resolve issues found.

Changes v2:
 - remove one patch, since it was resolved by: 7eb24009

Dima Stepanov (2):
  memfd: fix possible usage of the uninitialized file descriptor
  memory: fix possible NULL pointer dereference

 memory.c     | 2 +-
 util/memfd.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4
