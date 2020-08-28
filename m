Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553AFC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ABA20776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8U035LO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ABA20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBht1-0004gr-54
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhov-000446-Kv
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:45 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhot-00037K-NB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:45 -0400
Received: by mail-pj1-x1041.google.com with SMTP id g6so31868pjl.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R08qzgHyL/bf1N6eFfMci3b2adBB+mTS2SLfm7s3DVE=;
 b=s8U035LOyXRw5MhJdmmyVpJUu5OJ6CULXwcL6utmvGyD2v3+TJ3m4LzOthcQPqBKV6
 uV4rD08GqEZGISDJ3kD+4pgCYgLsEEGDcLq9lA77GGjxc0QnH3v4a2QcmObP3ab6EboH
 NvA4n5YOgtzNZfGvNrkrKWqTO28CAbcoJ3tlu7GlfgLvxYlZjqRsWAjubjTwxQuUr9v9
 frRpJaWXIByrBQyup4RM3ic/0Y+aXcOJTRzm+I7mFI9sDm5Iz0pWWhnJvQkKTf1Ny4BM
 GZUxRe2vJ/j6JJ7WDE0+PesI3Z8mx3N6AujoF8zqw395cNVZTtjrWJ4ptiemRgcmwSq+
 e9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R08qzgHyL/bf1N6eFfMci3b2adBB+mTS2SLfm7s3DVE=;
 b=QNNRJ4CQMo85T9jsnRHCUkbVI0C77ft+AWZiURf/s2yLJyGQiyxohRWO2m6HatM/W0
 X3yAqevC0iVxhP/j+GRk+ftXh/t0drLrBOWV/S85OvX0wsVfEVKkm11ZnkkUIQlsaxQr
 sTCAuhRQufRTc8986vzOseHznmN+79e4aNxg1acWZxrcj5dnbSUVacoQhQu4cEaWX/4i
 yoYtIb/Jg3FCThtfNvMCn80NoHbxcy4IfgUEJGhAPgWAUoMJLTy/jhC7QXu7vGqVrhAz
 SwKxH2eiNWdMV76pDSIrPsMBF78xqVDlTuBDp5vIz7hkvEfudEsphGyFOmFR3tp8403J
 YheA==
X-Gm-Message-State: AOAM531swGGAshhYEsUyMlNdQc2Ug3pY+GejiXuQpkoV+nucIARqdpqN
 CX+6/5ZuvrSVKNuPKMadx4Z2jPWuSFuq4g==
X-Google-Smtp-Source: ABdhPJxH2zQ4HZ5BUmCI0im7DYVaHXSw0N/gFECusuuG1dG7uZWnTy9Jn3kqoCGBU9SEkJG5L3QxeQ==
X-Received: by 2002:a17:90a:9915:: with SMTP id
 b21mr58544pjp.109.1598634341917; 
 Fri, 28 Aug 2020 10:05:41 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/16] crypto/builtin: Split and simplify AES_encrypt_cbc
Date: Fri, 28 Aug 2020 10:05:20 -0700
Message-Id: <20200828170523.418603-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Split into encrypt/decrypt functions, dropping the "enc" argument.
Now that the function is private to this file, we know that "len"
is a multiple of AES_BLOCK_SIZE.  So drop the odd block size code.

Name the functions do_aes_*crypt_cbc to match the *_ecb functions.
Reorder and re-type the arguments to match as well.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-builtin.c.inc | 97 ++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 55 deletions(-)

diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 61baad265a..b1fe3b08c3 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -104,61 +104,50 @@ static void do_aes_decrypt_ecb(const void *vctx,
     }
 }
 
