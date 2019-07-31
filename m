Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A17C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E878206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkSMIXUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E878206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrMg-0003qi-Fq
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42391)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG7-0005up-E9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG6-00049v-1N
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG5-00048G-Or
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id p13so70305491wru.10
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lyP5gbjSZYFvC7g5QsskrcGKhwqRElrOHldYQXubnjI=;
 b=WkSMIXUxydI/KCqK6+zuYbzYnRKBjvosqzjsR/QrJpma8sM+g02VxrUKl0Edq5YsXm
 VYIs5nX9+kuxqNb4te6S/V5+p5eCdIepVmZM8MuN9Dr4hVrGRTFxRTqSUbeSCJ1f9C6e
 xMlbZ84BRxh7G871rBucEczQy8z8XZysSJaVowKsrCBsQQJG92hJrnzYB8VvB7qQcQ+2
 qIqdyOzwHCCfMov7rBjvTYvy5oyWjmjV0Umdjmm6BPa9ZJllf43fvdd0piM/B03SA7bk
 puSvZ9MnAtMUYw+S18z/3ohnGs5GANNYt+U69zumnAdwbm8M9e2R7NKG60ryd0BM4d3R
 CJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lyP5gbjSZYFvC7g5QsskrcGKhwqRElrOHldYQXubnjI=;
 b=jgS16WOq83br59RIpKY303kbs5HpeFh0VRQncPSKjsYzEN6H6O1c1+Uxg648zpO28R
 EC5eaHSbHe/v7WOXffy/RgYJ6SKKdbXEFz9HXRKyywIe3LgiLnbf5Gn8pZ8HKzNtM9R9
 j8kGr+08KalHrpkSUj/YEezn4BdjJ9G+eF7rpHa0oVaXKuK6z9ZT1sTPO6f1eM0T+cLT
 C4UDVAUsmR49/l47QSn8Pwl8kBcv91Ze+Y5P/kWJtP+wrxPPBPrY5gkoC08REkUO9jqR
 MTwoSHOUlSvN4z8S+C7NTDI+TaQBDjbojhEMA9uXUcSbC2ohKx3uvsw7e/nImXpWMBHC
 +VlA==
X-Gm-Message-State: APjAAAVs8J0nFsM4P4mkmooZIuFLR9ENqQxpO9ElzxxB1Fj9roEa4NXB
 Kbqkx25j80WIND8GNszkA+Q+Ig==
X-Google-Smtp-Source: APXvYqxAOPzse0KuhGxk5NEObK5X+GhyP5bP3dn6jrVgfUAiHWV87gxjiRge4GXi7vtMu1/21HVKig==
X-Received: by 2002:adf:f40b:: with SMTP id g11mr66901499wro.81.1564589718677; 
 Wed, 31 Jul 2019 09:15:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g11sm66774709wrq.92.2019.07.31.09.15.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:15 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3241A1FFA5;
 Wed, 31 Jul 2019 17:07:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:44 +0100
Message-Id: <20190731160719.11396-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH  v4 19/54] tcg: add tcg_gen_st_ptr
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 aaron@os.amperecomputing.com, cota@braap.org, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tcg/tcg-op.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 2d4dd5cd7de..698f3111eb2 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1249,6 +1249,11 @@ static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
     glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
 }
 
+static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
+}
+
 static inline void tcg_gen_discard_ptr(TCGv_ptr a)
 {
     glue(tcg_gen_discard_,PTR)((NAT)a);
-- 
2.20.1


