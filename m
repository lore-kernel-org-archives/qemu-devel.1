Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE7C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8165F20776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGB1X0i4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8165F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhsJ-0003Gx-JO
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhor-0003tC-LR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:41 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhop-000352-S7
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:41 -0400
Received: by mail-pl1-x641.google.com with SMTP id j11so777767plk.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TqzPE+AsczeJFR52P3swxprxnAZO/kZ1snURQdlagJA=;
 b=XGB1X0i4my0zdUr1MHPPBWyF2ZTOZnn4l3AVeNVWvJtE+U5PCV0agP/aAFq1devQg/
 clDiH/N4yVYZJ5w62/z/QtZF01caGviCKeyVJkLYEmrqcKyD56R77e7IhxgZuFj8xJr/
 TSw3d/XPCZUimt90B8aajrTR+GX/NRMV4m1Wb5+4ADcep8boy7XAE+/FNMREdp2CLJpA
 aGRL8Z4U0EhGB29p38YHfyKAYj2mUAoAFgNmmudM9E4yEtg3IqH0ws0LQnaJovvYUZfG
 jLNek2vUtXt9j/TNeJdvR+jfdlXmp2BL1+bhKIZ5TsUCPejLAFiBCd3N4DWvcQ/Oi0Mz
 jBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TqzPE+AsczeJFR52P3swxprxnAZO/kZ1snURQdlagJA=;
 b=qJTmCDN7sWhpl7iQEn6ocftnB576UyOcstEyMgr9lnM9JWqRVHK5Ly01jxDwjRN9iD
 ZBE67iRq7jLi4DTDXIghAOaE1kn+cPu1FfwKQOR1GFDoV3eCOP/8qMWuG6FgwqRChqA3
 eQz2prySfG9dThzVfoyK3zGQBJeSOOiG8OUjFq235pSXOmaq3JqttHWv38MDdKDP9Sb3
 zWi6+Srk44iZjoroXkq/qow1T80oTb+KVuzKi7NAXu/cPjhHUb2huSRZyXH/XSl7ff8e
 UaXBwUdygmdwrv5nsY8VJrIY2PFryvOb85jB4LQaA7WHMIMEtlVsHMlc84G9wtAnT4vV
 assQ==
X-Gm-Message-State: AOAM5316qLItp5HG4hqG551hyzsWrudomr3Aod7nwx883bVAd7m95of6
 hREzEGIIHKpRCK47A3mZfX5651XbygMmGA==
X-Google-Smtp-Source: ABdhPJzjxMIxor5Gg9pbplDdi9RDj3cCJUeat7Obyr+MgtO0HSZu02n8RdCw6FddbqLoGAjBWMyB9w==
X-Received: by 2002:a17:902:7582:: with SMTP id
 j2mr2203287pll.322.1598634338106; 
 Fri, 28 Aug 2020 10:05:38 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/16] crypto/builtin: Remove odd-sized AES block handling
Date: Fri, 28 Aug 2020 10:05:17 -0700
Message-Id: <20200828170523.418603-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We verified that the data block is properly sized modulo
AES_BLOCK_SIZE within qcrypto_builtin_cipher_{en,de}crypt.
Therefore we will never have to handle odd sized blocks.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-builtin.c.inc | 40 +++++++++++--------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 1444139f36..e2ae5d090c 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -80,21 +80,13 @@ static void qcrypto_cipher_aes_ecb_encrypt(const AES_KEY *key,
 {
     const uint8_t *inptr = in;
     uint8_t *outptr = out;
+
+    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
     while (len) {
-        if (len > AES_BLOCK_SIZE) {
-            AES_encrypt(inptr, outptr, key);
-            inptr += AES_BLOCK_SIZE;
-            outptr += AES_BLOCK_SIZE;
-            len -= AES_BLOCK_SIZE;
-        } else {
-            uint8_t tmp1[AES_BLOCK_SIZE], tmp2[AES_BLOCK_SIZE];
-            memcpy(tmp1, inptr, len);
-            /* Fill with 0 to avoid valgrind uninitialized reads */
-            memset(tmp1 + len, 0, sizeof(tmp1) - len);
-            AES_encrypt(tmp1, tmp2, key);
-            memcpy(outptr, tmp2, len);
-            len = 0;
-        }
+        AES_encrypt(inptr, outptr, key);
+        inptr += AES_BLOCK_SIZE;
+        outptr += AES_BLOCK_SIZE;
+        len -= AES_BLOCK_SIZE;
     }
 }
 
@@ -106,21 +98,13 @@ static void qcrypto_cipher_aes_ecb_decrypt(const AES_KEY *key,
 {
     const uint8_t *inptr = in;
     uint8_t *outptr = out;
+
+    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
     while (len) {
-        if (len > AES_BLOCK_SIZE) {
-            AES_decrypt(inptr, outptr, key);
-            inptr += AES_BLOCK_SIZE;
-            outptr += AES_BLOCK_SIZE;
-            len -= AES_BLOCK_SIZE;
-        } else {
-            uint8_t tmp1[AES_BLOCK_SIZE], tmp2[AES_BLOCK_SIZE];
-            memcpy(tmp1, inptr, len);
-            /* Fill with 0 to avoid valgrind uninitialized reads */
-            memset(tmp1 + len, 0, sizeof(tmp1) - len);
-            AES_decrypt(tmp1, tmp2, key);
-            memcpy(outptr, tmp2, len);
-            len = 0;
-        }
+        AES_decrypt(inptr, outptr, key);
+        inptr += AES_BLOCK_SIZE;
+        outptr += AES_BLOCK_SIZE;
+        len -= AES_BLOCK_SIZE;
     }
 }
 
-- 
2.25.1


