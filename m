Received: from eggs.gnu.org ([2001:4830:134:3::10]:38624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtH-000296-La
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtG-0007Bm-6C
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtF-0007BE-WC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:58 -0400
Date: Fri, 1 Jun 2018 19:26:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-11-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/31] crypto: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>

When pulling in headers that are in the same directory as the C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.h    | 2 +-
 crypto/block-qcow.h    | 2 +-
 crypto/ivgen-essiv.h   | 2 +-
 crypto/ivgen-plain.h   | 2 +-
 crypto/ivgen-plain64.h | 2 +-
 crypto/block-luks.c    | 2 +-
 crypto/block-qcow.c    | 2 +-
 crypto/block.c         | 6 +++---
 crypto/cipher.c        | 6 +++---
 crypto/ivgen-essiv.c   | 2 +-
 crypto/ivgen-plain.c   | 2 +-
 crypto/ivgen-plain64.c | 2 +-
 crypto/ivgen.c         | 8 ++++----
 crypto/tlscreds.c      | 2 +-
 crypto/tlscredsanon.c  | 2 +-
 crypto/tlscredsx509.c  | 2 +-
 16 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/crypto/block-luks.h b/crypto/block-luks.h
index b2d8a35c1b..befd8b2c56 100644
--- a/crypto/block-luks.h
+++ b/crypto/block-luks.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_BLOCK_LUKS_H
 #define QCRYPTO_BLOCK_LUKS_H
=20
-#include "crypto/blockpriv.h"
+#include "blockpriv.h"
=20
 extern const QCryptoBlockDriver qcrypto_block_driver_luks;
=20
diff --git a/crypto/block-qcow.h b/crypto/block-qcow.h
index 3e2c0a851a..6988fb210b 100644
--- a/crypto/block-qcow.h
+++ b/crypto/block-qcow.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_BLOCK_QCOW_H
 #define QCRYPTO_BLOCK_QCOW_H
=20
-#include "crypto/blockpriv.h"
+#include "blockpriv.h"
=20
 extern const QCryptoBlockDriver qcrypto_block_driver_qcow;
=20
diff --git a/crypto/ivgen-essiv.h b/crypto/ivgen-essiv.h
index 4a00af849a..f34dbab57b 100644
--- a/crypto/ivgen-essiv.h
+++ b/crypto/ivgen-essiv.h
@@ -18,7 +18,7 @@
  *
  */
=20
-#include "crypto/ivgenpriv.h"
+#include "ivgenpriv.h"
=20
 #ifndef QCRYPTO_IVGEN_ESSIV_H__
 #define QCRYPTO_IVGEN_ESSIV_H__
diff --git a/crypto/ivgen-plain.h b/crypto/ivgen-plain.h
index 0fe8835c3e..16e1ae5b27 100644
--- a/crypto/ivgen-plain.h
+++ b/crypto/ivgen-plain.h
@@ -18,7 +18,7 @@
  *
  */
=20
-#include "crypto/ivgenpriv.h"
+#include "ivgenpriv.h"
=20
 #ifndef QCRYPTO_IVGEN_PLAIN_H__
 #define QCRYPTO_IVGEN_PLAIN_H__
diff --git a/crypto/ivgen-plain64.h b/crypto/ivgen-plain64.h
index c4104459b5..f8611bd705 100644
--- a/crypto/ivgen-plain64.h
+++ b/crypto/ivgen-plain64.h
@@ -18,7 +18,7 @@
  *
  */
=20
-#include "crypto/ivgenpriv.h"
+#include "ivgenpriv.h"
=20
 #ifndef QCRYPTO_IVGEN_PLAIN64_H__
 #define QCRYPTO_IVGEN_PLAIN64_H__
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index d418ac30b8..5738124773 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/bswap.h"
=20
-#include "crypto/block-luks.h"
+#include "block-luks.h"
=20
 #include "crypto/hash.h"
 #include "crypto/afsplit.h"
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 8817d6aaa7..4284e05167 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
=20
-#include "crypto/block-qcow.h"
+#include "block-qcow.h"
 #include "crypto/secret.h"
