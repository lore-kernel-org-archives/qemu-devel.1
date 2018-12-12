Received: from eggs.gnu.org ([2001:4830:134:3::10]:37254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2dR-0002my-4S
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2dQ-00046b-AD
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:25:01 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 12 Dec 2018 11:24:45 +0000
Message-Id: <20181212112450.2103-2-berrange@redhat.com>
In-Reply-To: <20181212112450.2103-1-berrange@redhat.com>
References: <20181212112450.2103-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/6] crypto: Fix defaults in
 QCryptoBlockCreateOptionsLUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>

From: Alberto Garcia <berto@igalia.com>

The values specified in the documentation don't match the actual
defaults set in qcrypto_block_luks_create().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qapi/crypto.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index a51b434412..b2a4cff683 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -181,11 +181,11 @@
 # The options that apply to LUKS encryption format initialization
 #
 # @cipher-alg: the cipher algorithm for data encryption
-#              Currently defaults to 'aes'.
+#              Currently defaults to 'aes-256'.
 # @cipher-mode: the cipher mode for data encryption
-#               Currently defaults to 'cbc'
+#               Currently defaults to 'xts'
 # @ivgen-alg: the initialization vector generator
-#             Currently defaults to 'essiv'
+#             Currently defaults to 'plain64'
 # @ivgen-hash-alg: the initialization vector generator hash
 #                  Currently defaults to 'sha256'
 # @hash-alg: the master key hash algorithm
--=20
2.19.2
