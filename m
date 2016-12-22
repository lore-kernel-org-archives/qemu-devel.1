Received: from eggs.gnu.org ([2001:4830:134:3::10]:36569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cK0ub-0004h5-Gq
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cK0uY-00067O-Co
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cK0uY-00067C-6e
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:46 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 22 Dec 2016 10:47:32 +0000
Message-Id: <20161222104740.19606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/8] Merge qcrypto 2016-12-21
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

The following changes since commit 82ecffa8c050bf5bbc13329e9b65eac1caa5b5=
5c:

  Open 2.9 development tree (2016-12-20 16:20:16 +0000)

are available in the git repository at:

  git://github.com/berrange/qemu pull-qcrypto-2016-12-21-2

for you to fetch changes up to 4fd460bf25b197f94b9db463b77a69433901ac92:

  crypto: add HMAC algorithms testcases (2016-12-22 09:24:59 +0000)

----------------------------------------------------------------
Merge qcrypto 2016/12/21 v2

----------------------------------------------------------------

Longpeng(Mike) (7):
  crypto: add 3des-ede support when using libgcrypt/nettle
  configure: add CONFIG_GCRYPT_HMAC item
  crypto: add HMAC algorithms framework
  crypto: support HMAC algorithms based on libgcrypt
  crypto: support HMAC algorithms based on glib
  crypto: support HMAC algorithms based on nettle
  crypto: add HMAC algorithms testcases

Marc-Andr=C3=A9 Lureau (1):
  cipher: fix leak on initialization error

 configure                  |  17 +++
 crypto/Makefile.objs       |   4 +
 crypto/cipher-gcrypt.c     |   6 +
 crypto/cipher-nettle.c     |  42 ++++++-
 crypto/cipher.c            |   7 +-
 crypto/hmac-gcrypt.c       | 152 ++++++++++++++++++++++++++
 crypto/hmac-glib.c         | 166 ++++++++++++++++++++++++++++
 crypto/hmac-nettle.c       | 175 +++++++++++++++++++++++++++++
 crypto/hmac.c              |  72 ++++++++++++
 crypto/hmac.h              | 166 ++++++++++++++++++++++++++++
 qapi/crypto.json           |   3 +-
 tests/Makefile.include     |   2 +
 tests/test-crypto-cipher.c | 119 ++++++++++++++++++++
 tests/test-crypto-hmac.c   | 266 +++++++++++++++++++++++++++++++++++++++=
++++++
 14 files changed, 1191 insertions(+), 6 deletions(-)
 create mode 100644 crypto/hmac-gcrypt.c
 create mode 100644 crypto/hmac-glib.c
 create mode 100644 crypto/hmac-nettle.c
 create mode 100644 crypto/hmac.c
 create mode 100644 crypto/hmac.h
 create mode 100644 tests/test-crypto-hmac.c

--=20
2.9.3
