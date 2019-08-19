Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E7CC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED2F20851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkSLmk2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED2F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzh8u-0003vM-8m
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbG-000383-JW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbE-0007Em-Dh
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzgbE-0007AE-5a
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id j16so8477698wrr.8
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Utwbf3YuFsETI9r5r/jP/BTX9cC86U2GO16Ys38FQ5U=;
 b=HkSLmk2RYLAQiCflzGnW8+lmdiYtsRiKHfeFWgJGzdr2HrPtXMoGOK6QRLddGZuIf8
 O4TdTZZEUqan7It0v/hfVdvk3VRXjy2d30qKbVmr8vuZJB8oABrn7x4zifsqH75PBVrd
 MLLoP9DEORkU3cCUTzLZXdbVeEjUlh15v/COcYqU33jIq5IzvVt8etlvBlWv/vNuV7RF
 NQMKypUtrvP5JTxgVm5qFxCZkXHOEuvlnze4LyBHl9hja6TJtoXcv+K/mSzhDfLRe3Wf
 RjKgdvgBE43SeJFOmmrIcUSiIds461e5b1Owpd0dInlnMs2TH3c9U97ZElAnqldfKFdF
 vt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Utwbf3YuFsETI9r5r/jP/BTX9cC86U2GO16Ys38FQ5U=;
 b=nBFoRJt/iWp0AyAphr8EmdprNVbi3Tn09bCaH0AaYGhSK7htD5RXTAO0oUACfEc1Lo
 yWxfCSxczRZrP4NH6X7pYFfeh60CMYr8ab9RSZZRFwteK+NjvyWSL/xBBVtGo20gLlOc
 rGcO/yb8rQ0u076Dp0Q1tQH4fFNOPKkzrdY9IYTRo2Ko/GuIwhrHJKOZCu1m0pP3M4ct
 fihhYk7zWn+ERwk3ahpqhAxuLkdEkyEVPR8U2zY9h1428T0Uwx12s6TBCNhJBe+L7vc2
 HSZb2HNSVUie+m59pZQ8KZWVW08snXgZxDbwWbyv2yvd7Ct7U1pLpEKsOfmPpUYcwwUT
 p/Dw==
X-Gm-Message-State: APjAAAXvuP9yJhIo3Y1KOBnVeW3zMxIEc8vIN/WgqDNW+ArW5Vz5zVwp
 6o22lMUhUh8hoH8MrZ/ietkdzzUD2B4=
X-Google-Smtp-Source: APXvYqwvNu9+CNHauGYrxphcOZL7n9Z/w9k3peVJqm5N9aJ3A3/YGAtmbMJrzrhmilN8vo8ndmFe7Q==
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr26325586wrg.325.1566217037118; 
 Mon, 19 Aug 2019 05:17:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j17sm13108025wru.24.2019.08.19.05.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:17:15 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AC4261FF99;
 Mon, 19 Aug 2019 13:17:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 19 Aug 2019 13:17:06 +0100
Message-Id: <20190819121709.31597-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
References: <20190819121709.31597-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 09/12] fpu: rename softfloat-specialize.h ->
 .inc.c
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is not a normal header and should only be included in the main
softfloat.c file to bring in the various target specific
specialisations. Indeed as it contains non-inlined C functions it is
not even a legal header. Rename it to match our included C convention.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.inc.c
similarity index 100%
rename from fpu/softfloat-specialize.h
rename to fpu/softfloat-specialize.inc.c
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7ef0638d7e4..0638c9f4e03 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -634,7 +634,7 @@ static inline float64 float64_pack_raw(FloatParts p)
 | are propagated from function inputs to output.  These details are target-
 | specific.
 *----------------------------------------------------------------------------*/
-#include "softfloat-specialize.h"
+#include "softfloat-specialize.inc.c"
 
 /* Canonicalize EXP and FRAC, setting CLS.  */
 static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
-- 
2.20.1


