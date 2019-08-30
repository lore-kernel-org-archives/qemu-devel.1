Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF3BC3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5357520674
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5357520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3o2o-0007x6-Cq
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 17:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwk-0003Av-GO
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwg-0001QN-8Y
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i3nwU-0001Iy-GF; Fri, 30 Aug 2019 16:56:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA8207FDFE;
 Fri, 30 Aug 2019 20:56:21 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 482125D9CA;
 Fri, 30 Aug 2019 20:56:19 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 23:56:00 +0300
Message-Id: <20190830205608.18192-3-mlevitsk@redhat.com>
In-Reply-To: <20190830205608.18192-1-mlevitsk@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 30 Aug 2019 20:56:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 02/10] qcrypto-luks: extend the create options
 for upcoming encryption key management
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now you can specify which slot to put the encryption key to
Plus add 'active' option which will let  user erase the key secret
instead of adding it.
Check that it is true for creation

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/crypto.c             |  2 ++
 block/crypto.h             | 16 +++++++++++
 block/qcow2.c              |  2 ++
 crypto/block-luks.c        | 26 +++++++++++++++---
 qapi/crypto.json           | 19 ++++++++++++++
 tests/qemu-iotests/082.out | 54 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 6e822c6e50..a6a3e1f1d8 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -144,6 +144,8 @@ static QemuOptsList block_crypto_create_opts_luks = {
         BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG(""),
         BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG(""),
         BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_SLOT(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ACTIVE(""),
         { /* end of list */ }
     },
 };
diff --git a/block/crypto.h b/block/crypto.h
index b935695e79..05cc43d9bc 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -35,12 +35,14 @@
         "ID of the secret that provides the AES encryption key")
 
 #define BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET "key-secret"
+#define BLOCK_CRYPTO_OPT_LUKS_SLOT "slot"
 #define BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG "cipher-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE "cipher-mode"
 #define BLOCK_CRYPTO_OPT_LUKS_IVGEN_ALG "ivgen-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG "ivgen-hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_HASH_ALG "hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_ITER_TIME "iter-time"
