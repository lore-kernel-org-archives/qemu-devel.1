Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B107C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB232206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lD4OP7YX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB232206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k642U-00034f-0D
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sZ-0005UJ-DO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:26:12 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:38317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sR-0000Ah-PU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:26:09 -0400
Received: by mail-pg1-x52b.google.com with SMTP id 128so2120102pgd.5
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QchneBl9TWix1N+ObvjtoFh5J1w2fPNIRVjlp3fdtNU=;
 b=lD4OP7YXFKrbGmhY+gXsoCZ8LJBnl2/ZPQ8GtFKqfb0df5Skr258zcq68jyehfuf4Q
 2/D1ZAuTjZZX8wKuSaXSCCrnYv5ezouHV98i8I2BENQh0zRss/NhSBTj0LMxtNL99elt
 lURUc5eePjcKOiGXIBnT1hSQRFIH5b/Ngs+P0wvNVEAqTBFmRBDYeICNxZ2giLKaChql
 K2V6Eo7wPfQ/+tzmU0IUJO+EpSOJLFa3SCQst7YldIagoEGGBHjb3dpnWFkYXwL7F1+F
 c6kdNNYMXF5Y5BEtOBWhiZcY8yBBJOGCHLlTZlQLoAfaOUyweFRNn3rXjjCM7d5dkvDR
 OPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QchneBl9TWix1N+ObvjtoFh5J1w2fPNIRVjlp3fdtNU=;
 b=qOU1owi0wwxi6mrfoCgacKJc7c8nsF0cUjtZWeQNgA5QLHbpa48+VBnTLKnsVx40jj
 B1UJ2uabs5JZ0Z/OV4owBQaCUA9eWMZHQ54moTJzYmMXnOLFAxcdyXmxg8ZKe32fJQtI
 Qe8wXxSlPrYuTa77vXNcx2x7TcYvDdMneJ1WPfFSNLj7j0djv5q6nYpt11dNxXUQuFRH
 PF/C0DRkkX+oxqZHbqLQ1AYxtAKYDzpye5/ZfSdLi5kydWq3G7R+RRXcdT9lQUfgfjYi
 Kmp0hOgI6OYxg8GZHgbnF9GAExwvF8vWTVlRvBrzAI3poOcKr0qOmJZur++hYY0p+7G4
 SjhA==
X-Gm-Message-State: AOAM533UOVzOkS9Qy/g8Haax9cM4jhsNZk7G0FeQoVcsepNkX95BnZek
 FNF3YJQtwmkJjLin2mPgmXU19Bx+0R0=
X-Google-Smtp-Source: ABdhPJxZrWGct5L7UJ1Bv6AeVUNt66VoQIAN1OGqMaxIkujuejztQ93Mbps2TAW2VywUxytwfm2xzw==
X-Received: by 2002:a62:d111:: with SMTP id z17mr2496717pfg.221.1597289160600; 
 Wed, 12 Aug 2020 20:26:00 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/17] crypto/nettle: Split QCryptoCipherNettle into subclasses
Date: Wed, 12 Aug 2020 20:25:36 -0700
Message-Id: <20200813032537.2888593-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Use separate classes for each cipher entry point: des_rfb, des3,
aes128, aes192, aes256, cast128, serpent, and twofish.

Generate wrappers for XTS only for CONFIG_QEMU_PRIVATE_XTS.
This eliminates unreachable wrappers for DES_RFB, DES3 and
CAST128, which have blocksizes that do not allow XTS mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-nettle.inc.c | 987 +++++++++++++++++++------------------
 1 file changed, 503 insertions(+), 484 deletions(-)

diff --git a/crypto/cipher-nettle.inc.c b/crypto/cipher-nettle.inc.c
index 36d57ef430..a1f4f6eac6 100644
--- a/crypto/cipher-nettle.inc.c
+++ b/crypto/cipher-nettle.inc.c
@@ -34,8 +34,6 @@
 #include <nettle/xts.h>
 #endif
 
-static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
-
 typedef void (*QCryptoCipherNettleFuncWrapper)(const void *ctx,
                                                size_t length,
                                                uint8_t *dst,
@@ -75,62 +73,212 @@ typedef const void * cipher_ctx_t;
 typedef size_t       cipher_length_t;
 #endif
 
-typedef struct QCryptoNettleAES128 {
-    struct aes128_ctx enc;
-    struct aes128_ctx dec;
-} QCryptoNettleAES128;
-
-typedef struct QCryptoNettleAES192 {
-    struct aes192_ctx enc;
-    struct aes192_ctx dec;
-} QCryptoNettleAES192;
-
-typedef struct QCryptoNettleAES256 {
-    struct aes256_ctx enc;
-    struct aes256_ctx dec;
-} QCryptoNettleAES256;
-
-static void aes128_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
-                                  uint8_t *dst, const uint8_t *src)
+static inline bool qcrypto_length_check(size_t len, size_t blocksize,
+                                        Error **errp)
 {
-    const QCryptoNettleAES128 *aesctx = ctx;
-    aes128_encrypt(&aesctx->enc, length, dst, src);
+    if (unlikely(len & (blocksize - 1))) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, blocksize);
+        return false;
+    }
+    return true;
 }
 
-static void aes128_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
-                                  uint8_t *dst, const uint8_t *src)
+
+static void qcrypto_cipher_ctx_free(QCryptoCipher *ctx)
 {
-    const QCryptoNettleAES128 *aesctx = ctx;
-    aes128_decrypt(&aesctx->dec, length, dst, src);
+    g_free(ctx);
 }
 
-static void aes192_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
-                               uint8_t *dst, const uint8_t *src)
+static int qcrypto_cipher_no_setiv(QCryptoCipher *cipher,
+                                   const uint8_t *iv, size_t niv,
+                                   Error **errp)
 {
-    const QCryptoNettleAES192 *aesctx = ctx;
-    aes192_encrypt(&aesctx->enc, length, dst, src);
+    error_setg(errp, "Setting IV is not supported");
+    return -1;
 }
 
