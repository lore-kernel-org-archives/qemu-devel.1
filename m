Received: from eggs.gnu.org ([2001:4830:134:3::10]:48085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLfx-0006lI-Bn
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLft-0007C8-B5
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:09:33 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:35976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLfs-00071e-JM
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:09:29 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 12 Dec 2016 16:08:05 +0800
Message-ID: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v2 0/7] crypto: add HMAC algorithms
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, armbru@redhat.com, berrange@redhat.com, stefanha@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

Since QEMU has been supported cryptodev, so it is necessary to support
more crypto algorithms(i.e. hmac,aead) in QEMU backend.

This patchset add HMAC algorithms support.

---
Changes since v1:
    - check whether algorithm is supported in testcase [build test]

---
Longpeng(Mike) (7):
  qapi: crypto: add defination about HMAC algorithms
  crypto: add HMAC algorithms framework
  configure: add CONFIG_GCRYPT_SUPPORT_HMAC item
  crypto: support HMAC algorithms based on libgcrypt
  crypto: support HMAC algorithms based on glibc
  crypto: support HMAC algorithms based on nettle
  crypto: add HMAC algorithms testcases

 configure                |  18 +++++
 crypto/Makefile.objs     |   4 ++
 crypto/hmac-gcrypt.c     | 182 +++++++++++++++++++++++++++++++++++++++++++++++
 crypto/hmac-glib.c       | 163 ++++++++++++++++++++++++++++++++++++++++++
 crypto/hmac-nettle.c     | 156 ++++++++++++++++++++++++++++++++++++++++
 crypto/hmac.c            |  72 +++++++++++++++++++
 crypto/hmac.h            | 166 ++++++++++++++++++++++++++++++++++++++++++
 qapi/crypto.json         |  17 +++++
 tests/Makefile.include   |   2 +
 tests/test-crypto-hmac.c | 166 ++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 946 insertions(+)
 create mode 100644 crypto/hmac-gcrypt.c
 create mode 100644 crypto/hmac-glib.c
 create mode 100644 crypto/hmac-nettle.c
 create mode 100644 crypto/hmac.c
 create mode 100644 crypto/hmac.h
 create mode 100644 tests/test-crypto-hmac.c

-- 
1.8.3.1
