Received: from eggs.gnu.org ([2001:4830:134:3::10]:37209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnhPk-00045a-7v
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnhPh-0006k9-6A
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnhPg-0006ig-W7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:02:37 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2017 16:02:27 +0800
Message-Id: <1489478550-19431-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Net patches
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

The following changes since commit 5bac3c39c82e149515c10643acafd1d292433775:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-03-13 15:08:01 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to adb560f7fc92903f52071086a46422be1e3f4640:

  hw/net: implement MIB counters in mcf_fec driver (2017-03-14 15:39:55 +0800)

----------------------------------------------------------------
- fix e100e memory regions leaks during cleanup
- fix fec MIB counters
- fix COLO trace print
----------------------------------------------------------------
Greg Ungerer (1):
      hw/net: implement MIB counters in mcf_fec driver

Paolo Bonzini (1):
      e1000e: correctly tear down MSI-X memory regions

Zhang Chen (1):
      COLO-compare: Fix trace_event print bug

 hw/net/e1000e.c    |   2 +-
 hw/net/mcf_fec.c   | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/colo-compare.c |  33 +++++++++++----
 3 files changed, 141 insertions(+), 9 deletions(-)