-static void aes192_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
-                               uint8_t *dst, const uint8_t *src)
-{
-    const QCryptoNettleAES192 *aesctx = ctx;
-    aes192_decrypt(&aesctx->dec, length, dst, src);
+
+#define DEFINE_SETIV(NAME, TYPE, BLEN)                                  \
+static int NAME##_setiv(QCryptoCipher *cipher, const uint8_t *iv,       \
+                        size_t niv, Error **errp)                       \
+{                                                                       \
+    TYPE *ctx = container_of(cipher, TYPE, base);                       \
+    if (niv != BLEN) {                                                  \
+        error_setg(errp, "Expected IV size %d not %zu", BLEN, niv);     \
+        return -1;                                                      \
+    }                                                                   \
+    memcpy(ctx->iv, iv, niv);                                           \
+    return 0;                                                           \
 }
 
-static void aes256_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
-                               uint8_t *dst, const uint8_t *src)
-{
-    const QCryptoNettleAES256 *aesctx = ctx;
-    aes256_encrypt(&aesctx->enc, length, dst, src);
-}
 
-static void aes256_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
-                               uint8_t *dst, const uint8_t *src)
-{
-    const QCryptoNettleAES256 *aesctx = ctx;
-    aes256_decrypt(&aesctx->dec, length, dst, src);
+#define DEFINE_ECB(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)                  \
+static int NAME##_encrypt_ecb(QCryptoCipher *cipher, const void *in,    \
+                              void *out, size_t len, Error **errp)      \
+{                                                                       \
+    TYPE *ctx = container_of(cipher, TYPE, base);                       \
+    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
+        return -1;                                                      \
+    }                                                                   \
+    ENCRYPT(&ctx->key, len, out, in);                                   \
+    return 0;                                                           \
+}                                                                       \
+static int NAME##_decrypt_ecb(QCryptoCipher *cipher, const void *in,    \
+                              void *out, size_t len, Error **errp)      \
+{                                                                       \
+    TYPE *ctx = container_of(cipher, TYPE, base);                       \
+    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
+        return -1;                                                      \
+    }                                                                   \
+    DECRYPT(&ctx->key, len, out, in);                                   \
+    return 0;                                                           \
+}                                                                       \
+static const struct QCryptoCipherDriver NAME##_driver_ecb = {           \
+    .cipher_encrypt = NAME##_encrypt_ecb,                               \
+    .cipher_decrypt = NAME##_decrypt_ecb,                               \
+    .cipher_setiv = qcrypto_cipher_no_setiv,                            \
+    .cipher_free = qcrypto_cipher_ctx_free,                             \
+};
+
+
+#define DEFINE_CBC(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)                  \
+static int NAME##_encrypt_cbc(QCryptoCipher *cipher, const void *in,    \
+                              void *out, size_t len, Error **errp)      \
+{                                                                       \
+    TYPE *ctx = container_of(cipher, TYPE, base);                       \
+    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
+        return -1;                                                      \
+    }                                                                   \
+    cbc_encrypt(&ctx->key, ENCRYPT, BLEN, ctx->iv, len, out, in);       \
+    return 0;                                                           \
+}                                                                       \
+static int NAME##_decrypt_cbc(QCryptoCipher *cipher, const void *in,    \
+                              void *out, size_t len, Error **errp)      \
+{                                                                       \
+    TYPE *ctx = container_of(cipher, TYPE, base);                       \
+    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
+        return -1;                                                      \
+    }                                                                   \
+    cbc_decrypt(&ctx->key, DECRYPT, BLEN, ctx->iv, len, out, in);       \
+    return 0;                                                           \
+}                                                                       \
+static const struct QCryptoCipherDriver NAME##_driver_cbc = {           \
+    .cipher_encrypt = NAME##_encrypt_cbc,                               \
+    .cipher_decrypt = NAME##_decrypt_cbc,                               \
+    .cipher_setiv = NAME##_setiv,                                       \
+    .cipher_free = qcrypto_cipher_ctx_free,                             \
+};
+
+
+#define DEFINE_CTR(NAME, TYPE, BLEN, ENCRYPT)                           \
+static int NAME##_encrypt_ctr(QCryptoCipher *cipher, const void *in,    \
+                              void *out, size_t len, Error **errp)      \
+{                                                                       \
+    TYPE *ctx = container_of(cipher, TYPE, base);                       \
+    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
+        return -1;                                                      \
+    }                                                                   \
+    ctr_crypt(&ctx->key, ENCRYPT, BLEN, ctx->iv, len, out, in);         \
+    return 0;                                                           \
+}                                                                       \
+static const struct QCryptoCipherDriver NAME##_driver_ctr = {           \
+    .cipher_encrypt = NAME##_encrypt_ctr,                               \
+    .cipher_decrypt = NAME##_encrypt_ctr,                               \
+    .cipher_setiv = NAME##_setiv,                                       \
+    .cipher_free = qcrypto_cipher_ctx_free,                             \
+};
+
+
+#ifdef CONFIG_QEMU_PRIVATE_XTS
+#define DEFINE__XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)                 \
+static void NAME##_xts_wrape(const void *ctx, size_t length,            \
+                             uint8_t *dst, const uint8_t *src)          \
+{                                                                       \
+    ENCRYPT(ctx, length, dst, src);                                     \
+}                                                                       \
+static void NAME##_xts_wrapd(const void *ctx, size_t length,            \
+                             uint8_t *dst, const uint8_t *src)          \
+{                                                                       \
+    DECRYPT(ctx, length, dst, src);                                     \
+}                                                                       \
+static int NAME##_encrypt_xts(QCryptoCipher *cipher, const void *in,    \
+                              void *out, size_t len, Error **errp)      \
+{                                                                       \
+    TYPE *ctx = container_of(cipher, TYPE, base);                       \
+    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
+        return -1;                                                      \
+    }                                                                   \
+    xts_encrypt(&ctx->key, &ctx->key_xts,                               \
+                NAME##_xts_wrape, NAME##_xts_wrapd,                     \
+                ctx->iv, len, out, in);                                 \
+    return 0;                                                           \
+}                                                                       \
+static int NAME##_decrypt_xts(QCryptoCipher *cipher, const void *in,    \
+                              void *out, size_t len, Error **errp)      \
+{                                                                       \
+    TYPE *ctx = container_of(cipher, TYPE, base);                       \
+    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
+        return -1;                                                      \
+    }                                                                   \
+    xts_decrypt(&ctx->key, &ctx->key_xts,                               \
+                NAME##_xts_wrape, NAME##_xts_wrapd,                     \
+                ctx->iv, len, out, in);                                 \
+    return 0;                                                           \
 }
