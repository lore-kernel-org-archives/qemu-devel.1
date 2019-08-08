Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4C7C32754
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB45E21883
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDy8FIj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB45E21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvlWP-0000Wa-2x
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 12:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTg-0004T0-C5
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTf-0007Wa-1G
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvlTe-0007VQ-RM
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id l2so3081714wmg.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tUBhSG6/x7Tr0aypyO/Nit66ev0ekNFuf88g/cOO/o4=;
 b=hDy8FIj+EEmT7XM2OtG08Jp5V2Be9XnKMPqQUqSxtupoN6GaNYTMkzS1g3Xc4cM/a/
 lvHaunTJ9BqdVO83EXB16qPzL1sQmy5ciVTFpuGySpWttb7GWfN96dtjG3S7Jg2vo1HY
 p03oyVjqTxxzzu5q48AUfgEcPStkE4JpNFNV/t38w+o68r7g9WbSil5bCXwA/b4LMBXU
 GFZYkfb8wzgDtJzujtJfGrYShfHXnL7jOCAWkx3OVvGvIX7Hh2ScpLNHr6IJ0DCryTN8
 fd+i5VJikLWu2vtCakrlP+ncByaxRpgVsxFd/axzvVrtpd8WNiI0j6d6eC45Q0vPdfv2
 U5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tUBhSG6/x7Tr0aypyO/Nit66ev0ekNFuf88g/cOO/o4=;
 b=OgE8+GEN7jfwqi9DjRJyub7aak5KmayG6bzv/huzFFiyz8do2Sb0H5byK5IS9RVGPy
 p56NjRkD7/qhrVYDiJzkzYfzRgt7YXLmlRwN3YWXtidh44SJp9yyE3cyYPDG+xo+ALip
 CIESzFD5IikcPSJlUgjFOepfzU3+W9LhvIYkY+0m+qanpbgcTCDlGQDrkR8ET1bUi6X9
 s4ox5CcIOIBaaVeneMPBogLQHGv80fU/GhrSNWkYcd1TYn5jBHrdGV72UmocLPMrQLN9
 VVT159KMVwPpc9zzexpCemylKJ1lyrYu4V/ovvwiUdc5RbZF8LvAUb3fuE6cRa3Ddyxm
 GDIw==
X-Gm-Message-State: APjAAAUpsgqQ1FniH0J9zh5nNX6N2r5N+KeyiLRizKw9Yk8M3vwh2CtJ
 idx8O8ejXJvNU/4VY8FM8nMnoyIHtgk=
X-Google-Smtp-Source: APXvYqzL5FT85zS6G032fCEUMFkuT4H+WaEna1+AVaA2KYqlH8XUDFx2JIVQruVHocQIWjpyljAoLw==
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr5288225wmu.67.1565282481732; 
 Thu, 08 Aug 2019 09:41:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x20sm209525398wrg.10.2019.08.08.09.41.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 09:41:19 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B49FF1FF91;
 Thu,  8 Aug 2019 17:41:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 17:41:14 +0100
Message-Id: <20190808164117.23348-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808164117.23348-1-alex.bennee@linaro.org>
References: <20190808164117.23348-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v1 4/7] fpu: rename softfloat-specialize.h ->
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is not a normal header and should only be included in the main
softfloat.c file to bring in the various target specific
specialisations. Indeed as it contains non-inlined C functions it is
not even a legal header. Rename it to match our included C convention.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/{softfloat-specialize.h => softfloat-specialize.inc.c} | 0
 fpu/softfloat.c                                            | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename fpu/{softfloat-specialize.h => softfloat-specialize.inc.c} (100%)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.inc.c
similarity index 100%
rename from fpu/softfloat-specialize.h
rename to fpu/softfloat-specialize.inc.c
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2ba36ec3703..80a16458304 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -652,7 +652,7 @@ static inline float64 float64_pack_raw(FloatParts p)
 | are propagated from function inputs to output.  These details are target-
 | specific.
 *----------------------------------------------------------------------------*/
-#include "softfloat-specialize.h"
+#include "softfloat-specialize.inc.c"
 
 /* Canonicalize EXP and FRAC, setting CLS.  */
 static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
-- 
2.20.1


