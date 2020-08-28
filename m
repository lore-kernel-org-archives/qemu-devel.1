Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DBCC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF1620776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZDhrPed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF1620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhr9-0000Xy-Ik
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhp1-0004Kh-96
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:51 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhoy-000381-Na
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:50 -0400
Received: by mail-pl1-x643.google.com with SMTP id c15so787918plq.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6oAAd13GwF/3Te3K0+i8T99RpHAlTgI/+rDnUt7DA9A=;
 b=aZDhrPedvmbMt4La7SABNowNFitHiAKxBVa/W0nKiodr6ADYUz/2pk/DBnszvAxnQ0
 a793gQPcgBTaYe4ZSRy+rly5vRnCPy4XH+KIj3lenGZwZ8J0FijPiWXlFesv2U0JUC3Q
 gipm9XJNH3zjjSB1VaOFM+IF845iuruNB5xVvqVqKib3mstZfskW3dK7nTVHB34Okt/f
 tGb4BWINkJBNd5wsSgZJFC9K4jbgVVr/55svNr66C/g8qUwzP0PPJuviBNSFEyoYUsUf
 hv2hI7PuKvds6tvF7aAg1bM2yWc2XGt3kytno58pgOefQUqoNp71pSHvB/rrzla49MM1
 Be2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6oAAd13GwF/3Te3K0+i8T99RpHAlTgI/+rDnUt7DA9A=;
 b=KtdLlLIGLxYep0Fn9huYZ+YjIL7Rt4SoUmTOhSK7ZB8XkB7l/smYZxxg1woiqSNHfg
 2ca+88l+XxziZZQk0fBT22F7sfS2DEb6j11BijVvm3R9XYcz/8JnUpoteuMXUBZ7U0T4
 daIl+AkQZ1S8rWx3OFbAfjPFL8Xs/gSIGxFAQPAuGq8V2r7JnSTLv+nVZ8rbDvI2w6F1
 uAnW14+3HEBL/TKWqk1duaRvfX7hIdfqXIJ4cBx/fiZzTTVfBiAsDa6LwUnBBaK9DGGN
 yJnQsJTdV6z2LF6+wufyRegFbYVPRI9vMbqQs1E+0Rz6+VAiw5c0Yz6XiEvDT306tI7K
 J+hQ==
X-Gm-Message-State: AOAM530EaLxEC1bI4YFU3jmf65lCKVYKC3baLRBl6JCvg76bUbFrq0iP
 HZTY40GrSChlnzqvk8yTMcRMU6sEMiAuCw==
X-Google-Smtp-Source: ABdhPJzlAiJUnzfzT1GTSZZQ4a+ZiA74TeFxShmtkSgCknuR/CSKaxkdR3Iu31AAAz4zPIfL3h73sQ==
X-Received: by 2002:a17:90a:f691:: with SMTP id cl17mr40474pjb.8.1598634346720; 
 Fri, 28 Aug 2020 10:05:46 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/16] crypto/gcrypt: Split QCryptoCipherGcrypt into
 subclasses
Date: Fri, 28 Aug 2020 10:05:23 -0700
Message-Id: <20200828170523.418603-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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

With gcrypt, most of the dispatch happens in the library,
so there aren't many classes to create.  However, we can
still create separate dispatch for CTR mode, and for
CONFIG_QEMU_PRIVATE_XTS, which avoids needing to check
for these modes at runtime.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-gcrypt.c.inc | 497 ++++++++++++++++++-------------------
 1 file changed, 240 insertions(+), 257 deletions(-)

diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index 7a1fbc9745..42d4137534 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -24,8 +24,6 @@
 
 #include <gcrypt.h>
 
-static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
-
 bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode)
 {
@@ -57,36 +55,212 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
     }
 }
 
-typedef struct QCryptoCipherGcrypt QCryptoCipherGcrypt;
-struct QCryptoCipherGcrypt {
+typedef struct QCryptoCipherGcrypt {
     QCryptoCipher base;
     gcry_cipher_hd_t handle;
     size_t blocksize;
 #ifdef CONFIG_QEMU_PRIVATE_XTS
     gcry_cipher_hd_t tweakhandle;
-    /* Initialization vector or Counter */
-    uint8_t *iv;
+    uint8_t iv[XTS_BLOCK_SIZE];
 #endif
-};
+} QCryptoCipherGcrypt;
 
-static void
-qcrypto_gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
-                               QCryptoCipherMode mode)
+
+static void qcrypto_gcrypt_ctx_free(QCryptoCipher *cipher)
 {
-    if (!ctx) {
-        return;
-    }
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
 
     gcry_cipher_close(ctx->handle);
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-    if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-        gcry_cipher_close(ctx->tweakhandle);
-    }
-    g_free(ctx->iv);
-#endif
     g_free(ctx);
 }
 
