Received: from eggs.gnu.org ([2001:4830:134:3::10]:56063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFL-00027E-SD
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFG-0001tq-Jg
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFG-0001r1-5E
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:26 -0400
Date: Thu, 3 May 2018 22:50:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-3-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 02/67] crypto: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory. Directory based path works more or less by accident.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index b2d8a35..befd8b2 100644
--- a/crypto/block-luks.h
+++ b/crypto/block-luks.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_BLOCK_LUKS_H
 #define QCRYPTO_BLOCK_LUKS_H
 
-#include "crypto/blockpriv.h"
+#include "blockpriv.h"
 
 extern const QCryptoBlockDriver qcrypto_block_driver_luks;
 
diff --git a/crypto/block-qcow.h b/crypto/block-qcow.h
index 3e2c0a8..6988fb2 100644
--- a/crypto/block-qcow.h
+++ b/crypto/block-qcow.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_BLOCK_QCOW_H
 #define QCRYPTO_BLOCK_QCOW_H
 
-#include "crypto/blockpriv.h"
+#include "blockpriv.h"
 
 extern const QCryptoBlockDriver qcrypto_block_driver_qcow;
 
diff --git a/crypto/ivgen-essiv.h b/crypto/ivgen-essiv.h
index 4a00af8..f34dbab 100644
--- a/crypto/ivgen-essiv.h
+++ b/crypto/ivgen-essiv.h
@@ -18,7 +18,7 @@
  *
  */
 
-#include "crypto/ivgenpriv.h"
+#include "ivgenpriv.h"
 
 #ifndef QCRYPTO_IVGEN_ESSIV_H__
 #define QCRYPTO_IVGEN_ESSIV_H__
diff --git a/crypto/ivgen-plain.h b/crypto/ivgen-plain.h
index 0fe8835..16e1ae5 100644
--- a/crypto/ivgen-plain.h
+++ b/crypto/ivgen-plain.h
@@ -18,7 +18,7 @@
  *
  */
 
-#include "crypto/ivgenpriv.h"
+#include "ivgenpriv.h"
 
 #ifndef QCRYPTO_IVGEN_PLAIN_H__
 #define QCRYPTO_IVGEN_PLAIN_H__
diff --git a/crypto/ivgen-plain64.h b/crypto/ivgen-plain64.h
index c410445..f8611bd 100644
--- a/crypto/ivgen-plain64.h
+++ b/crypto/ivgen-plain64.h
@@ -18,7 +18,7 @@
  *
  */
 
-#include "crypto/ivgenpriv.h"
+#include "ivgenpriv.h"
 
 #ifndef QCRYPTO_IVGEN_PLAIN64_H__
 #define QCRYPTO_IVGEN_PLAIN64_H__
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index d418ac3..5738124 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/bswap.h"
 
-#include "crypto/block-luks.h"
+#include "block-luks.h"
 
 #include "crypto/hash.h"
 #include "crypto/afsplit.h"
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 8817d6a..4284e05 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 
-#include "crypto/block-qcow.h"
+#include "block-qcow.h"
 #include "crypto/secret.h"
 
 #define QCRYPTO_BLOCK_QCOW_SECTOR_SIZE 512
diff --git a/crypto/block.c b/crypto/block.c
index f206d5e..e59d114 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -20,9 +20,9 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "crypto/blockpriv.h"
-#include "crypto/block-qcow.h"
-#include "crypto/block-luks.h"
+#include "blockpriv.h"
+#include "block-qcow.h"
+#include "block-luks.h"
 
 static const QCryptoBlockDriver *qcrypto_block_drivers[] = {
     [Q_CRYPTO_BLOCK_FORMAT_QCOW] = &qcrypto_block_driver_qcow,
diff --git a/crypto/cipher.c b/crypto/cipher.c
index bcbfb3d..b3af579 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -150,11 +150,11 @@ qcrypto_cipher_munge_des_rfb_key(const uint8_t *key,
 #endif /* CONFIG_GCRYPT || CONFIG_NETTLE */
 
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
 
 QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
index aeaa8fc..43e258c 100644
--- a/crypto/ivgen-essiv.c
+++ b/crypto/ivgen-essiv.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
-#include "crypto/ivgen-essiv.h"
+#include "ivgen-essiv.h"
 
 typedef struct QCryptoIVGenESSIV QCryptoIVGenESSIV;
 struct QCryptoIVGenESSIV {
diff --git a/crypto/ivgen-plain.c b/crypto/ivgen-plain.c
index bf2fb7a..06f4145 100644
--- a/crypto/ivgen-plain.c
+++ b/crypto/ivgen-plain.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
-#include "crypto/ivgen-plain.h"
+#include "ivgen-plain.h"
 
 static int qcrypto_ivgen_plain_init(QCryptoIVGen *ivgen,
                                     const uint8_t *key, size_t nkey,
diff --git a/crypto/ivgen-plain64.c b/crypto/ivgen-plain64.c
index e4679a1..fbb7724 100644
--- a/crypto/ivgen-plain64.c
+++ b/crypto/ivgen-plain64.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
-#include "crypto/ivgen-plain.h"
+#include "ivgen-plain.h"
 
 static int qcrypto_ivgen_plain_init(QCryptoIVGen *ivgen,
                                     const uint8_t *key, size_t nkey,
diff --git a/crypto/ivgen.c b/crypto/ivgen.c
index f664351..6a2b3ad 100644
--- a/crypto/ivgen.c
+++ b/crypto/ivgen.c
@@ -21,10 +21,10 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 
-#include "crypto/ivgenpriv.h"
-#include "crypto/ivgen-plain.h"
-#include "crypto/ivgen-plain64.h"
-#include "crypto/ivgen-essiv.h"
+#include "ivgenpriv.h"
+#include "ivgen-plain.h"
+#include "ivgen-plain64.h"
+#include "ivgen-essiv.h"
 
 
 QCryptoIVGen *qcrypto_ivgen_new(QCryptoIVGenAlgorithm alg,
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 3cd4103..02255a6 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "crypto/tlscredspriv.h"
+#include "tlscredspriv.h"
 #include "trace.h"
 
 #define DH_BITS 2048
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 1464220..7ad66d1 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "crypto/tlscredsanon.h"
-#include "crypto/tlscredspriv.h"
+#include "tlscredspriv.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 50eb54f..98ee042 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "crypto/tlscredsx509.h"
-#include "crypto/tlscredspriv.h"
+#include "tlscredspriv.h"
 #include "crypto/secret.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-- 
MST
