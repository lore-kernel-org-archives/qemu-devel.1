Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A245CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EAA8208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OijwdnFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAA8208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsyf-0007ZE-MY
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdswd-0003UU-UM
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:05:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdswb-0005CZ-Cm
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:05:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id j10so7799058wrw.8
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7BwVQR+RWIzqLy1PIq/KCliSSJ727LeNTpr8QNS3EBg=;
 b=OijwdnFog7MJOKgQXuIpzoT9zTo2dRa22snN1e8PLCTgtegtiufaLSHXf31GGRSzo5
 i3EmIUqduEqP3s20UJIESHxq2Sy0zkU5gqtWbjJKOz6lqcH9VpTyX3iX4Zz+V++zEPbM
 nrWxXM6MVBIh9YyzSp12zYwLWdsWad/KhJAJMi29K+8Snk0AvjBPmvUVj3RPyduqeOGf
 yRRu5ZGGq/gO2hXnEAA2Vdp1PPdaAe0185NhbFZcH4TUfPbw3vSLf9CE7TqoWY2uGtPm
 Rt3OLk9viPuNE04H6uqTp/Y6NhiNGKB113jJejopfwxKOK0T1lrxS2uiwGQoHxT7VqfR
 Na7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7BwVQR+RWIzqLy1PIq/KCliSSJ727LeNTpr8QNS3EBg=;
 b=n9xBy2tdz3ssqYvdt7QBaMWtkRIsA4Ca69bo3zKtfEnqHlP3mJiKhjHxN7QZCS77/k
 oTaIRBVBbvyfNrg/sm2r8izx6TK9CDI9VQOCpCbppiQgaWW9y7vV9cz8FAifzPn0YCWV
 LSNHCXvvzkrHQg+aEbh0He6rZSqQ86HZZetvldJ2DG86aMhuiFJypk3PqCjHRnJGBKbK
 Ry/HPbZo9kyzCewBRFiXufnfob5NJCM+AR39jdlG1II4b6qco6W/mBDa7g+qiXMTwk5h
 pSmCG+14EGiLZcrk5z6nr9RAliQ+N7dnAoiGK1ZzhwpdBsGMIJBeeYA5wWpFY4vOuSGz
 4qcQ==
X-Gm-Message-State: AOAM5321Mra5RPHiL7jIovFA6i2Z4Q9PPuvO+rSSyMvVppbgOQAbadwZ
 252NTATJR2c4YNk3Ax48D+akdg==
X-Google-Smtp-Source: ABdhPJwGurJiv8ZSbyhr+zuL3upZs0F7DKctk9YFB3PPnoOrai7qTWgzQhABnoC9ExuVssKBuB4Lsw==
X-Received: by 2002:adf:e38e:: with SMTP id e14mr25153823wrm.2.1590573951548; 
 Wed, 27 May 2020 03:05:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t6sm2202636wma.4.2020.05.27.03.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 03:05:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 479B81FF8F;
 Wed, 27 May 2020 11:05:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/3] tests/tcg: add simple commpage test case
Date: Wed, 27 May 2020 11:05:46 +0100
Message-Id: <20200527100546.29297-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527100546.29297-1-alex.bennee@linaro.org>
References: <20200527100546.29297-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The COMMPAGE are a number of kernel provided user-space routines for
32 bit ARM systems. Add a basic series of smoke tests to ensure it is
working as it should.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/commpage.c      | 61 +++++++++++++++++++++++++++++++++++
 tests/tcg/arm/Makefile.target |  2 ++
 2 files changed, 63 insertions(+)
 create mode 100644 tests/tcg/arm/commpage.c

diff --git a/tests/tcg/arm/commpage.c b/tests/tcg/arm/commpage.c
new file mode 100644
index 00000000000..c76e70cb8bd
--- /dev/null
+++ b/tests/tcg/arm/commpage.c
@@ -0,0 +1,61 @@
+/*
+ * Verify the COMMPAGE emulation
+ *
+ * The ARM commpage is a set of user space helper functions provided
+ * by the kernel in an effort to ease portability of user space code
+ * between different CPUs with potentially different capabilities. It
+ * is a 32 bit invention and similar to the vdso segment in many ways.
+ *
+ * The ABI is documented in the Linux kernel:
+ *     Documentation/arm/kernel_userspace_helpers.rst
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+
+#define ARM_COMMPAGE      (0xffff0f00u)
+#define ARM_KUSER_VERSION (*(int32_t *)(ARM_COMMPAGE + 0xfc))
+typedef void * (get_tls_fn)(void);
+#define ARM_KUSER_GET_TLS (*(get_tls_fn *)(ARM_COMMPAGE + 0xe0))
+typedef int (cmpxchg_fn)(int oldval, int newval, volatile int *ptr);
+#define ARM_KUSER_CMPXCHG (*(cmpxchg_fn *)(ARM_COMMPAGE + 0xc0))
+typedef void (dmb_fn)(void);
+#define ARM_KUSER_DMB (*(dmb_fn *)(ARM_COMMPAGE + 0xa0))
+typedef int (cmpxchg64_fn)(const int64_t *oldval,
+                           const int64_t *newval,
+                           volatile int64_t *ptr);
+#define ARM_KUSER_CMPXCHG64 (*(cmpxchg64_fn *)(ARM_COMMPAGE + 0x60))
+
+#define fail_unless(x)                                                  \
+    do {                                                                \
+        if (!(x)) {                                                     \
+            fprintf(stderr, "FAILED at %s:%d\n", __FILE__, __LINE__);   \
+            exit(EXIT_FAILURE);                                         \
+        }                                                               \
+    } while (0)
+
+
+int main(int argc, char *argv[argc])
+{
+    void *kuser_tls;
+    int val = 1;
+    const int64_t oldval = 1, newval = 2;
+    int64_t val64 = 1;
+
+    fail_unless(ARM_KUSER_VERSION == 0x5);
+    kuser_tls = ARM_KUSER_GET_TLS();
+    printf("TLS = %p\n", kuser_tls);
+    fail_unless(kuser_tls != 0);
+    fail_unless(ARM_KUSER_CMPXCHG(1, 2, &val) == 0);
+    printf("val = %d\n", val);
+    /* this is a crash test, not checking an actual barrier occurs */
+    ARM_KUSER_DMB();
+    fail_unless(ARM_KUSER_CMPXCHG64(&oldval, &newval, &val64) == 0);
+    printf("val64 = %lld\n", val64);
+    return 0;
+}
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 11c39c601ea..3da09a38be7 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -68,6 +68,8 @@ run-semiconsole-arm: semiconsole-arm
 run-plugin-semiconsole-arm-with-%:
 	$(call skip-test, $<, "MANUAL ONLY")
 
+ARM_TESTS += commpage
+
 TESTS += $(ARM_TESTS)
 
 # On ARM Linux only supports 4k pages
-- 
2.20.1


