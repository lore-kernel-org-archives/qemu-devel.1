Received: from eggs.gnu.org ([2001:4830:134:3::10]:37256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2dR-0002mz-7N
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2dQ-00046g-Bl
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:25:01 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 12 Dec 2018 11:24:44 +0000
Message-Id: <20181212112450.2103-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Qcrypto next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af4220=
86:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-12-11 19:18:58 +0000)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qcrypto-next-pull-request

for you to fetch changes up to c972fa123c73501b4b0c6de7873754ea3205a5eb:

  crypto: support multiple threads accessing one QCryptoBlock (2018-12-12=
 11:16:49 +0000)

----------------------------------------------------------------
Merge crypto patches 2018/12/12

 - Fix documentation about default LUKS algorithms
 - Support for multi-threaded block crypto

----------------------------------------------------------------

Alberto Garcia (1):
  crypto: Fix defaults in QCryptoBlockCreateOptionsLUKS

Vladimir Sementsov-Ogievskiy (5):
  crypto/block-luks: fix memory leak in qcrypto_block_luks_create
  crypto/block: refactor qcrypto_block_*crypt_helper functions
  crypto/block: rename qcrypto_block_*crypt_helper
  crypto/block: introduce qcrypto_block_*crypt_helper functions
  crypto: support multiple threads accessing one QCryptoBlock

 block/crypto.c            |   1 +
 block/qcow.c              |   2 +-
 block/qcow2.c             |   4 +-
 crypto/block-luks.c       |  57 +++++-----
 crypto/block-qcow.c       |  26 ++---
 crypto/block.c            | 225 +++++++++++++++++++++++++++++---------
 crypto/blockpriv.h        |  42 +++++--
 include/crypto/block.h    |   2 +
 qapi/crypto.json          |   6 +-
 tests/test-crypto-block.c |   3 +
 10 files changed, 260 insertions(+), 108 deletions(-)

--=20
2.19.2
