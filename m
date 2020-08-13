Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C41CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39BE20756
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsFpya0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39BE20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63yQ-0006JZ-4v
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sO-0005EM-D8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:26:00 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:35917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sM-0000A2-In
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:26:00 -0400
Received: by mail-pg1-x52b.google.com with SMTP id p37so2124553pgl.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dJVKjiEkOYni5kS+6oXRQCkue35GHv0VpKcWBZdFBBk=;
 b=fsFpya0W+7tQF58WN/FjXL1mu4h31IJ/l+AlLL5xRGa1ANaljw9PKxzv1NWJfVi2Db
 E7/NcjUHIYsFGSVp2zqZVR5+iAYlEKMouTRtC8hDwdh+8NMYxgEooiJOmeeS1VAn5KIo
 nQlaNImeB+gXpEPCh3rVcc6B0ghDxNWXqgaYmjY5bU9Zpj5M1H2G4QewQEJab5Q/vBfo
 zNmH5sFV8rBwKFuV0db7DE8ZiQ3ZHmGY+uPDZkNTTrAiM/jPuY3m3xNPXQ217x9PSvEi
 ziLRL0I/fE0VQcTPWtV0I0i/F0Mr/QRbwA5Tn5jHtDjtKGHX1aKBlXBzwu9Sq6cr5NBD
 XB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dJVKjiEkOYni5kS+6oXRQCkue35GHv0VpKcWBZdFBBk=;
 b=Yf++E5susFA7mXHtSq3ZsH2gA6RdMlpMYpdhPgGOZ85BdC7Norr+0koW/qYWbVllrr
 BAjiKlp8Z3v3LrmVvXPIM0nA4uhDvEGNBUYCaLiuv8FHdCPYZFz/ncjatirzMG3HxE8E
 DD/3PCIIYpqNTU63eVXwc09gtEMHQINICecK8ULQWm4NDroPYP9jptsXqUjai+4Hfy9n
 0e8Z8kOOn4E4owG2tRyhsd+fRj+GdlK/NYNLs09escardMtstBIeslG8c17Cxs4zxwg0
 jknXKmy9r9M8eXK9FD7ZdQ3F4O1tAgHg4iCfkQiZTUkV7YPtLaiomP1HGBT1fF1C24mo
 y0dw==
X-Gm-Message-State: AOAM532pQUKfDO5dPHqZIgOBMxTKmZLZSoskHcfvRAEnyMnFgYW4djRl
 H0kzEJSY9j1eUECASzSbZe0Rr9bk5To=
X-Google-Smtp-Source: ABdhPJxHVRPGD+ZCBih54kfyVpetWDZ91KT3SUY3K5YdG8Ysu4o/gKAhqqeuqk9Z5gkKSnPavXsdHg==
X-Received: by 2002:a62:c182:: with SMTP id i124mr2344803pfg.225.1597289156789; 
 Wed, 12 Aug 2020 20:25:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/17] crypto/builtin: Move AES_cbc_encrypt into
 cipher-builtin.inc.c
Date: Wed, 12 Aug 2020 20:25:33 -0700
Message-Id: <20200813032537.2888593-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

By making the function private, we will be able to make further
simplifications.  Re-indent the migrated code and fix the missing
braces for CODING_STYLE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/aes.h        |  4 ---
 crypto/aes.c                | 51 ---------------------------------
 crypto/cipher-builtin.inc.c | 56 +++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 12fb321b89..ba297d6a73 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -16,7 +16,6 @@ typedef struct aes_key_st AES_KEY;
 #define AES_set_decrypt_key QEMU_AES_set_decrypt_key
 #define AES_encrypt QEMU_AES_encrypt
 #define AES_decrypt QEMU_AES_decrypt
-#define AES_cbc_encrypt QEMU_AES_cbc_encrypt
 
 int AES_set_encrypt_key(const unsigned char *userKey, const int bits,
 	AES_KEY *key);
@@ -27,9 +26,6 @@ void AES_encrypt(const unsigned char *in, unsigned char *out,
 	const AES_KEY *key);
 void AES_decrypt(const unsigned char *in, unsigned char *out,
 	const AES_KEY *key);
-void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
-		     const unsigned long length, const AES_KEY *key,
-		     unsigned char *ivec, const int enc);
 
 extern const uint8_t AES_sbox[256];
 extern const uint8_t AES_isbox[256];
diff --git a/crypto/aes.c b/crypto/aes.c
index 0f6a195af8..159800df65 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1599,54 +1599,3 @@ void AES_decrypt(const unsigned char *in, unsigned char *out,
 }
 
 #endif /* AES_ASM */