+#else
+#define DEFINE__XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)                 \
+static int NAME##_encrypt_xts(QCryptoCipher *cipher, const void *in,    \
+                              void *out, size_t len, Error **errp)      \
+{                                                                       \
+    TYPE *ctx = container_of(cipher, TYPE, base);                       \
+    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
+        return -1;                                                      \
+    }                                                                   \
+    xts_encrypt_message(&ctx->key, &ctx->key_xts, ENCRYPT,              \
+                        ctx->iv, len, out, in);                         \
+    return 0;                                                           \
+}                                                                       \
+static int NAME##_decrypt_xts(QCryptoCipher *cipher, const void *in,    \
+                              void *out, size_t len, Error **errp)      \
+{                                                                       \
+    TYPE *ctx = container_of(cipher, TYPE, base);                       \
+    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
+        return -1;                                                      \
+    }                                                                   \
+    xts_decrypt_message(&ctx->key, &ctx->key_xts, DECRYPT, ENCRYPT,     \
+                        ctx->iv, len, out, in);                         \
+    return 0;                                                           \
+}
+#endif
+
+#define DEFINE_XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)          \
+    QEMU_BUILD_BUG_ON(BLEN != XTS_BLOCK_SIZE);                  \
+    DEFINE__XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)             \
+static const struct QCryptoCipherDriver NAME##_driver_xts = {   \
+    .cipher_encrypt = NAME##_encrypt_xts,                       \
+    .cipher_decrypt = NAME##_decrypt_xts,                       \
+    .cipher_setiv = NAME##_setiv,                               \
+    .cipher_free = qcrypto_cipher_ctx_free,                     \
+};
+
+
+#define DEFINE_ECB_CBC_CTR(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)  \
+    DEFINE_SETIV(NAME, TYPE, BLEN)                              \
+    DEFINE_ECB(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)              \
+    DEFINE_CBC(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)              \
+    DEFINE_CTR(NAME, TYPE, BLEN, ENCRYPT)
+
+#define DEFINE_ECB_CBC_CTR_XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)      \
+    DEFINE_ECB_CBC_CTR(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)              \
+    DEFINE_XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)
+
+
+typedef struct QCryptoNettleDESRFB {
+    QCryptoCipher base;
+    struct des_ctx key;
+    uint8_t iv[DES_BLOCK_SIZE];
+} QCryptoNettleDESRFB;
 
 static void des_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
                                uint8_t *dst, const uint8_t *src)
@@ -144,6 +292,16 @@ static void des_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
     des_decrypt(ctx, length, dst, src);
 }
 
+DEFINE_ECB_CBC_CTR(qcrypto_nettle_des_rfb, QCryptoNettleDESRFB,
+                   DES_BLOCK_SIZE, des_encrypt_native, des_decrypt_native)
+
+
+typedef struct QCryptoNettleDES3 {
+    QCryptoCipher base;
+    struct des3_ctx key;
+    uint8_t iv[DES3_BLOCK_SIZE];
+} QCryptoNettleDES3;
+
 static void des3_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
                                 uint8_t *dst, const uint8_t *src)
 {
@@ -156,6 +314,94 @@ static void des3_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
     des3_decrypt(ctx, length, dst, src);
 }
 
+DEFINE_ECB_CBC_CTR(qcrypto_nettle_des3, QCryptoNettleDES3, DES3_BLOCK_SIZE,
+                   des3_encrypt_native, des3_decrypt_native)
+
+
+typedef struct QCryptoNettleAES128 {
+    QCryptoCipher base;
+    uint8_t iv[AES_BLOCK_SIZE];
+    /* First key from pair is encode, second key is decode. */
+    struct aes128_ctx key[2], key_xts[2];
+} QCryptoNettleAES128;
+
+static void aes128_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
+                                  uint8_t *dst, const uint8_t *src)
+{
+    const struct aes128_ctx *keys = ctx;
+    aes128_encrypt(&keys[0], length, dst, src);
+}
+
+static void aes128_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
+                                  uint8_t *dst, const uint8_t *src)
+{
+    const struct aes128_ctx *keys = ctx;
+    aes128_decrypt(&keys[1], length, dst, src);
+}
+
+DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_aes128,
+                       QCryptoNettleAES128, AES_BLOCK_SIZE,
+                       aes128_encrypt_native, aes128_decrypt_native)
+
+
+typedef struct QCryptoNettleAES192 {
+    QCryptoCipher base;
+    uint8_t iv[AES_BLOCK_SIZE];
+    /* First key from pair is encode, second key is decode. */
+    struct aes192_ctx key[2], key_xts[2];
+} QCryptoNettleAES192;
+
+static void aes192_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
+                                  uint8_t *dst, const uint8_t *src)
+{
+    const struct aes192_ctx *keys = ctx;
+    aes192_encrypt(&keys[0], length, dst, src);
+}
+
+static void aes192_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
+                                  uint8_t *dst, const uint8_t *src)
+{
+    const struct aes192_ctx *keys = ctx;
+    aes192_decrypt(&keys[1], length, dst, src);
+}
+
+DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_aes192,
+                       QCryptoNettleAES192, AES_BLOCK_SIZE,
+                       aes192_encrypt_native, aes192_decrypt_native)
+
+
+typedef struct QCryptoNettleAES256 {
+    QCryptoCipher base;
+    uint8_t iv[AES_BLOCK_SIZE];
+    /* First key from pair is encode, second key is decode. */
+    struct aes256_ctx key[2], key_xts[2];
+} QCryptoNettleAES256;
+
+static void aes256_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
+                                  uint8_t *dst, const uint8_t *src)
+{
+    const struct aes256_ctx *keys = ctx;
+    aes256_encrypt(&keys[0], length, dst, src);
+}
+
+static void aes256_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
+                               uint8_t *dst, const uint8_t *src)
+{
+    const struct aes256_ctx *keys = ctx;
+    aes256_decrypt(&keys[1], length, dst, src);
+}
+
+DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_aes256,
+                       QCryptoNettleAES256, AES_BLOCK_SIZE,
+                       aes256_encrypt_native, aes256_decrypt_native)
+
+
+typedef struct QCryptoNettleCAST128 {
+    QCryptoCipher base;
+    uint8_t iv[CAST128_BLOCK_SIZE];
+    struct cast128_ctx key, key_xts;
+} QCryptoNettleCAST128;
+
 static void cast128_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
                                    uint8_t *dst, const uint8_t *src)
 {
@@ -168,6 +414,18 @@ static void cast128_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
     cast128_decrypt(ctx, length, dst, src);
 }
 
