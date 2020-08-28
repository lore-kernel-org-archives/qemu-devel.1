Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882ADC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4799920776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clj6F+Zt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4799920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhqt-0008Nl-EQ
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhoh-0003YA-6A
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:31 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhoe-000309-ND
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:30 -0400
Received: by mail-pg1-x544.google.com with SMTP id l191so726244pgd.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FatlbZdYeHqsze9yHJGjnClTveY0gIW8RCgkQaKgScQ=;
 b=clj6F+ZtuzsXuk6WQlQQZXHbFPYm6DHm9mErWBPPiMbU7zsMi0XsR24XQsFy++p6l2
 SfGzrjeVZTLu3POZpVrpcE5KWf0ZTmwflD1g+hJOdGQnoSM0wK8nPQj/I3asmZa1t84o
 oTM8w6NtkeGhpgCq+0AWPeXzY5dhwUCEw8U7bv5/fS15jkSjWKuIdWM3H2eNEgRJZWMK
 acGt261dZz8+cHd+2Z3/6Jl4oueGgELulo41xrAxxE0zyc6SZQWXLBvGmymVlb+ZIP82
 EXX9CDp4FLebqeAi4BmgfEf1F9i2cN6VgOPY2x/CCMHWEtj4aKKflc/2bY8Z4UvetJky
 i/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FatlbZdYeHqsze9yHJGjnClTveY0gIW8RCgkQaKgScQ=;
 b=l3aD2anKOIt3WSOh6rUNK9b+FkMMYhWfl0lnkvK5NQ4Am+ZdDtjsliFC5Y4j+G4CQa
 LvWuZvBftYpnUtrABcI1FM3oLCNT/oe9oLTbf3Dhuygh5QZvJ0Dh99rQVkxEv//2unWv
 YwIjpkwbb7yYb0BZ7CE9DZnGhaKA8GFe70189GHD+h17V3dYztjOma5mydmqYWkCgJOj
 ElaJtCZmJNvMu0dAj1DPIsDHv1mWf1urMM36WneDSSeRejR00YIsakASNS/T3fcc5tT5
 ysFYv8w2ProcIzZxmckFEOl5PAuM5Kdkq+FYprCOOfWsxeWKrGo465YoLyB3FMn/scHf
 kakQ==
X-Gm-Message-State: AOAM533wg2h/yrx9MDHNkfLlVpRnOJJn0zbGt9LkFBTus3yXAMTREGze
 f/XlJFjKPyI+Eo6UV8sea1qP/xqOdsP5NA==
X-Google-Smtp-Source: ABdhPJxtk3AuHy5uDI0+ZPWu+hKUY2XcOssbvB++NqsUBXe9y9hNMFyKpEb/jREgYqFXohdtVnVpmg==
X-Received: by 2002:a65:6897:: with SMTP id e23mr1795129pgt.103.1598634326669; 
 Fri, 28 Aug 2020 10:05:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/16] crypto: Assume blocksize is a power of 2
Date: Fri, 28 Aug 2020 10:05:08 -0700
Message-Id: <20200828170523.418603-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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

The check in the encode/decode path using full division has a
noticeable amount of overhead.  By asserting the blocksize is
a power of 2, we can reduce this check to a mask.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-builtin.c | 4 ++--
 crypto/cipher-gcrypt.c  | 5 +++--
 crypto/cipher-nettle.c  | 5 +++--
 crypto/cipher.c         | 1 +
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index 35cf7820d9..6eafd39da0 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -484,7 +484,7 @@ qcrypto_builtin_cipher_encrypt(QCryptoCipher *cipher,
 {
     QCryptoCipherBuiltin *ctxt = cipher->opaque;
 
-    if (len % ctxt->blocksize) {
+    if (len & (ctxt->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctxt->blocksize);
         return -1;
@@ -503,7 +503,7 @@ qcrypto_builtin_cipher_decrypt(QCryptoCipher *cipher,
 {
     QCryptoCipherBuiltin *ctxt = cipher->opaque;
 
-    if (len % ctxt->blocksize) {
+    if (len & (ctxt->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctxt->blocksize);
         return -1;
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 2864099527..81e4745bff 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -245,6 +245,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
             g_assert_not_reached();
         }
     }
+    g_assert(is_power_of_2(ctx->blocksize));
 
 #ifdef CONFIG_QEMU_PRIVATE_XTS
     if (mode == QCRYPTO_CIPHER_MODE_XTS) {
@@ -305,7 +306,7 @@ qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
     QCryptoCipherGcrypt *ctx = cipher->opaque;
     gcry_error_t err;
 
-    if (len % ctx->blocksize) {
+    if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctx->blocksize);
         return -1;
@@ -344,7 +345,7 @@ qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *cipher,
     QCryptoCipherGcrypt *ctx = cipher->opaque;
     gcry_error_t err;
 
-    if (len % ctx->blocksize) {
+    if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctx->blocksize);
         return -1;
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index 7e9a4cc199..0677fdfd33 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -576,6 +576,7 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                    QCryptoCipherAlgorithm_str(alg));
         goto error;
     }
+    g_assert(is_power_of_2(ctx->blocksize));
 
     if (mode == QCRYPTO_CIPHER_MODE_XTS &&
         ctx->blocksize != XTS_BLOCK_SIZE) {
@@ -613,7 +614,7 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
 {
     QCryptoCipherNettle *ctx = cipher->opaque;
 
-    if (len % ctx->blocksize) {
+    if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctx->blocksize);
         return -1;
@@ -666,7 +667,7 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
 {
     QCryptoCipherNettle *ctx = cipher->opaque;
 
-    if (len % ctx->blocksize) {
+    if (len & (ctx->blocksize - 1)) {
         error_setg(errp, "Length %zu must be a multiple of block size %zu",
                    len, ctx->blocksize);
         return -1;
diff --git a/crypto/cipher.c b/crypto/cipher.c
index e5adb56271..2722dc7d87 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/host-utils.h"
 #include "qapi/error.h"
 #include "crypto/cipher.h"
 #include "cipherpriv.h"
-- 
2.25.1


