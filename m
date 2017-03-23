Received: from eggs.gnu.org ([2001:4830:134:3::10]:56284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqzE4-0001q1-6c
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqzE1-0003nh-2O
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:40:12 -0400
Received: from [45.249.212.187] (port=3008 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqzE0-0003bD-LJ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:40:09 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 23 Mar 2017 17:39:09 +0800
Message-ID: <1490261951-21352-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL for-2.9 0/2] cryptodev patches 20170323
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gonglei <arei.gonglei@huawei.com>

The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:

  Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)

are available in the git repository at:

  https://github.com/gongleiarei/qemu.git tags/cryptodev-next-20170323

for you to fetch changes up to b7bad50ae81efeb180609eeecdb086ebc7536ed7:

  cryptodev: fix asserting single queue (2017-03-23 17:22:01 +0800)

----------------------------------------------------------------
cryptodev fixes

----------------------------------------------------------------

Halil Pasic (1):
  cryptodev: fix asserting single queue

Longpeng(Mike) (1):
  cryptodev: setiv only when really need

 backends/cryptodev-builtin.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
1.7.12.4
