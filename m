Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77090C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40457206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZU27wAbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40457206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63vY-0002IR-FD
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sJ-00053P-SV
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:55 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:50822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sI-00009X-0D
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:55 -0400
Received: by mail-pj1-x102f.google.com with SMTP id e4so2119511pjd.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nOP/WB4f5EOc+9iMNgr1GvARoRc8y3IjDCJ8RShT+rk=;
 b=ZU27wAbV9bFAD3vOJnqL/otthlPiL6zh0mPvAV8aZr4CpRznmH0NZlR4ER1nnURy9Q
 YTrHXfW46dK+iw43XtdsWd6amV2neT690U0sZsITBByGi9ieCijEoXz98+5aLhnEKr5/
 XCg9a6pFV1E0VS6BOQ+efHMPD7cNOWwZXqHIqIoYF05MuBuyMUYcYU48z0I0T/ssS1iS
 E53ycr+yfmngcwGTcCLIwY4uGcdc1M/2S1jiflFNSH384Od0nkAx+BW96kJbNzWW0o+4
 qC1ILEvhpZeY5rwo9UuL/tStNPgLpwraHMn5xDpeJpGSmg8veoHsgUfVuInsDkn37pek
 gRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nOP/WB4f5EOc+9iMNgr1GvARoRc8y3IjDCJ8RShT+rk=;
 b=InPQaICtb818wHpYVSZ4H8iDl7S7Sjgm/VLhCvb5ZxI2WEg/u+utajKlM6doJbvdHr
 57pVUi6pMgszb6Jt4oHoOK/G20WZ1QP2jsaYEos1dell5QofLRnT6agcIC+9ITVDA/k/
 ESh4tFg/naH0CFpIq4L1aGaM/uSusvmTAHGt8tKlkZKFOm8kXDejnY9gTsoY2EuKw23L
 ziN+EBhyGGD2HIsFclQerzzvXt13UvN9alN/tlRxFMNNYupuduynr2SsRNWcn/zxI1UG
 JvC5HzQbCEuXZVh6r0Y0RLgrwG8BapxDO2xjQypOJ4BrhHkl861ERmba/Ar5J74UIG/C
 3/Ng==
X-Gm-Message-State: AOAM5333DblMeg0tFtcTYaeMaIWZZO8oOO5XStYon3eEcMWJGsBr3WnF
 NNpIqhoyqPR38sfLwbfjtxgWMTH3P+U=
X-Google-Smtp-Source: ABdhPJzfAdGTY+sKFAd/gx0f2dDyOojI7UWMLl9+7hPeWalKVfTBZOyZSeSME4Jnom5EnfCTjKjQ9w==
X-Received: by 2002:a17:90a:eac9:: with SMTP id
 ev9mr3008655pjb.106.1597289152307; 
 Wed, 12 Aug 2020 20:25:52 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/17] crypto: Move cipher->driver init to
 qcrypto_*_cipher_ctx_new
Date: Wed, 12 Aug 2020 20:25:29 -0700
Message-Id: <20200813032537.2888593-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

The class vtable should be set by the class initializer.
This will also allow additional subclassing, reducing the
amount of indirection in the hierarchy.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipherpriv.h         | 2 --
 crypto/cipher-afalg.c       | 5 ++++-
 crypto/cipher-builtin.inc.c | 4 ++++
 crypto/cipher-gcrypt.inc.c  | 2 ++
 crypto/cipher-nettle.inc.c  | 3 +++
 crypto/cipher.c             | 7 -------
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 437b109b5e..396527857d 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -47,8 +47,6 @@ qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              const uint8_t *key,
                              size_t nkey, Error **errp);
 
-extern const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
-
 #endif
 
 #endif
diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
index 86e5249bd6..052355a8a9 100644
--- a/crypto/cipher-afalg.c
+++ b/crypto/cipher-afalg.c
@@ -58,6 +58,8 @@ qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm alg,
     return name;
 }
 
+static const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
+
 QCryptoCipher *
 qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode,