+static int qcrypto_gcrypt_encrypt(QCryptoCipher *cipher, const void *in,
+                                  void *out, size_t len, Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+    gcry_error_t err;
+
+    if (len & (ctx->blocksize - 1)) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, ctx->blocksize);
+        return -1;
+    }
+
+    err = gcry_cipher_encrypt(ctx->handle, out, len, in, len);
+    if (err != 0) {
+        error_setg(errp, "Cannot encrypt data: %s", gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+
+static int qcrypto_gcrypt_decrypt(QCryptoCipher *cipher, const void *in,
+                                  void *out, size_t len, Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+    gcry_error_t err;
+
+    if (len & (ctx->blocksize - 1)) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, ctx->blocksize);
+        return -1;
+    }
+
+    err = gcry_cipher_decrypt(ctx->handle, out, len, in, len);
+    if (err != 0) {
+        error_setg(errp, "Cannot decrypt data: %s",
+                   gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int qcrypto_gcrypt_setiv(QCryptoCipher *cipher,
+                                const uint8_t *iv, size_t niv,
+                                Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+    gcry_error_t err;
+
+    if (niv != ctx->blocksize) {
+        error_setg(errp, "Expected IV size %zu not %zu",
+                   ctx->blocksize, niv);
+        return -1;
+    }
+
+    gcry_cipher_reset(ctx->handle);
+    err = gcry_cipher_setiv(ctx->handle, iv, niv);
+    if (err != 0) {
+        error_setg(errp, "Cannot set IV: %s", gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int qcrypto_gcrypt_ctr_setiv(QCryptoCipher *cipher,
+                                    const uint8_t *iv, size_t niv,
+                                    Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+    gcry_error_t err;
+
+    if (niv != ctx->blocksize) {
+        error_setg(errp, "Expected IV size %zu not %zu",
+                   ctx->blocksize, niv);
+        return -1;
+    }
+
+    err = gcry_cipher_setctr(ctx->handle, iv, niv);
+    if (err != 0) {
+        error_setg(errp, "Cannot set Counter: %s", gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+
+static const struct QCryptoCipherDriver qcrypto_gcrypt_driver = {
+    .cipher_encrypt = qcrypto_gcrypt_encrypt,
+    .cipher_decrypt = qcrypto_gcrypt_decrypt,
+    .cipher_setiv = qcrypto_gcrypt_setiv,
+    .cipher_free = qcrypto_gcrypt_ctx_free,
+};
+
+static const struct QCryptoCipherDriver qcrypto_gcrypt_ctr_driver = {
+    .cipher_encrypt = qcrypto_gcrypt_encrypt,
+    .cipher_decrypt = qcrypto_gcrypt_decrypt,
+    .cipher_setiv = qcrypto_gcrypt_ctr_setiv,
+    .cipher_free = qcrypto_gcrypt_ctx_free,
+};
+
+#ifdef CONFIG_QEMU_PRIVATE_XTS
+static void qcrypto_gcrypt_xts_ctx_free(QCryptoCipher *cipher)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+
+    gcry_cipher_close(ctx->tweakhandle);
+    qcrypto_gcrypt_ctx_free(cipher);
+}
+
+static void qcrypto_gcrypt_xts_wrape(const void *ctx, size_t length,
+                                     uint8_t *dst, const uint8_t *src)
+{
+    gcry_error_t err;
+    err = gcry_cipher_encrypt((gcry_cipher_hd_t)ctx, dst, length, src, length);
+    g_assert(err == 0);
+}
+
+static void qcrypto_gcrypt_xts_wrapd(const void *ctx, size_t length,
+                                     uint8_t *dst, const uint8_t *src)
+{
+    gcry_error_t err;
+    err = gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src, length);
+    g_assert(err == 0);
+}
+
+static int qcrypto_gcrypt_xts_encrypt(QCryptoCipher *cipher, const void *in,
+                                      void *out, size_t len, Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+
+    if (len & (ctx->blocksize - 1)) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, ctx->blocksize);
+        return -1;
+    }
+
+    xts_encrypt(ctx->handle, ctx->tweakhandle,
+                qcrypto_gcrypt_xts_wrape, qcrypto_gcrypt_xts_wrapd,
+                ctx->iv, len, out, in);
+    return 0;
+}
+
+static int qcrypto_gcrypt_xts_decrypt(QCryptoCipher *cipher, const void *in,
+                                      void *out, size_t len, Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+
+    if (len & (ctx->blocksize - 1)) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, ctx->blocksize);
+        return -1;
+    }
+
+    xts_decrypt(ctx->handle, ctx->tweakhandle,
+                qcrypto_gcrypt_xts_wrape, qcrypto_gcrypt_xts_wrapd,
+                ctx->iv, len, out, in);
+    return 0;
+}
+
+static int qcrypto_gcrypt_xts_setiv(QCryptoCipher *cipher,
+                                    const uint8_t *iv, size_t niv,
+                                    Error **errp)
+{
+    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
+
+    if (niv != ctx->blocksize) {
+        error_setg(errp, "Expected IV size %zu not %zu",
+                   ctx->blocksize, niv);
+        return -1;
+    }
+
+    memcpy(ctx->iv, iv, niv);
+    return 0;
+}
+
+static const struct QCryptoCipherDriver qcrypto_gcrypt_xts_driver = {
+    .cipher_encrypt = qcrypto_gcrypt_xts_encrypt,
+    .cipher_decrypt = qcrypto_gcrypt_xts_decrypt,
+    .cipher_setiv = qcrypto_gcrypt_xts_setiv,
+    .cipher_free = qcrypto_gcrypt_xts_ctx_free,
+};
+#endif /* CONFIG_QEMU_PRIVATE_XTS */
+
 
 static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                                              QCryptoCipherMode mode,
@@ -95,32 +269,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                                              Error **errp)
 {
     QCryptoCipherGcrypt *ctx;
+    const QCryptoCipherDriver *drv;
     gcry_error_t err;
     int gcryalg, gcrymode;
 
-    switch (mode) {
-    case QCRYPTO_CIPHER_MODE_ECB:
-        gcrymode = GCRY_CIPHER_MODE_ECB;
-        break;
-    case QCRYPTO_CIPHER_MODE_XTS:
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-        gcrymode = GCRY_CIPHER_MODE_ECB;
-#else
-        gcrymode = GCRY_CIPHER_MODE_XTS;
-#endif
-        break;
-    case QCRYPTO_CIPHER_MODE_CBC:
-        gcrymode = GCRY_CIPHER_MODE_CBC;
-        break;
-    case QCRYPTO_CIPHER_MODE_CTR:
-        gcrymode = GCRY_CIPHER_MODE_CTR;
-        break;
-    default:
-        error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_str(mode));
-        return NULL;
-    }
-
     if (!qcrypto_cipher_validate_key_length(alg, mode, nkey, errp)) {
         return NULL;
     }
@@ -129,54 +281,70 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_ALG_DES_RFB:
         gcryalg = GCRY_CIPHER_DES;
         break;
-
     case QCRYPTO_CIPHER_ALG_3DES:
         gcryalg = GCRY_CIPHER_3DES;
         break;
-
     case QCRYPTO_CIPHER_ALG_AES_128:
         gcryalg = GCRY_CIPHER_AES128;
         break;
-
     case QCRYPTO_CIPHER_ALG_AES_192:
         gcryalg = GCRY_CIPHER_AES192;
         break;
-
     case QCRYPTO_CIPHER_ALG_AES_256:
         gcryalg = GCRY_CIPHER_AES256;
         break;
-
     case QCRYPTO_CIPHER_ALG_CAST5_128:
         gcryalg = GCRY_CIPHER_CAST5;
         break;
-
     case QCRYPTO_CIPHER_ALG_SERPENT_128:
         gcryalg = GCRY_CIPHER_SERPENT128;
         break;
-
     case QCRYPTO_CIPHER_ALG_SERPENT_192:
         gcryalg = GCRY_CIPHER_SERPENT192;
         break;
-
     case QCRYPTO_CIPHER_ALG_SERPENT_256:
         gcryalg = GCRY_CIPHER_SERPENT256;
         break;
-
     case QCRYPTO_CIPHER_ALG_TWOFISH_128:
         gcryalg = GCRY_CIPHER_TWOFISH128;
         break;
-
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
         gcryalg = GCRY_CIPHER_TWOFISH;
         break;
-
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
                    QCryptoCipherAlgorithm_str(alg));
         return NULL;
     }
 
