Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0322A20767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9aKhV9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0322A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmMZ-0000AF-5q
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmJx-0003Q0-P5
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:13 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:35753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmJu-0005tw-C0
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:13 -0400
Received: by mail-pg1-x52b.google.com with SMTP id g29so841030pgl.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=unhCEa+c++7uk9+yQ2XBvkX8JjrsH/tZ97/HnRS/zo4=;
 b=C9aKhV9zcNFwgMhf9cj1IdJ6dZpAscIBprz8wWvT4iq1HxyeIhWeoE2VtqQrvMtQR0
 0WwEXOWTUMLxTzWhS/zD+9pgo1PsD8xPooFp2LRoM6TBg9sOhfJtvCBaBgOrpL1jU+Cr
 mydkkEKeZAbg0CpprObEX7u3HyADIbQZIrTUza6MyZh+vHUSJmETbF/KMEUypwqgoIHL
 iullAOCQ5GgQa66sHqU6qbQ4AwyfO2BLYdPAcwROSoleU8BptHLBcEWuKzTSPtWxlx5X
 ZH2TdRASkkZeygNNUChr2uRX3zpZPnbTCOJg7xWCvcS0rs+PYeqBssJ2UHR749aTAjZi
 A5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=unhCEa+c++7uk9+yQ2XBvkX8JjrsH/tZ97/HnRS/zo4=;
 b=JIb+WNNxvKgkUl42KfJOtWz/tPQBiolD/47Ex4BIbY+GxOKHnzzKCVwIc5nGV4f9ji
 8pGsanQegVnbW8a6w0uRozhKm39xUfIuBOuGGb8Mxdq0e/XjO/py9AhXLRzgOJWTmNJs
 Fh7jF9SrQc8/CrchdqfYVJUHNF+tkFXyRM6QvganREbh531jhp4KvkYjtQz1N7ySy0vN
 14z2wUXGnNdAn7qSatuQHp9uiubZVMcOHbpVxSIYLc5hJR92ZrfL3PN0JfMBKhyv+C5V
 2Dyo/9o+f77gvTWUCKfQBLbqzuF6iUC0EHXNM/AlzQ5bedoNL4X6fzFggq3yrAJywx0/
 zxvQ==
X-Gm-Message-State: AOAM532uGYIiA7eVDa7z4rO4R4EoaApZSiNFK9oihSddzRLwXaL0+3HU
 mhi9aUbeAUgJukw3s6UUmvkUGwSpfQLWTw==
X-Google-Smtp-Source: ABdhPJyDtqdok+j03nMpUOxHCp1UMzO12T+qf4sH0KLNQDn+FaqoB1MZ7t2tCHSudCIXc1U5J5Sz5w==
X-Received: by 2002:a63:5c1a:: with SMTP id q26mr1788510pgb.223.1598889968668; 
 Mon, 31 Aug 2020 09:06:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/76] tests/tcg: Do not require FE_* exception bits
Date: Mon, 31 Aug 2020 09:04:48 -0700
Message-Id: <20200831160601.833692-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define anything that is missing as 0, so that flags & FE_FOO
is false for any missing FOO.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/float_helpers.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/tcg/multiarch/float_helpers.h b/tests/tcg/multiarch/float_helpers.h
index 6337bc66c1..309f3f4bf1 100644
--- a/tests/tcg/multiarch/float_helpers.h
+++ b/tests/tcg/multiarch/float_helpers.h
@@ -8,6 +8,23 @@
 
 #include <inttypes.h>
 
+/* Some hosts do not have support for all of these; not required by ISO C. */
+#ifndef FE_OVERFLOW
+#define FE_OVERFLOW 0
+#endif
+#ifndef FE_UNDERFLOW
+#define FE_UNDERFLOW 0
+#endif
+#ifndef FE_DIVBYZERO
+#define FE_DIVBYZERO 0
+#endif
+#ifndef FE_INEXACT
+#define FE_INEXACT 0
+#endif
+#ifndef FE_INVALID
+#define FE_INVALID 0
+#endif
+
 /* Number of constants in each table */
 int get_num_f16(void);
 int get_num_f32(void);
-- 
2.25.1


