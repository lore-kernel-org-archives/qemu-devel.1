Received: from eggs.gnu.org ([2001:4830:134:3::10]:58223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGkZZ-0003Lq-9p
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGkZV-0002WJ-DH
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:44:37 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:15886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGkZR-0002Af-VO
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:44:33 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 13 Dec 2016 18:42:54 +0800
Message-ID: <1481625780-39164-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v4 0/6] crypto: add HMAC algorithms
 support
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

This patchset add HMAC algorithms support.

---
Changes since v3:
    - s/glibc/glib in patch 4. [Daniel]
    - fix build failure with glib older than 2.30.0. [build test]

Changes since v2:
    - remove QCryptoHmacAlgorithm defination in qapi, just use
      QCryptoHashAlgorithm as some funcs first para. [Daniel]
    - fix alignment of the lines wrt to the "(". [Daniel]
    - fix typos in the configure. [Daniel]
    - rename gcrypy_support_hmac to gcrypy_hmac. [Daniel]
    - use CONFIG_GCRYPT_HMAC in crypto/Makefile.objs to
      decide whether compiled gcrypt-backed impls. [Daniel]
    - implement all 7 hash algorithms. [Daniel]
    - cover all 7 hash algorithms in testcase. [Daniel]
    - cover qcrypto_hmac_bytesv and qcrypto_hmac_digest. [Daniel]
    - rewrite testcase based on test-crypto-hash. [Daniel]

Changes since v1:
    - check whether algorithm is supported in testcase [build test]

---
Longpeng(Mike) (6):
  configure: add CONFIG_GCRYPT_HMAC item
  crypto: add HMAC algorithms framework
  crypto: support HMAC algorithms based on libgcrypt
  crypto: support HMAC algorithms based on glib
  crypto: support HMAC algorithms based on nettle
  crypto: add HMAC algorithms testcases

 configure                |  17 +++
 crypto/Makefile.objs     |   4 +
 crypto/hmac-gcrypt.c     | 152 +++++++++++++++++++++++++++
 crypto/hmac-glib.c       | 166 +++++++++++++++++++++++++++++
 crypto/hmac-nettle.c     | 175 +++++++++++++++++++++++++++++++
 crypto/hmac.c            |  72 +++++++++++++
 crypto/hmac.h            | 166 +++++++++++++++++++++++++++++
 tests/Makefile.include   |   2 +
 tests/test-crypto-hmac.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1020 insertions(+)
 create mode 100644 crypto/hmac-gcrypt.c
 create mode 100644 crypto/hmac-glib.c
 create mode 100644 crypto/hmac-nettle.c
 create mode 100644 crypto/hmac.c
 create mode 100644 crypto/hmac.h
 create mode 100644 tests/test-crypto-hmac.c

-- 
1.8.3.1
