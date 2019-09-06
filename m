Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F8C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058C22081B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kjf/G3XL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058C22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Kr1-0004wZ-43
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 16:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Koc-00036x-9u
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Kob-0002S2-3C
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6Koa-0002R6-P2
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id y135so8170146wmc.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 13:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hEwLxmZ1/l0uu9kShjHwMMLEdP39KievYwY8GQL60m8=;
 b=kjf/G3XL4HCyAAxLOZxqVlh6RbndTCua98iipPGPJMHbQE0BmtRa+oz6EdzzbXk1k+
 Wr4iZbzvvnK9TmGuVFJTFjDm7KGIqABPqLkBHTT748vaWKizGQ9ipjTYYjR8RZ7qiOPm
 iNa3gWw30vJeaEZ6dmBOqkvcD26dGYCWmBSV05MAyjHWW1Uxb7ppQwK+7EnAm5/+Y7TK
 Fs9fH1DZje3cD9xX5ta/4rW+JXz6M+iqnSOKk3tP9g+LYyWI8UaiObtbSTYZMbY1l8ll
 WNxn4yxE48zZBp+q6vHxfJNO/7FM6FQbOSlOdQ2iJqakvhiJxajlEImjEyXgFKfG3A4a
 +ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hEwLxmZ1/l0uu9kShjHwMMLEdP39KievYwY8GQL60m8=;
 b=GUFqHHQcKusB+ArBo+4xUIkKlE+2KvRnSIBpCX31/ctt0xUr2y/2zew7fFI8aWvrUm
 F28khQrjr5TvwG6U7USMPFHAOBT5hhfGvUgTWAKcrVQeciDwjsuJDjpnyP+ZJj8HCeaS
 TLrArF2OhOfi/mpwl1qDOoWmDaCOsGIf4km12XtPOK3bcG5dLzsib7M3mV4hBl0NStjz
 UxEsfEVoj2AoLMpZAB90lZuGoV0BSTq2T5FcPoc5djtyZbRFHR03cKyNXM/2HK9+Vis/
 bN+qcUHYXlfGor7Wi0T0mYmvvkgORRAtM0/TeC6Q+MIxxS4Sm1UaSmoOlnEPAMF7bBPe
 edcg==
X-Gm-Message-State: APjAAAWHSYH5mT/NHBRm9voL/GuOOhyU7edL6/imB/y0g0+tXRGXrnNy
 Fz36vYnBENoPjHr88E0XR1+9yg==
X-Google-Smtp-Source: APXvYqxYbMsLdmLdZ18av3Lu2P3uY2oZ76txqtj3Ak6t7GLSv72LwxgkTb9xITWnwU5dSSdAJ+Na/A==
X-Received: by 2002:a1c:eb0a:: with SMTP id j10mr9157314wmh.125.1567801599617; 
 Fri, 06 Sep 2019 13:26:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q5sm269955wmq.3.2019.09.06.13.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 13:26:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB08E1FF91;
 Fri,  6 Sep 2019 21:26:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  6 Sep 2019 21:26:35 +0100
Message-Id: <20190906202636.28642-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906202636.28642-1-alex.bennee@linaro.org>
References: <20190906202636.28642-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v4 4/4] atomic_template: fix indentation in
 GEN_ATOMIC_HELPER
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
 "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/atomic_template.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index df9c8388178..287433d809b 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -149,7 +149,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
 
 #define GEN_ATOMIC_HELPER(X)                                        \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
-                 ABI_TYPE val EXTRA_ARGS)                           \
+                        ABI_TYPE val EXTRA_ARGS)                    \
 {                                                                   \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
-- 
2.20.1


