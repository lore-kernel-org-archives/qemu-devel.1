Received: from eggs.gnu.org ([2001:4830:134:3::10]:39986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPhD-0006So-Sm
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPh9-0002go-Av
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXPh9-0002fK-1H
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:35 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 18 Jul 2017 11:25:01 +0100
Message-Id: <20170718102519.15392-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 00/18] Merge crypto 201/07/18
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

The following changes since commit 6c6076662d98c068059983d411cb2a8987ba56=
70:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-07-14 12:16:09 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qcrypto-2017-07-18-1

for you to fetch changes up to 0e0fb56bcc8145d956bf527bfedc2be42bca101f:

  tests: crypto: add hmac speed benchmark support (2017-07-18 11:18:30 +0=
100)

----------------------------------------------------------------
Merge crypto 2017/07/18 v1

----------------------------------------------------------------

Longpeng(Mike) (18):
  crypto: cipher: introduce context free function
  crypto: cipher: introduce qcrypto_cipher_ctx_new for gcrypt-backend
  crypto: cipher: introduce qcrypto_cipher_ctx_new for nettle-backend
  crypto: cipher: introduce qcrypto_cipher_ctx_new for builtin-backend
  crypto: cipher: add cipher driver framework
  crypto: hash: add hash driver framework
  crypto: hmac: move crypto/hmac.h into include/crypto/
  crypto: hmac: introduce qcrypto_hmac_ctx_new for gcrypt-backend
  crypto: hmac: introduce qcrypto_hmac_ctx_new for nettle-backend
  crypto: hmac: introduce qcrypto_hmac_ctx_new for glib-backend
  crypto: hmac: add hmac driver framework
  crypto: introduce some common functions for af_alg backend
  crypto: cipher: add afalg-backend cipher support
  crypto: hash: add afalg-backend hash support
  crypto: hmac: add af_alg-backend hmac support
  tests: crypto: add cipher speed benchmark support
  tests: crypto: add hash speed benchmark support
  tests: crypto: add hmac speed benchmark support

 configure                         |  37 +++++++
 crypto/Makefile.objs              |   3 +
 crypto/afalg.c                    | 116 +++++++++++++++++++
 crypto/afalgpriv.h                |  64 +++++++++++
 crypto/cipher-afalg.c             | 226 ++++++++++++++++++++++++++++++++=
++++++
 crypto/cipher-builtin.c           | 125 ++++++++++-----------
 crypto/cipher-gcrypt.c            | 105 ++++++++++--------
 crypto/cipher-nettle.c            |  84 ++++++++------
 crypto/cipher.c                   |  80 ++++++++++++++
 crypto/cipherpriv.h               |  56 ++++++++++
 crypto/hash-afalg.c               | 214 ++++++++++++++++++++++++++++++++=
++++
 crypto/hash-gcrypt.c              |  19 +++-
 crypto/hash-glib.c                |  19 +++-
 crypto/hash-nettle.c              |  19 +++-
 crypto/hash.c                     |  30 +++++
 crypto/hashpriv.h                 |  39 +++++++
 crypto/hmac-gcrypt.c              |  42 ++++---
 crypto/hmac-glib.c                |  63 ++++++-----
 crypto/hmac-nettle.c              |  42 ++++---
 crypto/hmac.c                     |  58 ++++++++++
 crypto/hmacpriv.h                 |  48 ++++++++
 include/crypto/cipher.h           |   1 +
 {crypto =3D> include/crypto}/hmac.h |   1 +
 tests/.gitignore                  |   3 +
 tests/Makefile.include            |  13 ++-
 tests/benchmark-crypto-cipher.c   |  88 +++++++++++++++
 tests/benchmark-crypto-hash.c     |  67 +++++++++++
 tests/benchmark-crypto-hmac.c     |  82 ++++++++++++++
 28 files changed, 1499 insertions(+), 245 deletions(-)
 create mode 100644 crypto/afalg.c
 create mode 100644 crypto/afalgpriv.h
 create mode 100644 crypto/cipher-afalg.c
 create mode 100644 crypto/cipherpriv.h
 create mode 100644 crypto/hash-afalg.c
 create mode 100644 crypto/hashpriv.h
 create mode 100644 crypto/hmacpriv.h
 rename {crypto =3D> include/crypto}/hmac.h (99%)
 create mode 100644 tests/benchmark-crypto-cipher.c
 create mode 100644 tests/benchmark-crypto-hash.c
 create mode 100644 tests/benchmark-crypto-hmac.c

--=20
2.13.0
