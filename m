Received: from eggs.gnu.org ([2001:4830:134:3::10]:45941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1esgY0-0006p9-C2
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1esgXv-0005IU-TL
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1esgXv-0005HL-Oh
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:15 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  5 Mar 2018 11:11:55 +0800
Message-Id: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 0/9] Net patches
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

The following changes since commit 136c67e07869227b21b3f627316e03679ce7b738:

  Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2018-03-02' into staging (2018-03-02 16:56:20 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 46d4d36d0bf2b24b205f2f604f0905db80264eef:

  tap: setting error appropriately when calling net_init_tap_one() (2018-03-05 10:30:16 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Jay Zhou (1):
      tap: setting error appropriately when calling net_init_tap_one()

Thomas Huth (8):
      net: Move error reporting from net_init_client/netdev to the calling site
      net: List available netdevs with "-netdev help"
      net: Only show vhost-user in the help text if CONFIG_POSIX is defined
      net: Make net_client_init() static
      net: Remove the deprecated way of dumping network packets
      net: Remove the deprecated 'host_net_add' and 'host_net_remove' HMP commands
      net: Add a new convenience option "--nic" to configure default/on-board NICs
      hw/net: Remove unnecessary header includes

 hmp-commands.hx         |  30 ------
 hmp.h                   |   3 -
 hw/net/e1000.c          |   1 -
 hw/net/lance.c          |   3 -
 hw/net/ne2000.c         |   2 -
 hw/net/pcnet-pci.c      |   1 -
 hw/net/pcnet.c          |   1 -
 hw/net/rtl8139.c        |   2 -
 hw/net/xgmac.c          |   1 -
 include/net/net.h       |   4 +-
 include/net/vhost_net.h |   3 +
 include/sysemu/sysemu.h |   1 +
 monitor.c               |  61 ------------
 net/dump.c              | 102 +--------------------
 net/net.c               | 239 +++++++++++++++++++++++-------------------------
 net/tap.c               |  22 ++++-
 qapi/net.json           |  29 ++----
 qemu-doc.texi           |  16 ----
 qemu-options.hx         |  48 +++++++---
 tests/test-hmp.c        |   2 -
 vl.c                    |  10 +-
 21 files changed, 190 insertions(+), 391 deletions(-)
