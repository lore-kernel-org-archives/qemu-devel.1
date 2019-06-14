Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A0C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E709620673
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDLRUGuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E709620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbr8p-000079-62
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0K-00076g-AJ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0H-000401-Qr
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35312)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0G-0003ms-TE
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id m3so3381117wrv.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fvj+WUGANmLFqW2EJSINSwwcAn8sLAyNi/cgHqJTnR8=;
 b=LDLRUGuRo1k6ccAgdmq4PXLjpEXU1bA74OtyyoAn2v/rzsoR6vBnHY0p5mwIKlEyw1
 jTvhICmW2dK0obdWwmS0dpI+bPC7apkvpWKg/j2QNq47JejrjvqxM8FO2hFt29J4UOI9
 u2XYHX5v8xxKo0ruXvTEwvhjtGWHFv7ZKmlNEzpCuM074r1VANN6z03PQ+FgDJpnhdQy
 iJowrWJmlYligEcU44Kv400TMHbJdnkZhji1SS74EMGiweLSPmINL3tzDsj2Zl1wzdFw
 b+AD3ST+ePK1lTygQwBdfMAQ5EAQU5zOn/cZu7534sWH8sOyKDecHHEuF6YA1UFtBBsz
 U0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fvj+WUGANmLFqW2EJSINSwwcAn8sLAyNi/cgHqJTnR8=;
 b=Lr/phDMjf9ewz7FuDrFz7PK8nI7vim/m2h5z5dY9PrdJ8ThNBzdMNzuVmNxr9PL7uV
 JkJk5rhz9Zkqj2cepqroNP9tQMEckw6AQ4/axlF1t390wxshNxj76E1h3r7qB+FulYJ7
 U0U+UVrnranKDXtpmqXbPLkkV1+UHV8yE9GLLuJeg4N0niMaHfFSmW4UKreKepUUsA97
 E6XapmIIkHJUU00L+T6NTacNiARJLBXUH1x8B01Otu8i2MjsGlSFiYDCv+NL06C6bD9W
 ZZgb3/s6nFMRRbqqNSHOHdoABtC1Khz61nhyhpX5BuQFNMsj9A+mutPQ6ff5/80fC3/J
 0DYA==
X-Gm-Message-State: APjAAAVXJXUmsurtuQkOqSLLkZvA0JZVtXSQo7bgihdwm+IfTDzRa1hF
 s1ECf15Etlg+1+pCXRuV4yKOLg==
X-Google-Smtp-Source: APXvYqxuD3a0pD9ZYdthvGwCJzuOkmP1GyY2kDx8kJ8s512Pu3NpRPYp3mZIWNsjszVYbr7M4+uwSA==
X-Received: by 2002:a5d:548e:: with SMTP id h14mr12198151wrv.76.1560533311917; 
 Fri, 14 Jun 2019 10:28:31 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o2sm5672335wrq.56.2019.06.14.10.28.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AAF071FFC6;
 Fri, 14 Jun 2019 18:12:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:57 +0100
Message-Id: <20190614171200.21078-48-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PATCH v3 47/50] accel/stubs: reduce headers from
 tcg-stub
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need much for these. However I do wonder why these aren't
just null inlines in exec-all.h

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/stubs/tcg-stub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 76ae461749..431ec7d7e6 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -11,10 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
-#include "tcg/tcg.h"
-#include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 
 void tb_flush(CPUState *cpu)
-- 
2.20.1


