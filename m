Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6C0C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7112467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkuuiJr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7112467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irODQ-0002u7-Kj
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNy1-0008Ve-MF
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNy0-0008CJ-92
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:53 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNy0-0008AM-1m
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:52 -0500
Received: by mail-wm1-x341.google.com with SMTP id w5so2542662wmi.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xrL98QqACLXFusR89lTBCTfiY5Snnqcv9MdmoeZvdOo=;
 b=NkuuiJr266TnnVPr6qsppAHjvQeT4H7FxJV+ZaH5d9qQ7h/rhsLtxftFLSG9ZghxUl
 tCa63adg9CEC0hEr1FXhiZgtQXfIjPWLL64NXOEaJ4eq4qqdWCy9Ej5huL74YbN8frLm
 +KCVUmOqhFBPG6XkBcGb0Jzi6abxhOahUapxoJ5hZ8BoUweg8POoZk3dHSt1K7tJLtAQ
 hf7w8lnBzn7+K5Jp2cLn5CxHddrpWxUJOzJo3j+Q2ZDQyrY7sBp7MCIXdXUxaXXFqlaP
 H+kXUoStt/kK/S6WODZ9ml/qdNafrFDQo9Hwwucq518kA4mOw64XAYChQRzYjSNhjYX9
 p9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xrL98QqACLXFusR89lTBCTfiY5Snnqcv9MdmoeZvdOo=;
 b=HAsyVH+nA9U7HcsVMxAm8pw0m9zv2U5SU7ZJNELeGSRHD7DDz2VTKl6HTsNCEVuDqZ
 tMP7tc/MAOsopFGTjsI67+v9oXOB23cRwoHgM3nOq20qpN9hHTL48UEp9Ja5JlvHU1pR
 Gx5E1pi6H6k4n0xQunFOvYv+TzLaUaVNnUQTZeVJS6kb+46EgETyzPMPKkgeipG27HQm
 sktrgXyZDzFZKuhIeZb6A2G48CERfUIIDPvbxE477IJcr+kcgCw+9wzU9N5WI52TcqC2
 F+5HELAiH+8GmyHf6rXxv8B1GLSsnOffA5qdGgLaGVohjBHRPGLWYQtdTaCEKzWQbCyU
 stRA==
X-Gm-Message-State: APjAAAXubXYo3YGUWWvaSoiIk6eZpnbKM+okclr4IvBgmgzeR/07mylh
 uabmdj0MY6I6/yz92cW/t6AMl5slZiA=
X-Google-Smtp-Source: APXvYqyE4P1iWZZcynEvHUw0hu6tvepVJWJncA7lu8wLuIWRtcBv8PKkSSnBPQMXBhrG8Ujc1LMSHA==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr28589201wmc.54.1579015131028; 
 Tue, 14 Jan 2020 07:18:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e12sm20071276wrn.56.2020.01.14.07.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:18:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4C9141FFA5;
 Tue, 14 Jan 2020 15:09:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 19/22] tests/tcg/aarch64: add SVE iotcl test
Date: Tue, 14 Jan 2020 15:09:50 +0000
Message-Id: <20200114150953.27659-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a fairly bare-bones test of setting the various vector sizes
for SVE which will only fail if the PR_SVE_SET_VL can't reduce the
user-space vector length by powers of 2.

However we will also be able to use it in a future test which
exercises the GDB stub.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - use index to fill zreg
  - CROSS_CC_HAS_SVE
v5
  - merge conflicts
---
 tests/tcg/aarch64/sve-ioctls.c    | 77 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  4 ++
 2 files changed, 81 insertions(+)
 create mode 100644 tests/tcg/aarch64/sve-ioctls.c

diff --git a/tests/tcg/aarch64/sve-ioctls.c b/tests/tcg/aarch64/sve-ioctls.c
new file mode 100644
index 0000000000..d7bb64d53f
--- /dev/null
+++ b/tests/tcg/aarch64/sve-ioctls.c
@@ -0,0 +1,77 @@
+/*
+ * SVE ioctls tests
+ *
+ * Test the SVE width setting ioctls work and provide a base for
+ * testing the gdbstub.
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <sys/prctl.h>
+#include <asm/hwcap.h>
+#include <stdio.h>
+#include <sys/auxv.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+#ifndef HWCAP_CPUID
+#define HWCAP_CPUID (1 << 11)
+#endif
+
+#define SVE_MAX_QUADS  (2048 / 128)
+#define BYTES_PER_QUAD (128 / 8)
+
+#define get_cpu_reg(id) ({                                      \
+            unsigned long __val;                                \
+            asm("mrs %0, "#id : "=r" (__val));                  \
+            __val;                                              \
+        })
+
+static int do_sve_ioctl_test(void)
+{
+    int i, res, init_vq;
+
+    res = prctl(PR_SVE_GET_VL, 0, 0, 0, 0);
+    if (res < 0) {
+        printf("FAILED to PR_SVE_GET_VL (%d)", res);
+        return -1;
+    }
+    init_vq = res & PR_SVE_VL_LEN_MASK;
+
+    for (i = init_vq; i > 15; i /= 2) {
+        printf("Checking PR_SVE_SET_VL=%d\n", i);
+        res = prctl(PR_SVE_SET_VL, i, 0, 0, 0, 0);
+        if (res < 0) {
+            printf("FAILED to PR_SVE_SET_VL (%d)", res);
+            return -1;
+        }
+        asm("index z0.b, #0, #1\n"
+            ".global __sve_ld_done\n"
+            "__sve_ld_done:\n"
+            "mov z0.b, #0\n"
+            : /* no outputs kept */
+            : /* no inputs */
+            : "memory", "z0");
+    }
+    printf("PASS\n");
+    return 0;
+}
+
+int main(int argc, char **argv)
+{
+    unsigned int sve_feature = (get_cpu_reg(ID_AA64PFR0_EL1) >> 32) & 0xf;
+    /* Exit early if we don't support SVE at all */
+    if (sve_feature == 0x1) {
+        /* we also need to probe for the ioctl support */
+        if (getauxval(AT_HWCAP) & HWCAP_SVE) {
+            return do_sve_ioctl_test();
+        } else {
+            printf("SKIP: no HWCAP_SVE on this system\n");
+            return 0;
+        }
+    } else {
+        printf("SKIP: no SVE on this system\n");
+        return 0;
+    }
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index aba17881e9..66addbc52f 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -44,6 +44,10 @@ ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
 AARCH64_TESTS += sysregs
 sysregs: CFLAGS+=-march=armv8.1-a+sve
 
+# SVE ioctl test
+AARCH64_TESTS += sve-ioctls
+sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
+
 ifneq ($(HAVE_GDB_BIN),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
-- 
2.20.1