@@ -109,6 +111,7 @@ qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     }
     afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
 
+    afalg->base.driver = &qcrypto_cipher_afalg_driver;
     return &afalg->base;
 }
 
@@ -222,7 +225,7 @@ static void qcrypto_afalg_comm_ctx_free(QCryptoCipher *cipher)
     qcrypto_afalg_comm_free(afalg);
 }
 
-const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
+static const struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
     .cipher_encrypt = qcrypto_afalg_cipher_encrypt,
     .cipher_decrypt = qcrypto_afalg_cipher_decrypt,
     .cipher_setiv = qcrypto_afalg_cipher_setiv,
diff --git a/crypto/cipher-builtin.inc.c b/crypto/cipher-builtin.inc.c
index 6a03e23040..1444139f36 100644
--- a/crypto/cipher-builtin.inc.c
+++ b/crypto/cipher-builtin.inc.c
@@ -22,6 +22,8 @@
 #include "crypto/desrfb.h"
 #include "crypto/xts.h"
 
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
+
 typedef struct QCryptoCipherBuiltinAESContext QCryptoCipherBuiltinAESContext;
 struct QCryptoCipherBuiltinAESContext {
     AES_KEY enc;
@@ -292,6 +294,7 @@ qcrypto_cipher_init_aes(QCryptoCipherMode mode,
     ctxt->encrypt = qcrypto_cipher_encrypt_aes;
     ctxt->decrypt = qcrypto_cipher_decrypt_aes;
 
+    ctxt->base.driver = &qcrypto_cipher_lib_driver;
     return &ctxt->base;
 
  error:
@@ -396,6 +399,7 @@ qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
     ctxt->encrypt = qcrypto_cipher_encrypt_des_rfb;
     ctxt->decrypt = qcrypto_cipher_decrypt_des_rfb;
 
+    ctxt->base.driver = &qcrypto_cipher_lib_driver;
     return &ctxt->base;
 }
 
diff --git a/crypto/cipher-gcrypt.inc.c b/crypto/cipher-gcrypt.inc.c
index 3b3c85e265..7a1fbc9745 100644
--- a/crypto/cipher-gcrypt.inc.c
+++ b/crypto/cipher-gcrypt.inc.c
@@ -24,6 +24,7 @@
 
 #include <gcrypt.h>
 
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
 
 bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode)
@@ -258,6 +259,7 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     }
 #endif
 
+    ctx->base.driver = &qcrypto_cipher_lib_driver;
     return &ctx->base;
 
  error:
diff --git a/crypto/cipher-nettle.inc.c b/crypto/cipher-nettle.inc.c
index d8371d1f37..36d57ef430 100644
--- a/crypto/cipher-nettle.inc.c
+++ b/crypto/cipher-nettle.inc.c
@@ -34,6 +34,8 @@
 #include <nettle/xts.h>
 #endif
 
+static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
+
 typedef void (*QCryptoCipherNettleFuncWrapper)(const void *ctx,
                                                size_t length,
                                                uint8_t *dst,
@@ -587,6 +589,7 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 
     ctx->iv = g_new0(uint8_t, ctx->blocksize);
 
+    ctx->base.driver = &qcrypto_cipher_lib_driver;
     return &ctx->base;
 
  error:
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 6ea75bb764..6e25f68f5c 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -164,13 +164,9 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
                                   Error **errp)
 {
     QCryptoCipher *cipher = NULL;
-    const QCryptoCipherDriver *drv = NULL;
 
 #ifdef CONFIG_AF_ALG
     cipher = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, NULL);
-    if (cipher) {
-        drv = &qcrypto_cipher_afalg_driver;
-    }
 #endif
 
     if (!cipher) {
@@ -178,13 +174,10 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         if (!cipher) {
             return NULL;
         }
-
-        drv = &qcrypto_cipher_lib_driver;
     }
 
     cipher->alg = alg;
     cipher->mode = mode;
-    cipher->driver = drv;
 
     return cipher;
 }
-- 
2.25.1