+DEFINE_ECB_CBC_CTR(qcrypto_nettle_cast128,
+                   QCryptoNettleCAST128, CAST128_BLOCK_SIZE,
+                   cast128_encrypt_native, cast128_decrypt_native)
+
+
+typedef struct QCryptoNettleSerpent {
+    QCryptoCipher base;
+    uint8_t iv[SERPENT_BLOCK_SIZE];
+    struct serpent_ctx key, key_xts;
+} QCryptoNettleSerpent;
+
+
 static void serpent_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
                                    uint8_t *dst, const uint8_t *src)
 {
@@ -180,6 +438,17 @@ static void serpent_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
     serpent_decrypt(ctx, length, dst, src);
 }
 
+DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_serpent,
+                       QCryptoNettleSerpent, SERPENT_BLOCK_SIZE,
+                       serpent_encrypt_native, serpent_decrypt_native)
+
+
+typedef struct QCryptoNettleTwofish {
+    QCryptoCipher base;
+    uint8_t iv[TWOFISH_BLOCK_SIZE];
+    struct twofish_ctx key, key_xts;
+} QCryptoNettleTwofish;
+
 static void twofish_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
                                    uint8_t *dst, const uint8_t *src)
 {
@@ -192,125 +461,10 @@ static void twofish_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
     twofish_decrypt(ctx, length, dst, src);
 }
 
-static void aes128_encrypt_wrapper(const void *ctx, size_t length,
-                                uint8_t *dst, const uint8_t *src)
-{
-    const QCryptoNettleAES128 *aesctx = ctx;
-    aes128_encrypt(&aesctx->enc, length, dst, src);
-}
+DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_twofish,
+                       QCryptoNettleTwofish, TWOFISH_BLOCK_SIZE,
+                       twofish_encrypt_native, twofish_decrypt_native)
 
-static void aes128_decrypt_wrapper(const void *ctx, size_t length,
-                                uint8_t *dst, const uint8_t *src)
-{
-    const QCryptoNettleAES128 *aesctx = ctx;
-    aes128_decrypt(&aesctx->dec, length, dst, src);
-}
-
-static void aes192_encrypt_wrapper(const void *ctx, size_t length,
-                                uint8_t *dst, const uint8_t *src)
-{
-    const QCryptoNettleAES192 *aesctx = ctx;
-    aes192_encrypt(&aesctx->enc, length, dst, src);
-}
-
-static void aes192_decrypt_wrapper(const void *ctx, size_t length,
-                                uint8_t *dst, const uint8_t *src)
-{
-    const QCryptoNettleAES192 *aesctx = ctx;
-    aes192_decrypt(&aesctx->dec, length, dst, src);
-}
-
-static void aes256_encrypt_wrapper(const void *ctx, size_t length,
-                                uint8_t *dst, const uint8_t *src)
-{
-    const QCryptoNettleAES256 *aesctx = ctx;
-    aes256_encrypt(&aesctx->enc, length, dst, src);
-}
-
-static void aes256_decrypt_wrapper(const void *ctx, size_t length,
-                                uint8_t *dst, const uint8_t *src)
-{
-    const QCryptoNettleAES256 *aesctx = ctx;
-    aes256_decrypt(&aesctx->dec, length, dst, src);
-}
-
-static void des_encrypt_wrapper(const void *ctx, size_t length,
-                                uint8_t *dst, const uint8_t *src)
-{
-    des_encrypt(ctx, length, dst, src);
-}
-
-static void des_decrypt_wrapper(const void *ctx, size_t length,
-                                uint8_t *dst, const uint8_t *src)
-{
-    des_decrypt(ctx, length, dst, src);
-}
-
-static void des3_encrypt_wrapper(const void *ctx, size_t length,
-                                uint8_t *dst, const uint8_t *src)
-{
-    des3_encrypt(ctx, length, dst, src);
-}
-
-static void des3_decrypt_wrapper(const void *ctx, size_t length,
-                                uint8_t *dst, const uint8_t *src)
-{
-    des3_decrypt(ctx, length, dst, src);
-}
-
-static void cast128_encrypt_wrapper(const void *ctx, size_t length,
-                                    uint8_t *dst, const uint8_t *src)
-{
-    cast128_encrypt(ctx, length, dst, src);
-}
-
-static void cast128_decrypt_wrapper(const void *ctx, size_t length,
-                                    uint8_t *dst, const uint8_t *src)
-{
-    cast128_decrypt(ctx, length, dst, src);
-}
-
-static void serpent_encrypt_wrapper(const void *ctx, size_t length,
-                                    uint8_t *dst, const uint8_t *src)
-{
-    serpent_encrypt(ctx, length, dst, src);
-}
-
-static void serpent_decrypt_wrapper(const void *ctx, size_t length,
-                                    uint8_t *dst, const uint8_t *src)
-{
-    serpent_decrypt(ctx, length, dst, src);
-}
-
-static void twofish_encrypt_wrapper(const void *ctx, size_t length,
-                                    uint8_t *dst, const uint8_t *src)
-{
-    twofish_encrypt(ctx, length, dst, src);
-}
-
-static void twofish_decrypt_wrapper(const void *ctx, size_t length,
-                                    uint8_t *dst, const uint8_t *src)
-{
-    twofish_decrypt(ctx, length, dst, src);
-}
-
-typedef struct QCryptoCipherNettle QCryptoCipherNettle;
-struct QCryptoCipherNettle {
-    QCryptoCipher base;
-
-    /* Primary cipher context for all modes */
-    void *ctx;
-    /* Second cipher context for XTS mode only */
-    void *ctx_tweak;
-    /* Cipher callbacks for both contexts */
-    QCryptoCipherNettleFuncNative alg_encrypt_native;
-    QCryptoCipherNettleFuncNative alg_decrypt_native;
-    QCryptoCipherNettleFuncWrapper alg_encrypt_wrapper;
-    QCryptoCipherNettleFuncWrapper alg_decrypt_wrapper;
-    /* Initialization vector or Counter */
-    uint8_t *iv;
-    size_t blocksize;
-};
 
 bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode)
