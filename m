Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA7520715
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCg5WWAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA7520715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63zX-00083Z-8C
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sQ-0005IM-VK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:26:02 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sO-0000AE-1R
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:26:01 -0400
Received: by mail-pg1-x543.google.com with SMTP id h12so2114949pgm.7
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XfDBqVtcFp4u69HfrPx2aYbk0EB30OybSYsl3oZkJuM=;
 b=BCg5WWAYUJo/5l2JLBQpDtWdfMAusmXw+9wpC/wXOIbC3IOETdp/nPNe6WbdxMj7dd
 Cg14wYAHL4XVLRF8uuOfhOc0RUFeVJpyGqFxfS8erzXM1RXtzY5eKzh3Heq3YH68X7KP
 fKakJHd9x0j260R8P/P2/IYM5CFZypOYeLyCcpjjxZe+DGLX+VhRCCL86kL6fEfcatW5
 q19d6FWx8vmD83V6SHIicqB6SdvCnGSjsVmk0m41OuxyQFxMMQUBODD2vZqItT26KKib
 IJwQeJGWgTKMKOLPU9u1iX1N23HkkjsLgDL3iGJ2dhenlddpiZKjEH9d8cog67Pop8ya
 IaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XfDBqVtcFp4u69HfrPx2aYbk0EB30OybSYsl3oZkJuM=;
 b=E6nGJkacJU5g86dwbJfOTJD9+441V+Nd4gHTJnHCMfbTvVnukSUEkB8shdBO9ipZFp
 /9T/429IHdKt/cQDwxK9y2kmfw1yAiZvs5miyhdqsNkSADkzKAhpjApKX01mSWQtixJF
 3N7yZtd9691FClELO8JxINjm0nEVGtmVGUQSqLJqOXyMACKR8s0MtibbGizqdWxMBlH7
 CWtzEyWNiniai9lRnOL34gPYmvP75bUKFMbcHV+j6kECcooIXpc5btnguYXjKfjPEcV7
 hXoCU8iCJPoA/efIQc7eclEySNu/g2/r1jxq6jJVKJUc9Yt/2ICTSyzsUim0N8URU8/D
 e50A==
X-Gm-Message-State: AOAM531Q57pYFLN72GL6yU699t80P4Gk4uTQJl51g2LeDWeqZvigQTfl
 NR0v05W26QJb5JTUioiZ52naeZOzj70=
X-Google-Smtp-Source: ABdhPJyNsyF+QKsLw5xWIuYAQyirE2pvNKWOgXfXkKdIn7klz0uBX4YKzYxA16T6/c6Z6HQZan+t2A==
X-Received: by 2002:a05:6a00:7c8:: with SMTP id
 n8mr2455089pfu.123.1597289158079; 
 Wed, 12 Aug 2020 20:25:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/17] crypto/builtin: Split and simplify AES_encrypt_cbc
Date: Wed, 12 Aug 2020 20:25:34 -0700
Message-Id: <20200813032537.2888593-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-builtin.inc.c | 91 +++++++++++++++----------------------
 1 file changed, 36 insertions(+), 55 deletions(-)

diff --git a/crypto/cipher-builtin.inc.c b/crypto/cipher-builtin.inc.c
index 416d44b38e..4295f93af5 100644
--- a/crypto/cipher-builtin.inc.c
+++ b/crypto/cipher-builtin.inc.c
@@ -100,61 +100,44 @@ static void do_aes_decrypt_ecb(const void *vctx, size_t len,
     }
 }
 
-static void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
-                            const unsigned long length, const AES_KEY *key,
-                            unsigned char *ivec, const int enc)
+static void do_aes_encrypt_cbc(const AES_KEY *key, size_t len, uint8_t *out,
+                               const uint8_t *in, uint8_t *ivec)
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
 
+static void do_aes_decrypt_cbc(const AES_KEY *key, size_t len, uint8_t *out,
+                               const uint8_t *in, uint8_t *ivec)
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
@@ -170,9 +153,8 @@ static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
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
@@ -204,9 +186,8 @@ static int qcrypto_cipher_decrypt_aes(QCryptoCipher *cipher,
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


