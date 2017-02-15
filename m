Received: from eggs.gnu.org ([2001:4830:134:3::10]:48782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdqeq-000271-Rh
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdqem-0008N8-70
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cdqem-0008Mu-16
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:28 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Feb 2017 11:53:17 +0800
Message-Id: <1487130802-27953-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

The following changes since commit 5dae13cd71f0755a1395b5a4cde635b8a6ee3f58:

  Merge remote-tracking branch 'remotes/rth/tags/pull-or-20170214' into staging (2017-02-14 09:55:48 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 4154c7e03fa55b4cf52509a83d50d6c09d743b77:

  net: e1000e: fix an infinite loop issue (2017-02-15 11:18:57 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Li Qiang (1):
      net: e1000e: fix an infinite loop issue

Paolo Bonzini (1):
      net: e1000e: fix dead code in e1000e_write_packet_to_guest

Prasad J Pandit (1):
      net: imx: limit buffer descriptor count

Thomas Huth (1):
      net: Mark 'vlan' parameter as deprecated

Zhang Chen (1):
      colo-compare: sort TCP packet queue by sequence number

 hw/net/e1000e_core.c |  9 +++++++--
 hw/net/imx_fec.c     | 10 ++++++----
 net/colo-compare.c   | 19 +++++++++++++++++++
 net/net.c            |  6 ++++++
 4 files changed, 38 insertions(+), 6 deletions(-)
