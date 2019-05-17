Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F9EC04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C172082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGU7oRev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C172082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSzl-00081p-DB
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:53:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmc-0005WJ-Mp
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmb-00027B-0B
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:42 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSma-00026S-Lr
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:40 -0400
Received: by mail-pf1-x444.google.com with SMTP id g9so2857696pfo.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=4MrsM8HWkl5HnptGJNmid/oZc3Q7MB8Exr59LxaGIMY=;
	b=cGU7oRev0s/zz1mO46oi6pyQu7KKEY0tYpiTGOo1MaO24Y1uEAnV+rfgDeyi1GPAsL
	dJQNNn8i+jmPuwdvgggGg/cQdqjb1p5NNtjj4n6dqN7skGXPLJhNGBCDDAeHhrJSyc98
	+pITmixniajrzdOw83mfFNtdXkGsF/E8iYWwK4BVIq+/2ZoBu1yjzStP0NHnzaZ7JPdI
	rvpz6Zm4EaQJ0JCK1r3guMjJPPDKeuvdx9YR2IrG1vGQkU3djQ5p53pq2scFruXNiicB
	pKtoEFDEiqQbDjAI3wIszA2eZMqfb+N1LXlaWuSTRGpTgBnvlQTHwyyxIzyBqD4FfzRo
	SH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4MrsM8HWkl5HnptGJNmid/oZc3Q7MB8Exr59LxaGIMY=;
	b=qgZGCs1+v0FancpZdewNJwbHxsa+sdwAPeZ/eZbQ4q+hNzCdflPGiLHmxe9AqvNuH5
	tqqA1UPF3qFz3XJeavMkPHc5cG6huFHUl+95XO0H6ZjPnGbLyZFb92hUZxpz5bYgfIIY
	Y7YiTWhX3rmVpDLZXbk1yiku182Uzbz1rJv8VLSW7utMEd02gAIbTMtRrxSLn/fj3tuW
	rDYRcUNp+8CRz3Y6Qi8vhruaUqwBbEPMNQRRnYhLku5AFOp2PDgUK1iyr0C+iFv4roau
	RM2Ib5Ognn0cY5RUYZz029nJw/l61xxuML1ts3LlkeMPaJ685k6fXz9REuh59SXrOQXe
	MOkQ==
X-Gm-Message-State: APjAAAUhBiQFNY2VR8yG8JTN+8srvYkgf+svqc9E6IPYTy6RtQVlalVS
	Wt/nde+dfeIkWo3IpvcimeJsrlDXT7E=
X-Google-Smtp-Source: APXvYqwYzmb/JnS/apu9OPzq1FItV1NWFiXz53Cpqy8V/hoAgE+pwKfihEvvmLbyMDRG7/tURTVWYg==
X-Received: by 2002:a63:550c:: with SMTP id j12mr53738475pgb.450.1558060779255;
	Thu, 16 May 2019 19:39:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:09 -0700
Message-Id: <20190517023924.1686-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v8 10/25] util: Add qemu_guest_getrandom and
 associated routines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This routine is intended to produce high-quality random numbers to the
guest.  Normally, such numbers are crypto quality from the host, but a
command-line option can force the use of a fully deterministic sequence
for use while debugging.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/guest-random.h | 68 +++++++++++++++++++++++++++
 util/guest-random.c         | 93 +++++++++++++++++++++++++++++++++++++
 util/Makefile.objs          |  1 +
 3 files changed, 162 insertions(+)
 create mode 100644 include/qemu/guest-random.h
 create mode 100644 util/guest-random.c

