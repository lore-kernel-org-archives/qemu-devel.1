Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66429C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8A720756
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGTeMRER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8A720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63xO-0004yl-Bu
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sM-00058r-89
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:58 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sK-00009k-4j
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:57 -0400
Received: by mail-pf1-x443.google.com with SMTP id m71so2107851pfd.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TcYIyipPkI2d2aP17J0suGRqHmTuPSrIckZvWVvyskc=;
 b=MGTeMRERtIQu9/aSHMjQ9sttR+a5b/lKB9WXQLADMrjS6iq6xqMNdKLKpc3J8VOQ+m
 xueKzzFSn4K8sKnqvez2Fw4b1yo5NqPO77SDeUdtrRQSvHeLDyxiBblEb4CAk8usWPnW
 Xil7Tv/7X5qJgnTkR0RxPRE4qXQALVp3VHXdEUHTGOthy4qdfKjVx2Tsa40Dt5Z1nAjJ
 ODx1H28xy44x0VeP6odFCMYLjQwU9lzB1qJFwa0Zu2FMPZZDAHGdTTPRwlIc/qwzmYir
 bB0DekBSJ2XMfbDodxAJCnpzZcVNTV3eunIVREKlB+H6AXDmYW8kHIbUwddr/ZIs2oiM
 KE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TcYIyipPkI2d2aP17J0suGRqHmTuPSrIckZvWVvyskc=;
 b=qQlQ6BDURlXKlThAcXDeQqzJG8CU/3QenKTE/WpNswUruxbYAo44VFajI+Akf42nTM
 OJ8V2JtNNjMxaNUKofJ2D7xi/4/ZieOKPRzNXX+9jdzu/jsiOvkg1Ejq9nnXT/OKlllA
 YiAMfAxoYcQ9QlSIDxxvEDjwp0P91uu2qzdWxdfATmUeT/lk978A2zhoD2PYfiPYQlj6
 qi5b9r0rvOiTr3i0JJ3SRt00oeZwiP8uKGhP8H+vocRRznzXcT6qsDGj86IfL9huNCNV
 +i0/9fhR5yxEY5h5ehyizwzzHzew6UmUvHvCrQ6O/xUHSxkwdV8vQT73C1Q3Okh9E6yB
 /WsQ==
X-Gm-Message-State: AOAM533nb7ap6rMzFA8JHscBHqu3/3Q1DnvLimnqP25Wm1zDgliCTLmh
 x4rjkYBDNKmVr2F5spIyH+pt0kTraKU=
X-Google-Smtp-Source: ABdhPJxaMp+LOqWJtyB2mnInBPzjrFfNtw+aJ9mSNJ6I6TT3mimxRzwu/A24db/dAX3v2oXyQT5dKQ==
X-Received: by 2002:aa7:9904:: with SMTP id z4mr2435215pff.32.1597289154407;
 Wed, 12 Aug 2020 20:25:54 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/17] crypto/builtin: Remove odd-sized AES block handling
Date: Wed, 12 Aug 2020 20:25:31 -0700
Message-Id: <20200813032537.2888593-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-builtin.inc.c | 40 +++++++++++--------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/crypto/cipher-builtin.inc.c b/crypto/cipher-builtin.inc.c
index 1444139f36..e2ae5d090c 100644
--- a/crypto/cipher-builtin.inc.c
+++ b/crypto/cipher-builtin.inc.c
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


