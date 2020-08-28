Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478E9C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12A020776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="roMHS2o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12A020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhty-0006CZ-1x
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhot-0003xN-4X
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:43 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhor-00036E-96
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:42 -0400
Received: by mail-pj1-x1042.google.com with SMTP id nv17so23386pjb.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z0jSasqYMa/kYWQRBUn0M5RkDRX5OspYiVQvjoGRm10=;
 b=roMHS2o+qL8y8fbaQz7gA08dLUtzfxbTpBShd8UzaAfxUM5gRXDrYd/FVT68VjffzY
 XE9t5PHoHhdoKUBitXa5NNiIaTHqn0sbObZ+8jKtakPXq2Ijj/+1dnZgATZ/8hjW7o/6
 5uGa1wG23vHd32mgJNvkrz5TpxP14QSxixP5t700uK8XOUjOYk07oXvHQpk875E9nzxS
 hC6TYckscanY3NiLIQmMKJPy0CjziMuQQRavjGcQMUOf8Ro6o2g8oEVeiR5NQ1nrbwzy
 LmyTUvFZRy+7wOoPeopoN2aKVIDJkppffdLAxm718Nq9S2ExgfUPZJoa2ig4StaVyWgK
 qhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z0jSasqYMa/kYWQRBUn0M5RkDRX5OspYiVQvjoGRm10=;
 b=lqe/R3JwdNQnedav1BUy0y6p37Sw+iIl4Jf/UysSME3r8nB55PC9lbApJnrA27HhKS
 cmRPWGtSSIeKID9IoJW1lLLBl9/i+xVeQ/gDCLPaxNlZBw/NT7WEIkuuYQ2SdiJ4vhVd
 P6pTR0nCjGBjdO0TMOgFNrMCpCCvJKUCsIjPfIVInYWSKi0PolnAwb7k6SGVbS6ktzWs
 GsYh0QNHaeJ4U3Qr2iPv+7aIGEKDkvQXUFtvs/pHYE7TxyhHIaew1s4rNzjBacdHODx7
 nHmFa2Q6cPac8U7q/l+Hm/MChcNOly5juE+bmGcoUlSyhSrOZd9L0kbTRfmTQeesU4pi
 XCIQ==
X-Gm-Message-State: AOAM531eOHqTTHeLSWiw8TrcmpYZdJNppwYPI07Hyh9t0vszt+LT4+mQ
 mM4jPuzSAv/zN1cBYdmxsyj5gIc9rv2ECw==
X-Google-Smtp-Source: ABdhPJyOHoXvKXqmutVfzAD9XANsDGVJl6rC0cN+ieYdHx1QJ1U2uHqt3cnn0bLGWPqFFqZfVCr0Og==
X-Received: by 2002:a17:90a:858a:: with SMTP id
 m10mr47912pjn.185.1598634339389; 
 Fri, 28 Aug 2020 10:05:39 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/16] crypto/builtin: Merge qcrypto_cipher_aes_{ecb,
 xts}_{en, de}crypt
Date: Fri, 28 Aug 2020 10:05:18 -0700
Message-Id: <20200828170523.418603-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's no real reason we need two separate helper functions here.
Standardize on the function signature required for xts_encrypt.
Rename to do_aes_{en,de}crypt_ecb, since the helper does not
itself do anything with respect to xts.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-builtin.c.inc | 73 +++++++++++--------------------------
 1 file changed, 22 insertions(+), 51 deletions(-)

diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index e2ae5d090c..8e21f2673f 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -72,65 +72,38 @@ static void qcrypto_cipher_free_aes(QCryptoCipher *cipher)
     g_free(cipher);
 }
 
-
-static void qcrypto_cipher_aes_ecb_encrypt(const AES_KEY *key,
-                                           const void *in,
-                                           void *out,
-                                           size_t len)
+static void do_aes_encrypt_ecb(const void *vctx,
+                               size_t len,
+                               uint8_t *out,
+                               const uint8_t *in)
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
+static void do_aes_decrypt_ecb(const void *vctx,
+                               size_t len,
+                               uint8_t *out,
+                               const uint8_t *in)
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
@@ -142,8 +115,7 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
 
     switch (cipher->mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
-        qcrypto_cipher_aes_ecb_encrypt(&ctxt->state.aes.key.enc,
-                                       in, out, len);
+        do_aes_encrypt_ecb(&ctxt->state.aes.key, len, out, in);
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
         AES_cbc_encrypt(in, out, len,
@@ -153,8 +125,8 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
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
@@ -177,8 +149,7 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
 
     switch (cipher->mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
-        qcrypto_cipher_aes_ecb_decrypt(&ctxt->state.aes.key.dec,
-                                       in, out, len);
+        do_aes_decrypt_ecb(&ctxt->state.aes.key, len, out, in);
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
         AES_cbc_encrypt(in, out, len,
@@ -188,8 +159,8 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
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


