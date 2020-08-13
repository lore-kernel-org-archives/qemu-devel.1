Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C62EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481242076C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCJK6smQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481242076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63ts-0007zu-II
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sJ-00051g-5k
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:55 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sG-00009C-KG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:54 -0400
Received: by mail-pl1-x641.google.com with SMTP id bh1so1999419plb.12
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aMWNqFOgjOT3/apxgAdd5hAPkfQJszfd2f8kYZJcRqI=;
 b=sCJK6smQDaCj1Cy55ZTvvEjZzLwbYUDIRVrygL/DrUah8t1d6YbdrHcP/cWI2q2oYy
 ltGpV541MopXPqJTZ2UMehizf1IZ9QpZuMNWa/fWcwKo6EeNRLpRDIUCzdm/NX4fmsmn
 xr96muHIMez45EW2x8Bm/vj+lWrIt0Z/jpfgvbzEA8cQDPPHmhzfIM2UYMUm4pJigqZU
 25BelOXA9hBZXSOV5iz2mQzjr8CC6LOV89WTB6C6YLG8afG1TNHPZzr/o8t4QU23dXtC
 dhmd2rhGneP43iLMiO4db5DZ772I9T5XnWmMqAvCtH/NR5JXnCbH9dgC0EM4W3oJT0nN
 fP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aMWNqFOgjOT3/apxgAdd5hAPkfQJszfd2f8kYZJcRqI=;
 b=FfrUyxAjMCf6SkaYDRfXkpJwNxTd8uRM2qG3CUkBIVCIK/A6sribsHOq6cGzuOa86O
 llAfDGTEA1xdmt43cznfeOukcxcXT361kVUN7H2cjHQyd6GRBR83ZetqFd2thdrrX2Hq
 3WQUejgzbS1sW2IhKTM+fGVnuUWNLrMMpWYDQwR0GS97iZXYA1UkRS1i/AfIRLcZl5sz
 RKHNaMOL74IxlSjUarUcrqh6I+3uR2CrBOxy195dyxa3eDor/0qF07TrXJuqPbrNrgui
 bIcWhFfve86YqfZSqYdDbBr8nEWuhIL8DswZ7GgWrTDm1qirXPX+buGsVkpYFBv8sY8f
 jdTA==
X-Gm-Message-State: AOAM532UK1iTBcJxcrzkDYAqgIZjrSN8QgcHtqH4vAz3U2HRo+z1V7VH
 i2LNRJjB/72A+AHh0ncbCH2TQhk0ySo=
X-Google-Smtp-Source: ABdhPJyJxCqIk7Aq5xTE659uSXgK+lzje8KKNTY2X4RDX4qCjGTmfolhYkuch+/vd+pcg5JpSCjhBA==
X-Received: by 2002:a17:90a:630c:: with SMTP id
 e12mr2992398pjj.17.1597289150793; 
 Wed, 12 Aug 2020 20:25:50 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/17] crypto: Allocate QCryptoCipher with the subclass
Date: Wed, 12 Aug 2020 20:25:28 -0700
Message-Id: <20200813032537.2888593-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Merge the allocation of "opaque" into the allocation of "cipher".
This is step one in reducing the indirection in these classes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/afalgpriv.h          |  3 ++
 crypto/cipherpriv.h         |  2 +-
 include/crypto/cipher.h     |  1 -
 crypto/cipher-afalg.c       | 20 ++++++-----
 crypto/cipher-builtin.inc.c | 68 +++++++++++++++++++------------------
 crypto/cipher-gcrypt.inc.c  | 23 +++++++------
 crypto/cipher-nettle.inc.c  | 24 +++++++------
 crypto/cipher.c             | 20 ++++-------
 8 files changed, 84 insertions(+), 77 deletions(-)

diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
index f6550b5c51..5a2393f1b7 100644
--- a/crypto/afalgpriv.h
+++ b/crypto/afalgpriv.h
@@ -15,6 +15,7 @@
 #define QCRYPTO_AFALGPRIV_H
 
 #include <linux/if_alg.h>
+#include "crypto/cipher.h"
 
 #define SALG_TYPE_LEN_MAX 14
 #define SALG_NAME_LEN_MAX 64
@@ -32,6 +33,8 @@
 typedef struct QCryptoAFAlg QCryptoAFAlg;
 
 struct QCryptoAFAlg {
+    QCryptoCipher base;
+
     int tfmfd;
     int opfd;
     struct msghdr *msg;
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index b73be33bd2..437b109b5e 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -41,7 +41,7 @@ struct QCryptoCipherDriver {
 
 #include "afalgpriv.h"
 
-extern QCryptoAFAlg *
+extern QCryptoCipher *
 qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode,
                              const uint8_t *key,
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index 022a8d1157..56377c80fc 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -77,7 +77,6 @@
 struct QCryptoCipher {
     QCryptoCipherAlgorithm alg;
     QCryptoCipherMode mode;
-    void *opaque;
     const QCryptoCipherDriver *driver;
 };
 
diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
index 5c7c44761b..86e5249bd6 100644
--- a/crypto/cipher-afalg.c
+++ b/crypto/cipher-afalg.c
@@ -58,7 +58,7 @@ qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm alg,
     return name;
 }
 
-QCryptoAFAlg *
+QCryptoCipher *
 qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode,
                              const uint8_t *key,
@@ -109,7 +109,7 @@ qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     }
     afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
 
-    return afalg;
+    return &afalg->base;
 }
 
 static int