+    drv = &qcrypto_gcrypt_driver;
+    switch (mode) {
+    case QCRYPTO_CIPHER_MODE_ECB:
+        gcrymode = GCRY_CIPHER_MODE_ECB;
+        break;
+    case QCRYPTO_CIPHER_MODE_XTS:
+#ifdef CONFIG_QEMU_PRIVATE_XTS
+        drv = &qcrypto_gcrypt_xts_driver;
+        gcrymode = GCRY_CIPHER_MODE_ECB;
+#else
+        gcrymode = GCRY_CIPHER_MODE_XTS;
+#endif
+        break;
+    case QCRYPTO_CIPHER_MODE_CBC:
+        gcrymode = GCRY_CIPHER_MODE_CBC;
+        break;
+    case QCRYPTO_CIPHER_MODE_CTR:
+        drv = &qcrypto_gcrypt_ctr_driver;
+        gcrymode = GCRY_CIPHER_MODE_CTR;
+        break;
+    default:
+        error_setg(errp, "Unsupported cipher mode %s",
+                   QCryptoCipherMode_str(mode));
+        return NULL;
+    }
+
     ctx = g_new0(QCryptoCipherGcrypt, 1);
+    ctx->base.driver = drv;
 
     err = gcry_cipher_open(&ctx->handle, gcryalg, gcrymode, 0);
     if (err != 0) {
@@ -184,8 +352,16 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                    gcry_strerror(err));
         goto error;
     }
