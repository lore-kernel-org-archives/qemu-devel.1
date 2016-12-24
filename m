Received: from eggs.gnu.org ([2001:4830:134:3::10]:40631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZy-00026z-8a
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZv-0008Fe-54
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:14 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:50641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZu-0008Ez-Oc
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:11 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Sat, 24 Dec 2016 14:12:24 +0800
Message-ID: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 0/4] cryptodev patches
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

The following changes since commit a470b33259bf82ef2336bfcd5d07640562d3f63b:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2016-12-22 19:23:51 +0000)

are available in the git repository at:


  https://github.com/gongleiarei/qemu.git tags/cryptodev-next-20161224

for you to fetch changes up to 48ae36c0ad16bb757d4f6e243b8e9072fc8e8c8e:

  cryptodev: add 3des-ede support (2016-12-24 13:46:27 +0800)

----------------------------------------------------------------
- add xts mode support
- add 3DES algorithm support
- other trivial fixes

----------------------------------------------------------------
Longpeng(Mike) (4):
      cryptodev: fix the check of aes algorithm
      cryptodev: add xts(aes) support
      cryptodev: remove single-DES support in cryptodev
      cryptodev: add 3des-ede support

 backends/cryptodev-builtin.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 15 deletions(-)
-- 
1.7.12.4
