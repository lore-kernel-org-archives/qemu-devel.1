Received: from eggs.gnu.org ([2001:4830:134:3::10]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEXrV-0002IZ-GL
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEXrS-0004qb-BK
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:46:01 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:29442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEXrR-0004pw-Rl
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:45:58 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Wed, 7 Dec 2016 16:33:40 +0800
Message-ID: <1481099622-188132-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 0/2] crypto: add 3des-ede support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, wu.wubin@huawei.com, jianjay.zhou@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

This patchset add 3DES-EDE support when using gcrypt/nettle.

Due to the virtio-crypto has been supportted, the guest can use
various cipher-algo including 3DES-EDE.

Longpeng(Mike) (2):
  crypto: add 3des-ede support when using libgcrypt/nettle
  cryptodev: add 3des-ede support

 backends/cryptodev-builtin.c | 12 ++++++++++++
 crypto/cipher-gcrypt.c       |  6 ++++++
 crypto/cipher-nettle.c       | 37 +++++++++++++++++++++++++++++++++++++
 crypto/cipher.c              |  7 +++++--
 qapi/crypto.json             |  3 ++-
 tests/test-crypto-cipher.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 106 insertions(+), 3 deletions(-)

-- 
1.8.3.1
