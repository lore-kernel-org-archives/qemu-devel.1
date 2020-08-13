Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ECFC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D38A20715
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z34Qg9RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D38A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6417-0001De-Ni
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sG-0004wk-UD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:52 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sF-00008K-1I
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:52 -0400
Received: by mail-pl1-x641.google.com with SMTP id f10so2006232plj.8
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b5OUwYC1ijM0U3q76fWa5pbJW4qjaynWy6iI0RpDBZA=;
 b=Z34Qg9RJYkEGdiY8XgVqi5Rc5YXJmKhvp33kAxFpafyAZJcer9i6qQqe5bkcdo1123
 wmcEValt0eaYNOsBVIPqFDALa7qXq8tCmde4lsGeALatZ4PgBJy83EpjMuTqugHAzZs9
 EyOE7fz5CzRPvpLAeADS/lnTqHYuQANFitytZxK2BCQMuQhy1UezCPrO6/zkXKEZkBiv
 9VIsXEIlKKsgC4M6AaLZ2dbff7QgakTa0rPqoSSG94yh8nuzbLlrGGB8TJsPPP2HjngJ
 RovYJHOMWgweqgiTIABSk8EF7F+ufVXFLkkgNPSr9z+Xf1GpVlXE5aDfjD658YQh5JJR
 kfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b5OUwYC1ijM0U3q76fWa5pbJW4qjaynWy6iI0RpDBZA=;
 b=RJspRT5JKqytaFqqLHVq3PNMTxLANOFDl3R9/nrSIOu1Eksn3YC2RankJcArtf/+S4
 7G6Sc2QlUpqHqUoZu6kTyCxWC6vzfOlhHq1sYS82GnCO09afc+56Bpb9/dNcgz6eflRS
 J5cAOTo2B0n7Chqi+tOfkaV6Y4jwS3EXgg3s0jmhpLchFTPneECSIlbRU+LniIdl52so
 p6RFLekBTJuO2br6nUmlMgecUuKyshl/a+7UDwoUoJ5ZDBuK8NScRiaVLhmCilW9a7/0
 thDRtjTaXyHXMqKdjSh9NY4lBBLQwsuZcyootM2RR4v9OLDZ3ZmoM04sc5q3foDYhl/V
 eCGw==
X-Gm-Message-State: AOAM531CYB/xZeNPi3Igl1Dt1azq2i3Um1vSvloUG8u02i2Oxm2wfmiL
 3LKRjwQAlc35sNo1XPjOMTOfu9cc1SA=
X-Google-Smtp-Source: ABdhPJzuHGa0z3arZXNJig3fOWPpx3+RTFygPAJRvnWCWHs5P7lR0LvNILzq8WPOmnL127nbPkyhXw==
X-Received: by 2002:a17:90b:784:: with SMTP id l4mr2813640pjz.96.1597289149308; 
 Wed, 12 Aug 2020 20:25:49 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/17] crypto: Use the correct const type for driver
Date: Wed, 12 Aug 2020 20:25:27 -0700
Message-Id: <20200813032537.2888593-8-richard.henderson@linaro.org>
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

This allows the in memory structures to be read-only.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipherpriv.h         |  2 +-
 include/crypto/cipher.h     |  2 +-
 crypto/cipher-afalg.c       |  2 +-
 crypto/cipher-builtin.inc.c |  2 +-
 crypto/cipher-gcrypt.inc.c  |  2 +-
 crypto/cipher-nettle.inc.c  |  2 +-
 crypto/cipher.c             | 12 ++++++------
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
index 95a0412911..022a8d1157 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -78,7 +78,7 @@ struct QCryptoCipher {
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
diff --git a/crypto/cipher-builtin.inc.c b/crypto/cipher-builtin.inc.c
index 56d45b0227..156f32f1c7 100644
--- a/crypto/cipher-builtin.inc.c
+++ b/crypto/cipher-builtin.inc.c
@@ -522,7 +522,7 @@ qcrypto_builtin_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
     .cipher_encrypt = qcrypto_builtin_cipher_encrypt,
     .cipher_decrypt = qcrypto_builtin_cipher_decrypt,
     .cipher_setiv = qcrypto_builtin_cipher_setiv,
diff --git a/crypto/cipher-gcrypt.inc.c b/crypto/cipher-gcrypt.inc.c
index a62839914b..18850fadb9 100644
--- a/crypto/cipher-gcrypt.inc.c
+++ b/crypto/cipher-gcrypt.inc.c
@@ -413,7 +413,7 @@ qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
     .cipher_encrypt = qcrypto_gcrypt_cipher_encrypt,
     .cipher_decrypt = qcrypto_gcrypt_cipher_decrypt,
     .cipher_setiv = qcrypto_gcrypt_cipher_setiv,
diff --git a/crypto/cipher-nettle.inc.c b/crypto/cipher-nettle.inc.c
index 0404cfc6da..6ecce5e8ea 100644
--- a/crypto/cipher-nettle.inc.c
+++ b/crypto/cipher-nettle.inc.c
@@ -724,7 +724,7 @@ qcrypto_nettle_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
     .cipher_encrypt = qcrypto_nettle_cipher_encrypt,
     .cipher_decrypt = qcrypto_nettle_cipher_decrypt,
     .cipher_setiv = qcrypto_nettle_cipher_setiv,
diff --git a/crypto/cipher.c b/crypto/cipher.c
index deae82c264..d3ef856009 100644
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
-- 
2.25.1


