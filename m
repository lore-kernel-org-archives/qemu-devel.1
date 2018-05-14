Received: from eggs.gnu.org ([2001:4830:134:3::10]:57822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fI8L3-0007hd-4n
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fI8Kz-0004KG-V6
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:56:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fI8Kz-0004K4-QY
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:56:05 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 May 2018 15:55:56 +0800
Message-Id: <1526284560-20266-1-git-send-email-jasowang@redhat.com>
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

The following changes since commit c74e62ee3e2dc2955e07d004c71badecb68a84eb:

  Merge remote-tracking branch 'remotes/rth/tags/cota-target-pull-request' into staging (2018-05-11 15:41:29 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 0e0266c2e475b82b39a757c875fa03e64272fbe7:

  net: Get rid of 'vlan' terminology and use 'hub' instead in the doc files (2018-05-14 15:47:14 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Thomas Huth (4):
      net: Fix memory leak in net_param_nic()
      net: Remove the deprecated "vlan" parameter
      net: Get rid of 'vlan' terminology and use 'hub' instead in the source files
      net: Get rid of 'vlan' terminology and use 'hub' instead in the doc files

 docs/qdev-device-use.txt         |  3 --
 hw/core/qdev-properties-system.c | 80 ----------------------------------------
 include/hw/qdev-properties.h     |  3 --
 include/net/net.h                |  1 -
 net/hub.c                        |  7 ++--
 net/net.c                        | 18 ++++-----
 net/slirp.c                      |  8 ++--
 net/tap.c                        |  4 +-
 qapi/net.json                    | 15 ++++----
 qemu-doc.texi                    | 51 ++++++++++++-------------
 qemu-options.hx                  | 29 ++++++---------
 11 files changed, 58 insertions(+), 161 deletions(-)
