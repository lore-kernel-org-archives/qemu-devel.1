Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B82C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10440207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sz5zeG3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10440207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63wh-0003cQ-5R
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sN-0005CC-GU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:59 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sL-00009u-7C
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id y6so2020536plt.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jHuSzulEWSxcXS3/HgjqhtO/Ofgto2+WeRaIMAxtwhM=;
 b=Sz5zeG3XgVdhymmZEIjmfDzibF17JHrLPYGtUpJ94dyXjiVuSE86E/rcxIJx6bklEK
 e8p3MX2GpUZ5RPNdn9FEkoXW00uaPrIffXcgob1rY7NSul2DOVfBnxynTIkyMe9XoGVF
 1UYo8DAnf6C+uPYy0pwChWYRLS3JMyDKzTH1Wz/J4YOz5YRRVkW1P63v+0Nq8OFJi0mQ
 PUwT/PUboy63xS9y1g2nHE+x6XF94DOIgIgbL1DzpBUWIt9O1FstG9maj9x1hgmVU3KS
 LJyaeApEFgVdlzNSVOwdEU+osF1yaO4tyid/8uHnpp59CJdWoAvwMxDZxrRVJQCNa8pf
 MVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jHuSzulEWSxcXS3/HgjqhtO/Ofgto2+WeRaIMAxtwhM=;
 b=keNVvEvy+pW7zFwPQo7r9pOzs1gJs0ZiSM3dA/ZkAfp0+hhhnEQznlRGq3XCPESgYV
 ivW60bpOXTLnAEmkZe+rVQ5UHQ44ZyrhTFODdls9/Je42UkZRb+lNaUOOJgOdo1M0vGD
 AA+Cp+wTdlii8zf5tBqJVmt6mHEJW/fLNEtRWnWSLunqMuEl23MzlqwB15Tax+g7TP37
 rvT/tGXlIxXVAcqbXyU86fs5ZFV45T6IWsh062OF8apg80fpAikFpLzSysrlNSO+az2Y
 K0fqWpNKRjGhytwxtDvg6alLwbhWl0sjlKz5M3AMccYfwMCeKB0/zUHZLymLIMM5J+cf
 6k6g==
X-Gm-Message-State: AOAM5339w6PhROHGE0A8rbJjcfpT6jFAxxgEnE5KCK/mwgDHQ2ZPCChl
 SE2ZbFUb7lRyj71wKBEcPWmnA3Kd7IM=
X-Google-Smtp-Source: ABdhPJxUcFJml9PgDgnwE7wHJBbexG7JV81t1eNkeIVzwwE/d2QlZLrPBR+MxN4jpXAzHRV7AbFrQQ==
X-Received: by 2002:a17:90a:17ab:: with SMTP id
 q40mr3121848pja.28.1597289155645; 
 Wed, 12 Aug 2020 20:25:55 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/17] crypto/builtin: Merge qcrypto_cipher_aes_{ecb, xts}_{en,
 de}crypt
Date: Wed, 12 Aug 2020 20:25:32 -0700
Message-Id: <20200813032537.2888593-13-richard.henderson@linaro.org>
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

There's no real reason we need two separate helper functions here.
Standardize on the function signature required for xts_encrypt.
Rename to do_aes_{en,de}crypt_ecb, since the helper does not
itself do anything with respect to xts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-builtin.inc.c | 69 ++++++++++---------------------------
 1 file changed, 18 insertions(+), 51 deletions(-)

diff --git a/crypto/cipher-builtin.inc.c b/crypto/cipher-builtin.inc.c
index e2ae5d090c..4d971a2b82 100644
--- a/crypto/cipher-builtin.inc.c
+++ b/crypto/cipher-builtin.inc.c
@@ -72,65 +72,34 @@ static void qcrypto_cipher_free_aes(QCryptoCipher *cipher)
     g_free(cipher);
 }
 