@@ -344,30 +498,12 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
     }
 }
 
-
-static void
-qcrypto_nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
-{
-    if (!ctx) {
-        return;
-    }
-
-    g_free(ctx->iv);
-    g_free(ctx->ctx);
-    g_free(ctx->ctx_tweak);
-    g_free(ctx);
-}
-
-
 static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                                              QCryptoCipherMode mode,
                                              const uint8_t *key,
                                              size_t nkey,
                                              Error **errp)
 {
-    QCryptoCipherNettle *ctx;
-    uint8_t *rfbkey;
-
     switch (mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
     case QCRYPTO_CIPHER_MODE_CBC:
@@ -375,6 +511,7 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_MODE_CTR:
         break;
     default:
+    bad_cipher_mode:
         error_setg(errp, "Unsupported cipher mode %s",
                    QCryptoCipherMode_str(mode));
         return NULL;
@@ -384,354 +521,236 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
         return NULL;
     }
 
-    ctx = g_new0(QCryptoCipherNettle, 1);
-
     switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
-        ctx->ctx = g_new0(struct des_ctx, 1);
-        rfbkey = qcrypto_cipher_munge_des_rfb_key(key, nkey);
-        des_set_key(ctx->ctx, rfbkey);
-        g_free(rfbkey);
+        {
+            QCryptoNettleDESRFB *ctx;
+            const QCryptoCipherDriver *drv;
+            uint8_t *rfbkey;
 
-        ctx->alg_encrypt_native = des_encrypt_native;
-        ctx->alg_decrypt_native = des_decrypt_native;
-        ctx->alg_encrypt_wrapper = des_encrypt_wrapper;
-        ctx->alg_decrypt_wrapper = des_decrypt_wrapper;
+            switch (mode) {
+            case QCRYPTO_CIPHER_MODE_ECB:
+                drv = &qcrypto_nettle_des_rfb_driver_ecb;
+                break;
+            case QCRYPTO_CIPHER_MODE_CBC:
+                drv = &qcrypto_nettle_des_rfb_driver_cbc;
+                break;
+            case QCRYPTO_CIPHER_MODE_CTR:
+                drv = &qcrypto_nettle_des_rfb_driver_ctr;
+                break;
+            default:
+                goto bad_cipher_mode;
+            }
 
-        ctx->blocksize = DES_BLOCK_SIZE;
-        break;
+            ctx = g_new0(QCryptoNettleDESRFB, 1);
+            ctx->base.driver = drv;
+
+            rfbkey = qcrypto_cipher_munge_des_rfb_key(key, nkey);
+            des_set_key(&ctx->key, rfbkey);
+            g_free(rfbkey);
+
+            return &ctx->base;
+        }
 
     case QCRYPTO_CIPHER_ALG_3DES:
-        ctx->ctx = g_new0(struct des3_ctx, 1);
-        des3_set_key(ctx->ctx, key);
+        {
+            QCryptoNettleDES3 *ctx;
+            const QCryptoCipherDriver *drv;
 
-        ctx->alg_encrypt_native = des3_encrypt_native;
-        ctx->alg_decrypt_native = des3_decrypt_native;
-        ctx->alg_encrypt_wrapper = des3_encrypt_wrapper;
-        ctx->alg_decrypt_wrapper = des3_decrypt_wrapper;
+            switch (mode) {
+            case QCRYPTO_CIPHER_MODE_ECB:
+                drv = &qcrypto_nettle_des3_driver_ecb;
+                break;
+            case QCRYPTO_CIPHER_MODE_CBC:
+                drv = &qcrypto_nettle_des3_driver_cbc;
+                break;
+            case QCRYPTO_CIPHER_MODE_CTR:
+                drv = &qcrypto_nettle_des3_driver_ctr;
+                break;
+            default:
+                goto bad_cipher_mode;
+            }
 
-        ctx->blocksize = DES3_BLOCK_SIZE;
-        break;
+            ctx = g_new0(QCryptoNettleDES3, 1);
+            ctx->base.driver = drv;
+            des3_set_key(&ctx->key, key);
+            return &ctx->base;
+        }
 
     case QCRYPTO_CIPHER_ALG_AES_128:
-        ctx->ctx = g_new0(QCryptoNettleAES128, 1);
+        {
+            QCryptoNettleAES128 *ctx = g_new0(QCryptoNettleAES128, 1);
 
-        if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-            ctx->ctx_tweak = g_new0(QCryptoNettleAES128, 1);
+            switch (mode) {
+            case QCRYPTO_CIPHER_MODE_ECB:
+                ctx->base.driver = &qcrypto_nettle_aes128_driver_ecb;
+                break;
+            case QCRYPTO_CIPHER_MODE_CBC:
+                ctx->base.driver = &qcrypto_nettle_aes128_driver_cbc;
+                break;
+            case QCRYPTO_CIPHER_MODE_CTR:
+                ctx->base.driver = &qcrypto_nettle_aes128_driver_ctr;
+                break;
+            case QCRYPTO_CIPHER_MODE_XTS:
+                ctx->base.driver = &qcrypto_nettle_aes128_driver_xts;
+                nkey /= 2;
+                aes128_set_encrypt_key(&ctx->key_xts[0], key + nkey);
+                aes128_set_decrypt_key(&ctx->key_xts[1], key + nkey);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            aes128_set_encrypt_key(&ctx->key[0], key);
+            aes128_set_decrypt_key(&ctx->key[1], key);
 
-            nkey /= 2;
-            aes128_set_encrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->enc,
-                                   key);
-            aes128_set_decrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->dec,
-                                   key);
-
-            aes128_set_encrypt_key(&((QCryptoNettleAES128 *)ctx->ctx_tweak)->
-                                   enc, key + nkey);
-            aes128_set_decrypt_key(&((QCryptoNettleAES128 *)ctx->ctx_tweak)->
-                                   dec, key + nkey);
-        } else {
-            aes128_set_encrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->enc,
-                                   key);
-            aes128_set_decrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->dec,
-                                   key);
+            return &ctx->base;
         }
 