@@ -117,9 +117,9 @@ qcrypto_afalg_cipher_setiv(QCryptoCipher *cipher,
                            const uint8_t *iv,
                            size_t niv, Error **errp)
 {
+    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
     struct af_alg_iv *alg_iv;
     size_t expect_niv;
-    QCryptoAFAlg *afalg = cipher->opaque;
 
     expect_niv = qcrypto_cipher_get_iv_len(cipher->alg, cipher->mode);
     if (niv != expect_niv) {
@@ -200,8 +200,9 @@ qcrypto_afalg_cipher_encrypt(QCryptoCipher *cipher,
                              const void *in, void *out,
                              size_t len, Error **errp)
 {
-    return qcrypto_afalg_cipher_op(cipher->opaque, in, out,
-                                   len, true, errp);
+    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
+
+    return qcrypto_afalg_cipher_op(afalg, in, out, len, true, errp);
 }
 
 static int
@@ -209,13 +210,16 @@ qcrypto_afalg_cipher_decrypt(QCryptoCipher *cipher,
                              const void *in, void *out,
                              size_t len, Error **errp)
 {
-    return qcrypto_afalg_cipher_op(cipher->opaque, in, out,
-                                   len, false, errp);
+    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
+
+    return qcrypto_afalg_cipher_op(afalg, in, out, len, false, errp);
 }
 
 static void qcrypto_afalg_comm_ctx_free(QCryptoCipher *cipher)
 {
-    qcrypto_afalg_comm_free(cipher->opaque);
+    QCryptoAFAlg *afalg = container_of(cipher, QCryptoAFAlg, base);
+
+    qcrypto_afalg_comm_free(afalg);
 }
 
 const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
diff --git a/crypto/cipher-builtin.inc.c b/crypto/cipher-builtin.inc.c
index 156f32f1c7..6a03e23040 100644
--- a/crypto/cipher-builtin.inc.c
+++ b/crypto/cipher-builtin.inc.c
@@ -41,6 +41,8 @@ struct QCryptoCipherBuiltinDESRFB {
 
 typedef struct QCryptoCipherBuiltin QCryptoCipherBuiltin;
 struct QCryptoCipherBuiltin {
+    QCryptoCipher base;
+
     union {
         QCryptoCipherBuiltinAES aes;
         QCryptoCipherBuiltinDESRFB desrfb;
@@ -65,10 +67,7 @@ struct QCryptoCipherBuiltin {
 
 static void qcrypto_cipher_free_aes(QCryptoCipher *cipher)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
-
-    g_free(ctxt);
-    cipher->opaque = NULL;
+    g_free(cipher);
 }
 
 
@@ -152,7 +151,8 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
                                       size_t len,
                                       Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     switch (cipher->mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
@@ -186,7 +186,8 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
                                       size_t len,
                                       Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     switch (cipher->mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
@@ -217,7 +218,9 @@ static int qcrypto_cipher_setiv_aes(QCryptoCipher *cipher,
                                      const uint8_t *iv, size_t niv,
                                      Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
+
     if (niv != AES_BLOCK_SIZE) {
         error_setg(errp, "IV must be %d bytes not %zu",
                    AES_BLOCK_SIZE, niv);
@@ -232,7 +235,7 @@ static int qcrypto_cipher_setiv_aes(QCryptoCipher *cipher,
 
 
 
-static QCryptoCipherBuiltin *
+static QCryptoCipher *
 qcrypto_cipher_init_aes(QCryptoCipherMode mode,
                         const uint8_t *key, size_t nkey,
                         Error **errp)
@@ -289,7 +292,7 @@ qcrypto_cipher_init_aes(QCryptoCipherMode mode,
     ctxt->encrypt = qcrypto_cipher_encrypt_aes;
     ctxt->decrypt = qcrypto_cipher_decrypt_aes;
 
-    return ctxt;
+    return &ctxt->base;
 
  error:
     g_free(ctxt);
@@ -299,11 +302,11 @@ qcrypto_cipher_init_aes(QCryptoCipherMode mode,
 
 static void qcrypto_cipher_free_des_rfb(QCryptoCipher *cipher)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     g_free(ctxt->state.desrfb.key);
     g_free(ctxt);
-    cipher->opaque = NULL;
 }
 
 
@@ -313,7 +316,8 @@ static int qcrypto_cipher_encrypt_des_rfb(QCryptoCipher *cipher,
                                           size_t len,
                                           Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
     size_t i;
 
     if (len % 8) {
@@ -338,7 +342,8 @@ static int qcrypto_cipher_decrypt_des_rfb(QCryptoCipher *cipher,
                                           size_t len,
                                           Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
     size_t i;
 
     if (len % 8) {
@@ -366,7 +371,7 @@ static int qcrypto_cipher_setiv_des_rfb(QCryptoCipher *cipher,
 }
 
 
-static QCryptoCipherBuiltin *
+static QCryptoCipher *
 qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
                             const uint8_t *key, size_t nkey,
                             Error **errp)
@@ -391,7 +396,7 @@ qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
     ctxt->encrypt = qcrypto_cipher_encrypt_des_rfb;
     ctxt->decrypt = qcrypto_cipher_decrypt_des_rfb;
 
-    return ctxt;
+    return &ctxt->base;
 }
 
 
@@ -421,14 +426,12 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
 }
 
 
-static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
-                                                    QCryptoCipherMode mode,
-                                                    const uint8_t *key,
-                                                    size_t nkey,
-                                                    Error **errp)
+static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                                             QCryptoCipherMode mode,
+                                             const uint8_t *key,
+                                             size_t nkey,
+                                             Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt;
-
     switch (mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
     case QCRYPTO_CIPHER_MODE_CBC:
@@ -446,29 +449,25 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 
     switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
-        ctxt = qcrypto_cipher_init_des_rfb(mode, key, nkey, errp);
-        break;
+        return qcrypto_cipher_init_des_rfb(mode, key, nkey, errp);
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
-        ctxt = qcrypto_cipher_init_aes(mode, key, nkey, errp);
-        break;
+        return qcrypto_cipher_init_aes(mode, key, nkey, errp);
     default:
         error_setg(errp,
                    "Unsupported cipher algorithm %s",
                    QCryptoCipherAlgorithm_str(alg));
         return NULL;
     }
-
-    return ctxt;
 }
 
 static void
 qcrypto_builtin_cipher_ctx_free(QCryptoCipher *cipher)
 {
-    QCryptoCipherBuiltin *ctxt;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
-    ctxt = cipher->opaque;
     ctxt->free(cipher);
 }
 
@@ -480,7 +479,8 @@ qcrypto_builtin_cipher_encrypt(QCryptoCipher *cipher,
                                size_t len,
                                Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     if (len & (ctxt->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
@@ -499,7 +499,8 @@ qcrypto_builtin_cipher_decrypt(QCryptoCipher *cipher,
                                size_t len,
                                Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     if (len & (ctxt->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
@@ -516,7 +517,8 @@ qcrypto_builtin_cipher_setiv(QCryptoCipher *cipher,
                              const uint8_t *iv, size_t niv,
                              Error **errp)
 {
-    QCryptoCipherBuiltin *ctxt = cipher->opaque;
+    QCryptoCipherBuiltin *ctxt
+        = container_of(cipher, QCryptoCipherBuiltin, base);
 
     return ctxt->setiv(cipher, iv, niv, errp);
 }
diff --git a/crypto/cipher-gcrypt.inc.c b/crypto/cipher-gcrypt.inc.c
index 18850fadb9..3b3c85e265 100644
--- a/crypto/cipher-gcrypt.inc.c
+++ b/crypto/cipher-gcrypt.inc.c
@@ -58,6 +58,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
 
 typedef struct QCryptoCipherGcrypt QCryptoCipherGcrypt;
 struct QCryptoCipherGcrypt {
+    QCryptoCipher base;
     gcry_cipher_hd_t handle;
     size_t blocksize;
 #ifdef CONFIG_QEMU_PRIVATE_XTS
@@ -86,11 +87,11 @@ qcrypto_gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
 }
 
 
-static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
-                                                   QCryptoCipherMode mode,
-                                                   const uint8_t *key,
-                                                   size_t nkey,
-                                                   Error **errp)
+static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                                             QCryptoCipherMode mode,
+                                             const uint8_t *key,
+                                             size_t nkey,
+                                             Error **errp)
 {
     QCryptoCipherGcrypt *ctx;
     gcry_error_t err;
@@ -257,7 +258,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     }
 #endif
 
-    return ctx;
+    return &ctx->base;
 
  error:
     qcrypto_gcrypt_cipher_free_ctx(ctx, mode);
@@ -268,7 +269,9 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 static void
 qcrypto_gcrypt_cipher_ctx_free(QCryptoCipher *cipher)
 {
-    qcrypto_gcrypt_cipher_free_ctx(cipher->opaque, cipher->mode);
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+
+    qcrypto_gcrypt_cipher_free_ctx(ctx, cipher->mode);
 }
 
 
@@ -301,7 +304,7 @@ qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
                               size_t len,
                               Error **errp)
 {
-    QCryptoCipherGcrypt *ctx = cipher->opaque;
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
     gcry_error_t err;
 
     if (len & (ctx->blocksize - 1)) {
@@ -340,7 +343,7 @@ qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *cipher,
                               size_t len,
                               Error **errp)
 {
-    QCryptoCipherGcrypt *ctx = cipher->opaque;
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
     gcry_error_t err;
 
     if (len & (ctx->blocksize - 1)) {
@@ -376,7 +379,7 @@ qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
                             const uint8_t *iv, size_t niv,
                             Error **errp)
 {
-    QCryptoCipherGcrypt *ctx = cipher->opaque;
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
     gcry_error_t err;
 
     if (niv != ctx->blocksize) {
diff --git a/crypto/cipher-nettle.inc.c b/crypto/cipher-nettle.inc.c
index 6ecce5e8ea..d8371d1f37 100644
--- a/crypto/cipher-nettle.inc.c
+++ b/crypto/cipher-nettle.inc.c
@@ -294,6 +294,8 @@ static void twofish_decrypt_wrapper(const void *ctx, size_t length,
 
 typedef struct QCryptoCipherNettle QCryptoCipherNettle;
 struct QCryptoCipherNettle {
+    QCryptoCipher base;
+
     /* Primary cipher context for all modes */
     void *ctx;
     /* Second cipher context for XTS mode only */
@@ -355,11 +357,11 @@ qcrypto_nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
 }
 
 
-static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
-                                                   QCryptoCipherMode mode,
-                                                   const uint8_t *key,
-                                                   size_t nkey,
-                                                   Error **errp)
+static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                                             QCryptoCipherMode mode,
+                                             const uint8_t *key,
+                                             size_t nkey,
+                                             Error **errp)
 {
     QCryptoCipherNettle *ctx;
     uint8_t *rfbkey;
@@ -585,7 +587,7 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 
     ctx->iv = g_new0(uint8_t, ctx->blocksize);
 
-    return ctx;
+    return &ctx->base;
 
  error:
     qcrypto_nettle_cipher_free_ctx(ctx);
@@ -596,9 +598,8 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 static void
 qcrypto_nettle_cipher_ctx_free(QCryptoCipher *cipher)
 {
-    QCryptoCipherNettle *ctx;
+    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
 
-    ctx = cipher->opaque;
     qcrypto_nettle_cipher_free_ctx(ctx);
 }
 
@@ -610,7 +611,7 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
                               size_t len,
                               Error **errp)
 {
-    QCryptoCipherNettle *ctx = cipher->opaque;
+    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
 
     if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
@@ -663,7 +664,7 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
                               size_t len,
                               Error **errp)
 {
-    QCryptoCipherNettle *ctx = cipher->opaque;
+    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
 
     if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
@@ -713,7 +714,8 @@ qcrypto_nettle_cipher_setiv(QCryptoCipher *cipher,
                             const uint8_t *iv, size_t niv,
                             Error **errp)
 {
-    QCryptoCipherNettle *ctx = cipher->opaque;
+    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
+
     if (niv != ctx->blocksize) {
         error_setg(errp, "Expected IV size %zu not %zu",
                    ctx->blocksize, niv);
diff --git a/crypto/cipher.c b/crypto/cipher.c
index d3ef856009..6ea75bb764 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -163,30 +163,27 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
                                   const uint8_t *key, size_t nkey,
                                   Error **errp)
 {
-    QCryptoCipher *cipher;
-    void *ctx = NULL;
+    QCryptoCipher *cipher = NULL;
     const QCryptoCipherDriver *drv = NULL;
 
 #ifdef CONFIG_AF_ALG
-    ctx = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, NULL);
-    if (ctx) {
+    cipher = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, NULL);
+    if (cipher) {
         drv = &qcrypto_cipher_afalg_driver;
     }
 #endif
 
-    if (!ctx) {
-        ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
-        if (!ctx) {
+    if (!cipher) {
+        cipher = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
+        if (!cipher) {
             return NULL;
         }
 
         drv = &qcrypto_cipher_lib_driver;
     }
 
-    cipher = g_new0(QCryptoCipher, 1);
     cipher->alg = alg;
     cipher->mode = mode;
-    cipher->opaque = ctx;
     cipher->driver = drv;
 
     return cipher;
@@ -226,10 +223,7 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
 
 void qcrypto_cipher_free(QCryptoCipher *cipher)
 {
-    const QCryptoCipherDriver *drv;
     if (cipher) {
-        drv = cipher->driver;
-        drv->cipher_free(cipher);
-        g_free(cipher);
+        cipher->driver->cipher_free(cipher);
     }
 }
-- 
2.25.1


