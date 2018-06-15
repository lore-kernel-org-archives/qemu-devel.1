Received: from eggs.gnu.org ([2001:4830:134:3::10]:43079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTezX-0000Ws-BT
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTezS-0002Ir-W9
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36736 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fTezS-0002Hr-RD
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:30 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Jun 2018 11:01:19 +0800
Message-Id: <1529031683-27458-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Net patches
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

The following changes since commit 409c241f887a38bb7a2ac12e34d3a8d73922a9a5:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180614-pull-request' into staging (2018-06-14 14:04:14 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to c67daf4a24442d1bb404a11a6a54dc45ea10f234:

  vhost-user: delete net client if necessary (2018-06-15 10:39:53 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Brijesh Singh (1):
      tap: set vhostfd passed from qemu cli to non-blocking

Jan Kiszka (1):
      e1000e: Do not auto-clear ICR bits which aren't set in EIAC

Lin Ma (1):
      net: Fix a potential segfault

linzhecheng (1):
      vhost-user: delete net client if necessary

 hw/net/e1000e_core.c | 4 ----
 net/net.c            | 4 +++-
 net/tap.c            | 2 ++
 net/vhost-user.c     | 3 +++
 4 files changed, 8 insertions(+), 5 deletions(-)