-        ctx->alg_encrypt_native = aes128_encrypt_native;
-        ctx->alg_decrypt_native = aes128_decrypt_native;
-        ctx->alg_encrypt_wrapper = aes128_encrypt_wrapper;
-        ctx->alg_decrypt_wrapper = aes128_decrypt_wrapper;
-
-        ctx->blocksize = AES_BLOCK_SIZE;
-        break;
-
     case QCRYPTO_CIPHER_ALG_AES_192:
-        ctx->ctx = g_new0(QCryptoNettleAES192, 1);
+        {
+            QCryptoNettleAES192 *ctx = g_new0(QCryptoNettleAES192, 1);
 
-        if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-            ctx->ctx_tweak = g_new0(QCryptoNettleAES192, 1);
+            switch (mode) {
+            case QCRYPTO_CIPHER_MODE_ECB:
+                ctx->base.driver = &qcrypto_nettle_aes192_driver_ecb;
+                break;
+            case QCRYPTO_CIPHER_MODE_CBC:
+                ctx->base.driver = &qcrypto_nettle_aes192_driver_cbc;
+                break;
+            case QCRYPTO_CIPHER_MODE_CTR:
+                ctx->base.driver = &qcrypto_nettle_aes192_driver_ctr;
+                break;
+            case QCRYPTO_CIPHER_MODE_XTS:
+                ctx->base.driver = &qcrypto_nettle_aes192_driver_xts;
+                nkey /= 2;
+                aes192_set_encrypt_key(&ctx->key_xts[0], key + nkey);
+                aes192_set_decrypt_key(&ctx->key_xts[1], key + nkey);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            aes192_set_encrypt_key(&ctx->key[0], key);
+            aes192_set_decrypt_key(&ctx->key[1], key);
 
-            nkey /= 2;
-            aes192_set_encrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->enc,
-                                   key);
-            aes192_set_decrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->dec,
-                                   key);
-
-            aes192_set_encrypt_key(&((QCryptoNettleAES192 *)ctx->ctx_tweak)->
-                                   enc, key + nkey);
-            aes192_set_decrypt_key(&((QCryptoNettleAES192 *)ctx->ctx_tweak)->
-                                   dec, key + nkey);
-        } else {
-            aes192_set_encrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->enc,
-                                   key);
-            aes192_set_decrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->dec,
-                                   key);
+            return &ctx->base;
         }
 
-        ctx->alg_encrypt_native = aes192_encrypt_native;
-        ctx->alg_decrypt_native = aes192_decrypt_native;
-        ctx->alg_encrypt_wrapper = aes192_encrypt_wrapper;
-        ctx->alg_decrypt_wrapper = aes192_decrypt_wrapper;
-
-        ctx->blocksize = AES_BLOCK_SIZE;
-        break;
-
     case QCRYPTO_CIPHER_ALG_AES_256:
-        ctx->ctx = g_new0(QCryptoNettleAES256, 1);
+        {
+            QCryptoNettleAES256 *ctx = g_new0(QCryptoNettleAES256, 1);
 
-        if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-            ctx->ctx_tweak = g_new0(QCryptoNettleAES256, 1);
+            switch (mode) {
+            case QCRYPTO_CIPHER_MODE_ECB:
+                ctx->base.driver = &qcrypto_nettle_aes256_driver_ecb;
+                break;
+            case QCRYPTO_CIPHER_MODE_CBC:
+                ctx->base.driver = &qcrypto_nettle_aes256_driver_cbc;
+                break;
+            case QCRYPTO_CIPHER_MODE_CTR:
+                ctx->base.driver = &qcrypto_nettle_aes256_driver_ctr;
+                break;
+            case QCRYPTO_CIPHER_MODE_XTS:
+                ctx->base.driver = &qcrypto_nettle_aes256_driver_xts;
+                nkey /= 2;
+                aes256_set_encrypt_key(&ctx->key_xts[0], key + nkey);
+                aes256_set_decrypt_key(&ctx->key_xts[1], key + nkey);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            aes256_set_encrypt_key(&ctx->key[0], key);
+            aes256_set_decrypt_key(&ctx->key[1], key);
 
-            nkey /= 2;
-            aes256_set_encrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->enc,
-                                   key);
-            aes256_set_decrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->dec,
-                                   key);
-
-            aes256_set_encrypt_key(&((QCryptoNettleAES256 *)ctx->ctx_tweak)->
-                                   enc, key + nkey);
-            aes256_set_decrypt_key(&((QCryptoNettleAES256 *)ctx->ctx_tweak)->
-                                   dec, key + nkey);
-        } else {
-            aes256_set_encrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->enc,
-                                   key);
-            aes256_set_decrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->dec,
-                                   key);
+            return &ctx->base;
         }
 
