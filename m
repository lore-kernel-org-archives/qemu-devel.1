Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB167C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9E320715
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWnQX6+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9E320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k642W-0003B7-U8
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sV-0005RF-QN
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:26:08 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:34021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sR-0000Aj-LC
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:26:07 -0400
Received: by mail-pj1-x1043.google.com with SMTP id c10so3674168pjn.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WapXvFLvjsW5WLq7o3+vGvs0T+qx/dbyDx6c37+3X6A=;
 b=ZWnQX6+Unu4KSIOy+asNs+nbpkhsIIy6ZioFIYiECiQ/F2367mEXcPCydfZ7WUcVrH
 YkmLceLBz5YgPymvve+d81m4aW2NAMdf1G42m9l5J68RdCpFKJVEZeLjHGmmkmbUT7Ob
 z02oNyY9XwpNy+rRMpvcATKenX00OvzWxS6zJW/6AH+vdNCmNo+YC/uU2RaVk3fIg2ED
 MYmeqtDUm2UDYCPqu37W/gjqWob/StAcMY8ye7E9pq8kmpsk4D7Yw2DFswDPU3vSCCjj
 Wcsg+T8em/L3tRQozxHImYd6GMADHiuV5nRl0cee9CQ7LaKXTBJaHQsrZi8g5lUmkOLe
 O3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WapXvFLvjsW5WLq7o3+vGvs0T+qx/dbyDx6c37+3X6A=;
 b=WwYa7ErbezAQJDHbYRPR4JadzRJAkI88n8Sea9FtBPnubmtxHjVxHCcjYs4/D5nujk
 2jCh36x9Vn/22NbNtA1wSsvUGFUJFp2Ii211/nSLJ0edmuoMg42871j3jzOyJrAu0ko/
 lJPkF3HoomWwLZzyXwbbO4YgFIdNBz+rYpgiWrbk0338Te49ZhBDmVqr7q8k/dgdhtmi
 lnD++KkV2o6oJ2MMO3Ust/srIVryy8iiyyqtUBFw5Ruoo+QNWb/etF+WOj+f45EbDj+2
 5gJiME5CAhIUaPey2IaPTll1S6aloNO7qVBc81R2vB/ubGnYoYsgd70Wkcl9u2OfwOk4
 qZ8Q==
X-Gm-Message-State: AOAM531jbfPtIXJ2IpZqruQ/ypyFMoVCM0O3HEgOTbHPa4P4I1pDVScw
 hJ/4cQS9dIXMoeJ1iZu9T19mZpk/pno=
X-Google-Smtp-Source: ABdhPJwNjsU+uthOFCrImgeWUNKV//LE0yVhL+F1NjsaJkZl6s2iAcZEU1jJsvQIH0cFWZwVWTjIzQ==
X-Received: by 2002:a17:902:a714:: with SMTP id
 w20mr2218553plq.8.1597289161730; 
 Wed, 12 Aug 2020 20:26:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:26:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/17] crypto/gcrypt: Split QCryptoCipherGcrypt into subclasses
Date: Wed, 12 Aug 2020 20:25:37 -0700
Message-Id: <20200813032537.2888593-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
 crypto/cipher-gcrypt.inc.c | 512 ++++++++++++++++++-------------------
 1 file changed, 250 insertions(+), 262 deletions(-)

diff --git a/crypto/cipher-gcrypt.inc.c b/crypto/cipher-gcrypt.inc.c
index 7a1fbc9745..1f9d08a7fa 100644
--- a/crypto/cipher-gcrypt.inc.c
+++ b/crypto/cipher-gcrypt.inc.c
@@ -24,8 +24,6 @@
 
 #include <gcrypt.h>
 
-static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
-
 bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode)
 {
@@ -57,36 +55,215 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
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
+    gcry_error_t err;
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
+    gcry_error_t err;
+
+    if (len & (ctx->blocksize - 1)) {
+        error_setg(errp, "Length %zu must be a multiple of block size %zu",
+                   len, ctx->blocksize);
+        return -1;
+    }
+
+    xts_decrypt(ctx->handle, ctx->tweakhandle,
+                qcrypto_gcrypt_xts_encrypt, qcrypto_gcrypt_xts_decrypt,
+                ctx->iv, len, out, in);
+    return 0;
+}
+
+static int qcrypto_gcrypt_xts_setiv(QCryptoCipher *cipher,
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
@@ -95,32 +272,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
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
@@ -129,68 +284,92 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
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
         error_setg(errp, "Cannot initialize cipher: %s",
                    gcry_strerror(err));
-        goto error;
+        goto error1;
     }
+    ctx->blocksize = gcry_cipher_get_algo_blklen(gcryalg);
+
 #ifdef CONFIG_QEMU_PRIVATE_XTS
     if (mode == QCRYPTO_CIPHER_MODE_XTS) {
+        if (ctx->blocksize != XTS_BLOCK_SIZE) {
+            error_setg(errp,
+                       "Cipher block size %zu must equal XTS block size %d",
+                       blocksize, XTS_BLOCK_SIZE);
+            goto error2;
+        }
         err = gcry_cipher_open(&ctx->tweakhandle, gcryalg, gcrymode, 0);
         if (err != 0) {
             error_setg(errp, "Cannot initialize cipher: %s",
                        gcry_strerror(err));
-            goto error;
+            goto error2;
         }
     }
 #endif
@@ -203,224 +382,33 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
         uint8_t *rfbkey = qcrypto_cipher_munge_des_rfb_key(key, nkey);
         err = gcry_cipher_setkey(ctx->handle, rfbkey, nkey);
         g_free(rfbkey);
-        ctx->blocksize = 8;
     } else {
 #ifdef CONFIG_QEMU_PRIVATE_XTS
         if (mode == QCRYPTO_CIPHER_MODE_XTS) {
             nkey /= 2;
-            err = gcry_cipher_setkey(ctx->handle, key, nkey);
-            if (err != 0) {
-                error_setg(errp, "Cannot set key: %s",
-                           gcry_strerror(err));
-                goto error;
-            }
             err = gcry_cipher_setkey(ctx->tweakhandle, key + nkey, nkey);
-        } else {
-#endif
-            err = gcry_cipher_setkey(ctx->handle, key, nkey);
-#ifdef CONFIG_QEMU_PRIVATE_XTS
+            if (err != 0) {
+                error_setg(errp, "Cannot set key: %s", gcry_strerror(err));
+                goto error3;
+            }
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
+        goto error3;
     }
-#endif
 
-    ctx->base.driver = &qcrypto_cipher_lib_driver;
     return &ctx->base;
 
- error:
-    qcrypto_gcrypt_cipher_free_ctx(ctx, mode);
+ error3:
+#ifdef CONFIG_QEMU_PRIVATE_XTS
+    gcry_cipher_close(ctx->tweakhandle);
+ error2:
+#endif
+    gcry_cipher_close(ctx->handle);
+ error1:
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