-
-static void qcrypto_cipher_aes_ecb_encrypt(const AES_KEY *key,
-                                           const void *in,
-                                           void *out,
-                                           size_t len)
+static void do_aes_encrypt_ecb(const void *vctx, size_t len,
+                               uint8_t *out, const uint8_t *in)
 {
-    const uint8_t *inptr = in;
-    uint8_t *outptr = out;
+    const QCryptoCipherBuiltinAESContext *ctx = vctx;
 
     /* We have already verified that len % AES_BLOCK_SIZE == 0. */
     while (len) {
-        AES_encrypt(inptr, outptr, key);
-        inptr += AES_BLOCK_SIZE;
-        outptr += AES_BLOCK_SIZE;
+        AES_encrypt(in, out, &ctx->enc);
+        in += AES_BLOCK_SIZE;
+        out += AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
     }
 }
 
-
-static void qcrypto_cipher_aes_ecb_decrypt(const AES_KEY *key,
-                                           const void *in,
-                                           void *out,
-                                           size_t len)
+static void do_aes_decrypt_ecb(const void *vctx, size_t len,
+                               uint8_t *out, const uint8_t *in)
 {
-    const uint8_t *inptr = in;
-    uint8_t *outptr = out;
+    const QCryptoCipherBuiltinAESContext *ctx = vctx;
 
     /* We have already verified that len % AES_BLOCK_SIZE == 0. */
     while (len) {
-        AES_decrypt(inptr, outptr, key);
-        inptr += AES_BLOCK_SIZE;
-        outptr += AES_BLOCK_SIZE;
+        AES_decrypt(in, out, &ctx->dec);
+        in += AES_BLOCK_SIZE;
+        out += AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
     }
 }
 
-
-static void qcrypto_cipher_aes_xts_encrypt(const void *ctx,
-                                           size_t length,
-                                           uint8_t *dst,
-                                           const uint8_t *src)
-{
-    const QCryptoCipherBuiltinAESContext *aesctx = ctx;
-
-    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
-}
-
-
-static void qcrypto_cipher_aes_xts_decrypt(const void *ctx,
-                                           size_t length,
-                                           uint8_t *dst,
-                                           const uint8_t *src)
-{
-    const QCryptoCipherBuiltinAESContext *aesctx = ctx;
-
-    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
-}
-
-
 static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
                                       const void *in,
                                       void *out,
@@ -142,8 +111,7 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
 
     switch (cipher->mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
-        qcrypto_cipher_aes_ecb_encrypt(&ctxt->state.aes.key.enc,
-                                       in, out, len);
+        do_aes_encrypt_ecb(&ctxt->state.aes.key, len, out, in);
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
         AES_cbc_encrypt(in, out, len,
@@ -153,8 +121,8 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
     case QCRYPTO_CIPHER_MODE_XTS:
         xts_encrypt(&ctxt->state.aes.key,
                     &ctxt->state.aes.key_tweak,
-                    qcrypto_cipher_aes_xts_encrypt,
-                    qcrypto_cipher_aes_xts_decrypt,
+                    do_aes_encrypt_ecb,
+                    do_aes_decrypt_ecb,
                     ctxt->state.aes.iv,
                     len, out, in);
         break;
@@ -177,8 +145,7 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
 
     switch (cipher->mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
-        qcrypto_cipher_aes_ecb_decrypt(&ctxt->state.aes.key.dec,
-                                       in, out, len);
+        do_aes_decrypt_ecb(&ctxt->state.aes.key, len, out, in);
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
         AES_cbc_encrypt(in, out, len,
@@ -188,8 +155,8 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
     case QCRYPTO_CIPHER_MODE_XTS:
         xts_decrypt(&ctxt->state.aes.key,
                     &ctxt->state.aes.key_tweak,
-                    qcrypto_cipher_aes_xts_encrypt,
-                    qcrypto_cipher_aes_xts_decrypt,
+                    do_aes_encrypt_ecb,
+                    do_aes_decrypt_ecb,
                     ctxt->state.aes.iv,
                     len, out, in);
         break;
-- 
2.25.1