-        ctx->alg_encrypt_native = aes256_encrypt_native;
-        ctx->alg_decrypt_native = aes256_decrypt_native;
-        ctx->alg_encrypt_wrapper = aes256_encrypt_wrapper;
-        ctx->alg_decrypt_wrapper = aes256_decrypt_wrapper;
-
-        ctx->blocksize = AES_BLOCK_SIZE;
-        break;
-
     case QCRYPTO_CIPHER_ALG_CAST5_128:
-        ctx->ctx = g_new0(struct cast128_ctx, 1);
+        {
+            QCryptoNettleCAST128 *ctx;
+            const QCryptoCipherDriver *drv;
 
-        if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-            ctx->ctx_tweak = g_new0(struct cast128_ctx, 1);
+            switch (mode) {
+            case QCRYPTO_CIPHER_MODE_ECB:
+                drv = &qcrypto_nettle_cast128_driver_ecb;
+                break;
+            case QCRYPTO_CIPHER_MODE_CBC:
+                drv = &qcrypto_nettle_cast128_driver_cbc;
+                break;
+            case QCRYPTO_CIPHER_MODE_CTR:
+                drv = &qcrypto_nettle_cast128_driver_ctr;
+                break;
+            default:
+                goto bad_cipher_mode;
+            }
 
-            nkey /= 2;
-            cast5_set_key(ctx->ctx, nkey, key);
-            cast5_set_key(ctx->ctx_tweak, nkey, key + nkey);
-        } else {
-            cast5_set_key(ctx->ctx, nkey, key);
+            ctx = g_new0(QCryptoNettleCAST128, 1);
+            ctx->base.driver = drv;
+            cast5_set_key(&ctx->key, nkey, key);
+
+            return &ctx->base;
         }
 
-        ctx->alg_encrypt_native = cast128_encrypt_native;
-        ctx->alg_decrypt_native = cast128_decrypt_native;
-        ctx->alg_encrypt_wrapper = cast128_encrypt_wrapper;
-        ctx->alg_decrypt_wrapper = cast128_decrypt_wrapper;
-
-        ctx->blocksize = CAST128_BLOCK_SIZE;
-        break;
-
     case QCRYPTO_CIPHER_ALG_SERPENT_128:
     case QCRYPTO_CIPHER_ALG_SERPENT_192:
     case QCRYPTO_CIPHER_ALG_SERPENT_256:
-        ctx->ctx = g_new0(struct serpent_ctx, 1);
+        {
+            QCryptoNettleSerpent *ctx = g_new0(QCryptoNettleSerpent, 1);
 
-        if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-            ctx->ctx_tweak = g_new0(struct serpent_ctx, 1);
+            switch (mode) {
+            case QCRYPTO_CIPHER_MODE_ECB:
+                ctx->base.driver = &qcrypto_nettle_serpent_driver_ecb;
+                break;
+            case QCRYPTO_CIPHER_MODE_CBC:
+                ctx->base.driver = &qcrypto_nettle_serpent_driver_cbc;
+                break;
+            case QCRYPTO_CIPHER_MODE_CTR:
+                ctx->base.driver = &qcrypto_nettle_serpent_driver_ctr;
+                break;
+            case QCRYPTO_CIPHER_MODE_XTS:
+                ctx->base.driver = &qcrypto_nettle_serpent_driver_xts;
+                nkey /= 2;
+                serpent_set_key(&ctx->key_xts, nkey, key + nkey);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            serpent_set_key(&ctx->key, nkey, key);
 
-            nkey /= 2;
-            serpent_set_key(ctx->ctx, nkey, key);
-            serpent_set_key(ctx->ctx_tweak, nkey, key + nkey);
-        } else {
-            serpent_set_key(ctx->ctx, nkey, key);
+            return &ctx->base;
         }
 
-        ctx->alg_encrypt_native = serpent_encrypt_native;
-        ctx->alg_decrypt_native = serpent_decrypt_native;
-        ctx->alg_encrypt_wrapper = serpent_encrypt_wrapper;
-        ctx->alg_decrypt_wrapper = serpent_decrypt_wrapper;
-
-        ctx->blocksize = SERPENT_BLOCK_SIZE;
-        break;
-
     case QCRYPTO_CIPHER_ALG_TWOFISH_128:
     case QCRYPTO_CIPHER_ALG_TWOFISH_192:
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
-        ctx->ctx = g_new0(struct twofish_ctx, 1);
+        {
+            QCryptoNettleTwofish *ctx = g_new0(QCryptoNettleTwofish, 1);
 
-        if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-            ctx->ctx_tweak = g_new0(struct twofish_ctx, 1);
+            switch (mode) {
+            case QCRYPTO_CIPHER_MODE_ECB:
+                ctx->base.driver = &qcrypto_nettle_twofish_driver_ecb;
+                break;
+            case QCRYPTO_CIPHER_MODE_CBC:
+                ctx->base.driver = &qcrypto_nettle_twofish_driver_cbc;
+                break;
+            case QCRYPTO_CIPHER_MODE_CTR:
+                ctx->base.driver = &qcrypto_nettle_twofish_driver_ctr;
+                break;
+            case QCRYPTO_CIPHER_MODE_XTS:
+                ctx->base.driver = &qcrypto_nettle_twofish_driver_xts;
+                nkey /= 2;
+                twofish_set_key(&ctx->key_xts, nkey, key + nkey);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            twofish_set_key(&ctx->key, nkey, key);
 
-            nkey /= 2;
-            twofish_set_key(ctx->ctx, nkey, key);
-            twofish_set_key(ctx->ctx_tweak, nkey, key + nkey);
-        } else {
-            twofish_set_key(ctx->ctx, nkey, key);
+            return &ctx->base;
         }
 
-        ctx->alg_encrypt_native = twofish_encrypt_native;
-        ctx->alg_decrypt_native = twofish_decrypt_native;
-        ctx->alg_encrypt_wrapper = twofish_encrypt_wrapper;
-        ctx->alg_decrypt_wrapper = twofish_decrypt_wrapper;
-
-        ctx->blocksize = TWOFISH_BLOCK_SIZE;
-        break;
-
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
                    QCryptoCipherAlgorithm_str(alg));
-        goto error;
+        return NULL;
     }
