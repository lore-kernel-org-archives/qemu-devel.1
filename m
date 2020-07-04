Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78E6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 09:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BAA20739
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 09:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IdUoZ5KQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BAA20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jreOr-0000X4-Qt
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 05:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jreOJ-0008LC-SR
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 05:23:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jreOI-0003SI-2V
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 05:23:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id 22so34167795wmg.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MHkoxi+EkVCFW4Wg+U688/CA12tSJrQLvZAe0iXiD3s=;
 b=IdUoZ5KQs17te3PKz1bWyJMvBglYxRRCD2aeb9T9gGyOq3AX6zID5g5F5nF5lvSl4t
 gnbkKU+XnpQ70VnW74dOisyUfSfqLOi16DVu8Kvak+2ZSa7ReU2NgGhdESqobELDY0PE
 31sj8GaNwHOA5kt9L0WiffLLXwgLD2LhMSO+UgeSrXJmAmKILseBGCP5RtFLIiDis8Mg
 pxKUEaFQUn7ubze+84Onnh+06DzeZAULYphdYpLMqKAzis+4nwB8f5knCgRi4xMVH5tr
 18lLOqGn2nIDgPYlbgdyEI1KdP8Mio2SGk+lkgnXXpzkzmQWUn7lNeZvXHIzdiESROEk
 sSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MHkoxi+EkVCFW4Wg+U688/CA12tSJrQLvZAe0iXiD3s=;
 b=EY5ePe4/MdNl8V5UECLbpqnOCm5lnwsRXYKe8ty/y6VG06iFL0u0wB5vavPJPj1W3v
 xrPqeZ08QCXreN41tIaSJ8M2ELxBUvf5TlLR89PBdftUiPOOwketnfQDDlU7G8gZSox6
 HMwSKmfB/z9DEMXKOUHQkubFDhiVWO7+TvlsI+zuwpx1SX7OIsyEFFVTGtaOPf3YoMFM
 4VZbhGTRCimJq8TOCvQ4NqAUnke8Mm1k3mSRyRtVwLyGFlZgyltE5Wrj+YJ2PJyFBDZ9
 3rK03xZskyfcSaNRfqoeABJowj2aIpoMSGwmY3vDOznDdLEDffRLN+0i2Ry+e1LL0QiH
 a8kg==
X-Gm-Message-State: AOAM533pLehRDLFoqyA1skzykAP4mYgLOv2WKucDREyqhrLoxlVwMFZW
 yOHegFeEEHBNayKhTAxQxdP9+HqZ8v+86w==
X-Google-Smtp-Source: ABdhPJxzcFfM4SQShMtoJYaI0lDRDbNcrwPQ5e/ZLrZLijhVgRNY5W6W73w6lnGhj/YOXwun8hLIWg==
X-Received: by 2002:a1c:398b:: with SMTP id g133mr39065734wma.76.1593854600279; 
 Sat, 04 Jul 2020 02:23:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm4104764wrr.85.2020.07.04.02.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 02:23:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] net/tap-solaris.c: Include qemu-common.h for TFR macro
Date: Sat,  4 Jul 2020 10:23:17 +0100
Message-Id: <20200704092317.12943-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit a8d2532645cf5ce4 we cleaned up usage of the qemu-common.h header
so that it was always included from .c files and never from other .h files.
We missed adding it to net/tap-solaris.c (which previously was pulling it
in via tap-int.h), which broke building on Solaris hosts.

Fixes: a8d2532645cf5ce4
Reported-by: Michele Denber <denber@mindspring.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Untested: Michele, could you give this a try?
---
 net/tap-solaris.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 4725d2314ee..d03165c57c9 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -27,6 +27,7 @@
 #include "tap_int.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu-common.h"
 
 #include <sys/ethernet.h>
 #include <sys/sockio.h>
-- 
2.20.1


