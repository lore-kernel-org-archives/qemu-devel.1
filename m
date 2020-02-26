Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2063C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0ACB24650
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhZKl9/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0ACB24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71Ai-0002Cx-RQ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j718d-00077h-UN
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j718c-00065A-PU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:27 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j718c-00064S-Iu
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so284128wmb.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hTO2TJKTVn6zYRsBqCfNS47JQf5FFH1MtA261qT+XBk=;
 b=XhZKl9/y1LXlkcu4qnQDHpOSISFfZXX5rZTkBK3XsCMR7LgI/JUaD75+mDloiGDs+T
 DXpIrXPkXY90+FfirwZzGMYnna1qoqIjQnYRFbTq9zNYGmSXJxAe2cV4Sx+ZFWeSQ5uy
 6Fg/RNivdqoJT3z0YPHlO+C4z5UpSDqsGFJWvYKm0BUfKNes/OEc16rr6bYiIlByZ2Yv
 XOw/lf2pQRxWwVkFScpLm274JOJ8tBR7W/SyED7t7ofrxHj1Y4Y8QtjfxcYfM4z05RFa
 eWK+wv+PK3az5Ez5I6MD6LlHHe8PAV4Y1Loejl1G34+ceN0QVFM1IY6D3uj+11egqODk
 Z5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hTO2TJKTVn6zYRsBqCfNS47JQf5FFH1MtA261qT+XBk=;
 b=rA/ZhhilYWaW64TjBv/2haZY/lwBFyMzommhW/4ULX+VQKmOqhgrHvi4LX8j+PiSKc
 U+IMGxU/sdsiWpETj9XO0r7D9c7aqjKzyp+cWrMP+V3RwTqoq19/SngArF1TisC/TRVd
 AUWLKfrpJ5RZf5YgcYlcHNmu7D3oeGH53BWGou0CBYX03TQ6gymBTt6KtNxOAVO2boXo
 h9aoMgfpb9Dd+WmjrPP7CQKPI3lyt1NHNxHqIr9tNy5Bago2gRWgoIkPk3EX3dDLrDjT
 veCK5e8Whd7V0ZpulvQv9JB6jewfHNCtlIiFTLFPWDgZo6TfuJ49nv9gIEVyiJUPO38z
 xLow==
X-Gm-Message-State: APjAAAWTYvsqnIcl+X7ViSJOnJOq0kaP8ino59LK3KX1zK5Ug1FO3rlI
 e8XMeKwDs3VUqurVSlZ0a60qWQ==
X-Google-Smtp-Source: APXvYqzQgMdzyv1kRIJ0A5xZ+8PIob9SLYhIZRVPTr+Ie+CbSKOG8v5VAmbmd0Cdfaay52qGOEfKSQ==
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr110130wme.25.1582740625545; 
 Wed, 26 Feb 2020 10:10:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z10sm3867301wmk.31.2020.02.26.10.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 10:10:21 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 08C411FF8F;
 Wed, 26 Feb 2020 18:10:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/4] accel/tcg: remove link between guest ram and TCG cache
 size
Date: Wed, 26 Feb 2020 18:10:18 +0000
Message-Id: <20200226181020.19592-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226181020.19592-1-alex.bennee@linaro.org>
References: <20200226181020.19592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Basing the TB cache size on the ram_size was always a little heuristic
and was broken by a1b18df9a4 which caused ram_size not to be fully
realised at the time we initialise the TCG translation cache.

The current DEFAULT_CODE_GEN_BUFFER_SIZE may still be a little small
but follow-up patches will address that.

Fixes: a1b18df9a4
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 accel/tcg/translate-all.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 238b0e575bf..5b66af783b5 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -938,15 +938,7 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
 {
     /* Size the buffer.  */
     if (tb_size == 0) {
-#ifdef USE_STATIC_CODE_GEN_BUFFER
         tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
-#else
-        /* ??? Needs adjustments.  */
-        /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
-           static buffer, we could size this on RESERVED_VA, on the text
-           segment size of the executable, or continue to use the default.  */
-        tb_size = (unsigned long)(ram_size / 4);
-#endif
     }
     if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
         tb_size = MIN_CODE_GEN_BUFFER_SIZE;
-- 
2.20.1