-    g_assert(is_power_of_2(ctx->blocksize));
-
-    if (mode == QCRYPTO_CIPHER_MODE_XTS &&
-        ctx->blocksize != XTS_BLOCK_SIZE) {
-        error_setg(errp, "Cipher block size %zu must equal XTS block size %d",
-                   ctx->blocksize, XTS_BLOCK_SIZE);
-        goto error;
-    }
-
-    ctx->iv = g_new0(uint8_t, ctx->blocksize);
-
-    ctx->base.driver = &qcrypto_cipher_lib_driver;
-    return &ctx->base;
-
- error:
-    qcrypto_nettle_cipher_free_ctx(ctx);
-    return NULL;
 }
-
-
-static void
-qcrypto_nettle_cipher_ctx_free(QCryptoCipher *cipher)
-{
-    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
-
-    qcrypto_nettle_cipher_free_ctx(ctx);
-}
-
-
-static int
-qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
-                              const void *in,
-                              void *out,
-                              size_t len,
-                              Error **errp)
-{
-    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
-
-    if (len & (ctx->blocksize - 1)) {
-        error_setg(errp, "Length %zu must be a multiple of block size %zu",
-                   len, ctx->blocksize);
-        return -1;
-    }
-
-    switch (cipher->mode) {
-    case QCRYPTO_CIPHER_MODE_ECB:
-        ctx->alg_encrypt_wrapper(ctx->ctx, len, out, in);
-        break;
-
-    case QCRYPTO_CIPHER_MODE_CBC:
-        cbc_encrypt(ctx->ctx, ctx->alg_encrypt_native,
-                    ctx->blocksize, ctx->iv,
-                    len, out, in);
-        break;
-
-    case QCRYPTO_CIPHER_MODE_XTS:
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-        xts_encrypt(ctx->ctx, ctx->ctx_tweak,
-                    ctx->alg_encrypt_wrapper, ctx->alg_decrypt_wrapper,
-                    ctx->iv, len, out, in);
-#else
-        xts_encrypt_message(ctx->ctx, ctx->ctx_tweak,
-                            ctx->alg_encrypt_native,
-                            ctx->iv, len, out, in);
-#endif
-        break;
-
-    case QCRYPTO_CIPHER_MODE_CTR:
-        ctr_crypt(ctx->ctx, ctx->alg_encrypt_native,
-                    ctx->blocksize, ctx->iv,
-                    len, out, in);
-        break;
-
-    default:
-        error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_str(cipher->mode));
-        return -1;
-    }
-    return 0;
-}
-
-
-static int
-qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
-                              const void *in,
-                              void *out,
-                              size_t len,
-                              Error **errp)
-{
-    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
-
-    if (len & (ctx->blocksize - 1)) {
-        error_setg(errp, "Length %zu must be a multiple of block size %zu",
-                   len, ctx->blocksize);
-        return -1;
-    }
-
-    switch (cipher->mode) {
-    case QCRYPTO_CIPHER_MODE_ECB:
-        ctx->alg_decrypt_wrapper(ctx->ctx, len, out, in);
-        break;
-
-    case QCRYPTO_CIPHER_MODE_CBC:
-        cbc_decrypt(ctx->ctx, ctx->alg_decrypt_native,
-                    ctx->blocksize, ctx->iv,
-                    len, out, in);
-        break;
-
-    case QCRYPTO_CIPHER_MODE_XTS:
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-        xts_decrypt(ctx->ctx, ctx->ctx_tweak,
-                    ctx->alg_encrypt_wrapper, ctx->alg_decrypt_wrapper,
-                    ctx->iv, len, out, in);
-#else
-        xts_decrypt_message(ctx->ctx, ctx->ctx_tweak,
-                            ctx->alg_decrypt_native,
-                            ctx->alg_encrypt_native,
-                            ctx->iv, len, out, in);
-#endif
-        break;
-    case QCRYPTO_CIPHER_MODE_CTR:
-        ctr_crypt(ctx->ctx, ctx->alg_encrypt_native,
-                    ctx->blocksize, ctx->iv,
-                    len, out, in);
-        break;
-
-    default:
-        error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_str(cipher->mode));
-        return -1;
-    }
-    return 0;
-}
-
-static int
-qcrypto_nettle_cipher_setiv(QCryptoCipher *cipher,
-                            const uint8_t *iv, size_t niv,
-                            Error **errp)
-{
-    QCryptoCipherNettle *ctx = container_of(cipher, QCryptoCipherNettle, base);
-
-    if (niv != ctx->blocksize) {
-        error_setg(errp, "Expected IV size %zu not %zu",
-                   ctx->blocksize, niv);
-        return -1;
-    }
-    memcpy(ctx->iv, iv, niv);
-    return 0;
-}
-
-
-static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
-    .cipher_encrypt = qcrypto_nettle_cipher_encrypt,
-    .cipher_decrypt = qcrypto_nettle_cipher_decrypt,
-    .cipher_setiv = qcrypto_nettle_cipher_setiv,
-    .cipher_free = qcrypto_nettle_cipher_ctx_free,
-};
-- 
2.25.1


