Received: from eggs.gnu.org ([2001:4830:134:3::10]:32787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCQX1-0006P1-KF
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCQWy-00028P-HN
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:36:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCQWy-00027V-Bh
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:36:36 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  8 Nov 2017 13:36:10 +0000
Message-Id: <20171108133612.16471-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 0/2] Merge qcrypto 2017/11/8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qcrypto-2017-11-08-1

for you to fetch changes up to f1710638edb2e98008c2a733ffda63ef32b50411:

  crypto: afalg: fix a NULL pointer dereference (2017-11-08 11:05:09 +0000)

----------------------------------------------------------------
Merge qcrypto 2017/11/08 v1

----------------------------------------------------------------
Longpeng (1):
  crypto: afalg: fix a NULL pointer dereference

Thomas Huth (1):
  tests: Run the luks tests in test-crypto-block only if encryption is
    available

 crypto/cipher.c           |  5 +----
 crypto/hash.c             | 13 +++++--------
 crypto/hmac.c             |  4 +---
 tests/test-crypto-block.c |  3 ++-
 4 files changed, 9 insertions(+), 16 deletions(-)

-- 
2.13.6
