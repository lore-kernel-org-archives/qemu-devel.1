Received: from eggs.gnu.org ([2001:4830:134:3::10]:43867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxiA-00062w-8T
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxi9-0004lN-1J
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:08:30 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:06:51 +0200
Message-Id: <20170711160814.20941-3-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 02/85] block: add ability to set a prefix for
 opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

When integrating the crypto support with qcow/qcow2, we don't
want to use the bare LUKS option names "hash-alg", "key-secret",
etc. We need to namespace them to match the nested QAPI schema.

e.g. "encrypt.hash-alg", "encrypt.key-secret"

so that they don't clash with any general qcow options at a later
date.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170623162419.26068-3-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/crypto.h | 40 ++++++++++++++++++++--------------------
 block/crypto.c | 16 ++++++++--------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/block/crypto.h b/block/crypto.h
index c0e9b54..3430dcd 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -29,51 +29,51 @@
 #define BLOCK_CRYPTO_OPT_LUKS_HASH_ALG "hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_ITER_TIME "iter-time"
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET                            \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(prefix)                    \
     {                                                                   \
-        .name = BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,                       \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,                \
         .type = QEMU_OPT_STRING,                                        \
         .help = "ID of the secret that provides the keyslot passphrase", \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG               \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG(prefix)       \
     {                                                      \
-        .name = BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG,          \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG,   \
         .type = QEMU_OPT_STRING,                           \
         .help = "Name of encryption cipher algorithm",     \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE         \
-    {                                                 \
-        .name = BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE,    \
-        .type = QEMU_OPT_STRING,                      \
-        .help = "Name of encryption cipher mode",     \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE(prefix)      \
+    {                                                      \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE,  \
+        .type = QEMU_OPT_STRING,                           \
+        .help = "Name of encryption cipher mode",          \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG           \
-    {                                                 \
-        .name = BLOCK_CRYPTO_OPT_LUKS_IVGEN_ALG,      \
-        .type = QEMU_OPT_STRING,                      \
-        .help = "Name of IV generator algorithm",     \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG(prefix)     \
+    {                                                   \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_IVGEN_ALG, \
+        .type = QEMU_OPT_STRING,                        \
+        .help = "Name of IV generator algorithm",       \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG                \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG(prefix)        \
     {                                                           \
-        .name = BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG,           \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG,    \
         .type = QEMU_OPT_STRING,                                \
         .help = "Name of IV generator hash algorithm",          \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG               \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG(prefix)       \
     {                                                    \
-        .name = BLOCK_CRYPTO_OPT_LUKS_HASH_ALG,          \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_HASH_ALG,   \
         .type = QEMU_OPT_STRING,                         \
         .help = "Name of encryption hash algorithm",     \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME                   \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(prefix)           \
     {                                                         \
-        .name = BLOCK_CRYPTO_OPT_LUKS_ITER_TIME,              \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_ITER_TIME,       \
         .type = QEMU_OPT_NUMBER,                              \
         .help = "Time to spend in PBKDF in milliseconds",     \
     }
diff --git a/block/crypto.c b/block/crypto.c
index ea40ba4..9df1e5d 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -129,7 +129,7 @@ static QemuOptsList block_crypto_runtime_opts_luks = {
     .name = "crypto",
     .head = QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks.head),
     .desc = {
-        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(""),
         { /* end of list */ }
     },
 };
@@ -144,13 +144,13 @@ static QemuOptsList block_crypto_create_opts_luks = {
             .type = QEMU_OPT_SIZE,
             .help = "Virtual disk size"
         },
-        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(""),
         { /* end of list */ }
     },
 };
-- 
2.9.4
