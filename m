Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB89C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A024120848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6PerQXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A024120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhtv-00068U-RE
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhom-0003hk-Qd
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:36 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:50418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhok-00031B-Rb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:36 -0400
Received: by mail-pj1-x1041.google.com with SMTP id i13so29592pjv.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HhAhMooMYX4G7bojWisen5XGZe2hgpNyMX5WGu2HwOc=;
 b=G6PerQXWstwmdCPXnwBaX11sraa0ig2nAFNHo2l2N0UkGdzTzFPrgpk4y2bcj4I5y/
 PvfA1Z02eCoYWuxZZboVWxk6SiHgO5DXrGTJLleGklN/BvW4a4gXx8ghkca2CXwqU2l1
 3QW1we7H/XOj7t2d8lu3MH3OtTqEyROjj6vWUNButuoq4YvPZvNevNvTPV8WDc42A/kq
 kk1pYg06iCporVjyHAVE2VYb2t5K4lN1vjNOEQgjWviV3shMCwH1JYmzByrR0l+GYERo
 4A6h2ue5kQMkE087vzWxJfq26jtSw7ucMQvJkkULzuY+fMCIsUaB2R+g5my2HUnzH3AK
 dJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HhAhMooMYX4G7bojWisen5XGZe2hgpNyMX5WGu2HwOc=;
 b=bpZBfisIxLzdvbr0T0e57S+EHdVsfP+adBe9b0NvkKqMQ+0QCLbxvkj2VIcxgtsz5t
 GHT6WJWxLOw5Vrh6bJmhuzsPto0/arZ3unT6XN2v82U166p6yEyLJOR2/zte44SqGiM1
 BA5zS39y7auP66brprVL3UHZS6CST0W17AEF30KKEHTJygzgNNbBDkpsSdTf/7+bVEpX
 gslefyAws8DJVS4Z9bCe8kB0zZnODA/mSs99uDCd1ehvZREB43Q5zJe5js47aoxU+Zxa
 rqfHZa8GqEMYQsm/F8VZri/9H7rQhAmt5jzH2DSkMilLj9ZdrAEbeInx4GZFn6gvjMR1
 uSuw==
X-Gm-Message-State: AOAM531nHgTgjmU0LwJPg5cGlTkmt1qFEejrNIpVzHgZKHY60R07D1iV
 klE3jsrNATH59MI+pbww335d+ZCKvjLkIQ==
X-Google-Smtp-Source: ABdhPJyCjTgj5QF2SYXA9NAO7ptpdCIkPjfUVXa3ZnIcr2xekVv/Fn1YgGE4h/p3XlHordmticFAGg==
X-Received: by 2002:a17:90a:f416:: with SMTP id
 ch22mr11829pjb.232.1598634332949; 
 Fri, 28 Aug 2020 10:05:32 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/16] crypto: Use the correct const type for driver
Date: Fri, 28 Aug 2020 10:05:13 -0700
Message-Id: <20200828170523.418603-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

This allows the in memory structures to be read-only.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipherpriv.h         |  2 +-
 include/crypto/cipher.h     |  2 +-
 crypto/cipher-afalg.c       |  2 +-
 crypto/cipher.c             | 12 ++++++------
 crypto/cipher-builtin.c.inc |  2 +-
 crypto/cipher-gcrypt.c.inc  |  2 +-
 crypto/cipher-nettle.c.inc  |  2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 9228c9fc3a..b73be33bd2 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -47,7 +47,7 @@ qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              const uint8_t *key,
                              size_t nkey, Error **errp);
 
-extern struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
+extern const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
 
 #endif
 
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index 8a42a683a4..cc57179a4d 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -81,7 +81,7 @@ struct QCryptoCipher {
     QCryptoCipherAlgorithm alg;
     QCryptoCipherMode mode;
     void *opaque;
-    void *driver;
+    const QCryptoCipherDriver *driver;
 };
 
 /**
diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
index cd72284690..5c7c44761b 100644
--- a/crypto/cipher-afalg.c
+++ b/crypto/cipher-afalg.c
@@ -218,7 +218,7 @@ static void qcrypto_afalg_comm_ctx_free(QCryptoCipher *cipher)
     qcrypto_afalg_comm_free(cipher->opaque);
 }
 
-struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
+const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
     .cipher_encrypt = qcrypto_afalg_cipher_encrypt,
     .cipher_decrypt = qcrypto_afalg_cipher_decrypt,
     .cipher_setiv = qcrypto_afalg_cipher_setiv,
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 005b5da4de..3ca4a7e662 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -165,7 +165,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
 {
     QCryptoCipher *cipher;
     void *ctx = NULL;
-    QCryptoCipherDriver *drv = NULL;
+    const QCryptoCipherDriver *drv = NULL;
 
 #ifdef CONFIG_AF_ALG
     ctx = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, NULL);
@@ -187,7 +187,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
     cipher->alg = alg;
     cipher->mode = mode;
     cipher->opaque = ctx;
-    cipher->driver = (void *)drv;
+    cipher->driver = drv;
 
     return cipher;
 }
@@ -199,7 +199,7 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
                            size_t len,
                            Error **errp)
 {
-    QCryptoCipherDriver *drv = cipher->driver;
+    const QCryptoCipherDriver *drv = cipher->driver;
     return drv->cipher_encrypt(cipher, in, out, len, errp);
 }
 
@@ -210,7 +210,7 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
                            size_t len,
                            Error **errp)
 {
-    QCryptoCipherDriver *drv = cipher->driver;
+    const QCryptoCipherDriver *drv = cipher->driver;
     return drv->cipher_decrypt(cipher, in, out, len, errp);
 }
 
@@ -219,14 +219,14 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
                          const uint8_t *iv, size_t niv,
                          Error **errp)
 {
-    QCryptoCipherDriver *drv = cipher->driver;
+    const QCryptoCipherDriver *drv = cipher->driver;
     return drv->cipher_setiv(cipher, iv, niv, errp);
 }
 
 
 void qcrypto_cipher_free(QCryptoCipher *cipher)
 {
-    QCryptoCipherDriver *drv;
+    const QCryptoCipherDriver *drv;
     if (cipher) {
         drv = cipher->driver;
         drv->cipher_free(cipher);
diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 56d45b0227..156f32f1c7 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -522,7 +522,7 @@ qcrypto_builtin_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
     .cipher_encrypt = qcrypto_builtin_cipher_encrypt,
     .cipher_decrypt = qcrypto_builtin_cipher_decrypt,
     .cipher_setiv = qcrypto_builtin_cipher_setiv,
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index a62839914b..18850fadb9 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -413,7 +413,7 @@ qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
     .cipher_encrypt = qcrypto_gcrypt_cipher_encrypt,
     .cipher_decrypt = qcrypto_gcrypt_cipher_decrypt,
     .cipher_setiv = qcrypto_gcrypt_cipher_setiv,
diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 0404cfc6da..6ecce5e8ea 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -724,7 +724,7 @@ qcrypto_nettle_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
     .cipher_encrypt = qcrypto_nettle_cipher_encrypt,
     .cipher_decrypt = qcrypto_nettle_cipher_decrypt,
     .cipher_setiv = qcrypto_nettle_cipher_setiv,
-- 
2.25.1