+    ctx->blocksize = gcry_cipher_get_algo_blklen(gcryalg);
+
 #ifdef CONFIG_QEMU_PRIVATE_XTS
     if (mode == QCRYPTO_CIPHER_MODE_XTS) {
+        if (ctx->blocksize != XTS_BLOCK_SIZE) {
+            error_setg(errp,
+                       "Cipher block size %zu must equal XTS block size %d",
+		       ctx->blocksize, XTS_BLOCK_SIZE);
+            goto error;
+        }
         err = gcry_cipher_open(&ctx->tweakhandle, gcryalg, gcrymode, 0);
         if (err != 0) {
             error_setg(errp, "Cannot initialize cipher: %s",
@@ -203,224 +379,31 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
         uint8_t *rfbkey = qcrypto_cipher_munge_des_rfb_key(key, nkey);
         err = gcry_cipher_setkey(ctx->handle, rfbkey, nkey);
         g_free(rfbkey);
-        ctx->blocksize = 8;
     } else {
 #ifdef CONFIG_QEMU_PRIVATE_XTS
         if (mode == QCRYPTO_CIPHER_MODE_XTS) {
             nkey /= 2;
-            err = gcry_cipher_setkey(ctx->handle, key, nkey);
+            err = gcry_cipher_setkey(ctx->tweakhandle, key + nkey, nkey);
             if (err != 0) {
-                error_setg(errp, "Cannot set key: %s",
-                           gcry_strerror(err));
+                error_setg(errp, "Cannot set key: %s", gcry_strerror(err));
                 goto error;
             }
-            err = gcry_cipher_setkey(ctx->tweakhandle, key + nkey, nkey);
-        } else {
-#endif
-            err = gcry_cipher_setkey(ctx->handle, key, nkey);
-#ifdef CONFIG_QEMU_PRIVATE_XTS
         }
 #endif
-        if (err != 0) {
-            error_setg(errp, "Cannot set key: %s",
-                       gcry_strerror(err));
-            goto error;
-        }
-        switch (alg) {
-        case QCRYPTO_CIPHER_ALG_AES_128:
-        case QCRYPTO_CIPHER_ALG_AES_192:
-        case QCRYPTO_CIPHER_ALG_AES_256:
-        case QCRYPTO_CIPHER_ALG_SERPENT_128:
-        case QCRYPTO_CIPHER_ALG_SERPENT_192:
-        case QCRYPTO_CIPHER_ALG_SERPENT_256:
-        case QCRYPTO_CIPHER_ALG_TWOFISH_128:
-        case QCRYPTO_CIPHER_ALG_TWOFISH_256:
-            ctx->blocksize = 16;
-            break;
-        case QCRYPTO_CIPHER_ALG_3DES:
-        case QCRYPTO_CIPHER_ALG_CAST5_128:
-            ctx->blocksize = 8;
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        err = gcry_cipher_setkey(ctx->handle, key, nkey);
     }
-    g_assert(is_power_of_2(ctx->blocksize));
-
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-    if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-        if (ctx->blocksize != XTS_BLOCK_SIZE) {
-            error_setg(errp,
-                       "Cipher block size %zu must equal XTS block size %d",
-                       ctx->blocksize, XTS_BLOCK_SIZE);
-            goto error;
-        }
-        ctx->iv = g_new0(uint8_t, ctx->blocksize);
+    if (err != 0) {
+        error_setg(errp, "Cannot set key: %s", gcry_strerror(err));
+        goto error;
     }
-#endif
 
-    ctx->base.driver = &qcrypto_cipher_lib_driver;
     return &ctx->base;
 
  error:
-    qcrypto_gcrypt_cipher_free_ctx(ctx, mode);
+#ifdef CONFIG_QEMU_PRIVATE_XTS
+    gcry_cipher_close(ctx->tweakhandle);
+#endif
+    gcry_cipher_close(ctx->handle);
+    g_free(ctx);
     return NULL;
 }
-
-
-static void
-qcrypto_gcrypt_cipher_ctx_free(QCryptoCipher *cipher)
-{
-    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
-
-    qcrypto_gcrypt_cipher_free_ctx(ctx, cipher->mode);
-}
-
-
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-static void qcrypto_gcrypt_xts_encrypt(const void *ctx,
-                                       size_t length,
-                                       uint8_t *dst,
-                                       const uint8_t *src)
-{
-    gcry_error_t err;
-    err = gcry_cipher_encrypt((gcry_cipher_hd_t)ctx, dst, length, src, length);
-    g_assert(err == 0);
-}
-
-static void qcrypto_gcrypt_xts_decrypt(const void *ctx,
-                                       size_t length,
-                                       uint8_t *dst,
-                                       const uint8_t *src)
-{
-    gcry_error_t err;
-    err = gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src, length);
-    g_assert(err == 0);
-}
-#endif
-
-static int
-qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
-                              const void *in,
-                              void *out,
-                              size_t len,
-                              Error **errp)
-{
-    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
-    gcry_error_t err;
-
-    if (len & (ctx->blocksize - 1)) {
-        error_setg(errp, "Length %zu must be a multiple of block size %zu",
-                   len, ctx->blocksize);
-        return -1;
-    }
-
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
-        xts_encrypt(ctx->handle, ctx->tweakhandle,
-                    qcrypto_gcrypt_xts_encrypt,
-                    qcrypto_gcrypt_xts_decrypt,
-                    ctx->iv, len, out, in);
-        return 0;
-    }
-#endif
-
-    err = gcry_cipher_encrypt(ctx->handle,
-                              out, len,
-                              in, len);
-    if (err != 0) {
-        error_setg(errp, "Cannot encrypt data: %s",
-                   gcry_strerror(err));
-        return -1;
-    }
-
-    return 0;
-}
-
-
-static int
-qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *cipher,
-                              const void *in,
-                              void *out,
-                              size_t len,
-                              Error **errp)
-{
-    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
-    gcry_error_t err;
-
-    if (len & (ctx->blocksize - 1)) {
-        error_setg(errp, "Length %zu must be a multiple of block size %zu",
-                   len, ctx->blocksize);
-        return -1;
-    }
-
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
-        xts_decrypt(ctx->handle, ctx->tweakhandle,
-                    qcrypto_gcrypt_xts_encrypt,
-                    qcrypto_gcrypt_xts_decrypt,
-                    ctx->iv, len, out, in);
-        return 0;
-    }
-#endif
-
-    err = gcry_cipher_decrypt(ctx->handle,
-                              out, len,
-                              in, len);
-    if (err != 0) {
-        error_setg(errp, "Cannot decrypt data: %s",
-                   gcry_strerror(err));
-        return -1;
-    }
-
-    return 0;
-}
-
-static int
-qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
-                            const uint8_t *iv, size_t niv,
-                            Error **errp)
-{
-    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
-    gcry_error_t err;
-
-    if (niv != ctx->blocksize) {
-        error_setg(errp, "Expected IV size %zu not %zu",
-                   ctx->blocksize, niv);
-        return -1;
-    }
-
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-    if (ctx->iv) {
-        memcpy(ctx->iv, iv, niv);
-        return 0;
-    }
-#endif
-
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_CTR) {
-        err = gcry_cipher_setctr(ctx->handle, iv, niv);
-        if (err != 0) {
-            error_setg(errp, "Cannot set Counter: %s",
-                       gcry_strerror(err));
-            return -1;
-        }
-    } else {
-        gcry_cipher_reset(ctx->handle);
-        err = gcry_cipher_setiv(ctx->handle, iv, niv);
-        if (err != 0) {
-            error_setg(errp, "Cannot set IV: %s",
-                       gcry_strerror(err));
-            return -1;
-        }
-    }
-
-    return 0;
-}
-
-
-static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
-    .cipher_encrypt = qcrypto_gcrypt_cipher_encrypt,
-    .cipher_decrypt = qcrypto_gcrypt_cipher_decrypt,
-    .cipher_setiv = qcrypto_gcrypt_cipher_setiv,
-    .cipher_free = qcrypto_gcrypt_cipher_ctx_free,
-};
-- 
2.25.1