=20
 #define QCRYPTO_BLOCK_QCOW_SECTOR_SIZE 512
diff --git a/crypto/block.c b/crypto/block.c
index f206d5eea8..e59d1140fe 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -20,9 +20,9 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "crypto/blockpriv.h"
-#include "crypto/block-qcow.h"
-#include "crypto/block-luks.h"
+#include "blockpriv.h"
+#include "block-qcow.h"
+#include "block-luks.h"
=20
 static const QCryptoBlockDriver *qcrypto_block_drivers[] =3D {
     [Q_CRYPTO_BLOCK_FORMAT_QCOW] =3D &qcrypto_block_driver_qcow,
diff --git a/crypto/cipher.c b/crypto/cipher.c
index bcbfb3d5b8..b3af57961b 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -150,11 +150,11 @@ qcrypto_cipher_munge_des_rfb_key(const uint8_t *key=
,
 #endif /* CONFIG_GCRYPT || CONFIG_NETTLE */
=20
 #ifdef CONFIG_GCRYPT
-#include "crypto/cipher-gcrypt.c"
+#include "cipher-gcrypt.c"
 #elif defined CONFIG_NETTLE
-#include "crypto/cipher-nettle.c"
+#include "cipher-nettle.c"
 #else
-#include "crypto/cipher-builtin.c"
+#include "cipher-builtin.c"
 #endif
=20
 QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
index aeaa8fcd5b..43e258c6f7 100644
--- a/crypto/ivgen-essiv.c
+++ b/crypto/ivgen-essiv.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
-#include "crypto/ivgen-essiv.h"
+#include "ivgen-essiv.h"
=20
 typedef struct QCryptoIVGenESSIV QCryptoIVGenESSIV;
 struct QCryptoIVGenESSIV {
diff --git a/crypto/ivgen-plain.c b/crypto/ivgen-plain.c
index bf2fb7aac4..06f4145fe5 100644
--- a/crypto/ivgen-plain.c
+++ b/crypto/ivgen-plain.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
-#include "crypto/ivgen-plain.h"
+#include "ivgen-plain.h"
=20
 static int qcrypto_ivgen_plain_init(QCryptoIVGen *ivgen,
                                     const uint8_t *key, size_t nkey,
diff --git a/crypto/ivgen-plain64.c b/crypto/ivgen-plain64.c
index e4679a1e6e..fbb7724b20 100644
--- a/crypto/ivgen-plain64.c
+++ b/crypto/ivgen-plain64.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
-#include "crypto/ivgen-plain.h"
+#include "ivgen-plain.h"
=20
 static int qcrypto_ivgen_plain_init(QCryptoIVGen *ivgen,
                                     const uint8_t *key, size_t nkey,
diff --git a/crypto/ivgen.c b/crypto/ivgen.c
index f66435112b..6a2b3ad01e 100644
--- a/crypto/ivgen.c
+++ b/crypto/ivgen.c
@@ -21,10 +21,10 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
=20
-#include "crypto/ivgenpriv.h"
-#include "crypto/ivgen-plain.h"
-#include "crypto/ivgen-plain64.h"
-#include "crypto/ivgen-essiv.h"
+#include "ivgenpriv.h"
+#include "ivgen-plain.h"
+#include "ivgen-plain64.h"
+#include "ivgen-essiv.h"
=20
=20
 QCryptoIVGen *qcrypto_ivgen_new(QCryptoIVGenAlgorithm alg,
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 3cd41035bb..02255a6f3c 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "crypto/tlscredspriv.h"
+#include "tlscredspriv.h"
 #include "trace.h"
=20
 #define DH_BITS 2048
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 1464220080..7ad66d1e7d 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "crypto/tlscredsanon.h"
-#include "crypto/tlscredspriv.h"
+#include "tlscredspriv.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 50eb54f6bb..98ee0424e5 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "crypto/tlscredsx509.h"
-#include "crypto/tlscredspriv.h"
+#include "tlscredspriv.h"
 #include "crypto/secret.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
--=20
MST