-
-void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
-                     const unsigned long length, const AES_KEY *key,
-                     unsigned char *ivec, const int enc)
-{
-
-        unsigned long n;
-        unsigned long len = length;
-        unsigned char tmp[AES_BLOCK_SIZE];
-
-        assert(in && out && key && ivec);
-
-        if (enc) {
-                while (len >= AES_BLOCK_SIZE) {
-                        for(n=0; n < AES_BLOCK_SIZE; ++n)
-                                tmp[n] = in[n] ^ ivec[n];
-                        AES_encrypt(tmp, out, key);
-                        memcpy(ivec, out, AES_BLOCK_SIZE);
-                        len -= AES_BLOCK_SIZE;
-                        in += AES_BLOCK_SIZE;
-                        out += AES_BLOCK_SIZE;
-                }
-                if (len) {
-                        for(n=0; n < len; ++n)
-                                tmp[n] = in[n] ^ ivec[n];
-                        for(n=len; n < AES_BLOCK_SIZE; ++n)
-                                tmp[n] = ivec[n];
-                        AES_encrypt(tmp, tmp, key);
-                        memcpy(out, tmp, AES_BLOCK_SIZE);
-                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
-                }
-        } else {
-                while (len >= AES_BLOCK_SIZE) {
-                        memcpy(tmp, in, AES_BLOCK_SIZE);
-                        AES_decrypt(in, out, key);
-                        for(n=0; n < AES_BLOCK_SIZE; ++n)
-                                out[n] ^= ivec[n];
-                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
-                        len -= AES_BLOCK_SIZE;
-                        in += AES_BLOCK_SIZE;
-                        out += AES_BLOCK_SIZE;
-                }
-                if (len) {
-                        memcpy(tmp, in, AES_BLOCK_SIZE);
-                        AES_decrypt(tmp, tmp, key);
-                        for(n=0; n < len; ++n)
-                                out[n] = tmp[n] ^ ivec[n];
-                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
-                }
-        }
-}
diff --git a/crypto/cipher-builtin.inc.c b/crypto/cipher-builtin.inc.c
index 4d971a2b82..416d44b38e 100644
--- a/crypto/cipher-builtin.inc.c
+++ b/crypto/cipher-builtin.inc.c
@@ -100,6 +100,62 @@ static void do_aes_decrypt_ecb(const void *vctx, size_t len,
     }
 }
 
+static void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
+                            const unsigned long length, const AES_KEY *key,
+                            unsigned char *ivec, const int enc)
+{
+    unsigned long n;
+    unsigned long len = length;
+    unsigned char tmp[AES_BLOCK_SIZE];
+
+    assert(in && out && key && ivec);
+
+    if (enc) {
+        while (len >= AES_BLOCK_SIZE) {
+            for (n = 0; n < AES_BLOCK_SIZE; ++n) {
+                tmp[n] = in[n] ^ ivec[n];
+            }
+            AES_encrypt(tmp, out, key);
+            memcpy(ivec, out, AES_BLOCK_SIZE);
+            len -= AES_BLOCK_SIZE;
+            in += AES_BLOCK_SIZE;
+            out += AES_BLOCK_SIZE;
+        }
+        if (len) {
+            for (n = 0; n < len; ++n) {
+                tmp[n] = in[n] ^ ivec[n];
+            }
+            for (n = len; n < AES_BLOCK_SIZE; ++n) {
+                tmp[n] = ivec[n];
+            }
+            AES_encrypt(tmp, tmp, key);
+            memcpy(out, tmp, AES_BLOCK_SIZE);
+            memcpy(ivec, tmp, AES_BLOCK_SIZE);
+        }
+    } else {
+        while (len >= AES_BLOCK_SIZE) {
+            memcpy(tmp, in, AES_BLOCK_SIZE);
+            AES_decrypt(in, out, key);
+            for (n = 0; n < AES_BLOCK_SIZE; ++n) {
+                out[n] ^= ivec[n];
+            }
+            memcpy(ivec, tmp, AES_BLOCK_SIZE);
+            len -= AES_BLOCK_SIZE;
+            in += AES_BLOCK_SIZE;
+            out += AES_BLOCK_SIZE;
+        }
+        if (len) {
+            memcpy(tmp, in, AES_BLOCK_SIZE);
+            AES_decrypt(tmp, tmp, key);
+            for (n = 0; n < len; ++n) {
+                out[n] = tmp[n] ^ ivec[n];
+            }
+            memcpy(ivec, tmp, AES_BLOCK_SIZE);
+        }
+    }
+}
+
+
 static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
                                       const void *in,
                                       void *out,
-- 
2.25.1


