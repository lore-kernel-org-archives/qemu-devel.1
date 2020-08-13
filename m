Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC4CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69820206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/pDw9F8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69820206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63tH-0006SJ-Iw
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sB-0004mb-PJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:47 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63s9-0008VL-Vu
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:47 -0400
Received: by mail-pg1-x541.google.com with SMTP id x6so2105265pgx.12
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ttKbooO9380v1ETeZhXOVKlGzyg1tlctRYSN45UvQQc=;
 b=T/pDw9F8LncEoJRmsfGCHCOzbgZZV3UpSXJ6fnzGtindqTSaJLcFU5rbOAG719HsMA
 m0caPuMbRhijy4z6n9O6ThAc5riE5Ga+Ww/wLOmCpXU4qXRWOHeJ0aurpgIERzLhOsUN
 gD8YRMwYO8TU3C/62gP+tTHeuq1WX5UQzN4QM1bdM7ugUu9wiS7sGyNu9MatAX0H6dIk
 y7SqmgweR1847aVYcZtQX+7fowPd+ztS5ENfMboHdTa2RH3WRW146/a6CkSYCg0XnTUM
 4JHcaMIV2+DiV9QnZHRigqxiGT8/pIx+LcsS5e2OVr4U/gWc4jytAdrSEDATq6URV1vf
 2cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ttKbooO9380v1ETeZhXOVKlGzyg1tlctRYSN45UvQQc=;
 b=CgVuAVZe2ZM52VnBuU/D0UF0dnXUDgDighePejyz95snYI7CT1F3iUIP58jF1Nlj8r
 +duT5UWC0N10acZaLc6I/Y0IT8hM2oApMyRjYGMQOVG1t1bIP80Uw0S+8qbzAECWJ9Fn
 A1KHPELGcbe62xQTqt92BVVr+Rqx1CWSrk8IyCoTbdapexfLyWgLJXK3GvyO3ID7zE7V
 H2c3OhWsJDX5a5fgA6kkGbBnbVNrkmg8ejkpksfSmq7nwKr1vohx0IbczzYsiL+V4OEt
 NqdRmpW7ZHV5F9MWBa3mqXeuhealC1fxCMZbmR+qUkm0B7zjFKSOYRELU93GEQBQB/Zo
 ngiA==
X-Gm-Message-State: AOAM5328/mvtag/yNxeOneZlzdCq4tjQhNDsnOmtYol9nLQNqkxZi6JF
 yCZPfLw6zp3cqwuXDW4kZ7yehJfcmOg=
X-Google-Smtp-Source: ABdhPJw0SXsy2xlFdaqrRbuZvy8A8povRyCr4vjRCHlSZU53yN8ZFuQyyAXuPto+7rtmf7qNW+y2dg==
X-Received: by 2002:a65:6384:: with SMTP id h4mr1971691pgv.196.1597289144143; 
 Wed, 12 Aug 2020 20:25:44 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/17] crypto: Assume blocksize is a power of 2
Date: Wed, 12 Aug 2020 20:25:23 -0700
Message-Id: <20200813032537.2888593-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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


