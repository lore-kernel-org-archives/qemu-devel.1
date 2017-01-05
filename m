Received: from eggs.gnu.org ([2001:4830:134:3::10]:60057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOwGE-00024r-HO
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 19:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOwGB-0008Lx-5P
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 19:50:30 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:47658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOwGA-0008Fp-Ht
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 19:50:27 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Thu, 5 Jan 2017 08:49:35 +0800
Message-ID: <1483577381-38088-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND 0/6] crypto:add AEAD algorithms support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

Since QEMU has been supported cryptodev, so it is necessary to support
more crypto algorithms(i.e. hmac,aead) in QEMU backend.

We have already added HMAC support, and this patchset adds AEAD algos
support.
---

Hi Daniel,

Would you please review this patchset? AEAD is also an important algorithm,
and it will be used by the virtio-crypto in the near future.

---
Longpeng(Mike) (6):
  configure: add CONFIG_GCRYPT/NETTLE_AEAD item
  crypto: add AEAD algorithms framework
  crypto: implement nettle-backed AEAD algorithms
  crypto: implement gcrypt-backed AEAD algorithms
  crypto: implement other common funcs for AEAD algorithms
  crypto: add AEAD algorithms testcases

 configure                |  36 +++++
 crypto/Makefile.objs     |   3 +
 crypto/aead-gcrypt.c     | 231 ++++++++++++++++++++++++++++++
 crypto/aead-nettle.c     | 232 ++++++++++++++++++++++++++++++
 crypto/aead.c            | 124 ++++++++++++++++
 crypto/aead.h            | 180 ++++++++++++++++++++++++
 qapi/crypto.json         |   4 +-
 tests/Makefile.include   |   2 +
 tests/test-crypto-aead.c | 357 +++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1168 insertions(+), 1 deletion(-)
 create mode 100644 crypto/aead-gcrypt.c
 create mode 100644 crypto/aead-nettle.c
 create mode 100644 crypto/aead.c
 create mode 100644 crypto/aead.h
 create mode 100644 tests/test-crypto-aead.c

-- 
1.8.3.1
