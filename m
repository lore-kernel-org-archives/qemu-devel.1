Received: from eggs.gnu.org ([2001:4830:134:3::10]:57569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhX-0004RU-Pv
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhT-0000e7-R3
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eEQhT-0000dj-Kd
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:43 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2017 10:11:30 +0800
Message-Id: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 0/8] Net patches
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

The following changes since commit 4ffa88c99c54d2a30f79e3dbecec50b023eff1c8:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-11-08-1' into staging (2017-11-10 16:01:35 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to bb160b571fe469b03228d4502c75a18045978a74:

  net/socket: fix coverity issue (2017-11-13 18:05:12 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Jens Freimann (2):
      net: fix check for number of parameters to -netdev socket
      net/socket: fix coverity issue

Mao Zhongyi (4):
      colo-compare: Insert packet into the suitable position of packet queue directly
      colo-compare: compare the packet in a specified Connection
      colo-compare: Fix comments
      colo: Consolidate the duplicate code chunk into a routine

Mike Nawrocki (2):
      Fix eepro100 simple transmission mode
      Add new PCI ID for i82559a

 hw/net/eepro100.c    | 31 +++++++++++++-------------
 include/hw/compat.h  |  4 ++++
 include/hw/pci/pci.h |  1 +
 net/colo-compare.c   | 61 ++++++++++++++++++++++++++++++----------------------
 net/colo.c           | 18 +++++++++-------
 net/colo.h           |  1 +
 net/socket.c         |  6 +++---
 qemu-options.hx      |  2 +-
 8 files changed, 71 insertions(+), 53 deletions(-)
