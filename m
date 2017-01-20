Received: from eggs.gnu.org ([2001:4830:134:3::10]:39507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUPYW-0000Qs-8s
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUPYT-0002mZ-4N
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cUPYS-0002ll-U7
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:07:57 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Jan 2017 11:07:44 +0800
Message-Id: <1484881670-24237-1-git-send-email-jasowang@redhat.com>
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
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit 0f6bcf68a99efdc531b209551f2b760b0bdcc5=
54:

  Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170118' =
into staging (2017-01-19 18:34:13 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to fac7d7b1cdb21f921d7ac396365f5e920ef03096:

  tap: fix memory leak on failure in net_init_tap() (2017-01-20 10:58:26 =
+0800)

----------------------------------------------------------------

----------------------------------------------------------------
Alex Kompel (1):
      hw/pci: use-after-free in pci_nic_init_nofail when nic device fails=
 to initialize

Ladi Prosek (1):
      net: optimize checksum computation

Peter Maydell (2):
      hw/net/dp8393x: Avoid unintentional sign extensions on addresses
      tap: fix memory leak on failure in net_init_tap()

Thomas Huth (1):
      m68k: QOMify the MCF Fast Ethernet Controller device

Zhang Chen (1):
      docs: Fix description of the sentence

 docs/colo-proxy.txt       |  4 +-
 hw/m68k/mcf5208.c         | 25 ++++++++++++-
 hw/net/dp8393x.c          | 95 +++++++++++++++++++++++++++++++++--------=
------
 hw/net/mcf_fec.c          | 71 ++++++++++++++++++++++++++---------
 hw/pci/pci.c              |  9 +----
 include/hw/m68k/mcf.h     |  4 --
 include/hw/m68k/mcf_fec.h | 13 +++++++
 net/checksum.c            | 21 +++++++----
 net/tap.c                 |  7 +++-
 9 files changed, 180 insertions(+), 69 deletions(-)
 create mode 100644 include/hw/m68k/mcf_fec.h