+#define BLOCK_CRYPTO_OPT_LUKS_ACTIVE "active"
 
 #define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(prefix)                    \
     BLOCK_CRYPTO_OPT_DEF_KEY_SECRET(prefix,                             \
@@ -88,6 +90,20 @@
         .help = "Time to spend in PBKDF in milliseconds",     \
     }
 
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_SLOT(prefix)           \
+    {                                                         \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_SLOT,       \
+        .type = QEMU_OPT_NUMBER,                              \
+        .help = "Controls the slot where the secret is added/erased",     \
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_ACTIVE(prefix)           \
+    {                                                         \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_ACTIVE,       \
+        .type = QEMU_OPT_BOOL,                              \
+        .help = "Controls if the added secret is added or erased",     \
+    }
+
 QCryptoBlockCreateOptions *
 block_crypto_create_opts_init(QDict *opts, Error **errp);
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 7c5a4859f7..be4a5063e5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5167,6 +5167,8 @@ static QemuOptsList qcow2_create_opts = {
         BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),
         BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),
         BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_SLOT("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ACTIVE("encrypt."),
         {
             .name = BLOCK_OPT_CLUSTER_SIZE,
             .type = QEMU_OPT_SIZE,
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 3af137e364..ba20d55246 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1230,6 +1230,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     const char *hash_alg;
     g_autofree char *cipher_mode_spec = NULL;
     uint64_t iters;
+    unsigned int slot_idx = 0;
 
     memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
     if (!luks_opts.has_iter_time) {
@@ -1263,12 +1264,30 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     luks->ivgen_hash_alg = luks_opts.ivgen_hash_alg;
     luks->hash_alg = luks_opts.hash_alg;
 
+    if (luks_opts.has_active && !luks_opts.active) {
+        error_setg(errp,
+                   "For image creation, the added secret must be active!");
+        goto error;
+
+    }
+
+    if (luks_opts.has_slot) {
+        if (luks_opts.slot >= QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ||
+            luks_opts.slot < 0) {
+                error_setg(errp,
+                           "Invalid slot %" PRId64 " is specified",
+                           luks_opts.slot);
+                goto error;
+        }
+        slot_idx = (unsigned int)luks_opts.slot;
+    }
+
 
     /* Note we're allowing ivgen_hash_alg to be set even for
      * non-essiv iv generators that don't need a hash. It will
      * be silently ignored, for compatibility with dm-crypt */
 
-    if (!options->u.luks.key_secret) {
+    if (!luks_opts.has_key_secret) {
         error_setg(errp, "Parameter '%skey-secret' is required for cipher",
                    optprefix ? optprefix : "");
         goto error;
@@ -1473,11 +1492,10 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
 
-
-    /* populate the slot 0 with the password encrypted master key*/
+    /* populate one of the slots with the password encrypted master key*/
     /* This will also store the header */
     if (qcrypto_block_luks_store_key(block,
-                                     0,
+                                     slot_idx,
                                      password,
                                      masterkey,
                                      luks_opts.iter_time,
diff --git a/qapi/crypto.json b/qapi/crypto.json
index b2a4cff683..9b83a70634 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -190,6 +190,20 @@
 #                  Currently defaults to 'sha256'
 # @hash-alg: the master key hash algorithm
 #            Currently defaults to 'sha256'
+#
+# @active: Should the new secret be added (true) or erased (false)
+#          (amend only, since 4.2)
+#
+# @slot: The slot in which to put/erase the secret
+#        if not given, will select first free slot for secret addtion
+#        and erase all matching keyslots for erase. except last one
+#        (optional, since 4.2)
+#
+# @unlock-secret: The secret to use to unlock the image
+#        If not given, will use the secret that was used
+#        when opening the image.
+#        (optional, for amend only, since 4.2)
+#
 # @iter-time: number of milliseconds to spend in
 #             PBKDF passphrase processing. Currently defaults
 #             to 2000. (since 2.8)
@@ -201,7 +215,12 @@
             '*cipher-mode': 'QCryptoCipherMode',
             '*ivgen-alg': 'QCryptoIVGenAlgorithm',
             '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
+
             '*hash-alg': 'QCryptoHashAlgorithm',
+            '*active' : 'bool',
+            '*slot': 'int',
+            '*unlock-secret': 'str',
+
             '*iter-time': 'int'}}
 
 
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 9d4ed4dc9d..5651a0b953 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -50,6 +50,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -58,6 +59,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -73,6 +75,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -81,6 +84,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -96,6 +100,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -104,6 +109,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -119,6 +125,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -127,6 +134,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -142,6 +150,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -150,6 +159,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -165,6 +175,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -173,6 +184,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -188,6 +200,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -196,6 +209,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -211,6 +225,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -219,6 +234,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -249,6 +265,7 @@ Supported qcow2 options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -257,6 +274,7 @@ Supported qcow2 options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -330,6 +348,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -338,6 +357,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -353,6 +373,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -361,6 +382,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -376,6 +398,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -384,6 +407,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -399,6 +423,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -407,6 +432,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -422,6 +448,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -430,6 +457,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -445,6 +473,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -453,6 +482,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -468,6 +498,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -476,6 +507,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -491,6 +523,7 @@ Supported options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -499,6 +532,7 @@ Supported options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -529,6 +563,7 @@ Supported qcow2 options:
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -537,6 +572,7 @@ Supported qcow2 options:
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -621,6 +657,7 @@ Creation options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -629,6 +666,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -645,6 +683,7 @@ Creation options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -653,6 +692,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -669,6 +709,7 @@ Creation options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -677,6 +718,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -693,6 +735,7 @@ Creation options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -701,6 +744,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -717,6 +761,7 @@ Creation options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -725,6 +770,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -741,6 +787,7 @@ Creation options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -749,6 +796,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -765,6 +813,7 @@ Creation options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -773,6 +822,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -789,6 +839,7 @@ Creation options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -797,6 +848,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -830,6 +882,7 @@ Creation options for 'qcow2':
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
+  encrypt.active=<bool (on/off)> - Controls if the added secret is added or erased
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=<str> - Name of encryption cipher mode
   encrypt.format=<str>   - Encrypt the image, format choices: 'aes', 'luks'
@@ -838,6 +891,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-alg=<str> - Name of IV generator algorithm
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
+  encrypt.slot=<num>     - Controls the slot where the secret is added/erased
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
-- 
2.17.2


