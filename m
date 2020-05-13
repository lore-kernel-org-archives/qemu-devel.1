Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D23EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF0B2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHdpc28E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF0B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvFx-0006ZM-T0
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEr-0004lH-3j
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:33691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEq-0007mO-5w
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id d207so9442810wmd.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U+wDRXFAS4OV7UFOFmLqxoBwV2cM218whk06u8SrwM0=;
 b=RHdpc28E4Tt6y22isUBMIn8q5whMNRVJj6Py0aVZ5o5Ebhh7Md+Y/fn18RcdZNk9bz
 ur/kzq1cGMyz/7gBQ8qQxRK3Ib0FtwlO7ru9+eW+Oj6tqOE16BmFziwo2tEFt7N+iprZ
 Q+TV3Z4lxeYvnhlLT8Slrir3hGuNfnlDdCwATV9VQvMrOppoMOgxRP9LOKxghTsru2Ec
 eO4T9D2gw7aOpvKf3ekL4kjsGuHQPAy9KPV5U1QyClvhaUYSqVVFd21TtooOsHNVeYWG
 Rc26eiezzzpZvBf0rhPMDlUwRRm/JvrRzt9s1D0uvvnLu1wLGwPeqruqOAO0zsrO7pmZ
 Jv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U+wDRXFAS4OV7UFOFmLqxoBwV2cM218whk06u8SrwM0=;
 b=AF3+ebRCeX34NH4NmvoTYIpczQ5Vixkb8NylSUXfJG5W+N2rN1ZbEeHoNdTatmh9OW
 /zFDGH8Va9ClZlGrC2afVPSEddkvPE5yWejIlG57P9EeiewvRhjCuvPzJb75Jnweug1W
 LeP3FSBlDhJ4BFPUNLPDyiVWS5SME1/7P2I9Rook8JYloNjPPUZ6fgi8gwTabPGu+vyy
 BzvoiNekfAlKFkQzetTVEw4vD9xx0entCqviYSRBoTV9F2UHm4SDhS187k8j61UosY2y
 Bq/ypjfMaC/5ab+ZMfIYnrlElxb2pyC765YAKAh8qF/cR1vIbvw/Q6oH0ABh5yrC3+Ie
 EmFQ==
X-Gm-Message-State: AOAM5320PJeSx+q9d0+4jdjQpAD5xozOIMuTXS29dsp2O+WjKE5BNtHh
 hHWe8IHzxaHEPECkYQdtpZ+GOg==
X-Google-Smtp-Source: ABdhPJxX7DpYIxzJwPvhQ257/5aMtJTBX2i+msvs9knfpynhetWEVamRCfg6VcZcI9X34AN6AONGbA==
X-Received: by 2002:a05:600c:206:: with SMTP id
 6mr9916787wmi.170.1589391130775; 
 Wed, 13 May 2020 10:32:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u12sm38461466wmu.25.2020.05.13.10.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:32:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 84FF01FF93;
 Wed, 13 May 2020 18:32:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 7/8] tests/tcg: add new threadcount test
Date: Wed, 13 May 2020 18:31:59 +0100
Message-Id: <20200513173200.11830-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513173200.11830-1-alex.bennee@linaro.org>
References: <20200513173200.11830-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nikolay Igotti <igotti@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based on the original testcase by Nikolay Igotti.

Message-ID: <CAEme+7GLKg_dNsHizzTKDymX9HyD+Ph2iZ=WKhOw2XG+zhViXg@mail.gmail.com>
Cc: Nikolay Igotti <igotti@gmail.com>
[Nikolay can we have your signed of by to add the testcase?]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/threadcount.c   | 62 +++++++++++++++++++++++++++++
 tests/tcg/multiarch/Makefile.target |  2 +
 2 files changed, 64 insertions(+)
 create mode 100644 tests/tcg/multiarch/threadcount.c

diff --git a/tests/tcg/multiarch/threadcount.c b/tests/tcg/multiarch/threadcount.c
new file mode 100644
index 00000000000..546dd90eeb2
--- /dev/null
+++ b/tests/tcg/multiarch/threadcount.c
@@ -0,0 +1,62 @@
+/*
+ * Thread Exerciser
+ *
+ * Unlike testthread which is mainly concerned about testing thread
+ * semantics this test is used to exercise the thread creation and
+ * accounting. A version of this test found a problem with clashing
+ * cpu_indexes which caused a break in plugin handling.
+ *
+ * Based on the original test case by Nikolay Igotti.
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <pthread.h>
+
+int max_threads = 10;
+
+typedef struct {
+    int delay;
+} ThreadArg;
+
+static void *thread_fn(void* varg)  {
+    ThreadArg* arg = varg;
+    usleep(arg->delay);
+    free(arg);
+    return NULL;
+}
+
+int main(int argc, char **argv) {
+    int i;
+    pthread_t *threads;
+
+    if (argc > 1) {
+        max_threads = atoi(argv[1]);
+    }
+    threads = calloc(sizeof(pthread_t), max_threads);
+
+    for (i = 0; i < max_threads; i++) {
+        ThreadArg* arg = calloc(sizeof(ThreadArg), 1);
+        arg->delay = i * 100;
+        pthread_create(threads + i, NULL, thread_fn, arg);
+    }
+
+    printf("Created %d threads\n", max_threads);
+
+    /* sleep until roughly half the threads have "finished" */
+    usleep(max_threads * 50);
+
+    for (i = 0; i < max_threads; i++) {
+        pthread_join(threads[i], NULL);
+    }
+
+    printf("Done\n");
+
+    return 0;
+}
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 51fb75ecfdd..cb49cc9ccb2 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -28,6 +28,8 @@ run-float_%: float_%
 
 testthread: LDFLAGS+=-lpthread
 
+threadcount: LDFLAGS+=-lpthread
+
 # We define the runner for test-mmap after the individual
 # architectures have defined their supported pages sizes. If no
 # additional page sizes are defined we only run the default test.
-- 
2.20.1


