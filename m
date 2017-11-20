Received: from eggs.gnu.org ([2001:4830:134:3::10]:39394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eGco6-00074t-3u
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eGco1-0000pK-Ni
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eGco1-0000mc-H6
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:33 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Nov 2017 11:31:21 +0800
Message-Id: <1511148687-24909-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Net patches
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

The following changes since commit 2e02083438962d26ef9dcc7100f3b378104183=
db:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2017-11-17 19:08:07 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to c527e0afcd7d719abc3a5ca5e4c8ac2fe48b999f:

  hw/net/vmxnet3: Fix code to work on big endian hosts, too (2017-11-20 1=
1:08:00 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Ed Swierk (1):
      net: Transmit zero UDP checksum as 0xFFFF

Jason Wang (1):
      Revert "Add new PCI ID for i82559a"

Mao Zhongyi (1):
      colo-compare: fix the dangerous assignment

Stefan Weil (1):
      MAINTAINERS: Add missing entry for eepro100 emulation

Thomas Huth (2):
      hw/net/eepro100: Fix endianness problem on big endian hosts
      hw/net/vmxnet3: Fix code to work on big endian hosts, too

 MAINTAINERS            |   5 ++
 hw/net/e1000.c         |   2 +-
 hw/net/eepro100.c      |  17 +---
 hw/net/net_rx_pkt.c    |   2 +-
 hw/net/net_tx_pkt.c    |   2 +-
 hw/net/vmware_utils.h  |   6 ++
 hw/net/vmxnet3.c       |  49 ++++++++---
 hw/net/vmxnet3.h       | 230 ++++++++++++++++++++++++++++++-------------=
------
 include/hw/compat.h    |   4 -
 include/hw/pci/pci.h   |   1 -
 include/net/checksum.h |   6 ++
 net/colo-compare.c     |   2 +-
 qemu-options.hx        |   2 +-
 13 files changed, 201 insertions(+), 127 deletions(-)
