Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EE7C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED7C20776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfX+UpRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED7C20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhqw-000075-S5
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhop-0003nO-52
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:39 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:35339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhon-00031j-9X
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:38 -0400
Received: by mail-pf1-x431.google.com with SMTP id o68so954231pfg.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eBk+GrbH5UnrDm8FHWFaBbZjN/qoNANGe98dIeav8qI=;
 b=DfX+UpRuPgzZzEI+ypg6EHr6Ta3dP4juFUvEgDsY1xLS1HCF0Kxeam9Bgxy1rbkGDO
 LIO/i2nd4D/WopXTp5CCNfSTuIzzgL702owFH3FKbYRjQ5Y4gWnp5/wR/sC7uq9KQGGs
 21fGA8P23CDSypaOdMCJmpRFWjs0Nzg7+BaISO0QgrZQoYljP9xbATIJbjA4Sw7pbMQw
 S6n7yumIYw6+aaWgVHjW4gPFsBukChnZQ4Wm2WcKsNzROUlOH/Kjj44OylOaTocr6rb6
 PgcV5hW88Ri3rIWitgDYStNbZ66SlzxiDh1pwji9Sl1Olqb/MkRVc3WfJUETNYIdXcE3
 DZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eBk+GrbH5UnrDm8FHWFaBbZjN/qoNANGe98dIeav8qI=;
 b=sjaW61f/5H3UGbeBfd5I2gWKvbObm+45wc0gp5qKP3f18nU1KHvXP0Owd4tV6D2L8w
 Y2JgcHry6TIu4dK2uxCCHU1O1T8f/l7F7t5rw4GKBxh/kGpP3Cn6Eov3nPn1486Rw08l
 SxG1HwAZXotsTCoZMQ0DTzk0gi7KYOPKsD4pL1AVk3SDKmPmgc8IIYdhqM/7XVAhbobL
 UEfjUIMLw73BRvkTME4hhEVeOwlGNKp4qzfVtbi1jby0zzpWt+1YitF970xEDFq609IZ
 tAmoTtvKmedHmSpVlfjIEEFGzh3fdWwTrE0A9MOf9Ui5S7MN3vVNwCbeE7BF8lRY0RlB
 twdA==
X-Gm-Message-State: AOAM533Z/nU7ERPmexKmbdEXvZ0jgZmheZLYOIcweMr6HZVM97S0T1jr
 zrzHpQR07RGrsbwHUzVHKIYtQW+Xmxjx0Q==
X-Google-Smtp-Source: ABdhPJz+AELX29YEAbykZYDMIPmSKRcYfaShMbgXHoXAXaKzZx14It7xpZNMIfDAY9eht9xwQOlHWQ==
X-Received: by 2002:a63:5f8b:: with SMTP id t133mr1825708pgb.238.1598634335505; 
 Fri, 28 Aug 2020 10:05:35 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/16] crypto: Move cipher->driver init to
 qcrypto_*_cipher_ctx_new
Date: Fri, 28 Aug 2020 10:05:15 -0700
Message-Id: <20200828170523.418603-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipherpriv.h         | 2 --
 crypto/cipher-afalg.c       | 5 ++++-
 crypto/cipher.c             | 7 -------
 crypto/cipher-builtin.c.inc | 4 ++++
 crypto/cipher-gcrypt.c.inc  | 2 ++
 crypto/cipher-nettle.c.inc  | 3 +++
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
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 737fc0735d..3711b552fa 100644
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
diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 6a03e23040..1444139f36 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
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
 
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index 3b3c85e265..7a1fbc9745 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
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
diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index d8371d1f37..36d57ef430 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
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
-- 
2.25.1


