Received: from eggs.gnu.org ([2001:4830:134:3::10]:60799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbLxR-0005Yc-Lr
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbLxO-0005cm-Ji
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:42:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cbLxO-0005cM-Dp
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:42:22 -0500
From: P J P <ppandit@redhat.com>
Date: Wed,  8 Feb 2017 12:12:09 +0530
Message-Id: <20170208064212.25307-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] sd: sdhci: correct transfer mode
 register usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

In SDHCI protocol, the 'Block Count Enable' bit of the Transfer Mode
register is used to control 's->blkcnt' value. One, this bit is not
relevant in single block transfers. Second, Transfer Mode register
value could be set such that 's->blkcnt' would not see an update
during multi block transfers. Thus leading to an infinite loop.

This patch set attempts to correct 'Block Count Enable' bit usage.

This series incorporates changes suggested in patch set v1:
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg06476.html

Thank you.
--
Prasad J Pandit (3):
  sd: sdhci: check transfer mode register in multi block transfer
  sd: sdhci: conditionally invoke multi block transfer
  sd: sdhci: Remove block count enable check in single block transfers

 hw/sd/sdhci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--
2.9.3