diff --git a/include/qemu/guest-random.h b/include/qemu/guest-random.h
new file mode 100644
index 0000000000..09ff9c2236
--- /dev/null
+++ b/include/qemu/guest-random.h
@@ -0,0 +1,68 @@
+/*
+ * QEMU guest-visible random functions
+ *
+ * Copyright 2019 Linaro, Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#ifndef QEMU_GUEST_RANDOM_H
+#define QEMU_GUEST_RANDOM_H
+
+/**
+ * qemu_guest_random_seed_main(const char *optarg, Error **errp)
+ * @optarg: a non-NULL pointer to a C string
+ * @errp: an error indicator
+ *
+ * The @optarg value is that which accompanies the -seed argument.
+ * This forces qemu_guest_getrandom into deterministic mode.
+ *
+ * Returns 0 on success, < 0 on failure while setting *errp.
+ */
+int qemu_guest_random_seed_main(const char *optarg, Error **errp);
+
+/**
+ * qemu_guest_random_seed_thread_part1(void)
+ *
+ * If qemu_getrandom is in deterministic mode, returns an
+ * independent seed for the new thread.  Otherwise returns 0.
+ */
+uint64_t qemu_guest_random_seed_thread_part1(void);
+
+/**
+ * qemu_guest_random_seed_thread_part2(uint64_t seed)
+ * @seed: a value for the new thread.
+ *
+ * If qemu_guest_getrandom is in deterministic mode, this stores an
+ * independent seed for the new thread.  Otherwise a no-op.
+ */
+void qemu_guest_random_seed_thread_part2(uint64_t seed);
+
+/**
+ * qemu_guest_getrandom(void *buf, size_t len, Error **errp)
+ * @buf: a buffer of bytes to be written
+ * @len: the number of bytes in @buf
+ * @errp: an error indicator
+ *
+ * Fills len bytes in buf with random data.  This should only be used
+ * for data presented to the guest.  Host-side crypto services should
+ * use qcrypto_random_bytes.
+ *
+ * Returns 0 on success, < 0 on failure while setting *errp.
+ */
+int qemu_guest_getrandom(void *buf, size_t len, Error **errp);
+
+/**
+ * qemu_guest_getrandom_nofail(void *buf, size_t len)
+ * @buf: a buffer of bytes to be written
+ * @len: the number of bytes in @buf
+ *
+ * Like qemu_guest_getrandom, but will assert for failure.
+ * Use this when there is no reasonable recovery.
+ */
+void qemu_guest_getrandom_nofail(void *buf, size_t len);
+
+#endif /* QEMU_GUEST_RANDOM_H */
diff --git a/util/guest-random.c b/util/guest-random.c
new file mode 100644
index 0000000000..e8124a3cad
--- /dev/null
+++ b/util/guest-random.c
@@ -0,0 +1,93 @@
+/*
+ * QEMU guest-visible random functions
+ *
+ * Copyright 2019 Linaro, Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "qemu/guest-random.h"
+#include "crypto/random.h"
+
+
+static __thread GRand *thread_rand;
+static bool deterministic;
+
+
+static int glib_random_bytes(void *buf, size_t len)
+{
+    GRand *rand = thread_rand;
+    size_t i;
+    uint32_t x;
+
+    if (unlikely(rand == NULL)) {
+        /* Thread not initialized for a cpu, or main w/o -seed.  */
+        thread_rand = rand = g_rand_new();
+    }
+
+    for (i = 0; i + 4 <= len; i += 4) {
+        x = g_rand_int(rand);
+        __builtin_memcpy(buf + i, &x, 4);
+    }
+    if (i < len) {
+        x = g_rand_int(rand);
+        __builtin_memcpy(buf + i, &x, i - len);
+    }
+    return 0;
+}
+
+int qemu_guest_getrandom(void *buf, size_t len, Error **errp)
+{
+    if (unlikely(deterministic)) {
+        /* Deterministic implementation using Glib's Mersenne Twister.  */
+        return glib_random_bytes(buf, len);
+    } else {
+        /* Non-deterministic implementation using crypto routines.  */
+        return qcrypto_random_bytes(buf, len, errp);
+    }
+}
+
+void qemu_guest_getrandom_nofail(void *buf, size_t len)
+{
+    qemu_guest_getrandom(buf, len, &error_fatal);
+}
+
+uint64_t qemu_guest_random_seed_thread_part1(void)
+{
+    if (deterministic) {
+        uint64_t ret;
+        glib_random_bytes(&ret, sizeof(ret));
+        return ret;
+    }
+    return 0;
+}
+
+void qemu_guest_random_seed_thread_part2(uint64_t seed)
+{
+    g_assert(thread_rand == NULL);
+    if (deterministic) {
+        thread_rand =
+            g_rand_new_with_seed_array((const guint32 *)&seed,
+                                       sizeof(seed) / sizeof(guint32));
+    }
+}
+
+int qemu_guest_random_seed_main(const char *optarg, Error **errp)
+{
+    unsigned long long seed;
+    if (parse_uint_full(optarg, &seed, 0)) {
+        error_setg(errp, "Invalid seed number: %s", optarg);
+        return -1;
+    } else {
+        deterministic = true;
+        qemu_guest_random_seed_thread_part2(seed);
+        return 0;
+    }
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 9206878dec..c27a923dbe 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -54,5 +54,6 @@ util-obj-y += iova-tree.o
 util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
 util-obj-$(CONFIG_LINUX) += vfio-helpers.o
 util-obj-$(CONFIG_OPENGL) += drm.o
+util-obj-y += guest-random.o
 
 stub-obj-y += filemonitor-stub.o
-- 
2.17.1