-static void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
-                            const unsigned long length, const AES_KEY *key,
-                            unsigned char *ivec, const int enc)
+static void do_aes_encrypt_cbc(const AES_KEY *key,
+                               size_t len,
+                               uint8_t *out,
+                               const uint8_t *in,
+                               uint8_t *ivec)
 {
-    unsigned long n;
-    unsigned long len = length;
-    unsigned char tmp[AES_BLOCK_SIZE];
+    uint8_t tmp[AES_BLOCK_SIZE];
+    size_t n;
 
-    assert(in && out && key && ivec);
-
-    if (enc) {
-        while (len >= AES_BLOCK_SIZE) {
-            for (n = 0; n < AES_BLOCK_SIZE; ++n) {
-                tmp[n] = in[n] ^ ivec[n];
-            }
-            AES_encrypt(tmp, out, key);
-            memcpy(ivec, out, AES_BLOCK_SIZE);
-            len -= AES_BLOCK_SIZE;
-            in += AES_BLOCK_SIZE;
-            out += AES_BLOCK_SIZE;
-        }
-        if (len) {
-            for (n = 0; n < len; ++n) {
-                tmp[n] = in[n] ^ ivec[n];
-            }
-            for (n = len; n < AES_BLOCK_SIZE; ++n) {
-                tmp[n] = ivec[n];
-            }
-            AES_encrypt(tmp, tmp, key);
-            memcpy(out, tmp, AES_BLOCK_SIZE);
-            memcpy(ivec, tmp, AES_BLOCK_SIZE);
-        }
-    } else {
-        while (len >= AES_BLOCK_SIZE) {
-            memcpy(tmp, in, AES_BLOCK_SIZE);
-            AES_decrypt(in, out, key);
-            for (n = 0; n < AES_BLOCK_SIZE; ++n) {
-                out[n] ^= ivec[n];
-            }
-            memcpy(ivec, tmp, AES_BLOCK_SIZE);
-            len -= AES_BLOCK_SIZE;
-            in += AES_BLOCK_SIZE;
-            out += AES_BLOCK_SIZE;
-        }
-        if (len) {
-            memcpy(tmp, in, AES_BLOCK_SIZE);
-            AES_decrypt(tmp, tmp, key);
-            for (n = 0; n < len; ++n) {
-                out[n] = tmp[n] ^ ivec[n];
-            }
-            memcpy(ivec, tmp, AES_BLOCK_SIZE);
+    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
+    while (len) {
+        for (n = 0; n < AES_BLOCK_SIZE; ++n) {
+            tmp[n] = in[n] ^ ivec[n];
         }
+        AES_encrypt(tmp, out, key);
+        memcpy(ivec, out, AES_BLOCK_SIZE);
+        len -= AES_BLOCK_SIZE;
+        in += AES_BLOCK_SIZE;
+        out += AES_BLOCK_SIZE;
     }
 }
 
+static void do_aes_decrypt_cbc(const AES_KEY *key,
+                               size_t len,
+                               uint8_t *out,
+                               const uint8_t *in,
+                               uint8_t *ivec)
+{
+    uint8_t tmp[AES_BLOCK_SIZE];
+    size_t n;
+
+    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
+    while (len) {
+        memcpy(tmp, in, AES_BLOCK_SIZE);
+        AES_decrypt(in, out, key);
+        for (n = 0; n < AES_BLOCK_SIZE; ++n) {
+            out[n] ^= ivec[n];
+        }
+        memcpy(ivec, tmp, AES_BLOCK_SIZE);
+        len -= AES_BLOCK_SIZE;
+        in += AES_BLOCK_SIZE;
+        out += AES_BLOCK_SIZE;
+    }
+}
 
 static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
                                       const void *in,
@@ -174,9 +163,8 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
         do_aes_encrypt_ecb(&ctxt->state.aes.key, len, out, in);
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
-        AES_cbc_encrypt(in, out, len,
-                        &ctxt->state.aes.key.enc,
-                        ctxt->state.aes.iv, 1);
+        do_aes_encrypt_cbc(&ctxt->state.aes.key.enc, len, out, in,
+                           ctxt->state.aes.iv);
         break;
     case QCRYPTO_CIPHER_MODE_XTS:
         xts_encrypt(&ctxt->state.aes.key,
@@ -208,9 +196,8 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
         do_aes_decrypt_ecb(&ctxt->state.aes.key, len, out, in);
         break;
     case QCRYPTO_CIPHER_MODE_CBC:
-        AES_cbc_encrypt(in, out, len,
-                        &ctxt->state.aes.key.dec,
-                        ctxt->state.aes.iv, 0);
+        do_aes_decrypt_cbc(&ctxt->state.aes.key.dec, len, out, in,
+                           ctxt->state.aes.iv);
         break;
     case QCRYPTO_CIPHER_MODE_XTS:
         xts_decrypt(&ctxt->state.aes.key,
-- 
2.25.1


