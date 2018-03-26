Received: from eggs.gnu.org ([2001:4830:134:3::10]:42808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f0M7c-0002HY-DP
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f0M7Z-0000ss-D5
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:00:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f0M7Z-0000si-8X
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:00:45 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Mar 2018 15:00:27 +0800
Message-Id: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit 7b1db0908d88f0c9cfac24e214ff72a860692e23:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180323' into staging (2018-03-25 13:51:33 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 7587855cd23755a7a6bd01b026611465f5584ecd:

  net/vde: print error on vde_open() failure (2018-03-26 14:52:43 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Greg Kurz (1):
      virtio_net: flush uncompleted TX on reset

Julia Suvorova via Qemu-devel (1):
      net/vde: print error on vde_open() failure

 hw/net/virtio-net.c | 11 +++++++++++
 include/net/net.h   |  1 +
 net/net.c           |  1 -
 net/vde.c           |  7 ++++---
 4 files changed, 16 insertions(+), 4 deletions(-)
