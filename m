Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF325C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85984206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2Y3K20S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85984206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrHg-0000FJ-Q4
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42320)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG5-0005pF-NN
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG1-00047A-PY
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrFz-00045h-RA
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so70412745wrs.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hRMRp/kI4c6YkREQzYFhfvajgB0U5gRdKHztblUpjFI=;
 b=j2Y3K20SDQD+/el2Zi3u3VV+45SKWz+Eel35LKG+Am/PqcOqxfhtKH5492aI24/bzj
 har7/X4PRmRUFNPIs2d2S+y4PfO5xrb9Y6LkvaTllYZShHH6l5Z3nQ4+2SvVWIS45TzG
 /gA0f7IXU9m96Ll1qCWHbWGdQyeaqosA2Ojjm0huVBehynvhHN+ke33Quxoa71KnqXCr
 pg+ZhawYUURQjGGUhbCu10fwZLNrXbsa5WYe38GkR4f2hFipvhImgm0o7HUZmxCqr32a
 WkMIz+pchCp2fKWG0RBO/AoF0uJL1OljncOF6c2a53c+rrmBTwSDiKiL117hwDVsQkHz
 6PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hRMRp/kI4c6YkREQzYFhfvajgB0U5gRdKHztblUpjFI=;
 b=omi4u989LhcGafDQvDWcn9L8EtmPRTnvoLU3Aqn5AR+dwQJy4nXhVCLlFEMxNga936
 PkwlIL3Xvb+3qHfcg/w0ro9Vow5BQxFa73+hoGj9465zOdM1hQ2qK7z2Sd8gzd4xNnmX
 EXW3Q2f/ElcTDyPChS4DqHx5EmeYue43e8e67EgjM5QnzV95ux0Ok+0qLUYiR4homMSU
 CeJ9rC+gIBtoM/jRUSPRpyyYNEXZpMVeXCwEyKe5fUz7SjO0sChqkvlC9QMu3miDRiSP
 WAWFHFIa5XLV1dUGpuuOpDyYZWazWU8lA93mf9++Etx30o6H0ZoyrvutgiErAnNj6+DT
 6GzQ==
X-Gm-Message-State: APjAAAWW7E7cFQJwm0Sgs2nbGftMcrsVqyTQ09760dgGC1eVQkMLAKtx
 GYE8FCQrLJbdmi4XWtnhyVTu6Q==
X-Google-Smtp-Source: APXvYqzhiljH59Xbyu6AsqatCyuXim7vcES7HuHQvwoNYB8jLxmb6hQi0Yn64kKMX6dgdkPVuSnqpw==
X-Received: by 2002:a05:6000:42:: with SMTP id
 k2mr14230044wrx.80.1564589714403; 
 Wed, 31 Jul 2019 09:15:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g19sm79297294wmg.10.2019.07.31.09.15.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:13 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 594F31FFCA;
 Wed, 31 Jul 2019 17:07:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:18 +0100
Message-Id: <20190731160719.11396-54-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v4 53/54] include/exec: wrap cpu_ldst.h in
 CONFIG_TCG
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This gets around a build problem with --disable-tcg.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/exec-all.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index c42626e35b1..e6b9b460c81 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -21,7 +21,9 @@
 #define EXEC_ALL_H
 
 #include "exec/tb-context.h"
+#ifdef CONFIG_TCG
 #include "exec/cpu_ldst.h"
+#endif
 #include "sysemu/cpus.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
-- 
2.20.1


