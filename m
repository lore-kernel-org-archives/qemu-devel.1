Received: from eggs.gnu.org ([2001:4830:134:3::10]:45743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFNb1-0003yN-Nc
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 14:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFNXZ-0007OW-8Z
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 14:06:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gFNXV-0007KW-CF
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 14:05:54 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 24 Oct 2018 19:05:39 +0100
Message-Id: <20181024180547.20429-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Qcrypto next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit c96292036a17857d62b8b5d3c8752bac3d6b71=
93:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-oct-201=
8-part-2-v2' into staging (2018-10-24 16:31:40 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qcrypto-next-pull-request

for you to fetch changes up to 1e0fa32c6c952d2ce9c19d35717c609804dd55d5:

  crypto: add testing for unaligned buffers with XTS cipher mode (2018-10=
-24 19:03:37 +0100)

----------------------------------------------------------------
Improve performance of XTS cipher mode impl

The XTS cipher mode performance is approximately doubled and test
coverage is improved.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (8):
  crypto: expand algorithm coverage for cipher benchmark
  crypto: remove code duplication in tweak encrypt/decrypt
  crypto: introduce a xts_uint128 data type
  crypto: convert xts_tweak_encdec to use xts_uint128 type
  crypto: convert xts_mult_x to use xts_uint128 type
  crypto: annotate xts_tweak_encdec as inlineable
  crypto: refactor XTS cipher mode test suite
  crypto: add testing for unaligned buffers with XTS cipher mode

 crypto/xts.c                    | 200 +++++++++++++++-------------
 tests/benchmark-crypto-cipher.c | 149 +++++++++++++++++----
 tests/test-crypto-xts.c         | 226 +++++++++++++++++++++++---------
 3 files changed, 402 insertions(+), 173 deletions(-)

--=20
2.17.2
