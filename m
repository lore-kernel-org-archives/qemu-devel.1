Received: from eggs.gnu.org ([2001:4830:134:3::10]:46941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cYXU5-000675-9v
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cYXU1-000583-BB
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:24:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cYXU1-00057q-5C
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:24:25 -0500
From: P J P <ppandit@redhat.com>
Date: Tue, 31 Jan 2017 17:54:14 +0530
Message-Id: <20170131122416.10284-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] sd: sdhci: correct transfer mode register
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

In SDHCI emulation, the 'Block Count Enable' bit of the Transfer Mode
register is used to control 's->blkcnt' value. One, this bit is not
relevant in single block transfers. Second, Transfer Mode register
value could be set such that 's->blkcnt' would not see an update
during multi block transfers. Thus leading to an infinite loop.

This patch set attempts to correct 'Block Count Enable' bit usage.

Thank you.
--
Prasad J Pandit (2):
  sd: sdhci: check transfer mode register in multi block transfer
  sd: sdhci: block count enable not relevant in single block transfer

 hw/sd/sdhci.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--
2.9.3
