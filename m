Received: from eggs.gnu.org ([2001:4830:134:3::10]:33120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2WMC-0003qm-Ux
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 01:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2WM8-00066m-Gn
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 01:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2WM8-00066A-Al
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 01:16:12 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Apr 2017 13:15:58 +0800
Message-Id: <1493010966-22976-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Net patches
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

The following changes since commit 32c7e0ab755745e961f1772e95cac381cc6876=
9d:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170=
421' into staging (2017-04-21 15:59:27 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 049f6d8237dd0b14dee02e4c22b20114c43cecff:

  COLO-compare: Optimize tcp compare trace event (2017-04-24 11:30:36 +08=
00)

----------------------------------------------------------------

----------------------------------------------------------------
C=C3=A9dric Le Goater (5):
      hw/net: add MII definitions
      net: add FTGMAC100 support
      net/ftgmac100: add a 'aspeed' property
      aspeed: add a FTGMAC100 nic
      slirp: add a fake NC-SI backend

Zhang Chen (3):
      colo-compare: Fix old packet check bug.
      COLO-compare: Optimize tcp compare for option field
      COLO-compare: Optimize tcp compare trace event

 default-configs/arm-softmmu.mak |    1 +
 hw/arm/aspeed_soc.c             |   21 +
 hw/net/Makefile.objs            |    1 +
 hw/net/ftgmac100.c              | 1016 +++++++++++++++++++++++++++++++++=
++++++
 include/hw/arm/aspeed_soc.h     |    2 +
 include/hw/net/ftgmac100.h      |   64 +++
 include/hw/net/mii.h            |   71 ++-
 include/net/eth.h               |    1 +
 net/colo-compare.c              |   69 ++-
 net/trace-events                |    3 +-
 slirp/Makefile.objs             |    2 +-
 slirp/ncsi-pkt.h                |  419 ++++++++++++++++
 slirp/ncsi.c                    |  130 +++++
 slirp/slirp.c                   |    4 +
 slirp/slirp.h                   |    3 +
 15 files changed, 1770 insertions(+), 37 deletions(-)
 create mode 100644 hw/net/ftgmac100.c
 create mode 100644 include/hw/net/ftgmac100.h
 create mode 100644 slirp/ncsi-pkt.h
 create mode 100644 slirp/ncsi.c
