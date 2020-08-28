Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00914C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A230220776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Amz+3ytM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A230220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhwd-0001Xa-Qf
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhou-00041Z-O4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:44 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:40480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhos-000370-Gz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:44 -0400
Received: by mail-pf1-x42d.google.com with SMTP id c142so873777pfb.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9pef8gAf1wsVL1CMsBcENDnjN1Fz2AwxX3zrLli9AqA=;
 b=Amz+3ytMmbpQhWupxfLouxMaZDgJQDIS6kmT8arZH33roOHAHvFzmpunSQiHXyipbr
 q9hTxtpM89RMO7CLm0a5c03RZpQhaoGI7hpdRfXTQSFk34r9QD6mGO+oIa4F4JcJkQge
 AyrAYniTVAjMhKTffJAnw33mZTsFERaxkRcVwR+Ttm2nEtKR9TLpp/PbLjaD63isONDY
 nyiJWGqWlLSuuQ4xBeVaHDMDG7UDfr/eq4LIGt9wnVAEjKD+dCcUrKdXY7VvjbR6XSBE
 VeB5sQtwJejV7zN4PyksWPN9KnP+DuSv1vHKcSwHtOY2l5FuOPiP2clBGz7wjhlW8sSh
 Ataw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9pef8gAf1wsVL1CMsBcENDnjN1Fz2AwxX3zrLli9AqA=;
 b=ARIO0a6EwDcBTkne7Jmflsd3+Cpfn7t2tmBVShR1oDZxxRoH0vCT8oO3h6uysO7F+j
 EO1PGMjom+qDWS1NACkEJ6MyIROFyRwWPQ3RaRW4QpVLL7y1+tiuD/mjhZaCFbqEVDA0
 IzR7nUeJeWsxdwv2PmIx2NGtDe6oM083Px5omADrOXEY6cOw1YwTTOvuQbxVPF1kvatX
 3Q4b+vynfUM15ssGjVjxe5H3EVA0yoY71YzdXwHFBtp5gM5NrOUb+1XIX49bssbF84W+
 Lrijtpt+z2K+yUX+mCLJTTkk9+XjWdv0hsCVQaKxvAVuImcuIRcYjThjdG8k1ZTHHmNa
 Q1HA==
X-Gm-Message-State: AOAM5309gB5Z5+RlTJwkkbY0Ay7A2fgqtnBgcNEzt5dHuafAVoeKzvSs
 YpleQ+z8LRM2YBmOSUSDvH1zXYF+pqwasQ==
X-Google-Smtp-Source: ABdhPJx+cjnxMxZ4fhI6q7kld+nPK1EajGBvHGWWOPY7F+SygbhvrGPnOiCqI4iVFTulEK7UWksQVw==
X-Received: by 2002:a63:d918:: with SMTP id r24mr1736363pgg.158.1598634340748; 
 Fri, 28 Aug 2020 10:05:40 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/16] crypto/builtin: Move AES_cbc_encrypt into
 cipher-builtin.inc.c
Date: Fri, 28 Aug 2020 10:05:19 -0700
Message-Id: <20200828170523.418603-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

By making the function private, we will be able to make further
simplifications.  Re-indent the migrated code and fix the missing
braces for CODING_STYLE.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/aes.h        |  4 ---
 crypto/aes.c                | 51 ---------------------------------
 crypto/cipher-builtin.c.inc | 56 +++++++++++++++++++++++++++++++++++++
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
diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 8e21f2673f..61baad265a 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -104,6 +104,62 @@ static void do_aes_decrypt_ecb(const void *vctx,
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


