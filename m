Received: from eggs.gnu.org ([2001:4830:134:3::10]:33418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fgJY9-0007Q0-Tr
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 20:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fgJY6-0003cj-Sa
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 20:45:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fgJY6-0003cI-O6
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 20:45:34 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Jul 2018 08:45:27 +0800
Message-Id: <1532047529-17961-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit 9f2b67e1ca43c84ed37ebd027e7e77a0f2f8ef65:

  Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-pull-20180719' into staging (2018-07-19 17:21:43 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 323e7c117754e4d4ce6b4282d74ad01c99d67714:

  tap: fix memory leak on success to create a tap device (2018-07-20 08:30:49 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Jan Kiszka (1):
      e1000e: Prevent MSI/MSI-X storms

Yunjian Wang (1):
      tap: fix memory leak on success to create a tap device

 hw/net/e1000e_core.c | 11 +++++++++++
 hw/net/e1000e_core.h |  2 ++
 net/tap.c            | 16 ++++++++++------
 3 files changed, 23 insertions(+), 6 deletions(-)
