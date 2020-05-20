Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529EFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1337B2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcGiZMh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1337B2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPVX-0000Kx-81
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPME-0000LO-5G
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:06:06 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:34020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPMC-00022Q-Pj
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:06:05 -0400
Received: by mail-ej1-x643.google.com with SMTP id j21so3986517ejy.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tVaA6VVKMxT5atPOq3mupoaoOxw2j2mNyFQd2GQU77U=;
 b=FcGiZMh0mR/7XmqKUTy7DPfOsaqDwIbdy4LZrUUlNMvGnlptykNuU61UfgovyZMh0T
 L29g1s2OvORb//bFqpZUsoOPfAUwEdJ9cjzMV6wkZU1UGiSL11YQyZWOWlYSldh+Zjvh
 3bq6NwVHikpdhpg6eKFLWDFrV+wpTKrhz7ENdG4pqg6tPcABUlqlUweRofaobCOXaGnx
 ETOyygfgqABLLwXc3lY7LOsdGvrhKBmO+CXkv87xyjEtcfkOvC4fx5EVUc5poibIA2UQ
 wQuSrlN8s+9jQp8GPDts0HsaipNWuGa8rjB205Gb7s3nUimPrm5zPmjXy8GkIafZ+Orw
 cFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tVaA6VVKMxT5atPOq3mupoaoOxw2j2mNyFQd2GQU77U=;
 b=sOlhn92b6zcXsWv4bbalqVKzvCQlqvg/5Gj3vzycD8MGM1MrzGiBHkqwqEgLZyGG9X
 5bNBsj8ILld9+RZLC0K/tpVlwgJgsdQh8DRwiAQZvk32S94OuraVJjExFXoruvXksTIc
 Wt9rY6xS38ab+usCLlpTRKWDYua8tKOLVdMsagMxavVFC9ECOYYqZqcH8+zRMI2OvldJ
 Vq+iIuXIpuHS1sV9n3bXIhNzNoKuZrXX+P6TCbeQyzldHLky5Ubdj9lyWtvkVh09M//9
 vrswu6+3uj6/Zi5kCqk2r7TaxAwc+p5jZkbE+NTg7UargV77tr/vVLbR9eGS63KErzMw
 VfkQ==
X-Gm-Message-State: AOAM533U5HhiOd/3kk/v6fi5M0eReKwxX64IC2CAMpWRdgNvorsw7jRh
 pEXEUY5EEhgPmM5VxrnCywhwQg==
X-Google-Smtp-Source: ABdhPJz/47npYSYpLNEmFuF0YR0OljuFNxxEIk9xR/zyaqYEO79RuOmsaXnmnB3UgRoROhLqfDC2dw==
X-Received: by 2002:a17:906:780b:: with SMTP id
 u11mr3625508ejm.341.1589983563430; 
 Wed, 20 May 2020 07:06:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id dt12sm2017082ejb.102.2020.05.20.07.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 750B41FF9D;
 Wed, 20 May 2020 15:05:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 14/15] tests/tcg: add new threadcount test
Date: Wed, 20 May 2020 15:05:40 +0100
Message-Id: <20200520140541.30256-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x643.google.com
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
Signed-off-by: Nikolay Igotti <igotti@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add Nikolay's s-o-b
  - checkpatch fixes
---
 tests/tcg/multiarch/threadcount.c   | 64 +++++++++++++++++++++++++++++
 tests/tcg/multiarch/Makefile.target |  2 +
 2 files changed, 66 insertions(+)
 create mode 100644 tests/tcg/multiarch/threadcount.c

diff --git a/tests/tcg/multiarch/threadcount.c b/tests/tcg/multiarch/threadcount.c
new file mode 100644
index 00000000000..545a1c81466
--- /dev/null
+++ b/tests/tcg/multiarch/threadcount.c
@@ -0,0 +1,64 @@
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
+static void *thread_fn(void* varg)
+{
+    ThreadArg *arg = varg;
+    usleep(arg->delay);
+    free(arg);
+    return NULL;
+}
+
+int main(int argc, char **argv)
+{
+    int i;
+    pthread_t *threads;
+
+    if (argc > 1) {
+        max_threads = atoi(argv[1]);
+    }
+    threads = calloc(sizeof(pthread_t), max_threads);
+
+    for (i = 0; i < max_threads; i++) {
+        ThreadArg *arg = calloc(sizeof(ThreadArg), 1);
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


